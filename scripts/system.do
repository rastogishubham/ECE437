onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/PortB_int
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/z_comp
add wave -noupdate /system_tb/DUT/CPU/DP/z_final
add wave -noupdate /system_tb/DUT/CPU/DP/Branch_final
add wave -noupdate /system_tb/DUT/CPU/DP/branchAddr
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/PCSrc
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegWrite
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ExtOP
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/BNE
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Halt
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Jump
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/RegDest
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/JumpSel
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/ALUOP
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/opcode_out
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Rs
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Rt
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Rd
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Imm
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/j25
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group cuif /system_tb/DUT/CPU/DP/cuif/Instr
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/PCNext
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/PCOut
add wave -noupdate -group pcif /system_tb/DUT/CPU/DP/pcif/PCEN
add wave -noupdate -expand -group aluif /system_tb/DUT/CPU/DP/aluif/PortA
add wave -noupdate -expand -group aluif /system_tb/DUT/CPU/DP/aluif/PortB
add wave -noupdate -expand -group aluif /system_tb/DUT/CPU/DP/aluif/Output
add wave -noupdate -expand -group aluif /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -expand -group aluif /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -expand -group aluif /system_tb/DUT/CPU/DP/aluif/neg
add wave -noupdate -expand -group aluif /system_tb/DUT/CPU/DP/aluif/ALUOP
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group rfif /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/regDUT/register
add wave -noupdate -group ifidif /system_tb/DUT/CPU/DP/ifidif/ihit
add wave -noupdate -group ifidif /system_tb/DUT/CPU/DP/ifidif/flush
add wave -noupdate -group ifidif /system_tb/DUT/CPU/DP/ifidif/imemload
add wave -noupdate -group ifidif /system_tb/DUT/CPU/DP/ifidif/instr
add wave -noupdate -group ifidif /system_tb/DUT/CPU/DP/ifidif/pcp4_in
add wave -noupdate -group ifidif /system_tb/DUT/CPU/DP/ifidif/pcp4_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/ihit
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/PCSrc_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/RegWrite_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/dWEN_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/dREN_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/BNE_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/Halt_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/Jump_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/flush
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/ALUSrc_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/RegDest_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/JumpSel_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/MemtoReg_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/ALUOP_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/Rt_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/Rd_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/opcode_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/j25_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/shamt_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/rdat1_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/rdat2_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/pcp4_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/extImm_in
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/PCSrc_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/RegWrite_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/dWEN_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/dREN_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/BNE_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/Halt_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/Jump_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/ALUSrc_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/RegDest_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/JumpSel_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/MemtoReg_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/ALUOP_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/Rt_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/Rd_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/opcode_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/j25_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/shamt_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/rdat1_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/rdat2_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/pcp4_out
add wave -noupdate -expand -group idexif /system_tb/DUT/CPU/DP/idexif/extImm_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/ihit
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/dhit
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/dWEN_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/dREN_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/RegWrite_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/LUI_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/Halt_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/MemToReg_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/wsel_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/opcode_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/Porto_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/pcp4_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/dmemstr_in
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/dmemstr_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/dWEN_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/dREN_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/RegWrite_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/LUI_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/Halt_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/MemToReg_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/wsel_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/opcode_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/Porto_out
add wave -noupdate -expand -group exmemif /system_tb/DUT/CPU/DP/exmemif/pcp4_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/Halt_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/RegWrite_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/dhit
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/ihit
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/MemToReg_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/wsel_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/opcode_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/pcp4_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/LUI_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/Porto_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/dmemload_in
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/Halt_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/RegWrite_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/MemToReg_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/wsel_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/opcode_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/pcp4_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/LUI_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/Porto_out
add wave -noupdate -expand -group memwbif /system_tb/DUT/CPU/DP/memwbif/dmemload_out
add wave -noupdate -expand -group hzif /system_tb/DUT/CPU/DP/hzif/RegWrite_mem
add wave -noupdate -expand -group hzif /system_tb/DUT/CPU/DP/hzif/RegWrite_wb
add wave -noupdate -expand -group hzif /system_tb/DUT/CPU/DP/hzif/Rs_Sel
add wave -noupdate -expand -group hzif /system_tb/DUT/CPU/DP/hzif/Rt_Sel
add wave -noupdate -expand -group hzif /system_tb/DUT/CPU/DP/hzif/Rs_EX
add wave -noupdate -expand -group hzif /system_tb/DUT/CPU/DP/hzif/Rt_EX
add wave -noupdate -expand -group hzif /system_tb/DUT/CPU/DP/hzif/Wsel_mem
add wave -noupdate -expand -group hzif /system_tb/DUT/CPU/DP/hzif/Wsel_wb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1985959 ps} 0}
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
WaveRestoreZoom {1444766 ps} {2688507 ps}
