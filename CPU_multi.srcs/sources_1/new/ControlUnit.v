`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/13 10:09:51
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(opcode, CLK, RST, zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
	input [5:0]opcode;
	input CLK, RST;
	input zero, sign;
	output PCWre, ALUSrcA, ALUSrcB, DBDataSrc;
	output RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel;
	output [1:0]PCSrc, RegDst;
	output [2:0]ALUOp;
	
	wire [2:0] inputState, outputState;
	
	DFlipFlop dff(inputState, RST, CLK, outputState);
	NextState ns(outputState, opcode, inputState);
	OutputFunc of(outputState, opcode, zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
	
endmodule
