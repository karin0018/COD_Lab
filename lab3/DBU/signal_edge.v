`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/13 21:40:43
// Design Name: 
// Module Name: signal_edge
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


//ͨ���ð�ť���źŲ���һ��ʱ�����ڿ�ȵ������ź�
//�������ϱ��ػ����±��أ��������źŶ��Ǹߵ�ƽ
module signal_edge(
    input clk,
    input button,
    output button_redge
);
reg button_r1,button_r2;
always@(negedge clk)
    button_r1 <= button;
always@(negedge clk)
    button_r2 <= button_r1;
assign button_redge = button_r1 & (~button_r2);//ȡ�±�����Ч�ź�

endmodule
