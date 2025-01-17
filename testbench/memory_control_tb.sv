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
  cache_control_if #(.CPUS(1)) ccif (cif0, cif1);
  cpu_ram_if ramif();

  // test program
  test PROG (CLK, nRST, cif0, cif1);//, ccif, ramif);
  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
  ram ramDUT(CLK, nRST, ramif);
`else
  memory_control DUT(
	.\CLK(CLK),
	.\nRST(nRST),
	.\ccif.iREN(ccif.iREN),
	.\ccif.dREN(ccif.dREN),
	.\ccif.dWEN(ccif.dWEN),
	.\ccif.dstore(ccif.dstore),
	.\ccif.iaddr(ccif.iaddr),
	.\ccif.daddr(ccif.daddr),
	.\ccif.ramload(ccif.ramload),
	.\ccif.ramstate(ccif.ramstate),
	.\ccif.iwait(ccif.iwait),
	.\ccif.dwait(ccif.dwait),
	.\ccif.iload(ccif.iload),
	.\ccif.dload(ccif.dload),
	.\ccif.ramstore(ccif.ramstore),
	.\ccif.ramaddr(ccif.ramaddr),
	.\ccif.ramWEN(ccif.ramWEN),
	.\ccif.ramREN(ccif.ramREN)
  );
  ram ramDUT(
	.\CLK(CLK),
	.\nRST(nRST),
	.\ramif.ramaddr(ramif.ramaddr),
	.\ramif.ramstore(ramif.ramstore),
	.\ramif.ramREN(ramif.ramREN),
	.\ramif.ramWEN(ramif.ramWEN),
	.\ramif.ramstate(ramif.ramstate),
	.\ramif.ramload(ramif.ramload)
  );
	
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
	//cache_control_if ccif,
	//cpu_ram_if.ram ramif
);
initial
begin
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
	tbif2.dstore = 32'h00000000;*/
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
	$finish;
end

task automatic dump_memory();
  
    string filename = "memcpu.hex";
    int memfd;
    //ccif.tbCTRL = 1;
    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      //ccif.tbCTRL = 0;
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask

endprogram


