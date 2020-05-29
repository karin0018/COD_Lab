`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/05/27 12:42:37
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
    input [5:0]Op,
    input clk,
    input rst,
    output reg PCWriteCond,
    output reg PCWrite,
    output reg lorD,
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg IRWrite,
    output reg [1:0]PCSource,
    output reg [1:0]ALUOp,
    output reg ALUSrcA,
    output reg [1:0]ALUSrcB,
    output reg RegWrite,
    output reg RegDst
    );
    parameter BEGIN = 3'b000,
               IF = 3'b001,
               ID = 3'b010,
               EX = 3'b011,
               MEM = 3'b100,
               WB = 3'b101;

    parameter op_add = 6'b000000,
              op_addi = 6'b001000,
              op_lw = 6'b100011,
              op_sw = 6'b101011,
              op_beq = 6'b000100,
              op_j = 6'b000010;

    parameter aluop_R = 2'b10,
              aluop_lw = 2'b00,
              aluop_sw = 2'b00,
              aluop_addi = 2'b11,
              aluop_beq = 2'b01;

    reg [2:0] curr_state,next_state;

    always@(posedge clk or posedge rst)
    begin
        if(rst) curr_state <= BEGIN;
        else curr_state <= next_state;
    end

    always@(*)
    begin
        case(curr_state)
            BEGIN:begin next_state = IF; end
            IF:begin next_state = ID; end
            ID:begin next_state = EX; end
            EX:
            begin
                if(Op == op_add || Op == op_addi) next_state = WB;
                else if (Op == op_j || Op == op_beq) next_state = IF;
                else next_state = MEM;
            end
            MEM:
            begin
                if(Op == op_sw) next_state = IF;
                else next_state = WB;
            end
            WB:begin next_state = IF; end
            default next_state = BEGIN;
        endcase
    end

    always@(*)
    begin
        PCWrite = 0;
        PCWriteCond = 0;
        IRWrite = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        ALUSrcA = 0;
        ALUSrcB = 2'b01;
        ALUOp = 2'b00;
        lorD = 0;
        PCSource = 2'b00;
        RegDst = 0; 
             
        case(curr_state)
            BEGIN:;
            IF:
            begin
                PCWrite = 1;
                IRWrite = 1;
            end
            ID:
            begin
//                IRWrite = 1;
                ALUSrcB = 2'b11;
            end
            EX:
            begin
                case(Op)
                    op_add:
                    begin
                        ALUSrcA = 1;
                        ALUSrcB = 2'b00;
                        ALUOp = aluop_R;
                    end
                    op_j:
                    begin
                        PCSource = 2'b10;
                        PCWrite = 1;
                    end
                    op_beq:
                    begin
                        ALUSrcA = 1;
                        ALUSrcB = 2'b00;
                        ALUOp = aluop_beq;
                        PCSource = 1;
                        PCWriteCond = 1;
                        PCWrite = 0;
                    end
                    op_addi:
                    begin
                        ALUSrcA = 1;
                        ALUSrcB = 2'b10;
                        ALUOp = aluop_addi;
                    end
                    op_lw,op_sw:
                    begin
                        ALUSrcA = 1;
                        ALUSrcB = 2'b10;
                        ALUOp = aluop_lw;
                    end
                    default:begin ALUOp = 00; end
                endcase
            end
            MEM:
            begin
                case(Op)
                    op_lw:
                    begin
                        MemRead = 1;
                        lorD = 1;
                    end
                    op_sw:
                    begin
                        MemWrite = 1;
                        lorD = 1;
                    end
                    default:begin MemRead = 0; MemWrite = 0; end
                endcase
            end
            WB:
            begin
                case(Op)
                    op_add,op_addi:
                    begin
                        MemtoReg = 0;
                        RegWrite = 1;
                        RegDst = (Op == op_add)?1:0;
                    end       
                    op_lw:
                    begin
                        RegWrite = 1;
                        RegDst = 0;
                        MemtoReg = 1;
                    end
                    default:begin RegWrite = 0; end
                endcase
            end
            default:begin MemRead = 0; MemWrite = 0; RegWrite = 0;end
        endcase

    end

endmodule
