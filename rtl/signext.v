module signext(
	input		immoff,
	input	[6:0]	offset,
	output	[15:0]	extdata
);

assign	extdata = immoff ? {{9{1'd0}},offset} : {{8{offset[6]}},offset,1'b0};

endmodule
