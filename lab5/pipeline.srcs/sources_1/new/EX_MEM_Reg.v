`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 12:53:03
// Design Name: 
// Module Name: EX_MEM_Reg
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


module EX_MEM_Reg #(parameter N = 32)
   (input clk,
    input [N-1:0] AluOut_ex,
    input [N-1:0] MemWriteData_ex,
    input [4:0] RegWriteAddr_ex,
    input RegWrite_ex,
    input MemToReg_ex,
    input MemWrite_ex,
    input MemRead_ex,
    // Êä³ö¶Ë¿Ú
    output reg [N-1:0] AluOut_mem,
    output reg [N-1:0] MemWriteData_mem,
    output reg [4:0] RegWriteAddr_mem,
    output reg RegWrite_mem,
    output reg MemToReg_mem,
    output reg MemWrite_mem,
    output reg MemRead_mem
    );
    
    always@(posedge clk)
    begin
        AluOut_mem <= AluOut_ex;
        MemWriteData_mem <= MemWriteData_ex;
        RegWriteAddr_mem <= RegWriteAddr_ex;
        RegWrite_mem <= RegWrite_ex;
        MemToReg_mem <= MemToReg_ex;
        MemWrite_mem <= MemWrite_ex;
        MemRead_mem <= MemRead_ex;
    end
    
endmodule
