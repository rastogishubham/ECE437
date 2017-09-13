/*
  Eric Villasenor
  evillase@gmail.com

  system interface
*/
`ifndef SYSTEM_IF_VH
`define SYSTEM_IF_VH

// types
`include "cpu_types_pkg.vh"

interface system_if;
  // import types
  import cpu_types_pkg::*;

  logic               dumpCTRL, tbCTRL, halt, WEN, REN, dump;
  word_t              addr, store, load;

  // system ports
  modport sys (
    input   tbCTRL, WEN, REN, store, addr, dump,
    output  load, halt, dumpCTRL
  );
  // testbench program
  modport tb (
    input   load, halt, dumpCTRL,
    output  tbCTRL, WEN, REN, store, addr, dump
  );
endinterface

`endif //SYSTEM_IF_VH
