`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: TOP_module
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

module TOP_module(
    input clk_fpga, // input clk, 100MHz
    input rst, // whole reset     
    input rst_mcs, // reset signal for microblaze alone
	
	input rx,
	output tx,
	
	input [2:0] BT,
	output [7:0] AN,
	output [6:0] seven_seg,
	output [15:0] LED,
	
	output color,
	
	output sclk,
	output dac_din,
	output sync
    );
    
    wire clk_100MHz; // for microblaze
    wire clk_10MHz; // for disp, and for sclk
	wire clk_500Hz; // AN logic
	
	wire [7:0] disp_d_in; //GPO1
    wire [3:0] d_in_l;
    wire [3:0] d_in_h;
	
	wire [7:0] serial_data; // GPO2
	wire [1:0] select_flag; // GPO3
	
	assign d_in_l = disp_d_in[3:0];
	assign d_in_h = disp_d_in[7:4];
	
  // instantiation for other parts  
clk_wiz_0 MMCM(
    // Clock in ports
    .clk_fpga(clk_fpga),      // input clk_fpga
    // Clock out ports
    .clk_100MHz(clk_100MHz),     // output clk_100MHz
    .clk_10MHz(clk_10MHz),     // output clk_10MHz
    // Status and control signals
    .rst(rst), // input rst
    .locked(color)
    );      // output locked
        
 microblaze_mcs_0 MCS (
    .Clk(clk_100MHz),         // input wire Clk
    .Reset(rst_mcs),        // input wire Reset
    .UART_rxd(rx),     // input wire UART_rxd
    .UART_txd(tx),     // output wire UART_txd
    .GPIO1_tri_i(BT),  // input wire [2 : 0] GPIO1_tri_i
    .GPIO1_tri_o(disp_d_in),  // output wire [7 : 0] GPIO1_tri_o
    .GPIO2_tri_o(serial_data),  // output wire [7 : 0] GPIO2_tri_o
    .GPIO3_tri_o(select_flag),  // output wire [1 : 0] GPIO3_tri_o
    .GPIO4_tri_o(LED)  // output wire [15 : 0] GPIO4_tri_o
    );
    
clock_generator slower_clk_creater(
	.clk_10MHz(clk_10MHz),
	.rst(rst),
	.clk_500Hz(clk_500Hz)
	);

seven_seg_disp seven_seg_disp(
	//.clk_in(clk_10MHz),
	.rst(rst),
	.AN(AN),
	.seven_seg(seven_seg),
	.d_1(d_in_l),
	.d_2(d_in_h),
	.clk_500Hz(clk_500Hz)
	);	

DAC_SPI_TOP DAC_SPI(
	.clk_in(clk_10MHz),
    .rst(rst),
    .serial_data(serial_data),
    .select_flag(select_flag),
    .sclk(sclk),
	.sync(sync),
	.dac_din(dac_din)
	);

endmodule


