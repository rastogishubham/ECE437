onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group DUT /dcache_tb/DUT/dcache_tab
add wave -noupdate -expand -group DUT /dcache_tb/DUT/dcachef
add wave -noupdate -expand -group DUT /dcache_tb/DUT/match1
add wave -noupdate -expand -group DUT /dcache_tb/DUT/match2
add wave -noupdate -expand -group DUT /dcache_tb/DUT/dirty1
add wave -noupdate -expand -group DUT /dcache_tb/DUT/dirty2
add wave -noupdate -expand -group DUT /dcache_tb/DUT/LRU_idx
add wave -noupdate -expand -group DUT /dcache_tb/DUT/blockoff
add wave -noupdate -expand -group DUT /dcache_tb/DUT/count
add wave -noupdate -expand -group DUT /dcache_tb/DUT/next_dirty
add wave -noupdate -expand -group DUT /dcache_tb/DUT/next_tag
add wave -noupdate -expand -group DUT /dcache_tb/DUT/next_v
add wave -noupdate -expand -group DUT /dcache_tb/DUT/next_data
add wave -noupdate -expand -group DUT /dcache_tb/DUT/next_LRU
add wave -noupdate -expand -group DUT /dcache_tb/DUT/cacheWEN
add wave -noupdate -expand -group DUT /dcache_tb/DUT/n_count
add wave -noupdate -expand -group DUT /dcache_tb/DUT/state
add wave -noupdate -expand -group DUT /dcache_tb/DUT/next_state
add wave -noupdate -expand -group DUT /dcache_tb/DUT/match_countup
add wave -noupdate -expand -group DUT /dcache_tb/DUT/match_countdown
add wave -noupdate -expand -group ddcif /dcache_tb/DUT/ddcif/halt
add wave -noupdate -expand -group ddcif /dcache_tb/DUT/ddcif/dhit
add wave -noupdate -expand -group ddcif /dcache_tb/DUT/ddcif/dmemREN
add wave -noupdate -expand -group ddcif /dcache_tb/DUT/ddcif/dmemWEN
add wave -noupdate -expand -group ddcif /dcache_tb/DUT/ddcif/flushed
add wave -noupdate -expand -group ddcif /dcache_tb/DUT/ddcif/dmemload
add wave -noupdate -expand -group ddcif /dcache_tb/DUT/ddcif/dmemstore
add wave -noupdate -expand -group ddcif /dcache_tb/DUT/ddcif/dmemaddr
add wave -noupdate -expand -group cdcif /dcache_tb/DUT/cdcif/dwait
add wave -noupdate -expand -group cdcif /dcache_tb/DUT/cdcif/dREN
add wave -noupdate -expand -group cdcif /dcache_tb/DUT/cdcif/dWEN
add wave -noupdate -expand -group cdcif /dcache_tb/DUT/cdcif/dload
add wave -noupdate -expand -group cdcif /dcache_tb/DUT/cdcif/dstore
add wave -noupdate -expand -group cdcif /dcache_tb/DUT/cdcif/daddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {206 ns} 0}
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
WaveRestoreZoom {0 ns} {499 ns}
