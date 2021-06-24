// -------------------------------------------------------------
// 
// File Name: /Users/ciaran/Documents/MATLAB/Yr3 Intel/stableTD3/hdlsrc/ControllerTestbench/ControllerTestbench/Hidden_Layer_2_Neurons.v
// Created: 2021-06-15 22:29:09
// 
// Generated by MATLAB 9.9 and HDL Coder 3.17
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: Hidden_Layer_2_Neurons
// Source Path: ControllerTestbench/Controller_equiv_DC_motor1/PI_Ctrl_float_speed/Reinforcement Learning1/Subsystem 
// Reference2/Hidden Layer (2 Neurons
// Hierarchy Level: 1
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module Hidden_Layer_2_Neurons
          (clk,
           reset,
           enb,
           layer_input_0,
           layer_input_1,
           layer_input_2,
           layer_input_3,
           weights_matrix_0,
           weights_matrix_1,
           weights_matrix_2,
           weights_matrix_3,
           weights_matrix_4,
           weights_matrix_5,
           weights_matrix_6,
           weights_matrix_7,
           bias_vector_0,
           bias_vector_1,
           layer_output_0,
           layer_output_1);


  input   clk;
  input   reset;
  input   enb;
  input   [17:0] layer_input_0;  // ufix18_En15
  input   [17:0] layer_input_1;  // ufix18_En15
  input   [17:0] layer_input_2;  // ufix18_En15
  input   [17:0] layer_input_3;  // ufix18_En15
  input   signed [17:0] weights_matrix_0;  // sfix18_En15
  input   signed [17:0] weights_matrix_1;  // sfix18_En15
  input   signed [17:0] weights_matrix_2;  // sfix18_En15
  input   signed [17:0] weights_matrix_3;  // sfix18_En15
  input   signed [17:0] weights_matrix_4;  // sfix18_En15
  input   signed [17:0] weights_matrix_5;  // sfix18_En15
  input   signed [17:0] weights_matrix_6;  // sfix18_En15
  input   signed [17:0] weights_matrix_7;  // sfix18_En15
  input   [17:0] bias_vector_0;  // ufix18_En18
  input   [17:0] bias_vector_1;  // ufix18_En18
  output  [17:0] layer_output_0;  // ufix18_En14
  output  [17:0] layer_output_1;  // ufix18_En14


  wire signed [17:0] weights_matrix [0:1] [0:3];  // sfix18_En15 [2x4]
  reg signed [17:0] weights_matrixt [0:3] [0:1];  // sfix18_En15 [4x2]
  wire signed [17:0] weights_matrixt_0_3;  // sfix18_En15
  reg signed [17:0] weights_matrixt_0_3_1;  // sfix18_En15
  reg [17:0] layer_input_3_1;  // ufix18_En15
  wire signed [18:0] mul_Product_dotp_3_cast;  // sfix19_En15
  wire signed [36:0] mul_Product_dotp_3_mul_temp;  // sfix37_En30
  wire signed [35:0] mul_Product_dotp_3_cast_1;  // sfix36_En30
  wire signed [17:0] tmp_Product_dotp_3;  // sfix18_En13
  wire signed [17:0] weights_matrixt_0_2;  // sfix18_En15
  reg signed [17:0] weights_matrixt_0_2_1;  // sfix18_En15
  reg [17:0] layer_input_2_1;  // ufix18_En15
  wire signed [18:0] mul_Product_dotp_2_cast;  // sfix19_En15
  wire signed [36:0] mul_Product_dotp_2_mul_temp;  // sfix37_En30
  wire signed [35:0] mul_Product_dotp_2_cast_1;  // sfix36_En30
  wire signed [17:0] tmp_Product_dotp_2;  // sfix18_En13
  wire signed [17:0] weights_matrixt_0_1;  // sfix18_En15
  reg signed [17:0] weights_matrixt_0_1_1;  // sfix18_En15
  reg [17:0] layer_input_1_1;  // ufix18_En15
  wire signed [18:0] mul_Product_dotp_1_cast;  // sfix19_En15
  wire signed [36:0] mul_Product_dotp_1_mul_temp;  // sfix37_En30
  wire signed [35:0] mul_Product_dotp_1_cast_1;  // sfix36_En30
  wire signed [17:0] tmp_Product_dotp_1;  // sfix18_En13
  reg signed [17:0] tmp_Product_dotp_1_1;  // sfix18_En13
  wire signed [17:0] weights_matrixt_0_0;  // sfix18_En15
  reg signed [17:0] weights_matrixt_0_0_1;  // sfix18_En15
  reg [17:0] layer_input_0_1;  // ufix18_En15
  wire signed [18:0] mul_Product_dotp_0_cast;  // sfix19_En15
  wire signed [36:0] mul_Product_dotp_0_mul_temp;  // sfix37_En30
  wire signed [35:0] mul_Product_dotp_0_cast_1;  // sfix36_En30
  wire signed [17:0] tmp_Product_dotp_0;  // sfix18_En13
  wire signed [17:0] weights_matrixt_1_3;  // sfix18_En15
  reg signed [17:0] weights_matrixt_1_3_1;  // sfix18_En15
  reg [17:0] layer_input_3_2;  // ufix18_En15
  wire signed [18:0] mul_Product_dotp_31_cast;  // sfix19_En15
  wire signed [36:0] mul_Product_dotp_31_mul_temp;  // sfix37_En30
  wire signed [35:0] mul_Product_dotp_31_cast_1;  // sfix36_En30
  wire signed [17:0] tmp_Product_dotp_3_1;  // sfix18_En13
  wire signed [17:0] weights_matrixt_1_2;  // sfix18_En15
  reg signed [17:0] weights_matrixt_1_2_1;  // sfix18_En15
  reg [17:0] layer_input_2_2;  // ufix18_En15
  wire signed [18:0] mul_Product_dotp_21_cast;  // sfix19_En15
  wire signed [36:0] mul_Product_dotp_21_mul_temp;  // sfix37_En30
  wire signed [35:0] mul_Product_dotp_21_cast_1;  // sfix36_En30
  wire signed [17:0] tmp_Product_dotp_2_1;  // sfix18_En13
  wire signed [17:0] weights_matrixt_1_1;  // sfix18_En15
  reg signed [17:0] weights_matrixt_1_1_1;  // sfix18_En15
  reg [17:0] layer_input_1_2;  // ufix18_En15
  wire signed [18:0] mul_Product_dotp_11_cast;  // sfix19_En15
  wire signed [36:0] mul_Product_dotp_11_mul_temp;  // sfix37_En30
  wire signed [35:0] mul_Product_dotp_11_cast_1;  // sfix36_En30
  wire signed [17:0] tmp_Product_dotp_1_2;  // sfix18_En13
  reg signed [17:0] tmp_Product_dotp_1_3;  // sfix18_En13
  wire signed [17:0] weights_matrixt_1_0;  // sfix18_En15
  reg signed [17:0] weights_matrixt_1_0_1;  // sfix18_En15
  reg [17:0] layer_input_0_2;  // ufix18_En15
  wire signed [18:0] mul_Product_dotp_01_cast;  // sfix19_En15
  wire signed [36:0] mul_Product_dotp_01_mul_temp;  // sfix37_En30
  wire signed [35:0] mul_Product_dotp_01_cast_1;  // sfix36_En30
  wire signed [17:0] tmp_Product_dotp_0_1;  // sfix18_En13
  wire [17:0] delayMatch_out_1;  // ufix18_En18
  reg [17:0] delayMatch_1_reg [0:1];  // ufix18 [2]
  wire [17:0] delayMatch_out_2;  // ufix18_En18
  reg [17:0] delayMatch_1_reg_1 [0:1];  // ufix18 [2]
  wire [17:0] delayMatch_1_reg_next [0:1];  // ufix18_En18 [2]
  wire [17:0] delayMatch_1_reg_next_1 [0:1];  // ufix18_En18 [2]
  reg signed [17:0] tmp_Product_dotp_3_2;  // sfix18_En13
  reg signed [17:0] tmp_Product_dotp_2_2;  // sfix18_En13
  reg signed [17:0] tmp_Product_dotp_0_2;  // sfix18_En13
  wire signed [17:0] sum_Product_dotp_1;  // sfix18_En13
  wire signed [17:0] sum_Product_dotp_2;  // sfix18_En13
  wire signed [17:0] Product_0_0;  // sfix18_En13
  reg signed [17:0] tmp_Product_dotp_3_3;  // sfix18_En13
  reg signed [17:0] tmp_Product_dotp_2_3;  // sfix18_En13
  reg signed [17:0] tmp_Product_dotp_0_3;  // sfix18_En13
  wire signed [17:0] sum_Product_dotp_1_1;  // sfix18_En13
  wire signed [17:0] sum_Product_dotp_2_1;  // sfix18_En13
  wire signed [17:0] Product_1_0;  // sfix18_En13
  wire signed [17:0] Product_out1 [0:1];  // sfix18_En13 [2]
  wire [17:0] bias_vector [0:1];  // ufix18_En18 [2]
  wire signed [31:0] Add_add_cast;  // sfix32_En18
  wire signed [31:0] Add_add_cast_1;  // sfix32_En18
  wire signed [31:0] Add_add_temp;  // sfix32_En18
  wire signed [31:0] Add_add_cast_2;  // sfix32_En18
  wire signed [31:0] Add_add_cast_3;  // sfix32_En18
  wire signed [31:0] Add_add_temp_1;  // sfix32_En18
  wire signed [17:0] Add_out1 [0:1];  // sfix18_En13 [2]
  reg signed [17:0] HwModeRegister16_reg [0:1];  // sfix18 [2]
  wire signed [17:0] HwModeRegister16_reg_next [0:1];  // sfix18_En13 [2]
  wire signed [17:0] Add_out1_1 [0:1];  // sfix18_En13 [2]
  wire [0:1] Compare_To_Constant_out1;  // boolean [2]
  reg  [0:1] HwModeRegister17_reg;  // ufix1 [2]
  wire [0:1] HwModeRegister17_reg_next;  // ufix1 [2]
  wire [0:1] Compare_To_Constant_out1_1;  // boolean [2]
  wire signed [17:0] Product21_in1;  // sfix18_En13
  wire signed [18:0] Product21_cast;  // sfix19_En13
  wire signed [17:0] Product21_in1_1;  // sfix18_En13
  wire signed [18:0] Product21_cast_1;  // sfix19_En13
  wire [17:0] Product2_out1 [0:1];  // ufix18_En14 [2]
  reg [17:0] PipelineRegister8_reg [0:1];  // ufix18 [2]
  wire [17:0] PipelineRegister8_reg_next [0:1];  // ufix18_En14 [2]
  wire [17:0] Product2_out1_1 [0:1];  // ufix18_En14 [2]


  assign weights_matrix[0][0] = weights_matrix_0;
  assign weights_matrix[1][0] = weights_matrix_1;
  assign weights_matrix[0][1] = weights_matrix_2;
  assign weights_matrix[1][1] = weights_matrix_3;
  assign weights_matrix[0][2] = weights_matrix_4;
  assign weights_matrix[1][2] = weights_matrix_5;
  assign weights_matrix[0][3] = weights_matrix_6;
  assign weights_matrix[1][3] = weights_matrix_7;

  always @* begin
    weights_matrixt[0][32'sd0] = weights_matrix[0][32'sd0];
    weights_matrixt[1][32'sd0] = weights_matrix[0][32'sd1];
    weights_matrixt[2][32'sd0] = weights_matrix[0][32'sd2];
    weights_matrixt[3][32'sd0] = weights_matrix[0][32'sd3];
    weights_matrixt[0][32'sd1] = weights_matrix[1][32'sd0];
    weights_matrixt[1][32'sd1] = weights_matrix[1][32'sd1];
    weights_matrixt[2][32'sd1] = weights_matrix[1][32'sd2];
    weights_matrixt[3][32'sd1] = weights_matrix[1][32'sd3];
  end



  assign weights_matrixt_0_3 = weights_matrixt[3][0];

  always @(posedge clk or posedge reset)
    begin : HwModeRegister6_process
      if (reset == 1'b1) begin
        weights_matrixt_0_3_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          weights_matrixt_0_3_1 <= weights_matrixt_0_3;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : HwModeRegister7_process
      if (reset == 1'b1) begin
        layer_input_3_1 <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          layer_input_3_1 <= layer_input_3;
        end
      end
    end



  assign mul_Product_dotp_3_cast = {1'b0, layer_input_3_1};
  assign mul_Product_dotp_3_mul_temp = weights_matrixt_0_3_1 * mul_Product_dotp_3_cast;
  assign mul_Product_dotp_3_cast_1 = mul_Product_dotp_3_mul_temp[35:0];
  assign tmp_Product_dotp_3 = mul_Product_dotp_3_cast_1[34:17];



  assign weights_matrixt_0_2 = weights_matrixt[2][0];

  always @(posedge clk or posedge reset)
    begin : HwModeRegister4_process
      if (reset == 1'b1) begin
        weights_matrixt_0_2_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          weights_matrixt_0_2_1 <= weights_matrixt_0_2;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : HwModeRegister5_process
      if (reset == 1'b1) begin
        layer_input_2_1 <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          layer_input_2_1 <= layer_input_2;
        end
      end
    end



  assign mul_Product_dotp_2_cast = {1'b0, layer_input_2_1};
  assign mul_Product_dotp_2_mul_temp = weights_matrixt_0_2_1 * mul_Product_dotp_2_cast;
  assign mul_Product_dotp_2_cast_1 = mul_Product_dotp_2_mul_temp[35:0];
  assign tmp_Product_dotp_2 = mul_Product_dotp_2_cast_1[34:17];



  assign weights_matrixt_0_1 = weights_matrixt[1][0];

  always @(posedge clk or posedge reset)
    begin : HwModeRegister2_process
      if (reset == 1'b1) begin
        weights_matrixt_0_1_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          weights_matrixt_0_1_1 <= weights_matrixt_0_1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : HwModeRegister3_process
      if (reset == 1'b1) begin
        layer_input_1_1 <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          layer_input_1_1 <= layer_input_1;
        end
      end
    end



  assign mul_Product_dotp_1_cast = {1'b0, layer_input_1_1};
  assign mul_Product_dotp_1_mul_temp = weights_matrixt_0_1_1 * mul_Product_dotp_1_cast;
  assign mul_Product_dotp_1_cast_1 = mul_Product_dotp_1_mul_temp[35:0];
  assign tmp_Product_dotp_1 = mul_Product_dotp_1_cast_1[34:17];



  always @(posedge clk or posedge reset)
    begin : PipelineRegister1_process
      if (reset == 1'b1) begin
        tmp_Product_dotp_1_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          tmp_Product_dotp_1_1 <= tmp_Product_dotp_1;
        end
      end
    end



  assign weights_matrixt_0_0 = weights_matrixt[0][0];

  always @(posedge clk or posedge reset)
    begin : HwModeRegister_process
      if (reset == 1'b1) begin
        weights_matrixt_0_0_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          weights_matrixt_0_0_1 <= weights_matrixt_0_0;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : HwModeRegister1_process
      if (reset == 1'b1) begin
        layer_input_0_1 <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          layer_input_0_1 <= layer_input_0;
        end
      end
    end



  assign mul_Product_dotp_0_cast = {1'b0, layer_input_0_1};
  assign mul_Product_dotp_0_mul_temp = weights_matrixt_0_0_1 * mul_Product_dotp_0_cast;
  assign mul_Product_dotp_0_cast_1 = mul_Product_dotp_0_mul_temp[35:0];
  assign tmp_Product_dotp_0 = mul_Product_dotp_0_cast_1[34:17];



  assign weights_matrixt_1_3 = weights_matrixt[3][1];

  always @(posedge clk or posedge reset)
    begin : HwModeRegister14_process
      if (reset == 1'b1) begin
        weights_matrixt_1_3_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          weights_matrixt_1_3_1 <= weights_matrixt_1_3;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : HwModeRegister15_process
      if (reset == 1'b1) begin
        layer_input_3_2 <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          layer_input_3_2 <= layer_input_3;
        end
      end
    end



  assign mul_Product_dotp_31_cast = {1'b0, layer_input_3_2};
  assign mul_Product_dotp_31_mul_temp = weights_matrixt_1_3_1 * mul_Product_dotp_31_cast;
  assign mul_Product_dotp_31_cast_1 = mul_Product_dotp_31_mul_temp[35:0];
  assign tmp_Product_dotp_3_1 = mul_Product_dotp_31_cast_1[34:17];



  assign weights_matrixt_1_2 = weights_matrixt[2][1];

  always @(posedge clk or posedge reset)
    begin : HwModeRegister12_process
      if (reset == 1'b1) begin
        weights_matrixt_1_2_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          weights_matrixt_1_2_1 <= weights_matrixt_1_2;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : HwModeRegister13_process
      if (reset == 1'b1) begin
        layer_input_2_2 <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          layer_input_2_2 <= layer_input_2;
        end
      end
    end



  assign mul_Product_dotp_21_cast = {1'b0, layer_input_2_2};
  assign mul_Product_dotp_21_mul_temp = weights_matrixt_1_2_1 * mul_Product_dotp_21_cast;
  assign mul_Product_dotp_21_cast_1 = mul_Product_dotp_21_mul_temp[35:0];
  assign tmp_Product_dotp_2_1 = mul_Product_dotp_21_cast_1[34:17];



  assign weights_matrixt_1_1 = weights_matrixt[1][1];

  always @(posedge clk or posedge reset)
    begin : HwModeRegister10_process
      if (reset == 1'b1) begin
        weights_matrixt_1_1_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          weights_matrixt_1_1_1 <= weights_matrixt_1_1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : HwModeRegister11_process
      if (reset == 1'b1) begin
        layer_input_1_2 <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          layer_input_1_2 <= layer_input_1;
        end
      end
    end



  assign mul_Product_dotp_11_cast = {1'b0, layer_input_1_2};
  assign mul_Product_dotp_11_mul_temp = weights_matrixt_1_1_1 * mul_Product_dotp_11_cast;
  assign mul_Product_dotp_11_cast_1 = mul_Product_dotp_11_mul_temp[35:0];
  assign tmp_Product_dotp_1_2 = mul_Product_dotp_11_cast_1[34:17];



  always @(posedge clk or posedge reset)
    begin : PipelineRegister5_process
      if (reset == 1'b1) begin
        tmp_Product_dotp_1_3 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          tmp_Product_dotp_1_3 <= tmp_Product_dotp_1_2;
        end
      end
    end



  assign weights_matrixt_1_0 = weights_matrixt[0][1];

  always @(posedge clk or posedge reset)
    begin : HwModeRegister8_process
      if (reset == 1'b1) begin
        weights_matrixt_1_0_1 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          weights_matrixt_1_0_1 <= weights_matrixt_1_0;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : HwModeRegister9_process
      if (reset == 1'b1) begin
        layer_input_0_2 <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          layer_input_0_2 <= layer_input_0;
        end
      end
    end



  assign mul_Product_dotp_01_cast = {1'b0, layer_input_0_2};
  assign mul_Product_dotp_01_mul_temp = weights_matrixt_1_0_1 * mul_Product_dotp_01_cast;
  assign mul_Product_dotp_01_cast_1 = mul_Product_dotp_01_mul_temp[35:0];
  assign tmp_Product_dotp_0_1 = mul_Product_dotp_01_cast_1[34:17];



  always @(posedge clk or posedge reset)
    begin : delayMatch_1_process
      if (reset == 1'b1) begin
        delayMatch_1_reg[0] <= 18'b000000000000000000;
        delayMatch_1_reg[1] <= 18'b000000000000000000;
        delayMatch_1_reg_1[0] <= 18'b000000000000000000;
        delayMatch_1_reg_1[1] <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          delayMatch_1_reg[0] <= delayMatch_1_reg_next[0];
          delayMatch_1_reg[1] <= delayMatch_1_reg_next[1];
          delayMatch_1_reg_1[0] <= delayMatch_1_reg_next_1[0];
          delayMatch_1_reg_1[1] <= delayMatch_1_reg_next_1[1];
        end
      end
    end

  assign delayMatch_1_reg_next[0] = bias_vector_0;
  assign delayMatch_1_reg_next[1] = delayMatch_1_reg[0];
  assign delayMatch_out_1 = delayMatch_1_reg[1];
  assign delayMatch_1_reg_next_1[0] = bias_vector_1;
  assign delayMatch_1_reg_next_1[1] = delayMatch_1_reg_1[0];
  assign delayMatch_out_2 = delayMatch_1_reg_1[1];



  always @(posedge clk or posedge reset)
    begin : PipelineRegister3_process
      if (reset == 1'b1) begin
        tmp_Product_dotp_3_2 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          tmp_Product_dotp_3_2 <= tmp_Product_dotp_3;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : PipelineRegister2_process
      if (reset == 1'b1) begin
        tmp_Product_dotp_2_2 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          tmp_Product_dotp_2_2 <= tmp_Product_dotp_2;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : PipelineRegister_process
      if (reset == 1'b1) begin
        tmp_Product_dotp_0_2 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          tmp_Product_dotp_0_2 <= tmp_Product_dotp_0;
        end
      end
    end



  assign sum_Product_dotp_1 = tmp_Product_dotp_1_1 + tmp_Product_dotp_0_2;



  assign sum_Product_dotp_2 = tmp_Product_dotp_2_2 + sum_Product_dotp_1;



  assign Product_0_0 = tmp_Product_dotp_3_2 + sum_Product_dotp_2;



  always @(posedge clk or posedge reset)
    begin : PipelineRegister7_process
      if (reset == 1'b1) begin
        tmp_Product_dotp_3_3 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          tmp_Product_dotp_3_3 <= tmp_Product_dotp_3_1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : PipelineRegister6_process
      if (reset == 1'b1) begin
        tmp_Product_dotp_2_3 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          tmp_Product_dotp_2_3 <= tmp_Product_dotp_2_1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : PipelineRegister4_process
      if (reset == 1'b1) begin
        tmp_Product_dotp_0_3 <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          tmp_Product_dotp_0_3 <= tmp_Product_dotp_0_1;
        end
      end
    end



  assign sum_Product_dotp_1_1 = tmp_Product_dotp_1_3 + tmp_Product_dotp_0_3;



  assign sum_Product_dotp_2_1 = tmp_Product_dotp_2_3 + sum_Product_dotp_1_1;



  assign Product_1_0 = tmp_Product_dotp_3_3 + sum_Product_dotp_2_1;



  assign Product_out1[0] = Product_0_0;
  assign Product_out1[1] = Product_1_0;

  assign bias_vector[0] = delayMatch_out_1;
  assign bias_vector[1] = delayMatch_out_2;

  assign Add_add_cast = {{9{Product_out1[0][17]}}, {Product_out1[0], 5'b00000}};
  assign Add_add_cast_1 = {14'b0, bias_vector[0]};
  assign Add_add_temp = Add_add_cast + Add_add_cast_1;
  assign Add_out1[0] = Add_add_temp[22:5];
  assign Add_add_cast_2 = {{9{Product_out1[1][17]}}, {Product_out1[1], 5'b00000}};
  assign Add_add_cast_3 = {14'b0, bias_vector[1]};
  assign Add_add_temp_1 = Add_add_cast_2 + Add_add_cast_3;
  assign Add_out1[1] = Add_add_temp_1[22:5];



  always @(posedge clk or posedge reset)
    begin : HwModeRegister16_process
      if (reset == 1'b1) begin
        HwModeRegister16_reg[0] <= 18'sb000000000000000000;
        HwModeRegister16_reg[1] <= 18'sb000000000000000000;
      end
      else begin
        if (enb) begin
          HwModeRegister16_reg[0] <= HwModeRegister16_reg_next[0];
          HwModeRegister16_reg[1] <= HwModeRegister16_reg_next[1];
        end
      end
    end

  assign Add_out1_1[0] = HwModeRegister16_reg[0];
  assign Add_out1_1[1] = HwModeRegister16_reg[1];
  assign HwModeRegister16_reg_next[0] = Add_out1[0];
  assign HwModeRegister16_reg_next[1] = Add_out1[1];



  assign Compare_To_Constant_out1[0] = Add_out1[0] >= 18'sb000000000000000000;
  assign Compare_To_Constant_out1[1] = Add_out1[1] >= 18'sb000000000000000000;



  always @(posedge clk or posedge reset)
    begin : HwModeRegister17_process
      if (reset == 1'b1) begin
        HwModeRegister17_reg[0] <= 1'b0;
        HwModeRegister17_reg[1] <= 1'b0;
      end
      else begin
        if (enb) begin
          HwModeRegister17_reg[0] <= HwModeRegister17_reg_next[0];
          HwModeRegister17_reg[1] <= HwModeRegister17_reg_next[1];
        end
      end
    end

  assign Compare_To_Constant_out1_1[0] = HwModeRegister17_reg[0];
  assign Compare_To_Constant_out1_1[1] = HwModeRegister17_reg[1];
  assign HwModeRegister17_reg_next[0] = Compare_To_Constant_out1[0];
  assign HwModeRegister17_reg_next[1] = Compare_To_Constant_out1[1];



  assign Product21_in1 = (Compare_To_Constant_out1_1[0] == 1'b1 ? Add_out1_1[0] :
              18'sb000000000000000000);
  assign Product21_cast = {Product21_in1[17], Product21_in1};
  assign Product2_out1[0] = {Product21_cast[16:0], 1'b0};
  assign Product21_in1_1 = (Compare_To_Constant_out1_1[1] == 1'b1 ? Add_out1_1[1] :
              18'sb000000000000000000);
  assign Product21_cast_1 = {Product21_in1_1[17], Product21_in1_1};
  assign Product2_out1[1] = {Product21_cast_1[16:0], 1'b0};



  always @(posedge clk or posedge reset)
    begin : PipelineRegister8_process
      if (reset == 1'b1) begin
        PipelineRegister8_reg[0] <= 18'b000000000000000000;
        PipelineRegister8_reg[1] <= 18'b000000000000000000;
      end
      else begin
        if (enb) begin
          PipelineRegister8_reg[0] <= PipelineRegister8_reg_next[0];
          PipelineRegister8_reg[1] <= PipelineRegister8_reg_next[1];
        end
      end
    end

  assign Product2_out1_1[0] = PipelineRegister8_reg[0];
  assign Product2_out1_1[1] = PipelineRegister8_reg[1];
  assign PipelineRegister8_reg_next[0] = Product2_out1[0];
  assign PipelineRegister8_reg_next[1] = Product2_out1[1];



  assign layer_output_0 = Product2_out1_1[0];

  assign layer_output_1 = Product2_out1_1[1];

endmodule  // Hidden_Layer_2_Neurons

