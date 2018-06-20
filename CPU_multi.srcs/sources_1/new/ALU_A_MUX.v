`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 17:46:32
// Design Name: 
// Module Name: ALU_A_MUX
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

//ѡ��ALU��һ�������2ѡ1ѡ����
module ALU_A_MUX(
    input ALUSrcA,
    input [31:0]Data1,      //���ԼĴ��������
    input [4:0]Data2,      //�����saֻ��5λ��Ҫ��0��չ
    output [31:0]result
    );  
    assign result = (ALUSrcA == 0 ? Data1 : {{27{0}}, Data2[4:0]});
endmodule
