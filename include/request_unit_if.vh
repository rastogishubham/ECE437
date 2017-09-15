`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic     PCEN, dhit, ihit, dREN, dWEN, dmemREN, dmemWEN;
  word_t    imemload, instr;

  modport ru (
    input   dhit, ihit, dWEN, dREN, imemload,
    output  dmemREN, dmemWEN, PCEN, instr
  );
  
  modport tb (
    output   dhit, ihit, dWEN, dREN, imemload,
    input  dmemREN, dmemWEN, PCEN, instr
  );
endinterface

`endif 
