`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 19:30:21
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input CLK,
    input [31:0] DAddr,
    input [31:0] DataIn, // [31:24], [23:16], [15:8], [7:0]
    input nRD, // 为0，正常读；为1,输出高组态
    input nWR, // 为0，写；为1，无操作
    output [31:0] Dataout
    );
    reg [7:0] ram [0:60]; // 存储器定义必须用reg类型
    // 读
    assign Dataout[7:0] = (nRD==0)?ram[DAddr + 3]:8'bz; // z 为高阻态
    assign Dataout[15:8] = (nRD==0)?ram[DAddr + 2]:8'bz;
    assign Dataout[23:16] = (nRD==0)?ram[DAddr + 1]:8'bz;
    assign Dataout[31:24] = (nRD==0)?ram[DAddr ]:8'bz;
    // 写
    always@( nWR or DAddr or DataIn) begin // 用电平信号触发写存储器，个例
        if( nWR==0 ) begin
            ram[DAddr] <= DataIn[31:24];
            ram[DAddr + 1] <= DataIn[23:16];
            ram[DAddr + 2] <= DataIn[15:8];
            ram[DAddr + 3] <= DataIn[7:0];
        end
    end
endmodule