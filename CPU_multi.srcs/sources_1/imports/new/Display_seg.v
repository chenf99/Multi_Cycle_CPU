`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/24 12:45:13
// Design Name: 
// Module Name: Display_seg
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


module Display_seg(
    input CLK,
    input [1:0]count,
    input [31:0]DataIn1,
    input [31:0]DataIn2,
    output reg [3:0]AN,
    output reg [3:0]display_data
    );
    
    wire [7:0]DataOut1, DataOut2;
    
    assign DataOut1 = DataIn1[7:0];
    assign DataOut2 = DataIn2[7:0];
    always @(posedge CLK) begin
        case (count)
            0:begin
                AN <= 4'b0111;
                display_data = DataOut1[7:4];
            end
            1:begin
                AN <= 4'b1011;
                display_data = DataOut1[3:0];
            end
            2:begin
                AN <= 4'b1101;
                display_data = DataOut2[7:4];
            end
            3:begin
                AN <= 4'b1110;
                display_data = DataOut2[3:0];
            end
        endcase
    end
endmodule
