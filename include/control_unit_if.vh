`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic PCSrc, MemtoReg, RegWrite, JAL, ExtOP, dWEN, dREN, imemREN, LUI, BNE, Halt;
  logic [1:0] ALUSrc, RegDest, JumpSel;
  aluop_t ALUOP;
  regbits_t Rs, Rt, Rd;
  logic [15:0] Imm;
  word_t shamt, Instr;

 
  modport cu (
    input   Instr,
    output  PCSrc, MemtoReg, RegWrite, JAL, ExtOP, 
    dWEN, dREN, imemREN, LUI, ALUSrc, RegDest, 
    JumpSel, ALUOP, Rs, Rt, Rd, Imm, shamt, BNE, Halt
  );

  modport tb (
    output   Instr,
    input  PCSrc, MemtoReg, RegWrite, JAL, ExtOP, 
    dWEN, dREN, imemREN, LUI, ALUSrc, RegDest, 
    JumpSel, ALUOP, Rs, Rt, Rd, Imm, shamt, BNE, Halt
  );

endinterface

`endif 
