`timescale 1ns / 1ps
module Write_RegAdd_MUX(EX_RegDst, rt, rd, Write_RegisterAddr);
//input signals;
input wire [1:0] EX_RegDst;
input wire [4:0] rt;
input wire [4:0] rd;

//output signals;
output wire [4:0] Write_RegisterAddr;

assign Write_RegisterAddr = (EX_RegDst == 2'b10) ? 5'd31 : (EX_RegDst == 2'b01) ? rd : rt;

endmodule
