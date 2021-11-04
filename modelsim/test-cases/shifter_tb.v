`timescale 1ps / 1ps

module shifter_tb;
    parameter LOGGING_PATH = "./test-cases/log/shifter_tb.csv";

    reg [1:0] control;
    reg [31:0] data;
    wire [31:0] dataOut;

    integer fileLog;
    integer inpectionsCounter = -1;

    shifter SHIFTER(
        .control(control),
	    .data(data),
	    .dataOut(dataOut)
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
        // check of arithmetic shift at right 
        data = {(32/4){4'b1000}};
        control = 2'b01;
        registerData;

        #1 // 3ps
        if(dataOut != {data[31], data[30:0] >> 1}) 
        begin 
            $error("right shift error"); 
        end
        registerData;

        #1 // 4ps
        // check of logical shift at left
        control = 2'b10;
        registerData;

        #1 // 5ps
        if(dataOut != data << 8) 
        begin 
            $error("left shift error"); 
        end
        registerData;

        #1 // 6ps
        setUpInitialState;
        registerData;

        #1 // 7ps
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
            control = 32'd0;
            data = 32'd0;
        end
    endtask

    task registerData; 
        begin
            inpectionsCounter = inpectionsCounter + 1;
            $fstrobe(
                fileLog, 
                "%-d;%b;%b;%b", 
                inpectionsCounter, control, data, dataOut
            );
        end
    endtask

    task registerDataHeader; 
        begin
            $fdisplay(
                fileLog, 
                "inpectionsCounter;control;data;dataOut"
            );
        end
    endtask

endmodule

