`timescale 1ns / 1ps
module ALU(in1, in2, ALUCtrl, Sign, out, zero);
	input [31:0] in1, in2;
    input [4:0] ALUCtrl;
    input Sign;
    output reg [31:0] out;
    output zero;
   // Your code below 
   /*
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
    */
    wire zero;
    assign zero = (out == 0) ? 1 : 0;
    always @(*)
    begin
    case(ALUCtrl)
        5'd0: begin out=in1+in2;  end
        5'd1: begin out=in1-in2;  end
        5'd2: begin out=in1&in2; end
        5'd3: begin out=in1|in2;  end
        5'd4: begin out=in1^in2;  end
        5'd5: begin out=~(in1|in2);  end
        5'd6: begin out=in2<<in1;  end
        5'd7: begin out=in2>>in1;  end
        5'd8: begin out=(in2[31])?({32'hffffffff,in2}>>in1):({32'b0,in2}>>in1); end
        5'd9: begin
        if (Sign) begin
            if (in1[31]==in2[31])begin
                 if(in1[30:0]<in2[30:0])out=1;
                 else out=0;
            end
            else if (in2[31]==0) out=1; else out=0;
            end
        else 
            out=(in1<in2);
        end
        5'd10: begin if(in1 == in2)out = 1;else out = 0;  end
        5'd11: begin if(in1 <= 0)out = 0;else out = 1;  end
        5'd12: begin if(in1 > 0)out = 0;else out = 1;  end
        5'd13: begin if(in1 < 0)out = 0;else out = 1;  end        
        default: begin  out=1;  end
    endcase
    end
	// Your code above



endmodule
