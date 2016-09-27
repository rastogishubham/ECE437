/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "program_counter_if.vh"
`include "alu_if.vh"
`include "IF_ID_if.vh"
`include "ID_EX_if.vh"
`include "EX_MEM_if.vh"
`include "MEM_WB_if.vh"

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
  word_t extImm, PC_4, Branch, Branch_in, JumpVal, Branch_final, LUI_val, floatymuxy, wdat_wb, PortA_int, PortB_int;
  logic z_final, z_comp;
  logic [27:0] Jump_Im;

  //Interfaces
  control_unit_if cuif();
  program_counter_if pcif();
  alu_if aluif();
  register_file_if rfif();
  IF_ID_if ifidif();
  ID_EX_if idexif();
  EX_MEM_if exmemif();
  MEM_WB_if memwbif();
  hazard_unit_if hzif();
  //Port Map
  alu ALUDUT(aluif.aluf);
  register_file regDUT (CLK, nRST, rfif.rf);
  control_unit contDUT (cuif.cu);
  program_counter pcDUT (CLK, nRST, pcif.pc);
  IF_ID IFID_DUT (CLK, nRST, ifidif.ifid);
  ID_EX IDEX_DUT (CLK, nRST, idexif.idex);
  EX_MEM EXMEM_DUT (CLK, nRST, exmemif.exmem);
  MEM_WB MEMWB_DUT (CLK, nRST, memwbif.memwb);
  hazard_unit HAZ_DUT (hzif.hz);
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
		dpif.halt <= memwbif.Halt_out;
	end
end
//assign dpif.halt = memwbif.Halt_out;
always_comb
begin
  	if(cuif.ExtOP == 0)
	begin
		extImm [31:16] = '{default: '0};
		extImm [15:0] = cuif.Imm;
	end
	else
	begin
		extImm [31:16] = (cuif.Imm[15] == 1) ? '{default: '1} : '{default: '0};
		extImm [15:0] = cuif.Imm;
	end
end


//Datapath


//IF_ID
assign ifidif.imemload = dpif.imemload;
assign ifidif.ihit = dpif.ihit;
assign ifidif.pcp4_in = PC_4;

//ID_EX
assign idexif.ihit = dpif.ihit;
assign idexif.PCSrc_in = cuif.PCSrc;
assign idexif.RegWrite_in = cuif.RegWrite;
assign idexif.dWEN_in = cuif.dWEN;
assign idexif.dREN_in = cuif.dREN;
assign idexif.BNE_in = cuif.BNE;
assign idexif.Halt_in = cuif.Halt;
assign idexif.Jump_in = cuif.Jump;
assign idexif.ALUSrc_in = cuif.ALUSrc;
assign idexif.RegDest_in = cuif.RegDest;
assign idexif.JumpSel_in = cuif.JumpSel;
assign idexif.MemtoReg_in = cuif.MemtoReg;
assign idexif.ALUOP_in = cuif.ALUOP;
assign idexif.Rt_in = cuif.Rt;
assign idexif.Rd_in = cuif.Rd;
assign idexif.Rs_in = cuif.Rs;
assign idexif.opcode_in = cuif.opcode_out;
assign idexif.j25_in = cuif.j25;
assign idexif.shamt_in = cuif.shamt;
assign idexif.rdat1_in = rfif.rdat1;
assign idexif.rdat2_in = rfif.rdat2;
assign idexif.pcp4_in = ifidif.pcp4_out;
assign idexif.extImm_in = extImm;


//EX_MEM
assign exmemif.dWEN_in = idexif.dWEN_out;
assign exmemif.dREN_in = idexif.dREN_out;
assign exmemif.RegWrite_in = idexif.RegWrite_out;
assign exmemif.LUI_in = {idexif.extImm_out[15:0], 16'h0000};
assign exmemif.Halt_in = idexif.Halt_out;
assign exmemif.MemToReg_in = idexif.MemtoReg_out;
assign exmemif.opcode_in = idexif.opcode_out;
assign exmemif.Porto_in = aluif.Output;
assign exmemif.pcp4_in = idexif.pcp4_out;
assign exmemif.ihit = dpif.ihit;
assign exmemif.dhit = dpif.dhit;
assign exmemif.dmemstr_in = PortB_int;

//M/WB
assign memwbif.Halt_in = exmemif.Halt_out;
assign memwbif.RegWrite_in = exmemif.RegWrite_out;
assign memwbif.MemToReg_in = exmemif.MemToReg_out;
assign memwbif.wsel_in = exmemif.wsel_out;
assign memwbif.opcode_in = exmemif.opcode_out;
assign memwbif.pcp4_in = exmemif.pcp4_out;
assign memwbif.LUI_in = exmemif.LUI_out;
assign memwbif.Porto_in = exmemif.Porto_out;
assign memwbif.dmemload_in = dpif.dmemload;
assign memwbif.ihit = dpif.ihit;
assign memwbif.dhit = dpif.dhit;


//Comparator
always_comb
begin
	if((PortA_int - PortB_int) == 0)
		z_comp = 1;
	else
		z_comp = 0;
end


//Register File
assign rfif.wsel = memwbif.wsel_out;
assign rfif.WEN = memwbif.RegWrite_out;// & (memwbif.dhit | memwbif.ihit); //do we need this?
assign rfif.rsel1 = cuif.Rs;
assign rfif.rsel2 = cuif.Rt;
always_comb
begin
	if (memwbif.MemToReg_out == 2'b0)
		wdat_wb = memwbif.Porto_out;
	else if (memwbif.MemToReg_out == 2'b01)
		wdat_wb = memwbif.dmemload_out;
	else if (memwbif.MemToReg_out == 2'b10)
		wdat_wb = memwbif.LUI_out;
	else
		wdat_wb = memwbif.pcp4_out;
end

assign rfif.wdat = wdat_wb;

always_comb
begin
	if (idexif.RegDest_out == 2'b0)
		exmemif.wsel_in = idexif.Rt_out;
	else if (idexif.RegDest_out == 2'b1)
		exmemif.wsel_in = idexif.Rd_out;
	else if (idexif.RegDest_out == 2'b10)
		exmemif.wsel_in = 31;
	else
		exmemif.wsel_in = idexif.Rt_out;
end

//Hazard Unit
always_comb
begin
	if (exmemif.MemToReg_out == 2'b00)
		floatymuxy = exmemif.Porto_out;
	else if (exmemif.MemToReg_out == 2'b01)
		floatymuxy = dpif.dmemload;
	else if (exmemif.MemToReg_out == 2'b10)
		floatymuxy = exmemif.LUI_out;
	else
		floatymuxy = exmemif.pcp4_out;
end
assign hzif.Rs_EX = idexif.Rs_out;
assign hzif.Rt_EX = idexif.Rt_out;
assign hzif.Wsel_mem = exmemif.wsel_out;
assign hzif.Wsel_wb = memwbif.wsel_out;
assign hzif.RegWrite_mem = exmemif.RegWrite_out;
assign hzif.RegWrite_wb = memwbif.RegWrite_out;
//ALU 
//assign aluif.PortA = idexif.rdat1_out;


always_comb
begin
	if (hzif.Rs_Sel == 2'b00)
		PortA_int = idexif.rdat1_out;
	else if (hzif.Rs_Sel == 2'b01)
		PortA_int = floatymuxy;
	else if (hzif.Rs_Sel == 2'b10)
		PortA_int = wdat_wb;
	else 
		PortA_int = idexif.rdat1_out;
end

/*always_comb
begin
	if (hzif.Rs_Sel == 2'b00)
		aluif.PortA = idexif.rdat1_out;
	else if (hzif.Rs_Sel == 2'b01)
		aluif.PortA = floatymuxy;
	else if (hzif.Rs_Sel == 2'b10)
		aluif.PortA = wdat_wb;
	else 
		aluif.PortA = idexif.rdat1_out;
end*/
assign aluif.PortA = PortA_int;
assign aluif.ALUOP = idexif.ALUOP_out;


always_comb
begin
	if (hzif.Rt_Sel == 2'b00)
		PortB_int = idexif.rdat2_out;
	else if(hzif.Rt_Sel == 2'b01)
		PortB_int = floatymuxy;
	else if (hzif.Rt_Sel == 2'b10)
		PortB_int = wdat_wb;
	else
		PortB_int = idexif.rdat2_out;
end

always_comb
begin
	if (idexif.ALUSrc_out == 2'b01)
		aluif.PortB = idexif.shamt_out;
	else if (idexif.ALUSrc_out == 2'b00)
	begin
		aluif.PortB = PortB_int;
	end
	else if (idexif.ALUSrc_out == 2'b10)
		aluif.PortB = idexif.extImm_out;
	else
		aluif.PortB = idexif.extImm_out;
end

//PC
assign pcif.PCEN = dpif.ihit & ~dpif.halt;
logic [31:0] jumpaddr;
logic [31:0] branchAddr;
assign jumpaddr = {PC_4[31:28],idexif.j25_out, 2'b00};
assign branchAddr = (idexif.extImm_out << 2) + idexif.pcp4_out;

/*logic [31:0] Branch;
logic [31:0] Branch_in;*/
always_comb
begin
	Branch = idexif.extImm_out << 2;
	Branch_in = Branch + PC_4;
	if(idexif.BNE_out == 0)
		z_final = z_comp;
	else
		z_final = ~z_comp;
end
always_comb
begin
	if((z_final & idexif.PCSrc_out))
		Branch_final = branchAddr;
	else
		Branch_final = PC_4;
end

always_comb
begin
	if(idexif.JumpSel_out == 2'b0)
		pcif.PCNext = PC_4;
	else if(idexif.JumpSel_out == 2'b01)
		pcif.PCNext = Branch_final;
	else if(idexif.JumpSel_out == 2'b10)
		pcif.PCNext = idexif.rdat1_out;
	else
		pcif.PCNext = jumpaddr;
end

always_comb
begin
	if(idexif.Jump_out | (z_final & idexif.PCSrc_out) && dpif.ihit)
	begin
		idexif.flush = 1;
		ifidif.flush = 1;
	end
	else
	begin
		idexif.flush = 0;
		ifidif.flush = 0;
	end
end


//assign idexif.flush	= idexif.Jump_out | z_final;
//assign ifidif.flush = idexif.Jump_out | z_final;

//Request Unit
//Check the logic
/*always_ff @(posedge CLK, negedge nRST)
begin
	if(!nRST)
	begin
		dpif.dmemWEN <= 0;
		dpif.dmemREN <= 0;
	end
	else
	begin
		if(dpif.dhit)
		begin
			dpif.dmemWEN <= 0;
			dpif.dmemREN <= 0;
		end
		else
		begin
			dpif.dmemWEN <= exmemif.dWEN_out;
			dpif.dmemREN <= exmemif.dREN_out;
		end
	end
end*/
assign dpif.dmemWEN = exmemif.dWEN_out;
assign dpif.dmemREN = exmemif.dREN_out;
/*assign dpif.dmemWEN = (dpif.dhit) ? 0 : exmemif.dWEN_out;
assign dpif.dmemREN = (dpif.dhit) ? 0 : exmemif.dREN_out;*/
assign dpif.dmemaddr = exmemif.Porto_out;
assign dpif.dmemstore = exmemif.dmemstr_out;
assign dpif.imemaddr = pcif.PCOut;
assign dpif.imemREN = 1;

//Control Unit
assign cuif.Instr = ifidif.instr;

assign exmemif.flush = dpif.dhit;
/*always_comb
begin
	if (idexif.JumpSel_out == 2'b0)
		pcif.PCNext = idexif.pcp4_out;
	else if (idexif.JumpSel_out == 2'b01)
		pcif.PCNext = idexif.jumpaddr;
	else if (idexif.JumpSel_out == 2'b10)
		pcif.PCNext = idexif.*/
/*
  //Datapath
  
 // assign dpif.halt = cuif.Halt;
  assign dpif.imemREN = cuif.imemREN;
  assign dpif.imemaddr = pcif.PCOut;
  assign dpif.dmemREN = ruif.dmemREN;
  assign dpif.dmemWEN = ruif.dmemWEN;
  assign dpif.dmemstore = rfif.rdat2;
  assign dpif.dmemaddr = aluif.Output;

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
 	if(cuif.ALUSrc == 2'b00)
		aluif.PortB = rfif.rdat2;
	else if(cuif.ALUSrc == 2'b01)
		aluif.PortB = cuif.shamt;
	else
		aluif.PortB = extImm;
  end

  //Program Counter
  
  always_comb
  begin
	Branch = extImm << 2;
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
  end*/
 
endmodule
