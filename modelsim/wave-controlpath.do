onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /controlpath_tb/clk
add wave -noupdate -radix binary /controlpath_tb/rst
add wave -noupdate -radix binary /controlpath_tb/N
add wave -noupdate -radix binary /controlpath_tb/Z
add wave -noupdate -radix binary /controlpath_tb/next_addr
add wave -noupdate -radix binary /controlpath_tb/jump
add wave -noupdate -radix binary /controlpath_tb/jumpN
add wave -noupdate -radix binary /controlpath_tb/jumpZ
add wave -noupdate -radix binary /controlpath_tb/MBR
add wave -noupdate -radix binary /controlpath_tb/MPC
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {6 ps}
