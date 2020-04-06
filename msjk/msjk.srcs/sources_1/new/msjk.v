`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2018 22:45:52
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
    
    always @(posedge clk)
    begin
    case({s,r})
    2'b00:q=q;
    2'b01:q=0;
    2'b10:q=1;
    2'b11:q=1'bz;
    endcase
    qb=~q;
    end
endmodule
