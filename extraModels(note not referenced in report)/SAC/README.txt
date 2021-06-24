README for SAC Models

Three different SAC-models have been trained, two with the Inclusion of LSTMs and one without.
Please note that v1.1 has not been trained as long as v1.0 with and without LSTMs. 
There might also be hyperparameter differences between the versions not stated explicitly here in the readme. There is also no indication of final layers e.g. softplus, softmax, addition, e.t.c.
The input to each layer is always 9 observations.

v1.0
Critic has the following Neural Network

FC(128)-FC(64)-|
		    -FC(1) 
	  FC(64)-|

with leakyRelu after each LSTM and FC layer.

Actor has the following Neural Network

	  |-FC(64)
FC(128)-
	  |-FC(64)


v1.0 + LSTM
Critic has the following Neural Network

FC(400)-FC(300)-|
		     -LSTM(8)-FC(1) 
	  FC(300)-|

with leakyRelu after each LSTM and FC layer.

Actor has the following Neural Network

		    |-FC(300)
FC(400)-LSTM(8)-
		    |-FC(300)


v1.1 + LSTM
Critic has the following Neural Network

FC(150)-FC(150)-|
		     -LSTM(8)-FC(1) 
	  FC(150)-|

with leakyRelu after each LSTM and FC layer.

Actor has the following Neural Network

				 |-FC(100)
FC(150)-FC(150)-LSTM(8)-
				 |-FC(100)