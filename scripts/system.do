onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/CM/CLK
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/CM/nRST
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/CM/daddr
add wave -noupdate -expand -group caches /system_tb/DUT/CPU/CM/instr
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/halt
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/ihit
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/imemREN
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/imemload
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/imemaddr
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/dhit
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/dmemREN
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/dmemWEN
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/flushed
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/dmemload
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/dmemstore
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/CM/dcif/dmemaddr
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/iwait
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dwait
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/iREN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dREN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dWEN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/iload
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dload
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dstore
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/iaddr
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/daddr
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Instr
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/contDUT/opercode
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/contDUT/func_code
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Halt
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/PCSrc
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegWrite
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/JAL
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ExtOP
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/imemREN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/LUI
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/BNE
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegDest
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/JumpSel
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ALUOP
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Rs
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Rt
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Rd
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Imm
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group PCIF /system_tb/DUT/CPU/DP/pcif/PCNext
add wave -noupdate -group PCIF /system_tb/DUT/CPU/DP/pcif/PCOut
add wave -noupdate -group PCIF /system_tb/DUT/CPU/DP/pcif/PCEN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -group ruif /system_tb/DUT/CPU/DP/ruif/PCEN
add wave -noupdate -group ruif /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate -group ruif /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate -group ruif /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate -group ruif /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate -group ruif /system_tb/DUT/CPU/DP/ruif/dmemREN
add wave -noupdate -group ruif /system_tb/DUT/CPU/DP/ruif/dmemWEN
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2477532 ps} 0}
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
WaveRestoreZoom {2354777 ps} {2717684 ps}
