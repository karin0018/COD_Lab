`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 23:07:09
// Design Name: 
// Module Name: mux3to1_d32
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


module mux3to1_d32 #(parameter N = 32)
    (output reg [N-1:0] out, // 输出数据
    input [N-1:0] a,b,c, // 输入数据
    input [1:0]sel // 选择位
    );
    always@(*)
    begin
        if(sel == 2'b00) out = a;
        else if(sel == 2'b01) out = b;
        else if(sel == 2'b10) out = c; 
        else out = out;
    end
endmodule

