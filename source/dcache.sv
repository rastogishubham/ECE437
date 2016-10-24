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
logic match1, match2, dirty1, dirty2, LRU_idx, 
blockoff, next_dirty, next_v, next_LRU, cacheWEN, 
match_idx, data_idx;
logic [3:0] count, n_count;
logic [25:0] next_tag;
word_t next_data, match_countup, match_countdown, next_match_countup, next_match_countdown;
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

always_ff @(posedge CLK, negedge nRST) 
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
		match_countup <=  next_match_countup;
		match_countdown <= next_match_countdown;
		if (cacheWEN)
		begin
			dcache_tab[dcachef.idx].set[match_idx].dirty <= next_dirty;
			dcache_tab[dcachef.idx].set[match_idx].v <= next_v;
			dcache_tab[dcachef.idx].set[match_idx].tag <= next_tag;
			dcache_tab[dcachef.idx].set[match_idx].data[data_idx] <= next_data;
			dcache_tab[dcachef.idx].LRU <= next_LRU;
		end
	end
end

/*always_ff @(posedge ddcif.dhit, negedge nRST)
begin
	if(~nRST) 
	begin
		 match_countup <= 0;
	end
	else 
	begin
		 match_countup <= match_countup + 1;
	end
end

always_ff @(negedge cdcif.dwait, negedge nRST)
begin
	if(~nRST) 
	begin
		 match_countdown <= 0;
	end
	else 
	begin
		if(state == LD2)
			match_countdown <= match_countdown + 1;
	end
end*/

always_comb
begin
	next_state = state;
	next_data = dcache_tab[dcachef.idx].set[match_idx].data[data_idx];
	next_tag = dcache_tab[dcachef.idx].set[match_idx].tag;
	next_v = dcache_tab[dcachef.idx].set[match_idx].v;
	next_dirty = dcache_tab[dcachef.idx].set[match_idx].dirty;
	next_LRU = LRU_idx;
	cacheWEN = 0;
	n_count = count;
	ddcif.flushed = 0;
	cdcif.dstore = 32'b0;
	cdcif.daddr = 32'b0;
	cdcif.dWEN = 0;
	ddcif.dmemload = 32'b0;
	cdcif.dREN = 0;
	next_match_countdown = match_countdown;
	next_match_countup = match_countup;
	case(state)
		IDLE: begin
			n_count = 0;
			cacheWEN = 0;
			cdcif.dREN = 0;

			if(ddcif.dhit)
			begin
				next_match_countup = match_countup + 1;
			end

			if(!match1 && !match2 & (ddcif.dmemWEN | ddcif.dmemREN))
			begin
				//match_countdown += 1;
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
			//	match_countup += 1;
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
			//	match_countup += 1;
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
			cdcif.daddr = {dcachef.tag, dcachef.idx, 3'b000};
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
				cacheWEN = 1;
			end
		end

		LD2: begin
			cdcif.dWEN = 0;
			cdcif.dREN = 1;
			cdcif.daddr = {dcachef.tag, dcachef.idx, 3'b100};
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
				cacheWEN = 1;
				next_match_countdown = match_countdown + 1;
			end
		end

		FLUSH1: begin
			cacheWEN = 0;
			cdcif.dWEN = 0;
			if (!dcache_tab[count[2:0]].set[count[3]].dirty)
			begin
				n_count = count + 1;
				if(count != 4'd15)
					next_state = FLUSH1;
				else
					next_state = WRITE_COUNT;
			end
			else if (count != 4'd15)
			begin
				next_state = FLUSH2;
			end
			else
			begin
				next_state = WRITE_COUNT;
			end
		end
		FLUSH2: begin
			cacheWEN = 0;
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			cdcif.daddr = {dcache_tab[count[2:0]].set[count[3]].tag, count[2:0], 3'b000};
			cdcif.dstore = dcache_tab[count[2:0]].set[count[3]].data[0];
			if(cdcif.dwait)
				next_state = FLUSH2;
			else
			begin
				next_state = FLUSH3;
			end
		end

		FLUSH3: begin
			cacheWEN = 0;
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			cdcif.daddr = {dcache_tab[count[2:0]].set[count[3]].tag, count[2:0], 3'b100};
			cdcif.dstore = dcache_tab[count[2:0]].set[count[3]].data[1];
			if(cdcif.dwait)
				next_state = FLUSH3;
			else
			begin
				next_state = FLUSH1;
				n_count = count + 1;
				if(count == 4'd15)
					next_state = WRITE_COUNT;
			end
		end
		WRITE_COUNT: begin
			cacheWEN = 0;
			cdcif.dWEN = 1;
			cdcif.daddr = 32'h00003100;
			cdcif.dstore = (match_countup - match_countdown);
			if(cdcif.dwait)
				next_state = WRITE_COUNT;
			else
				next_state = HALT;
		end
		HALT: begin
			cacheWEN = 0;
			next_state = HALT;
			ddcif.flushed = 1;
		end
		default: begin
			next_state = state;
			next_LRU = 0;
			next_data = 0;
			next_tag = 0;
			next_v = 0;
			next_dirty = 0;
			cacheWEN = 0;
			ddcif.flushed = 0;
			cdcif.dWEN = 0;
			cdcif.dREN = 0;
			cdcif.dstore = 0;
			cdcif.daddr = 0;
			ddcif.dmemload = 0;
			n_count = 0;
		end
	endcase
end

assign LRU_idx = dcache_tab[dcachef.idx].LRU;
assign dcachef = dcachef_t'(ddcif.dmemaddr);
assign match1 = (dcache_tab[dcachef.idx].set[0].tag == dcachef.tag) 
				& dcache_tab[dcachef.idx].set[0].v;
assign dirty1 = dcache_tab[dcachef.idx].set[0].dirty;
assign match2 = (dcache_tab[dcachef.idx].set[1].tag == dcachef.tag) 
				& dcache_tab[dcachef.idx].set[1].v;
assign dirty2 = dcache_tab[dcachef.idx].set[1].dirty;
assign blockoff = dcachef.blkoff;
assign ddcif.dhit = ((match1 | match2) & (ddcif.dmemREN | ddcif.dmemWEN));
assign match_idx = (match1) ? 0 : ((match2) ? 1 : LRU_idx);
assign data_idx = (match1 | match2) ? blockoff : ((state == LD1) ? 0 : 1);
endmodule