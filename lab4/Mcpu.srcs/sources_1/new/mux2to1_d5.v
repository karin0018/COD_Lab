`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 11:42:55
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
   (output [N-1:0]out,
   input [N-1:0 ]a,b, // 输入数据
   input sel // 选择位
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