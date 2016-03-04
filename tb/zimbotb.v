`timescale 1ns/100ps
module zimbotb;

reg clock;
reg reset_n;

zimbotop zimboinst(
	.clock(clock),
	.reset_n(reset_n)
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

	#1000;
end

endmodule
