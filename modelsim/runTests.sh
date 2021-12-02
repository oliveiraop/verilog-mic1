FILE=mic1_tb
vsim -c -do "
    vsim work.${FILE}
    run -all
    exit" $FILE

bash analysers/analyse.sh
