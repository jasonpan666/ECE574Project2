`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: DAC_SPI_TOP
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

module DAC_SPI_TOP(
    input clk_in,
    input rst,
    input [7:0] serial_data, // microblaze output to create voltage
    input [1:0] select_flag,
    output sclk,
	output reg sync,
	output reg dac_din
    );
	
	reg [15:0] buffer;
	reg [6:0] count_sync; // 0--99; count 16 times for low sunc, count 100 times for 100KHz
	
	wire [7:0] buffer_tri; // store the triangle wave data
	wire [7:0] buffer_sin; // store the sine wave data
	
	assign sclk = clk_in; // sclk is 10MHz
	
	parameter s1 = 1'b0, s2 = 1'b1;
	reg state, next_state;
	
	ram_triangle ram_triangle (.sync(sync), .rst(rst), .d_out(buffer_tri));
	ram_sin ram_sin (.sync(sync), .rst(rst), .d_out(buffer_sin));
	
always@(posedge sclk or posedge rst)
if(rst)
	count_sync <= 0;
else if(count_sync == 7'd99)
	count_sync <= 0;
else
	count_sync <= count_sync + 1'b1;
	
always@(posedge sclk or posedge rst)
if(rst)
	sync <= 0;
else if (count_sync <= 7'd15)
	sync <= 0;
else
	sync <= 1;

// state machine Flip-flops
always@(negedge sclk or posedge rst)
if(rst)
	state <= 0;
else
	state <= next_state;

// state machine combintional logic
always@(state, sync)
	case(state)
		s1: if(sync == 1'b1)
				next_state = s1;
			else 
				next_state = s2;
		s2: if(sync == 0)
				next_state = s2;
			else 
				next_state = s1;
		default: next_state = s1;
	endcase
	
always@(posedge sclk or posedge rst)
if(rst)
	buffer <= 16'd0;
else
	if(state == s1)
	begin
		if((select_flag == 2'd3)|(select_flag == 2'd2)) // output voltage,
			buffer <= {8'd0, serial_data};
		else if (select_flag == 2'd0) // create sine or triangle wave
			buffer <= {8'd0, buffer_tri};
		else if (select_flag == 2'd1)
			buffer <= {8'd0, buffer_sin};
		else;
	end
	else if(state == s2)
		buffer <= {buffer[15:0],1'b0}; // left shift
	else;	
/*	
always@(posedge sclk or posedge sync or posedge rst)
if(rst)
	buffer <= 16'd0;
else if (sync)
	begin
		if (select_flag[1] == 1) // output voltage  select_flag = 2'b10
			buffer <= {8'd0, serial_data};
		else if (select_flag[1] == 0) // create sine or triangle wave
			if (select_flag[0] == 0) // select_flag = 2'b01;
				buffer <= {8'd0, buffer_tri};
			else                                 // select_flag = 2'b00;
				buffer <= {8'd0, buffer_sin};
		else;
	end	
else
	buffer <= {buffer[15:0],1'b0}; // left shift

*/	
always@(negedge sclk or posedge rst)
if(rst)
	dac_din <= 0;
else
	dac_din <= buffer[15];	
	
endmodule
