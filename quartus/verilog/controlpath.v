module controlpath(
	clk,
	rst,
	N,
	Z,
	MBR,
	MIR,
	MPC
);

	input N, Z, clk, rst;
	input [7:0] MBR;
	output reg [8:0] MPC;
	input [35:24] MIR;

	reg N_s, Z_s;

	wire high_bit;
	assign high_bit = (MIR[24] && Z_s) || (MIR[25] && N_s) || MIR[35];


	always @(posedge clk) 
	begin
		if (rst)
			MPC <= 0;
		else 
		begin
			// load new MPC:
			N_s <= N;
			Z_s <= Z;
			if ( MIR[26] )
				MPC <= { high_bit, (MIR[33:27] ) };
			else
				MPC <= { high_bit, MIR[33:27] || MBR};
		end
	end

endmodule