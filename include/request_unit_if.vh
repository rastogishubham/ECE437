`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic     PCEN, dhit, ihit, dREN, dWEN, dmemREN, dmemWEN;

  modport ru (
    input   dhit, ihit, dWEN, dREN,
    output  dmemREN, dmemWEN, PCEN
  );
  
  modport tb (
    output   dhit, ihit, dWEN, dREN,
    input  dmemREN, dmemWEN, PCEN
  );
endinterface

`endif 
