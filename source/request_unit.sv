`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"
module request_unit (
  input logic CLK, nRST,
  request_unit_if.ru reqif
);
  import cpu_types_pkg::*;
  always_ff @(posedge CLK, negedge nRST)
  begin
	if(!nRST)
	begin
		reqif.dmemWEN <= 0;
		reqif.dmemREN <= 0;
	end
	/*else if(reqif.ihit && reqif.dREN)
	begin
		reqif.dmemREN <= reqif.dREN;
	end
	else if(reqif.ihit && reqif.dWEN)
	begin
		reqif.dmemWEN <= reqif.dWEN;
	end*/
	/*else if(reqif.ihit)
	begin
		reqif.dmemREN <= reqif.dREN;
		reqif.dmemWEN <= reqif.dWEN;
	end
	else if(reqif.dhit)
	begin
		reqif.dmemWEN <= 0;
		reqif.dmemREN <= 0;
	end
	else
	begin
		reqif.dmemWEN <= 0;
		reqif.dmemREN <= 0;
	end*/
	else
	begin
		if(reqif.ihit)
		begin
			reqif.dmemREN <= reqif.dREN;
			reqif.dmemWEN <= reqif.dWEN;
		end
		else if(reqif.dhit)
		begin
			reqif.dmemWEN <= 0;
			reqif.dmemREN <= 0;
		end
	end
  end
  assign reqif.PCEN = reqif.ihit;
endmodule
