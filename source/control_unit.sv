`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"
import cpu_types_pkg::*;
module control_unit (
	control_unit_if.cu cuif
);

opcode_t opercode;
funct_t func_code;
assign cuif.Imm = cuif.Instr[15:0];
assign opercode = opcode_t'(cuif.Instr[31:26]);
assign cuif.Rs = cuif.Instr[25:21];
assign cuif.Rt = cuif.Instr[20:16];
assign cuif.Rd = cuif.Instr[15:11];
assign cuif.shamt[4:0] = cuif.Instr[10:6];
assign cuif.shamt[31:5] = '{default: '0};
assign func_code = funct_t'(cuif.Instr[5:0]);

always_comb
begin
	casez(opercode)
	RTYPE:
	begin
		casez(func_code)
		SLL:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0; 
			cuif.RegWrite = 1;
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b01;
			cuif.JumpSel = 2'b00;   
			cuif.ALUOP = ALU_SLL; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		SRL:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0; 
			cuif.RegWrite = 1;
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b01;
			cuif.JumpSel = 2'b00;   
			cuif.ALUOP = ALU_SRL; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		JR:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b00; //dont care
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0; //dont care
			cuif.RegWrite = 0; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00; //dont care
			cuif.JumpSel = 2'b10; //   
			cuif.ALUOP = ALU_SRL; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		ADD:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_ADD;
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		ADDU:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_ADD; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		SUB:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_SUB; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		SUBU:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_SUB; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		AND:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_AND; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		OR:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_OR; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		XOR:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_XOR; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		NOR:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_NOR; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		SLT:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_SLT; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		SLTU:
		begin
			cuif.PCSrc = 0; //dont care
			cuif.RegDest = 2'b01;
			cuif.ExtOP = 0; //dont care
			cuif.MemtoReg = 0;
			cuif.RegWrite = 1; 
			cuif.JAL = 0; //dont care
			cuif.dWEN = 0;
			cuif.dREN = 0; 
			cuif.imemREN = 1; 
			cuif.LUI = 0; 
			cuif.ALUSrc = 2'b00;
			cuif.JumpSel = 2'b00;    
			cuif.ALUOP = ALU_SLTU; //dont care 
			cuif.BNE = 0; //dont care
			cuif.Halt = 0;
		end
		endcase
	end
	J:
	begin
		cuif.PCSrc = 0; //dont care
		cuif.RegDest = 2'b00; //dont care
		cuif.ExtOP = 0; //dont care
		cuif.MemtoReg = 0; //dont care
		cuif.RegWrite = 0;
		cuif.JAL = 0; //dont care
		cuif.dWEN = 0;
		cuif.dREN = 0; 
		cuif.imemREN = 1; 
		cuif.LUI = 0; //dont care
		cuif.ALUSrc = 2'b00; //dont care
		cuif.JumpSel = 2'b11; //Jump  
		cuif.ALUOP = ALU_SRL; //dont care 
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	JAL:
	begin		
		cuif.PCSrc = 0; //dont care
		cuif.RegDest = 2'b10;
		cuif.ExtOP = 0; //dont care
		cuif.MemtoReg = 0; //dont care
		cuif.RegWrite = 1;
		cuif.JAL = 1;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1; 
		cuif.LUI = 0; //dont care
		cuif.ALUSrc = 2'b00; //dont care
		cuif.JumpSel = 2'b11; //Jump  
		cuif.ALUOP = ALU_SRL; //dont care 
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	BEQ:
	begin
		cuif.PCSrc = 1; 
		cuif.RegDest = 2'b00; //dont care
		cuif.ExtOP = 1;
		cuif.MemtoReg = 0; //dont care
		cuif.RegWrite = 0;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1; 
		cuif.LUI = 0; //dont care
		cuif.ALUSrc = 2'b00;
		cuif.JumpSel = 2'b01; //branch  
		cuif.ALUOP = ALU_SUB;
		cuif.BNE = 0;
		cuif.Halt = 0;
	end
	BNE:
	begin
		cuif.PCSrc = 1; 
		cuif.RegDest = 2'b00; //dont care
		cuif.ExtOP = 1;
		cuif.MemtoReg = 0; //dont care
		cuif.RegWrite = 0;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1; 
		cuif.LUI = 0; //dont care
		cuif.ALUSrc = 2'b00;
		cuif.JumpSel = 2'b01; //branch  
		cuif.ALUOP = ALU_SUB;
		cuif.BNE = 1;
		cuif.Halt = 0;
	end
	ADDI:
	begin
		cuif.PCSrc = 0;
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 1;
		cuif.MemtoReg = 0;
		cuif.RegWrite = 1;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10;
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_ADD;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	ADDIU:
	begin
		cuif.PCSrc = 0;
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 1;
		cuif.MemtoReg = 0;
		cuif.RegWrite = 1;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10;
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_ADD;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	SLTI:
	begin
		cuif.PCSrc = 0;
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 1;
		cuif.MemtoReg = 0;
		cuif.RegWrite = 1;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10;
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_SLT;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	SLTIU:
	begin
		cuif.PCSrc = 0;
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 1;
		cuif.MemtoReg = 0;
		cuif.RegWrite = 1;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10;
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_SLTU;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	ANDI:
	begin
		cuif.PCSrc = 0;
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 0;
		cuif.MemtoReg = 0;
		cuif.RegWrite = 1;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10;
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_AND;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	ORI:
	begin
		cuif.PCSrc = 0;
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 0;
		cuif.MemtoReg = 0;
		cuif.RegWrite = 1;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10;
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_OR;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	XORI:
	begin
		cuif.PCSrc = 0;
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 0;
		cuif.MemtoReg = 0;
		cuif.RegWrite = 1;
		cuif.JAL = 0;
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10;
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_XOR;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	LUI:
	begin
		cuif.PCSrc = 0; //dont care
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 0; //dont care
		cuif.MemtoReg = 0; //dont care
		cuif.RegWrite = 1; 
		cuif.JAL = 0; 
		cuif.dWEN = 0;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 1;
		cuif.ALUSrc = 2'b00; //dont care
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_SRL; //dont care
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	LW:
	begin
		cuif.PCSrc = 0; //dont care
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 1;
		cuif.MemtoReg = 1;
		cuif.RegWrite = 1; 
		cuif.JAL = 0; 
		cuif.dWEN = 0;
		cuif.dREN = 1;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10; 
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_ADD;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	SW:
	begin
		cuif.PCSrc = 0; //dont care
		cuif.RegDest = 2'b00;
		cuif.ExtOP = 1;
		cuif.MemtoReg = 0; //dont care
		cuif.RegWrite = 0; 
		cuif.JAL = 0; 
		cuif.dWEN = 1;
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0;
		cuif.ALUSrc = 2'b10;
		cuif.JumpSel = 2'b00;
		cuif.ALUOP = ALU_ADD;
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	HALT:
	begin
		cuif.PCSrc = 0; //dont care
		cuif.RegDest = 2'b00; //dont care
		cuif.ExtOP = 0; //dont care
		cuif.MemtoReg = 0; //dont care
		cuif.RegWrite = 0; //dont care
		cuif.JAL = 0; //dont care
		cuif.dWEN = 0; 
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0; //dont care
		cuif.ALUSrc = 2'b00; //dont care
		cuif.JumpSel = 2'b00; //dont care
		cuif.ALUOP = ALU_SRL; //dont care
		cuif.BNE = 0; //dont care
		cuif.Halt = 1;
	end
	default:
	begin
		cuif.PCSrc = 0; //dont care
		cuif.RegDest = 2'b00; //dont care
		cuif.ExtOP = 0; //dont care
		cuif.MemtoReg = 0; //dont care
		cuif.RegWrite = 0; //dont care
		cuif.JAL = 0; //dont care
		cuif.dWEN = 0; 
		cuif.dREN = 0;
		cuif.imemREN = 1;
		cuif.LUI = 0; //dont care
		cuif.ALUSrc = 2'b00; //dont care
		cuif.JumpSel = 2'b00; //dont care
		cuif.ALUOP = ALU_SRL; //dont care
		cuif.BNE = 0; //dont care
		cuif.Halt = 0;
	end
	endcase
	
end
endmodule
