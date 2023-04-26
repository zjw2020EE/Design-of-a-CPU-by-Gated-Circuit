`timescale 1ns / 1ps
module EX_MEM(sysclk, reset,
              EX_MemWrite, EX_MemRead, EX_MemtoReg, 
              EX_RegWrite, EX_lbflag,
              EX_out, EX_PC_plus4,
              EX_Write_Register, EX_Write_Data,
              MEM_MemWrite, MEM_MemRead, MEM_MemtoReg, 
              MEM_RegWrite, MEM_lbflag,
              MEM_out, MEM_PC_next,
              MEM_Write_Register, MEM_Write_Data);
//input signals
input wire sysclk;
input wire reset;
input wire EX_MemWrite;
input wire EX_MemRead;
input wire [1:0] EX_MemtoReg;
input wire EX_RegWrite;
input wire EX_lbflag;
input wire [31:0] EX_out;
input wire [31:0] EX_PC_plus4;
input wire [4:0] EX_Write_Register;
input wire [31:0] EX_Write_Data;

//output signals           
output reg MEM_MemWrite;
output reg MEM_MemRead;
output reg [1:0] MEM_MemtoReg;
output reg MEM_RegWrite;
output reg MEM_lbflag;
output reg [31:0] MEM_out;
output reg [31:0] MEM_PC_next;
output reg [4:0] MEM_Write_Register;
output reg [31:0] MEM_Write_Data;        
     
always @(posedge sysclk or posedge reset)
begin  
    if(reset)begin
        MEM_MemWrite <= 0;
        MEM_MemRead <= 0;
        MEM_MemtoReg <= 2'b00;
        MEM_RegWrite <= 0;
        MEM_lbflag <= 0;
        MEM_out <= 32'b0;
        MEM_PC_next <= 32'b0;
        MEM_Write_Register <= 5'b00000;
        MEM_Write_Data <= 32'b0;
     end
     else begin
        MEM_MemWrite <= EX_MemWrite;
        MEM_MemRead <= EX_MemRead;
        MEM_MemtoReg <= EX_MemtoReg;
        MEM_RegWrite <= EX_RegWrite;
        MEM_lbflag <= EX_lbflag;
        MEM_out <= EX_out;
        MEM_PC_next <= EX_PC_plus4;
        MEM_Write_Register <= EX_Write_Register;
        MEM_Write_Data <= EX_Write_Data;        
     end            
end             
endmodule
