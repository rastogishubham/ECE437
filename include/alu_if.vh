`ifndef ALU_IF_VH
`define ALU_IF_VH

`include "cpu_types_pkg.vh"

interface alu_if;
	import cpu_types_pkg::*;
	word_t PortA, PortB, Output;
	logic zero, overflow, neg;
	aluop_t ALUOP;
	
	modport aluf (
		input PortA, PortB, ALUOP,
		output overflow, neg, zero, Output
	);
	modport tb (
		input overflow, neg, zero, Output,
		output PortA, PortB, ALUOP
	);

endinterface
`endif
