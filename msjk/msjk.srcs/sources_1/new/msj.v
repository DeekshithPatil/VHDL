`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2018 22:51:21
// Design Name: 
// Module Name: msj
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


module msj(
    input j,
    input k,
    input clk,
    output q1,
    output q1b,
    output q2,
    output q2b
    );
    wire w1,w2,w3;
    not n1 (w3,clk);
    and a1 (w1,j,q2b);
    and a2 (w2,k,q2);
    
    srf s1 (w1,w2,clk,q1,q1b);
    srf s2 (q1,q1b,w3,q2,q2b);
endmodule
