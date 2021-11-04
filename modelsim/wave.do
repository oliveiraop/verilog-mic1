onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /shifter_tb/control
add wave -noupdate -radix binary /shifter_tb/data
add wave -noupdate -radix binary /shifter_tb/dataOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {2 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 237
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
WaveRestoreZoom {0 ps} {15 ps}
