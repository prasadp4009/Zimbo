onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /zimbotb2/zimboinst/clock
add wave -noupdate /zimbotb2/zimboinst/reset_n
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/pcin
add wave -noupdate -radix binary /zimbotb2/zimboinst/rmdata
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/pcout
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/addrm
add wave -noupdate -radix binary /zimbotb2/zimboinst/wmdata
add wave -noupdate -radix hexadecimal /zimbotb2/zimboinst/wrfdata
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/rdata1
add wave -noupdate -radix hexadecimal /zimbotb2/zimboinst/rdata2
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/result
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/var1
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/var2
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/addr1
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/regfileinst/addr1
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/addr2
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/regfileinst/addr2
add wave -noupdate /zimbotb2/zimboinst/opcode
add wave -noupdate -radix binary /zimbotb2/zimboinst/extdata
add wave -noupdate -radix unsigned -childformat {{{/zimbotb2/zimboinst/func[2]} -radix unsigned} {{/zimbotb2/zimboinst/func[1]} -radix unsigned} {{/zimbotb2/zimboinst/func[0]} -radix unsigned}} -subitemconfig {{/zimbotb2/zimboinst/func[2]} {-height 15 -radix unsigned} {/zimbotb2/zimboinst/func[1]} {-height 15 -radix unsigned} {/zimbotb2/zimboinst/func[0]} {-height 15 -radix unsigned}} /zimbotb2/zimboinst/func
add wave -noupdate /zimbotb2/zimboinst/pc_en
add wave -noupdate /zimbotb2/zimboinst/memwr_en
add wave -noupdate /zimbotb2/zimboinst/memrd_en
add wave -noupdate /zimbotb2/zimboinst/regwr_en
add wave -noupdate /zimbotb2/zimboinst/mulreg
add wave -noupdate /zimbotb2/zimboinst/cycle
add wave -noupdate /zimbotb2/zimboinst/insdat
add wave -noupdate /zimbotb2/zimboinst/immoff
add wave -noupdate /zimbotb2/zimboinst/mem_alu
add wave -noupdate /zimbotb2/zimboinst/alusrc
add wave -noupdate /zimbotb2/zimboinst/addrbase
add wave -noupdate /zimbotb2/zimboinst/aluopr
add wave -noupdate /zimbotb2/zimboinst/alufunc
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/offset
add wave -noupdate /zimbotb2/zimboinst/pcinst/clock
add wave -noupdate /zimbotb2/zimboinst/pcinst/reset_n
add wave -noupdate /zimbotb2/zimboinst/pcinst/en
add wave -noupdate /zimbotb2/zimboinst/pcinst/branch
add wave -noupdate /zimbotb2/zimboinst/pcinst/jump
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/pcinst/pcin
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/pcinst/pcbranch
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/pcinst/pcjump
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/pcinst/pcout
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/pcinst/pc1
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/pcinst/pc2
add wave -noupdate -radix binary /zimbotb2/zimboinst/controlinst/update
add wave -noupdate /zimbotb2/zimboinst/controlinst/new_opcode
add wave -noupdate /zimbotb2/zimboinst/controlinst/opcode_latch
add wave -noupdate /zimbotb2/zimboinst/aluinst/mulreg
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/mul
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/mul_latch
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/mod_latch
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/mod_temp
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/modSub
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/resultc
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/modHLsubsel
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/notmodzeroH
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/notmodzeroL
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/notmodzero
add wave -noupdate -radix unsigned /zimbotb2/zimboinst/aluinst/modHGTmodL
add wave -noupdate /zimbotb2/zimboinst/aluinst/sign
add wave -noupdate /zimbotb2/zimboinst/aluinst/zero
add wave -noupdate /zimbotb2/zimboinst/controlinst/sign_flag
add wave -noupdate /zimbotb2/zimboinst/controlinst/zero_flag
add wave -noupdate -radix hexadecimal /zimbotb2/addrm_cpu
add wave -noupdate -radix hexadecimal /zimbotb2/wmdata_cpu
add wave -noupdate -radix hexadecimal /zimbotb2/memwr_en_cpu
add wave -noupdate -radix hexadecimal /zimbotb2/rmdata_cpu
add wave -noupdate -radix hexadecimal /zimbotb2/addrm_tb
add wave -noupdate -radix hexadecimal /zimbotb2/wmdata_tb
add wave -noupdate -radix hexadecimal /zimbotb2/memwr_en_tb
add wave -noupdate -radix hexadecimal /zimbotb2/rmdata_tb
add wave -noupdate -radix hexadecimal /zimbotb2/addrm_mem
add wave -noupdate -radix hexadecimal /zimbotb2/wmdata_mem
add wave -noupdate -radix hexadecimal /zimbotb2/memwr_en_mem
add wave -noupdate -radix hexadecimal /zimbotb2/rmdata_mem
add wave -noupdate -radix hexadecimal /zimbotb2/tbcpu
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22683800 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 148
configure wave -valuecolwidth 143
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {609 ns}
