onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /zimbotb/zimboinst/clock
add wave -noupdate /zimbotb/zimboinst/reset_n
add wave -noupdate -radix unsigned /zimbotb/zimboinst/pcin
add wave -noupdate -radix binary /zimbotb/zimboinst/rmdata
add wave -noupdate -radix unsigned /zimbotb/zimboinst/pcout
add wave -noupdate -radix unsigned /zimbotb/zimboinst/addrm
add wave -noupdate -radix binary /zimbotb/zimboinst/wmdata
add wave -noupdate -radix unsigned /zimbotb/zimboinst/wrfdata
add wave -noupdate -radix unsigned /zimbotb/zimboinst/rdata1
add wave -noupdate -radix unsigned /zimbotb/zimboinst/rdata2
add wave -noupdate -radix unsigned /zimbotb/zimboinst/result
add wave -noupdate -radix unsigned /zimbotb/zimboinst/var1
add wave -noupdate -radix unsigned /zimbotb/zimboinst/var2
add wave -noupdate /zimbotb/zimboinst/memoryinst/rlatch
add wave -noupdate -radix unsigned /zimbotb/zimboinst/addr1
add wave -noupdate -radix unsigned /zimbotb/zimboinst/regfileinst/addr1
add wave -noupdate -radix unsigned /zimbotb/zimboinst/addr2
add wave -noupdate -radix unsigned /zimbotb/zimboinst/regfileinst/addr2
add wave -noupdate /zimbotb/zimboinst/opcode
add wave -noupdate /zimbotb/zimboinst/extdata
add wave -noupdate -radix unsigned -childformat {{{/zimbotb/zimboinst/func[2]} -radix unsigned} {{/zimbotb/zimboinst/func[1]} -radix unsigned} {{/zimbotb/zimboinst/func[0]} -radix unsigned}} -subitemconfig {{/zimbotb/zimboinst/func[2]} {-height 15 -radix unsigned} {/zimbotb/zimboinst/func[1]} {-height 15 -radix unsigned} {/zimbotb/zimboinst/func[0]} {-height 15 -radix unsigned}} /zimbotb/zimboinst/func
add wave -noupdate /zimbotb/zimboinst/pc_en
add wave -noupdate /zimbotb/zimboinst/memwr_en
add wave -noupdate /zimbotb/zimboinst/memrd_en
add wave -noupdate /zimbotb/zimboinst/regwr_en
add wave -noupdate /zimbotb/zimboinst/mulreg
add wave -noupdate /zimbotb/zimboinst/cycle
add wave -noupdate /zimbotb/zimboinst/insdat
add wave -noupdate /zimbotb/zimboinst/immoff
add wave -noupdate /zimbotb/zimboinst/mem_alu
add wave -noupdate /zimbotb/zimboinst/alusrc
add wave -noupdate /zimbotb/zimboinst/addrbase
add wave -noupdate /zimbotb/zimboinst/aluopr
add wave -noupdate /zimbotb/zimboinst/alufunc
add wave -noupdate -radix unsigned /zimbotb/zimboinst/offset
add wave -noupdate /zimbotb/zimboinst/pcinst/clock
add wave -noupdate /zimbotb/zimboinst/pcinst/reset_n
add wave -noupdate /zimbotb/zimboinst/pcinst/en
add wave -noupdate /zimbotb/zimboinst/pcinst/branch
add wave -noupdate /zimbotb/zimboinst/pcinst/jump
add wave -noupdate -radix unsigned /zimbotb/zimboinst/pcinst/pcin
add wave -noupdate -radix unsigned /zimbotb/zimboinst/pcinst/pcbranch
add wave -noupdate -radix unsigned /zimbotb/zimboinst/pcinst/pcjump
add wave -noupdate -radix unsigned /zimbotb/zimboinst/pcinst/pcout
add wave -noupdate -radix unsigned /zimbotb/zimboinst/pcinst/pc1
add wave -noupdate -radix unsigned /zimbotb/zimboinst/pcinst/pc2
add wave -noupdate -radix binary /zimbotb/zimboinst/controlinst/update
add wave -noupdate /zimbotb/zimboinst/controlinst/new_opcode
add wave -noupdate /zimbotb/zimboinst/controlinst/opcode_latch
add wave -noupdate /zimbotb/zimboinst/aluinst/mulreg
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/mul
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/mul_latch
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/mod_latch
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/mod_temp
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/modSub
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/resultc
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/modHLsubsel
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/notmodzeroH
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/notmodzeroL
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/notmodzero
add wave -noupdate -radix unsigned /zimbotb/zimboinst/aluinst/modHGTmodL
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17900 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 148
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
configure wave -timelineunits ps
update
WaveRestoreZoom {17900 ps} {146700 ps}
