`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface ID_EX_if;
  // import types
  import cpu_types_pkg::*;

  logic ihit, PCSrc_in, RegWrite_in, dWEN_in, dREN_in, BNE_in, Halt_in, Jump_in, flush, datomic_in;
  logic [1:0] ALUSrc_in, RegDest_in, JumpSel_in, MemtoReg_in;
  aluop_t ALUOP_in;
  regbits_t Rt_in, Rd_in, Rs_in;
  opcode_t opcode_in;
  logic [25:0] j25_in;
  word_t shamt_in, rdat1_in, rdat2_in, pcp4_in, extImm_in;

  logic PCSrc_out, RegWrite_out, dWEN_out, dREN_out, BNE_out, Halt_out, Jump_out, datomic_out;
  logic [1:0] ALUSrc_out, RegDest_out, JumpSel_out, MemtoReg_out;
  aluop_t ALUOP_out;
  regbits_t Rt_out, Rd_out, Rs_out;
  opcode_t opcode_out;
  logic [25:0] j25_out;
  word_t shamt_out, rdat1_out, rdat2_out, pcp4_out, extImm_out;
  

  modport idex (
    input ihit, PCSrc_in, RegWrite_in, dWEN_in, dREN_in, BNE_in, Halt_in, Jump_in, ALUSrc_in, 
    RegDest_in, JumpSel_in, MemtoReg_in, ALUOP_in, Rt_in, Rd_in, Rs_in, opcode_in, j25_in, 
    shamt_in, rdat1_in, rdat2_in, pcp4_in, extImm_in, flush, datomic_in,
    output PCSrc_out, RegWrite_out, dWEN_out, dREN_out, BNE_out, Halt_out, Jump_out, 
    ALUSrc_out, RegDest_out, JumpSel_out, MemtoReg_out, ALUOP_out, Rt_out, Rd_out, Rs_out,
    opcode_out, j25_out, shamt_out, rdat1_out, rdat2_out, pcp4_out, extImm_out, datomic_out
  );
  
  modport tb (
    output ihit, PCSrc_in, RegWrite_in, dWEN_in, dREN_in, BNE_in, Halt_in, Jump_in, ALUSrc_in, 
    RegDest_in, JumpSel_in, MemtoReg_in, ALUOP_in, Rt_in, Rd_in, Rs_in, opcode_in, j25_in, 
    shamt_in, rdat1_in, rdat2_in, pcp4_in, extImm_in, datomic_in,
    input PCSrc_out, RegWrite_out, dWEN_out, dREN_out, BNE_out, Halt_out, Jump_out, 
    ALUSrc_out, RegDest_out, JumpSel_out, MemtoReg_out, ALUOP_out, Rt_out, Rd_out, Rs_out,
    opcode_out, j25_out, shamt_out, rdat1_out, rdat2_out, pcp4_out, extImm_out, flush, datomic_out 
  );
endinterface

`endif 
