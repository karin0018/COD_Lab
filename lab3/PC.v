`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 23:02:09
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
    input [31:0]pcin,
    output [31:0]ExtOut
    );
    reg [31:0]pc;
    
    assign ExtOut = pc;
    always@(posedge clk or posedge rst)
    begin
        if(rst) pc = 0;
        else pc = pcin;
    end
endmodule
