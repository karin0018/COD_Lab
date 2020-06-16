`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 13:16:50
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [5:0]Opcode,
    output Jump,
    output Branch,
    output MemRead,
    output MemWrite,
    output RegDst,
    output reg [1:0]AluOp,
    output AluSrcB,
    output MemtoReg,
    output RegWrite
    );
    parameter  op_add   = 6'b000000,
               op_addi  = 6'b001000,
               op_lw    = 6'b100011,
               op_sw    = 6'b101011,
               op_beq   = 6'b000100,
               op_j     = 6'b000010;
               
    parameter  aluop_R  = 2'b10,
               aluop_lw = 2'b00, 
               aluop_sw = 2'b00,
               aluop_addi = 2'b11,
               aluop_beq  = 2'b01;
     
    assign RegDst = (Opcode == op_add )? 1:0;
    assign Jump = (Opcode == op_j)? 1:0;
    assign Branch = (Opcode == op_beq)? 1:0;
    assign MemRead = (Opcode == op_lw)? 1:0;
    assign MemtoReg = (Opcode == op_lw)? 0:1;
    
    assign MemWrite = (Opcode == op_sw)? 1:0;
    assign AluSrcB = (Opcode == op_addi || Opcode == op_lw || Opcode == op_sw)? 0:1; // AluSrcB == 0 Ñ¡ÔñÁ¢¼´Êý
    assign RegWrite = (Opcode == op_add || Opcode == op_addi || Opcode == op_lw)? 1:0; 
    
    always@(*)
    begin
        case(Opcode)
            op_add: AluOp = aluop_R;
            op_lw: AluOp = aluop_lw;
            op_sw: AluOp = aluop_sw;
            op_addi: AluOp = aluop_addi;
            op_beq: AluOp = aluop_beq;
            default:AluOp = 0;
        endcase
    end
    
endmodule