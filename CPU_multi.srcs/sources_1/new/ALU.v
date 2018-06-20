`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 19:17:01
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [2:0] ALUopcode,
    input [31:0] rega,
    input [31:0] regb,
    output reg [31:0] result,
    output zero,
	output sign
    );
    assign zero = (result==0) ? 1 : 0;
	assign sign = (result[31] == 1'b0) ? 0 : 1;
    always @( ALUopcode or rega or regb ) begin
        case (ALUopcode)
            3'b000 : result = rega + regb;
            3'b001 : result = rega - regb;
            3'b010 : result = (rega < regb)?1:0;//不带符号比较
            3'b011 : begin//带符号比较
                if(rega < regb && (rega[31] == regb[31]))result = 1;
                else if (rega[31] == 1 && regb[31] == 0) result = 1;
                else result = 0;
                end
			3'b100 : result = regb << rega;
			3'b101 : result = rega | regb;
			3'b110 : result = rega & regb;
            3'b111 : result = rega ^ regb;
            default : begin
                result = 32'h00000000;
                $display (" no match");
                end
        endcase
    end
endmodule