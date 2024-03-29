// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
// Date        : Sun Oct 30 15:10:49 2022
// Host        : pax-18 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/ci7662ar-s/CNN/CNN.srcs/sources_1/ip/dist_mem_gen_3/dist_mem_gen_3_stub.v
// Design      : dist_mem_gen_3
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_10,Vivado 2016.1" *)
module dist_mem_gen_3(a, d, clk, we, spo)
/* synthesis syn_black_box black_box_pad_pin="a[3:0],d[63:0],clk,we,spo[63:0]" */;
  input [3:0]a;
  input [63:0]d;
  input clk;
  input we;
  output [63:0]spo;
endmodule
