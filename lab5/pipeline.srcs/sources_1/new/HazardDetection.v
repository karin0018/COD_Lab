`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 20:43:20
// Design Name: 
// Module Name: HazardDetection
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


module HazardDetection(
    input [4:0] RsAddr_id,
    input [4:0] RtAddr_id,
    input [4:0] RtAddr_ex,
    input MemRead_ex,
    // ����˿�
    output PCEn,
    output IF_ID_En,
    output NOP
    );

    assign NOP = ((RsAddr_id == RtAddr_ex) || (RtAddr_id == RtAddr_ex)) && MemRead_ex; // NOP == 1 ������ˮ������
    assign PCEn = ~NOP; // ��ˮ������1��ָ��ٸ���
    assign IF_ID_En = ~NOP; // ��ˮ������2���μ�Ĵ������ٸ���
    
endmodule
