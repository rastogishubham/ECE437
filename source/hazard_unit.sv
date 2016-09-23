`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"
import cpu_types_pkg::*;
module hazard_unit (
	hazard_unit_if.hz hzif
);
always_comb
begin
	if(hzif.RegWrite_mem && hzif.Wsel_mem != 0 && hzif.Rs_EX == hzif.Wsel_mem)
	begin
		hzif.Rs_Sel = 2'b01;
	end
	else if(hzif.RegWrite_wb && hzif.Wsel_wb != 0 && hzif.Rs_EX == hzif.Wsel_wb)
	begin
		hzif.Rs_Sel = 2'b10;
	end
	else
	begin
		hzif.Rs_Sel = 2'b00;
	end
	if(hzif.RegWrite_mem && hzif.Wsel_mem != 0 && hzif.Rt_EX == hzif.Wsel_mem)
	begin
		hzif.Rt_Sel = 2'b01;
	end
	else if(hzif.RegWrite_wb && hzif.Wsel_wb != 0 && hzif.Rt_EX == hzif.Wsel_wb)
	begin
		hzif.Rt_Sel = 2'b10;
	end
	else
	begin
		hzif.Rt_Sel = 2'b00;
	end
end
endmodule 