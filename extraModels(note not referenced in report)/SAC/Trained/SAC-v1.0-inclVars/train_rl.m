mdl = 'intel_motor_control_rl';
%open_system(mdl)

% Create observation specifications.
numObservations = 9;
observationInfo = rlNumericSpec([numObservations 1]);
observationInfo.Name = 'observations';
observationInfo.Description = 'Information on error and reference signal';

% Create action specifications.
numActions = 1;
actionInfo = rlNumericSpec([numActions 1]); 
actionInfo.Name = 'vqdRef';
actionInfo.LowerLimit = -1;
actionInfo.UpperLimit = 1;

agentblk = 'intel_motor_control_rl/Controller_equiv_DC_motor1/PI_Ctrl_float_speed/Reinforcement Learning1/RL Agent';
env = rlSimulinkEnv(mdl,agentblk,observationInfo,actionInfo);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%set random seed
rng(0);

%create environment
numObs = observationInfo.Dimension(1);
numAct = numel(actionInfo);

%create critic networks
statePath1 = [
    featureInputLayer(numObs,'Normalization','none','Name','observation')
    fullyConnectedLayer(128,'Name','CriticStateFC1')
    leakyReluLayer('Name','CriticStateRelu1')
    fullyConnectedLayer(64,'Name','CriticStateFC2')
    ];
actionPath1 = [
    featureInputLayer(numAct,'Normalization','none','Name','action')
    fullyConnectedLayer(64,'Name','CriticActionFC1')
    ];
commonPath1 = [
    additionLayer(2,'Name','add')
    leakyReluLayer('Name','CriticCommonRelu1')
    fullyConnectedLayer(1,'Name','CriticOutput')
    ];

criticNet = layerGraph(statePath1);
criticNet = addLayers(criticNet,actionPath1);
criticNet = addLayers(criticNet,commonPath1);
criticNet = connectLayers(criticNet,'CriticStateFC2','add/in1');
criticNet = connectLayers(criticNet,'CriticActionFC1','add/in2');

criticOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,... 
                                        'GradientThreshold',1,'L2RegularizationFactor',2e-4);
                                    
critic1 = rlQValueRepresentation(criticNet,observationInfo,actionInfo,...
    'Observation',{'observation'},'Action',{'action'},criticOptions);
critic2 = rlQValueRepresentation(criticNet,observationInfo,actionInfo,...
    'Observation',{'observation'},'Action',{'action'},criticOptions);

%create actor
statePath = [
    featureInputLayer(numObs,'Normalization','none','Name','observation')
    fullyConnectedLayer(128, 'Name','commonFC1')
    leakyReluLayer('Name','CommonRelu')];
meanPath = [
    fullyConnectedLayer(64,'Name','MeanFC1')
    leakyReluLayer('Name','MeanRelu')
    fullyConnectedLayer(numAct,'Name','Mean')
    ];
stdPath = [
    fullyConnectedLayer(64,'Name','StdFC1')
    leakyReluLayer('Name','StdRelu')
    fullyConnectedLayer(numAct,'Name','StdFC2')
    softplusLayer('Name','StandardDeviation')
    ];

concatPath = concatenationLayer(1,2,'Name','GaussianParameters');

actorNetwork = layerGraph(statePath);
actorNetwork = addLayers(actorNetwork,meanPath);
actorNetwork = addLayers(actorNetwork,stdPath);
actorNetwork = addLayers(actorNetwork,concatPath);
actorNetwork = connectLayers(actorNetwork,'CommonRelu','MeanFC1/in');
actorNetwork = connectLayers(actorNetwork,'CommonRelu','StdFC1/in');
actorNetwork = connectLayers(actorNetwork,'Mean','GaussianParameters/in1');
actorNetwork = connectLayers(actorNetwork,'StandardDeviation','GaussianParameters/in2');

actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,...
                                       'GradientThreshold',1,'L2RegularizationFactor',1e-5);

actor = rlStochasticActorRepresentation(actorNetwork,observationInfo,actionInfo,actorOptions,...
    'Observation',{'observation'});


Ts = 1/16000;
Ts_agent = Ts;
agentOptions = rlSACAgentOptions("NumStepsToLookAhead",1);


%Hyperparameters


%Options used in TD3 Agent
agentOptions.SampleTime = Ts;
agentOptions.DiscountFactor = 0.95;
agentOptions.TargetSmoothFactor = 0.5; %used to be 1e-3
agentOptions.ExperienceBufferLength = 2e6;
agentOptions.TargetUpdateFrequency = 10;
agentOptions.MiniBatchSize = 512;

%Entropy Weight Options
agentOptions.EntropyWeightOptions.LearnRate = 3e-4;
%agentOptions.EntropyWeightOptions.EntropyWeight = 1;
%agentOptions.EntropyWeightOptions.TargetEntropy = -1;

%Training Options
%agentOptions.NumWarmStartSteps = 512;


agent = rlSACAgent(actor,[critic1 critic2],agentOptions);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Start of training

T = 0.7;
maxepisodes = 10;
maxsteps = ceil(T/Ts_agent); 
trainingOpts = rlTrainingOptions(...
    'MaxEpisodes',maxepisodes, ...
    'MaxStepsPerEpisode',maxsteps, ...
    'StopTrainingCriteria','AverageReward',...
    'StopTrainingValue',-190,... 
    'ScoreAveragingWindowLength',3);
doTraining = true;
trainingStats = train(agent,env,trainingOpts);

