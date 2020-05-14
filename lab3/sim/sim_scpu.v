`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/13 12:15:07
// Design Name: 
// Module Name: sim_scpu
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


module sim_scpu( );
    reg clk,rst;
    parameter PERIOD = 10;
    parameter CYCLE = 50;
    
    sigle_cpu cpu(.clk(clk),.rst(rst));
    
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
        #(PERIOD)
        rst = 0;
    end

endmodule
