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
  logic service = 0;
  typedef enum logic [3:0] {IDLE, ARBITRATE, WB1, WB2, SNOOP, RAMWRITE1, RAMWRITE2, RAMREAD1, RAMREAD2}
  state_type;
  state_type state, next_state;

  always_ff @(posedge CLK, negedge nRST)
  begin
  	if(~nRST)
  	begin
  		state <= IDLE;
  	end
 	else
 	begin
  		 state <= next_state;
  	end
  end

  always_comb
  begin
  	next_state = state;
  	ccif.dwait = 1;
  	ccif.ramWEN = 0;
  	ccif.ramREN = 0;
  	ccif.ramaddr = 0;
  	ccif.ramstore = 0;
  	case(state)
  		IDLE:
  		begin
  			ccif.ccwait = 0;
  			ccif.ccinv = 0;
  			if(ccif.cctrans[0] | ccif.cctrans[1])
  				next_state = ARBITRATE;
  			else
  				next_state = IDLE;
  		end
  		ARBITRATE:
  		begin
  			if(ccif.cctrans[0])
  			begin
  				service = 0;
  				if(ccif.dWEN[0])
  				begin
  					next_state = WB1;
  				end
  				else
  				begin
  					next_state = SNOOP;
  				end
  			end
  			else
  			begin
  				service = 1;
  				if(ccif.dWEN[1])
  				begin
  					next_state = WB1;
  				end
  				else
  				begin
  					next_state = SNOOP;
  				end
  			end
  		end
  		WB1:
  		begin
  			ccif.ramstore = ccif.dstore[service];
  			ccif.ramWEN = ccif.dWEN[service];
  			ccif.ramREN = 0;
  			ccif.ramaddr = ccif.daddr[service];
  			ccif.dwait = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = WB2;
  				ccif.dwait = 0;
  			end
  			else
  				next_state = WB1;
  		end
  		WB2:
  		begin
  			ccif.ramstore = ccif.dstore[service];
  			ccif.ramWEN = ccif.dWEN[service];
  			ccif.ramREN = 0;
  			ccif.ramaddr = ccif.daddr[service];
  			ccif.dwait = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = IDLE;
  				ccif.dwait = 0;
  			end
  			else
  				next_state = WB2;
  		end
  		SNOOP:
  		begin
  			ccif.ccsnoopaddr[~service] = ccif.daddr[service];
  			ccif.ccwait[~service] = 1;
  			if(ccif.ccwrite[service])
  				ccif.ccinv[~service] = 1;
  			if(ccif.ccwrite[~service])
  				next_state = RAMWRITE1;
  			else
  				next_state = RAMREAD1;
  		end
  		RAMWRITE1:
  		begin
  			ccif.ramWEN = 1;
  			ccif.ramREN = 0;
  			ccif.ramstore = ccif.dstore[~service];
  			ccif.dload[service] = ccif.dstore[~service];
  			ccif.ramaddr = ccif.daddr[~service];
  			ccif.dwait = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = RAMWRITE2;
  				ccif.dwait = 0;
  			end
  			else
  				next_state = RAMWRITE1;
  		end
  		RAMWRITE2:
  		begin
  			ccif.ramWEN = 1;
  			ccif.ramREN = 0;
  			ccif.ramstore = ccif.dstore[~service];
  			ccif.dload[service] = ccif.dstore[~service];
  			ccif.ramaddr = ccif.daddr[~service];
  			ccif.dwait = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = IDLE;
  				ccif.dwait = 0;
  			end
  			else
  				next_state = RAMWRITE2;
  		end
  		RAMREAD1:
  		begin
  			ccif.ramREN = 1;
  			ccif.ramaddr = ccif.daddr[service];
  			ccif.ramWEN = 0;
  			ccif.dwait = 1;
  			ccif.dload[service] = ccif.ramload;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = RAMREAD2;
  				ccif.dwait = 0;
  			end                
  			else
  				next_state = RAMREAD1;                               
  		end
  		RAMREAD2:
  		begin
  			ccif.ramREN = 1;
  			ccif.ramaddr = ccif.daddr[service];
  			ccif.ramWEN = 0;
  			ccif.dwait = 1;
  			ccif.dload[service] = ccif.ramload;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = IDLE;
  				ccif.dwait = 0;
  			end                
  			else
  				next_state = RAMREAD2;
  		end
  	endcase
  end

  /*

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
*/


endmodule
