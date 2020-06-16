`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 01:18:09
// Design Name: 
// Module Name: IF_ID_Reg
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


module IF_ID_Reg #(parameter N = 32)
   (input [N-1:0] PC4,
    input [N-1:0] Instruct,
    input en,
    input clk,
    input rst,
    input Flush,
    output reg [N-1:0] NPC,
    output reg [N-1:0] IR
    );
    
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            NPC <= 0;
            IR <= 0;
        end
        else if(Flush)
        begin
            NPC <= 0;
            IR <= 0;
        end
        else if(!Flush && en)
        begin
            NPC <= PC4;
            IR <= Instruct;
        end
        else
        begin
            NPC <= NPC;
            IR <= IR;
        end
    end
    
endmodule
