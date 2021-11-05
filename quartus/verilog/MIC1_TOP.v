module MIC1_TOP(
	clock,
	reset
);

	input reset;
	input clock;
	wire N, Z;
	wire [35:0] MIR;
	wire [31:0] MBR, q_rom, q_ram, A, B, C, MAR, MDR, PC, out;
	wire [8:0] MPC;

	MIC1 datapath(
		.clock(clock),
		.ROM_data(q_rom),
		.RAM_data(q_ram),
		.C(C),
		.MIR(MIR[15:0]),
		.MAR(MAR),
		.MDR(MDR),
		.PC(PC),
		.MBR(MBR),
		.A(A),
		.B(B)
	);

	ULA ula(
		.A(A),
		.B(B),
		.select(MIR[21:16]),
		.out(out),
		.N(N),
		.Z(Z)
	);

	shifter SHIFTER(
		.control(MIR[23:22]),
		.data(out),
		.dataOut(C)
	);

	controlpath CONTROL(
		.clk(clock),
		.rst(reset),
		.N(N),
		.Z(Z),
		.MBR(MBR[7:0]),
		.MIR(MIR[35:24]),
		.MPC(MPC)
	);

	ROM control_store(
		.a(MPC),
		.clock(!clock),
		.out(MIR)
	);

	rom_program_mem	rom_program_mem_inst (
		.address(PC),
		.clock(clock),
		.q(MBR_in)
	);
	
	
	ram_data_mem ram_data_mem_inst (
		.address({2'b00, MAR[31:2]} ),
		.clock(clock),
		.q(MDR_in),
		.data(MDR_out),
		.wren(MIR[6])
	);


endmodule