`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/11 21:45:14
// Design Name: 
// Module Name: ALU
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


/*--- ALU ����ʵ�� ---*/
module ALU #(parameter WIDTH = 32) // ���ݿ��
    (output reg [WIDTH-1:0]y, // ���������
     output reg zf, // ���־
     output reg cf, // ��λ/��λ��־
     output reg of, // �����־
     input [WIDTH-1:0]a,b, // ����������
     input [2:0]m // ��������
    );

always@(*)
begin
  cf=1'b0;
  zf=1'b0;
  of=1'b0;
  case(m)
    3'b000:// �ӷ�
    begin
      {cf,y} = a + b;
      of = (~a[WIDTH-1]&~b[WIDTH-1]&y[WIDTH-1])|(a[WIDTH-1]&b[WIDTH-1]&~y[WIDTH-1]);
    end
    3'b001:// ����
    begin
      {cf,y} = a - b;
      of = (a[WIDTH-1]&~b[WIDTH-1]&~y[WIDTH-1])|(a[WIDTH-1]&~b[WIDTH-1]&~y[WIDTH-1]);
    end
    3'b010: // ��λ��
    begin
      y = a & b;
    end
    3'b011:// ��λ��
    begin
      y = a | b;
    end
    3'b100:// ��λ���
    begin
      y = a ^ b;
    end
    default:
    begin
      cf=1'b0;
      zf=1'b0;
      of=1'b0;
      y = 0;
    end
  endcase
  zf = ~|y; // ��Լ���
end
endmodule

