`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
module dcache (
	input CLK, nRST,
	datapath_cache_if.dcache ddcif,
	caches_if.dcache cdcif
);
typedef struct packed {
	logic v;
	logic [ITAG_W - 1:0] tag;
	word_t data;
} dcache_entry;

