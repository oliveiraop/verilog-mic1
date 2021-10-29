module MIC1(
	clock,
	ROM_data,
	RAM_data,
	C,
	MIR,
	MAR,
	MDR,
	PC,
	MBR,
	A,
	B
);

input clock;
input [31:0] ROM_data, RAM_data, C, MAR;
input [15:0] MIR;
output [31:0] A, B, PC;
reg [31:0]MDR_in;
output [31:0] MDR, MBR;

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

reg H_out_en, OPC_out_en, TOS_out_en, CPP_out_en, LV_out_en, SP_out_en, PC_out_en, MDR_out_en, MAR_out_en, MBR_out_en, MBRU_out_en;

wire [31:0]MBR_out;

assign MBR = MBRU_out_en ? {{24{MBR_out[7]}}, MBR_out[7:0]} : MBR_out_en ? {{24{1'b0}}, MBR_out[7:0]} : 32'bZ;

register H_REG(
	.clock(clock),
	.dataIn(C),
	.inEnable(H_en),
	.outEnable(H_out_en),
	.dataOut(B),
	.alwaysOnDataOut(A)
);

register OPC_REG(
	.clock(clock),
	.dataIn(C),
	.inEnable(OPC_en),
	.outEnable(OPC_out_en),
	.dataOut(B)
);

register TOS_REG(
	.clock(clock),
	.dataIn(C),
	.inEnable(TOS_en),
	.outEnable(TOS_out_en),
	.dataOut(B)
);

register CPP_REG(
	.clock(clock),
	.dataIn(C),
	.inEnable(CPP_en),
	.outEnable(CPP_out_en),
	.dataOut(B)
);

register LV_REG(
	.clock(clock),
	.dataIn(C),
	.inEnable(LV_en),
	.outEnable(LV_out_en),
	.dataOut(B)
);

register SP_REG(
	.clock(clock),
	.dataIn(C),
	.inEnable(SP_en),
	.outEnable(SP_out_en),
	.dataOut(B)
);

register PC_REG(
	.clock(clock),
	.dataIn(C),
	.inEnable(PC_en),
	.outEnable(PC_out_en),
	.dataOut(B),
	.alwaysOnDataOut(PC)
);

register MDR_REG(
	.clock(clock),
	.dataIn(MDR_in),
	.inEnable(MDR_en),
	.outEnable(MDR_out_en),
	.dataOut(B),
	.alwaysOnDataOut(MDR)
);

register MAR_REG(
	.clock(clock),
	.dataIn(C),
	.inEnable(MAR_en),
	.outEnable(MAR_out_en),
	.dataOut(B),
	.alwaysOnDataOut(MAR)
);

register MBR_REG(
	.clock(clock),
	.dataIn(ROM_data),
	.inEnable(MIR[4]),
	.outEnable(MBR_out_en),
	.dataOut(MBR_out),
	.alwaysOnDataOut(MBR)
);

always @ (posedge clock)
begin

end

always @ (MIR[3:0], A, RAM_data)
begin
	if (MIR[5])
	begin
		MDR_in = RAM_data;
	end
	else
	begin
		MDR_in = A;
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