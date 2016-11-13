onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPU/CC/CLK
add wave -noupdate /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ccwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ccinv
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ccwrite
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/cctrans
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/service
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/service_icache
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/next_service_icache
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/state
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/dwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/iREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/dREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/dWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/iload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/dload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/dstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/iaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/daddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ramWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ramREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ramstate
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ramstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/CC/ccif/ramload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/halt
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/ihit
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/imemREN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/imemload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/imemaddr
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/dhit
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/datomic
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/dmemREN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/dmemWEN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/flushed
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/dmemload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/dmemstore
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/CM0/dcif/dmemaddr
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/iwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/dwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/iREN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/dREN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/dWEN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/iload
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/dload
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/dstore
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/iaddr
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/daddr
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/ccwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/ccinv
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/ccwrite
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/cctrans
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/CM0/cif/ccsnoopaddr
add wave -noupdate -expand -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/cachetab
add wave -noupdate -expand -group icache0 /system_tb/DUT/CPU/CM0/ICACHE/icachef
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dcache_tab
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dcachef
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/sndcachef
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/match1
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/match2
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dirty1
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/dirty2
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/LRU_idx
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/blockoff
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_dirty
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_v
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_LRU
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/cacheWEN
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/match_idx
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/data_idx
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snmatch1
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snmatch2
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/sndirty1
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/sndirty2
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/sncacheWEN
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/sn_next_v
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/sn_next_dirty
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/sn_match_idx
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/count
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/n_count
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_tag
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_data
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/match_countup
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/match_countdown
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_match_countup
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_match_countdown
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -expand -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/halt
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/ihit
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/imemREN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/imemload
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/imemaddr
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/dhit
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/datomic
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/dmemREN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/dmemWEN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/flushed
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/dmemload
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/dmemstore
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/CM1/dcif/dmemaddr
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/iwait
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/dwait
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/iREN
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/dREN
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/dWEN
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/iload
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/dload
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/dstore
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/iaddr
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/daddr
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/ccwait
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/ccinv
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/ccwrite
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/cctrans
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/CM1/cif/ccsnoopaddr
add wave -noupdate -expand -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/cachetab
add wave -noupdate -expand -group icache1 /system_tb/DUT/CPU/CM1/ICACHE/icachef
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dcache_tab
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dcachef
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/sndcachef
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/match1
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/match2
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dirty1
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/dirty2
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/LRU_idx
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/blockoff
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_dirty
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_v
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_LRU
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/cacheWEN
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/match_idx
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/data_idx
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snmatch1
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snmatch2
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/sndirty1
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/sndirty2
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/sncacheWEN
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/sn_next_v
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/sn_next_dirty
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/sn_match_idx
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/count
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/n_count
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_tag
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_data
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/match_countup
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/match_countdown
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_match_countup
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_match_countdown
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -expand -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {52433 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {218066 ps}
