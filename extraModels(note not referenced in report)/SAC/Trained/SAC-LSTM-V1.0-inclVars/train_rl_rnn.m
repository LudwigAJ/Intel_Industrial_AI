
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%         Soft-Actor-Critic using LSTMs 	                   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%          Set up some the environment e.t.c               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mdl = 'intel_motor_control_rl';
%open_system(mdl)

% Create observation specifications.
numObservations = 9;
obsInfo = rlNumericSpec([numObservations 1]);
obsInfo.Name = 'observations';
obsInfo.Description = 'Information on error and reference signal';

% Create action specifications.
numActions = 1;
actInfo = rlNumericSpec([numActions 1]); 
actInfo.Name = 'vqdRef';
%actInfo.LowerLimit = -1;
%actInfo.UpperLimit = 1;

agentblk = 'intel_motor_control_rl/Controller_equiv_DC_motor1/PI_Ctrl_float_speed/Reinforcement Learning1/RL Agent';
env = rlSimulinkEnv(mdl,agentblk,obsInfo,actInfo);


rng(0);

%create environment
numObs = obsInfo.Dimension(1);
numAct = numel(actInfo);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the critic and its NNs               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


statePath1 = [
    sequenceInputLayer(numObs,'Normalization','none','Name','observation')
    fullyConnectedLayer(400,'Name','CriticStateFC1')
    leakyReluLayer('Name','CriticStateRelu1')
    fullyConnectedLayer(300,'Name','CriticStateFC2')
    ];
actionPath1 = [
    sequenceInputLayer(numAct,'Normalization','none','Name','action')
    fullyConnectedLayer(300,'Name','CriticActionFC1')
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
%%%              Set up the critic's options                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

criticOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,... 
                                        'GradientThreshold',1,'L2RegularizationFactor',2e-4);
                                    
critic1 = rlQValueRepresentation(criticNet,obsInfo,actInfo,...
    'Observation',{'observation'},'Action',{'action'},criticOptions);
critic2 = rlQValueRepresentation(criticNet,obsInfo,actInfo,...
    'Observation',{'observation'},'Action',{'action'},criticOptions);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the actor and its NNs                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

statePath = [
    sequenceInputLayer(numObs,'Normalization','none','Name','observation')
    fullyConnectedLayer(400, 'Name','commonFC1')
    lstmLayer(8,'OutputMode','sequence','Name','lstm')    
    leakyReluLayer('Name','CommonRelu')];
meanPath = [
    fullyConnectedLayer(300,'Name','MeanFC1')
    leakyReluLayer('Name','MeanRelu')
    fullyConnectedLayer(numAct,'Name','Mean')
    ];
stdPath = [
    fullyConnectedLayer(300,'Name','StdFC1')
    leakyReluLayer('Name','StdRelu')
    fullyConnectedLayer(numAct,'Name','StdFC2')
    softplusLayer('Name','StandardDeviation')];

concatPath = concatenationLayer(1,2,'Name','GaussianParameters');

actorNetwork = layerGraph(statePath);
actorNetwork = addLayers(actorNetwork,meanPath);
actorNetwork = addLayers(actorNetwork,stdPath);
actorNetwork = addLayers(actorNetwork,concatPath);
actorNetwork = connectLayers(actorNetwork,'CommonRelu','MeanFC1/in');
actorNetwork = connectLayers(actorNetwork,'CommonRelu','StdFC1/in');
actorNetwork = connectLayers(actorNetwork,'Mean','GaussianParameters/in1');
actorNetwork = connectLayers(actorNetwork,'StandardDeviation','GaussianParameters/in2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the actor's options                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,...
                                       'GradientThreshold',1,'L2RegularizationFactor',1e-5);

actor = rlStochasticActorRepresentation(actorNetwork,obsInfo,actInfo,actorOptions,...
    'Observation',{'observation'});



Ts = 1/16000;
Ts_agent = Ts;

agentOptions = rlSACAgentOptions("NumStepsToLookAhead",1);

%Hyperparameters
agentOptions.SampleTime = Ts;
agentOptions.DiscountFactor = 0.95;
agentOptions.TargetSmoothFactor = 1e-3; %used to be 1e-3
agentOptions.ExperienceBufferLength = 2e6; %%
agentOptions.SequenceLength = 64; %%
agentOptions.MiniBatchSize = 64; %%

agentOptions.TargetUpdateFrequency = 10; %%

%Entropy Weight Options
agentOptions.EntropyWeightOptions.LearnRate = 1e-3;
%agentOptions.EntropyWeightOptions.EntropyWeight = 1;
%agentOptions.EntropyWeightOptions.TargetEntropy = -1;

%Training Options
%agentOptions.NumWarmStartSteps = 512;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Do the rest i.e. set-up                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


agent = rlSACAgent(actor,[critic1 critic2],agentOptions);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                    Start of training                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


T = 0.7;
maxepisodes = 1000;
maxsteps = ceil(T/Ts_agent); 

trainingOpts = rlTrainingOptions(...
    'MaxEpisodes',maxepisodes, ...
    'MaxStepsPerEpisode',maxsteps, ...
    'StopTrainingCriteria','AverageReward',...
    'StopTrainingValue',-190,... 
    'ScoreAveragingWindowLength',3);

doTraining = true;

trainingStats = train(agent,env,trainingOpts);



