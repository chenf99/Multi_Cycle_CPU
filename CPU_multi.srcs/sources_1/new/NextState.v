`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 20:29:42
// Design Name: 
// Module Name: NextState
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

//控制单元子模块，用于产生下一状态

/*	000-IF
	001-ID
	010-EXE
	011-WB
	100-MEM	
*/

module NextState(
    input [2:0]inputState,
    input [5:0]opcode,  //用于区分指令
    output reg [2:0]outputState
    );
    always @(inputState or opcode) begin
        case (inputState)
            3'b000 : outputState = 3'b001;      //IF状态的下一状态为ID
            3'b001 : begin
                if (opcode[5:3] == 3'b111) outputState = 3'b000;	//j,jal,jr,halt
				else outputState = 3'b010;		//add,sub,addi等指令
            end
			3'b010 : begin
				if (opcode[5:1] == 5'b11000) outputState = 3'b100;	//sw,lw
				else if (opcode == 6'b110100 || opcode == 6'b110110) outputState = 3'b000;	//beq,bltz
				else outputState = 3'b011;	//add,sub等指令
			end
			3'b011 : outputState = 3'b000;
			3'b100 : begin
				if (opcode[0] == 1'b1) outputState = 3'b011;	//lw
				else outputState = 3'b000;		//sw
			end
        endcase
    end
endmodule
