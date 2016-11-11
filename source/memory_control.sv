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
  logic service, next_service;
  logic service_icache, next_service_icache;
  typedef enum logic [3:0] {IDLE, INSTR_SERVICE, ARB, WB1, WB2, SNOOP, RAMWRITE1, RAMWRITE2, RAMREAD1, RAMREAD2}
  state_type;
  state_type state, next_state;

  always_ff @(posedge CLK, negedge nRST)
  begin
  	if(~nRST)
  	begin
  		state <= IDLE;
  		//service_icache <= 0;
  	end
 	else
 	begin
  		state <= next_state;
  		service <= next_service;
  		/*if(ccif.cctrans[0] || ccif.dWEN[0])
  		 	service <= 0;
  		else if(ccif.cctrans[1] || ccif.dWEN[1])
  		 	service <= 1;
  		else
  		begin
  		 	/*if(ccif.dWEN[0])
  		 		service <= 0;
  		 	else if(ccif.dWEN[1])
  		 		service <= 1;
  		 	else
  		 		service <= 0;
  		end*/
  	end
  end

always_ff @(posedge CLK, negedge nRST) 
begin
  	if(~nRST)
  		service_icache <= 0;

  	else
  	begin
  	if(~ccif.iwait[0] | ~ccif.iwait[1])
			service_icache <= ~service_icache;
	end
end


  always_comb
  begin
  	next_state = state;
  	ccif.dwait = 2'b11;
  	ccif.ramWEN = 0;
  	ccif.ramREN = 0;
  	ccif.ramaddr = '0;
  	ccif.ramstore = 0;
  	ccif.ccsnoopaddr = 0;
  	ccif.dload = 0;
  	ccif.ccwait = 0;
  	ccif.ccinv = 0;
	ccif.iwait = 2'b11;
	ccif.iload = 0;
	next_service = service;
	//next_service_icache = service_icache;
  	case(state)
  		IDLE:
  		begin
	  		/*if(ccif.iREN[0] && ccif.iREN[1])
			begin
				next_service_icache = ~service_icache;
			end
			else if(ccif.iREN[0])
			begin
				next_service_icache = 0;
			end
			else if(ccif.iREN[1])
			begin
				next_service_icache = 1;
			end
			else
			begin
				next_service_icache = service_icache;
			end*/

			if(ccif.cctrans[0] || ccif.dWEN[0])
  		 		next_service = 0;
  			else if(ccif.cctrans[1] || ccif.dWEN[1])
  		 		next_service = 1;
  			else
  				next_service = service;

  			if(ccif.cctrans)
  			begin
  				next_state = ARB;
  			end
  			else if(ccif.dWEN)
  				next_state = ARB;
  			else if(ccif.iREN[0] | ccif.iREN[1])
  				next_state = INSTR_SERVICE;
  			else
  			begin
  				next_state = IDLE;
  			end
  		end
  		ARB:
  		begin
  			if(ccif.cctrans[service])
  			begin
  				next_state = SNOOP;
  			end
  			else
  				next_state = WB1;
  		end
  		INSTR_SERVICE:
  		begin
  			if(service_icache == 0 & ccif.iREN[0] & ccif.iREN[1])
  			begin
		  		ccif.ramREN = ccif.iREN[1];
				ccif.ramaddr = ccif.iaddr[1];
				ccif.iload[1] = ccif.ramload;
				if(ccif.ramstate == ACCESS)
				begin
					ccif.iwait[1] = 0;
	  				next_state = IDLE;
	  			end
	  			else
	  				next_state = INSTR_SERVICE;
  			end
  			else if(service_icache == 0 & ccif.iREN[0] & ~ccif.iREN[1])
  			begin
		  		ccif.ramREN = ccif.iREN[0];
				ccif.ramaddr = ccif.iaddr[0];
				ccif.iload[0] = ccif.ramload;
				if(ccif.ramstate == ACCESS)
				begin
					ccif.iwait[0] = 0;
	  				next_state = IDLE;
	  			end
	  			else
	  				next_state = INSTR_SERVICE;
  			end
  			else if(service_icache == 0 & ~ccif.iREN[0] & ccif.iREN[1])
  			begin
		  		ccif.ramREN = ccif.iREN[1];
				ccif.ramaddr = ccif.iaddr[1];
				ccif.iload[1] = ccif.ramload;
				if(ccif.ramstate == ACCESS)
				begin
					ccif.iwait[1] = 0;
	  				next_state = IDLE;
	  			end
	  			else
	  				next_state = INSTR_SERVICE;
  			end
  			else if(service_icache == 1 & ccif.iREN[0] & ccif.iREN[1])
  			begin
		  		ccif.ramREN = ccif.iREN[0];
				ccif.ramaddr = ccif.iaddr[0];
				ccif.iload[0] = ccif.ramload;
				if(ccif.ramstate == ACCESS)
				begin
					ccif.iwait[0] = 0;
	  				next_state = IDLE;
	  			end
	  			else
	  				next_state = INSTR_SERVICE;
  			end
  			else if(service_icache == 1 & ~ccif.iREN[0] & ccif.iREN[1])
  			begin
		  		ccif.ramREN = ccif.iREN[1];
				ccif.ramaddr = ccif.iaddr[1];
				ccif.iload[1] = ccif.ramload;
				if(ccif.ramstate == ACCESS)
				begin
					ccif.iwait[1] = 0;
	  				next_state = IDLE;
	  			end
	  			else
	  				next_state = INSTR_SERVICE;
  			end
  			else if(service_icache == 1 & ccif.iREN[0] & ~ccif.iREN[1])
  			begin
		  		ccif.ramREN = ccif.iREN[0];
				ccif.ramaddr = ccif.iaddr[0];
				ccif.iload[0] = ccif.ramload;
				if(ccif.ramstate == ACCESS)
				begin
					ccif.iwait[0] = 0;
	  				next_state = IDLE;
	  			end
	  			else
	  				next_state = INSTR_SERVICE;
  			end
  			else 
  				next_state = IDLE;
  		end
  		WB1:
  		begin
  			ccif.ramstore = ccif.dstore[service];
  			ccif.ramWEN = ccif.dWEN[service];
  			ccif.ramREN = 0;
  			ccif.ramaddr = ccif.daddr[service];
  			ccif.dwait[service] = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = WB2;
  				ccif.dwait[service] = 0;
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
  			ccif.dwait[service] = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = IDLE;
  				ccif.dwait[service] = 0;
  			end
  			else
  				next_state = WB2;
  		end
  		SNOOP:
  		begin
  			ccif.ccsnoopaddr[~service] = ccif.daddr[service];
  			ccif.ccinv[~service] = ccif.ccwrite[service];
  			ccif.ccwait[~service] = 1;
  			if(ccif.ccwrite[~service] & ccif.cctrans[~service])
  				next_state = RAMWRITE1;
  			else if(~ccif.ccwrite[~service] & ccif.cctrans[~service])
  				next_state = RAMREAD1;
  			else
  				next_state = SNOOP;
  		end
  		RAMWRITE1:
  		begin
  			ccif.ccsnoopaddr[~service] = ccif.daddr[service];
  			ccif.ramWEN = 1;
  			ccif.ramREN = 0;
  			ccif.ramstore = ccif.dstore[~service];
  			ccif.dload[service] = ccif.dstore[~service];
  			ccif.ramaddr = ccif.daddr[~service];
  			ccif.dwait[service] = 1;
  			ccif.dwait[~service] = 1;
  			ccif.ccinv[~service] = ccif.ccwrite[service];
  			ccif.ccwait[~service] = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = RAMWRITE2;
  				ccif.dwait[service] = 0;
  				ccif.dwait[~service] = 0;
  			end
  			else
  				next_state = RAMWRITE1;
  		end
  		RAMWRITE2:
  		begin
  			ccif.ccsnoopaddr[~service] = ccif.daddr[service];
  			ccif.ramWEN = 1;
  			ccif.ramREN = 0;
  			ccif.ramstore = ccif.dstore[~service];
  			ccif.dload[service] = ccif.dstore[~service];
  			ccif.ramaddr = ccif.daddr[~service];
  			ccif.dwait[service] = 1;
  			ccif.dwait[~service] = 1;
  			ccif.ccinv[~service] = ccif.ccwrite[service];
  			ccif.ccwait[~service] = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = IDLE;
  				ccif.dwait[service] = 0;
  				ccif.dwait[~service] = 0;
  			end
  			else
  				next_state = RAMWRITE2;
  		end
  		RAMREAD1:
  		begin
  			ccif.ramREN = 1;
  			ccif.ramaddr = ccif.daddr[service];
  			ccif.ramWEN = 0;
  			ccif.dwait[service] = 1;
  			ccif.dwait[~service] = 1;
  			ccif.dload[service] = ccif.ramload;
  			ccif.ccinv[~service] = ccif.ccwrite[service];
  			ccif.ccwait[~service] = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = RAMREAD2;
  				ccif.dwait[service] = 0;
  				ccif.dwait[~service] = 0;
  			end                
  			else
  				next_state = RAMREAD1;                               
  		end
  		RAMREAD2:
  		begin
  			ccif.ramREN = 1;
  			ccif.ramaddr = ccif.daddr[service];
  			ccif.ramWEN = 0;
  			ccif.dwait[service] = 1;
  			ccif.dload[service] = ccif.ramload;
  			ccif.ccinv[~service] = ccif.ccwrite[service];
  			ccif.ccwait[~service] = 1;
  			if(ccif.ramstate == ACCESS)
  			begin
  				next_state = IDLE;
  				ccif.dwait[service] = 0;
  			end                
  			else
  				next_state = RAMREAD2;
  		end
  	endcase
  end

/*always_comb
begin	//if(state == IDLE)
		
//	if(state == INSTR_SERVICE)
		

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
