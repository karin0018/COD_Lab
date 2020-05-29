`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 00:59:54
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
    input [31:0]pcin,
    output reg [31:0]ExtOut
    );

    always@(posedge clk or posedge rst)
    begin
        if(rst) ExtOut <= 0;
        else if(PCen) ExtOut <= pcin;
        else ExtOut <= ExtOut;
    end
endmodule