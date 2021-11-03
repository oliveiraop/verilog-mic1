module shifter(
	control,
	data,
	dataOut
);

	parameter STEPS_AT_RIGHT = 1;
	parameter STEPS_AT_LEFT = 8;

	input [1:0] control;
	input [31:0] data;
	output reg [31:0] dataOut;

	always @ (control, data)
	begin
		case (control)
			2'b01: dataOut = {data[31], data[30:0] >> STEPS_AT_RIGHT};
			2'b10: dataOut = data << STEPS_AT_LEFT;
			default: dataOut = data;
		endcase

	end


endmodule