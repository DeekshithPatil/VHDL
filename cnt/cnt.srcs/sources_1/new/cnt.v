`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2018 22:18:58
// Design Name: 
// Module Name: cnt
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


module cnt(
    input clk,
    input en,
    input clr,
    output [3:0] q
    );
    reg [3:0] q=4'b0001;
    always @(posedge clk)
    begin
    if(en==0)
    q=4'bzzzz;
    else
    begin
    if (clr==0)
    q=4'b0001;
    else if(q==4'd9)
    q=4'b0001;
    else
    q=q+2;
    end
    end
    
endmodule
