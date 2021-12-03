module register(
	clock,
	reset,
	dataIn,
	inEnable,
	outEnable,
	dataOut,
	alwaysOnDataOut
);
	parameter resetData = 32'b0;
	input clock, reset;
	input [31:0] dataIn;
	input inEnable;
	input outEnable;
	output reg [31:0] dataOut;
	output [31:0] alwaysOnDataOut;

	reg [31:0] data;

	assign alwaysOnDataOut = data;

	always @ (posedge clock)
	begin
		if (reset) data <= resetData;
		else if (inEnable) data <= dataIn;
	end

	always @ (outEnable, data)
	begin
		if (outEnable) dataOut = data;
		else dataOut = 32'bZ;
	end

endmodule