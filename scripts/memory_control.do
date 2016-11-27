onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/dwait
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/dREN
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/dWEN
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/dload
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/dstore
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/daddr
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/ccwait
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/ccinv
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/ccwrite
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/cctrans
add wave -noupdate -expand -group tbif /memory_control_tb/PROG/tbif/ccsnoopaddr
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/dwait
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/dREN
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/dWEN
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/dload
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/dstore
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/daddr
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/ccwait
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/ccinv
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/ccwrite
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/cctrans
add wave -noupdate -expand -group tbif2 /memory_control_tb/PROG/tbif2/ccsnoopaddr
add wave -noupdate -expand -group ramif /memory_control_tb/ramDUT/ramif/ramREN
add wave -noupdate -expand -group ramif /memory_control_tb/ramDUT/ramif/ramWEN
add wave -noupdate -expand -group ramif /memory_control_tb/ramDUT/ramif/ramaddr
add wave -noupdate -expand -group ramif /memory_control_tb/ramDUT/ramif/ramstore
add wave -noupdate -expand -group ramif /memory_control_tb/ramDUT/ramif/ramload
add wave -noupdate -expand -group ramif /memory_control_tb/ramDUT/ramif/ramstate
add wave -noupdate /memory_control_tb/DUT/service
add wave -noupdate /memory_control_tb/DUT/service
add wave -noupdate -expand -group ccif /memory_control_tb/DUT/state
add wave -noupdate -expand -group ccif /memory_control_tb/DUT/next_state
add wave -noupdate -expand -group ccif /memory_control_tb/DUT/service
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dwait
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dREN
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dWEN
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dload
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/dstore
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/daddr
add wave -noupdate -expand -group ccif -expand /memory_control_tb/ccif/ccwait
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ccinv
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ccwrite
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/cctrans
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramWEN
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramREN
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramstate
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramaddr
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramstore
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramload
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {31594 ps} 0}
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
WaveRestoreZoom {20175 ps} {93675 ps}
