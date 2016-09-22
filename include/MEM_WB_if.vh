`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface MEM_WB_if;
  // import types
  import cpu_types_pkg::*;

  logic Halt_in, RegWrite_in;
  logic dhit, ihit;
  logic [1:0] MemToReg_in;
  regbits_t wsel_in;
  opcode_t opcode_in;
  word_t pcp4_in, LUI_in, Porto_in, dmemload_in;

  logic Halt_out, RegWrite_out;
  logic [1:0] MemToReg_out;
  regbits_t wsel_out;
  opcode_t opcode_out;
  word_t pcp4_out, LUI_out, Porto_out, dmemload_out;

  modport memwb (
    input Halt_in, RegWrite_in, MemToReg_in, wsel_in, opcode_in, pcp4_in, LUI_in, Porto_in, dmemload_in, ihit, dhit,
    output  Halt_out, RegWrite_out, MemToReg_out, wsel_out, opcode_out, pcp4_out, LUI_out, Porto_out, dmemload_out
  );
  
  modport tb (
    output Halt_in, RegWrite_in, MemToReg_in, wsel_in, opcode_in, pcp4_in, LUI_in, Porto_in, dmemload_in, ihit, dhit,
    input  Halt_out, RegWrite_out, MemToReg_out, wsel_out, opcode_out, pcp4_out, LUI_out, Porto_out, dmemload_out
  );
endinterface

`endif 