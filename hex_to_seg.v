//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: hex_to_seg
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

module hex_to_seg(
	//input clk_in,
	input rst,
	
	input [3:0] data_in,
	output reg [6:0] seg_out
	);
	
parameter ZERO = 7'b1000000, ONE = 7'b1111001, TWO = 7'b0100100, THREE = 7'b0110000,
		FOUR = 7'b0011001, FIVE = 7'b0010010, SIX = 7'b0000010, SEVEN = 7'b1111000,
		EIGHT = 7'b00000000, NINE = 7'b0010000, TEN = 7'b0001000, ELEVEN = 7'b0000011, 
		TWELVE = 7'b1000110, THIRTEEN = 7'b0100001, FOURTEEN = 7'b0000110, FIFTEEN = 7'b0001110;
	
always@(data_in, rst)
begin
	if (rst)
		seg_out <= ONE;
	else
		case(data_in)
		4'b0000: seg_out <= ZERO;
		4'b0001: seg_out <= ONE;
		4'b0010: seg_out <= TWO;
		4'b0011: seg_out <= THREE;
		4'b0100: seg_out <= FOUR;
		4'b0101: seg_out <= FIVE;
		4'b0110: seg_out <= SIX;
		4'b0111: seg_out <= SEVEN;
		4'b1000: seg_out <= EIGHT;
		4'b1001: seg_out <= NINE;
		4'b1010: seg_out <= TEN;
		4'b1011: seg_out <= ELEVEN;
		4'b1100: seg_out <= TWELVE;
		4'b1101: seg_out <= THIRTEEN;
		4'b1110: seg_out <= FOURTEEN;
		4'b1111: seg_out <= FIFTEEN;
		endcase
end
	
	
endmodule