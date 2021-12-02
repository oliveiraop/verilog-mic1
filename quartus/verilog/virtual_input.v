module virtual_input (number, control, button3, button2, button1, button0, switch17,
	switch16, switch15, switch14, switch13, switch12, switch11, switch10,
	switch9, switch8, switch7, switch6, switch5, switch4, switch3, switch2,
	switch1, switch0);

	input [4:0]number;
	input control;

	output reg button3, button2, button1, button0;
	output reg switch17, switch16, switch15, switch14, switch13, switch12, 
	switch11, switch10, switch9, switch8, switch7, switch6, switch5,
	switch4, switch3, switch2, switch1, switch0;

	always @(posedge control)
	begin
		button3  <= button3 ;
		button2  <= button2 ;
		button1  <= button1 ;
		button0  <= button0 ;
		switch17 <= switch17;
		switch16 <= switch16;
		switch15 <= switch15;
		switch14 <= switch14;
		switch13 <= switch13;
		switch12 <= switch12;
		switch11 <= switch11;
		switch10 <= switch10;
		switch9  <= switch9 ;
		switch8  <= switch8 ;
		switch7  <= switch7 ;
		switch6  <= switch6 ;
		switch5  <= switch5 ;
		switch4  <= switch4 ;
		switch3  <= switch3 ;
		switch2  <= switch2 ;
		switch1  <= switch1 ;
		switch0  <= switch0 ;
		case(number)
			5'b00000:	button3  <= ~button3 ;
			5'b00001: 	button2  <= ~button2 ;
			5'b00010: 	button1  <= ~button1 ;
			5'b00011:	button0  <= ~button0 ;
			5'b00100:	switch17 <= ~switch17;
			5'b00101:	switch16 <= ~switch16;
			5'b00110:	switch15 <= ~switch15;
			5'b00111:	switch14 <= ~switch14;
			5'b01000:	switch13 <= ~switch13;
			5'b01001:	switch12 <= ~switch12;
			5'b01010:	switch11 <= ~switch11;
			5'b01011:	switch10 <= ~switch10;
			5'b01100:	switch9  <= ~switch9 ;
			5'b01101:	switch8  <= ~switch8 ;
			5'b01110:	switch7  <= ~switch7 ;
			5'b01111:	switch6  <= ~switch6 ;
			5'b10000:	switch5  <= ~switch5 ;
			5'b10001:	switch4  <= ~switch4 ;
			5'b10010:	switch3  <= ~switch3 ;
			5'b10011:	switch2  <= ~switch2 ;
			5'b10100:	switch1  <= ~switch1 ;
			5'b10101:	switch0  <= ~switch0 ;
			default:
			begin
				button3 <= 1;
				button2 <= 1;
				button1 <= 1;
				button0 <= 1;
				switch17 <= 0;
				switch16 <= 0;
				switch15 <= 0;
				switch14 <= 0;
				switch13 <= 0;
				switch12 <= 0;
				switch11 <= 0;
				switch10 <= 0;
				switch9 <= 0;
				switch8 <= 0;
				switch7 <= 0;
				switch6 <= 0;
				switch5 <= 0;
				switch4 <= 0;
				switch3 <= 0;
				switch2 <= 0;
				switch1 <= 0;
				switch0 <= 0;
			end
		endcase
	end
endmodule
