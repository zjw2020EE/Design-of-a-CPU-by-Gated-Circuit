`timescale 1ns / 1ps
module Data_Hazard(IDEX_rs, IDEX_rt, IDEX_MemRead, 
                   MEMWB_RegWrite, MEMWB_Write_Register,
                   EXMEM_RegWrite, EXMEM_Write_Register, 
                   ForwardA, ForwardB, loaduse_stall);
//input signals
input wire [4:0] IDEX_rs;
input wire [4:0] IDEX_rt;
input wire MEMWB_RegWrite;
input wire [4:0] MEMWB_Write_Register;
input wire EXMEM_RegWrite;
input wire [4:0] EXMEM_Write_Register;
input wire IDEX_MemRead;


//output signals                   
output wire [1:0] ForwardA;
output wire [1:0] ForwardB;
output wire loaduse_stall;

assign ForwardA = (MEMWB_RegWrite 
&& MEMWB_Write_Register!=0 
&& MEMWB_Write_Register==IDEX_rs 
) ? 2'b01 :
(EXMEM_RegWrite
&& EXMEM_Write_Register!=0
&& EXMEM_Write_Register==IDEX_rs) ? 2'b10 :2'b00;

assign ForwardB = (MEMWB_RegWrite 
&& MEMWB_Write_Register!=0 
&& MEMWB_Write_Register==IDEX_rt 
) ? 2'b01 :
(EXMEM_RegWrite
&& EXMEM_Write_Register!=0
&& EXMEM_Write_Register==IDEX_rt) ? 2'b10 :2'b00;                
                   
assign loaduse_stall = IDEX_MemRead && (MEMWB_Write_Register!=0) && (MEMWB_Write_Register==IDEX_rs || MEMWB_Write_Register==IDEX_rt);



endmodule
