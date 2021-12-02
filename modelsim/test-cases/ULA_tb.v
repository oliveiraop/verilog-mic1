`timescale 1ps / 1ps

module ULA_tb;
    parameter LOGGING_PATH = "./test-cases/log/ULA_tb.csv";

    reg [31:0] A, B;
	reg [5:0] select;
	wire [31:0] out;
	wire N, Z;

    integer fileLog;
    integer inpectionsCounter = -1;

    ULA ula(
        .A(A),
        .B(B),
        .select(select),
        .out(out),
        .N(N),
        .Z(Z)
    );

    initial begin
        $display("running tests");
        fileLog = $fopen(LOGGING_PATH);
        registerDataHeader;
        registerData;

        #1 // 1ps
        setUpInitialState;
        registerData;

        #1 // 2ps
        A = 1;
        B = 2;
        // bypass para a entrada A
        select = 6'b011000;

        #1 // 3ps
        if(out != A || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] bypass A error"); 
        end
        registerData;

        #1 // 4ps
        // bypass para a entrada B
        select = 6'b010100;

        #1 // 5ps
        if(out != B || N == 1 || Z == 1)
        begin 
            $error("[ULA_tb] bypass B error"); 
        end
        registerData;

        #1 // 6ps
        //| ~A
		select = 6'b011010; 

        #1 // 7ps
        if(out != ~A || N == 0 || Z == 1) 
        begin 
            $error("[ULA_tb] ~A error"); 
        end
        registerData;

        #1 // 8ps
        //| ~B
		select = 6'b101100;

        #1 // 9ps
        if(out != ~B || N == 0 || Z == 1) 
        begin 
            $error("[ULA_tb] ~B error"); 
        end
        registerData;

        #1 // 10ps
        //| A + B
		select = 6'b111100;

        #1 // 11ps
        if(out != A + B || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] A + B error"); 
        end
        registerData;

        #1 // 12ps
        //| A + B + 1
		select = 6'b111101;

        #1 // 13ps
        if(out != A + B + 1 || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] A + B + 1 error"); 
        end
        registerData;

        #1 // 14ps
        //| A + 1
		select = 6'b111001;

        #1 // 15ps
        if(out != A + 1 || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] A + 1 error"); 
        end
        registerData;

        #1 // 16ps
        //| B + 1
		select = 6'b110101;

        #1 // 17ps
        if(out != B + 1 || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] B + 1 error"); 
        end
        registerData;

        #1 // 18ps
        //| B - A
		select = 6'b111111;

        #1 // 19ps
        if(out != B - A || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] B - A error"); 
        end
        registerData;

        #1 // 20ps
        //| B - 1
		select = 6'b110110;

        #1 // 21ps
        if(out != B - 1 || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] B - 1 error"); 
        end
        registerData;        

        #1 // 22ps
        //| -A
		select = 6'b111011;

        #1 // 23ps
        if(out != ~A + 31'd1 || N == 0 || Z == 1) 
        begin 
            $error("[ULA_tb] -A error"); 
        end
        registerData;

        #1 // 24ps
        //|	A AND B
		select = 6'b001100;

        #1 // 25ps
        if(out != A & B || N == 1 || Z == 0) 
        begin 
            $error("[ULA_tb] A & B error"); 
        end
        registerData;

        #1 // 26ps
        //| A OR B
		select = 6'b011100;

        #1 // 27ps
        if(out != (A | B) || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] A | B error"); 
        end
        registerData;

        #1 // 28ps
        //| 0
		select = 6'b010000;

        #1 // 29ps
        if(out != 32'd0 || N == 1 || Z == 0) 
        begin 
            $error("[ULA_tb] 0 (zero) error"); 
        end
        registerData;
        
        #1 // 30ps
        //| 1
		select = 6'b110001;

        #1 // 31ps
        if(out != 32'd1 || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] 1 (output is not 1) error"); 
        end
        registerData;
        
        #1 // 32ps
        //| -1
		select = 6'b110010; 

        #1 // 33ps
        if(out != ~32'd1 + 32'd1 || N == 0 || Z == 1) 
        begin 
            $error("[ULA_tb] -1 (output is not -1) error"); 
        end
        registerData;

        # 1 // 34ps 
        $fclose(fileLog);
        $display("ended");
    end

    task setUpInitialState;
        begin
            select = 6'b0;
            A = 32'b0;
            B = 32'b0;
        end
    endtask

    task registerData; 
        begin
            inpectionsCounter = inpectionsCounter + 1;
            $fstrobe(
                fileLog, 
                "%-d;%b;%-d;%-d;%-d;%b;%b", 
                inpectionsCounter, select, A, B, out, N, Z
            );
        end
    endtask

    task registerDataHeader; 
        begin
            $fdisplay(
                fileLog, 
                "inpectionsCounter;select;A;B;out;N;Z"
            );
        end
    endtask

endmodule

