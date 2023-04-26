`timescale 1ns / 1ps
module CPU(sysclk, reset, leds, BCD7, AN);
//input signals
input wire sysclk;
input wire reset;

//output signals
output wire [7:0] leds;
output wire [7:0] BCD7;
output wire [3:0] AN;

//clk
wire clk;
assign clk = sysclk;

//PC
wire [31:0] PC_i;
wire [31:0] PC_o;
wire PC_holdon;
wire PC_Write;
assign PC_Write=!PC_holdon;
PC PC_(reset, clk, PC_Write, PC_i, PC_o);

//InstrucitonMemory
wire [31:0] Instruction;
InstructionMemory InstructionMemory_(PC_o, Instruction);

//IF_ID
wire IFID_Flush;
wire IFID_holdon;
wire [31:0] IFPC_plus4;
wire [5:0] OpCode;
wire [5:0] Funct;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] shamt;
wire [31:0] ID_PC_next;
assign IFPC_plus4 = PC_o + 4;
IF_ID IF_ID_(clk, reset, IFID_Flush, IFID_holdon, IFPC_plus4, ID_PC_next, Instruction, OpCode, Funct, rs, rt, rd, shamt);

//ID Controller
wire ID_MemWrite;
wire ID_MemRead;
wire [1:0] ID_MemtoReg;
wire [1:0] ID_RegDst;
wire ID_RegWrite;
wire ExtOp;
wire LuiOp;
wire ID_lbflag;
wire ID_ALUSrcA;
wire ID_ALUSrcB;
wire [4:0] ID_ALUOp;
wire ID_Sign;
wire Jump;
wire JumpSrc;
wire ID_Branch;
Controller Controller_(OpCode, Funct, 
                ID_MemWrite, ID_MemRead, ID_MemtoReg, 
                ID_RegDst, ID_RegWrite, ExtOp, LuiOp, ID_lbflag,
                ID_ALUSrcA, ID_ALUSrcB, ID_ALUOp, ID_Sign,
                Jump, JumpSrc, ID_Branch); 

//immediate
wire [15:0] Immediate;
wire [31:0] ImmExtOut;
assign Immediate = {rd, shamt, Funct};
ImmProcess ImmProcess_(ExtOp, LuiOp, Immediate, ImmExtOut);

//RF
wire WB_RegWrite;
wire [4:0] Read_register1;
wire [4:0] Read_register2;
wire [4:0] WB_Write_Register;
wire [31:0] WB_Write_Data;
wire [31:0]Read_data1;
wire [31:0]Read_data2;
assign Read_register1 = rs;
assign Read_register2 = rt;
RegisterFile RegisterFile_(reset, clk, WB_RegWrite, Read_register1, Read_register2, WB_Write_Register, WB_Write_Data, Read_data1, Read_data2);

//fowardA\B
wire [31:0] ID_forwardA_o;
wire [31:0] ID_forwardB_o;
wire [1:0] ForwardA;
wire [1:0] ForwardB;

//jump
wire [31:0] Jump_PC;
wire [31:0] PC_jump_Ex;
assign PC_jump_Ex = {ID_PC_next[31:28], rs, rt, rd, shamt, Funct, 2'b00};
J_PCMUX J_PCMUX_(Jump, JumpSrc, Jump_PC, IFPC_plus4, PC_jump_Ex, ID_forwardA_o);

//ID_EX
wire IDEX_Flush;
//wire [31:0] ID_Immediate;= ImmExtOut
//wire [31:0] ID_PC_plus4;= ID_PC_next;
//wire [4:0] ID_rt;= rt
//wire [4:0] ID_rd;= rd
//wire [4:0] ID_Shamt;= shamt
wire EX_MemWrite;
wire EX_MemRead;
wire [1:0] EX_MemtoReg;
wire [1:0] EX_RegDst;
wire EX_RegWrite;
wire EX_lbflag;
wire EX_ALUSrcA;
wire EX_ALUSrcB;
wire [4:0] EX_ALUOp;
wire EX_Sign;
wire EX_Branch;
wire [31:0] EX_Immediate;
wire [31:0] EX_PC_next;
wire [31:0] EX_forwardA_o;
wire [31:0] EX_forwardB_o;
wire [4:0] EX_rs;
wire [4:0] EX_rt;
wire [4:0] EX_rd;
wire [4:0] EX_Shamt;
ID_EX ID_EX_(clk, reset, IDEX_Flush, 
             ID_MemWrite, ID_MemRead, ID_MemtoReg, 
             ID_RegDst, ID_RegWrite, ID_lbflag,
             ID_ALUSrcA, ID_ALUSrcB, ID_ALUOp, ID_Sign,
             ID_Branch, ImmExtOut, ID_PC_next, 
             ID_forwardA_o, ID_forwardB_o,
             rs,rt, rd, shamt, 
             EX_MemWrite, EX_MemRead, EX_MemtoReg, 
             EX_RegDst, EX_RegWrite, EX_lbflag,
             EX_ALUSrcA, EX_ALUSrcB, EX_ALUOp, EX_Sign,
             EX_Branch, EX_Immediate, EX_PC_next, 
             EX_forwardA_o, EX_forwardB_o,
             EX_rs, EX_rt, EX_rd, EX_Shamt
    );

//write register
wire [4:0] EX_Write_Register;
Write_RegAdd_MUX Write_RegAdd_MUX_(EX_RegDst, EX_rt, EX_rd, EX_Write_Register);
   

//ALU
wire [31:0] in1;
wire [31:0] in2;
assign in1 = EX_ALUSrcA ? EX_Shamt : EX_forwardA_o;
assign in2 = EX_ALUSrcB ? EX_Immediate : EX_forwardB_o;
wire [31:0] out;
wire zero;
ALU ALU_(in1, in2, EX_ALUOp, EX_Sign, out, zero);

//branch PC
wire [31:0] Branch_PC;
assign Branch_PC = EX_PC_next + (EX_Immediate << 2);
PC_branch_MUX PC_branch_MUX_(EX_Branch, zero, Jump_PC, Branch_PC, PC_i);

//EX_MEM
//EX_MemWrite,EX_MemRead,EX_MemtoReg,EX_RegWrite,EX_lbflag
//wire [31:0] EX_out;= out
//wire [31:0] EX_PC_plus4;= EX_PC_next
//EX_Write_Register
wire [31:0] EX_Write_Data;
assign EX_Write_Data = EX_forwardB_o;
wire MEM_MemWrite;
wire MEM_MemRead;
wire [1:0] MEM_MemtoReg;
wire MEM_RegWrite;
wire MEM_lbflag;
wire [31:0] MEM_out;
wire [31:0] MEM_PC_next;
wire [4:0] MEM_Write_Register;
wire [31:0] MEM_Write_Data;
EX_MEM EX_MEM_(clk, reset,
              EX_MemWrite, EX_MemRead, EX_MemtoReg, 
              EX_RegWrite, EX_lbflag,
              out, EX_PC_next,
              EX_Write_Register, EX_Write_Data,
              MEM_MemWrite, MEM_MemRead, MEM_MemtoReg, 
              MEM_RegWrite, MEM_lbflag,
              MEM_out, MEM_PC_next,
              MEM_Write_Register, MEM_Write_Data);

//DataMemory
//wire [31:0] Address;= MEM_out
//Write_Data, MemWrite, MemRead, lbflag, leds, BCD7, AN
wire [31:0] MEM_Read_Data;
DataMemory DataMemory_(clk, reset, MEM_out, MEM_Write_Data, MEM_Read_Data, MEM_MemWrite, MEM_MemRead, MEM_lbflag, leds, BCD7, AN);

//MEM_WB
//MEM_MemtoReg, MEM_RegWrite, MEM_out, MEM_Write_Register, MEM_Read_Data
//wire [31:0] MEM_PC_plus4;= MEM_PC_next
wire [1:0] WB_MemtoReg;
wire [31:0] WB_out;
wire [31:0] WB_PC_next;
wire [31:0] WB_Read_Data;

MEM_WB MEM_WB_(clk, reset,
              MEM_MemtoReg, 
              MEM_RegWrite,
              MEM_out, MEM_PC_next,
              MEM_Write_Register, MEM_Read_Data,
              WB_MemtoReg, 
              WB_RegWrite,
              WB_out, WB_PC_next,
              WB_Write_Register, WB_Read_Data              
);     

//MemtoReg_MUX
MemtoReg_MUX MemtoReg_MUX_(WB_MemtoReg, WB_PC_next, WB_Read_Data, WB_out, WB_Write_Data);

//data hazard
//IDEX_rs=rs, IDEX_rt=rt
//MEMWB_RegWrite=EX_RegWrite, MEMWB_Write_Register=EX_Write_Register
//EXMEM_RegWrite=MEM_RegWrite, EXMEM_Write_Register=MEM_Write_Register
wire loaduse_stall;
Data_Hazard Data_Hazard_(rs, rt, EX_MemRead,
                   EX_RegWrite, EX_Write_Register,
                   MEM_RegWrite, MEM_Write_Register,                   
                   ForwardA, ForwardB, loaduse_stall);                
                   
//ForwadA/B
wire [31:0] Aout;
wire [31:0] Bout;
Forward_A Forward_A_(ForwardA, MEM_MemtoReg, ID_forwardA_o, out, MEM_out, MEM_Read_Data, MEM_PC_next, Read_data1);
Forward_B Forward_B_(ForwardB, MEM_MemtoReg, ID_forwardB_o, out, MEM_out, MEM_Read_Data, MEM_PC_next, Read_data2);
assign ID_forwardA_o = Aout;
assign ID_forwardB_o = Bout;

//control hazard
wire true_branch;
assign true_branch = EX_Branch && zero;
ControlHazard ControlHazard_(Jump, true_branch, loaduse_stall, IFID_Flush, IDEX_Flush, PC_holdon, IFID_holdon);


endmodule
