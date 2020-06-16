`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 13:04:19
// Design Name: 
// Module Name: MEM_WB_Reg
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


module MEM_WB_Reg #(parameter N = 32)
   (input clk,
    input [N-1:0] MemOut_mem,
    input [N-1:0] RTypeWriteBackData_mem,
    input [4:0] RegWriteAddr_mem,
    input RegWrite_mem,
    input MemToReg_mem,
    // Êä³ö¶Ë¿Ú
    output reg [N-1:0] MemOut_wb,
    output reg [N-1:0] RTypeWriteBackData_wb,
    output reg [4:0] RegWriteAddr_wb,
    output reg RegWrite_wb,
    output reg MemToReg_wb
    );
    
    always@(posedge clk)
    begin
        MemOut_wb <= MemOut_mem;
        RTypeWriteBackData_wb <= RTypeWriteBackData_mem;
        RegWriteAddr_wb <= RegWriteAddr_mem;
        RegWrite_wb <= RegWrite_mem;
        MemToReg_wb <= MemToReg_mem;
    end
    
endmodule

