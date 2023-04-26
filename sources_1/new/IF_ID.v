`timescale 1ns / 1ps
module IF_ID(sysclk, reset, IFID_Flush, IFID_holdon, IFPC_plus4, ID_PC_next, Instruction, OpCode, Funct, rs, rt, rd, shamt);
//input signals
input wire sysclk;
input wire reset;
input wire IFID_Flush;
input wire IFID_holdon;
input wire [31:0] IFPC_plus4;
input wire [31:0] Instruction;
//output signals
output reg [5:0] OpCode;
output reg [5:0] Funct;
output reg [4:0] rs;
output reg [4:0] rt;
output reg [4:0] rd;
output reg [4:0] shamt;
output reg [31:0] ID_PC_next;

always @(posedge sysclk or posedge reset)
begin
    if(reset)begin
        OpCode <= 0;
        Funct <= 0;
        rs <= 0;
        rt <= 0;
        rd <= 0;
        shamt <= 0;
        ID_PC_next <= 0;
    end
    else if(IFID_holdon == 0)begin
            if(IFID_Flush)begin
                OpCode <= 0;
                Funct <= 0;
                rs <= 0;
                rt <= 0;
                rd <= 0;
                shamt <= 0;
                ID_PC_next <= 0;
            end
            else begin
                OpCode <= Instruction[31:26];
                Funct <= Instruction[5:0];
                rs <= Instruction[25:21];
                rt <= Instruction[20:16];
                rd <= Instruction[15:11];
                shamt <= Instruction[10:6];
                ID_PC_next <= IFPC_plus4;     
            end       
    end
end
endmodule
