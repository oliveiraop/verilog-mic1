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

	wire [8:0] next_addr;
	wire jump, jumpN, jumpZ;
	
	assign next_addr = MIR[35:27];
	assign jump = MIR[26];
	assign jumpN = MIR[25];
	assign jumpZ = MIR[24];

	reg N_s, Z_s;

	wire high_bit;
	assign high_bit = (jumpZ && Z_s) || (jumpN && N_s) || next_addr[8];


	always @(posedge clk) 
	begin
		if (rst)
			MPC <= 0;
		else 
		begin
			// load new MPC:
			N_s <= N;
			Z_s <= Z;
			if (jump )
				MPC <= { high_bit, next_addr[7:0] }; 
			else
				MPC <= { high_bit, next_addr[7:0] || MBR}; 
		end
	end

endmodule