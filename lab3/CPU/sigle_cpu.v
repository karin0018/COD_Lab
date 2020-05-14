`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/12 23:18:41
// Design Name: 
// Module Name: sigle_cpu
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


module sigle_cpu(
    input clk,
    input rst,
    input [7:0]m_rf_addr,
    output [31:0]m_data,
    output [31:0]rf_data,
    // dbu -- status 
    output Jump,
    output Branch,
    output RegDst,
    output RegWrite,
    output MemRead,
    output MemtoReg,
    output MemWrite,
    output ALUSrc,
    output zero,
    output [2:0]ALUOp,
    output [31:0]pc_in,
    output [31:0]pc_out,
    output [31:0]instr,
    output [31:0]rf_rd1,
    output [31:0]rf_rd2,
    output [31:0]alu_y,
    output [31:0]m_rd
    );
    wire [31:0] pin,pout,pc_4,instruct,extend,Jump_addr,Add_out,ALU_result,Rd1,Rd2,mem_Rd,WRd;
    wire [31:0] m3_out,m1_out;
    wire [27:0] shift_out;
    wire [4:0] WR;
    wire [2:0]ALU_con;
    
    assign Jump_addr = pc_4[31:28]|shift_out[27:0];
     
    assign pc_in = pin;
    assign pc_out = pout;
    assign instr = instruct;
    assign rf_rd1 = Rd1;
    assign rf_rd2 = Rd2;
    assign alu_y = ALU_result;
    assign m_rd = mem_Rd;
    
    PC pc_0 (.pcin(pin),.ExtOut(pout),.clk(clk),.rst(rst));
    
    mux2to1_d5 mux0 (.a(instruct[20:16]),.b(instruct[15:11]),.sel(RegDst),.out(WR));
    mux2to1_d32 mux1(.a(Rd2),.b(extend),.sel(ALUSrc),.out(m1_out));
    mux2to1_d32 mux3 (.a(pc_4),.b(Add_out),.sel(Branch&zero),.out(m3_out));
    mux2to1_d32 mux4 (.a(m3_out),.b(Jump_addr),.sel(Jump),.out(pin));
    mux2to1_d32 mux2 (.a(ALU_result),.b(mem_Rd),.sel(MemtoReg),.out(WRd));  
    
    dist_mem_gen_0 instuctions (.a(pout[9:2]),.spo(instruct));    
    RegFile reg_file (.ra0(instruct[25:21]),.ra1(instruct[20:16]),.ra2(m_rf_addr),.wa(WR),.wd(WRd),.rd0(Rd1),.rd1(Rd2),.rd2(rf_data),.clk(clk),.we(RegWrite));
    dist_mem_gen_1 DataMem (.a(ALU_result[9:2]),.dpra(m_rf_addr),.d(Rd2),.we(MemWrite),.spo(mem_Rd),.dpo(m_data),.clk(clk)); // ×Ö½ÚÑ°Ö·

    ControlUnit CU (.Opcode(instruct[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOp(ALUOp),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite));
    
    shift_left shift(.addr(instruct[25:0]),.new_addr(shift_out));
    sign_extend new_sign (.imm(instruct[15:0]),.ExtOut(extend));
    
    ALU Add (.a(4),.b(pout),.m(3'b000),.y(pc_4));
    ALU Add_branch (.a(pc_4),.b(extend<<2),.m(3'b000),.y(Add_out));
    ALU ALU_0 (.a(Rd1),.b(m1_out),.m(ALU_con),.y(ALU_result),.zf(zero));    
    ALUcontrol alu_control (.funct(instruct[5:0]),.ALUOp(ALUOp),.opcode(ALU_con));
     
endmodule
