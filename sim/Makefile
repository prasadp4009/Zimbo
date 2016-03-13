# Makefile for calc1

RTL= ../rtl/*.v
INC = +incdir+../rtl
work= work #library name

TB= ../tb/zimbotb.v

VSIMOPT= -novopt work.zimbotb

VSIMBATCH= -c -do "run -all; exit"

VSIMGUI= -do "do wave.do;run -all"

cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(INC) $(RTL) $(TB)

run_sim:
	vsim $(VSIMBATCH) $(VSIMOPT) -l zimbotest.log

run_gui:
	vsim $(VSIMGUI) $(VSIMOPT) -l zimbotest.log

run_testg:
	vsim -novopt work.zimbotb
	clear

clean:
	rm -rf modelsim.* transcript* vlog.* work vsim.wlf *.log
	clear

run_test:
	make clean
	make cmp
	make run_sim

run_test_gui:
	make clean
	make cmp
	make run_gui
