`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 20:02:18
// Design Name: 
// Module Name: Select2_MUX
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

//2ѡ1ѡ����,������ѡ��ALU�ڶ������롢DB��д��Ĵ�������
module Select2_MUX(
    input select,       //ALUSrcB��DBDataSrc��WrRegDSrc
    input [31:0]Data1,  //���ԼĴ����������ALU��������PC + 4
    input [31:0]Data2,  //������չ�����������洢�������DB
    output [31:0]result
    );
    assign result = (select == 0 ? Data1 : Data2);
endmodule
