`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2018 17:53:43
// Design Name: 
// Module Name: jkf
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


module jkf(
    input j,
    input k,
    input clk,
    input re,
    input pre,
    input en,
    output q,
    output qb
    );
    reg q=1'b0;
    reg qb=1'b1;
    
    always @(posedge clk or negedge re or negedge pre)
    begin
    if(en==0)
    {q,qb}=2'bzz;
    else
    begin
    if(re==0)
    {q,qb}=2'b01;
    else if(pre==0)
    {q,qb}=2'b10;
    else if(pre==1 && re==1)
    begin
    case({j,k})
    2'b00:q=q;
    2'b01:q=1'b0;
    2'b10:q=1'b1;
    2'b11:q=~q;
    endcase
    qb=~q;
    end
    end
    end
    
    
endmodule
