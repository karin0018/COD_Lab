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


/*--- ALU 代码实现 ---*/
module ALU #(parameter WIDTH = 32) // 数据宽度
    (output reg [WIDTH-1:0]y, // 输出运算结果
     output reg zf, // 零标志
     output reg cf, // 进位/借位标志
     output reg of, // 溢出标志
     input [WIDTH-1:0]a,b, // 两个操作数
     input [2:0]m // 操作类型
    );

always@(*)
begin
  cf=1'b0;
  zf=1'b0;
  of=1'b0;
  case(m)
    3'b000:// 加法
    begin
      {cf,y} = a + b;
      of = (~a[WIDTH-1]&~b[WIDTH-1]&y[WIDTH-1])|(a[WIDTH-1]&b[WIDTH-1]&~y[WIDTH-1]);
    end
    3'b001:// 减法
    begin
      {cf,y} = a - b;
      of = (a[WIDTH-1]&~b[WIDTH-1]&~y[WIDTH-1])|(a[WIDTH-1]&~b[WIDTH-1]&~y[WIDTH-1]);
    end
    3'b010: // 按位与
    begin
      y = a & b;
    end
    3'b011:// 按位或
    begin
      y = a | b;
    end
    3'b100:// 按位异或
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
  zf = ~|y; // 规约或非
end
endmodule

