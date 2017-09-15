`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"
module request_unit (
  input logic CLK, nRST,
  request_unit_if.ru reqif
);

  import cpu_types_pkg::*;
  word_t instruction;
  always_ff @(posedge CLK, negedge nRST)
  begin
	if(!nRST)
	begin
		reqif.dmemWEN <= 0;
		reqif.dmemREN <= 0;
		instruction <= 0;
	end
	else
	begin
		if(reqif.ihit)
		begin
			reqif.dmemREN <= reqif.dREN;
			reqif.dmemWEN <= reqif.dWEN;
			instruction <= reqif.imemload;
		end
		else if(reqif.dhit)
		begin
			reqif.dmemWEN <= 0;
			reqif.dmemREN <= 0;
		end
	end
  end
  assign reqif.PCEN = reqif.ihit;
  assign reqif.instr = (reqif.ihit) ? reqif.imemload : instruction;
endmodule
