README for the PPO_MODELS used for training/testing.

Each PPO_Model here is trained using LSTMs (except one) with different window sizes as well as different sized neural networks.

The version-ing between the different models do NOT reflect a increase in superiority but only a change in things tried and tested based on previous observations.

Version 1.0-1.3 uses the old reward and action-functions. 1.4-1.7 all use the newer version. It will be seen how these perform, but currently the results have been promising.


v1.1
critic's neural network is FC(20)-FC(16)-LSTM(12)-FC(1)
actor's neural network is FC(20)-FC(16)-LSTM(12)-||FC(16)-FC(1)

please note that the last two layers of the actor is split, one for mean and one for 
standard deviation. So after the LSTM(12) it is actually 2 split FC(16)-FC(1). These then
get concatenated into one 2x1 neuron. This same splitting of last two layers is true for all
PPO models.

v1.2
critic's neural network is FC(32)-FC(32)-LSTM(16)-FC(1)
actor's neural network is FC(32)-FC(32)-LSTM(16)-||FC(32)-FC(1)

The learning rate was a bit smaller here as well.

v1.3

critic's neural network is FC(32)-FC(16)-LSTM(12)-FC(1)
actor's neural network is FC(16)-LSTM(12)-||FC(16)-FC(1)

v1.4 (untrained)
Here and in future versions we see the introduction of two new variations of the simulink model.
Changes made were to now use the previous voltage/action and carry it forward. i.e. if current
voltage is 20 and we want to get to 22 the actor will (hopefully) output +2 scaled between [-1,1].
There is also a new reward function which checks if the error has improved and will thus give 
positive reward for that happening. Please note that not all future trainings will use both of 
these new variants. Some might only use the new voltage summation and some might use both the new
reward as well as the new voltage summation.




v1.5 (untrained)

v1.6
critic's neural network is FC(32)-FC(32)-LSTM(10)-FC(1)
actor's neural network is FC(10)-LSTM(12)-||FC(10)-FC(1)

v1.7
critic's neural network is FC(20)-FC(16)-LSTM(10)-FC(1)
actor's neural network is FC(10)-LSTM(12)-||FC(10)-FC(1)
