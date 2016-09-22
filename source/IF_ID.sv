`include "cpu_types_pkg.vh"
`include "IF_ID_if.vh"
module IF_ID (
  input logic CLK, nRST,
  IF_ID_if.ifid ifidif
);
  import cpu_types_pkg::*;
  always_ff @(posedge CLK, negedge nRST)
  begin
  		if(!nRST)
  		begin
  				ifidif.instr <= '0;
          ifidif.pcp4_out <= '0;
  		end
      else if (ifidif.flush)
      begin
        ifidif.instr <= '0;
        ifidif.pcp4_out <= '0; 
      end
  		else if(ifidif.ihit)
  		begin
  			ifidif.instr <= ifidif.imemload;
        ifidif.pcp4_out <= ifidif.pcp4_in;
  		end
  		else
  		begin
  			ifidif.instr <= ifidif.instr;
        ifidif.pcp4_out <= ifidif.pcp4_out;
  		end
    end
  endmodule
