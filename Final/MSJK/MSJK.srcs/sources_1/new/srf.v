`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2018 17:22:03
// Design Name: 
// Module Name: srf
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


module srf(
    input s,
    input r,
    input clk,
    output q,
    output qb
    );
    reg q=1'b0;
    reg qb=1'b1;
    always@(posedge clk)
    begin
    case({s,r})
    2'b00:q=q;
    2'b01:q=1'b0;
    2'b10:q=1'b1;
    2'b11:q=1'bz;
    endcase
    qb=~q;
    end
    
endmodule

module msjk(j,k,clk,q,qb);
input j,k,clk;
output q,qb;
wire w1,w2,w3,w4,w5;
not n1(w1,clk);
and a1(w2,j,qb);
and a2(w3,k,q);

srf s1(w2,w3,clk,w4,w5);
srf s2(w4,w5,w1,q,qb);
endmodule






