`timescale 1ps / 1ps

module mic1_tb;
    parameter LOGGING_PATH = "./test-cases/log/mic1_tb.csv";

    reg clock;
	reg [31:0] ROM_data, RAM_data, C;
	reg [15:0] MIR;
	wire [31:0] A, B, PC, MAR;
	wire [31:0] MDR, MBR;

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

        // inspeção 2 (caso feliz: tudo ativo)
        @(posedge clock)
        #1
        // dataIn = {32{1'b1}};

        @(posedge clock)
        #1
        // if(alwaysOnDataOut != {32{1'b1}} || dataOut != {32{1'b1}}) begin 
        //     $error("[register] dataIn = 1...1, inEnable = 1, outEnable = 1 error"); 
        // end
        registerData;

        @(negedge clock)
        setUpInitialState;
        
       
        # 1
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

