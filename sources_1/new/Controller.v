`timescale 1ns / 1ps
module Controller(OpCode, Funct, 
                MemWrite, MemRead, MemtoReg, 
                RegDst, RegWrite, ExtOp, LuiOp, lbflag,
                ALUSrcA, ALUSrcB, ALUOp, Sign,
                Jump, JumpSrc, Branch);             
//Input Signals                
input [5:0] OpCode;
input [5:0] Funct;
//Output Control Signals             
output reg MemRead;
output reg MemWrite;
output reg [1:0] MemtoReg;               
output reg [1:0] RegDst;              
output reg RegWrite;
output reg ExtOp;
output reg LuiOp;
output reg lbflag;
output reg ALUSrcA;
output reg ALUSrcB;
output reg [4:0] ALUOp;
output reg Sign;
output reg Jump;
output reg JumpSrc;
output reg Branch;

parameter ADD = 0;
parameter SUB = 1;
parameter AND = 2;
parameter OR = 3;
parameter XOR = 4;
parameter NOR = 5;
parameter SLL = 6;
parameter SRL = 7;
parameter SRA = 8;
parameter SLT = 9;
parameter BNE = 10;
parameter BLEZ = 11;
parameter BGTZ = 12;
parameter BLTZ = 13;   
parameter ELSE = 14;

always @(*)
    begin
        if(OpCode===0)begin
        case(Funct)
   /*add*/6'h20:begin ALUOp[4:0] <= ADD; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
  /*addu*/6'h21:begin ALUOp[4:0] <= ADD; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
   /*sub*/6'h22:begin ALUOp[4:0] <= SUB; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
  /*subu*/6'h23:begin ALUOp[4:0] <= SUB; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
       
   /*and*/6'h24:begin ALUOp[4:0] <= AND; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
    /*or*/6'h25:begin ALUOp[4:0] <= OR;  MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
   /*xor*/6'h26:begin ALUOp[4:0] <= XOR; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
   /*nor*/6'h27:begin ALUOp[4:0] <= NOR; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
      
   /*sll*/6'h00:begin ALUOp[4:0] <= SLL; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 1; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
   /*srl*/6'h02:begin ALUOp[4:0] <= SRL; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 1; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
   /*sra*/6'h03:begin ALUOp[4:0] <= SRA; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 1; ALUSrcB <= 0; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
   /*slt*/6'h2a:begin ALUOp[4:0] <= SLT; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end    
  /*sltu*/6'h2b:begin ALUOp[4:0] <= SLT; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b01; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
      
    /*jr*/6'h08:begin ALUOp[4:0] <= ADD; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 1; JumpSrc <= 1; Branch <= 0; end
  /*jalr*/6'h09:begin ALUOp[4:0] <= ADD; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b10; RegDst[1:0] <= 2'b10; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 1; JumpSrc <= 1; Branch <= 0; end
         
        default:begin ALUOp[4:0] <= ELSE; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end       
        endcase      
        end
    else begin
        case(OpCode)
    /*lw*/6'h23:begin ALUOp[4:0] <= ADD; MemRead <= 1; MemWrite <= 0; MemtoReg[1:0] <= 2'b01; RegDst[1:0] <= 2'b00; RegWrite <= 1; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
    /*lb*/6'h20:begin ALUOp[4:0] <= ADD; MemRead <= 1; MemWrite <= 0; MemtoReg[1:0] <= 2'b01; RegDst[1:0] <= 2'b00; RegWrite <= 1; lbflag <= 1; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
    /*sw*/6'h2b:begin ALUOp[4:0] <= ADD; MemRead <= 0; MemWrite <= 1; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end 
   /*lui*/6'h0f:begin ALUOp[4:0] <= ADD; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 1; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
                
  /*addi*/6'h08:begin ALUOp[4:0] <= ADD; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 1; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
 /*addiu*/6'h09:begin ALUOp[4:0] <= ADD; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 1; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
  /*andi*/6'h0c:begin ALUOp[4:0] <= AND; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end 
                 
  /*slti*/6'h0a:begin ALUOp[4:0] <= SLT; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 1; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
 /*sltiu*/6'h0b:begin ALUOp[4:0] <= SLT; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 1; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 1; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end
 
   /*beq*/6'h04:begin ALUOp[4:0] <= SUB; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 1; end        
   /*bne*/6'h05:begin ALUOp[4:0] <= BNE; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 1; end      
  /*blez*/6'h06:begin ALUOp[4:0] <= BLEZ; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 1; end
  /*bgtz*/6'h07:begin ALUOp[4:0] <= BGTZ; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 1; end  
  /*bltz*/6'h01:begin ALUOp[4:0] <= BLTZ; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 1; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 1; Jump <= 0; JumpSrc <= 0; Branch <= 1; end
     
     /*j*/6'h02:begin ALUOp[4:0] <= ELSE; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 1; JumpSrc <= 0; Branch <= 0; end        
   /*jal*/6'h03:begin ALUOp[4:0] <= ELSE; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b10; RegDst[1:0] <= 2'b10; RegWrite <= 1; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 1; JumpSrc <= 0; Branch <= 0; end         
        default:begin ALUOp[4:0] <= ELSE; MemRead <= 0; MemWrite <= 0; MemtoReg[1:0] <= 2'b00; RegDst[1:0] <= 2'b00; RegWrite <= 0; lbflag <= 0; ExtOp <= 0; LuiOp <= 0; ALUSrcA <= 0; ALUSrcB <= 0; Sign <= 0; Jump <= 0; JumpSrc <= 0; Branch <= 0; end       
        endcase           
        end   
    end   
              
endmodule
