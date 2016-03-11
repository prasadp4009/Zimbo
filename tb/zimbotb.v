`timescale 1ns/100ps
module zimbotb;

reg clock;
reg reset_n;

wire	[15:0]	addrm;
wire	[15:0]	wmdata;

wire		memwr_en;
wire	[15:0]	rmdata;

zimbotop zimboinst(
	.clock(clock),
	.reset_n(reset_n),
	.addrm(addrm),
	.wmdata(wmdata),
	.memwr_en(memwr_en),
	.rmdata(rmdata)
);

mem_top meminit(
	.clock(clock),
	.addrm(addrm),

	.wmdata(wmdata),
	.we(memwr_en),

	.rmdata(rmdata)

);
initial
begin
	clock = 0;
	forever
	#10 clock = ~clock;
end

initial
begin
	$display("Starting Simulation..!!");
	reset_n = 0;

	repeat(2)
	@(negedge clock);

	reset_n = 1;

	while (zimboinst.opcode != 5'b11111)
	@(negedge clock);
	#100 $stop;
end

endmodule
