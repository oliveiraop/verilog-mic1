FILE=ULA_tb
vsim -c -do "
    vsim work.${FILE}
    run -all
    exit" $FILE
