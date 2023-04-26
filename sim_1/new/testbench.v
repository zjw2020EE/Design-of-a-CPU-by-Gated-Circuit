`timescale 1ns / 1ps
module testbench();
reg sysclk;
reg reset;
wire [3:0] AN;
wire [7:0] BCD7;
wire [7:0] leds;

CPU CPU_(sysclk,reset,leds,BCD7,AN);

initial begin
    sysclk <= 0;
    reset <= 1;
    #100 reset <= 1;
    #100 reset <= 0;
end
    
always #5 sysclk <= ~sysclk;
    
endmodule
