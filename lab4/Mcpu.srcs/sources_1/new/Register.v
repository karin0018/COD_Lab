`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 11:15:40
// Design Name: 
// Module Name: Register
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


module Register
    #(parameter WIDTH = 32 ) // ¼Ä´æÆ÷Êý¾ÝÎ»¿í
    (input clk,
    input rst,
    input [WIDTH-1:0]data,
    output [WIDTH-1:0]exout 
    );
    reg [WIDTH-1:0] ind;
    assign exout = ind;
    
    always@(posedge clk or posedge rst)
    begin
        if(rst) ind <= 0;
        else ind <= data;     
    end
endmodule
