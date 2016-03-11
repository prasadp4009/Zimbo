module control(
	input		clock,
	input		reset_n,
	input	[4:0]	opcode,
	input	[2:0]	func,

	input		rdestBit0,	//For multiplication reg selection
	input		sign_f,
	input		zero_f,

	input		step_exe,

	output		pc_en,
	output		memwr_en,
	output		memrd_en,
	output		regwr_en,
	output		mulreg,
	output	reg	cycle,
	
	output		insdat,
	output		immoff,
	output		jump,
	output		branch,
	output		mem_alu,
	output		alusrc,
	output	[1:0]	addrbase,

	output	[2:0]	aluopr,
	output	[2:0]	alufunc
);

localparam	PAS1	= 3'b001,
		PAS2	= 3'b011,
		FUN1	= 3'b000,
		FUN2	= 3'b001,
		AOFF	= 3'b000,
		AIMM	= 3'b000,
		SIMM	= 3'b010;

localparam	NOP	= 5'b00000,
		HLT	= 5'b11111,
		STA	= 5'b00001,
		LDA	= 5'b00010,	//Load at Address directly
		LDD	= 5'b00011,
		LDR	= 5'b00100,
		LDM	= 5'b00101,
		LDI	= 5'b00110,

		STR	= 5'b00111,
		
		ADD	= 5'b01000,
		ADI	= 5'b01001,
		SUB	= 5'b01010,
		SUI	= 5'b01011,
		MUL	= 5'b01100,
		AND	= 5'b01101,
		ORR	= 5'b01110,
		XOR	= 5'b01111,

		BZR	= 5'b10000,
		BEQ	= 5'b10001,
		BPV	= 5'b10010,
		BNG	= 5'b10011,

		JMP	= 5'b110xx;

localparam	EPC	= 1'b1,	//Enable PC increment
		DPC	= 1'b0,	//Disable PC increment

		MWR	= 1'b1, //Memory Write Enable
		MRD	= 1'b0,	//Memory Read Enable

		IMM	= 1'b1, //Immidiate operand
		OFF	= 1'b0, //Offset operand

		R21	= 2'd2, //bypass RF2 address to R1
		RGA	= 2'd1, //Allow all registers for Reg1 port
		RG0	= 2'd0, //Only register 0 for Base address 

		PSM	= 1'b1, //Pass Memory
		PSA	= 1'b0, //Pass ALU

		TJP	= 1'b1, //Take Jump
		NJP	= 1'b0, //No Jump

		TBR	= 1'b1, //Take Branch
		NBR	= 1'b0, //No branch

		SRG	= 1'b1, //ALU source is Reg2
		SIM	= 1'b0, //ALU source is Immidiate

		WRF	= 1'b1, //Write register file
		RRF	= 1'b0, //Read register file

		CY1	= 1'b0,	//Number of Cycles is 1
		CY2	= 1'b1, //Number of Cycles is 2
		
		INS	= 1'b0,
		DAT	= 1'b1;

//reg cycle;

reg sign_flag;
reg zero_flag;

wire	rdwr;
wire	pc_stat;
wire	mulstat;

wire	num_of_cycles;

wire [2:0] OPR;
wire	   FUN;

wire [4:0] new_opcode;
reg  [4:0] opcode_latch;

reg [17:0] update;

assign memrd_en = ~memwr_en;
assign OPR = opcode[2:0];
assign FUN = func[0];
assign new_opcode = cycle ? opcode_latch : opcode;
assign mulreg = (new_opcode == MUL) & (~FUN) ? (cycle ? (~rdestBit0) : rdestBit0) : rdestBit0; 
assign {pc_en,insdat,memwr_en,regwr_en,immoff,jump,branch,mem_alu,alusrc,addrbase,num_of_cycles,aluopr,alufunc} = update;

always@(posedge clock or negedge reset_n)
begin
	if(~reset_n)
	begin
		sign_flag	<= 1'd0;
		zero_flag	<= 1'd0;
		cycle		<= 1'd0;
		opcode_latch	<= 5'd0;
	end
	else
	begin
		opcode_latch	<= opcode;
		sign_flag	<= sign_f;
		zero_flag	<= zero_f;
		if(num_of_cycles == CY2)
			cycle <= ~cycle;
		else
			cycle <= CY1;
	end
end

always@(*)
begin
	casex(new_opcode)
		NOP: update = {EPC,INS,MRD,RRF,IMM,NJP,NBR,PSA,SIM,RGA,CY1,PAS1,FUN1};
		HLT: update = {DPC,INS,MRD,RRF,IMM,NJP,NBR,PSA,SIM,RGA,CY1,PAS1,FUN1};
		LDA: case(cycle)
			CY1: update = {DPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SIM,RGA,CY2,PAS1,FUN1};
			CY2: update = {EPC,DAT,MRD,WRF,OFF,NJP,NBR,PSM,SIM,RGA,CY1,PAS1,FUN1};
		     endcase
		LDD: case(cycle)
			CY1: update = {EPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SIM,RGA,CY2,AOFF,FUN1};
			CY2: update = {EPC,INS,MRD,WRF,OFF,NJP,NBR,PSM,SIM,RGA,CY1,AOFF,FUN1};
		     endcase
		LDR: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SIM,RGA,CY1,PAS1,FUN1};
		    /*case(cycle)
			CY1: update = {DPC,INS,MRD,RRF,IMM,NJP,NBR,PSA,SIM,RGA,CY2,PAS1,FUN1};
			CY2: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SIM,RGA,CY2,PAS1,FUN1};
		     endcase*/
		LDM: case(cycle)
			CY1: update = {DPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SIM,RG0,CY2,AOFF,FUN1};
			CY2: update = {EPC,DAT,MRD,WRF,OFF,NJP,NBR,PSM,SIM,RG0,CY1,AOFF,FUN1};
		     endcase
		LDI: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SIM,RGA,CY1,PAS2,FUN1};
		STA: case(cycle)
			CY1: update = {DPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SIM,RGA,CY2,PAS1,FUN1};
			CY2: update = {EPC,DAT,MWR,RRF,OFF,NJP,NBR,PSM,SIM,RGA,CY1,PAS1,FUN1};
		     endcase
		STR: case(cycle)
			CY1: update = {DPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SIM,RG0,CY2,AOFF,FUN1};
			CY2: update = {EPC,DAT,MWR,RRF,OFF,NJP,NBR,PSM,SIM,RG0,CY1,AOFF,FUN1};
		     endcase
		ADD: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN1};
		ADI: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SIM,R21,CY1,AIMM,FUN1};
		SUB: case(FUN)
			1'b0	: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN1};
			1'b1	: update = {EPC,INS,MRD,RRF,IMM,NJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN1};
		     endcase
		SUI: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SIM,R21,CY1,SIMM,FUN1};
		MUL: case(FUN)
			1'b0	: case(cycle)
					CY1: update = {DPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SRG,RGA,CY2,OPR,FUN1};
					CY2: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN1};
				  endcase
			1'b1	: case(cycle)
					CY1: update = {DPC,INS,MRD,RRF,IMM,NJP,NBR,PSA,SRG,RGA,CY2,OPR,FUN2};		//MOD
					CY2: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN2};
				  endcase
		     endcase
		AND: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN1};
		ORR: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN1};
		XOR: update = {EPC,INS,MRD,WRF,IMM,NJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN1};

		BZR: case(zero_flag)
			1'b1: update = {EPC,INS,MRD,RRF,OFF,NJP,TBR,PSA,SRG,RG0,CY1,OPR,FUN1};
			1'b0: update = {EPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SRG,RG0,CY1,OPR,FUN1};
		     endcase
		BEQ: case(zero_flag)
			1'b1: update = {EPC,INS,MRD,RRF,OFF,NJP,TBR,PSA,SRG,RG0,CY1,OPR,FUN1};
			1'b0: update = {EPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SRG,RG0,CY1,OPR,FUN1};
		     endcase
		BPV: case(sign_flag)
			1'b1: update = {EPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SRG,RG0,CY1,OPR,FUN1};
			1'b0: update = {EPC,INS,MRD,RRF,OFF,NJP,TBR,PSA,SRG,RG0,CY1,OPR,FUN1};
		     endcase
		BNG: case(sign_flag)
			1'b1: update = {EPC,INS,MRD,RRF,OFF,NJP,TBR,PSA,SRG,RG0,CY1,OPR,FUN1};
			1'b0: update = {EPC,INS,MRD,RRF,OFF,NJP,NBR,PSA,SRG,RG0,CY1,OPR,FUN1};
		     endcase
		
		JMP: update = {EPC,INS,MRD,RRF,IMM,TJP,NBR,PSA,SRG,RGA,CY1,OPR,FUN1};
		
		default: update = {DPC,INS,MRD,RRF,IMM,NJP,NBR,PSA,SIM,RGA,CY1,PAS1,FUN1};
	endcase
end

endmodule




