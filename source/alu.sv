
`include "cpu_types_pkg.vh"
`include "alu_if.vh"
import cpu_types_pkg::*;
module alu (
	alu_if.aluf alufif
);
	
always_comb 
begin
	casez(alufif.ALUOP)
		ALU_SLL:
		begin
			alufif.overflow = 1'b0;
			alufif.neg = 1'b0; 
			alufif.Output = alufif.PortA << alufif.PortB;
		end
		ALU_SRL:
		begin
			alufif.overflow = 1'b0;
			alufif.neg = 1'b0;
			alufif.Output = alufif.PortA >> alufif.PortB;
		end
		ALU_ADD:
		begin
			alufif.Output = $signed(alufif.PortA) + $signed(alufif.PortB);
			if(alufif.PortA[31] == 1 && alufif.PortB[31] == 1)
				alufif.overflow = (alufif.Output[31] == 0) ? 1'b1 : 1'b0;
			else if(alufif.PortA[31] == 0 && alufif.PortB[31] == 0)
				alufif.overflow = (alufif.Output[31] == 1) ? 1'b1 : 1'b0;
			else
				alufif.overflow = 1'b0;
			alufif.neg = (alufif.Output[31] == 1) ? 1'b1 : 1'b0;
		end		
		ALU_SUB:
		begin
			alufif.Output = $signed(alufif.PortA) - $signed(alufif.PortB);
			if(alufif.PortA[31] == 1 && alufif.PortB[31] == 0)
				alufif.overflow = (alufif.Output[31] == 0) ? 1'b1 : 1'b0;
			else if(alufif.PortA[31] == 0 && alufif.PortB[31] == 1)
				alufif.overflow = (alufif.Output[31] == 1) ? 1'b1 : 1'b0;
			else
				alufif.overflow = 1'b0;
			alufif.neg = (alufif.Output[31] == 1) ? 1'b1 : 1'b0;
		end
		ALU_AND:
		begin
			alufif.overflow = 1'b0;
			alufif.neg = 1'b0;
			alufif.Output = alufif.PortA & alufif.PortB;
		end		
		ALU_OR:
		begin
			alufif.overflow = 1'b0;
			alufif.neg = 1'b0;
			alufif.Output = alufif.PortA | alufif.PortB;
		end		
		ALU_XOR:
		begin
			alufif.overflow = 1'b0;
			alufif.neg = 1'b0;
			alufif.Output = alufif.PortA  ^ alufif.PortB;
		end		
		ALU_NOR:
		begin
			alufif.overflow = 1'b0;
			alufif.neg = 1'b0;
			alufif.Output = ~(alufif.PortA | alufif.PortB);
		end
		ALU_SLT:
		begin
			alufif.Output = ($signed(alufif.PortA) < $signed(alufif.PortB)) ? 32'd1 : 32'd0;
			alufif.neg = (alufif.Output[31] == 1) ? 1'b1 : 1'b0;
			alufif.overflow = 1'b0;
		end		
		ALU_SLTU:
		begin
			alufif.overflow = 1'b0;
			alufif.neg = 1'b0;		
			alufif.Output = (alufif.PortA < alufif.PortB) ? 32'd1 : 32'd0;
		end
		default: 
		begin
			alufif.overflow = 1'b0;
			alufif.neg = 1'b0;		
		end
		
endcase
end
assign alufif.zero = (alufif.Output == 0) ? 1'b1 : 1'b0;
endmodule
