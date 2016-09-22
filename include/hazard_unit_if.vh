`ifndef hazard_unit_IF_VH
`define hazard_unit_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic ihit, dhit, IFID_en, IDEX_en, EXMEM_en, MEMWB_en, PCEN; 
  regbits_t Rs_ID, Wsel_ex, Wsel_mem;

  modport hz (
    input ihit, dhit, Rs_ID, Wsel_mem, Wsel_ex,
    output IFID_en, IDEX_en, EXMEM_en, MEMWB_en, PCEN
  );
  modport tb (
    output ihit, dhit, Rs_ID, Wsel_mem, Wsel_ex,
    input IFID_en, IDEX_en, EXMEM_en, MEMWB_en, PCEN
    );
  endinterface
  `endif