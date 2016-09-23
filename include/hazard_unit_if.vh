`ifndef hazard_unit_IF_VH
`define hazard_unit_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;
  logic RegWrite_mem, RegWrite_wb;
  logic [1:0] Rs_Sel, Rt_Sel;
  regbits_t Rs_EX, Rt_EX, Wsel_mem, Wsel_wb;

  modport hz (
    input Rs_EX, Rt_EX, Wsel_mem, Wsel_wb, RegWrite_mem,
    output Rs_Sel, Rt_Sel
  );
  modport tb (
    output Rs_EX, Rt_EX, Wsel_mem, Wsel_wb, RegWrite_mem,
    input Rs_Sel, Rt_Sel
    );
  endinterface
  `endif