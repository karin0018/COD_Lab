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
    #(parameter WIDTH = 32, NUM = 32) // NUM*WIDTH ��С�ļĴ���
    (input clk,
     input [4:0] ra0, // ���˿� 0 ��ַ
     output [WIDTH-1:0] rd0, // ���˿� 0 ����
     input [4:0]ra1, // ���˿� 1 ��ַ
     output [WIDTH-1:0]rd1,// ���˿� 1 ����
     input [4:0] ra2,// ���˿� 2 ��ַ
     output [WIDTH-1:0]rd2, // д�˿�����
     input [4:0] wa, // д�˿ڵ�ַ
     input we, // дʹ��
     input [WIDTH-1:0] wd // д�˿�����
    );
    reg [WIDTH-1:0] REG_FILE[0:NUM-1];
    integer i;
    initial // ��ʼ�� NUM ���Ĵ���
        for(i=0;i < NUM;i=i+1) REG_FILE[i] <=0;
    always@(posedge clk)
    begin
        REG_FILE[0] <= 0;
        if(we && wa) REG_FILE[wa] <= wd;
    end
    
    // �첽�����ݣ�����ʱ���źŵĿ���
    assign rd0 = REG_FILE[ra0];
    assign rd1 = REG_FILE[ra1];
    assign rd2 = REG_FILE[ra2];
    
endmodule
