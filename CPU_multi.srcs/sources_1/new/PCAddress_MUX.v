`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 19:46:44
// Design Name: 
// Module Name: PCAddress_MUX
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

//����ѡ������PC�ĵ�ַ��4ѡ1ѡ����
module PCAddress_MUX(
    input [1:0]PCSrc,
    input [31:0]PC4,        //PC + 4
    input [31:0]PC4_imme,   //PC + 4 + ��չ������������beq��bltz�й�
    input [31:0]PC_jr,      //��jr���
    input [31:0]PC_j,       //��j���
    output reg [31:0]outputAddress
    );
    always @(PCSrc or PC4 or PC4_imme or PC_jr or PC_j) begin
        case (PCSrc)
            2'b00 : outputAddress = PC4;
            2'b01 : outputAddress = PC4_imme;
            2'b10 : outputAddress = PC_jr;
            2'b11 : outputAddress = PC_j;
        endcase
    end
endmodule
