`include "cpu_types_pkg.vh"
`include "MEM_WB_if.vh"
import cpu_types_pkg::*;
module MEM_WB(
	input logic CLK, nRST,
	MEM_WB_if.memwb memwbif
);

always_ff @(posedge CLK, negedge nRST)
begin
	if (!nRST)
	begin
		memwbif.Halt_out <= '0;
 		memwbif.RegWrite_out <= '0;
		memwbif.MemToReg_out <= '0;
		memwbif.wsel_out <= '0;
		memwbif.opcode_out <= opcode_t'('0);
		memwbif.pcp4_out <= '0;
		memwbif.LUI_out <= '0;
		memwbif.Porto_out <= '0;
		memwbif.dmemload_out <= '0;
	end
	else
		if (memwbif.dhit || memwbif.ihit)
		begin
			memwbif.Halt_out <= memwbif.Halt_in;
 			memwbif.RegWrite_out <= memwbif.RegWrite_in;
			memwbif.MemToReg_out <= memwbif.MemToReg_in;
			memwbif.wsel_out <= memwbif.wsel_in;
			memwbif.opcode_out <= memwbif.opcode_in;
			memwbif.pcp4_out <= memwbif.pcp4_in;
			memwbif.LUI_out <= memwbif.LUI_in;
			memwbif.Porto_out <= memwbif.Porto_in;
			memwbif.dmemload_out <= memwbif.dmemload_in;
		end
	/*	else
		begin
			memwbif.Halt_out <= memwbif.Halt_out;
 			memwbif.RegWrite_out <= memwbif.RegWrite_out;
			memwbif.MemToReg_out <= memwbif.MemToReg_out;
			memwbif.wsel_out <= memwbif.wsel_out;
			memwbif.opcode_out <= memwbif.opcode_out;
			memwbif.pcp4_out <= memwbif.pcp4_out;
			memwbif.LUI_out <= memwbif.LUI_out;
			memwbif.Porto_out <= memwbif.Porto_out;
			memwbif.dmemload_out <= memwbif.dmemload_out;
		end*/
	end
endmodule // memwbif_WB