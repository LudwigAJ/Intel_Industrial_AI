// -------------------------------------------------------------
// 
// File Name: /Users/ciaran/Documents/MATLAB/Yr3 Intel/stableTD3/hdlsrc/ControllerTestbench/ControllerTestbench/nfp_convert_single_to_sfix_18_En16.v
// Created: 2021-06-15 22:29:09
// 
// Generated by MATLAB 9.9 and HDL Coder 3.17
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: nfp_convert_single_to_sfix_18_En16
// Source Path: ControllerTestbench/Controller_equiv_DC_motor1/PI_Ctrl_float_speed/Reinforcement Learning1/Subsystem 
// Reference2/Output Layer (1 Neuron)/nfp_convert_single_to_sfix_18_En1
// Hierarchy Level: 2
// 
// {Latency Strategy = "Max"}
// 
// {Rounding Mode = Nearest}
// {Overflow Mode = Wrap}
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module nfp_convert_single_to_sfix_18_En16
          (clk,
           reset,
           enb,
           nfp_in,
           nfp_out);


  input   clk;
  input   reset;
  input   enb;
  input   [31:0] nfp_in;  // ufix32
  output  signed [17:0] nfp_out;  // sfix18_En16


  wire In1;  // ufix1
  wire [7:0] In2;  // ufix8
  wire [22:0] In3;  // ufix23
  reg  [0:4] Delay10_reg;  // ufix1 [5]
  wire [0:4] Delay10_reg_next;  // ufix1 [5]
  wire Delay10_out1;
  reg [7:0] Delay3_out1;  // uint8
  wire Compare_To_Zero1_out1;
  wire [7:0] Constant3_out1;  // uint8
  wire [7:0] Constant2_out1;  // uint8
  wire [7:0] Switch2_out1;  // uint8
  wire signed [8:0] Add_1;  // sfix9
  wire signed [8:0] Add_2;  // sfix9
  wire signed [8:0] alphave;  // sfix9
  reg signed [8:0] Delay1_reg [0:1];  // sfix9 [2]
  wire signed [8:0] Delay1_reg_next [0:1];  // sfix9 [2]
  wire signed [8:0] Delay1_out1;  // sfix9
  wire equality;
  reg  Delay5_out1;
  wire Compare_To_Zero_out1;
  reg [22:0] Delay4_out1;  // ufix23
  wire [23:0] Bit_Concat_out1;  // ufix24
  wire [23:0] Data_Type_Conversion1_out1;  // ufix24_En23
  reg [23:0] Delay2_reg [0:1];  // ufix24 [2]
  wire [23:0] Delay2_reg_next [0:1];  // ufix24_En23 [2]
  wire [23:0] Delay2_out1;  // ufix24_En23
  wire signed [9:0] Unary_Minus_in0;  // sfix10
  wire signed [9:0] Unary_Minus_1;  // sfix10
  wire signed [8:0] alphave_1;  // sfix9
  wire signed [8:0] shift_arithmetic1_zerosig;  // sfix9
  wire signed [8:0] shift_arithmetic1_selsig;  // sfix9
  wire [25:0] Data_Type_Conversion_out1;  // ufix26_En24
  wire signed [8:0] dynamic_shift_zerosig;  // sfix9
  wire signed [8:0] dynamic_shift_selsig;  // sfix9
  wire signed [15:0] dynamic_shift_cast;  // int16
  wire [25:0] Shift_Arithmetic1_out1;  // ufix26_En24
  reg [25:0] Delay4_out1_1;  // ufix26_En24
  wire signed [8:0] shift_arithmetic2_zerosig;  // sfix9
  wire signed [8:0] shift_arithmetic2_selsig;  // sfix9
  wire [25:0] Data_Type_Conversion1_out1_1;  // ufix26_En24
  wire signed [8:0] dynamic_shift_zerosig_1;  // sfix9
  wire signed [8:0] dynamic_shift_selsig_1;  // sfix9
  wire signed [15:0] dynamic_shift_cast_1;  // int16
  wire [25:0] Shift_Arithmetic2_out1;  // ufix26_En24
  reg [25:0] Delay6_out1;  // ufix26_En24
  wire [25:0] Switch1_out1;  // ufix26_En24
  reg [25:0] Delay9_out1;  // ufix26_En24
  wire signed [26:0] Data_Type_Conversion1_out1_2;  // sfix27_En24
  wire signed [27:0] Unary_Minus_cast;  // sfix28_En24
  wire signed [27:0] Unary_Minus_cast_1;  // sfix28_En24
  wire signed [26:0] Unary_Minus_out1;  // sfix27_En24
  wire signed [26:0] Switch1_out1_1;  // sfix27_En24
  wire signed [17:0] Data_Type_Conversion2_out1;  // sfix18_En16
  reg signed [17:0] Delay8_out1;  // sfix18_En16


  // Split 32 bit word into FP sign, exponent, mantissa
  assign In1 = nfp_in[31];
  assign In2 = nfp_in[30:23];
  assign In3 = nfp_in[22:0];



  always @(posedge clk or posedge reset)
    begin : Delay10_process
      if (reset == 1'b1) begin
        Delay10_reg[0] <= 1'b0;
        Delay10_reg[1] <= 1'b0;
        Delay10_reg[2] <= 1'b0;
        Delay10_reg[3] <= 1'b0;
        Delay10_reg[4] <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay10_reg[0] <= Delay10_reg_next[0];
          Delay10_reg[1] <= Delay10_reg_next[1];
          Delay10_reg[2] <= Delay10_reg_next[2];
          Delay10_reg[3] <= Delay10_reg_next[3];
          Delay10_reg[4] <= Delay10_reg_next[4];
        end
      end
    end

  assign Delay10_out1 = Delay10_reg[4];
  assign Delay10_reg_next[0] = In1;
  assign Delay10_reg_next[1] = Delay10_reg[0];
  assign Delay10_reg_next[2] = Delay10_reg[1];
  assign Delay10_reg_next[3] = Delay10_reg[2];
  assign Delay10_reg_next[4] = Delay10_reg[3];



  always @(posedge clk or posedge reset)
    begin : Delay3_process
      if (reset == 1'b1) begin
        Delay3_out1 <= 8'b00000000;
      end
      else begin
        if (enb) begin
          Delay3_out1 <= In2;
        end
      end
    end



  assign Compare_To_Zero1_out1 = Delay3_out1 != 8'b00000000;



  assign Constant3_out1 = 8'b01111110;



  assign Constant2_out1 = 8'b01111111;



  assign Switch2_out1 = (Compare_To_Zero1_out1 == 1'b0 ? Constant3_out1 :
              Constant2_out1);



  assign Add_1 = {1'b0, Delay3_out1};
  assign Add_2 = {1'b0, Switch2_out1};
  assign alphave = Add_1 - Add_2;



  always @(posedge clk or posedge reset)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_reg[0] <= 9'sb000000000;
        Delay1_reg[1] <= 9'sb000000000;
      end
      else begin
        if (enb) begin
          Delay1_reg[0] <= Delay1_reg_next[0];
          Delay1_reg[1] <= Delay1_reg_next[1];
        end
      end
    end

  assign Delay1_out1 = Delay1_reg[1];
  assign Delay1_reg_next[0] = alphave;
  assign Delay1_reg_next[1] = Delay1_reg[0];



  assign equality = Delay1_out1 >= 9'sb000000000;



  always @(posedge clk or posedge reset)
    begin : Delay5_process
      if (reset == 1'b1) begin
        Delay5_out1 <= 1'b0;
      end
      else begin
        if (enb) begin
          Delay5_out1 <= equality;
        end
      end
    end



  assign Compare_To_Zero_out1 = Delay3_out1 != 8'b00000000;



  always @(posedge clk or posedge reset)
    begin : Delay4_process
      if (reset == 1'b1) begin
        Delay4_out1 <= 23'b00000000000000000000000;
      end
      else begin
        if (enb) begin
          Delay4_out1 <= In3;
        end
      end
    end



  assign Bit_Concat_out1 = {Compare_To_Zero_out1, Delay4_out1};



  assign Data_Type_Conversion1_out1 = Bit_Concat_out1;



  always @(posedge clk or posedge reset)
    begin : Delay2_process
      if (reset == 1'b1) begin
        Delay2_reg[0] <= 24'b000000000000000000000000;
        Delay2_reg[1] <= 24'b000000000000000000000000;
      end
      else begin
        if (enb) begin
          Delay2_reg[0] <= Delay2_reg_next[0];
          Delay2_reg[1] <= Delay2_reg_next[1];
        end
      end
    end

  assign Delay2_out1 = Delay2_reg[1];
  assign Delay2_reg_next[0] = Data_Type_Conversion1_out1;
  assign Delay2_reg_next[1] = Delay2_reg[0];



  assign Unary_Minus_1 = {Delay1_out1[8], Delay1_out1};
  assign Unary_Minus_in0 =  - (Unary_Minus_1);
  assign alphave_1 = Unary_Minus_in0[8:0];



  assign shift_arithmetic1_zerosig = 9'sb000000000;



  assign shift_arithmetic1_selsig = (alphave_1 >= shift_arithmetic1_zerosig ? alphave_1 :
              shift_arithmetic1_zerosig);



  assign Data_Type_Conversion_out1 = {1'b0, {Delay2_out1, 1'b0}};



  assign dynamic_shift_zerosig = 9'sb000000000;



  assign dynamic_shift_selsig = (shift_arithmetic1_selsig >= dynamic_shift_zerosig ? shift_arithmetic1_selsig :
              dynamic_shift_zerosig);



  assign dynamic_shift_cast = {{7{dynamic_shift_selsig[8]}}, dynamic_shift_selsig};
  assign Shift_Arithmetic1_out1 = Data_Type_Conversion_out1 >>> dynamic_shift_cast;



  always @(posedge clk or posedge reset)
    begin : Delay4_1_process
      if (reset == 1'b1) begin
        Delay4_out1_1 <= 26'b00000000000000000000000000;
      end
      else begin
        if (enb) begin
          Delay4_out1_1 <= Shift_Arithmetic1_out1;
        end
      end
    end



  assign shift_arithmetic2_zerosig = 9'sb000000000;



  assign shift_arithmetic2_selsig = (Delay1_out1 >= shift_arithmetic2_zerosig ? Delay1_out1 :
              shift_arithmetic2_zerosig);



  assign Data_Type_Conversion1_out1_1 = {1'b0, {Delay2_out1, 1'b0}};



  assign dynamic_shift_zerosig_1 = 9'sb000000000;



  assign dynamic_shift_selsig_1 = (shift_arithmetic2_selsig >= dynamic_shift_zerosig_1 ? shift_arithmetic2_selsig :
              dynamic_shift_zerosig_1);



  assign dynamic_shift_cast_1 = {{7{dynamic_shift_selsig_1[8]}}, dynamic_shift_selsig_1};
  assign Shift_Arithmetic2_out1 = Data_Type_Conversion1_out1_1 <<< dynamic_shift_cast_1;



  always @(posedge clk or posedge reset)
    begin : Delay6_process
      if (reset == 1'b1) begin
        Delay6_out1 <= 26'b00000000000000000000000000;
      end
      else begin
        if (enb) begin
          Delay6_out1 <= Shift_Arithmetic2_out1;
        end
      end
    end



  assign Switch1_out1 = (Delay5_out1 == 1'b0 ? Delay4_out1_1 :
              Delay6_out1);



  always @(posedge clk or posedge reset)
    begin : Delay9_process
      if (reset == 1'b1) begin
        Delay9_out1 <= 26'b00000000000000000000000000;
      end
      else begin
        if (enb) begin
          Delay9_out1 <= Switch1_out1;
        end
      end
    end



  assign Data_Type_Conversion1_out1_2 = {1'b0, Delay9_out1};



  assign Unary_Minus_cast = {Data_Type_Conversion1_out1_2[26], Data_Type_Conversion1_out1_2};
  assign Unary_Minus_cast_1 =  - (Unary_Minus_cast);
  assign Unary_Minus_out1 = Unary_Minus_cast_1[26:0];



  assign Switch1_out1_1 = (Delay10_out1 == 1'b0 ? Data_Type_Conversion1_out1_2 :
              Unary_Minus_out1);



  assign Data_Type_Conversion2_out1 = Switch1_out1_1[25:8] + $signed({1'b0, Switch1_out1_1[7]});



  always @(posedge clk or posedge reset)
    begin : Delay8_process
      if (reset == 1'b1) begin
        Delay8_out1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          Delay8_out1 <= Data_Type_Conversion2_out1;
        end
      end
    end



  assign nfp_out = Delay8_out1;

endmodule  // nfp_convert_single_to_sfix_18_En16
