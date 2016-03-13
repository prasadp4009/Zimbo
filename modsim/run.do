vlib work
vmap work work
vlog -work work  +incdir+../rtl ../rtl/*.v ../tb/*.v
vsim -novopt work.zimbotb2 -l zimbotb.log
do wave2.do
run -all

