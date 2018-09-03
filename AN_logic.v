//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: AN_logic
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

module AN_logic (
	input clk_in,
	input rst,
	
	input [6:0] MEM_1, MEM_2, //MEM_3, MEM_4,
	output reg [6:0] seven_seg,
	output reg [7:0] AN
	);
	
reg [1:0] counter; // count from 0 to 3

always@(posedge clk_in, posedge rst)
if (rst)
	counter <= 0;
else if (counter == 3)
	counter <= 0;
else
	counter <= counter + 1'b1;

always@(counter,rst)
if (rst)
	AN <= 8'b1111_1100;
else
	case(counter)
	0:	AN <= 8'b1111_1110;
	1:	AN <= 8'b1111_1101;
	default: AN <= 8'b1111_1111;
	//2:	AN <= 8'b1111_1011;
	//3:	AN <= 8'b1111_0111;
	endcase
	
always@(counter,rst, MEM_1, MEM_2)
if (rst)
	seven_seg <= MEM_1;
else
	case(counter)
	0: seven_seg <= MEM_1;
	1: seven_seg <= MEM_2;
	default seven_seg <= 7'b0000000;
	//2: seven_seg <= MEM_3;
	//3: seven_seg <= MEM_4;
	endcase
endmodule