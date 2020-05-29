`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 11:13:37
// Design Name: 
// Module Name: InsReg
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


module Reg_file
    #(parameter WIDTH = 32, NUM = 32) // NUM*WIDTH 大小的寄存器
    (input clk,
     input [4:0] ra0, // 读端口 0 地址
     output [WIDTH-1:0] rd0, // 读端口 0 数据
     input [4:0]ra1, // 读端口 1 地址
     output [WIDTH-1:0]rd1,// 读端口 1 数据
     input [4:0] ra2,// 读端口 2 地址
     output [WIDTH-1:0]rd2, // 写端口数据
     input [4:0] wa, // 写端口地址
     input we, // 写使能
     input [WIDTH-1:0] wd // 写端口数据
    );
    reg [WIDTH-1:0] REG_FILE[0:NUM-1];
    integer i;
    initial // 初始化 NUM 个寄存器
        for(i=0;i < NUM;i=i+1) REG_FILE[i] <=0;
    always@(posedge clk)
    begin
        REG_FILE[0] <= 0;
        if(we && wa) REG_FILE[wa] <= wd;
    end
    
    // 异步读数据，不受时钟信号的控制
    assign rd0 = REG_FILE[ra0];
    assign rd1 = REG_FILE[ra1];
    assign rd2 = REG_FILE[ra2];
    
endmodule
