`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2018 19:46:52
// Design Name: 
// Module Name: mux41
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


module mux41(
    input a,
    input b,
    input c,
    input d,
    input en,
    input [1:0] s,
    output y
    );
    reg y=1'b0;
    always@(*)
    begin
    if(en==0)
    y=1'b0;
    else
    begin
    case(s)
    2'b00:y=a;
    2'b01:y=b;
    2'b10:y=c;
    2'b11:y=d;
    default: y=1'b0;
    endcase
    end
    end
    
endmodule

module mux(a,b,c,d,e,f,g,h,s,y);
input a,b,c,d,e,f,g,h;
input [2:0] s;
output y;
wire w1,w2,w3;
not(w1,s[2]);
mux41 z1 (a,b,c,d,w1,s[1:0],w2);
mux41 z2 (e,f,g,h,s[2],s[1:0],w3);
or o1 (y,w2,w3);
endmodule
