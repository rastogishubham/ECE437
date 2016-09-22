onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/Instr
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/contDUT/opercode
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/contDUT/func_code
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/Halt
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/PCSrc
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/RegWrite
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/JAL
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/ExtOP
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/imemREN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/LUI
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/BNE
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/RegDest
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/JumpSel
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/ALUOP
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/Rs
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/Rt
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/Rd
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/Imm
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/PCNext
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/PCOut
add wave -noupdate -expand -group PCIF /system_tb/DUT/CPU/DP/pcif/PCEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/PCEN
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dmemREN
add wave -noupdate -expand -group ruif /system_tb/DUT/CPU/DP/ruif/dmemWEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {30365319050 ps} {30365320050 ps}
