`timescale 1ns / 1ps
module Forward_A(ForwardA, MEM_MemtoReg, Aout, EX_out, MEM_out, MEM_Read_Data, MEM_PC_next, ID_Read_data1);
//input siganls
input wire [1:0] ForwardA;
input wire [1:0] MEM_MemtoReg;
input wire [31:0] EX_out;
input wire [31:0] MEM_out;
input wire [31:0] MEM_Read_Data;
input wire [31:0] MEM_PC_next;
input wire [31:0] ID_Read_data1;

//output signals
output wire [31:0] Aout;

assign Aout = (ForwardA == 2'b01) ? EX_out : (ForwardA == 2'b10) ? ( (MEM_MemtoReg == 2'b00) ? MEM_out : (MEM_MemtoReg == 2'b01) ? MEM_Read_Data : MEM_PC_next) : ID_Read_data1; 

endmodule
