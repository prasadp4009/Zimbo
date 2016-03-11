`timescale 1ns/100ps
module zimbotb;

reg clock;
reg reset_n;

wire	[15:0]	addrm;
wire	[15:0]	wmdata;

wire		memwr_en;
wire	[15:0]	rmdata;

integer	count;

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
	count = 0;

	repeat(2)
	@(negedge clock);

	reset_n = 1;

	while (zimboinst.opcode != 5'b11111)
	begin
		count = count + 1;
		@(negedge clock);
	end

	$display("\n\n***************************************************************\n\n");
	$display("*\tTotal number of clocks for execution of program: %d",count);
	$display("\n\n***************************************************************\n\n");
	#100 $stop;
end

endmodule
