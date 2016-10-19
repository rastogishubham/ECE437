`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
import cpu_types_pkg::*;

`timescale 1 ns / 1 ns

module dcache_tb;

	parameter PERIOD = 10;

	logic CLK = 0, nRST;

	always #(PERIOD/2) CLK++;

	datapath_cache_if dpicif ();
	caches_if cichif ();

	test PROG (CLK, nRST, dpicif.dcache_tb, cichif.dcache_tb);
`ifndef MAPPED
  dcache DUT (CLK, nRST, dpicif, cichif);
`endif
endmodule

program test (
	input logic CLK,
	output logic nRST,
	datapath_cache_if.dcache_tb tb_dp,
	caches_if.dcache_tb tb_ca
);
initial
begin
	nRST = 0;
	@(posedge CLK);	
	@(posedge CLK);
	nRST = 1;
	tb_dp.dmemaddr = 32'b00000000000000000000000001000000;
	tb_dp.dmemWEN = 1;
	tb_dp.dmemREN = 0;
	tb_dp.dmemstore = 32'hB00B1E5;
	if(tb_ca.dREN | tb_ca.dWEN) 
	begin
		tb_ca.dwait = 1;
	end
	@(posedge CLK);
	tb_ca.dwait = 0;
	tb_ca.dload = 32'hDEADBEEF;
	@(posedge CLK);
	tb_ca.dwait = 1;
	@(posedge CLK);
	tb_ca.dwait = 0;
	tb_ca.dload = 32'hDEADBEEF;
	@(posedge CLK);
	@(posedge CLK);
	//tb_dp.halt = 1;
	tb_dp.dmemWEN = 0;
	tb_dp.dmemaddr = 32'b00000000000000000000000011000000;
	@(posedge CLK);
	tb_dp.dmemREN = 1;
	tb_dp.dmemaddr = 32'b00000000000000000000000001000000;
	@(posedge CLK);
	tb_dp.dmemaddr = 32'b00000000000000000000000111000100;
	tb_dp.dmemWEN = 1;
	tb_dp.dmemREN = 0;
	tb_dp.dmemstore = 32'hDEADDEAD;
	if(tb_ca.dREN | tb_ca.dWEN) 
	begin
		tb_ca.dwait = 1;
	end
	@(posedge CLK);
	tb_ca.dwait = 0;
	tb_ca.dload = 32'hBEEFDEAD;
	@(posedge CLK);
	tb_ca.dwait = 1;
	@(posedge CLK);
	tb_ca.dwait = 0;
	tb_ca.dload = 32'hBEEFDEAD;
	@(posedge CLK);
	@(posedge CLK);
	tb_dp.dmemaddr = 32'b00000000000000000000001111000000;
	tb_dp.dmemREN = 1;
	tb_dp.dmemWEN = 0;
	@(posedge tb_dp.dhit);
	@(posedge CLK);
	tb_dp.halt = 1;
	tb_dp.dmemWEN = 0;
	tb_dp.dmemREN = 0;
	tb_dp.dmemaddr = 32'b10000000000000000000000000000000;
	@(posedge tb_dp.flushed)
	@(posedge CLK);
	$finish;
end
endprogram
