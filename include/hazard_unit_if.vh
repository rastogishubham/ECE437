`ifndef hazard_unit_IF_VH
`define hazard_unit_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;
 
  regbits_t Rs_EX, Rt_EX, Wsel_mem, Rt_mem, Wsel_wb;
  word_t wdat_MEM, wdat_WB;
  word_t read_val; 

  modport hz (
    input Rs_EX, Rt_ID, Wsel_mem, Rt_mem, Wsel_wb, wdat_MEM, wdat_WB,
    output read_val;
  );
  modport tb (
    output Rs_EX, Rt_ID, Wsel_mem, Rt_mem, Wsel_wb, wdat_MEM, wdat_WB,
    input read_val;
    );
  endinterface
  `endif