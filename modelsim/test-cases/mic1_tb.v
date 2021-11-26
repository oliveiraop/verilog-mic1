`timescale 1ps / 1ps

module mic1_tb;
    parameter LOGGING_PATH = "./test-cases/log/mic1_tb.csv";

    reg clock;
	reg [31:0] ROM_data, RAM_data, C;
	reg [15:0] MIR;
	wire [31:0] A, B, PC, MAR;
	wire [31:0] MDR, MBR;

    reg [35:0] rom;

    integer fileLog;
    integer inpectionsCounter = -1;

    MIC1 mic1 (
        .clock(clock),
        .ROM_data(ROM_data),
        .RAM_data(RAM_data),
        .C(C),
        .MIR(MIR),
        .MAR(MAR),
        .MDR(MDR),
        .PC(PC),
        .MBR(MBR),
        .A(A),
        .B(B)
    );

    always #2 clock = ~clock;

    assign MIR = rom[15:0];

    initial begin
        // inspeção 0 (caso default)
        $display("running tests");
        fileLog = $fopen(LOGGING_PATH);
        registerDataHeader;
        registerData;

        // inspeção 1 (setup inicial)
        #1 
        setUpInitialState;
        registerData;

        // inspeção 2 (PC=PC+1;goto 0x40)
        @(posedge clock)
        #1
        rom = 36'b001000000_000_00_110101_000000100_000_0001;

        @(posedge clock)
        #1
        if(0) begin 
            $error("[mic1] MIR error"); 
        end
        registerData;

        // @(negedge clock)
        // setUpInitialState;
       
        #1
        $fclose(fileLog);
        $display("ended");
        
        #10 $stop;
    end

        

    task setUpInitialState;
        begin
            clock = 1'b0;
            ROM_data = {32{1'b0}};
            RAM_data = {32{1'b0}};
            C = {32{1'b0}};
            MIR = {16{1'b0}};
        end
    endtask
    

    task registerData; 
        begin
            inpectionsCounter = inpectionsCounter + 1;
            $fstrobe(
                fileLog, 
                "%-d;%b;%b;%b;%b;%-d;%-d;%-d;%-d;%-d;%-d;%-d", 
                inpectionsCounter, clock, ROM_data, RAM_data, MIR, C, A, B, MAR, MDR, PC, MBR
            );
        end
    endtask

    task registerDataHeader; 
        begin
            $fdisplay(
                fileLog, 
                "inpectionsCounter;clock;ROM_data;RAM_data;MIR;C;A;B;MAR;MDR;PC;MBR");
        end
    endtask

endmodule

