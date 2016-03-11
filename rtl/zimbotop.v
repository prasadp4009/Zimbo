module zimbotop(
	input		clock,
	input		reset_n,

	output	[15:0]	addrm,
	output	[15:0]	wmdata,

	output		memwr_en,
	input	[15:0]	rmdata
);

wire	[15:0]	pcin;
wire	[15:0]	pcout;
wire	[15:0]	pcbranch;
wire	[15:0]	pcjump;
wire	[15:0]	extdata;
//wire	[15:0]	addrm;
//wire	[15:0]	wmdata;
//wire	[15:0]	rmdata;
//wire	[15:0]	rwdata;
wire	[15:0]	wrfdata;
wire	[15:0]	rdata1;
wire	[15:0]	rdata2;
wire	[15:0]	result;
wire	[15:0]	var1;
wire	[15:0]	var2;


wire	[3:0]	addr1;
wire	[3:0]	addr2;

wire	[4:0]	opcode;
wire	[2:0]	func;

wire		rdestBit0;
wire		sign_f;
wire		zero_f;

wire		step_exe;

wire		pc_en;
//wire		memwr_en;
wire		memrd_en;
wire		regwr_en;
wire		mulreg;
wire		cycle;
	
wire		insdat;
wire		immoff;
wire		jump;
wire		branch;
wire		branch_ext;
wire		mem_alu;
wire		alusrc;
wire	[1:0]	addrbase;

wire	[2:0]	aluopr;
wire	[2:0]	alufunc;

wire	[10:0]	offset;

pc	pcinst(
	.clock(clock),
	.reset_n(reset_n),
	.en(pc_en),
	.branch(branch),
	.jump(jump),
	.pcin(pcin),
	.pcbranch(pcbranch),
	.pcjump(pcjump),
	.pcout(pcout)
);

/*
memory memoryinst(
	.clock(clock),
	.addrm(addrm),
	.wmdata(wmdata),
	.mem_alu(mem_alu),
	.re(memrd_en),
	.we(memwr_en),
	.rwdata(rwdata),
	.rmdata(rmdata)
);
*/
regfile regfileinst(
	.clock(clock),
	.addr1(addr1),
	.addr2(addr2),
	.wrfdata(wrfdata),
	.we(regwr_en),
	.rdata1(rdata1),
	.rdata2(rdata2)
);

signext	signextinst(
	.immoff(immoff),
	.branch_ext(branch_ext),
	.offset(offset),
	.extdata(extdata)
);

alu	aluinst(
	.clock(clock),
	.opr(aluopr),
	.func(alufunc),
	.mulreg(mulreg),
	.cycle(cycle),
	.var1(var1),
	.var2(var2),
	.result(result),
	.sign(sign_f),
	.zero(zero_f)
);

control	controlinst(
	.clock(clock),
	.reset_n(reset_n),
	.opcode(opcode),
	.func(func),
	.rdestBit0(rdestBit0),
	.sign_f(sign_f),
	.zero_f(zero_f),

	.step_exe(),

	.pc_en(pc_en),
	.memwr_en(memwr_en),
	.memrd_en(memrd_en),
	.regwr_en(regwr_en),
	.mulreg(mulreg),
	.cycle(cycle),
	.insdat(insdat),
	.immoff(immoff),
	.jump(jump),
	.branch(branch),
	.branch_ext(branch_ext),
	.mem_alu(mem_alu),
	.alusrc(alusrc),
	.addrbase(addrbase),
	.aluopr(aluopr),
	.alufunc(alufunc)
);

datapath dpinst(
		.clock(clock),
		.pcout(pcout),
		.extdata(extdata),
		.rmdata(rmdata),	
//		.rwdata(rwdata),	
		.result(result),
		.rdata1(rdata1),
		.rdata2(rdata2),
		.mem_alu(mem_alu),
		.addrbase(addrbase),
		.mulreg(mulreg),
		.insdat(insdat),
		.alusrc(alusrc),
		.rdestBit0(rdestBit0),
		.pcin(pcin),
		.pcjump(pcjump),
		.pcbranch(pcbranch),
		.wrfdata(wrfdata),
		.wmdata(wmdata),
		.addr1(addr1),
		.addr2(addr2),
		.addrm(addrm),
		.var1(var1),
		.var2(var2),
		.opcode(opcode),
		.func(func),
		.offset(offset)
);

endmodule
