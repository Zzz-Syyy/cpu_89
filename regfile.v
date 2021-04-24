`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/15 15:48:16
// Design Name: 
// Module Name: regfile
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

`include "defines.v"

module regfile(

	input  wire clk,
	input  wire rst,
	
	//Ð´¶Ë¿Ú
	input  wire    we,
	input  wire[`RegAddrBus]   waddr,
	input  wire[`RegBus]   wdata,
	
	//¶Á¶Ë¿Ú1
	input  wire	   re1,
	input  wire[`RegAddrBus]  raddr1,
	output reg[`RegBus]    rdata1,
	
	//¶Á¶Ë¿Ú2
	input  wire    re2,
	input  wire[`RegAddrBus]   raddr2,
	output reg[`RegBus]    rdata2
//    output [31:0] reg28
	
);

	reg[`RegBus]  regs[0:2047];

	always @ (posedge clk) begin
		if (rst == `RstDisable) 
		begin
			if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) 
			begin
				regs[waddr] <= wdata;
			end
		end
	end
	
	always @ (*) begin
		if(rst == `RstEnable) 
		begin
			  rdata1 <= `ZeroWord;
	    end 
	    else if(raddr1 == `RegNumLog2'h0) 
	    begin
	  		rdata1 <= `ZeroWord;
	    end 
	    else if((raddr1 == waddr) && (we == `WriteEnable) && (re1 == `ReadEnable)) 
	  	begin
	  	  rdata1 <= wdata;
	    end 
	    else if(re1 == `ReadEnable) 
	    begin
	      rdata1 <= regs[raddr1];
	    end 
	    else 
	    begin
	      rdata1 <= `ZeroWord;
	    end
	end

	always @ (*) begin
		if(rst == `RstEnable) 
		begin
			  rdata2 <= `ZeroWord;
	    end 
	    else if(raddr2 == `RegNumLog2'h0) 
	    begin
	  		rdata2 <= `ZeroWord;
	    end 
	    else if((raddr2 == waddr) && (we == `WriteEnable) && (re2 == `ReadEnable)) 
	    begin
	  	  rdata2 <= wdata;
	    end 
	    else if(re2 == `ReadEnable) 
	    begin
	      rdata2 <= regs[raddr2];
	    end 
	    else begin
	      rdata2 <= `ZeroWord;
	    end
	end

//    assign reg28 = regs[1];
endmodule