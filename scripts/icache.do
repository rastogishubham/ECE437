onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate /icache_tb/DUT/cachetab
add wave -noupdate /icache_tb/DUT/icachef
add wave -noupdate -expand -group dicif /icache_tb/dpicif/ihit
add wave -noupdate -expand -group dicif /icache_tb/dpicif/imemREN
add wave -noupdate -expand -group dicif /icache_tb/dpicif/imemload
add wave -noupdate -expand -group dicif /icache_tb/dpicif/imemaddr
add wave -noupdate -expand -group cicif /icache_tb/cichif/iwait
add wave -noupdate -expand -group cicif /icache_tb/cichif/iREN
add wave -noupdate -expand -group cicif /icache_tb/cichif/iload
add wave -noupdate -expand -group cicif /icache_tb/cichif/iaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17408 ns} 0}
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
WaveRestoreZoom {0 ns} {22845 ns}
