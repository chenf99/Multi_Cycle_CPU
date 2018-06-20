`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/24 11:36:46
// Design Name: 
// Module Name: CLOCK_DIV
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


module clock_div(
    input clk, //100MHz，系统默认主频率
    output reg clk_sys = 0 //分频后的频率。必须初始化为 0
    );
    reg [25:0] div_counter = 0;
    always @(posedge clk) begin
        //if(div_counter>=50) begin // 用于 仿真
        if(div_counter>=50000) begin // 用于生成 比特流文件 下载用
            clk_sys <= ~clk_sys; // 电平反向
            div_counter <= 0;
        end else begin
            div_counter <= div_counter + 1;
        end
    end
endmodule
