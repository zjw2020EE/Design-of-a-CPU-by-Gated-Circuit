`timescale 1ns / 1ps
module MemtoReg_MUX(MemtoReg, exPC, MEM_Read_Data, out, Write_Data);
//input signals
input wire [1:0] MemtoReg;
input wire [31:0] exPC;
input wire [31:0] MEM_Read_Data;
input wire [31:0] out;

//output signals
output wire [31:0] Write_Data;

assign Write_Data = (MemtoReg == 2'b10) ? exPC : (MemtoReg == 2'b01) ? MEM_Read_Data : out;

endmodule
