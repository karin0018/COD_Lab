`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/06/13 13:17:25
// Design Name:
// Module Name: Top_CPU
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


module Top_CPU #(parameter N = 32)
   (input rst,
    input clk
    );

    wire PCen,Jump,Branch,Zero,RegDst,AluSrcB,RegWrite,MemToReg,MemRead,MemWrite,NOP;
    wire AluSrcB_ex,RegDst_ex,MemRead_ex,MemWrite_ex,RegWrite_ex,MemToReg_ex,RegWrite_mem,MemToReg_mem,MemRead_mem,MemWrite_mem,RegWrite_wb,MemToReg_wb;
    wire [1:0] AluOp,AluOp_ex;
    //----------IF 段----------//
    wire [N-1:0] PC4,PCin,PCout,Instruct,NotJumpAddr,JumpAddr,BranchAddr;
    wire IF_ID_En,IF_Flush,PCSrc;
    wire RegWrite_id,MemToReg_id,MemWrite_id,MemRead_id,AluSrcB_id,RegDst_id;
    wire [1:0] AluOp_id;

    assign PCSrc = ~(Branch & Zero);
    assign IF_Flush = (Branch & Zero & !NOP) | Jump;
    // 流水线气泡
    assign RegWrite_id = ~NOP & RegWrite;
    assign MemToReg_id = ~NOP & MemToReg;
    assign MemWrite_id = ~NOP & MemWrite;
    assign MemRead_id = ~NOP & MemRead;
    assign AluSrcB_id = ~NOP & AluSrcB;
    assign RegDst_id = ~NOP & RegDst;
    assign AluOp_id = ~NOP & AluOp;

    //---------- ID & EX 段----------//
    wire [N-1:0] NPC,IR,RegData_A,RegData_B,RegData_A_id,RegData_B_id,ImmData_id,BranchImm;
    wire [4:0] RsAddr_ex,RtAddr_ex,RdAddr_ex,RegWriteAddr_ex;
    wire [N-1:0] RegData_A_ex,RegData_B_ex,ImmData_ex;
    wire [N-1:0] AluDataA,AluDataB,AluOut_ex, MemWriteData_ex;
    wire [2:0] AluCon;
    wire [1:0] Forward_A_ex,Forward_B_ex,Forward_MemWriteData_ex,Forward_RegWriteData_A_id,Forward_RegWriteData_B_id;
    wire [27:0] shift_out;
    wire [5:0] Funct,Op;
    wire [4:0] Shamt;
    wire [15:0] IMM16;
    wire [4:0] Rd,Rs,Rt;

    assign JumpAddr = NPC[31:28]|shift_out[27:0];
    assign Funct = IR[5:0];
    assign Shamt = IR[10:6];
    assign IMM16 = IR[15:0];
    assign Rd = IR[15:11];
    assign Rt = IR[20:16];
    assign Rs = IR[25:21];
    assign Op = IR[31:26];
    assign BranchImm[15:0] = IMM16;
    assign BranchImm[31:16] = 16'h0000;
    
    //----------MEM 段---------//
    wire [N-1:0] AluOut_mem,MemWriteData_mem,MemOut_mem;
    wire [4:0] RegWriteAddr_mem;
    //--------WB 段----------//
    wire [N-1:0] MemOut_wb,RTypeWriteBackData_wb,RegWriteData_wb;
    wire [4:0] RegWriteAddr_wb;

    //========== IF 段数据通路 ==========//

    PC pc_0(.clk(clk),.rst(rst),.PCen(PCen),.PCout(PCout),.PCin(PCin));
    mux2to1_d32 mux0(.a(NotJumpAddr),.b(JumpAddr),.sel(Jump),.out(PCin));
    mux2to1_d32 mux1(.a(BranchAddr),.b(PC4),.sel(PCSrc),.out(NotJumpAddr)); // 分支地址选择
    ADD add_0(.out(PC4),.a(PCout),.b(4)); // PC + 4
    shift_left left2_0(.addr(IR[25:0]),.new_addr(shift_out));
    IF_ID_Reg reg_ifid(.PC4(PC4),.Instruct(Instruct),.en(IF_ID_En),.clk(clk),.rst(rst),.Flush(IF_Flush),.NPC(NPC),.IR(IR));

    //========== ID 段数据通路 ==========//

    RegFile reg_file(.clk(clk),.ra0(Rs),.rd0(RegData_A),.ra1(Rt),.rd1(RegData_B),.we(RegWrite_wb),.wa(RegWriteAddr_wb),.wd(RegWriteData_wb));
    SignExtend sign_extend(.imm(IMM16),.extend(ImmData_id));
    ADD add_1(.out(BranchAddr),.b(NPC),.a(BranchImm << 2));
    EQUAL judge_equal(.zero(Zero),.a(RegData_A_id),.b(RegData_B_id));
    ControlUnit con_uni(.Opcode(Op),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),.MemWrite(MemWrite),.RegDst(RegDst),.AluOp(AluOp),.AluSrcB(AluSrcB),.MemtoReg(MemToReg),.RegWrite(RegWrite));
    HazardDetection hazard(.RsAddr_id(Rs),.RtAddr_id(Rt),.RtAddr_ex(RtAddr_ex),.MemRead_ex(MemRead_ex),.PCEn(PCen),.IF_ID_En(IF_ID_En),.NOP(NOP));
    ID_EX_Reg reg_idex(.clk(clk),.RegData_A_id(RegData_A_id),.RegData_B_id(RegData_B_id),.ImmData_id(ImmData_id),.RsAddr_id(Rs),.RtAddr_id(Rt),.RdAddr_id(Rd),.RegWrite_id(RegWrite_id),.MemToReg_id(MemToReg_id),.MemWrite_id(MemWrite_id),.MemRead_id(MemRead_id),.AluSrcB_id(AluSrcB_id),.RegDst_id(RegDst_id),.AluOp_id(AluOp_id),.RegData_A_ex(RegData_A_ex),.RegData_B_ex(RegData_B_ex),.ImmData_ex(ImmData_ex),.RsAddr_ex(RsAddr_ex),.RtAddr_ex(RtAddr_ex),.RdAddr_ex(RdAddr_ex),.RegWrite_ex(RegWrite_ex),.MemToReg_ex(MemToReg_ex),.MemWrite_ex(MemWrite_ex),.MemRead_ex(MemRead_ex),.AluSrcB_ex(AluSrcB_ex),.RegDst_ex(RegDst_ex),.AluOp_ex(AluOp_ex));
    mux3to1_d32 mux7(.out(RegData_A_id),.a(RegData_A),.b(MemOut_mem),.c(AluOut_ex),.sel(Forward_RegWriteData_A_id));
    mux3to1_d32 mux8(.out(RegData_B_id),.a(RegData_B),.b(MemOut_mem),.c(AluOut_ex),.sel(Forward_RegWriteData_B_id));
    
    //========== EX 段数据通路 ==========//

    ForwardUnit funit(.RsAddr_id(Rs),.RtAddr_id(Rt),.RsAddr_ex(RsAddr_ex),.RtAddr_ex(RtAddr_ex),.RegWriteAddr_mem(RegWriteAddr_mem),.RegWriteAddr_wb(RegWriteAddr_wb),.RegWrite_ex(RegWrite_ex),.RegWrite_mem(RegWrite_mem),.RegWrite_wb(RegWrite_wb),.RegWriteAddr_ex(RegWriteAddr_ex),.AluSrcB_ex(AluSrcB_ex),.Forward_A_ex(Forward_A_ex),.Forward_B_ex(Forward_B_ex),.Forward_MemWriteData_ex(Forward_MemWriteData_ex),.Forward_RegWriteData_A_id(Forward_RegWriteData_A_id),.Forward_RegWriteData_B_id(Forward_RegWriteData_B_id));
    mux2to1_d5 mux2(.out(RegWriteAddr_ex),.a(RtAddr_ex),.b(RdAddr_ex),.sel(RegDst_ex));
    mux3to1_d32 mux3(.out(AluDataA),.a(RegData_A_ex),.b(RegWriteData_wb),.c(AluOut_mem),.sel(Forward_A_ex));
    mux4to1_d32 mux4(.out(AluDataB),.a(RegData_B_ex),.b(RegWriteData_wb),.c(AluOut_mem),.d(ImmData_ex),.sel(Forward_B_ex));
    mux3to1_d32 mux5(.out(MemWriteData_ex),.a(AluOut_mem),.b(RegWriteData_wb),.c(RegData_B_ex),.sel(Forward_MemWriteData_ex));
    AluControl alu_con(.ALUm(AluCon),.funct(ImmData_ex[5:0]),.ALUOp(AluOp_ex));
    ALU alu0(.y(AluOut_ex),.a(AluDataA),.b(AluDataB),.m(AluCon));
    EX_MEM_Reg reg_exmem(.clk(clk),.AluOut_ex(AluOut_ex),.MemWriteData_ex(MemWriteData_ex),.RegWriteAddr_ex(RegWriteAddr_ex),.RegWrite_ex(RegWrite_ex),.MemToReg_ex(MemToReg_ex),.MemWrite_ex(MemWrite_ex),.MemRead_ex(MemRead_ex),.AluOut_mem(AluOut_mem),.MemWriteData_mem(MemWriteData_mem),.RegWriteAddr_mem(RegWriteAddr_mem),.RegWrite_mem(RegWrite_mem),.MemToReg_mem(MemToReg_mem),.MemWrite_mem(MemWrite_mem),.MemRead_mem(MemRead_mem));

    //========== MEM 段数据通路 ==========//
    
    MEM_WB_Reg reg_memwb(.clk(clk),.MemOut_mem(MemOut_mem),.RTypeWriteBackData_mem(AluOut_mem),.RegWriteAddr_mem(RegWriteAddr_mem),.RegWrite_mem(RegWrite_mem),.MemToReg_mem(MemToReg_mem),.MemOut_wb(MemOut_wb),.RTypeWriteBackData_wb(RTypeWriteBackData_wb),.RegWriteAddr_wb(RegWriteAddr_wb),.RegWrite_wb(RegWrite_wb),.MemToReg_wb(MemToReg_wb));

    //========== WB 段数据通路 ==========//

    mux2to1_d32 mux6(.out(RegWriteData_wb),.a(MemOut_wb),.b(RTypeWriteBackData_wb),.sel(MemToReg_wb));

    //---------- 指令和数据寄存器 ----------//

    wire [31:0] sw_rd = 16'h0008;
    wire [31:0] sw_data;
    dist_mem_gen_ins ins(.clk(clk),.a(PCout[9:2]),.spo(Instruct));
    dist_mem_gen_mem mem(.clk(clk),.a(AluOut_mem[9:2]),.d(MemWriteData_mem),.dpra(sw_rd[9:2]),.dpo(sw_data),.we(MemWrite_mem),.spo(MemOut_mem));



endmodule
