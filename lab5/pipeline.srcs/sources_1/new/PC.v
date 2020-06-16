`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/11 21:30:35
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input rst,
    input PCen,
    input [31:0]PCin,
    output reg [31:0]PCout
    );
    always@(posedge clk)
    begin
        if(rst) PCout <= 0;
        else if (PCen == 1) PCout <= PCin;
        else PCout <= PCout;
    end
endmodule
