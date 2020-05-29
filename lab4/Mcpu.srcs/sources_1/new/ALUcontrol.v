`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 11:55:28
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(
    input [5:0]funct,
    input [1:0]ALUOp,
    output reg [2:0]ALUm
    );
    
always@(*)
begin
    case(ALUOp)
        2'b10: // R-type
        begin
            if(funct == 6'b100000) ALUm = 3'b000; // add
            else ALUm = 0;
        end
        2'b00:begin ALUm = 3'b000; end // I-type lw/sw
        2'b01:begin ALUm = 3'b001; end // I-type beq
        2'b11:begin ALUm = 3'b000; end // I-type addi
        default: ALUm = 0;
    endcase
end
endmodule
