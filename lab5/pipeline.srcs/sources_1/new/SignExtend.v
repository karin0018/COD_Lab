`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 13:13:07
// Design Name: 
// Module Name: SignExtend
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


module SignExtend( // ������չģ��
    input [15:0]imm,
    output [31:0]extend
    );

    assign extend[15:0] = imm; // �� 16 λ����
    assign extend[31:16] = (imm[15] == 1)? 16'hffff:16'h0000; // �з��������� 16 λ�� imm[15]
    
endmodule
