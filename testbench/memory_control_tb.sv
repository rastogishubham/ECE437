/*
  ALU testbench

*/
`include "cpu_types_pkg.vh"
`include "cache_control_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"
//`include "system_if.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  caches_if cif0();
  caches_if cif1();

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  cache_control_if #(.CPUS(2)) ccif (cif0, cif1);
  cpu_ram_if ramif();

  // test program
  test PROG (CLK, nRST, cif0, cif1);
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
  ram ramDUT(CLK, nRST, ramif);
`endif

assign ramif.ramaddr = ccif.ramaddr;
assign ramif.ramstore = ccif.ramstore;
assign ramif.ramREN = ccif.ramREN;
assign ramif.ramWEN = ccif.ramWEN;
assign ccif.ramstate = ramif.ramstate;
assign ccif.ramload = ramif.ramload;

endmodule
program test(
	input logic CLK,
	output logic nRST,
	caches_if tbif,
	caches_if tbif2
);
initial
begin
	@(posedge CLK);
	nRST = 0;
	@(posedge CLK);
	nRST = 1;
	@(posedge CLK);


	//Testcase 1: Ramwrite and ccinv = 0
	tbif2.ccwrite = 0;
	tbif.ccwrite = 0;
	tbif.cctrans = 0;
	tbif2.cctrans = 0;
	tbif.dREN = 0;
	tbif.dWEN = 0;
	tbif.daddr = 0;
	tbif.dstore = 0;
	tbif.iREN = 0;
	tbif.iaddr = 0;
	tbif2.dREN = 0;
	tbif2.dWEN = 0;
	tbif2.daddr = 0;
	tbif2.dstore = 0;
	tbif2.iREN = 0;
	tbif2.iaddr = 0;
	@(posedge CLK);
	tbif.cctrans = 1;
	tbif2.cctrans = 1;
	tbif.dREN = 1;
	tbif2.dWEN = 1;
	tbif.daddr = 32'hBBBBBBBB;
	tbif2.daddr = 32'hBBBBBBBC;
	tbif2.dstore = 32'hB00B1E5;
	@(posedge CLK);
	@(posedge CLK);
	tbif2.ccwrite = 1;
	tbif.ccwrite = 0;
	tbif2.daddr = 32'hBBBBBBBB;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	tbif.daddr = 32'hBBBBBBBB + 4;
	tbif2.daddr = 32'hBBBBBBBB + 4;
	tbif2.dstore = 32'hA551A551;
	@(posedge CLK);
	@(posedge CLK);

	//Testcase 2: ramread and ccinv = 1
	tbif2.ccwrite = 0;
	tbif.ccwrite = 0;
	tbif.cctrans = 0;
	tbif2.cctrans = 0;
	tbif.dREN = 0;
	tbif.dWEN = 0;
	tbif.daddr = 0;
	tbif.dstore = 0;
	tbif.iREN = 0;
	tbif.iaddr = 0;
	tbif2.dREN = 0;
	tbif2.dWEN = 0;
	tbif2.daddr = 0;
	tbif2.dstore = 0;
	tbif2.iREN = 0;
	tbif2.iaddr = 0;

	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	tbif.cctrans = 0;
	tbif2.cctrans = 1;
	tbif2.dREN = 1;
	tbif2.daddr = 32'hBBBBBBBC;
	@(posedge CLK);
	@(posedge CLK);
	tbif2.ccwrite = 1;
	tbif.ccwrite = 0;
	tbif2.daddr = 32'hBBBBBBBB;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	//tbif.daddr = 32'hBBBBBBBB + 4;
	tbif2.daddr = 32'hBBBBBBBB + 4;
	//tbif2.dstore = 32'hA551A551;
	@(posedge CLK);
	@(posedge CLK);
	
	//Testcase 3: WB 
	tbif2.ccwrite = 0;
	tbif.ccwrite = 0;
	tbif.cctrans = 0;
	tbif2.cctrans = 0;
	tbif.dREN = 0;
	tbif.dWEN = 0;
	tbif.daddr = 0;
	tbif.dstore = 0;
	tbif.iREN = 0;
	tbif.iaddr = 0;
	tbif2.dREN = 0;
	tbif2.dWEN = 0;
	tbif2.daddr = 0;
	tbif2.dstore = 0;
	tbif2.iREN = 0;
	tbif2.iaddr = 0;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);

	@(posedge CLK);
	tbif.cctrans = 1;
	tbif2.cctrans = 1;
	tbif.dWEN = 1;
	tbif2.dREN = 1;
	tbif.daddr = 32'hBBBBBBBB;
	tbif2.daddr = 32'hBBBBBBBC;
	tbif.dstore = 32'hB00B1E5;
	@(posedge CLK);
	@(posedge CLK);
	tbif.daddr = 32'hDEADDEAD;
	@(posedge CLK);
	@(posedge CLK);
	tbif.daddr = 32'hDEADDEAD + 4;
	//tbif2.daddr = 32'hBBBBBBBB + 4;
	tbif.dstore = 32'hA551A551;
	@(posedge CLK);
	@(posedge CLK);

	tbif2.ccwrite = 0;
	tbif.ccwrite = 0;
	tbif.cctrans = 0;
	tbif2.cctrans = 0;
	tbif.dREN = 0;
	tbif.dWEN = 0;
	tbif.daddr = 0;
	tbif.dstore = 0;
	tbif.iREN = 0;
	tbif.iaddr = 0;
	tbif2.dREN = 0;
	tbif2.dWEN = 0;
	tbif2.daddr = 0;
	tbif2.dstore = 0;
	tbif2.iREN = 0;
	tbif2.iaddr = 0;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	$finish;
	/*
	//ccif.ramstate = FREE;
	nRST = 0;
	@(negedge CLK);	
	@(negedge CLK);
	nRST = 1;
	@(negedge CLK);
	tbif.dWEN = 1;
	tbif2.dWEN = 0;
	tbif.daddr = 32'hBBBBBBBB;
	tbif.dstore = 32'hFFFFFFFF;
	tbif2.daddr = 32'h00000000;
	tbif2.dstore = 32'h00000000;
	//ramif.ramaddr = 
	//ccif.ramstate = ACCESS;
/*	@(negedge CLK);
	@(negedge CLK);
	@(negedge CLK);
	tbif.daddr = 32'hBBBBBBBC;
	tbif.dstore = 32'hFFFFFFFD;
	tbif2.daddr = 32'h00000000;
	tbif2.dstore = 32'h00000000;
@(negedge CLK);
	@(negedge CLK);
	tbif.dWEN = 0;
	tbif.dREN = 1;
	@(negedge CLK);
	@(negedge CLK);
	@(negedge CLK);
	tbif.dstore = 32'h00000000;
	@(negedge CLK);
	@(negedge CLK);
	@(negedge CLK);
	if(ccif.ramWEN == 1)
		$display("ramWEN right!");
	else
		$display("ramWEN wrong!");
	if(ccif.ramREN == 0)
		$display("ramREN right");
	else
		$display("ramREN wrong");
	if(ccif.ramaddr == 32'hBBBBBBBB)
		$display("ramaddr right");
	else
		$display("ramaddr wrong");
	if(ccif.ramstore == 32'hFFFFFFFF)
		$display("ramstore right!");
	else
		$display("ramstore wrong");
	if(ccif.dload == 0)
		$display("dload right");
	else
		$display("dload wrong");
	if(ccif.ramload == 32'hFFFFFFFF)
		$display("ramload right!");
	else
		$display("ramload wrong");

	dump_memory();
	$finish;*/
end

endprogram


