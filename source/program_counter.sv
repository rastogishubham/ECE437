`include "cpu_types_pkg.vh"
`include "program_counter_if.vh"
module program_counter (
  input logic CLK, nRST,
  program_counter_if.pc pcif
);
  import cpu_types_pkg::*;
  always_ff @(posedge CLK, negedge nRST)
  begin
	if(!nRST)
		pcif.PCOut <= '{default: '0};
	else if(pcif.PCEN)
		pcif.PCOut <= pcif.PCNext;
	else
		pcif.PCOut <= pcif.PCOut;
  end
endmodule

