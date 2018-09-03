`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: clock_generator
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

module clock_generator(
    input clk_10MHz,
    input rst,
    output reg clk_500Hz // for AN logic
    );
	
	
	reg [13:0] counter_500;
	
always@(posedge clk_10MHz or posedge rst)
if(rst)
	counter_500 <= 0;
else if(counter_500 == 14'd9999)
	counter_500 <= 0;
else
	counter_500 <= counter_500 + 1'b1;
	
always@(posedge clk_10MHz or posedge rst)
if(rst)
	clk_500Hz <= 0;
else if(counter_500 == 0)
	clk_500Hz <= ~clk_500Hz;
else
	clk_500Hz <= clk_500Hz;
	
endmodule
