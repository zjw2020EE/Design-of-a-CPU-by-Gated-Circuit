`timescale 1ns / 1ps
module ControlHazard(Jump, true_branch, loaduse_stall, IFID_Flush, IDEX_Flush, PC_holdon, IFID_holdon);
//input signals
input wire Jump;
input wire true_branch;
input wire loaduse_stall;

//output signals
output wire IFID_Flush;
output wire IDEX_Flush;
output wire PC_holdon;
output wire IFID_holdon;

assign IFID_Flush = Jump || true_branch;
assign IDEX_Flush = true_branch || loaduse_stall;
assign PC_holdon = loaduse_stall;
assign IFID_holdon = loaduse_stall;
endmodule
