`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 18:02:05
// Design Name: 
// Module Name: m_cpu
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


module m_cpu(
    input clk,
    input rst
    );
    wire PCWriteCond, PCWrite,lorD,MemRead,MemWrite,MemtoReg,IRWrite,ALUSrcA,RegWrite,RegDst;
    wire PCwe,zero;
    wire [1:0]ALUOp,PCSource,ALUSrcB;
    wire [31:0] pcin,pcout,MemD,extend,Jump_addr,ALU_out,ALU_result,Rd1,Rd2,RA,RB,mdr,sw_data;
    wire [31:0] m0_out,m2_out,m3_out,m4_out,m5_out,ex_sl;
    wire [4:0] m1_out,ins_20_16,ins_25_21;
    wire [5:0] ins_31_26;
    wire [15:0] ins_15_0;
    wire [27:0] shift_out;
    wire [25:0] ins_25_0;
    wire [2:0] ALUm;
    wire [10:0] sw_addr;
    
    assign Jump_addr = pcout[31:28]|shift_out[27:0];
    assign PCwe = PCWrite | (zero & PCWriteCond);
    assign ex_sl = extend << 2;
    assign ins_25_0 = {ins_25_21,ins_20_16,ins_15_0};
    assign sw_addr = 11'b00000001000;
    dist_mem_gen_0 mem_data (.a(m0_out[10:2]),.d(RB),.clk(clk),.dpra(sw_addr[10:2]),.we(MemWrite),.spo(MemD),.dpo(sw_data));
    Ins_Reg insreg (.clk(clk),.rst(rst),.IRWrite(IRWrite),.instruct(MemD),.ins_15_0(ins_15_0),.ins_20_16(ins_20_16),.ins_25_21(ins_25_21),.ins_31_26(ins_31_26));
    Reg_file regfile (.clk(clk),.ra0(ins_25_21),.rd0(Rd1),.ra1(ins_20_16),.rd1(Rd2),.we(RegWrite),.wa(m1_out),.wd(m2_out));
    Register MemDR (.clk(clk),.rst(rst),.data(MemD),.exout(mdr));
    Register RegA (.clk(clk),.rst(rst),.data(Rd1),.exout(RA));
    Register RegB (.clk(clk),.rst(rst),.data(Rd2),.exout(RB));
    Register ALUOut (.clk(clk),.rst(rst),.data(ALU_result),.exout(ALU_out));
    
    PC pc (.clk(clk),.rst(rst),.PCen(PCwe),.pcin(pcin),.ExtOut(pcout));
    
    mux2to1_d32 m0 (.a(pcout),.b(ALU_out),.sel(lorD),.out(m0_out));
    mux2to1_d5 m1 (.a(ins_20_16),.b(ins_15_0[15:11]),.sel(RegDst),.out(m1_out));
    mux2to1_d32 m2 (.a(ALU_out),.b(mdr),.sel(MemtoReg),.out(m2_out));
    mux2to1_d32 m3 (.a(pcout),.b(RA),.sel(ALUSrcA),.out(m3_out));
    mux4to1_d32 m4 (.a(RB),.b(4),.c(extend),.d(ex_sl),.sel(ALUSrcB),.out(m4_out));
    mux3to1_d32 m5 (.a(ALU_result),.b(ALU_out),.c(Jump_addr),.sel(PCSource),.out(pcin));
    
    sign_extend SE (.imm(ins_15_0),.ExtOut(extend));
    shift_left_d25 SL (.addr(ins_25_0),.new_addr(shift_out));
    
    ALU alu (.a(m3_out),.b(m4_out),.y(ALU_result),.m(ALUm),.zf(zero));
    ALUcontrol alu_con (.funct(ins_15_0[5:0]),.ALUOp(ALUOp),.ALUm(ALUm));
    
    ControlUnit CU (.Op(ins_31_26),.clk(clk),.rst(rst),.ALUOp(ALUOp),.PCSource(PCSource),.ALUSrcB(ALUSrcB),.PCWriteCond(PCWriteCond),.PCWrite(PCWrite),.lorD(lorD),.MemRead(MemRead),.MemWrite(MemWrite),.MemtoReg(MemtoReg),.IRWrite(IRWrite),.ALUSrcA(ALUSrcA),.RegWrite(RegWrite),.RegDst(RegDst));
    
    
endmodule
