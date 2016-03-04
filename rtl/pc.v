module pc(
	input			clock,
	input			reset_n,
	input			en,
	input			branch,
	input			jump,

	input	[15:0]		pcin,
	input	[15:0]		pcbranch,
	input	[15:0]		pcjump,
	
	output	reg [15:0]	pcout
);

wire [15:0]	pc1;
wire [15:0]	pc2;

assign	pc1 = branch ? pcbranch : pcin;
assign	pc2 = jump ? pcjump : pc1;

always@(posedge clock or negedge reset_n)
begin
	if(~reset_n)
	begin
		pcout <= 16'd0;
	end
	else
	begin
		if(en)
			pcout <= pc2;
		else
			pcout <= pcout;
	end
end
endmodule

