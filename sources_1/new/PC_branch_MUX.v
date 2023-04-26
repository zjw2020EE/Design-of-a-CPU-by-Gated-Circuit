`timescale 1ns / 1ps
module PC_branch_MUX(branch, zero, jump_PC, branch_PC, PC_i);
//input signals
input wire branch;
input wire zero;
input wire [31:0] jump_PC;
input wire [31:0] branch_PC;

//output signals
output [31:0] PC_i;

assign PC_i = (branch && zero) ? branch_PC : jump_PC;

endmodule
