function RTW_Sid2UrlHash() {
	this.urlHashMap = new Array();
	/* <S13>/bias 1 */
	this.urlHashMap["ControllerTestbench:1279:32"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:32";
	/* <S13>/bias 2 */
	this.urlHashMap["ControllerTestbench:1279:33"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:33";
	/* <S13>/bias 3 */
	this.urlHashMap["ControllerTestbench:1279:35"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:35";
	/* <S13>/weights 1 */
	this.urlHashMap["ControllerTestbench:1279:30"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:30";
	/* <S13>/weights 2 */
	this.urlHashMap["ControllerTestbench:1279:31"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:31";
	/* <S13>/weights 3 */
	this.urlHashMap["ControllerTestbench:1279:34"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:34";
	/* <S18>/Add */
	this.urlHashMap["ControllerTestbench:1279:1271"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:1271";
	/* <S18>/Product */
	this.urlHashMap["ControllerTestbench:1279:1273"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:1273";
	/* <S18>/Product2 */
	this.urlHashMap["ControllerTestbench:1279:1274"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:1274";
	/* <S19>/Add */
	this.urlHashMap["ControllerTestbench:1279:25"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:25";
	/* <S19>/Product */
	this.urlHashMap["ControllerTestbench:1279:27"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:27";
	/* <S19>/Product2 */
	this.urlHashMap["ControllerTestbench:1279:28"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:28";
	/* <S20>/Add1 */
	this.urlHashMap["ControllerTestbench:1279:6"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:6";
	/* <S20>/Data Type Conversion1 */
	this.urlHashMap["ControllerTestbench:1279:1278"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:1278";
	/* <S20>/Data Type Conversion2 */
	this.urlHashMap["ControllerTestbench:1279:1280"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:1280";
	/* <S20>/Product1 */
	this.urlHashMap["ControllerTestbench:1279:8"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:8";
	/* <S20>/Tanh */
	this.urlHashMap["ControllerTestbench:1279:10"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:10";
	/* <S21>/Compare */
	this.urlHashMap["ControllerTestbench:1279:1272:2"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:1272:2";
	/* <S21>/Constant */
	this.urlHashMap["ControllerTestbench:1279:1272:3"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:1272:3";
	/* <S22>/Compare */
	this.urlHashMap["ControllerTestbench:1279:26:2"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:26:2";
	/* <S22>/Constant */
	this.urlHashMap["ControllerTestbench:1279:26:3"] = "msg=rtwMsg_notTraceable&block=ControllerTestbench:1279:26:3";
	this.getUrlHash = function(sid) { return this.urlHashMap[sid];}
}
RTW_Sid2UrlHash.instance = new RTW_Sid2UrlHash();
function RTW_rtwnameSIDMap() {
	this.rtwnameHashMap = new Array();
	this.sidHashMap = new Array();
	this.rtwnameHashMap["<Root>"] = {sid: "ControllerTestbench"};
	this.sidHashMap["ControllerTestbench"] = {rtwname: "<Root>"};
	this.rtwnameHashMap["<S13>/Observations"] = {sid: "ControllerTestbench:1279:1"};
	this.sidHashMap["ControllerTestbench:1279:1"] = {rtwname: "<S13>/Observations"};
	this.rtwnameHashMap["<S13>/Hidden Layer (2 Neurons)"] = {sid: "ControllerTestbench:1279:12"};
	this.sidHashMap["ControllerTestbench:1279:12"] = {rtwname: "<S13>/Hidden Layer (2 Neurons)"};
	this.rtwnameHashMap["<S13>/Input Layer (4 Neurons)"] = {sid: "ControllerTestbench:1279:21"};
	this.sidHashMap["ControllerTestbench:1279:21"] = {rtwname: "<S13>/Input Layer (4 Neurons)"};
	this.rtwnameHashMap["<S13>/Output Layer (1 Neuron)"] = {sid: "ControllerTestbench:1279:2"};
	this.sidHashMap["ControllerTestbench:1279:2"] = {rtwname: "<S13>/Output Layer (1 Neuron)"};
	this.rtwnameHashMap["<S13>/bias 1"] = {sid: "ControllerTestbench:1279:32"};
	this.sidHashMap["ControllerTestbench:1279:32"] = {rtwname: "<S13>/bias 1"};
	this.rtwnameHashMap["<S13>/bias 2"] = {sid: "ControllerTestbench:1279:33"};
	this.sidHashMap["ControllerTestbench:1279:33"] = {rtwname: "<S13>/bias 2"};
	this.rtwnameHashMap["<S13>/bias 3"] = {sid: "ControllerTestbench:1279:35"};
	this.sidHashMap["ControllerTestbench:1279:35"] = {rtwname: "<S13>/bias 3"};
	this.rtwnameHashMap["<S13>/weights 1"] = {sid: "ControllerTestbench:1279:30"};
	this.sidHashMap["ControllerTestbench:1279:30"] = {rtwname: "<S13>/weights 1"};
	this.rtwnameHashMap["<S13>/weights 2"] = {sid: "ControllerTestbench:1279:31"};
	this.sidHashMap["ControllerTestbench:1279:31"] = {rtwname: "<S13>/weights 2"};
	this.rtwnameHashMap["<S13>/weights 3"] = {sid: "ControllerTestbench:1279:34"};
	this.sidHashMap["ControllerTestbench:1279:34"] = {rtwname: "<S13>/weights 3"};
	this.rtwnameHashMap["<S13>/Action"] = {sid: "ControllerTestbench:1279:36"};
	this.sidHashMap["ControllerTestbench:1279:36"] = {rtwname: "<S13>/Action"};
	this.rtwnameHashMap["<S18>/layer input"] = {sid: "ControllerTestbench:1279:1268"};
	this.sidHashMap["ControllerTestbench:1279:1268"] = {rtwname: "<S18>/layer input"};
	this.rtwnameHashMap["<S18>/weights matrix"] = {sid: "ControllerTestbench:1279:1269"};
	this.sidHashMap["ControllerTestbench:1279:1269"] = {rtwname: "<S18>/weights matrix"};
	this.rtwnameHashMap["<S18>/bias vector"] = {sid: "ControllerTestbench:1279:1270"};
	this.sidHashMap["ControllerTestbench:1279:1270"] = {rtwname: "<S18>/bias vector"};
	this.rtwnameHashMap["<S18>/Add"] = {sid: "ControllerTestbench:1279:1271"};
	this.sidHashMap["ControllerTestbench:1279:1271"] = {rtwname: "<S18>/Add"};
	this.rtwnameHashMap["<S18>/Compare To Constant"] = {sid: "ControllerTestbench:1279:1272"};
	this.sidHashMap["ControllerTestbench:1279:1272"] = {rtwname: "<S18>/Compare To Constant"};
	this.rtwnameHashMap["<S18>/Product"] = {sid: "ControllerTestbench:1279:1273"};
	this.sidHashMap["ControllerTestbench:1279:1273"] = {rtwname: "<S18>/Product"};
	this.rtwnameHashMap["<S18>/Product2"] = {sid: "ControllerTestbench:1279:1274"};
	this.sidHashMap["ControllerTestbench:1279:1274"] = {rtwname: "<S18>/Product2"};
	this.rtwnameHashMap["<S18>/layer output"] = {sid: "ControllerTestbench:1279:1275"};
	this.sidHashMap["ControllerTestbench:1279:1275"] = {rtwname: "<S18>/layer output"};
	this.rtwnameHashMap["<S19>/layer input"] = {sid: "ControllerTestbench:1279:22"};
	this.sidHashMap["ControllerTestbench:1279:22"] = {rtwname: "<S19>/layer input"};
	this.rtwnameHashMap["<S19>/weights matrix"] = {sid: "ControllerTestbench:1279:23"};
	this.sidHashMap["ControllerTestbench:1279:23"] = {rtwname: "<S19>/weights matrix"};
	this.rtwnameHashMap["<S19>/bias vector"] = {sid: "ControllerTestbench:1279:24"};
	this.sidHashMap["ControllerTestbench:1279:24"] = {rtwname: "<S19>/bias vector"};
	this.rtwnameHashMap["<S19>/Add"] = {sid: "ControllerTestbench:1279:25"};
	this.sidHashMap["ControllerTestbench:1279:25"] = {rtwname: "<S19>/Add"};
	this.rtwnameHashMap["<S19>/Compare To Constant"] = {sid: "ControllerTestbench:1279:26"};
	this.sidHashMap["ControllerTestbench:1279:26"] = {rtwname: "<S19>/Compare To Constant"};
	this.rtwnameHashMap["<S19>/Product"] = {sid: "ControllerTestbench:1279:27"};
	this.sidHashMap["ControllerTestbench:1279:27"] = {rtwname: "<S19>/Product"};
	this.rtwnameHashMap["<S19>/Product2"] = {sid: "ControllerTestbench:1279:28"};
	this.sidHashMap["ControllerTestbench:1279:28"] = {rtwname: "<S19>/Product2"};
	this.rtwnameHashMap["<S19>/layer output"] = {sid: "ControllerTestbench:1279:29"};
	this.sidHashMap["ControllerTestbench:1279:29"] = {rtwname: "<S19>/layer output"};
	this.rtwnameHashMap["<S20>/layer input"] = {sid: "ControllerTestbench:1279:3"};
	this.sidHashMap["ControllerTestbench:1279:3"] = {rtwname: "<S20>/layer input"};
	this.rtwnameHashMap["<S20>/weights matrix1"] = {sid: "ControllerTestbench:1279:4"};
	this.sidHashMap["ControllerTestbench:1279:4"] = {rtwname: "<S20>/weights matrix1"};
	this.rtwnameHashMap["<S20>/bias vector1"] = {sid: "ControllerTestbench:1279:5"};
	this.sidHashMap["ControllerTestbench:1279:5"] = {rtwname: "<S20>/bias vector1"};
	this.rtwnameHashMap["<S20>/Add1"] = {sid: "ControllerTestbench:1279:6"};
	this.sidHashMap["ControllerTestbench:1279:6"] = {rtwname: "<S20>/Add1"};
	this.rtwnameHashMap["<S20>/Data Type Conversion1"] = {sid: "ControllerTestbench:1279:1278"};
	this.sidHashMap["ControllerTestbench:1279:1278"] = {rtwname: "<S20>/Data Type Conversion1"};
	this.rtwnameHashMap["<S20>/Data Type Conversion2"] = {sid: "ControllerTestbench:1279:1280"};
	this.sidHashMap["ControllerTestbench:1279:1280"] = {rtwname: "<S20>/Data Type Conversion2"};
	this.rtwnameHashMap["<S20>/Product1"] = {sid: "ControllerTestbench:1279:8"};
	this.sidHashMap["ControllerTestbench:1279:8"] = {rtwname: "<S20>/Product1"};
	this.rtwnameHashMap["<S20>/Tanh"] = {sid: "ControllerTestbench:1279:10"};
	this.sidHashMap["ControllerTestbench:1279:10"] = {rtwname: "<S20>/Tanh"};
	this.rtwnameHashMap["<S20>/layer output"] = {sid: "ControllerTestbench:1279:11"};
	this.sidHashMap["ControllerTestbench:1279:11"] = {rtwname: "<S20>/layer output"};
	this.rtwnameHashMap["<S21>/u"] = {sid: "ControllerTestbench:1279:1272:1"};
	this.sidHashMap["ControllerTestbench:1279:1272:1"] = {rtwname: "<S21>/u"};
	this.rtwnameHashMap["<S21>/Compare"] = {sid: "ControllerTestbench:1279:1272:2"};
	this.sidHashMap["ControllerTestbench:1279:1272:2"] = {rtwname: "<S21>/Compare"};
	this.rtwnameHashMap["<S21>/Constant"] = {sid: "ControllerTestbench:1279:1272:3"};
	this.sidHashMap["ControllerTestbench:1279:1272:3"] = {rtwname: "<S21>/Constant"};
	this.rtwnameHashMap["<S21>/y"] = {sid: "ControllerTestbench:1279:1272:4"};
	this.sidHashMap["ControllerTestbench:1279:1272:4"] = {rtwname: "<S21>/y"};
	this.rtwnameHashMap["<S22>/u"] = {sid: "ControllerTestbench:1279:26:1"};
	this.sidHashMap["ControllerTestbench:1279:26:1"] = {rtwname: "<S22>/u"};
	this.rtwnameHashMap["<S22>/Compare"] = {sid: "ControllerTestbench:1279:26:2"};
	this.sidHashMap["ControllerTestbench:1279:26:2"] = {rtwname: "<S22>/Compare"};
	this.rtwnameHashMap["<S22>/Constant"] = {sid: "ControllerTestbench:1279:26:3"};
	this.sidHashMap["ControllerTestbench:1279:26:3"] = {rtwname: "<S22>/Constant"};
	this.rtwnameHashMap["<S22>/y"] = {sid: "ControllerTestbench:1279:26:4"};
	this.sidHashMap["ControllerTestbench:1279:26:4"] = {rtwname: "<S22>/y"};
	this.getSID = function(rtwname) { return this.rtwnameHashMap[rtwname];}
	this.getRtwname = function(sid) { return this.sidHashMap[sid];}
}
RTW_rtwnameSIDMap.instance = new RTW_rtwnameSIDMap();
