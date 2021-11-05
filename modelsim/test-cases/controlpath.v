`timescale 1ps / 1ps

module controlpath;
    parameter LOGGING_PATH = "./test-cases/log/controlpath.csv";

    reg N, Z, clk, rst;
	reg [7:0] MBR;
	wire [8:0] MPC;
	reg [35:24] MIR;

    integer fileLog;
    integer inpectionsCounter = -1;

    controlpath CONTROLPATH (
        .clk(clk),
        .rst(rst),
        .N(N),
        .Z(Z),
        .MBR(MBR),
        .MIR(MIR),
        .MPC(MPC)
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
        registerData;

        #1 // 3ps
        if(false) 
        begin 
            $error("error"); 
        end
        registerData;

        #1 // 4ps
        registerData;

        #1 // 5ps
        if(false)
        begin 
            $error("error"); 
        end
        registerData;

        #1 // 6ps
        registerData;

        #1 // 7ps
        if(false) 
        begin 
            $error("error"); 
        end
        registerData;

        #1 // 8ps
        registerData;

        #1 // 9ps
        if(false) 
        begin 
            $error("error"); 
        end
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
*/
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

