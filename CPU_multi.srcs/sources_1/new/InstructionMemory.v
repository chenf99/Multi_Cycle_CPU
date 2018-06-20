`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 16:35:42
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory ( InsMemRW, IAddr, IDataOut); // �洢��ģ�飬Ҳ��Instruction Memory
    input InsMemRW; // ��ʹ���ź�
    input [ 31:0] IAddr; // �洢����ַ
    output reg [31:0] IDataOut; // ���������
    reg [7:0] rom [99:0]; // �洢�����������reg���ͣ��洢���洢��Ԫ8λ���ȣ���100���洢��Ԫ
    initial begin // �������ݵ��洢��rom��ע�⣺����ʹ�þ���·�����磺E:/Xlinx/VivadoProject/ROM/���Լ�����
        $readmemb ("D:/Vivado_Data/CPU_multi/instructions.txt", rom); // �����ļ�rom_data��.coe��.txt����δָ�����ʹ�0��ַ��ʼ��š�
    end
    always @( InsMemRW or IAddr ) begin
        if (InsMemRW==0) begin // Ϊ0�����洢����������ݴ洢ģʽ
            IDataOut[31:24] = rom[IAddr];
            IDataOut[23:16] = rom[IAddr+1];
            IDataOut[15:8] = rom[IAddr+2];
            IDataOut[7:0] = rom[IAddr+3];
        end
    end
endmodule