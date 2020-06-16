`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 23:25:59
// Design Name: 
// Module Name: EQUAL
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


module EQUAL #(parameter N = 32)
    (output reg zero,
    input [N-1:0] a,b
    );
    always@(*)
    begin
        if(a == b) zero = 1;
        else zero = 0;
    end
endmodule