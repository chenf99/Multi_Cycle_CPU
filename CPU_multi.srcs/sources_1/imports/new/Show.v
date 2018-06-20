`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/24 13:12:50
// Design Name: 
// Module Name: Show
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


module Show(
    input CLK1,     //按键时钟信号
    input CLK2,     //Basys3板时钟信号
    input [1:0]SW_In,
    input Reset,
    output [3:0]AN,
    output [7:0]dispcode
    );
    
    wire CLK;   //CPU工作信号,经过防抖处理得到
    DebKey deb(CLK2, CLK1, CLK);
    //CPU输入
    wire [31:0]nowPC, nextPC;
    wire [4:0]rs, rt;
    wire [31:0]ReadData1, ReadData2;
    wire [31:0]ALUresult, DB;
    
    CPU cpu(CLK, Reset, nowPC, nextPC, rs, rt, ReadData1, ReadData2, ALUresult, DB);
    
    wire CLK3;      //分频后的时钟信号，用于计数器
    clock_div div(CLK2, CLK3);
    
    wire [1:0]count;    //计数器输出
    counter4 counter(CLK3, count);
    
    reg [31:0]DataIn1, DataIn2;
    always @(SW_In) begin
        case (SW_In)
            2'b00:begin
                DataIn1 = nowPC;
                DataIn2 = nextPC;
                end
            2'b01:begin
                DataIn1[31:5] = 0;
                DataIn1[4:0] = rs;
                DataIn2 = ReadData1;
                end
            2'b10:begin
                DataIn1[31:5] = 0;
                DataIn1[4:0] = rt;
                DataIn2 = ReadData2;
                end
            2'b11:begin
                DataIn1 = ALUresult;
                DataIn2 = DB;
                end
        endcase
    end
    wire [3:0]display_data;
    Display_seg display(CLK2, count, DataIn1, DataIn2, AN, display_data);
    
    SegLED seg(display_data, dispcode);
endmodule
