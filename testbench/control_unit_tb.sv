/*
  ALU testbench
  logic PCSrc, MemtoReg, RegWrite, JAL, ExtOP, dWEN, dREN, imemREN, LUI, BNE, Halt;
  logic [1:0] ALUSrc, RegDest, JumpSel;
  aluop_t ALUOP;
  regbits_t Rs, Rt, Rd;
  logic [15:0] Imm;
  word_t shamt, Instr;
*/
`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  control_unit_if cuif ();

  // test program
  test PROG (CLK, nRST, cuif.tb);
  // DUT
`ifndef MAPPED
  control_unit DUT(cuif);
`else
  alu DUT(
    .\cuif.PCSrc (cuif.PCSrc),
    .\cuif.MemtoReg (cuif.MemtoReg),
    .\cuif.RegWrite (cuif.RegWrite),
    .\cuif.JAL (cuif.JAL),
    .\cuif.ExtOp (cuif.ExtOp),
    .\cuif.dWEN (cuif.dWEN),
    .\cuif.dREN (cuif.dREN),
    .\cuif.imemREN (cuif.imemREN),
    .\cuif.LUI (cuif.LUI),
    .\cuif.BNE (cuif.BNE),
    .\cuif.Halt (cuif.Halt),
    .\cuif.ALUSrc (cuif.ALUSrc),
    .\cuif.RegDest (cuif.RegDest),
    .\cuif.JumpSel (cuif.JumpSel),
    .\cuif.ALUOP (cuif.ALUOP),
    .\cuif.Rs (cuif.Rs),
    .\cuif.Rt (cuif.Rt),
    .\cuif.Rd (cuif.Rd),
    .\cuif.Imm (cuif.Imm),
    .\cuif.shamt (cuif.shamt),
    .\cuif.Instr (cuif.Instr)
  );
`endif
program test(
	input logic CLK, output logic nRST,
	control_unit_if.tb tbif
);
initial
begin
	tbif.Instr = 32'b0;
	@(posedge CLK);
	@(posedge CLK);
	tbif.Instr = 32'h340100F0;
	@(posedge CLK);
	@(posedge CLK);
	tbif.Instr = 32'h8C230000;
	@(posedge CLK);
	@(posedge CLK);
	$finish;
end
endprogram
endmodule

