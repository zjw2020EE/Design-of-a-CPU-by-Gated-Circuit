`timescale 1ns / 1ps
module ID_EX(sysclk, reset, IDEX_Flush, 
             ID_MemWrite, ID_MemRead, ID_MemtoReg, 
             ID_RegDst, ID_RegWrite, ID_lbflag,
             ID_ALUSrcA, ID_ALUSrcB, ID_ALUOp, ID_Sign,
             ID_Branch, ID_Immediate, ID_PC_plus4, 
             ID_forwardA_o, ID_forwardB_o,
             ID_rs, ID_rt, ID_rd, ID_Shamt, 
             EX_MemWrite, EX_MemRead, EX_MemtoReg, 
             EX_RegDst, EX_RegWrite, EX_lbflag,
             EX_ALUSrcA, EX_ALUSrcB, EX_ALUOp, EX_Sign,
             EX_Branch, EX_Immediate, EX_PC_next, 
             EX_forwardA_o, EX_forwardB_o,
             EX_rs, EX_rt, EX_rd, EX_Shamt
    );
//input signals
input wire sysclk;
input wire reset;
input wire IDEX_Flush;
input wire ID_MemWrite;
input wire ID_MemRead;
input wire [1:0] ID_MemtoReg;
input wire [1:0] ID_RegDst;
input wire ID_RegWrite;
input wire ID_lbflag;
input wire ID_ALUSrcA;
input wire ID_ALUSrcB;
input wire [4:0] ID_ALUOp;
input wire ID_Sign;
input wire ID_Branch;
input wire [31:0] ID_Immediate;
input wire [31:0] ID_PC_plus4;
input wire [31:0] ID_forwardA_o;
input wire [31:0] ID_forwardB_o;
input wire [4:0] ID_rs;
input wire [4:0] ID_rt;
input wire [4:0] ID_rd;
input wire [4:0] ID_Shamt;

//output signals
output reg EX_MemWrite;
output reg EX_MemRead;
output reg [1:0] EX_MemtoReg;
output reg [1:0] EX_RegDst;
output reg EX_RegWrite;
output reg EX_lbflag;
output reg EX_ALUSrcA;
output reg EX_ALUSrcB;
output reg [4:0] EX_ALUOp;
output reg EX_Sign;
output reg EX_Branch;
output reg [31:0] EX_Immediate;
output reg [31:0] EX_PC_next;
output reg [31:0] EX_forwardA_o;
output reg [31:0] EX_forwardB_o;
output reg [4:0] EX_rs;
output reg [4:0] EX_rt;
output reg [4:0] EX_rd;
output reg [4:0] EX_Shamt;

always @(posedge sysclk or posedge reset)
begin
    if(reset || IDEX_Flush)begin
        EX_MemWrite <= 0;
        EX_MemRead <= 0;
        EX_MemtoReg <= 2'b00;
        EX_RegDst <= 2'b00;
        EX_RegWrite <= 0;
        EX_lbflag <= 0;
        EX_ALUSrcA <= 0;
        EX_ALUSrcB <= 0;
        EX_ALUOp <= 5'b00000;
        EX_Sign <= 0;
        EX_Branch <= 0;
        EX_Immediate <= 32'b0;
        EX_PC_next <= 32'b0;
        EX_forwardA_o <= 32'b0;
        EX_forwardB_o <= 32'b0;
        EX_rs <= 5'b00000;
        EX_rt <= 5'b00000;
        EX_rd <= 5'b00000;
        EX_Shamt <= 5'b00000;
    end
    else begin
        EX_MemWrite <= ID_MemWrite;
        EX_MemRead <= ID_MemRead;
        EX_MemtoReg <= ID_MemtoReg;
        EX_RegDst <= ID_RegDst;
        EX_RegWrite <= ID_RegWrite;
        EX_lbflag <= ID_lbflag;
        EX_ALUSrcA <= ID_ALUSrcA;
        EX_ALUSrcB <= ID_ALUSrcB;
        EX_ALUOp <= ID_ALUOp;
        EX_Sign <= ID_Sign;
        EX_Branch <= ID_Branch;
        EX_Immediate <= ID_Immediate;
        EX_PC_next <= ID_PC_plus4;
        EX_forwardA_o <= ID_forwardA_o;
        EX_forwardB_o <= ID_forwardB_o;
        EX_rs <= ID_rs;
        EX_rt <= ID_rt;
        EX_rd <= ID_rd;
        EX_Shamt <= ID_Shamt;    
    end
end  
endmodule
