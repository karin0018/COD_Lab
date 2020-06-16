`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 20:43:20
// Design Name: 
// Module Name: HazardDetection
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


module HazardDetection(
    input [4:0] RsAddr_id,
    input [4:0] RtAddr_id,
    input [4:0] RtAddr_ex,
    input MemRead_ex,
    // 输出端口
    output PCEn,
    output IF_ID_En,
    output NOP
    );

    assign NOP = ((RsAddr_id == RtAddr_ex) || (RtAddr_id == RtAddr_ex)) && MemRead_ex; // NOP == 1 插入流水线气泡
    assign PCEn = ~NOP; // 流水线阻塞1，指令不再更新
    assign IF_ID_En = ~NOP; // 流水线阻塞2，段间寄存器不再更新
    
endmodule
