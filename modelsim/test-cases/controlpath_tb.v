`timescale 1ps / 1ps

module controlpath_tb;
    parameter LOGGING_PATH = "./test-cases/log/controlpath_tb.csv";

    reg N, Z, clk, rst;
	reg [7:0] MBR;
	wire [8:0] MPC;
	
    wire [35:24] MIR;
    reg [8:0] next_addr;
    reg jumpN, jumpZ, jump;

    assign MIR = {next_addr, jump, jumpN, jumpZ};

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

    always #2 clk = ~clk;

    initial begin
        // inspeção 0 (caso default)
        $display("running tests");
        fileLog = $fopen(LOGGING_PATH);
        registerDataHeader;
        registerData;

        // inspeção 1 (setup inicial)
        #1 // 1ps // clk = 1'b0 
        setUpInitialState;
        registerData;

        // inspeção 2 (reset)
        @(posedge clk); 
        #1 
        rst = 1'b1;         
        registerData;

        @(posedge clk); 
        #1

        @(posedge clk); 
        #1
        if(MPC != 0) 
        begin 
            $error("[controlpath] reset error"); 
        end
        registerData;

        @(negedge clk);
        setUpInitialState;
        
        // inspeção 3 (MPC == next_addr)
        // jump = 1; MPC <= { high_bit, next_addr[7:0] };  
        // high_bit = (jumpZ && Z_s) || (jumpN && N_s) || next_addr[8]
        @(posedge clk); 
        #1 
        jump = 1'b1;
        N = 1'b0;
        Z = 1'b0;
        next_addr = {9{1'b1}};

        @(posedge clk); 
        #1

        @(posedge clk); 
        #1
        if(MPC != next_addr) 
        begin 
            $error("[controlpath] N = 0, Z = 0, jump = 1 error"); 
        end
        registerData;

        @(negedge clk);
        setUpInitialState;      

        // inspeção 4 (MPC == higthbit = 1 e next_addr completando com 0)
        // jump = 1; MPC <= { high_bit, next_addr[7:0] };  
        // high_bit = (jumpZ && Z_s) || (jumpN && N_s) || next_addr[8]
        @(posedge clk); 
        #1 
        jump = 1'b1;
        jumpN = 1'b1;
        N = 1'b1;
        Z = 1'b0;
        next_addr = {9{1'b0}};

        @(posedge clk); 
        #1

        @(posedge clk); 
        #1
        if(MPC != { 1'b1, next_addr[7:0] }) 
        begin 
            $error("[controlpath] N = 1, Z = 0, jump = 1 error"); 
        end
        registerData;

        @(negedge clk);
        setUpInitialState;        

        

        # 1 
        $fclose(fileLog);
        $display("ended");
        
        #40 $stop;
    end

        

    task setUpInitialState;
        begin
            clk = 1'b0;
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
                "%-d;%b;%b;%b;%b;%-d;%b;%b;%b;%-d;%-d", 
                inpectionsCounter,clk,rst,N,Z,next_addr,jump,jumpN,jumpZ,MBR,MPC
            );
        end
    endtask

    task registerDataHeader; 
        begin
            $fdisplay(
                fileLog, 
                "inpectionsCounter;clk;rst;N;Z;next_addr;jump;jumpN;jumpZ;MBR;MPC");
        end
    endtask

endmodule

