module mem_bank0(
	input		clock,
	input	[14:0]	addrm,

	input	[7:0]	wmdata,
	input		we,

	output	[7:0]	rmdata
);

reg [7:0] mem [0:32767];

assign rmdata = mem[addrm];

initial
begin
	$readmemb("../scripts/program_8bin0.dat", mem);
	//$readmemh("../scripts/program_8hex.dat", mem);
end

always@(posedge clock)
begin
	if(we)
	begin
		mem[addrm] <= wmdata;
	end
end

endmodule


