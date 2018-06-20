`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 23:23:49
// Design Name: 
// Module Name: DR
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


//切分数据通路的寄存器,处理延迟
module DR(
    input [31:0]inputData,
    input CLK,
    output reg [31:0]outputData
    );
    always @(negedge CLK) begin
        outputData <= inputData;
    end
endmodule