%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    Proximal-Policy-Optimisation (PPO) + LSTM v1.7        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   In this test we are going to try and use the so-called     %
%   PPO agent to try and train the agent to perform in our     %
%   model. The advantages PPO might have is that it is a so-   %
%   -called 'on-policy' algorithm. This means it should        %
%   behave nicely in a fast-moving environment like this.      %
%   Another key thing is that PPO tends to be less hyper-      %
%   -parameter sensitive. Meaning that there is less work      %
%   on our end. This version also includes the use of RNNs     %
%   i.e. so called LSTMs to be able to capture past data in    %
%   the model as well. In essence, we use it as a form to      %
%   see how past data influences the future state. This is     %
%   more formally known as a 'Partially-Observable-Markov-     %
%   Decision-Process, or POMDP. I.e. we can predict best       %
%   action for the next state since the current state holds    %
%   all the information, except that we cannot observe the     %
%   full/whole state; only a snapshot.                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                          Changelog                       %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   15/06/2021 --
%   Version now uses the sumVoltage_newReward simulink model.
%   The before shrunken Neural Network + LSTMs stay the same.
%   Also made the Critic network a bit smaller. From 2 layers
%   with 32 neurons each to 2 layers with 20 and 16 neurons.
%   Still uses 10 LSTMs.

%   15/06/2021 --
%   Version now once again uses the sumVoltage simulink model
%   but with the old/previous reward function. It also includes
%   a shrunken size for the neural network and LSTM. Now it 
%   uses 10 LSTMS as well as 10 wide 2 deep neural networks.
%   having a total of 229 trainable parameters. The past one used
%   a bit over 440 trainable parameters with 12 LSTMs.

%   15/06/2021 --
%   Version now uses the sumVoltage_newReward simulink model
%   specified in the past changelogs.

%   15/06/2021 --
%   Version now uses the sumVoltage model specified in the past
%   changelogs. 

%   14/06/2021 --
%   Seed which dictates the signal in the simulink model is now
%   random and NOT deterministic.

%   14/06/2021 --
%   Created new variations of the simulink
%   model. Nnow adds cumulative voltage instead of 
%   before when it just had an output of the voltage. i.e. if 
%   we want to change the voltage to now be -30, and previously
%   it was -32, our model will output +2 (scaled between [-1, 1].
%   Implemented as 'sumVoltage' post-fix to simulink model.

%   14/06/2021 --
%   Created new variant of the reward function for simulink model.
%   This one takes into account past errors and if future errors
%   are are less than past ones, then this will count as a 
%   positive error.
%   Implemented as 'newReward' post-fix to simulink model.

%   13/06/2021 --
%   It was read that from a paper by OpenAI where they trained
%   a PPO agent to play DOTA2, that they had used a larger 
%   experienceHorizon as well as a smaller epoch size for 
%   agentOptions. This is now being tried.

%   13/06/2021 --
%   After past success with deeper and wider models (3 deep with
%   32 neurons). It is now being tried to make the model shallow
%   and less wide. Hopefully this will perform quite well.

%   13/06/2021 --
%   Started a changelog to keep track of changes made.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%               Set up the environment etc.                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mdl = 'intel_motor_control_rl_newReward_sumVoltage';

numObservations = 9;
obsInfo = rlNumericSpec([numObservations 1]);
obsInfo.Name = 'observations';
obsInfo.Description = 'Information on error and reference signal';

numActions = 1;
actInfo = rlNumericSpec([numActions 1]); 
actInfo.Name = 'vqdRef';

% constrict the action-space is finite. If not, sometimes the training
% crashes.
actInfo.LowerLimit = -1;
actInfo.UpperLimit = 1;

agentblk = 'intel_motor_control_rl_newReward_sumVoltage/Controller_equiv_DC_motor1/PI_Ctrl_float_speed/Reinforcement Learning1/RL Agent';
env = rlSimulinkEnv(mdl,agentblk,obsInfo,actInfo);

% Make random seed reset.
env.ResetFcn = @(in) setVariable(in,'randSeed',randi([0 1000])); 

% make it so the rng is determenistically random.
rng(0); 

numObs = obsInfo.Dimension(1);
numAct = numel(actInfo);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the critic's network(s)              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% create the network to be used as approximator in the critic
% it must take the observation signal as input and produce a scalar value

criticNet = [
    sequenceInputLayer(numObs,'Normalization','none','Name','myobs')
    fullyConnectedLayer(20, 'Name', 'fc1')
    leakyReluLayer('Name','relu1')
    fullyConnectedLayer(16, 'Name', 'fc2')
    leakyReluLayer('Name','relu2')
    lstmLayer(10,'OutputMode','sequence','Name','lstm')
    fullyConnectedLayer(1,'Name','output')];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%           Set up the critic and its options              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% set some training options for the critic
criticOpts = rlRepresentationOptions;

% Learning rate for the representation.
criticOpts.LearnRate = 1e-3;


% Optimizer for training the network of the representation.
criticOpts.Optimizer = "adam";


% Applicable parameters for the optimizer.
% It differs for adam vs rmsprop vs sgdm etc.
%criticOpts.OptimizerParameters.Momentum = 0.9;
criticOpts.OptimizerParameters.Epsilon = 10e-8;
criticOpts.OptimizerParameters.GradientDecayFactor = 0.9;
criticOpts.OptimizerParameters.SquaredGradientDecayFactor = 0.999;

% Threshold value for the representation gradient.
criticOpts.GradientThreshold = 1;

% Gradient threshold method used to clip gradient values 
% that exceed the gradient threshold.
criticOpts.GradientThresholdMethod = "l2norm";

%criticOpts.GradientThresholdMethod = "global-l2norm"
%criticOpts.GradientThresholdMethod = "absolute-value"

% Factor for L2 regularization (weight decay).
criticOpts.L2RegularizationFactor = 0.0001;

% Computation device used to perform deep neural network operations.
criticOpts.UseDevice = "cpu";
%criticOpts.UseDevice = "gpu";

% create the critic representation from the network
critic = rlValueRepresentation(criticNet,obsInfo,...
    'Observation','myobs', criticOpts);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the actor's network(s)               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% input path layers (2 by 1 input and a 1 by 1 output)
inPath = [ 
    sequenceInputLayer(numObs, 'Normalization','none','Name','state')
    fullyConnectedLayer(10,'Name', 'ip_fc1')  % 16 by 1 output
    leakyReluLayer('Name', 'ip_relu1')             % nonlinearity
    lstmLayer(10,'OutputMode','sequence','Name','lstm') % lstm
    fullyConnectedLayer(1,'Name','ip_out') ];% 1 by 1 output

% path layers for mean value (1 by 1 input and 1 by 1 output)
% using scalingLayer to scale the range
meanPath = [
    fullyConnectedLayer(10,'Name', 'mp_fc1') % 15 by 1 output
    leakyReluLayer('Name', 'mp_relu')             % nonlinearity
    fullyConnectedLayer(1,'Name','mp_fc2');  % 1 by 1 output
    tanhLayer('Name','tanh');                % output range: (-1,1)
    scalingLayer('Name','mp_out','Scale',actInfo.UpperLimit) ];

% path layers for standard deviation (1 by 1 input and output)
% using softplus layer to make it non negative
sdevPath = [
    fullyConnectedLayer(10,'Name', 'vp_fc1') % 15 by 1 output
    leakyReluLayer('Name', 'vp_relu')             % nonlinearity
    fullyConnectedLayer(1,'Name','vp_fc2');  % 1 by 1 output
    softplusLayer('Name', 'vp_out') ];       % output range: (0,+Inf)

% conctatenate two inputs (along dimension #3) to form a single (2 by 1) output layer
outLayer = concatenationLayer(1,2,'Name','mean&sdev');

% add layers to layerGraph network object
actorNet = layerGraph(inPath);
actorNet = addLayers(actorNet,meanPath);
actorNet = addLayers(actorNet,sdevPath);
actorNet = addLayers(actorNet,outLayer);

% connect layers: the mean value path output MUST be connected to the FIRST input of the concatenation layer
actorNet = connectLayers(actorNet,'ip_out','mp_fc1/in');   % connect output of inPath to meanPath input
actorNet = connectLayers(actorNet,'ip_out','vp_fc1/in');   % connect output of inPath to sdevPath input
actorNet = connectLayers(actorNet,'mp_out','mean&sdev/in1');% connect output of meanPath to mean&sdev input #1
actorNet = connectLayers(actorNet,'vp_out','mean&sdev/in2');% connect output of sdevPath to mean&sdev input #2

% plot network 
 plot(actorNet)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the actor and its options            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% set some training options for the critic
actorOpts = rlRepresentationOptions;

% Learning rate for the representation.
actorOpts.LearnRate = 1e-3;

% Optimizer for training the network of the representation.
actorOpts.Optimizer = "adam";

% Applicable parameters for the optimizer.
% It differs for adam vs rmsprop vs sgdm etc.
%actorOpts.OptimizerParameters.Momentum = 0.9;
actorOpts.OptimizerParameters.Epsilon = 10e-8;
actorOpts.OptimizerParameters.GradientDecayFactor = 0.9;
actorOpts.OptimizerParameters.SquaredGradientDecayFactor = 0.999;

% Threshold value for the representation gradient.
actorOpts.GradientThreshold = 1;

% Gradient threshold method used to clip gradient values 
% that exceed the gradient threshold.
actorOpts.GradientThresholdMethod = "l2norm";

%actorOpts.GradientThresholdMethod = "global-l2norm"
%actorOpts.GradientThresholdMethod = "absolute-value"

% Factor for L2 regularization (weight decay).
actorOpts.L2RegularizationFactor = 0.0001;

% Computation device used to perform deep neural network operations.
actorOpts.UseDevice = "cpu";
%actorOpts.UseDevice = "gpu";

% create the actor using the network
actor = rlStochasticActorRepresentation(actorNet,obsInfo,actInfo,...
    'Observation',{'state'},actorOpts);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%              Set up the RL Agent's options.              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Ts = 1/16000;
Ts_agent = Ts;

agentOpts = rlPPOAgentOptions;

% Agent training hyperparameters.

% Number of steps the agent interacts with the environment before learning 
% from its experience,  specified as a positive integer.
% The ExperienceHorizon value must be greater than or equal to the MiniBatchSize value.
agentOpts.ExperienceHorizon = 4096;

% Clip factor for limiting the change in each policy update step, 
% specified as a positive scalar less than 1.
agentOpts.ClipFactor = 0.2;

% Entropy loss weight, specified as a scalar value between 0 and 1. 
% A higher loss weight value promotes agent exploration by applying a penalty
% for being too certain about which action to take. 
% Doing so can help the agent move out of local optima.
agentOpts.EntropyLossWeight = 0.01;

% Mini-batch size used for each learning epoch, specified as a positive integer.
% When the agent uses a recurrent neural network, 
% MiniBatchSize is treated as the training trajectory length.
agentOpts.MiniBatchSize = 128;

% Number of epochs for which the actor and critic networks learn from the
% current experience set, specified as a positive integer.
agentOpts.NumEpoch = 2;

% Method for estimating advantage values.
agentOpts.AdvantageEstimateMethod = "gae";
%agentOpts.AdvantageEstimateMethod = "finite-horizon"

% Smoothing factor for GAE, specified as a scalar value between 0 and 1.
% Only use when using "gae".
agentOpts.GAEFactor = 0.95;

% Option to return the action with maximum likelihood for simulation and
% policy generation.
agentOpts.UseDeterministicExploitation = false;

% Sample time of agent, specified as a positive scalar.
agentOpts.SampleTime = Ts;

% Discount factor applied to future rewards during training.
agentOpts.DiscountFactor = 0.95;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%       Do the rest i.e. set-up & training options         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


agent = rlPPOAgent(actor,critic,agentOpts);


%%% How to start training or testing using past saved weights %%%

% 1. comment out the previous 'agent = rlPPOAgent(...)'.
% 2. 'clear' previous variables unless you are NOT loading from
%    a file. In which case skip this, step 3, and step 4.
% 3. do 'load("name_of_file");.
% 4. If saved_agent shows up as variable, set 'agent = saved_agent'.
%    Otherwise continue as normal.
% 5a. Call 'train(...)' or just run the whole script if training.
% 5b. Run the simulink model if testing.


T = 0.7;
maxepisodes = 5000;
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