%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%         Soft-Actor-Critic using LSTMs v1.1               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%          Set up some the environment e.t.c               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mdl = 'intel_motor_control_rl';
%open_system(mdl)  %un-comment this part to open the model in simulink.

% Create observation specifications.
numObservations = 9;
obsInfo = rlNumericSpec([numObservations 1]);
obsInfo.Name = 'observations';
obsInfo.Description = 'Information on error and reference signal';

% Create potential action specs and their options.
numActions = 1;
actInfo = rlNumericSpec([numActions 1]); 
actInfo.Name = 'vqdRef';
actInfo.LowerLimit = -1;
actInfo.UpperLimit = 1;

agentblk = 'intel_motor_control_rl/Controller_equiv_DC_motor1/PI_Ctrl_float_speed/Reinforcement Learning1/RL Agent';
env = rlSimulinkEnv(mdl,agentblk,obsInfo,actInfo);

rng(0); %make it so the rng isn't too random.

%create environment
numObs = obsInfo.Dimension(1);
numAct = numel(actInfo);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the critic's network(s)              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


statePath1 = [
    sequenceInputLayer(numObs,'Normalization','none','Name','observation')
    fullyConnectedLayer(150,'Name','CriticStateFC1')
    leakyReluLayer('Name','CriticStateRelu1')
    fullyConnectedLayer(150,'Name','CriticStateFC2')
    ];
actionPath1 = [
    sequenceInputLayer(numAct,'Normalization','none','Name','action')
    fullyConnectedLayer(150,'Name','CriticActionFC1')
    ];
commonPath1 = [
    additionLayer(2,'Name','add')
    lstmLayer(8,'OutputMode','sequence','Name','lstm')
    leakyReluLayer('Name','CriticCommonRelu1')
    fullyConnectedLayer(1,'Name','CriticOutput')
    ];

criticNet = layerGraph(statePath1);
criticNet = addLayers(criticNet,actionPath1);
criticNet = addLayers(criticNet,commonPath1);
criticNet = connectLayers(criticNet,'CriticStateFC2','add/in1');
criticNet = connectLayers(criticNet,'CriticActionFC1','add/in2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%           Set up the critic and its options              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

criticOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,... 
                                        'GradientThreshold',1,'L2RegularizationFactor',2e-4);
                                    
critic1 = rlQValueRepresentation(criticNet,obsInfo,actInfo,...
    'Observation',{'observation'},'Action',{'action'},criticOptions);
critic2 = rlQValueRepresentation(criticNet,obsInfo,actInfo,...
    'Observation',{'observation'},'Action',{'action'},criticOptions);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the actor's network(s)               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

statePath = [
    sequenceInputLayer(numObs,'Normalization','none','Name','observation')
    fullyConnectedLayer(150, 'Name','commonFC1')
    leakyReluLayer('Name','CommonRelu1')
    fullyConnectedLayer(150, 'Name','commonFC2')
    lstmLayer(8,'OutputMode','sequence','Name','lstm') 
    leakyReluLayer('Name','CommonRelu2')
    ];
    
meanPath = [
    fullyConnectedLayer(100,'Name','MeanFC1')
    leakyReluLayer('Name','MeanRelu')
    fullyConnectedLayer(numAct,'Name','Mean')
    ];
stdPath = [
    fullyConnectedLayer(100,'Name','StdFC1')
    leakyReluLayer('Name','StdRelu')
    fullyConnectedLayer(numAct,'Name','StdFC2')
    softplusLayer('Name','StandardDeviation')];

concatPath = concatenationLayer(1,2,'Name','GaussianParameters');

actorNetwork = layerGraph(statePath);
actorNetwork = addLayers(actorNetwork,meanPath);
actorNetwork = addLayers(actorNetwork,stdPath);
actorNetwork = addLayers(actorNetwork,concatPath);
actorNetwork = connectLayers(actorNetwork,'CommonRelu2','MeanFC1/in');
actorNetwork = connectLayers(actorNetwork,'CommonRelu2','StdFC1/in');
actorNetwork = connectLayers(actorNetwork,'Mean','GaussianParameters/in1');
actorNetwork = connectLayers(actorNetwork,'StandardDeviation','GaussianParameters/in2');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the actor and its options            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,...
                                       'GradientThreshold',1,'L2RegularizationFactor',1e-5);

actor = rlStochasticActorRepresentation(actorNetwork,obsInfo,actInfo,actorOptions,...
    'Observation',{'observation'});



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the RL Agent's options.              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ts = 1/16000;
Ts_agent = Ts;

agentOptions = rlSACAgentOptions();

%Hyperparameters to tune for training.
agentOptions.SampleTime = Ts; %time before sampling signal.
agentOptions.DiscountFactor = 0.99; %discount factor for reward.
agentOptions.TargetSmoothFactor = 0.33; %target smoothing for critic.
agentOptions.ExperienceBufferLength = 3e6; %Past actions to compute randomly over w. miniBatch.
agentOptions.SequenceLength = 10; % Used for RNNs.
agentOptions.MiniBatchSize = 64; % The amount of samples taken from Buffer to compute update for Agent.
agentOptions.TargetUpdateFrequency = 1; % How many steps before updates critics.
agentOptions.NumStepsToLookAhead = 1; % How many future reward values ahead to try and predict.
%agentOptions.NumWarmStartSteps = 512; % how many steps to do before you
%start calculating.

%Entropy Weight Options.
agentOptions.EntropyWeightOptions.TargetEntropy = 0; % Higher value -> more exploration.
agentOptions.EntropyWeightOptions.LearnRate = 1e-3;
%agentOptions.EntropyWeightOptions.EntropyWeight = 1;
agentOptions.EntropyWeightOptions.GradientThreshold = 100;

%Extra Training Options



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Do the rest i.e. set-up & training options         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


agent = rlSACAgent(actor,[critic1 critic2],agentOptions);


T = 0.7;
maxepisodes = 1000;
maxsteps = ceil(T/Ts_agent); 

trainingOpts = rlTrainingOptions(...
    'MaxEpisodes',maxepisodes, ...
    'MaxStepsPerEpisode',maxsteps, ...
    'StopTrainingCriteria','AverageReward',...
    'StopTrainingValue',-190,... 
    'ScoreAveragingWindowLength',3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                    Start of training                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

doTraining = true;

trainingStats = train(agent,env,trainingOpts);