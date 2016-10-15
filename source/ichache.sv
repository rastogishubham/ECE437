`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
module icache (
	input CLK, nRST,
	datapath_cache_if.icache dicif,
	caches_if.icache cicif
);
import cpu_types_pkg::*;
typedef struct packed {
	logic v;
	logic [ITAG_W - 1:0] tag;
	word_t data;
} icache_entry;

icache_entry [15:0] cachetab;
icachef_t icachef;
always_ff @(posedge CLK, negedge nRST)
begin
	if (!nRST)
	begin
		for (integer i=0; i <= 15; i = i + 1)
		begin
			cachetab[i].v <= 0;
			cachetab[i].tag <= '0;
			cachetab[i].data <= '0;
		end
	end
	else
	begin	
		if (dicif.imemREN && !cicif.iwait)
		begin
			cachetab[icachef.idx].v <= 1;
			cachetab[icachef.idx].tag <= icachef.tag;
			cachetab[icachef.idx].data <= cicif.iload;
		end
	end
end
assign icachef = icachef_t'(dicif.imemaddr);
assign dicif.ihit = (cachetab[icachef.idx].tag == dicif.imemaddr[31:5]) ? (cachetab[icachef.idx].v): 0;
assign dicif.imemload = cachetab[icachef.idx].data;
assign cicif.iaddr = dicif.imemaddr; 
assign cicif.iREN = dicif.imemREN;
endmodule
/*always_comb
begin
	if (dicif.imemREN && !cicif.iwait)
	begin
		icache_table.tag = dicif.imemaddr[31:5];
		icache_table.v = 1;

end
*/