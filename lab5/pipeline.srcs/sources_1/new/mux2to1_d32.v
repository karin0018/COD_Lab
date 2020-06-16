`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 22:55:33
// Design Name: 
// Module Name: mux2to1_d32
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


module mux2to1_d32 #(parameter N = 32)
    (output [N-1:0] out, // 输出数据
    input [N-1:0] a,b, // 输入数据
    input sel // 选择位
    );
    
    assign out = (sel == 0)? a:b;
    
endmodule
