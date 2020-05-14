`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 22:43:06
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
   (output [N-1:0]out,
   input [N-1:0 ]a,b, // ��������
   input sel // ѡ��λ
    );
reg [N-1:0]od;
assign out = od;
always @(*)
begin
    if(sel == 0)
        od = a;
    else if(sel == 1)
        od = b;
    else
        od = od;
end
endmodule
