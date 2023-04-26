`timescale 1ns / 1ps
module Forward_B(ForwardB, MEM_MemtoReg, Bout, EX_out, MEM_out, MEM_Read_Data, MEM_PC_next, ID_Read_data2);
//input siganls
input wire [1:0] ForwardB;
input wire [1:0] MEM_MemtoReg;
input wire [31:0] EX_out;
input wire [31:0] MEM_out;
input wire [31:0] MEM_Read_Data;
input wire [31:0] MEM_PC_next;
input wire [31:0] ID_Read_data2;

//output signals
output wire [31:0] Bout;

assign Bout = (ForwardB == 2'b01) ? EX_out : (ForwardB == 2'b10) ? ( (MEM_MemtoReg == 2'b00) ? MEM_out : (MEM_MemtoReg == 2'b01) ? MEM_Read_Data : MEM_PC_next) : ID_Read_data2; 

endmodule
