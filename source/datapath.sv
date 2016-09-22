/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "program_counter_if.vh"
`include "alu_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  //Variables
  word_t Imm_ext, PC_4, Branch, Branch_in, JumpVal, Branch_final;
  logic z_final;
  logic [27:0] Jump_Im;

  //Interfaces
  control_unit_if cuif();
  request_unit_if ruif();
  program_counter_if pcif();
  alu_if aluif();
  register_file_if rfif();

  //Port Map
  alu ALUDUT(aluif.aluf);
  register_file regDUT (CLK, nRST, rfif.rf);
  control_unit contDUT (cuif.cu);
  request_unit reqDUT (CLK, nRST, ruif.ru);
  program_counter pcDUT (CLK, nRST, pcif.pc);

  always_comb
  begin
	PC_4 = pcif.PCOut + 4;
  end

always_ff @(posedge CLK, negedge nRST)
begin
	if(!nRST)
	begin
		dpif.halt <= 0;
	end
	else
	begin
		dpif.halt <= cuif.Halt;
	end
end

  //Datapath
  
 // assign dpif.halt = cuif.Halt;
  assign dpif.imemREN = cuif.imemREN;
  assign dpif.imemaddr = pcif.PCOut;
  assign dpif.dmemREN = ruif.dmemREN;
  assign dpif.dmemWEN = ruif.dmemWEN;
  assign dpif.dmemstore = rfif.rdat2;
  assign dpif.dmemaddr = aluif.Output;

  //Request Unit

  assign ruif.dWEN = cuif.dWEN;
  assign ruif.dREN = cuif.dREN;
  assign ruif.dhit = dpif.dhit;
  assign ruif.ihit = dpif.ihit;
  assign pcif.PCEN = ruif.PCEN & ~cuif.Halt;
  
  //Control Unit

  assign cuif.Instr = dpif.imemload;
  
 //Register File
  
  assign rfif.rsel1 = cuif.Rs;
  assign rfif.rsel2 = cuif.Rt;
  assign rfif.WEN = (cuif.RegWrite & (dpif.ihit | dpif.dhit));

  //Wdat logic

  always_comb
  begin
	word_t MemRegVal, JALVal;
	if(cuif.MemtoReg == 0)
	begin
		MemRegVal = aluif.Output;
	end
	else
	begin
		MemRegVal = dpif.dmemload;
	end
	if(cuif.JAL == 0)
	begin
		JALVal = MemRegVal;
	end
	else
	begin
		JALVal = PC_4;
	end
	if(cuif.LUI == 0)
	begin
		rfif.wdat = JALVal;
	end
	else
	begin
		rfif.wdat[31:16] = cuif.Imm;
		rfif.wdat[15:0] = '{default: '0};
	end
  end

  //Wselect logic
  always_comb
  begin
  	if(cuif.RegDest == 2'b00)
	begin
		rfif.wsel = cuif.Rt;
	end
	else if(cuif.RegDest == 2'b01)
	begin
		rfif.wsel = cuif.Rd;
	end
	else if(cuif.RegDest == 2'b10)
	begin
		rfif.wsel = 5'd31;
	end
	else
	begin
		rfif.wsel = cuif.Rt;
	end
  end

  //ALU

  assign aluif.PortA = rfif.rdat1;
  assign aluif.ALUOP = cuif.ALUOP;

  //ALUSrc logic

  always_comb
  begin
  	if(cuif.ExtOP == 0)
	begin
		Imm_ext [31:16] = '{default: '0};
		Imm_ext [15:0] = cuif.Imm;
	end
	else
	begin
		Imm_ext [31:16] = (cuif.Imm[15] == 1) ? '{default: '1} : '{default: '0};
		Imm_ext [15:0] = cuif.Imm;
	end
	
  end
 
  always_comb
  begin
 	if(cuif.ALUSrc == 2'b00)
		aluif.PortB = rfif.rdat2;
	else if(cuif.ALUSrc == 2'b01)
		aluif.PortB = cuif.shamt;
	else
		aluif.PortB = Imm_ext;
  end

  //Program Counter
  
  always_comb
  begin
	Branch = Imm_ext << 2;
	Branch_in = Branch + PC_4;
	if(cuif.BNE == 0)
		z_final = aluif.zero;
	else
		z_final = ~aluif.zero;
  end

  always_comb
  begin
	if((z_final & cuif.PCSrc))
		Branch_final = Branch_in;
	else
		Branch_final = PC_4;
  end

  always_comb
  begin
	Jump_Im[27:2] = dpif.imemload[25:0];
	Jump_Im [1:0] = 2'b00;
	JumpVal [31:28] = PC_4[31:28];
	JumpVal [27:0] = Jump_Im;
  end

  always_comb
  begin
	if(cuif.JumpSel == 2'b0)
	begin
		pcif.PCNext = PC_4;
	end
	else if(cuif.JumpSel == 2'b01)
	begin
		pcif.PCNext = Branch_final;
	end
	else if(cuif.JumpSel == 2'b10)
	begin
		pcif.PCNext = rfif.rdat1;
	end
	else
	begin
		pcif.PCNext = JumpVal;
	end
  end
 
endmodule
