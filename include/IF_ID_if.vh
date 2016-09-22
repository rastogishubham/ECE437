`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface IF_ID_if;
  // import types
  import cpu_types_pkg::*;

  logic ihit, flush;
  word_t imemload, instr, pcp4_in, pcp4_out;

  modport ifid (
    input imemload, pcp4_in, flush, ihit,
    output instr, pcp4_out
  );
  modport tbid (
    output imemload, pcp4_in, flush, ihit,
    input instr, pcp4_out
  );
  endinterface
  `endif