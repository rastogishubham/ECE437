/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;


  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;
  // interface
  register_file_if rfif ();
  // test program
  test PROG (rfif.tb);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

program test(

register_file_if.tb tbif

);
initial
begin
	nRST = 1'b1;
	@(negedge CLK);
	tbif.WEN = 1'b1;
	tbif.wsel = 5'd20;
	tbif.wdat = 32'd500;
	@(negedge CLK);	
	tbif.wsel = 5'd21;
	tbif.wdat = 32'd501;
	@(negedge CLK);	
	tbif.WEN = 1'b0;
	tbif.rsel1 = 5'd21;
	tbif.rsel2 = 5'd20;
	@(negedge CLK);
	if(tbif.rdat1 == 32'd501 && tbif.rdat2 == 32'd500)
		$display("Works");
	else
		$display("Fuck off");
	@(negedge CLK);		
	tbif.WEN = 1'b1;
	tbif.wsel = 5'd0;
	tbif.wdat = 32'd51;
	tbif.rsel1 = 5'd0;	
	@(negedge CLK);	
	if(tbif.rdat1 == 32'd0)
		$display("Works again!");
	else
		$display("Fuck off again");
	tbif.rsel2 = 5'd20;
	@(negedge CLK);	
	nRST = 1'b0;
	@(negedge CLK);
	nRST = 1'b1;
	@(negedge CLK);
	if(tbif.rdat2 == 32'd0)
		$display("Works again you smart son of a bitch");
	else
		$display("Fuck off, give up on ECE");
	@(negedge CLK);	
	$finish;
end
endprogram
endmodule

