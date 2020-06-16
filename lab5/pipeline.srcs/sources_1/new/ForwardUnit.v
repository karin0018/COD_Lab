`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 13:16:31
// Design Name: 
// Module Name: ForwardUnit
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


module ForwardUnit(
    input [4:0] RsAddr_id,
    input [4:0] RtAddr_id,
    input [4:0] RsAddr_ex,
    input [4:0] RtAddr_ex,
    input [4:0] RegWriteAddr_mem,
    input [4:0] RegWriteAddr_wb,
    input RegWrite_ex,
    input RegWrite_mem,
    input RegWrite_wb,
    input [4:0] RegWriteAddr_ex,
    input AluSrcB_ex, // ALU �ڶ�����������ѡ���ź� 1 - �Ĵ����в�������0 - ������ imm
    // ����˿�
    output reg [1:0] Forward_A_ex,
    output reg [1:0] Forward_B_ex,
    output reg [1:0] Forward_MemWriteData_ex,
    output reg [1:0] Forward_RegWriteData_A_id,
    output reg [1:0] Forward_RegWriteData_B_id
    );
    
    always@(*)
    begin
    //----------ALU ��������ð��----------//
        // Forward_A_ex
        if (RegWrite_mem && RegWriteAddr_mem && (RegWriteAddr_mem == RsAddr_ex)) 
            Forward_A_ex = 2'b10; // ex ��ð��
        else if (RegWrite_wb && RegWriteAddr_wb && (RegWriteAddr_wb == RsAddr_ex))
            Forward_A_ex = 2'b01; // mem ��ð��
        else 
            Forward_A_ex = 2'b00;
            
        // Forward_B_ex     
        if(AluSrcB_ex == 0)
            Forward_B_ex = 2'b11; // ѡ����������û������ð��
        else if (AluSrcB_ex && RegWrite_mem && RegWriteAddr_mem && (RegWriteAddr_mem == RtAddr_ex))
            Forward_B_ex = 2'b10; // ex ��ð��
        else if (AluSrcB_ex && RegWrite_wb && RegWriteAddr_wb && (RegWriteAddr_wb == RtAddr_ex))
            Forward_B_ex = 2'b01; // mem ��ð��
        else
            Forward_B_ex = 2'b00;
            
    //----------sw д�� memory ������ð��----------//
        if(RegWrite_mem && RegWriteAddr_mem && (RtAddr_ex == RegWriteAddr_mem))
            Forward_MemWriteData_ex = 2'b00; // ex ��ð��
        else if(RegWrite_wb && RegWriteAddr_wb && (RtAddr_ex == RegWriteAddr_wb))
            Forward_MemWriteData_ex = 2'b01; // mem ��ð�� 
        else 
            Forward_MemWriteData_ex = 2'b10; // û��ð��
    
    //----------��ָ֧�������ð��----------//
    
    // Forward_RegWriteData_A_id
        if (RegWrite_ex && RegWriteAddr_ex && (RegWriteAddr_ex == RsAddr_id)) 
            Forward_RegWriteData_A_id = 2'b10; // ex ��ð��
        else if (RegWrite_mem && RegWriteAddr_mem && (RegWriteAddr_mem == RsAddr_id)) 
            Forward_RegWriteData_A_id = 2'b01; // mem ��ð��
        else 
            Forward_RegWriteData_A_id = 2'b00;
            
    // Forward_RegWriteData_B_id
        if (RegWrite_ex && RegWriteAddr_ex && (RegWriteAddr_ex == RtAddr_id)) 
            Forward_RegWriteData_B_id = 2'b10; // ex ��ð��
        else if (RegWrite_mem && RegWriteAddr_mem && (RegWriteAddr_mem == RtAddr_id)) 
            Forward_RegWriteData_B_id = 2'b01; // mem ��ð��
        else 
            Forward_RegWriteData_B_id = 2'b00;            
    end   
endmodule
