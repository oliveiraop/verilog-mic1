module ULA(
	A,
	B,
	select,
	out,
	N,
	Z
);

	input [31:0] A, B;
	input [5:0] select;
	output reg [31:0] out;
	output N, Z;

	assign N = out[31];
	assign Z = !(out);

	always @ (select, A, B)
	begin
		case (select)
			//| A
			6'b011000: out = A;
			//| B
			6'b010100: out = B;
			//| ~A
			6'b011010: out = ~A;
			//| ~B
			6'b101100: out = ~B;
			//| A + B
			6'b111100: out = A + B;
			//| A + B + 1
			6'b111101: out = A + B + 1;
			//| A + 1
			6'b111001: out = A + 1;
			//| B + 1
			6'b110101: out = B + 1;
			//| B - A
			6'b111111: out = B - A;
			//| B - 1
			6'b110110: out = B - 1;
			//| -A
			6'b111011: out = ~A + 31'd1;
			//|	A AND B
			6'b001100: out = A & B;
			//| A OR B
			6'b011100: out = A | B;
			//| 0
			6'b010000: out = 32'd0;
			//| 1
			6'b110001: out = 32'd1;
			//| -1
			6'b110010: out = ~32'd1 + 32'd1;
			default: out = B;
		endcase
	end


endmodule