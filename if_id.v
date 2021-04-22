`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/15 15:41:44
// Design Name: 
// Module Name: if_id
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

module if_id(
	input  wire clk,
	input wire rst,
	//来自控制模块的信息
	input wire[5:0]    stall,	
	input wire flush,

	input wire[`InstAddrBus]   if_pc,
	input wire[`InstBus]   if_inst,
	output reg[`InstAddrBus]   id_pc,
	output reg[`InstBus]   id_inst  
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) 
		begin
			id_pc <= `ZeroWord;
			id_inst <= `ZeroWord;
		end 
		else if(flush == 1'b1 ) 
		begin
			id_pc <= `ZeroWord;
			id_inst <= `ZeroWord;					
		end 
		else if(stall[1] == `Stop && stall[2] == `NoStop) 
		begin
			id_pc <= `ZeroWord;
			id_inst <= `ZeroWord;	
	    end 
	    else if(stall[1] == `NoStop) 
	    begin
		  id_pc <= if_pc;
		  id_inst <= if_inst;
		end
	end

endmodule