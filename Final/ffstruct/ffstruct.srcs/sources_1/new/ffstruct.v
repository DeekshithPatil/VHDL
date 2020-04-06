`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2018 16:50:19
// Design Name: 
// Module Name: ffstruct
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ffstruct(
    input t,
    //input k,
    input clk,
    output q,
    output qb
    );
    wire w1,w2,w3;
    //reg q=1'b0;
    //reg qb=1'b1;
   nand n1 (w1,t,clk,qb);
   nand n2 (w2,t,clk,q);
   na n3 (q,w1,qb);
   na n4 (qb,w2,q);
    
    
endmodule

module na (y,a,b);
input a,b;
output y;
reg y=1'b0;
always@(*)
begin
y=~(a & b);
end
endmodule