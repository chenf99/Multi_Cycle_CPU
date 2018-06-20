`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 17:03:41
// Design Name: 
// Module Name: RegWre_MUX
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

//����ѡ��д�Ĵ�����ַ��3ѡ1ѡ����
module RegWre_MUX(
    input [1:0]RegDst,      //�����ź�
    input [4:0]Data1,       //��Ӧ$31
    input [4:0]Data2,       //��Ӧrt
    input [4:0]Data3,       //��Ӧrd
    output reg [4:0]result
    );
    always @(RegDst or Data1 or Data2 or Data3) begin
        case (RegDst)
            2'b00 : result = Data1;
            2'b01 : result = Data2;
			2'b10 : result = Data3;
			2'b11 : result = 0;		//δ��
		endcase
	end
endmodule
