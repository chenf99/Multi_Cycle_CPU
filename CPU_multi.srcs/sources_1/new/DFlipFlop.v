`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 20:20:42
// Design Name: 
// Module Name: DFlipFlop
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

//控制单元的子模块,用于保存当前状态
module DFlipFlop(
    input [2:0]inputState,
    input RST,
    input CLK,
    output reg [2:0]outputState
    );
    always @(posedge CLK) begin
        if (RST == 0) outputState <= 0;
        else outputState <= inputState;
    end
endmodule
