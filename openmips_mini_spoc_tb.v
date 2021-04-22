`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/15 16:14:25
// Design Name: 
// Module Name: openmips_mini_spoc_tb
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



module openmips_min_sopc_tb();

  reg     CLOCK_50;
  reg     rst;
//  reg CLOCK_inst;
  wire [7:0] o_seg;
  wire [7:0] o_sel;
  wire [31:0] reg28; 
       
  initial begin
    CLOCK_50 = 1'b0;
//    CLOCK_inst=1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
//    forever #5 CLOCK_inst=~CLOCK_inst;
  end
      
  initial begin
    rst = 1'b1;
    #1 rst= 1'b0;
    #999999 $stop;
  end
       
//  openmips_min_sopc openmips_min_sopc0(
//		.clk(CLOCK_50),
//		.rst(rst),
//	    .reg28(reg28),
//        .clk_inst(CLOCK_inst)
//	);

    CPU_top CPU_top(
        .clk(CLOCK_50),
        .rst(rst),
        .o_seg(o_seg),
        .o_sel(o_sel),
        .reg28(reg28)
    );

endmodule
