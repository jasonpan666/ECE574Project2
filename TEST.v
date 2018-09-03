`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: WPI	
// Engineer: Zhenyu Pan
// 
// Create Date: 11/08/2017
// Design Name: ECE574 Project2
// Module Name: TEST
// Project Name: ECE574 Project2
//////////////////////////////////////////////////////////////////////////////////


module TEST(

    );
    
	reg	 clk_10MHz;
	reg  rst;
	wire sclk;
	wire dac_din;
	wire sync;
	
	reg [7:0] serial_data;
	reg [1:0] select_flag;
	
    DAC_SPI_TOP uut(
				.clk_in(clk_10MHz),
				.rst(rst),
				.serial_data(serial_data),
				.select_flag(select_flag),
				.sclk(sclk),
				.sync(sync),
				.dac_din(dac_din)
				   );
				   
initial
begin
	rst = 1;
	#10;
	rst = 0;
	select_flag = 2'b10;
end	

always
begin
	clk_10MHz = 0;
	#2;
	clk_10MHz = 1;
	#2;
end
  
always
begin
	serial_data = 8'd185; // 2.4v
	#500;
	serial_data = 8'd92; // 1.2v
	#500;
end
endmodule
