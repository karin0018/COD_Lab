`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/27 21:53:54
// Design Name: 
// Module Name: mcpu_tb
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


module mcpu_tb();
    reg clk,rst;
    parameter PERIOD = 10;
    parameter CYCLE = 250;
    
    m_cpu cpu(.clk(clk),.rst(rst));
    
    initial 
    begin
        clk = 0;
        repeat (2 * CYCLE)
        #(PERIOD/2) clk = ~clk;
        $finish;
    end
    
    initial
    begin
        rst = 1;
        #(PERIOD * 2)
        rst = 0;
    end
      
endmodule
