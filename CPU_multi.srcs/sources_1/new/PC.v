`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/11 16:29:44
// Design Name: 
// Module Name: PC
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


module PC(
    input CLK,          //ʱ��
    input RST,          //Ϊ0ʱ����
    input PCWre,        //Ϊ0ʱͣ����PC������
    input [31:0]inputAddress,
    output reg [31:0]outputAddress
    );
    
    initial begin
        outputAddress = 0;//��ʼ��PC��ַΪ0
    end
    
    always@(negedge CLK or negedge RST) begin
        if (RST == 0) outputAddress <= 0;
        else begin
            if (PCWre == 1) outputAddress <= inputAddress;
        end
    end
endmodule