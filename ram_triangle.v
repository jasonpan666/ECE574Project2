//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: ram_triangle
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

module ram_triangle (
	//input clk_fpga,
	input rst,
	input sync,
	output reg [7:0] d_out
	);
	
	wire [7:0] data_ram [15:0];
	assign data_ram[0] = 8'd0;
	assign data_ram[1] = 8'd36;
	assign data_ram[2] = 8'd73;
	assign data_ram[3] = 8'd109;
	assign data_ram[4] = 8'd146;
	assign data_ram[5] = 8'd182;
	assign data_ram[6] = 8'd219;
	assign data_ram[7] = 8'd255;
	assign data_ram[8] = 8'd245;
	assign data_ram[9] = 8'd219;
	assign data_ram[10]= 8'd182;
	assign data_ram[11]= 8'd146;
	assign data_ram[12]= 8'd109;
	assign data_ram[13]= 8'd73;
	assign data_ram[14]= 8'd36;
	assign data_ram[15]= 8'd0;
	
	reg [3:0] ram_addr;
	
always@(posedge sync or posedge rst)
if(rst)
	ram_addr <= 0;
else
	ram_addr <= ram_addr + 1'b1;
	
always@(posedge sync or posedge rst)
if(rst)
	d_out <= 0;
else
	d_out <= data_ram[ram_addr];
	
endmodule