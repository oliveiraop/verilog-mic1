module shifter(
	control,
	data,
	dataOut
);

	input [1:0] control;
	input [31:0] data;
	output reg [31:0] dataOut;

	always @ (control, data)
	begin
		case (control)
			2'b01: dataOut = {data[31], data[30:0] >> 1};
			2'b10: dataOut = data << 8;
			default: dataOut = data;
		endcase

	end


endmodule