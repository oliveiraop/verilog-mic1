onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /mic1_tb/clock
add wave -noupdate -radix binary /mic1_tb/ROM_data
add wave -noupdate -radix binary /mic1_tb/RAM_data
add wave -noupdate -radix binary -childformat {{{/mic1_tb/MIR[15]} -radix binary} {{/mic1_tb/MIR[14]} -radix binary} {{/mic1_tb/MIR[13]} -radix binary} {{/mic1_tb/MIR[12]} -radix binary} {{/mic1_tb/MIR[11]} -radix binary} {{/mic1_tb/MIR[10]} -radix binary} {{/mic1_tb/MIR[9]} -radix binary} {{/mic1_tb/MIR[8]} -radix binary} {{/mic1_tb/MIR[7]} -radix binary} {{/mic1_tb/MIR[6]} -radix binary} {{/mic1_tb/MIR[5]} -radix binary} {{/mic1_tb/MIR[4]} -radix binary} {{/mic1_tb/MIR[3]} -radix binary} {{/mic1_tb/MIR[2]} -radix binary} {{/mic1_tb/MIR[1]} -radix binary} {{/mic1_tb/MIR[0]} -radix binary}} -subitemconfig {{/mic1_tb/MIR[15]} {-height 17 -radix binary} {/mic1_tb/MIR[14]} {-height 17 -radix binary} {/mic1_tb/MIR[13]} {-height 17 -radix binary} {/mic1_tb/MIR[12]} {-height 17 -radix binary} {/mic1_tb/MIR[11]} {-height 17 -radix binary} {/mic1_tb/MIR[10]} {-height 17 -radix binary} {/mic1_tb/MIR[9]} {-height 17 -radix binary} {/mic1_tb/MIR[8]} {-height 17 -radix binary} {/mic1_tb/MIR[7]} {-height 17 -radix binary} {/mic1_tb/MIR[6]} {-height 17 -radix binary} {/mic1_tb/MIR[5]} {-height 17 -radix binary} {/mic1_tb/MIR[4]} {-height 17 -radix binary} {/mic1_tb/MIR[3]} {-height 17 -radix binary} {/mic1_tb/MIR[2]} {-height 17 -radix binary} {/mic1_tb/MIR[1]} {-height 17 -radix binary} {/mic1_tb/MIR[0]} {-height 17 -radix binary}} /mic1_tb/MIR
add wave -noupdate -radix decimal /mic1_tb/C
add wave -noupdate -radix decimal /mic1_tb/A
add wave -noupdate -radix decimal /mic1_tb/B
add wave -noupdate -radix decimal /mic1_tb/MAR
add wave -noupdate -radix decimal /mic1_tb/MDR
add wave -noupdate -radix decimal /mic1_tb/PC
add wave -noupdate -radix decimal /mic1_tb/MBR
add wave -noupdate -radix decimal /mic1_tb/inpectionsCounter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 196
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {17 ps}
