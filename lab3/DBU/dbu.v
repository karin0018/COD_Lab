`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/13 18:52:28
// Design Name: 
// Module Name: dbu
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


module dbu(
   input clk,
   input rst,
   input succ, // SW 控制 CPU 执行指令的条数
   input step, // button 单步执行指令 
   input [2:0]sel, // SW2~SW0 查看 CPU 运行的结果
   input m_rf, // SW3 1, 查看 MEM，0，查看 RF
   input inc, // button m_rf_addr +1
   input dec,  // button m_rf_addr -1
   output [7:0]SEG, // 数码管显示十六进制数字
   output reg [7:0]AN, // 片选信号
   output reg [15:0]led // led 灯显示
    );
    wire [31:0]m_data,rf_data;
    wire Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUSrc,zero;
    wire [2:0]ALUOp;
    wire [31:0]pc_in,pc_out,instr,rf_rd1,rf_rd2,alu_y,m_rd ;
    wire run;
    reg [7:0]m_rf_addr;
    reg [31:0]test_data;
    
    wire step_edge,inc_edge,dec_edge;
    
    //数码管扫描信号
    reg [2:0] cntsel;
    reg [19:0]cnt;
    wire pulse_cnt;
    wire [7:0]seg;
    reg [3:0] data;
    
    assign SEG = seg;
    
    sigle_cpu cpu(.clk(clk&run),.rst(rst),.m_rf_addr(m_rf_addr),.m_data(m_data),.rf_data(rf_data),.Jump(Jump),.Branch(Branch),.RegDst(RegDst),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOp(ALUOp),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite),.zero(zero),.pc_in(pc_in),.pc_out(pc_out),.instr(instr),.rf_rd1(rf_rd1),.rf_rd2(rf_rd2),.alu_y(alu_y),.m_rd(m_rd));
    
    // 按键信号取边沿
    signal_edge step_out(.clk(clk),.button(step),.button_redge(step_edge)); 
    signal_edge inc_out(.clk(clk),.button(inc),.button_redge(inc_edge)); 
    signal_edge dec_out(.clk(clk),.button(dec),.button_redge(dec_edge)); 
    
    //----------控制 CPU 运行方式----------//
    assign run = step_edge|succ;
    
    //---------- sel 查看 CPU 运行结果----------//
    
    reg [7:0]new_m_rf_addr;
    always@(posedge clk or posedge rst)
    begin
        if(rst) m_rf_addr <= 0;
        else m_rf_addr <= new_m_rf_addr;
    end
    
    // 组合逻辑实现 sel 控制信号的对应功能
    always@(*)
    begin
        if(rst)
        begin
            test_data = 0;
        end
        else 
        begin
            case(sel)
                3'b000:
                begin
                    led[7:0] = m_rf_addr; // led 显示
                    led[15:8] = 0;
                    if(m_rf) begin test_data = m_data; end
                    else if (~m_rf) begin test_data = rf_data;end
                    else test_data = 0;
                    
                    if(inc_edge && ~dec_edge) new_m_rf_addr =  m_rf_addr + 1;
                    else if (~inc_edge && dec_edge) new_m_rf_addr =  m_rf_addr - 1;
                    else new_m_rf_addr = m_rf_addr;
                end
                3'b001:
                begin
                    led[12:0] = {Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
                    led[15:13] = 0;
                    test_data = pc_in;
                end
                3'b010:
                begin
                    led[12:0] = {Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
                    led[15:13] = 0;
                    test_data = pc_out;
                end
                3'b011:
                begin
                    led[12:0] = {Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
                    led[15:13] = 0;
                    test_data = instr;
                end
                3'b100:
                begin
                    led[12:0] = {Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
                    led[15:13] = 0;
                    test_data = rf_rd1;
                end
                3'b101:
                begin
                    led[12:0] = {Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
                    led[15:13] = 0;
                    test_data = rf_rd2;
                end
                3'b110:
                begin
                    led[12:0] = {Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
                    led[15:13] = 0;
                    test_data = alu_y;
                end
                3'b111:
                begin
                    led[12:0] = {Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
                    led[15:13] = 0;
                    test_data = m_rd;
                end
                default:
                begin
                    led[12:0] = {Jump,Branch,RegDst,RegWrite,MemRead,MemtoReg,MemWrite,ALUOp,ALUSrc,zero};
                    led[15:13] = 0;
                    test_data = 0;
                end
            endcase
        end
    end
    
    //----------数码管扫描部分：显示十六进制数据----------//
    always @(posedge clk)
    begin
        if (rst)
            cnt <= 20'b0;
        else if(cnt == 20'h186a0)//设定扫描频率 10^5
            cnt <= 20'b0;
        else
            cnt <= cnt + 20'b1;
    end
    assign pulse_cnt = (cnt == 20'b1)? 1'b1:1'b0;
    always @(posedge clk)
    begin
        if (rst)
            cntsel <= 0;
        if(pulse_cnt)
            cntsel <= cntsel + 3'b01;
    end
    
    dist_mem_gen_2 dist_mem_2(
    .a(data),
    .spo(seg)
    );
    
    always @(posedge clk)
    begin
            case(cntsel)
                3'h0:AN     <= 8'b1111_1110;
                3'h1:AN     <= 8'b1111_1101;
                3'h2:AN     <= 8'b1111_1011;
                3'h3:AN     <= 8'b1111_0111;
                3'h4:AN     <= 8'b1110_1111;
                3'h5:AN     <= 8'b1101_1111;
                3'h6:AN     <= 8'b1011_1111;
                3'h7:AN     <= 8'b0111_1111;
                default: AN <= 8'b11;
            endcase
    end
    
    always @(posedge clk)
    begin
            case(cntsel)
                3'h0:data   <= test_data[3:0];
                3'h1:data   <= test_data[7:4];
                3'h2:data   <= test_data[11:8];
                3'h3:data   <= test_data[15:12];
                3'h4:data   <= test_data[19:16];
                3'h5:data   <= test_data[23:20];
                3'h6:data   <= test_data[27:24];
                3'h7:data   <= test_data[31:28];
                default: data <= 32'b0;
            endcase
    end    
       
endmodule
