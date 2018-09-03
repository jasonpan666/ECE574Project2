module LED(LED,BT);
 
input  [2:0] BT;
output  [15:0] LED;

reg  data;
 
always@(BT)
        if(BT <= 3'b010)
                 data = 1'b1;
        else
                 data = 1'b0;
assign  LED = data;

endmodule