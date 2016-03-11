module signext(
	input		immoff,
	input		branch_ext,
	input	[10:0]	offset,
	output	[15:0]	extdata
);

assign	extdata = branch_ext? {{4{offset[10]}},offset,1'b0} :(immoff ? {{9{1'd0}},offset[6:0]} : {{8{offset[6]}},offset[6:0],1'b0});

endmodule
