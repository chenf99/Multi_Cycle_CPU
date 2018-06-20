`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/13 12:22:31
// Design Name: 
// Module Name: CPU_sim
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


module CPU_sim();
	//inputs
	reg CLK, RST;
	//outputs
	wire [31:0]nowPC, nextPC, ReadData1, ReadData2, ALUresult, DB;
	wire [4:0]rs, rt;
	
	CPU test(
		.CLK(CLK),
		.RST(RST),
		.nowPC(nowPC),
		.nextPC(nextPC),
		.rs(rs),
		.rt(rt),
		.ReadData1(ReadData1),
		.ReadData2(ReadData2),
		.ALUresult(ALUresult),
		.DB(DB)
	);
	
	integer count = 1;
	
	initial begin
    // Initialize Inputs
      CLK = 0;
      RST = 0;
      #50;
          CLK = !CLK;
      #50;
          RST = 1;
      forever #50 begin
          CLK = !CLK;
          count = count + 1;
          if (count == 200) $stop;
      end
    end
	
endmodule
