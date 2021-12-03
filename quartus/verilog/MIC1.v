module MIC1(
	clock,
	reset,
	ROM_data,
	RAM_data,
	C,
	MIR,
	MAR,
	MDR,
	PC,
	A,
	B,
	SP_ao, 
	TOS_ao, 
	OPC_ao, 
	CPP_ao, 
	LV_ao,
	MBR_ao
);

	input clock, reset;
	input [31:0] ROM_data, RAM_data, C;
	input [15:0] MIR;
	output [31:0] A, B, PC, MAR;
	output [31:0] MDR;
	output [31:0] SP_ao, TOS_ao, OPC_ao, CPP_ao, LV_ao, MBR_ao;

	reg [31:0] MDR_in;

	wire H_en, OPC_en, TOS_en, CPP_en, LV_en, SP_en, PC_en, MDR_en, MAR_en;	
	assign H_en = MIR[15];
	assign OPC_en = MIR[14];
	assign TOS_en = MIR[13];
	assign CPP_en = MIR[12];
	assign LV_en = MIR[11];
	assign SP_en = MIR[10];
	assign PC_en = MIR[9];
	assign MDR_en = MIR[8] || MIR[5];
	assign MAR_en = MIR[7];

	reg H_out_en, OPC_out_en, TOS_out_en, CPP_out_en, LV_out_en, SP_out_en, 
		PC_out_en, MDR_out_en, MAR_out_en, MBR_out_en, MBRU_out_en;

	register H_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(C),
		.inEnable(H_en),
		.outEnable(H_out_en),
		.dataOut(B),
		.alwaysOnDataOut(A)
	);

	register OPC_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(C),
		.inEnable(OPC_en),
		.outEnable(OPC_out_en),
		.dataOut(B),
		.alwaysOnDataOut(OPC_ao)
	);

	register TOS_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(C),
		.inEnable(TOS_en),
		.outEnable(TOS_out_en),
		.dataOut(B),
		.alwaysOnDataOut(TOS_ao)
	);

	register CPP_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(C),
		.inEnable(CPP_en),
		.outEnable(CPP_out_en),
		.dataOut(B),
		.alwaysOnDataOut(CPP_ao)
	);

	register LV_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(C),
		.inEnable(LV_en),
		.outEnable(LV_out_en),
		.dataOut(B),
		.alwaysOnDataOut(LV_ao)
	);

	register SP_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(C),
		.inEnable(SP_en),
		.outEnable(SP_out_en),
		.dataOut(B),
		.alwaysOnDataOut(SP_ao)
	);
	defparam SP_REG.resetData = 32'hffffffff;

	register PC_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(C),
		.inEnable(PC_en),
		.outEnable(PC_out_en),
		.dataOut(B),
		.alwaysOnDataOut(PC)
	);

	register MDR_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(MDR_in),
		.inEnable(MDR_en),
		.outEnable(MDR_out_en),
		.dataOut(B),
		.alwaysOnDataOut(MDR)
	);

	register MAR_REG(
		.clock(clock),
		.reset(reset),
		.dataIn(C),
		.inEnable(MAR_en),
		.outEnable(MAR_out_en),
		.dataOut(B),
		.alwaysOnDataOut(MAR)
	);

	register MBR_REG(
		.clock(clock),
		.reset(reset),
		.dataIn({{24{1'b0}},ROM_data}),
		.inEnable(MIR[4]),
		.outEnable(MBR_out_en),
		.dataOut(B),
		.alwaysOnDataOut(MBR_ao)
	);


	always @ (MIR[3:0], C, RAM_data)
	begin
		if (MIR[8])
		begin
			MDR_in = C;
		end
		else
		begin
			MDR_in = RAM_data;
		end

		H_out_en = 1'b0;
		OPC_out_en = 1'b0;
		TOS_out_en = 1'b0;
		CPP_out_en = 1'b0;
		LV_out_en = 1'b0;
		SP_out_en = 1'b0;
		PC_out_en = 1'b0;
		MDR_out_en = 1'b0;
		MAR_out_en = 1'b0;
		MBR_out_en = 1'b0;
		MBRU_out_en = 1'b0;
		
		case ( MIR[3:0] )
			4'b0000: 
			begin
				MDR_out_en = 1'b1;
			end
			4'b0001:
			begin
				PC_out_en = 1'b1;
			end
			4'b0010:
			begin
				MBR_out_en = 1'b1;
			end
			4'b0011:
			begin
				MBRU_out_en = 1'b1;
			end
			4'b0100:
			begin
				SP_out_en = 1'b1;
			end
			4'b0101:
			begin
				LV_out_en = 1'b1;
			end
			4'b0110:
			begin
				CPP_out_en = 1'b1;
			end
			4'b0111:
			begin
				TOS_out_en = 1'b1;
			end
			4'b1000:
			begin
				OPC_out_en = 1'b1;
			end
		endcase
	end

endmodule