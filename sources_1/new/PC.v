`timescale 1ns / 1ps
module PC(reset, sysclk, PC_Write, PC_i, PC_o);
    //Input Clock Signals
    input reset;             
    input sysclk;
    //Input Control Signals             
    input PC_Write;
    //Input PC             
    input [31:0] PC_i;
    //Output PC  
    output reg [31:0] PC_o; 


    always@(posedge reset or posedge sysclk)
    begin
        if(reset) begin
            PC_o <= 32'h00400000;
        end else if (PC_Write == 1) begin
            PC_o <= PC_i;
        end else begin
            PC_o <= PC_o;
        end
    end
endmodule