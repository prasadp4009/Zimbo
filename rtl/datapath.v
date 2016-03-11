module datapath(
	input		clock,
	input	[15:0]	pcout,
	input	[15:0]	extdata,
	input	[15:0]	rmdata,	
//	input	[15:0]	rwdata,	
	input	[15:0]	result,
	input	[15:0]	rdata1,
	input	[15:0]	rdata2,

	input		mem_alu,
	input	[1:0]	addrbase,
	input		mulreg,
	input		insdat,
	input		alusrc,

	output		rdestBit0,
	output	[15:0]	pcin,
	output	[15:0]	pcjump,
	output	[15:0]	pcbranch,
	output	[15:0]	wrfdata,
	output	[15:0]	wmdata,
	output reg[3:0]	addr1,
	output	[3:0]	addr2,
	output	[15:0]	addrm,
	output	[15:0]	var1,
	output	[15:0]	var2,
	output	[4:0]	opcode,
	output	[2:0]	func,
	output	[6:0]	offset
);

localparam	R0 = 4'd0;

wire [15:0]	rmdata_out;
reg  [15:0]	rlatch;

assign	rmdata_out = mem_alu ? rlatch : rmdata;

assign pcin 	= pcout + 16'd2;
assign pcjump 	= {pcout[15:14],{rmdata_out[12:0],1'b0}};
assign pcbranch = pcout + extdata;
assign wrfdata	= mem_alu ? rmdata : result;
//assign addr1	= addrbase ? rmdata[6:3] : R0;
assign addr2	= {rmdata_out[10:8],mulreg};
assign addrm	= insdat ? result : pcout;
assign wmdata	= rdata2;
assign var1	= rdata1;
assign var2	= alusrc ? rdata2 : extdata;
assign opcode	= rmdata_out[15:11];
assign func	= rmdata_out[2:0];
assign offset	= rmdata_out[6:0];
assign rdestBit0= rmdata_out[7];

always@(posedge clock)
begin
	rlatch <= rmdata;
end

always@(*)
	case(addrbase)
		2'd0: addr1 = R0;
		2'd1: addr1 = rmdata_out[6:3];
		2'd2: addr1 = addr2;
		2'd3: addr1 = rmdata_out[6:3];
	endcase

endmodule


	

