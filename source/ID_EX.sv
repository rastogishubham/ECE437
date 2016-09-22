`include "cpu_types_pkg.vh"
`include "ID_EX_if.vh"
module ID_EX (
  input logic CLK, nRST,
  ID_EX_if.idex idexif
);
  import cpu_types_pkg::*;
  always_ff @(posedge CLK, negedge nRST)
  begin
  		if(!nRST)
  		begin
        idexif.PCSrc_out <= 0;
        idexif.RegWrite_out <= '0;
        idexif.dWEN_out <= '0;
        idexif.dREN_out <= '0;
        idexif.BNE_out <= '0;
        idexif.Halt_out <= '0;
        idexif.Jump_out <= '0;
        idexif.ALUSrc_out <= '0;
        idexif.RegDest_out <= '0;
        idexif.JumpSel_out <= '0;
        idexif.MemtoReg_out <= '0;
        idexif.ALUOP_out <= aluop_t'('0);
        idexif.Rt_out <= '0;
        idexif.Rd_out <= '0;
        idexif.opcode_out <= opcode_t'('0);
        idexif.j25_out <= '0;
        idexif.shamt_out <= '0;
        idexif.rdat1_out <= '0;
        idexif.rdat2_out <= '0;
        idexif.pcp4_out <= '0;
        idexif.extImm_out <= '0;
  		end
      else
      begin
        if(idexif.flush)
        begin
          idexif.PCSrc_out <= '0;
          idexif.RegWrite_out <= '0;
          idexif.dWEN_out <= '0;
          idexif.dREN_out <= '0;
          idexif.BNE_out <= '0;
          idexif.Halt_out <= '0;
          idexif.Jump_out <= '0;
          idexif.ALUSrc_out <= '0;
          idexif.RegDest_out <= '0;
          idexif.JumpSel_out <= '0;
          idexif.MemtoReg_out <= '0;
          idexif.ALUOP_out <= aluop_t'('0);
          idexif.Rt_out <= '0;
          idexif.Rd_out <= '0;
          idexif.opcode_out <= opcode_t'('0);
          idexif.j25_out <= '0;
          idexif.shamt_out <= '0;
          idexif.rdat1_out <= '0;
          idexif.rdat2_out <= '0;
          idexif.pcp4_out <= '0;
          idexif.extImm_out <= '0;
        end
    		else if(idexif.ihit)
    		begin
    			idexif.PCSrc_out <= idexif.PCSrc_in;
          idexif.RegWrite_out <= idexif.RegWrite_in;
          idexif.dWEN_out <= idexif.dWEN_in;
          idexif.dREN_out <= idexif.dREN_in;
          idexif.BNE_out <= idexif.BNE_in;
          idexif.Halt_out <= idexif.Halt_in;
          idexif.Jump_out <= idexif.Jump_in;
          idexif.ALUSrc_out <= idexif.ALUSrc_in;
          idexif.RegDest_out <= idexif.RegDest_in;
          idexif.JumpSel_out <= idexif.JumpSel_in;
          idexif.MemtoReg_out <= idexif.MemtoReg_in;
          idexif.ALUOP_out <= idexif.ALUOP_in;
          idexif.Rt_out  <= idexif.Rt_in;
          idexif.Rd_out <= idexif.Rd_in;
          idexif.opcode_out <= idexif.opcode_in;
          idexif.j25_out <= idexif.j25_in;
          idexif.shamt_out <= idexif.shamt_in;
          idexif.rdat1_out <= idexif.rdat1_in;
          idexif.rdat2_out <= idexif.rdat2_in;
          idexif.pcp4_out <= idexif.pcp4_in; 
          idexif.extImm_out <= idexif.extImm_in;
    		end
    		else
    		begin
    			idexif.PCSrc_out <= idexif.PCSrc_out;
          idexif.RegWrite_out <= idexif.RegWrite_out;
          idexif.dWEN_out <= idexif.dWEN_out;
          idexif.dREN_out <= idexif.dREN_out;
          idexif.BNE_out <= idexif.BNE_out;
          idexif.Halt_out <= idexif.Halt_out;
          idexif.Jump_out <= idexif.Jump_out;
          idexif.ALUSrc_out <= idexif.ALUSrc_out;
          idexif.RegDest_out <= idexif.RegDest_out;
          idexif.JumpSel_out <= idexif.JumpSel_out;
          idexif.MemtoReg_out <= idexif.MemtoReg_out;
          idexif.ALUOP_out <= idexif.ALUOP_out;
          idexif.Rt_out  <= idexif.Rt_out;
          idexif.Rd_out <= idexif.Rd_out;
          idexif.opcode_out <= idexif.opcode_out;
          idexif.j25_out <= idexif.j25_out;
          idexif.shamt_out <= idexif.shamt_out;
          idexif.rdat1_out <= idexif.rdat1_out;
          idexif.rdat2_out <= idexif.rdat2_out;
          idexif.pcp4_out <= idexif.pcp4_out; 
          idexif.extImm_out <= idexif.extImm_out;
    		end
      end
    end
  endmodule
