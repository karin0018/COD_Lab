`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 21:38:51
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
    output RegDst,
    output Jump,
    output Branch,
    output MemRead,
    output MemtoReg,
    output [2:0]ALUOp,
    output MemWrite,
    output ALUSrc,
    output RegWrite
    );
   parameter op_add   =  6'b000000,
              op_addi = 6'b001000,
              op_lw = 6'b100011,
              op_sw = 6'b101011,
              op_beq = 6'b000100,
              op_j = 6'b000010;
   
   assign RegDst = (Opcode == op_add )? 1:0;
   assign Jump = (Opcode == op_j)? 1:0;
   assign Branch = (Opcode == op_beq)? 1:0;
   assign MemRead = (Opcode == op_lw)? 1:0;
   assign MemtoReg = (Opcode == op_lw)? 1:0;
   
   assign ALUOp[0] = (Opcode == op_beq)? 1:0;
   assign ALUOp[1] = 0;
   assign ALUOp[2] = 0;
   
   assign MemWrite = (Opcode == op_sw)? 1:0;
   assign ALUSrc = (Opcode == op_addi || Opcode == op_lw || Opcode == op_sw)? 1:0;
   assign RegWrite = (Opcode == op_add || Opcode == op_addi || Opcode == op_lw)? 1:0;
   
   
endmodule
