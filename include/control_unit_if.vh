`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic PCSrc, RegWrite, ExtOP, dWEN, dREN, BNE, Halt, Jump, datomic;
  logic [1:0] ALUSrc, RegDest, JumpSel, MemtoReg;
  aluop_t ALUOP;
  opcode_t opcode_out;
  regbits_t Rs, Rt, Rd;
  logic [15:0] Imm;
  logic [25:0] j25;
  word_t shamt, Instr;

 
  modport cu (
    input   Instr,
    output PCSrc, RegWrite, ExtOP, dWEN, dREN, BNE, Halt, Jump, ALUSrc, 
    RegDest, JumpSel, MemtoReg, ALUOP, Rs, Rt, Rd, Imm, j25, shamt, opcode_out, datomic
  );

  modport tb (
    output   Instr,
    input PCSrc, RegWrite, ExtOP, dWEN, dREN, BNE, Halt, Jump, ALUSrc, 
    RegDest, JumpSel, MemtoReg, ALUOP, Rs, Rt, Rd, Imm, j25, shamt, opcode_out, datomic
  );

endinterface
`endif 
