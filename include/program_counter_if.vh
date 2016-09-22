`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

`include "cpu_types_pkg.vh"

interface program_counter_if;
	import cpu_types_pkg::*;
	word_t PCNext, PCOut;
	logic PCEN;
	
	modport pc (
		input PCEN, PCNext,
		output PCOut
	);
	modport tb (
		output PCEN, PCNext,
		input PCOut
	);

endinterface
`endif
