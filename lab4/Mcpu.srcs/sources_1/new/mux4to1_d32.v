`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 11:46:23
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
   (output [N-1:0]out,
   input [N-1:0 ]a,b,c,d, // 输入数据
   input [1:0]sel // 选择位
    );
reg [N-1:0]od;
assign out = od;
always @(*)
begin
    if(sel == 2'b00)
        od = a;
    else if(sel == 2'b01)
        od = b;
    else if(sel == 2'b10)
        od = c;
    else if(sel == 2'b11)
        od = d;
    else 
        od = od;
end
endmodule
