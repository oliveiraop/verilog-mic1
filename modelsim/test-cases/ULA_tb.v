`timescale 1ps / 1ps

module ULA_tb;
    parameter LOGGING_PATH = "./test-cases/log/ULA_tb.csv";

    reg [31:0] A, B;
	reg [7:0] select;
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
        select = 8'b00011000;
        registerData;

        #1 // 3ps
        if(out != A || N == 1 || Z == 1) 
        begin 
            $error("[ULA_tb] bypass A error"); 
        end
        registerData;

        #1 // 4ps
        // bypass para a entrada B
        select = 8'b00010100;
        registerData;

        #1 // 5ps
        if(out != B || N == 1 || Z == 1)
        begin 
            $error("[ULA_tb] bypass B error"); 
        end
        registerData;

        #1 // 6ps
        //| ~A
		select = 8'b00011010; 
        registerData;

        #1 // 7ps
        if(out != ~A || N == 0 || Z == 1) 
        begin 
            $error("[ULA_tb] ~A error"); 
        end
        registerData;

        #1 // 8ps
        registerData;

        #1 // 9ps
        
        registerData;

        #1 // 10ps
        registerData;

        #1 // 11ps
        registerData;

        #1 // 12ps
        registerData;

        #1 // 13ps
        registerData;

        #1 // 14ps
        registerData;

        #1 // 15ps
        registerData;

        #1 // 16ps
        registerData;

        #1 // 17ps
        registerData;

        #1 // 18ps
        registerData;

        #1 // 19ps
        registerData;

        #1 // 20ps
        registerData;

        # 1 // 21ps 
        $fclose(fileLog);
        $display("ended");
    end

    task setUpInitialState;
        begin
            select = 8'b0;
            A = 32'b0;
            B = 32'b0;
        end
    endtask

    task registerData; 
        begin
            inpectionsCounter = inpectionsCounter + 1;
            $fstrobe(
                fileLog, 
                "%-d;%-d;%-d;%-d;%-d;%b;%b", 
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

