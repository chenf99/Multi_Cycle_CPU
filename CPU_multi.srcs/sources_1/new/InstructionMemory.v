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


module InstructionMemory ( InsMemRW, IAddr, IDataOut); // 存储器模块，也即Instruction Memory
    input InsMemRW; // 读使能信号
    input [ 31:0] IAddr; // 存储器地址
    output reg [31:0] IDataOut; // 输出的数据
    reg [7:0] rom [99:0]; // 存储器定义必须用reg类型，存储器存储单元8位长度，共100个存储单元
    initial begin // 加载数据到存储器rom。注意：必须使用绝对路径，如：E:/Xlinx/VivadoProject/ROM/（自己定）
        $readmemb ("D:/Vivado_Data/CPU_multi/instructions.txt", rom); // 数据文件rom_data（.coe或.txt）。未指定，就从0地址开始存放。
    end
    always @( InsMemRW or IAddr ) begin
        if (InsMemRW==0) begin // 为0，读存储器。大端数据存储模式
            IDataOut[31:24] = rom[IAddr];
            IDataOut[23:16] = rom[IAddr+1];
            IDataOut[15:8] = rom[IAddr+2];
            IDataOut[7:0] = rom[IAddr+3];
        end
    end
endmodule