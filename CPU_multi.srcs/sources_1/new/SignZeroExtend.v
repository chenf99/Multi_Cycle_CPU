`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 17:33:00
// Design Name: 
// Module Name: SignZeroExtend
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


module SignZeroExtend(
    input ExtSel,           //Ϊ1������λ��չ��Ϊ0��0��չ
    input [15:0]immediate,  //�����16λ������
    output [31:0]extendImmediate
    );
    
    assign extendImmediate[15:0] = immediate;
    assign extendImmediate[31:16] = (ExtSel == 1) ? (immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;
endmodule