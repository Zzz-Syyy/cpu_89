`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/19 18:49:44
// Design Name: 
// Module Name: CPU_top
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


module CPU_top(
    input clk,
    input rst,
    output [7:0] o_seg,
    output [7:0] o_sel
//    output [31:0] reg28
    );
    
    parameter T1s = 99999999;
    
    reg [30:0] count;
    reg clk_1s;
    
    reg [30:0] count_inst;
    reg clk_inst;
    
    wire [31:0] inst;
//    wire [31:0] pc;      
    wire [31:0] reg28;
    wire [31:0] seg7_in;
    
    always @ (posedge clk or posedge rst) 
    begin
        if(rst) begin
            clk_1s <= 0;
            count <= 0;
        end
        else if(count == T1s) begin
            count <= 1;
            clk_1s <= ~clk_1s;
        end
        else
            count <= count + 1;
    end
    
        always @ (posedge clk or posedge rst) 
         begin
            if(rst) begin
                clk_inst <= 1;
                count_inst <= 0;
            end
            else if(count_inst == 49999999) begin
                count_inst <= 0;
                clk_inst <= ~clk_inst;
            end
            else
                count_inst <= count_inst + 1;
        end
    
    openmips_min_sopc cpu(
        .clk(clk_1s),
        .rst(rst),
        .reg28(reg28),
        .clk_inst(clk_inst)
    );
    
    Seg7x16 display(
        .clk(clk),
        .reset( rst), 
        .cs(1'b1),
        .i_data(reg28),
        .o_seg(o_seg),
        .o_sel(o_sel)
    );

endmodule
