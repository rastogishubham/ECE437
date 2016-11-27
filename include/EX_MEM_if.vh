`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface EX_MEM_if;
  // import types
  import cpu_types_pkg::*;

  logic flush, ihit, dhit, dWEN_in, dREN_in, RegWrite_in, Halt_in, datomic_in;
  logic [1:0] MemToReg_in;
  regbits_t wsel_in;
  opcode_t opcode_in;
  word_t Porto_in, pcp4_in, dmemstr_in, LUI_in;

  logic dWEN_out, dREN_out, RegWrite_out, Halt_out, datomic_out;
  logic [1:0] MemToReg_out;
  regbits_t wsel_out;
  opcode_t opcode_out;
  word_t Porto_out, pcp4_out, dmemstr_out, LUI_out;

  modport exmem (
    input flush, dWEN_in, dREN_in, RegWrite_in, LUI_in, Halt_in, MemToReg_in, wsel_in, opcode_in, Porto_in, pcp4_in, ihit, dhit, dmemstr_in, datomic_in,
    output dWEN_out, dREN_out, RegWrite_out, LUI_out, Halt_out, MemToReg_out, wsel_out, opcode_out, Porto_out, pcp4_out, dmemstr_out, datomic_out
  );
  
  modport tb (
    output flush, dWEN_in, dREN_in, RegWrite_in, LUI_in, Halt_in, MemToReg_in, wsel_in, opcode_in, Porto_in, pcp4_in, ihit, dhit, dmemstr_in, datomic_in,
    input dWEN_out, dREN_out, RegWrite_out, LUI_out, Halt_out, MemToReg_out, wsel_out, opcode_out, Porto_out, pcp4_out, dmemstr_out, datomic_out
  );
endinterface

`endif 
