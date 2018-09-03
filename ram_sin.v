//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: ram_sin
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////

module ram_sin (
	//input clk_fpga,
	input rst,
	input sync,
	output reg [7:0] d_out
	);
	
	wire [7:0] data_ram [15:0];
	assign data_ram[0] = 8'h80;
	assign data_ram[1] = 8'hb3;
	assign data_ram[2] = 8'hde;
	assign data_ram[3] = 8'hf9;
	assign data_ram[4] = 8'hfe;
	assign data_ram[5] = 8'hee;
	assign data_ram[6] = 8'hca;
	assign data_ram[7] = 8'h9a;
	assign data_ram[8] = 8'h65;
	assign data_ram[9] = 8'h35;
	assign data_ram[10]= 8'h11;
	assign data_ram[11]= 8'h1;
	assign data_ram[12]= 8'h6;
	assign data_ram[13]= 8'h21;
	assign data_ram[14]= 8'h4c;
	assign data_ram[15]= 8'h7f;
	
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