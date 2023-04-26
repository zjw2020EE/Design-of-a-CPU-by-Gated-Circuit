`timescale 1ns / 1ps
module MEM_WB(sysclk, reset,
              MEM_MemtoReg, 
              MEM_RegWrite,
              MEM_out, MEM_PC_plus4,
              MEM_Write_Register, MEM_Read_Data,
              WB_MemtoReg, 
              WB_RegWrite,
              WB_out, WB_PC_next,
              WB_Write_Register, WB_Read_Data              
);
//input signals
input wire sysclk;
input wire reset;
input wire [1:0] MEM_MemtoReg;
input wire MEM_RegWrite;
input wire [31:0] MEM_out;
input wire [31:0] MEM_PC_plus4;
input wire [4:0] MEM_Write_Register;
input wire [31:0] MEM_Read_Data;

//output signals
output reg [1:0] WB_MemtoReg;
output reg WB_RegWrite;
output reg [31:0] WB_out;
output reg [31:0] WB_PC_next;
output reg [4:0] WB_Write_Register;
output reg [31:0] WB_Read_Data;

always @(posedge sysclk or posedge reset)
begin
    if (reset)begin
        WB_MemtoReg <= 2'b00;
        WB_RegWrite <= 0;
        WB_out <= 32'b0;
        WB_PC_next <= 32'b0;
        WB_Write_Register <= 5'b00000;
        WB_Read_Data <= 32'b0;
    end
    else begin
        WB_MemtoReg <= MEM_MemtoReg;
        WB_RegWrite <= MEM_RegWrite;
        WB_out <= MEM_out;
        WB_PC_next <= MEM_PC_plus4;
        WB_Write_Register <= MEM_Write_Register;
        WB_Read_Data <= MEM_Read_Data;    
    end
end 
endmodule