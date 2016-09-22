`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"
import cpu_types_pkg::*;
module hazard_unit (
	input logic CLK, nRST
	hazard_unit_if.hz hzif
);
always_comb
begin
	if(hzif.Rs_EX == hzif.Wsel_mem | hzif.Rt_EX == hzif.Wsel_mem)
	begin
		hzif.read_val = hzif.wdat_MEM;
	end
	else if (hzif.Rs_EX == hzif.Wsel_wb | hzif.Rt_EX == hzif.Wsel_wb)
	begin
		hzif.read_val = hzif.wdat_WB;
	end
end
endmodule 