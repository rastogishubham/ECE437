`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
import cpu_types_pkg::*;

`timescale 1 ns / 1 ns

module icache_tb;

	parameter PERIOD = 10;

	logic CLK = 0, nRST;

	always #(PERIOD/2) CLK++;

	datapath_cache_if dpicif ();
	caches_if cichif ();

	test PROG (CLK, nRST, dpicif.icache_tb, cichif.icache_tb);
`ifndef MAPPED
  icache DUT (CLK, nRST, dpicif, cichif);
`endif
endmodule

program test (
	input logic CLK,
	output logic nRST,
	datapath_cache_if.icache_tb tb_dp,
	caches_if.icache_tb tb_ca
);
initial
begin
	nRST = 0;
	@(negedge CLK);	
	@(negedge CLK);
	nRST = 1;
	tb_dp.imemaddr = 32'b10101010101010101010101010000010;
	tb_dp.imemREN = 1;
	tb_ca.iwait = 1;
	@(negedge CLK);
	tb_ca.iwait = 0;
	tb_ca.iload = 32'hB00B1E5;
	@(negedge CLK);
	tb_dp.imemaddr = 32'b10101010101010101010101010000010;
	@(negedge CLK);
	if(tb_dp.ihit == 1)
	begin
		$display("Passed 1");
	end
	else
	begin
		$display("Failed 1");
	end
	if (tb_dp.imemload == 32'hB00B1E5)
	begin
		$display("Passed 2");
	end
	else
	begin
		$display("Failed 2");
	end
	if (tb_ca.iREN == 1)
	begin
		$display("Failed 3");
	end
	else
	begin
		$display("Passed 3");
	end
	@(negedge CLK);
	tb_dp.imemaddr = 32'b10101010101010101010101011000110;
	tb_ca.iwait = 1;
	@(negedge CLK);
	tb_ca.iwait = 0;
	tb_ca.iload = 32'hDEADB00B;
	@(negedge CLK);
	tb_dp.imemaddr = 32'b10101010101010101010101001001010;
	tb_ca.iwait = 1;
	@(negedge CLK);
	tb_ca.iwait = 0;
	tb_ca.iload = 32'hB00BDEAD;
	@(negedge CLK);
	tb_dp.imemaddr = 32'b10100010101010101010101001001010; //Incorrect Tag test
	tb_ca.iwait = 1;
	@(negedge CLK);
	@(negedge CLK);
	tb_ca.iwait = 0;
	tb_ca.iload = 32'h5EC50000;
	@(negedge CLK);
	$finish;
end
endprogram
