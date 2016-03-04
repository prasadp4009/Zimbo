module memory(
	input		clock,
	input	[15:0]	addrm,

	input	[15:0]	wmdata,
	input		mem_alu,
	input		re,
	input		we,

	output	[15:0]	rwdata,
	output	[15:0]	rmdata
);

wire [15:0] addr0;
wire [15:0] addr1;

reg [15:0] rlatch;
reg [7:0] mem [0:65536];

assign addr0 = addrm;
assign addr1 = {addrm[15:1],1'b1};

assign	rmdata = mem_alu ? rlatch : {mem[addr1],mem[addr0]};
assign	rwdata = {mem[addr1],mem[addr0]};

initial
begin
	$readmemb("F:/program.txt", mem);
end

always@(posedge clock)
begin
	if(we)
	begin
		mem[addr0] <= wmdata[7:0];
		mem[addr1] <= wmdata[15:8];
	end
end

always@(posedge clock)
begin
	rlatch <= rmdata;
end
endmodule
