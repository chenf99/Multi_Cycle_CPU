`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/12 14:48:39
// Design Name: 
// Module Name: OutputFunc
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

//输出函数模块，用来产生各种控制信号
module OutputFunc(state, opcode, zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUOp);
	input [2:0]state;
	input [5:0]opcode;
	input zero, sign;
	output reg PCWre, ALUSrcA, ALUSrcB, DBDataSrc;
	output reg RegWre, WrRegDSrc, InsMemRW, mRD, mWR, IRWre, ExtSel;
	output reg [1:0]PCSrc, RegDst;
	output reg [2:0]ALUOp;
	
	parameter [2:0] IF = 3'b000, ID = 3'b001, EXE = 3'b010, WB = 3'b011, MEM = 3'b100;
	parameter [5:0] add = 6'b000000, sub = 6'b000001, addi = 6'b000010;
	parameter [5:0] Or = 6'b010000, And = 6'b010001, ori = 6'b010010;
	parameter [5:0] sll = 6'b011000, slt = 6'b100110, sltiu = 6'b100111;
	parameter [5:0] sw = 6'b110000, lw = 6'b110001, beq = 6'b110100;
	parameter [5:0] bltz = 6'b110110, j = 6'b111000, jr = 6'b111001;
	parameter [5:0] jal = 6'b111010, halt = 6'b111111;
	
	always @(state) begin
		//对PCWre定值
		if (state == IF && opcode != halt) PCWre = 1;
		else PCWre = 0;
		//对ALUSrcA定值
		if (opcode == sll) ALUSrcA = 1;
		else ALUSrcA = 0;
		//对ALUSrcB定值
		if (opcode == addi || opcode == ori || opcode == sltiu || 
			opcode == sw || opcode == lw) ALUSrcB = 1;
		else ALUSrcB = 0;
		//对DBDataSrc定值
		if (opcode == lw) DBDataSrc = 1;
		else DBDataSrc = 0;
		//对RegWre定值
		if (state == WB || opcode == jal) RegWre = 1;
		else RegWre = 0;
		//对WrRegDst定值
		if (state == WB) WrRegDSrc = 1;
		else WrRegDSrc = 0;
		//对InsMemRW定值
		InsMemRW = 0;
		//对mRD定值
		if (opcode == lw && state == MEM) mRD = 0;
		else mRD = 1;
		//对mWR定值
		if (opcode == sw && state == MEM) mWR = 0;
		else mWR = 1;
		//对IRWre定值
		if (state == IF) IRWre = 1;
		else IRWre = 0;
		//对ExtSel定值
		if (opcode == ori || opcode == sltiu) ExtSel = 0;
		else ExtSel = 1;
		//对PCSrc定值
		case (opcode) 
			j : PCSrc = 2'b11;
			jr : PCSrc = 2'b10;
			jal : PCSrc = 2'b11;
			beq : begin
				if (zero == 0) PCSrc = 2'b00;
				else PCSrc = 2'b01;
			end
			bltz : begin
				if (zero == 0 && sign == 1) PCSrc = 2'b01;
				else PCSrc = 2'b00;
			end
			default : PCSrc = 2'b00;
		endcase
		//对RegDst定值
		if (opcode == jal) RegDst = 2'b00;
		else if (opcode == addi || opcode == ori || opcode == sltiu || opcode == lw) RegDst = 2'b01;
		else RegDst = 2'b10;
		//对ALUOp定值
		case (opcode)
			add : ALUOp = 3'b000;
			sub : ALUOp = 3'b001;
			addi : ALUOp = 3'b000;
			Or : ALUOp = 3'b101;
			And : ALUOp = 3'b110;
			ori : ALUOp = 3'b101;
			sll : ALUOp = 3'b100;
			slt : ALUOp = 3'b011;
			sltiu : ALUOp = 3'b010;
			sw : ALUOp = 3'b000;
			lw : ALUOp = 3'b000;
			beq : ALUOp = 3'b001;
			bltz : ALUOp = 3'b001;
		endcase
		//防止在IF阶段写存储器
		if (state == IF) RegWre = 0;
	end
endmodule
