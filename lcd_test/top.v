module top(
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
	
	reg [31:0] MDR_in, MAR_in, PC_in, MBR_in, SP_in, CPP_in, LV_in, TOS_in, OPC_in, H_in;
	
	always @ (*)
	begin
		MDR_in = 32'h0ab2c354;
		MAR_in = 32'h54606540;
		PC_in = 32'h40d50b69;
		MBR_in = 32'hf5c21a3f;
		SP_in = 32'h054ca321;
		CPP_in = 32'h25b3cd65;
		LV_in = 32'hbc253d42;
		TOS_in = 32'h05cd3584;
		OPC_in = 32'h5f5f5f5f;
		H_in = 32'hdf215dc5;
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
		.enable(enable),
		.rs(rs),
		.rw(rw),
		.data(data),
		.on(on),
		.MDR_in(MDR_in),
		.MAR_in(MAR_in), 
		.PC_in(PC_in), 
		.MBR_in(MBR_in), 
		.SP_in(SP_in), 
		.CPP_in(CPP_in), 
		.LV_in(LV_in), 
		.TOS_in(TOS_in), 
		.OPC_in(OPC_in), 
		.H_in(H_in)
	);

endmodule