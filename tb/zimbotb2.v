`timescale 1ns/100ps

module zimbotb2;

parameter result_loc = 16'd460;

reg clock;
reg reset_n;

wire	[15:0]	addrm_cpu;
wire	[15:0]	wmdata_cpu;

wire		memwr_en_cpu;
wire	[15:0]	rmdata_cpu;

reg	[15:0]	addrm_tb;
reg	[15:0]	wmdata_tb;

reg		memwr_en_tb;
wire	[15:0]	rmdata_tb;

wire	[15:0]	addrm_mem;
wire	[15:0]	wmdata_mem;

wire		memwr_en_mem;
wire	[15:0]	rmdata_mem;

integer count;
reg tbcpu;
reg [15:0] i;
integer f;

assign rmdata_cpu = tbcpu ? 16'd0 : rmdata_mem;
assign rmdata_tb = rmdata_mem;

assign addrm_mem = tbcpu ? addrm_tb : addrm_cpu;
assign wmdata_mem = tbcpu ? wmdata_tb : wmdata_cpu;
assign memwr_en_mem = tbcpu ? memwr_en_tb : memwr_en_cpu;

zimbotop zimboinst(
	.clock(clock),
	.reset_n(reset_n),
	.addrm(addrm_cpu),
	.wmdata(wmdata_cpu),
	.memwr_en(memwr_en_cpu),
	.rmdata(rmdata_cpu)
);

memory meminit(
	.clock(clock),
	.addrm(addrm_mem),

	.wmdata(wmdata_mem),
	.we(memwr_en_mem),

	.rmdata(rmdata_mem)

);
initial
begin
	clock = 0;
	forever
	#10 clock = ~clock;
end

initial
begin
	$display("Starting Simulation..!!");
	reset_n = 0;
	count = 0;
	tbcpu = 0;
	memwr_en_tb = 0;
	wmdata_tb   = 16'd0;
	addrm_tb    = 16'd0;
	i = 16'd0;
	
	repeat(2)
	@(negedge clock);

	reset_n = 1;

	while (zimboinst.opcode != 5'b11111)
	begin
		count = count + 1;
		@(negedge clock);
	end
		
        
	@(negedge clock);
	tbcpu = 1;
	f = $fopen("result.txt","w");
	$fwrite(f,"*******************************************************\n");
	$fwrite(f,"* Total Clock Cycles for Execution: %-5d\n",count);
	$fwrite(f,"*******************************************************\n");
	$fwrite(f,"\n Encrypted Data:\n");
	for (i = 0; i<16'd128; i=i+16'd2)
	begin
		if(~i[1])
		begin
			addrm_tb = result_loc + i;
			@(negedge clock);
        		$fwrite(f," %3d: %h",i/4,rmdata_tb);
		end
		else
		begin
			addrm_tb = result_loc + i;
			@(negedge clock);
        		$fwrite(f,"%h\n",rmdata_tb);
		end
	end

	$fclose(f);	

	$display("\n\n********************************************************************");
	$display("* Total number of clocks: %d",count);
	$display("* Encrypted data written in file result.txt");
	$display("********************************************************************\n\n");
	#100 $stop;
end

endmodule
