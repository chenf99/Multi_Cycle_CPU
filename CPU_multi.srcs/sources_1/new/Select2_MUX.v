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

//2选1选择器,可用来选择ALU第二个输入、DB、写入寄存器数据
module Select2_MUX(
    input select,       //ALUSrcB、DBDataSrc、WrRegDSrc
    input [31:0]Data1,  //来自寄存器堆输出、ALU运算结果、PC + 4
    input [31:0]Data2,  //来自扩展的立即数、存储器输出、DB
    output [31:0]result
    );
    assign result = (select == 0 ? Data1 : Data2);
endmodule
