`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: seven_seg_disp
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

module seven_seg_disp(
    input [3:0] d_1,
    input [3:0] d_2,
    //input [3:0] d_3,
    //input [3:0] d_4,
    //input clk_in,
    input rst,
    output [7:0] AN,
    output [6:0] seven_seg,
	
	input clk_500Hz
    );

wire [6:0] MEM_1, MEM_2;
wire [6:0] MEM_3, MEM_4;


hex_to_seg U1 (.rst(rst), .data_in(d_1), .seg_out(MEM_1));
hex_to_seg U2 (.rst(rst), .data_in(d_2), .seg_out(MEM_2));
//hex_to_seg U3 (.clk_in(clk_in), .rst(rst), .data_in(d_3), .seg_out(MEM_3));
//hex_to_seg U4 (.clk_in(clk_in), .rst(rst), .data_in(d_4), .seg_out(MEM_4));	
	
AN_logic U_shift(
	.clk_in(clk_500Hz), .rst(rst),
	.MEM_1(MEM_1), .MEM_2(MEM_2), //.MEM_3(MEM_3), .MEM_4(MEM_4),
	.AN(AN), .seven_seg(seven_seg));

	
endmodule
