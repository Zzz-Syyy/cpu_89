`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/15 16:06:05
// Design Name: 
// Module Name: inst_rom
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

module inst_rom(
	input wire ce,
	input wire[`InstAddrBus]   addr,
	output reg [`InstBus]   inst,
	input clk_inst,
	output[31:0] reg28
);

	reg[`InstBus]  inst_mem[0:1024];
    wire [`InstBus]inst_out;
	initial $readmemh ( "E:\\inst_rom.data", inst_mem );

//    inst_imem IMEM(
//        .addra(addr[12:2]),
//        .clka(clk_inst),
//        .ena(1'b1),
//        .douta(inst_out)
//    );

	always @ (*) begin
//	    inst=inst_out;
	    
		if (ce == `ChipDisable) 
		begin
			inst <= `ZeroWord;
	    end 
	    else 
	    begin
		    inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
		end
	end


    assign reg28=inst;
    
endmodule


