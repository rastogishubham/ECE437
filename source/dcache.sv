`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
module dcache (
	input CLK, nRST,
	datapath_cache_if.dcache ddcif,
	caches_if.dcache cdcif
);

