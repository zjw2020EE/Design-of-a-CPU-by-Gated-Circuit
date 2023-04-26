`timescale 1ns / 1ps
module J_PCMUX(jump, jumpsrc, jump_pc, IFPC_plus4, j_pc_ex, ID_forwardA_o);
//input signals
input wire jump;
input wire jumpsrc;
input wire [31:0] IFPC_plus4;
input wire [31:0] j_pc_ex;
input wire [31:0] ID_forwardA_o;

//output signals
output wire [31:0] jump_pc;

assign jump_pc = (!jump) ? IFPC_plus4 : (!jumpsrc) ? j_pc_ex : ID_forwardA_o;

endmodule
