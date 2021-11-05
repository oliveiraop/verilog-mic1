`timescale 1ps / 1ps

module controlpath;
    parameter LOGGING_PATH = "./test-cases/log/controlpath.csv";

    reg N, Z, clk, rst;
	reg [7:0] MBR;
	wire [8:0] MPC;
	
    wire [35:24] MIR;
    reg [8:0] next_addr;
    reg jumpN, jumpZ, jump;

    assign MIR = {next_addr, jump, jumpN, jumpZ}

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
        @(posedge clk) 

        $display("running tests");
        fileLog = $fopen(LOGGING_PATH);
        registerDataHeader;
        registerData;

        @(posedge clk) // 1ps
        setUpInitialState;
        registerData;

        @(negedge clk) // 2ps
        rst = 1'b1;

        @(posedge clk) // 3ps
        if(MPC != 0) 
        begin 
            $error("error"); 
        end        
        registerData;

        # 1 // 4ps 
        $fclose(fileLog);
        $display("ended");
    end


    always @(*) begin
        #1 clk = ~clk;
    end

    task setUpInitialState;
        begin
            rst = 1'b0;            
            N = 1'b0;
            Z = 1'b0;
	        MBR = 8'b0;
	        next_addr = 9'b0; 
            jump = 1'b0; 
            jumpN = 1'b0; 
            jumpZ = 1'b0; 
        end
    endtask

    task registerData; 
        begin
            inpectionsCounter = inpectionsCounter + 1;
            $fstrobe(
                fileLog, 
                "%-d;%b;%b;%b;%b;%b;%b;%b;%-d;%-d;%-d", 
                inpectionsCounter,clk,rst,N,Z,jump,jumpN,jumpZ,MBR,next_addr,MPC
            );
        end
    endtask

    task registerDataHeader; 
        begin
            $fdisplay(
                fileLog, 
                "inpectionsCounter;clk;rst;N;Z;jump;jumpN;jumpZ;MBR;next_addr;MPC");
        end
    endtask

endmodule

