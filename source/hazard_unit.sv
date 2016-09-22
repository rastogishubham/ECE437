`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"
import cpu_types_pkg::*;
module hazard_unit (
	hazard_unit_if.hz hzif
);

if(hzif.Rs_ID == hzif.Wsel_ex || hzif.Rt_ID == hzif.Wsel_ex)
begin
	hzif.PCEN = 0;
	hzif.
end
