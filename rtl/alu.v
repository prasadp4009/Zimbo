module alu(
	input		clock,

	input	[2:0]	opr,
	input	[2:0]	func,
	input		mulreg,
	input		cycle,

	input	[15:0]	var1,
	input	[15:0]	var2,

	output	[15:0]	result,

	output		sign,
	output		zero
);

localparam	ADD = 3'b000,
		PAS1= 3'b001,
		SUB = 3'b010,
		PAS2= 3'b011,
		MLT = 3'b100,
		AND = 3'b101,
		OR  = 3'b110,
		XOR = 3'b111;

wire[31:0] mul;	
reg [31:0] mul_latch;
reg [15:0] mod_latch;
wire[15:0] mod_temp;
wire[15:0] modSub;
reg [16:0] resultc;
wire[15:0] modHLsubsel;

wire notmodzeroH;
wire notmodzeroL;
wire notmodzero;
wire modHGTmodL;

assign mul = var1 * var2;

assign result = resultc[15:0];
assign sign = resultc[16];
assign zero = ~|resultc[15:0];
assign mod_temp = notmodzero ? modSub : (16'hFFFF - modHLsubsel);
assign notmodzeroH = |var1;
assign notmodzeroL = |var2;
assign notmodzero  = notmodzeroH & notmodzeroL; 
assign modHGTmodL  = mul[31:16] > mul[15:0];
assign modSub      = mul[15:0] - mul[31:16];
assign modHLsubsel = notmodzeroL ? var2 : var1;

always@(*)
begin
	case(opr)
		ADD	: resultc = {1'b0, var1} + {1'b0, var2};
		PAS1	: resultc[15:0] = var1;
		SUB	: resultc = {1'b0, var1} - {1'b0, var2};
		PAS2	: resultc[15:0] = var2;
		MLT	: case(func[0])
				1'b0	:	case(cycle)
							1'b0: resultc[15:0] = mulreg ? mul[31:16] : mul[15:0];
							1'b1: resultc[15:0] = mulreg ? mul_latch[31:16] : mul_latch[15:0];
						endcase
				1'b1	:	resultc[15:0] = notmodzero ? (modHGTmodL ? mod_latch : modSub) 
									   : (mod_latch + 16'd1);
				default	:	resultc = 17'd0;
			  endcase
		AND	: resultc[15:0] = var1 & var2;
		OR	: resultc[15:0] = var1 | var2;
		XOR	: resultc[15:0] = var1 ^ var2;
		default	: resultc	= 17'd0;
	endcase
end

always@(posedge clock)
begin
	mul_latch <= mul;
	mod_latch <= mod_temp + 16'd1;
end

endmodule
