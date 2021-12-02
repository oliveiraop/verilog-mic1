module MIC1_TOP(
	clock,
	number,
	control,
	enable,
	rs,
	rw,
	data,
	on
);

	input clock;
	input [4:0] number;
	input control;

	output enable, rs, rw, on;
	output [7:0]data;
	wire N, Z;
	wire [35:0] MIR;
	wire [31:0] MBR, q_rom, q_ram, A, B, C, MAR, MDR, PC, out;
	wire [8:0] MPC;
	reg [7:0] MBR_in;
	reg [31:0] MDR_in;
	always @ (*)
	begin
		MBR_in = 8'hca;
		MDR_in = 32'h00000033;
	end

	virtual_input Input(
		.switch0(switch0),
		.switch1(switch1),
		.switch2(switch2),
		.switch17(switch17),
		.button0(button0),
		.number(number),
		.control(control)
	);

	lcd_d display(
		.SW({switch2, switch1, switch0}), 
		.KEY(switch17),
		.clk(clock),
		.MDR_in(MDR), 
		.MAR_in(MAR), 
		.PC_in(PC), 
		.MBR_in(MBR), 
		.SP_in(SP_ao), 
		.TOS_in(TOS_ao), 
		.OPC_in(OPC_ao), 
		.CPP_in(CPP_ao), 
		.LV_in(LV_ao),
		.H_in(A),
		.enable(enable),
		.rs(rs),
		.rw(rw),
		.data(data),
		.on(on)
	);

	MIC1 datapath(
		.clock(button0),
		.ROM_data(q_rom),
		.RAM_data(q_ram),
		.C(C),
		.MIR(MIR[15:0]),
		.MAR(MAR),
		.MDR(MDR),
		.PC(PC),
		.MBR(MBR),
		.A(A),
		.B(B),
		.SP_ao(SP_ao), 
		.TOS_ao(TOS_ao), 
		.OPC_ao(OPC_ao), 
		.CPP_ao(CPP_ao), 
		.LV_ao(LV_ao)
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
		.clk(button0),
		.rst(reset),
		.N(N),
		.Z(Z),
		.MBR(MBR[7:0]),
		.MIR(MIR[35:24]),
		.MPC(MPC)
	);

	ROM control_store(
		.a(MPC),
		.clock(!button0),
		.out(MIR)
	);

	

	/*rom_program_mem	rom_program_mem_inst (
		.address(PC),
		.clock(button0),
		.q(MBR_in)
	);
	
	
	ram_data_mem ram_data_mem_inst (
		.address({2'b00, MAR[31:2]} ),
		.clock(button0),
		.q(MDR_in),
		.data(MDR_out),
		.wren(MIR[6])
	);*/


endmodule