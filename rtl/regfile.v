module regfile(
	input		clock,
	input	[3:0]	addr1,
	input	[3:0]	addr2,
	input	[15:0]	wrfdata,

	input		we,

	output	[15:0]	rdata1,
	output	[15:0]	rdata2
);

reg [15:0] regs	[0:15];

assign rdata1 = regs[addr1];
assign rdata2 = regs[addr2];

always@(posedge clock)
begin
	if(we)
		regs[addr2] <= wrfdata;
end
/*
always@(*)
begin
	rdata1 <= regs[addr1];
	rdata2 <= regs[addr2];
end
*/
endmodule

