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


module Ins_Reg
    #(parameter WIDTH = 32 ) // ¼Ä´æÆ÷Êý¾ÝÎ»¿í
    (input clk,
    input rst,
    input IRWrite,
    input [WIDTH-1:0] instruct,
    output reg [15:0]ins_15_0,
    output reg [4:0]ins_20_16,
    output reg [4:0]ins_25_21,
    output reg [5:0]ins_31_26
    );
    
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            ins_15_0 <= 0;
            ins_20_16 <= 0;
            ins_25_21 <= 0;
            ins_31_26 <= 0;
        end 
        else if(IRWrite)
        begin
            ins_15_0 <= instruct[15:0];
            ins_20_16 <= instruct[20:16];
            ins_25_21 <= instruct[25:21];
            ins_31_26 <= instruct[31:26];
        end
        else 
        begin
            ins_15_0 <= ins_15_0;
            ins_20_16 <= ins_20_16;
            ins_25_21 <= ins_25_21;
            ins_31_26 <= ins_31_26;
        end   
    end
endmodule
