/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;
  

  assign ccif.iload = ccif.ramload;
  assign ccif.dload = ccif.ramload;
  assign ccif.ramstore = ccif.dstore;
  always_comb
  begin

	if(ccif.dWEN == 1)
	begin
		ccif.ramWEN = 1;
		ccif.ramaddr = ccif.daddr;
		ccif.ramREN = 0;
	end
	else if(ccif.dREN == 1)
	begin
		ccif.ramREN = 1;
		ccif.ramaddr = ccif.daddr;
		ccif.ramWEN = 0;
	end
	else if(ccif.iREN == 1)
	begin
		ccif.ramREN = 1;
		ccif.ramaddr = ccif.iaddr;
		ccif.ramWEN = 0;
	end
	else
	begin
		ccif.ramWEN = 0;
		ccif.ramREN = 0;
		//ccif.ramstore = 0;
	//	ccif.iload = ccif.ramload;
	//	ccif.dload = '{default: '0};
		ccif.ramaddr = ccif.iaddr;
	end

	if((ccif.dREN || ccif.dWEN) && ccif.iREN && ccif.ramstate == ACCESS)
	begin
		ccif.dwait = 0;
		ccif.iwait = 1;
	end
	else if((ccif.dREN || ccif.dWEN) && !ccif.iREN && ccif.ramstate == ACCESS)
	begin
		ccif.dwait = 0;
		ccif.iwait = 1;
	end
	else if(!(ccif.dREN || ccif.dWEN) && ccif.iREN && ccif.ramstate == ACCESS)
	begin
		ccif.dwait = 1;
		ccif.iwait = 0;		
	end
	else
	begin
		ccif.dwait = 1;
		ccif.iwait = 1;
	end

  end

endmodule
