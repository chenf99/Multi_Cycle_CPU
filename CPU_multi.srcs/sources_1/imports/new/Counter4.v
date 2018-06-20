`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/24 11:32:15
// Design Name: 
// Module Name: Counter4
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


module counter4(
    input clk,
    output reg[1:0] count
    );
    always @(posedge clk) begin
            if(count == 3)
                count <= 0;
            else begin
                count <= count + 1; // ¼õ 1 ¼ÆÊý
            end
    end
endmodule
