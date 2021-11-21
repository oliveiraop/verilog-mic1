`timescale 1ps / 1ps

module register_tb;
    parameter LOGGING_PATH = "./test-cases/log/register_tb.csv";

    reg clock;
	reg [31:0] dataIn;
	reg inEnable;
	reg outEnable;
	wire [31:0] dataOut;
	wire [31:0] alwaysOnDataOut;

    integer fileLog;
    integer inpectionsCounter = -1;

    register REGISTER(
        .clock(clock),
        .dataIn(dataIn),
        .inEnable(inEnable),
        .outEnable(outEnable),
        .dataOut(dataOut),
        .alwaysOnDataOut(alwaysOnDataOut)
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
        dataIn = {32{1'b1}};
        inEnable = 1'b1;
        outEnable = 1'b1;

        @(posedge clock)
        #1
        if(alwaysOnDataOut != {32{1'b1}} || dataOut != {32{1'b1}}) begin 
            $error("[register] dataIn = 1...1, inEnable = 1, outEnable = 1 error"); 
        end
        registerData;

        @(negedge clock)
        setUpInitialState;
        
        // inspeção 3 (saída always deve voltar para 0)
        @(posedge clock)
        #1
        inEnable = 1'b1;

        @(posedge clock)
        #1
        if(alwaysOnDataOut != {32{1'b0}} || dataOut != 32'bZ) begin 
            $error("[register] dataIn = 0...0, inEnable = 1, outEnable = 0 error"); 
        end
        registerData;

        @(negedge clock)
        setUpInitialState;

        // inspeção 4 (atualizar o valor do dataOut)
        @(posedge clock)
        #1
        outEnable = 1'b1;

        @(posedge clock)
        #1
        if(dataOut != alwaysOnDataOut) begin 
            $error("[register] não atualizou o dataOut error"); 
        end
        registerData;

        @(negedge clock)
        setUpInitialState;

        // inspeção 5 (sem que os enable estejam ativos, as saídas não devem mudar)
        @(posedge clock)
        #1
        dataIn = 1'b1;

        @(posedge clock)
        #1
        if(alwaysOnDataOut == {32{1'b1}} || dataOut == {32{1'b1}}) begin 
            $error("[register] os enables não funcionaram no baixo error"); 
        end
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
	        dataIn = {32{1'b0}};
	        inEnable = 1'b0;
	        outEnable = 1'b0;
        end
    endtask

    task registerData; 
        begin
            inpectionsCounter = inpectionsCounter + 1;
            $fstrobe(
                fileLog, 
                "%-d;%b;%-d;%b;%b;%-d;%-d", 
                inpectionsCounter, clock, dataIn, inEnable, outEnable, dataOut, alwaysOnDataOut
            );
        end
    endtask

    task registerDataHeader; 
        begin
            $fdisplay(
                fileLog, 
                "inpectionsCounter;clock;dataIn;inEnable;outEnable;dataOut;alwaysOnDataOut");
        end
    endtask

endmodule

