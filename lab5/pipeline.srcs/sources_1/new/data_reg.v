`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/13 00:55:25
// Design Name: 
// Module Name: data_reg
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


module data_reg #(parameter WIDTH = 32)
   (input clk,
    input en,
    input rst,
    input [WIDTH-1:0] datain,
    output reg [WIDTH-1:0] dataout
    );
    always@(posedge clk or posedge rst)
    begin
        if(rst)
            dataout = 0;
        else if(en)
            dataout = datain;
        else
            dataout = dataout;
    end
endmodule
