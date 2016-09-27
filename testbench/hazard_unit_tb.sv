/*
  hazard unit testbench

*/
`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"
import cpu_types_pkg::*;
// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if hzif ();

  // test program
  test PROG (CLK, nRST, hzif.tb);
  // DUT
`ifndef MAPPED
  hazard_unit DUT(hzif);
`else
  hazard_unit DUT(
    .\hzif.Rs_EX (hzif.Rs_EX),
    .\hzif.Rt_EX (hzif.Rt_EX),
    .\hzif.Wsel_mem (hzif.Wsel_mem),
    .\hzif.Wsel_wb (hzif.Wsel_wb),
    .\hzif.RegWrite_mem (hzif.RegWrite_mem),
    .\hzif.RegWrite_wb (hzif.RegWrite_wb),
    .\hzif.Rs_Sel (hzif.Rs_Sel),
    .\hzif.Rt_Sel (hzif.Rt_Sel)
  );
`endif
program test(
	input logic CLK, output logic nRST, hazard_unit_if.tb hzif
);
initial
begin
	hzif.Rs_EX = 1;
	hzif.Wsel_mem = 1;
	hzif.RegWrite_mem = 1;
	@(negedge CLK);
	hzif.Rs_EX = 0;
	hzif.Wsel_mem = 0;
	hzif.RegWrite_mem = 1;
	@(negedge CLK);
	$finish;
end
endprogram
endmodule

