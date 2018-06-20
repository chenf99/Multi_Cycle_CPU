`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 16:41:50
// Design Name: 
// Module Name: IR
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


module IR(
    input [31:0]inputData,
    input IRWre,       //ָ��Ĵ���дʹ���źţ�Ϊ1ʱIR�ɸ���
    input CLK,
    output reg [31:0]outputData
    );
    always @(posedge CLK) begin
        if (IRWre) outputData = inputData;
    end
endmodule
