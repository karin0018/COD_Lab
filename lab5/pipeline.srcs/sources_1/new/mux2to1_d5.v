`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 23:03:46
// Design Name: 
// Module Name: mux2to1_d5
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


module mux2to1_d5 #(parameter N = 5)
    (output reg [N-1:0] out, // �������
    input [N-1:0] a,b, // ��������
    input sel // ѡ��λ
    );
    always@(*)
    begin
        if(sel == 0) out = a;
        else if (sel == 1) out = b;
        else out = out;
    end
endmodule

