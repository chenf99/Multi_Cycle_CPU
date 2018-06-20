`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/13 10:29:35
// Design Name: 
// Module Name: CPU
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


module CPU(
	input CLK,
	input RST,
	output [31:0]nowPC,
	output [31:0]nextPC,
	output [4:0]rs,
	output [4:0]rt,
	output [31:0]ReadData1,
	output [31:0]ReadData2,
	output [31:0]ALUresult,
	output [31:0]DB
    );
	
	//$31
	parameter reg31 = 5'b11111;
	
	wire [31:0]nextPC, PC4, jumpPC, comparePC;
	wire [31:0]instruction, inputIR, inputADR, inputBDR, inputALUDR, inputDBDR;
	wire [31:0]A, B;
	wire [31:0]extendImmediate;
	wire [31:0]DataOut;
	wire [31:0]writeData;
	
	wire [5:0]opcode;
	wire [4:0]rd;
	wire [2:0]ALUOp;
	wire [1:0]PCSrc, RegDst;
	wire [4:0]writeReg;
	wire zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel;
	
	assign opcode = instruction[31:26];
	assign rs = instruction[25:21];
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];
	
	assign PC4 = nowPC + 4;
	assign comparePC = PC4 + (extendImmediate << 2);
	assign jumpPC[31:28] = PC4[31:28];
	assign jumpPC[27:2] = instruction[25:0];
	assign jumpPC[1:0] = 2'b00;
	
	ControlUnit cu(opcode, CLK, RST, zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
	PC pc(CLK, RST, PCWre, nextPC, nowPC);
	InstructionMemory im(InsMemRW, nowPC, inputIR);
	IR ir(inputIR, IRWre, CLK, instruction);
	RegWre_MUX rwm(RegDst, reg31, rt, rd, writeReg);
	Select2_MUX wreData_mux(WrRegDSrc, PC4, DB, writeData);
	RegFile rg(CLK, RegWre, rs, rt, writeReg, writeData, inputADR, inputBDR);
	SignZeroExtend sze(ExtSel, instruction[15:0], extendImmediate);
	DR aDR(inputADR, CLK, ReadData1);
	DR bDR(inputBDR, CLK, ReadData2);
	ALU_A_MUX A_mux(ALUSrcA, ReadData1, instruction[10:6], A);
	Select2_MUX B_mux(ALUSrcB, ReadData2, extendImmediate, B);
	ALU alu(ALUOp, A, B, inputALUDR, zero, sign);
	DR aluDR(inputALUDR, CLK, ALUresult);
	PCAddress_MUX pcm(PCSrc, PC4, comparePC, inputADR, jumpPC, nextPC);
	DataMemory dm(CLK, ALUresult, ReadData2, mRD, mWR, DataOut);
	Select2_MUX DB_mux(DBDataSrc, inputALUDR, DataOut, inputDBDR);
	DBDR dbDR(inputDBDR, CLK, DB);
endmodule