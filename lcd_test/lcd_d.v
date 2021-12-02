// Adaptacao do codigo do professor para ihm final da disciplina
// buscar @start para achar o ponto de inicio de escrita de dados
// Parametrizando alguns dados que venham externos ao invés de hard coded




//	module atv3(number, control, clk,enable,rs,rw,data,on);
	module lcd_d(SW, KEY, clk,enable,rs,rw,data,on, MDR_in, MAR_in, PC_in, MBR_in, SP_in, CPP_in, LV_in, TOS_in, OPC_in, H_in);

	input clk;
	output reg enable, rs, rw, on;
	output reg [7:0]data;
	
	input KEY;

	input [31:0] MDR_in;
	input [31:0] MAR_in;
	input [31:0] PC_in;
	input [31:0] MBR_in;
	input [31:0] SP_in;
	input [31:0] CPP_in;
	input [31:0] LV_in;
	input [31:0] TOS_in;
	input [31:0] OPC_in;
	input [31:0] H_in;

	wire [7:0] MDR [7:0];
	wire [7:0] MAR [7:0];
	wire [7:0] PC [7:0];
	wire [7:0] MBR [7:0];
	wire [7:0] SP [7:0];
	wire [7:0] CPP [7:0];
	wire [7:0] LV [7:0];
	wire [7:0] TOS [7:0];
	wire [7:0] OPC [7:0];
	wire [7:0] H [7:0];

	bin2lcd MDR_c(.register(MDR_in), .out0(MDR[0]), .out1(MDR[1]), .out2(MDR[2]), .out3(MDR[3]), .out4(MDR[4]), .out5(MDR[5]), .out6(MDR[6]), .out7(MDR[7]));
	bin2lcd MAR_c(.register(MAR_in), .out0(MAR[0]), .out1(MAR[1]), .out2(MAR[2]), .out3(MAR[3]), .out4(MAR[4]), .out5(MAR[5]), .out6(MAR[6]), .out7(MAR[7]));
	bin2lcd PC_c(.register(PC_in), .out0(PC[0]), .out1(PC[1]), .out2(PC[2]), .out3(PC[3]), .out4(PC[4]), .out5(PC[5]), .out6(PC[6]), .out7(PC[7]));
	bin2lcd MBR_c(.register(MBR_in), .out0(MBR[0]), .out1(MBR[1]), .out2(MBR[2]), .out3(MBR[3]), .out4(MBR[4]), .out5(MBR[5]), .out6(MBR[6]), .out7(MBR[7]));
	bin2lcd SP_c(.register(SP_in), .out0(SP[0]), .out1(SP[1]), .out2(SP[2]), .out3(SP[3]), .out4(SP[4]), .out5(SP[5]), .out6(SP[6]), .out7(SP[7]));
	bin2lcd CPP_c(.register(CPP_in), .out0(CPP[0]), .out1(CPP[1]), .out2(CPP[2]), .out3(CPP[3]), .out4(CPP[4]), .out5(CPP[5]), .out6(CPP[6]), .out7(CPP[7]));
	bin2lcd LV_c(.register(LV_in), .out0(LV[0]), .out1(LV[1]), .out2(LV[2]), .out3(LV[3]), .out4(LV[4]), .out5(LV[5]), .out6(LV[6]), .out7(LV[7]));
	bin2lcd TOS_c(.register(TOS_in), .out0(TOS[0]), .out1(TOS[1]), .out2(TOS[2]), .out3(TOS[3]), .out4(TOS[4]), .out5(TOS[5]), .out6(TOS[6]), .out7(TOS[7]));
	bin2lcd OPC_c(.register(OPC_in), .out0(OPC[0]), .out1(OPC[1]), .out2(OPC[2]), .out3(OPC[3]), .out4(OPC[4]), .out5(OPC[5]), .out6(OPC[6]), .out7(OPC[7]));
	bin2lcd H_c(.register(H_in), .out0(H[0]), .out1(H[1]), .out2(H[2]), .out3(H[3]), .out4(H[4]), .out5(H[5]), .out6(H[6]), .out7(H[7]));

	//input [4:0]number;
	//input control;
	
	input [2:0] SW;
	
	reg [7:0] state;
	reg [7:0] nstate;
	reg [16:0]counter;
	reg [2:0]counter2;
	reg clk_100hz;
	reg [2:0] last_sw; 


	reg [3:0]bit2;

	wire[3:0] BT; 
	
	//SWITCH DETECT GLOBALS
   reg [4:0] swd [1:0];
	
	reg reset = 1'b0;

	
	//SWITCH STATE GLOBALS
	
	
	// Declare states
	parameter power_on = 0, function_set = 1, function_set1 = 2, function_set2 = 3,
				function_set3 = 4,display_off = 5,display_clear = 6, display_on=7,
				entry_mode_set=8, write0 = 9, write1 = 10, write2 = 11, write3 = 12, 
				write4 = 13, write5 = 14, write6 = 15, write7 = 16, write8 = 17, 
				write9 = 18, write10 = 19, write11 = 20, write12 = 21, set_line2_1 = 22, 
				write13 = 23, write14 = 24, write15 = 25, write16 = 26, write17 = 27, 
				write18 = 28, write19 = 29, write20 = 30, write21 = 31, write22 = 32, 
				write23 = 33, write24 = 34, write25 = 35, write26 = 36, write27 = 37, 
				write28 = 38, write29 = 39, write30 = 40, write31 = 41, next = 42, display_clear2 = 43, write01 = 44,
				write32 = 45, write33 = 46, write34 = 47, write35 = 48, write36 = 49, 
				write37 = 50, write38 = 51, write39 = 52, write40 = 53, write41 = 54, write42 = 55,
				write43 = 56, write44 = 57, write45 = 58, write46 = 59, write47 = 60, write48 = 61,
				write49 = 62, write50 = 63, write51 = 64, write52 = 65, write53 = 66, write54 = 67,
				write55 = 68, write56 = 69, write57 = 70, write58 = 71, write59 = 72, write60 = 73, 
				write61 = 74, write62 = 75, write63 = 76, write64 = 77, write65 = 78, write66 = 79, 				
				write67 = 80, write68 = 81, write69 = 82, write70 = 83, write71 = 84, write72 = 85, set_line2_2 = 86,
		      write73 = 87, write74 = 88, write75 = 89,	
				write76 = 91, write77 = 92, write78 = 93, write79 = 94, write80 = 95, write81 = 96, 	
				write82 = 97, write83 = 98, write84 = 99, write85 = 100, write86 = 101, write87 = 102,           
				write88 = 103, write89 = 104, write90 = 105, write91 = 106, write92 = 107, write93 = 108,
				write94 = 109, write95 = 110, write96 = 111, write97 = 112, write98 = 113, write99 = 114, write100 = 115,
    			write101 = 116, write102 = 117, write103 = 118, write104 = 119, write105 = 120, write106 = 121, write107 = 122,
				write108 = 123, write109 = 124, write110 = 125, write111 = 126, write113 = 127, display_clear1 = 128, display_clear3 = 129,
				display_clear4 = 130, display_clear5 = 131, write114 = 132, write115 = 133, write116 = 134, write117 = 135, write118 = 136,
				write119 = 137, write120 = 138, write121 = 139, write122 = 140, write123 = 141, write124 = 142, write125 = 143, write126 = 144,
				write127 = 145, write128 = 146, write129 = 147, write130 = 148, write131 = 149, write132 = 150, write133 = 151, write134 = 152,
				write135 = 153, write136 = 154, write112 = 155, write137 = 156;

				
    //virtual_input DUV (.number(number), .control(control), .button0(BT[0]));
	
		
//always @(posedge KEY[0])
//begin
// BTN[0]<=~BTN[0];
//end		
		
		
		
		
always @ (posedge clk) begin


  if(counter < 17'd125000) 
    begin									 
	   counter <= counter + 1'b1;
	 end
  else
	 begin
	   counter <= 17'h00000;
	   clk_100hz <= ~clk_100hz;
	 end
  end
	 

always @ (posedge clk_100hz) begin
 
 if (KEY==0) begin
 	state <= 0;
   nstate <= 0;
	 last_sw <= 3'b111;
	end
else begin
 
   case (state)	
    power_on:
	 begin
	   state <= next;
		nstate <= function_set; 
	 end
					
	 next:	
 	 begin
 	   enable <= 1'b0; 
	   on <= 1'b1;		
	   state <= nstate;
	 end

	 function_set:
	 begin
	   enable <= 1'b1;
		rs <= 1'b0;
		rw <= 1'b0;
		data <= 8'b00111000;
		state <= next;
		nstate <= function_set1;
	 end
					
	 function_set1:
	 begin
	   enable <= 1'b1;
		rs <= 1'b0;
		rw <= 1'b0;
		data <= 8'b00111000;
		state <= next;
		nstate <= function_set2;
	 end
				
	 function_set2:
	 begin
	   enable <= 1'b1;
		rs <= 1'b0;
		rw <= 1'b0;
		data <= 8'b00111000;
		state <= next;
		nstate <= function_set3;
	 end
				
	 function_set3:
	 begin
	   enable <= 1'b1;
	   rs <= 1'b0;
	   rw <= 1'b0;
	   data <= 8'b00111000;
	   state <= next;
	   nstate <= display_off;
	 end
					
	 display_off:
	 begin
	   enable <= 1'b1;
		rs <= 1'b0;
		rw <= 1'b0;
		data <= 8'b00001000;
		state <= next;
		nstate <= display_clear;
	 end
				
	 display_clear:
	 begin
	   enable <= 1'b1;
		rs <= 1'b0;
		rw <= 1'b0;
		data <= 8'b00000001;
		state <= next;
		nstate <= display_on;
	 end
					
	 display_on:
	 begin
	   enable <= 1'b1;
		rs <= 1'b0;
		rw <= 1'b0;
		data <= 8'b00001100;
		state <= next;
		nstate <= entry_mode_set;
	 end
					
	 entry_mode_set: //@entry
	 begin
	   enable <= 1'b1;
		rs <= 1'b0;
		rw <= 1'b0;
		data <= 8'b00000110;
		state <= next;
		case (SW[2:0])
		3'b000: nstate <= display_clear1; // MDR e MAR
		3'b001: nstate <= display_clear2;//PC e MBR
		3'b010: nstate <= display_clear3;//SP e TOS
		3'b011: nstate <= display_clear4;//LV e CPP
		3'b100: nstate <= display_clear5;//OPC e H
		default: nstate <= write0;
		endcase
	 end

	 display_clear1:
	 begin
		if (last_sw != SW)
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b00000001;
			state <= next;
			nstate <= write0;
			last_sw <= SW;
		end
		else
		begin
			state <= write0;
		end
	 end

	write0:
	 begin
	enable <= 1'b1;
	rs <= 1'b0;
	rw <= 1'b0;
	data <= 8'b10000000; //Return home
	state <= next;
	nstate <= write2;
	 end
	 
	write2:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h4D; //M
	  state <= next;
	  nstate <= write3;
	end
				
   write3:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h44; //D
	  state <= next;
	  nstate <= write4;
	end
				
	write4:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h52; //R
	  state <= next;
	  nstate <= write5;
	end
				
	write5:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h3A; //:
	  state <= next;
	  nstate <= write6;
	end

   write6:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h30; //0
	  state <= next;
	  nstate <= write7;
	end
	
				
	write7:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h78; //x
		state <= next;
		nstate <= write8;
	end
				
	write8:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
	   data <= MDR[7]; //@mdr[7]
		state <= next;
		nstate <= write9;
	end
					

	write9:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MDR[6]; //@mdr[6]
		state <= next;
		nstate <= write10;
	end
			
	write10:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MDR[5]; //@mdr[5]
		state <= next;
		nstate <= write11;
	end	
	
	write11:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MDR[4]; //@mdr[4]
		state <= next;
		nstate <= write12;
	end
					
	write12:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MDR[3]; //@mdr[3]
		state <= next;
		nstate <= write13;
	end
			
	
	write13:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MDR[2]; //@mdr[2]
		state <= next;
		nstate <= write14;
	end
	write14:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MDR[1]; //@mdr[1]
		state <= next;
		nstate <= write15;
	end
				
	write15:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MDR[0]; //@mdr[0]
		state <= next;
		nstate <= set_line2_1;
	end

	set_line2_1:
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b11000000; //Pula para linha 2
			state <= next;
			nstate <= write16;
		end
				
	write16:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h4D; //M
		state <= next;
		nstate <= write17;
	end
				
	write17:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h41; //A
		state <= next;
		nstate <= write18;
	end
				
	write18:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h52; //R
		state <= next;
		nstate <= write19;
	end
					
	write19:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h3A; //:
		state <= next;
		nstate <= write20;
	end
	
	write20:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h30; //0
		state <= next;
		nstate <= write21;
	end	
				
	write21:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h78; //x
		state <= next;
		nstate <= write22;
	end
					
	write22:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MAR[7]; //@mar[7]
		state <= next;
		nstate <= write23;
	end

	write23:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MAR[6]; //@mar[6]
		state <= next;
		nstate <= write24;
	end	
				
	write24:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MAR[5]; //@mar[5]
		state <= next;
		nstate <= write25;
	end
	
	write25:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MAR[4]; //@mar[4]
		state <= next;
		nstate <= write26;
	end	
	
	write26:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MAR[3]; //@mar[3]
		state <= next;
		nstate <= write27;
	end		
	
	write27:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MAR[2]; //@mar[2]
		state <= next;
		nstate <= write28;
	end		
	
	write28:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MAR[1]; //@mar[1]
		state <= next;
		nstate <= write29;
	end				

   write29:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= MAR[0]; //@mar[0]
		state <= next;
		nstate <= write30;
	end
	
	write30:
	begin
		state <= next;
		nstate <= entry_mode_set;
	end
				
  display_clear2:
  begin
		if (last_sw != SW)
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b00000001;
			state <= next;
			nstate <= write31;
			last_sw <= SW;
		end
		else 
		begin
			state <= write31;
		end
	end					

    write31:
	 begin
	enable <= 1'b1;
	rs <= 1'b0;
	rw <= 1'b0;
	data <= 8'b10000000; //Return home
	state <= next;
	nstate <= write32;
	 end
	 
	write32:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h50; //P
	  state <= next;
	  nstate <= write33;
	end	 
	
   write33:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h43; //C
	  state <= next;
	  nstate <= write34;
	end		
	 
	write34:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h3A; //:
	  state <= next;
	  nstate <= write35;
	end
				
   write35:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h30; //0
	  state <= next;
	  nstate <= write36;
	end
				
	write36:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h78; //x
	  state <= next;
	  nstate <= write37;
	end
				
	write37:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= PC[7]; //@PC[7]
	  state <= next;
	  nstate <= write38;
	end

   write38:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= PC[6]; //@PC[6]
	  state <= next;
	  nstate <= write39;
	end		
	write39:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= PC[5]; //@PC[5]
		state <= next;
		nstate <= write40;
	end
				
	write40:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= PC[4]; //@PC[4]
		state <= next;
		nstate <= write41;
	end

	write41:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
	   data <= PC[3]; //@PC[3]
		state <= next;
		nstate <= write42;
	end
	write42:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= PC[2]; //@PC[2]		
		state <= next;
		nstate <= write43;
	end	
	
	write43:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= PC[1]; //@PC[1]
		state <= next;
		nstate <= write44;
	end
					
	write44:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= PC[0]; //@PC[0]
		state <= next;
		nstate <= set_line2_2;
	end
	
/////////////////////////////////	
	

		set_line2_2:
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b11000000; //Pula para linha 2
			state <= next;
			nstate <= write45;
		end

	write45:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
	   data <= 8'h4D; //M
		state <= next;
		nstate <= write46;
	end
	
	write46:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
	   data <= 8'h42; //B
		state <= next;
		nstate <= write47;
	end
				
		

				
				 
	write47:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h52; //R
	  state <= next;
	  nstate <= write48;
	end	 
	
   write48:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h3A; //:
	  state <= next;
	  nstate <= write49;
	end		
	 
	write49:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h30; //0
	  state <= next;
	  nstate <= write50;
	end
				
   write50:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= 8'h78; //x
	  state <= next;
	  nstate <= write51;
	end
				
	write51:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= MBR[1]; //MBR[1]
	  state <= next;
	  nstate <= write52;
	end
				
	write52:
	begin
	  enable <= 1'b1;
	  rs <= 1'b1;
	  rw <= 1'b0;
	  data <= MBR[0]; //MBR[0]
	  state <= next;
	  nstate <= entry_mode_set;
	end

//3#

	 display_clear3:
	 begin
		if (last_sw != SW)
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b00000001;
			state <= next;
			nstate <= write53;
			last_sw <= SW;
		end
		else
		begin
			state <= write53;
		end
	 end

 write53:
	 begin
	enable <= 1'b1;
	rs <= 1'b0;
	rw <= 1'b0;
	data <= 8'b10000000; //Return home
	state <= next;
	nstate <= write54;
	 end

	write54:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h53; //S
		state <= next;
		nstate <= write55;
	end
				
	write55:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h30; //P
		state <= next;
		nstate <= write56;
	end
/////////////////////////					

	write56:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
	   data <= 8'h3A; //:
		state <= next;
		nstate <= write57;
	end
	
	write57:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h30; //0	
		state <= next;
		nstate <= write58;
	end	
	
	write58:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h78; //x	
		state <= next;
		nstate <= write59;
	end
					
	write59:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= SP[7]; //SP[7]
		state <= next;
		nstate <= write60;
	end
	
	write60:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= SP[6]; //SP[6]
		state <= next;
		nstate <= write61;
	end

	write61:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= SP[5]; //SP[5]
		state <= next;
		nstate <= write62;
	end

	write62:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= SP[4]; //SP[4]
		state <= next;
		nstate <= write63;
	end

	write63:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= SP[3]; //SP[3]
		state <= next;
		nstate <= write64;
	end

	write64:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= SP[2]; //SP[2]
		state <= next;
		nstate <= write65;
	end

	write65:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= SP[1]; //SP[1]
		state <= next;
		nstate <= write66;
	end

	write66:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= SP[0]; //SP[0]
		state <= next;
		nstate <= write67;
	end

	write67:
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b11000000; //Pula para linha 2
			state <= next;
			nstate <= write68;
		end
	
	write68:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h54; //T
		state <= next;
		nstate <= write69;
	end

	write69:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h4F; //O
		state <= next;
		nstate <= write70;
	end

	write70:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h53; //S
		state <= next;
		nstate <= write71;
	end

	write71:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h3A; //:
		state <= next;
		nstate <= write72;
	end

	write72:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h30; //0
		state <= next;
		nstate <= write73;
	end

	write73:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h78; //x
		state <= next;
		nstate <= write74;
	end

	write74:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= TOS[7]; //TOS[7]
		state <= next;
		nstate <= write75;
	end

	write75:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= TOS[6]; //TOS[6]
		state <= next;
		nstate <= write76;
	end

	write76:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= TOS[5]; //TOS[5]
		state <= next;
		nstate <= write77;
	end

	write77:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= TOS[4]; //TOS[4]
		state <= next;
		nstate <= write78;
	end

	write78:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= TOS[3]; //TOS[3]
		state <= next;
		nstate <= write79;
	end

	write79:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= TOS[2]; //TOS[2]
		state <= next;
		nstate <= write80;
	end

	write80:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= TOS[1]; //TOS[1]
		state <= next;
		nstate <= write81;
	end

	write81:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= TOS[0]; //TOS[0]
		state <= next;
		nstate <= entry_mode_set;
	end



//4# LV E CPP

	display_clear4:
	 begin
		if (last_sw != SW)
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b00000001;
			state <= next;
			nstate <= write1;
			last_sw <= SW;
		end
		else state <= write1;
	 end

	write1:
	 begin
	enable <= 1'b1;
	rs <= 1'b0;
	rw <= 1'b0;
	data <= 8'b10000000; //Return home
	state <= next;
	nstate <= write82;
	 end

	write82:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h4C; //L
		state <= next;
		nstate <= write83;
	end 

	write83:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h56; //V
		state <= next;
		nstate <= write84;
	end 

	write84:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h3A; //:
		state <= next;
		nstate <= write85;
	end

	write85:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h30; //0
		state <= next;
		nstate <= write86;
	end

	write86:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h78; //x
		state <= next;
		nstate <= write87;
	end

	write87:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= LV[7]; //LV[7]
		state <= next;
		nstate <= write88;
	end

	write88:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= LV[6]; //LV[6]
		state <= next;
		nstate <= write89;
	end

	write89:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= LV[5]; //LV[5]
		state <= next;
		nstate <= write90;
	end

	write90:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= LV[4]; //LV[4]
		state <= next;
		nstate <= write91;
	end

	write91:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= LV[3]; //LV[3]
		state <= next;
		nstate <= write92;
	end

	write92:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= LV[2]; //LV[2]
		state <= next;
		nstate <= write93;
	end

	write93:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= LV[1]; //LV[1]
		state <= next;
		nstate <= write94;
	end

	write94:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= LV[0]; //LV[0]
		state <= next;
		nstate <= write95;
	end

	write95:
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b11000000; //Pula para linha 2
			state <= next;
			nstate <= write96;
		end

	write96:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h43; //C
		state <= next;
		nstate <= write97;
	end

	write97:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h50; //P
		state <= next;
		nstate <= write98;
	end

	write98:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h50; //P
		state <= next;
		nstate <= write99;
	end

	write99:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h3A; //:
		state <= next;
		nstate <= write100;
	end

	write100:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h30; //0
		state <= next;
		nstate <= write101;
	end

	write101:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h78; //x
		state <= next;
		nstate <= write102;
	end

	write102:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= CPP[7]; //CPP[7]
		state <= next;
		nstate <= write103;
	end

	write103:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= CPP[6]; //CPP[6]
		state <= next;
		nstate <= write104;
	end

	write104:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= CPP[5]; //CPP[5]
		state <= next;
		nstate <= write105;
	end

	write105:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= CPP[4]; //CPP[4]
		state <= next;
		nstate <= write106;
	end

	write106:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= CPP[3]; //CPP[3]
		state <= next;
		nstate <= write107;
	end

	write107:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= CPP[2]; //CPP[2]
		state <= next;
		nstate <= write108;
	end

	write108:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= CPP[1]; //CPP[1]
		state <= next;
		nstate <= write109;
	end

	write109:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= CPP[0]; //CPP[0]
		state <= next;
		nstate <= entry_mode_set;
	end

//5# OPC e H

	display_clear5:
	 begin
		if (last_sw != SW)
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b00000001;
			state <= next;
			nstate <= write137;
			last_sw <= SW;
		end
		else state <= write137;
	 end

	write137:
	 begin
	enable <= 1'b1;
	rs <= 1'b0;
	rw <= 1'b0;
	data <= 8'b10000000; //Return home
	state <= next;
	nstate <= write110;
	 end

	 write110:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h4F; //O
		state <= next;
		nstate <= write111;
	end

	write111:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h50; //P
		state <= next;
		nstate <= write112;
	end

	write112:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h43; //C
		state <= next;
		nstate <= write113;
	end

	write113:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h3A; //:
		state <= next;
		nstate <= write114;
	end

write114:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h30; //0
		state <= next;
		nstate <= write115;
	end

	write115:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h78; //x
		state <= next;
		nstate <= write116;
	end

	write116:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= OPC[7]; //OPC[7]
		state <= next;
		nstate <= write117;
	end

	write117:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= OPC[6]; //OPC[6]
		state <= next;
		nstate <= write118;
	end

	write118:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= OPC[5]; //OPC[5]
		state <= next;
		nstate <= write119;
	end

	write119:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= OPC[4]; //OPC[4]
		state <= next;
		nstate <= write120;
	end

	write120:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= OPC[3]; //OPC[3]
		state <= next;
		nstate <= write121;
	end

	write121:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= OPC[2]; //OPC[2]
		state <= next;
		nstate <= write122;
	end

	write122:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= OPC[1]; //OPC[1]
		state <= next;
		nstate <= write123;
	end

	write123:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= OPC[0]; //OPC[0]
		state <= next;
		nstate <= write124;
	end

	write124:
		begin
			enable <= 1'b1;
			rs <= 1'b0;
			rw <= 1'b0;
			data <= 8'b11000000; //Pula para linha 2
			state <= next;
			nstate <= write125;
		end
	
	write125:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h48; //H
		state <= next;
		nstate <= write126;
	end

	write126:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h3A; //:
		state <= next;
		nstate <= write127;
	end

	write127:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h30; //0
		state <= next;
		nstate <= write128;
	end

	write128:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= 8'h78; //x
		state <= next;
		nstate <= write129;
	end

	write129:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= H[7]; //H[7]
		state <= next;
		nstate <= write130;
	end

	write130:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= H[6]; //H[6]
		state <= next;
		nstate <= write131;
	end

	write131:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= H[5]; //H[5]
		state <= next;
		nstate <= write132;
	end

	write132:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= H[4]; //H[4]
		state <= next;
		nstate <= write133;
	end

	write133:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= H[3]; //H[3]
		state <= next;
		nstate <= write134;
	end

	write134:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= H[2]; //H[2]
		state <= next;
		nstate <= write135;
	end

	write135:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= H[1]; //H[1]
		state <= next;
		nstate <= write136;
	end

	write136:
	begin
		enable <= 1'b1;
		rs <= 1'b1;
		rw <= 1'b0;
		data <= H[0]; //H[0]
		state <= next;
		nstate <= entry_mode_set;
	end

	endcase
	
	end
	
	end
	
	
				

endmodule