`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 19:15:37
// Design Name: 
// Module Name: pipeline_tb
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


module pipeline_tb();
    reg clk,rst;
    parameter PERIOD = 10;
    parameter CYCLE = 250;
    
    Top_CPU pipeline(.clk(clk),.rst(rst));
    
    initial 
    begin
        clk = 1;
        repeat (2 * CYCLE)
        #(PERIOD/2) clk = ~clk;
        $finish;
    end
    
    initial
    begin
        rst = 1;
        #(PERIOD * 10)
        rst = 0;
    end
      
endmodule

