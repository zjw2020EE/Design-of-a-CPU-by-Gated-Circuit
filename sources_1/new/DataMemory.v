`timescale 1ns / 1ps
module DataMemory(sysclk, reset, Address, Write_Data, Read_Data, MemWrite, MemRead, lbflag, leds, BCD7, AN);
//input signals
input sysclk;
input reset;
input wire [31:0] Address;
input wire [31:0] Write_Data;
input wire MemWrite;
input wire MemRead;
input wire lbflag;
//output signals
output [31:0] Read_Data;
output reg [7:0] leds;
output reg [7:0] BCD7;
output reg [3:0] AN;

parameter MEM_SIZE = 512;
reg [31:0] MEM_data[MEM_SIZE - 1: 0];
 initial
  begin
    MEM_data[0] = 32'h756e696c;
    MEM_data[1] = 32'h73692078;
    MEM_data[2] = 32'h746f6e20;
    MEM_data[3]= 32'h696e7520;
    MEM_data[4]= 32'h73692078;
    MEM_data[5]= 32'h746f6e20;
    MEM_data[6]= 32'h696e7520;
    MEM_data[7]= 32'h73692078;
    MEM_data[8]= 32'h746f6e20;
    MEM_data[9]= 32'h696e7520;
    MEM_data[10]= 32'h73692078;
    MEM_data[11]= 32'h696e7520;
    MEM_data[12]= 32'h00000a78;
    MEM_data[100]= 32'h78696e75;
    leds <= 8'b1;
    BCD7 <= 8'b0111111;
    AN <= 4'b0;
    end

wire [29:0] byte_cnt;
assign byte_cnt = Address[31:2];
wire [31:0] temp_data;
wire [7:0] temp_char;
assign temp_data = (byte_cnt < MEM_SIZE) ? MEM_data[byte_cnt] : 32'b0;
assign temp_char = (byte_cnt < MEM_SIZE) ? ((Address[1:0]==2'b00)?{temp_data[7:0]}:(Address[1:0]==2'b01)?{temp_data[15:8]}:(Address[1:0]==2'b10)?{temp_data[23:16]}:{temp_data[31:24]}) : 8'b0;
assign Read_Data = MemRead ? lbflag ? {24'b0,temp_char} : (Address == 32'h4000000C) ? {24'b0,leds} : (Address == 32'h40000010) ? {20'b0,AN,BCD7} :32'h00000000:temp_data;



always @(posedge reset or posedge sysclk) 
begin
    if(reset)begin
     MEM_data[0] = 32'h756e696c;
     MEM_data[1] = 32'h73692078;
     MEM_data[2] = 32'h746f6e20;
     MEM_data[3]= 32'h696e7520;
     MEM_data[4]= 32'h73692078;
     MEM_data[5]= 32'h746f6e20;
     MEM_data[6]= 32'h696e7520;
     MEM_data[7]= 32'h73692078;
     MEM_data[8]= 32'h746f6e20;
     MEM_data[9]= 32'h696e7520;
     MEM_data[10]= 32'h73692078;
     MEM_data[11]= 32'h696e7520;
     MEM_data[12]= 32'h00000a78;
     MEM_data[100]= 32'h78696e75;
     leds <= 8'b1;
     BCD7 <= 8'b0111111;
     AN <= 4'b0;
     end
     else if (MemWrite) 
            if(byte_cnt < MEM_SIZE) MEM_data[byte_cnt] <= Write_Data;
                else if (Address==32'h4000000C) leds <= Write_Data[7:0];
                    else if (Address==32'h40000010)begin BCD7 <= Write_Data[7:0]; AN <= Write_Data[11:8];end
    end
endmodule
