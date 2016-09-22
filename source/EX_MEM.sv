`include "cpu_types_pkg.vh"
`include "EX_MEM_if.vh"
module EX_MEM (
  input logic CLK, nRST,
  EX_MEM_if.exmem exmemif
);
  import cpu_types_pkg::*;
  always_ff @(posedge CLK, negedge nRST)
  begin
  		if(!nRST)
  		begin
        exmemif.dWEN_out <= '0; 
        exmemif.dREN_out <= '0;
        exmemif.RegWrite_out <= '0;
        exmemif.LUI_out <= '0;
        exmemif.Halt_out <= '0;
        exmemif.MemToReg_out <= '0;
        exmemif.wsel_out <= '0;
        exmemif.opcode_out <= opcode_t'('0);
        exmemif.Porto_out <= '0;
        exmemif.pcp4_out <= '0;
        exmemif.dmemstr_out <= '0;
  		end
      else
      begin
        if(exmemif.flush)
        begin
          exmemif.dWEN_out <= '0; 
          exmemif.dREN_out <= '0;
          exmemif.RegWrite_out <= '0;
          exmemif.LUI_out <= '0;
          exmemif.Halt_out <= '0;
          exmemif.MemToReg_out <= '0;
          exmemif.wsel_out <= '0;
          exmemif.opcode_out <= opcode_t'('0);
          exmemif.Porto_out <= '0;
          exmemif.pcp4_out <= '0;
          exmemif.dmemstr_out <= '0;
        end
  		  if(exmemif.ihit | exmemif.dhit)
  		  begin
          //exmemif.dWEN_out <= exmemif.dWEN_in;
          //exmemif.dREN_out <= exmemif.dREN_in;
          exmemif.RegWrite_out <= exmemif.RegWrite_in;
          exmemif.LUI_out <= exmemif.LUI_in;
          exmemif.Halt_out <= exmemif.Halt_in;
          exmemif.MemToReg_out <= exmemif.MemToReg_in;
          exmemif.wsel_out <= exmemif.wsel_in;
          exmemif.opcode_out <= exmemif.opcode_in;
          exmemif.Porto_out <= exmemif.Porto_in;
          exmemif.pcp4_out <= exmemif.pcp4_in;
          exmemif.dmemstr_out <= exmemif.dmemstr_in;
        /*  if(exmemif.dhit)
          begin
            exmemif.dWEN_out <= 0;
            exmemif.dREN_out <= 0;
          end
          else*/
          if(exmemif.ihit)
          begin
            exmemif.dWEN_out <= exmemif.dWEN_in;
            exmemif.dREN_out <= exmemif.dREN_in;
          end
  		  end
      end
  	/*	else
  		begin
  			exmemif.dWEN_out = exmemif.dWEN_out;
        exmemif.dREN_out = exmemif.dREN_out;
        exmemif.RegWrite_out = exmemif.RegWrite_out;
        exmemif.LUI_out = exmemif.LUI_out;
        exmemif.Halt_out = exmemif.Halt_out;
        exmemif.MemToReg_out = exmemif.MemToReg_out;
        exmemif.wsel_out = exmemif.wsel_out;
        exmemif.Porto_out = exmemif.Porto_out;
        exmemif.pcp4_out = exmemif.pcp4_out;
  		end*/
    end
  endmodule
