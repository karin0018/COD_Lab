`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 23:22:04
// Design Name: 
// Module Name: mux4to1_d32
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


module mux4to1_d32 #(parameter N = 32)
    (output reg [N-1:0] out, // �������
    input [N-1:0] a,b,c,d, // ��������
    input [1:0]sel // ѡ��λ
    );
    always@(*)
    begin
        if(sel == 2'b00) out = a;
        else if(sel == 2'b01) out = b;
        else if(sel == 2'b10) out = c; 
        else if(sel == 2'b11) out = d;
        else out = out;
    end
endmodule
