`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
import cpu_types_pkg::*;
module dcache (
	input CLK, nRST,
	datapath_cache_if.dcache ddcif,
	caches_if.dcache cdcif
);
typedef struct packed {
	logic v;
	logic dirty;
	logic [ITAG_W - 1:0] tag;
	word_t [1:0] data;
} dcache_entry;

typedef struct packed {
	dcache_entry [1:0] set;
	logic LRU;
} dcache_frame;

dcache_frame [7:0] dcache_tab;
dcachef_t dcachef;
logic match1;
logic match2;
logic dirty1;
logic dirty2;
logic LRU_idx;
logic blockoff;
logic [3:0] count;

logic next_dirty;
logic [25:0] next_tag;
logic next_v;
word_t next_data;
logic next_LRU;
logic cacheWEN;
logic [3:0] n_count;
logic signed [31:0] match_count;
logic dhit_int;
logic [1:0] load_WEN;
typedef enum logic [3:0] {IDLE, WB1, WB2, LD1, LD2, FLUSH1, FLUSH2, FLUSH3, WRITE_COUNT, HALT} 
state_type;
state_type state, next_state;

always_ff @(posedge CLK, negedge nRST) 
begin
	if(~nRST)
	begin
		 state <= IDLE;
	end 
	else
		 state <= next_state;
end

always_ff @(posedge CLK or negedge nRST) 
begin
	if(~nRST)
	begin
		for (integer i = 0; i <= 7; i = i + 1)
		begin
			dcache_tab[i].set[0] <= dcache_entry'(0);
			dcache_tab[i].set[1] <= dcache_entry'(0);
			dcache_tab[i].LRU <= 0;
		end
	end
	else
	begin
		count <= n_count;
		if (cacheWEN & load_WEN == 0)
		begin
			dcache_tab[dcachef.idx].set[LRU_idx].dirty <= next_dirty;
			dcache_tab[dcachef.idx].set[LRU_idx].v <= next_v;
			dcache_tab[dcachef.idx].set[LRU_idx].tag <= next_tag;
			dcache_tab[dcachef.idx].set[LRU_idx].data[blockoff] <= next_data;
			dcache_tab[dcachef.idx].LRU <= next_LRU;
		end
		else
		begin
			if(load_WEN == 1 & cacheWEN == 1)
			begin
				dcache_tab[dcachef.idx].set[LRU_idx].dirty <= next_dirty;
				dcache_tab[dcachef.idx].set[LRU_idx].v <= next_v;
				dcache_tab[dcachef.idx].set[LRU_idx].tag <= next_tag;
				dcache_tab[dcachef.idx].set[LRU_idx].data[0] <= next_data;
				dcache_tab[dcachef.idx].LRU <= next_LRU;
			end
			else if(load_WEN == 2'b10 & cacheWEN == 1)
			begin
				dcache_tab[dcachef.idx].set[LRU_idx].dirty <= next_dirty;
				dcache_tab[dcachef.idx].set[LRU_idx].v <= next_v;
				dcache_tab[dcachef.idx].set[LRU_idx].tag <= next_tag;
				dcache_tab[dcachef.idx].set[LRU_idx].data[1] <= next_data;
				dcache_tab[dcachef.idx].LRU <= next_LRU;
			end
		end
	end
end

always_comb
begin
	next_state = state;
	//next_LRU = 0;
	next_data = 0;
	next_tag = 0;
	next_v = 0;
	next_dirty = 0;
	load_WEN = 2'b0;
	cacheWEN = 0;
	if(ddcif.dhit)
		match_count += 1;
	else if(~(match1 | match2) & (ddcif.dmemREN | ddcif.dmemWEN) & ddcif.dhit)
		match_count -= 1;
	else
		match_count += 0;
	case(state)
		IDLE: begin
			n_count = 0;
			cacheWEN = 0;
			cdcif.dREN = 0;
			if(!match1 && !match2 & (ddcif.dmemWEN | ddcif.dmemREN))
			begin
				if(LRU_idx == 0)
				begin
					if(dirty1)
						next_state = WB1;
					else
						next_state = LD1;
				end
				else
				begin
					if(dirty2)
						next_state = WB1;
					else
						next_state = LD1;
				end
			end
			else if((match1 | match2) & ddcif.dmemREN)
			begin
				if(match1)
				begin
					next_LRU = 1;
					cacheWEN = 1;
					ddcif.dmemload = dcache_tab[dcachef.idx].set[0].data[blockoff];
				end
				else
				begin
					cacheWEN = 1;
					next_LRU = 0;
					ddcif.dmemload = dcache_tab[dcachef.idx].set[1].data[blockoff];
				end
			end
			else if((match1 | match2) & ddcif.dmemWEN)
			begin
				if(match1)
				begin
					cacheWEN = 1;
					next_data = ddcif.dmemstore;
					next_v = 1;
					next_tag = dcachef.tag;
					next_dirty = 1;
					next_LRU = 1;
				end
				else
				begin
					cacheWEN = 1;
					next_data = ddcif.dmemstore;
					next_v = 1;
					next_tag = dcachef.tag;
					next_dirty = 1;
					next_LRU = 0;
				end
			end
			else if(ddcif.halt)
				next_state = FLUSH1;
			else
				next_state = IDLE;
		end

		WB1: begin
			cacheWEN = 0;
			next_data = 0;
			next_v = 0;
			next_tag = 0;
			next_dirty = 0;
		//	next_LRU = 0;
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			cdcif.daddr = {dcache_tab[dcachef.idx].set[LRU_idx].tag, dcachef.idx, 3'b000};
			cdcif.dstore = dcache_tab[dcachef.idx].set[LRU_idx].data[0];
			if(cdcif.dwait)
				next_state = WB1;
			else
				next_state = WB2;
		end

		WB2: begin
			cacheWEN = 0;
			next_data = 0;
			next_v = 0;
			next_tag = 0;
			next_dirty = 0;
			//next_LRU = 0;
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			cdcif.daddr = {dcache_tab[dcachef.idx].set[LRU_idx].tag, dcachef.idx, 3'b100};
			cdcif.dstore = dcache_tab[dcachef.idx].set[LRU_idx].data[1];
			if(cdcif.dwait)
				next_state = WB2;
			else
			begin
				next_state = LD1;
				next_dirty = 0;
				cacheWEN = 1;
			end
		end

		LD1: begin
			cdcif.dWEN = 0;
			cdcif.dREN = 1;
			cdcif.daddr = {dcache_tab[dcachef.idx].set[LRU_idx].tag, dcachef.idx, 3'b000};
			if(cdcif.dwait)
			begin
				next_state = LD1;
			end
			else
			begin
				next_tag  = dcachef.tag;
				next_v = 0;
				next_dirty = 0;
				next_data = cdcif.dload;
				next_state = LD2;
			//	next_LRU = LRU_idx;
				cacheWEN = 1;
				load_WEN = 2'b01;
			end
		end

		LD2: begin
			cdcif.dWEN = 0;
			cdcif.dREN = 1;
			cdcif.daddr = {dcache_tab[dcachef.idx].set[LRU_idx].tag, dcachef.idx, 3'b100};
			if(cdcif.dwait)
			begin
				next_state = LD2;
			end
			else
			begin
				next_tag  = dcachef.tag;
				next_v = 1;
				next_dirty = 0;
				next_data = cdcif.dload;
				next_state = IDLE;
				//next_LRU = LRU_idx;
				cacheWEN = 1;
				load_WEN = 2'b10;
			end
		end

		FLUSH1: begin
			cacheWEN = 0;
			next_data = 0;
			next_v = 0;
			next_tag = 0;
			next_dirty = 0;
			//next_LRU = 0;
			if (!dcache_tab[count[2:0]].set[0].dirty && !dcache_tab[count[2:0]].set[1].dirty)
				n_count = count + 1;
			if (count != 4'd15)
			begin
				//n_count = count;
				next_state = FLUSH2;
			end
			else
			begin
				//n_count = count;
				next_state = WRITE_COUNT;
			end
		end
		FLUSH2: begin
			cacheWEN = 0;
			next_data = 0;
			next_v = 0;
			next_tag = 0;
			next_dirty = 0;
			//next_LRU = 0;
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			n_count = count + 1;
			cdcif.daddr = {dcache_tab[count[2:0]].set[count[3]].tag, count[2:0], 3'b000};
			cdcif.dstore = dcache_tab[count[2:0]].set[count[3]].data[0];
			if(cdcif.dwait)
				next_state = FLUSH2;
			else
				next_state = FLUSH3;
		end

		FLUSH3: begin
			cacheWEN = 0;
			next_data = 0;
			next_v = 0;
			next_tag = 0;
			next_dirty = 0;
			//next_LRU = 0;
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			cdcif.daddr = {dcache_tab[count[2:0]].set[count[3]].tag, count[2:0], 3'b100};
			cdcif.dstore = dcache_tab[count[2:0]].set[count[3]].data[1];
			if(cdcif.dwait)
				next_state = FLUSH3;
			else
				next_state = FLUSH1;
		end
		WRITE_COUNT: begin
			cacheWEN = 0;
			next_data = 0;
			next_v = 0;
			next_tag = 0;
			next_dirty = 0;
		//	next_LRU = 0;
			cdcif.dWEN = 1;
			cdcif.daddr = 32'h00003100;
			cdcif.dstore = match_count;
			if(cdcif.dwait)
				next_state = WRITE_COUNT;
			else
				next_state = HALT;
		end
		HALT: begin
			cacheWEN = 0;
			next_data = 0;
			next_v = 0;
			next_tag = 0;
			next_dirty = 0;
		//	next_LRU = 0;
			next_state = HALT;
			match_count = 0;
			ddcif.flushed = 1;
		end
		default: begin
			next_state = state;
			next_LRU = 0;
			next_data = 0;
			next_tag = 0;
			next_v = 0;
			next_dirty = 0;
			load_WEN = 2'b0;
			cacheWEN = 0;
			match_count = 0;
		end
	endcase
end

assign LRU_idx = dcache_tab[dcachef.idx].LRU;
assign dcachef = dcachef_t'(ddcif.dmemaddr);
assign match1 = (dcache_tab[dcachef.idx].set[0].tag == dcachef.tag) 
				& dcache_tab[dcachef.idx].set[0].v;
				//& (ddcif.dmemREN | ddcif.dmemWEN);
assign dirty1 = dcache_tab[dcachef.idx].set[0].dirty;
assign match2 = (dcache_tab[dcachef.idx].set[1].tag == dcachef.tag) 
				& dcache_tab[dcachef.idx].set[1].v;
				//& (ddcif.dmemREN | ddcif.dmemWEN);
assign dirty2 = dcache_tab[dcachef.idx].set[1].dirty;
assign blockoff = dcachef.blkoff;
assign ddcif.dhit = ((match1 | match2) & (ddcif.dmemREN | ddcif.dmemWEN));
endmodule