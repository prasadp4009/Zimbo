module mem_top(
	input		clock,
	input	[15:0]	addrm,

	input	[15:0]	wmdata,
	input		we,

	output	[15:0]	rmdata
);

mem_bank0 mb0(
	.clock(clock),
	.addrm(addrm[15:1]),
	.wmdata(wmdata[7:0]),
	.we(we),
	.rmdata(rmdata[7:0])
);

mem_bank1 mb1(
	.clock(clock),
	.addrm(addrm[15:1]),
	.wmdata(wmdata[15:8]),
	.we(we),
	.rmdata(rmdata[15:8])
);

endmodule
