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

typedef struct packed {
	logic v;
	word_t link;
} link_reg_t;

dcache_frame [7:0] dcache_tab;
dcachef_t dcachef, sndcachef;
logic match1, match2, dirty1, dirty2, LRU_idx, 
blockoff, next_dirty, next_v, next_LRU, cacheWEN, 
match_idx, data_idx, snmatch1, snmatch2, sndirty1, sndirty2,
sncacheWEN, sn_next_v, sn_next_dirty, sn_match_idx, flush_dirty, cacheflushWEN;
logic [4:0] count, n_count;
logic [25:0] next_tag;
word_t next_data, match_countup, match_countdown, next_match_countup, next_match_countdown;
typedef enum logic [3:0] {IDLE, WB1, WB2, LD1, LD2, FLUSH1, FLUSH2, FLUSH3, HALT, UPDATE_CACHE, WAIT, SNOOPWB1, SNOOPWB2, HALT_SNOOP} 
state_type;
state_type state, next_state;
link_reg_t link_reg, next_link_reg;

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
		link_reg.v <= 0;
		link_reg.link <= '0;
	end
	else
	begin
		count <= n_count;
		link_reg.v <= next_link_reg.v;
		link_reg.link <= next_link_reg.link;
		if (cacheWEN)
		begin
			dcache_tab[dcachef.idx].set[match_idx].dirty <= next_dirty;
			dcache_tab[dcachef.idx].set[match_idx].v <= next_v;
			dcache_tab[dcachef.idx].set[match_idx].tag <= next_tag;
			dcache_tab[dcachef.idx].set[match_idx].data[data_idx] <= next_data;
			dcache_tab[dcachef.idx].LRU <= next_LRU;
		end
		if(sncacheWEN)
		begin
			dcache_tab[sndcachef.idx].set[sn_match_idx].v <= sn_next_v;
			dcache_tab[sndcachef.idx].set[sn_match_idx].dirty <= sn_next_dirty;
		end
		if(cacheflushWEN)
			dcache_tab[count[2:0]].set[count[3]].dirty <= 0;
	end
end

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
	ddcif.dhit = 0;
	cdcif.cctrans = 0;
	cdcif.ccwrite = 0;
	sncacheWEN = 0;
	sn_next_v = 0;
	sn_next_dirty = 0;
	cacheflushWEN = 0;
	next_link_reg.link = link_reg.link;
	next_link_reg.v = link_reg.v;
	case(state)
		IDLE: begin
			n_count = 0;
			cacheWEN = 0;
			cdcif.dREN = 0;
			if(ddcif.datomic & ddcif.dmemREN)
			begin
				next_link_reg.link = ddcif.dmemaddr;
				next_link_reg.v = 1;
			end
			if(ddcif.datomic & ddcif.dmemWEN & ddcif.dmemaddr == link_reg.link & link_reg.v)
				ddcif.dmemload = 1;
			if(ddcif.datomic & ddcif.dmemWEN & (ddcif.dmemaddr != link_reg.link | !link_reg.v))
			begin
				ddcif.dhit = 1;
				ddcif.dmemload = 0;
				next_state = IDLE;
			end
			else if(!match1 && !match2 & (ddcif.dmemWEN | ddcif.dmemREN))
			begin
				if(LRU_idx == 0)
				begin
					if(dirty1)
						next_state = WB1;
					else
					begin
						cdcif.cctrans = 1;
						next_state = LD1;
					end
				end
				else
				begin
					if(dirty2)
						next_state = WB1;
					else
					begin
						cdcif.cctrans = 1;
						next_state = LD1;
					end
				end
			end
			else if((match1 | match2) & ddcif.dmemREN)
			begin
				ddcif.dhit = 1;
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
			else if(((match1 & dirty1) | (match2 & dirty2)) & ddcif.dmemWEN)
			begin
				ddcif.dhit = 1;
				if(ddcif.dmemWEN & link_reg.link == ddcif.dmemaddr)
				begin
					next_link_reg.v = 0;
				end
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
			else if((match1 | match2) & ddcif.dmemWEN)
			begin
				next_state = LD1;
				cdcif.cctrans = 1;
			end
			else if(cdcif.ccwait)
			begin
				next_state = WAIT;
				cdcif.cctrans = 0;
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
			if(cdcif.ccwait)
			begin
				next_state = WAIT;
				cdcif.cctrans = 0;
			end
			else if(cdcif.dwait)
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
				cdcif.cctrans = 1;
				next_state = LD1;
				next_dirty = 0;
				cacheWEN = 1;
			end
		end

		LD1: begin
			cdcif.cctrans = 1;
			next_LRU = match_idx;
			if(ddcif.dmemWEN)
				cdcif.ccwrite = 1;

			cdcif.dWEN = 0;
			cdcif.dREN = 1;
			cdcif.daddr = {dcachef.tag, dcachef.idx, 3'b000};
			if(cdcif.ccwait)
			begin
				next_state = WAIT;
				cdcif.cctrans = 0;
			end
			else if(cdcif.dwait)
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
			cdcif.cctrans = 1;
			cdcif.dWEN = 0;
			cdcif.dREN = 1;
			cdcif.daddr = {dcachef.tag, dcachef.idx, 3'b100};
			if(ddcif.dmemWEN)
				cdcif.ccwrite = 1;
			if(cdcif.dwait)
			begin
				next_state = LD2;
			end
			else if(~cdcif.dwait & ddcif.dmemWEN)
			begin
				next_state = UPDATE_CACHE;
				next_tag  = dcachef.tag;
				next_v = 1;
				next_dirty = 0;
				next_data = cdcif.dload;
				cacheWEN = 1;
			end
			else
			begin
				next_tag  = dcachef.tag;
				next_v = 1;
				next_dirty = 0;
				next_data = cdcif.dload;
				next_state = IDLE;
				cacheWEN = 1;
			end
		end

		FLUSH1: begin
			cacheWEN = 0;
			cdcif.dWEN = 0;
			if(cdcif.ccwait)
			begin
				next_state = WAIT;
				cdcif.cctrans = 0;
			end
			else if (!dcache_tab[count[2:0]].set[count[3]].dirty)
			begin
				n_count = count + 1;
				if(count > 5'd15)
					next_state = HALT;
				else
					next_state = FLUSH1;
			end
			else if (count <= 5'd15)
			begin
				next_state = FLUSH2;
			end
			else
			begin
				next_state = HALT;
			end
		end
		FLUSH2: begin
			cacheWEN = 0;
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			cdcif.daddr = {dcache_tab[count[2:0]].set[count[3]].tag, count[2:0], 3'b000};
			cdcif.dstore = dcache_tab[count[2:0]].set[count[3]].data[0];
			if(cdcif.ccwait)
			begin
				next_state = WAIT;
				cdcif.cctrans = 0;
			end
			else if(cdcif.dwait)
				next_state = FLUSH2;
			else
			begin
				next_state = FLUSH3;
			end
		end

		FLUSH3: begin
			cacheflushWEN = 1;
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
				if(count > 5'd15)
					next_state = HALT;
			end
		end
		HALT: begin
			cacheWEN = 0;
			ddcif.flushed = 1;
			cdcif.cctrans = 0;
			cdcif.ccwrite = 0;
			if(cdcif.ccwait)
				next_state = HALT_SNOOP;
			else
				next_state = HALT;
		end

		UPDATE_CACHE:
		begin
			if(ddcif.dmemWEN & link_reg.link == ddcif.dmemaddr)
			begin
				next_link_reg.v = 0;
			end
			if(ddcif.datomic & ddcif.dmemWEN & ddcif.dmemaddr == link_reg.link & link_reg.v)
			begin
				ddcif.dmemload = 1;
			end
			ddcif.dhit = 1;
			next_state = IDLE;
			cdcif.cctrans = 0;
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
		WAIT:
		begin
			cdcif.cctrans = 0;
			if(cdcif.ccinv & link_reg.link[31:3] == cdcif.ccsnoopaddr[31:3])
			begin
				next_link_reg.v = 0;
			end
			if(cdcif.ccinv & snmatch1 & ~sndirty1)
			begin
				sncacheWEN = 1;
				sn_next_v = 0;
				sn_next_dirty = sndirty1;
			end
			else if(cdcif.ccinv & snmatch2 & ~sndirty2)
			begin
				sncacheWEN = 1;
				sn_next_v = 0;
				sn_next_dirty = sndirty2;
			end
			else
				sncacheWEN = 0;
			if((snmatch1 & sndirty1) | (snmatch2 & sndirty2))
			begin
				cdcif.cctrans = 1;
				next_state = SNOOPWB1;
				cdcif.ccwrite = 1;
			end
			else if(~cdcif.ccwait)
				next_state = IDLE;
			else
			begin
				cdcif.cctrans = 1;
				next_state = WAIT;
				cdcif.ccwrite = 0;
			end
		end
		SNOOPWB1:
		begin
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			cdcif.daddr = {dcache_tab[sndcachef.idx].set[sn_match_idx].tag, sndcachef.idx, 3'b000};
			cdcif.dstore = dcache_tab[sndcachef.idx].set[sn_match_idx].data[0];
			if(~cdcif.dwait)
				next_state = SNOOPWB2;
			else if(~cdcif.ccwait)
				next_state = IDLE;
			else
				next_state = SNOOPWB1;
		end
		SNOOPWB2:
		begin
			cdcif.dWEN = 1;
			cdcif.dREN = 0;
			cdcif.daddr = {dcache_tab[sndcachef.idx].set[sn_match_idx].tag, sndcachef.idx, 3'b100};
			cdcif.dstore = dcache_tab[sndcachef.idx].set[sn_match_idx].data[1];

			if(~cdcif.dwait)
			begin
				if(snmatch1 & ~cdcif.ccinv)
				begin
					sncacheWEN = 1;
					sn_next_v = dcache_tab[sndcachef.idx].set[0].v;
					sn_next_dirty = 0;
				end
				else if(snmatch2 & ~cdcif.ccinv)
				begin
					sncacheWEN = 1;
					sn_next_v = dcache_tab[sndcachef.idx].set[1].v;
					sn_next_dirty = 0;
				end
				else if(snmatch1 & cdcif.ccinv)
				begin
					sncacheWEN = 1;
					sn_next_v = 0;
					sn_next_dirty = 0;
				end
				else if(snmatch2 & cdcif.ccinv)
				begin
					sncacheWEN = 1;
					sn_next_v = 0;
					sn_next_dirty = 0;
				end
				else
				begin
					sncacheWEN = 0;
				end
				next_state = IDLE;
			end
			else
				next_state = SNOOPWB2;
		end
		HALT_SNOOP:
		begin
			cacheWEN = 0;
			cdcif.cctrans = 1;
			next_state = HALT;
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
			next_match_countdown = 0;
			next_match_countup = 0;
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
assign match_idx = (match1) ? 0 : ((match2) ? 1 : LRU_idx);
assign data_idx = (match1 | match2) ? blockoff : ((state == LD1) ? 0 : 1);


//Snoop signals
assign sndcachef = dcachef_t'(cdcif.ccsnoopaddr);
assign sndirty1 = dcache_tab[sndcachef.idx].set[0].dirty;
assign sndirty2 = dcache_tab[sndcachef.idx].set[1].dirty;
assign snmatch1 = (dcache_tab[sndcachef.idx].set[0].tag == sndcachef.tag)
				& dcache_tab[sndcachef.idx].set[0].v;
assign snmatch2 = (dcache_tab[sndcachef.idx].set[1].tag == sndcachef.tag)
				& dcache_tab[sndcachef.idx].set[1].v;
assign sn_match_idx = (snmatch1) ? 0 : ((snmatch2) ? 1 : 0);		

//LL and SC
//assign next_link_reg.v = ~(ddcif.dmemWEN || cdcif.ccinv);

endmodule
