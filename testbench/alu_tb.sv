/*
  ALU testbench

*/
`include "cpu_types_pkg.vh"
`include "alu_if.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if alufif ();

  // test program
  test PROG (alufif.tb);
  // DUT
`ifndef MAPPED
  alu DUT(alufif);
`else
  alu DUT(
    .\alufif.PortA (alufif.PortA),
    .\alufif.PortB (alufif.PortB),
    .\alufif.Output (alufif.Output),
    .\alufif.ALUOP (alufif.ALUOP),
    .\alufif.zero (alufif.zero),
    .\alufif.neg (alufif.neg),
    .\alufif.overflow (alufif.overflow)
  );
`endif
program test(
	alu_if.tb tbif
);
initial
begin
	tbif.PortA = 32'b00000000000000000000000000000001;	
	tbif.PortB = 32'b00000000000000000000000000000001;
	tbif.ALUOP = ALU_SLL;		
	@(negedge CLK);	
	$display("Check now! Shift Left");
	@(negedge CLK);	
	tbif.PortA = 32'b00000000000000000000000000000001;	
	tbif.PortB = 32'b00000000000000000000000000000001;
	tbif.ALUOP = ALU_SRL;
	@(negedge CLK);	
	$display("Check now! Shift Right");
	@(negedge CLK);
	tbif.PortA = 32'b10000000000000000000000000000000;	
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_ADD;
	@(negedge CLK);
	$display("Check now! Add -ve and -ve");
	@(negedge CLK);	
	@(negedge CLK);
	tbif.PortA = 32'b01111111111111111111111111111111;	
	tbif.PortB = 32'b01111111111111111111111111111111;
	tbif.ALUOP = ALU_ADD;
	@(negedge CLK);
	$display("Check now! Add +ve and +ve");
	@(negedge CLK);	
	@(negedge CLK);
	tbif.PortA = 32'b10000000000000000000000000000000;	
	tbif.PortB = 32'b01111111111111111111111111111111;
	tbif.ALUOP = ALU_ADD;
	@(negedge CLK);
	$display("Check now! Add -ve and +ve");
	@(negedge CLK);	
	tbif.PortA = 32'b10000000000000000000000000000000;	
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_SUB;
	@(negedge CLK);
	$display("Check now! Sub -ve and -ve");
	@(negedge CLK);	
	@(negedge CLK);
	tbif.PortA = 32'b01111111111111111111111111111111;	
	tbif.PortB = 32'b01111111111111111111111111111111;
	tbif.ALUOP = ALU_SUB;
	@(negedge CLK);
	$display("Check now! Sub +ve and +ve");
	@(negedge CLK);	
	@(negedge CLK);
	tbif.PortA = 32'b10000000000000000000000000000000;	
	tbif.PortB = 32'b01111111111111111111111111111111;
	tbif.ALUOP = ALU_SUB;
	@(negedge CLK);
	$display("Check now! Sub -ve and +ve");
	@(negedge CLK);
	@(negedge CLK);	
	tbif.PortA = 32'b01111111111111111111111111111111;
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_SUB;
	@(negedge CLK);
	$display("Check now! Sub +ve and -ve");
	@(negedge CLK);
	@(negedge CLK);	
	tbif.PortA = 32'b01111111111111111111111111111111;
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_AND;
	@(negedge CLK);
	$display("Check now! AND");
	@(negedge CLK);
	@(negedge CLK);	
	tbif.PortA = 32'b01111111111111111111111111111111;
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_OR;
	@(negedge CLK);
	$display("Check now! OR");
	@(negedge CLK);
	@(negedge CLK);	
	tbif.PortA = 32'b01111111111111111111111111111111;
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_XOR;
	@(negedge CLK);
	$display("Check now! XOR");
	@(negedge CLK);
	@(negedge CLK);	
	tbif.PortA = 32'b01111111111111111111111111111111;
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_NOR;
	@(negedge CLK);
	$display("Check now! NOR");
	@(negedge CLK);
	@(negedge CLK);	
	tbif.PortA = 32'b01111111111111111111111111111111;
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_SLT;
	@(negedge CLK);
	$display("Check now! SLT");
	@(negedge CLK);
	@(negedge CLK);	
	tbif.PortA = 32'b01111111111111111111111111111111;
	tbif.PortB = 32'b10000000000000000000000000000000;
	tbif.ALUOP = ALU_SLTU;
	@(negedge CLK);
	$display("Check now! STLU");
	@(negedge CLK);
	$finish;
end
endprogram
endmodule

