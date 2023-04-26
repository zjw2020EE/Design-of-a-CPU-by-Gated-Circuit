`timescale 1ns / 1ps
module RegisterFile(reset, sysclk, WB_RegWrite, Read_register1, Read_register2, WB_Write_Register, WB_Write_Data, Read_data1, Read_data2);
	//Input Clock Signals
	input reset;
	input sysclk;
	//Input Control Signals
	input WB_RegWrite;
	//Input Data Signals
	input [4:0] Read_register1;
	input [4:0] Read_register2; 
	input [4:0] WB_Write_Register;
	input [31:0] WB_Write_Data;
	//Output Data Signals
	output [31:0] Read_data1;
	output [31:0] Read_data2;
	
	reg [31:0] RF_data[31:1];
	
	//read data
	assign Read_data1 = (Read_register1 == 5'b00000)? 32'h00000000: (WB_RegWrite && WB_Write_Register == Read_register1) ? WB_Write_Data : RF_data[Read_register1];
	assign Read_data2 = (Read_register2 == 5'b00000)? 32'h00000000: (WB_RegWrite && WB_Write_Register == Read_register2) ? WB_Write_Data : RF_data[Read_register2];
	
	integer i;
	always @(posedge reset or posedge sysclk) begin
		if (reset) begin
			for (i = 1; i < 32; i = i + 1) begin
				RF_data[i] <= 32'h00000000;
			end
		end else if (WB_RegWrite && (WB_Write_Register != 5'b00000)) begin
			RF_data[WB_Write_Register] <= WB_Write_Data;
		end
	end

endmodule