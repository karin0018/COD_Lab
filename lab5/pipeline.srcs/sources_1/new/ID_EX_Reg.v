`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 23:31:43
// Design Name: 
// Module Name: ID_EX_Reg
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


module ID_EX_Reg #(parameter N = 32)
   (input clk,
    input [N-1:0] RegData_A_id,
    input [N-1:0] RegData_B_id,
    input [N-1:0] ImmData_id,
    input [4:0] RsAddr_id,
    input [4:0] RtAddr_id,
    input [4:0] RdAddr_id,
    input RegWrite_id,
    input MemToReg_id,
    input MemWrite_id,
    input MemRead_id,
    input AluSrcB_id,
    input RegDst_id,
    input [1:0] AluOp_id,
    output reg [N-1:0] RegData_A_ex,
    output reg [N-1:0] RegData_B_ex,
    output reg [N-1:0] ImmData_ex,
    output reg [4:0] RsAddr_ex,
    output reg [4:0] RtAddr_ex,
    output reg [4:0] RdAddr_ex,
    output reg RegWrite_ex,
    output reg MemToReg_ex,
    output reg MemWrite_ex,
    output reg MemRead_ex,
    output reg AluSrcB_ex,
    output reg RegDst_ex,
    output reg [1:0] AluOp_ex
    );
    
    always@(posedge clk)
    begin
        RegData_A_ex <=  RegData_A_id;
        RegData_B_ex <= RegData_B_id;
        ImmData_ex <= ImmData_id;
        RsAddr_ex <= RsAddr_id;
        RtAddr_ex <= RtAddr_id;
        RdAddr_ex <= RdAddr_id;
        RegWrite_ex <= RegWrite_id;
        MemToReg_ex <= MemToReg_id;
        MemWrite_ex <= MemWrite_id;
        MemRead_ex <= MemRead_id;
        AluSrcB_ex <= AluSrcB_id;
        RegDst_ex <= RegDst_id;
        AluOp_ex <= AluOp_id;
    end
endmodule
