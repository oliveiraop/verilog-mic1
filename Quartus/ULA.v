module ULA(
	A,
	B,
	select,
	out,
	N,
	Z
);

input [31:0] A, B;
input [7:0] select;
output reg [31:0] out;
output N, Z;

assign N = out[31];
assign Z = !(out);

always @ (select, A, B)
begin
	case (select)
		//| A
		8'b00011000: out = A;
		//| B
		8'b00010100: out = B;
		//| ~A
		8'b00011010: out = ~A;
		//| ~B
		8'b00101100: out = ~B;
		//| A + B
		8'b00111100: out = A + B;
		//| A + B + 1
		8'b00111101: out = A + B + 1;
		//| A + 1
		8'b00111001: out = A + 1;
		//| B + 1
		8'b00110101: out = B + 1;
		//| B - A
		8'b00111111: out = B - A;
		//| B - 1
		8'b00110110: out = B - 1;
		//| -A
		8'b00111011: out = ~A + 31'd1;
		//|	A AND B
		8'b00001100: out = A & B;
		//| A OR B
		8'b00011100: out = A | B;
		//| 0
		8'b00010000: out = 32'd0;
		//| 1
		8'b00110001: out = 32'd1;
		//| -1
		8'b00110010: out = ~32'd1 + 32'd1;
		default: out = 32'b0;
	endcase
end


endmodule