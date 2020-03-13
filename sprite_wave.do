onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sprite_tb/clk
add wave -noupdate /sprite_tb/reset
add wave -noupdate -radix unsigned /sprite_tb/x
add wave -noupdate -radix unsigned /sprite_tb/y
add wave -noupdate -radix unsigned /sprite_tb/vga_x
add wave -noupdate -radix unsigned /sprite_tb/vga_y
add wave -noupdate -expand /sprite_tb/data
add wave -noupdate /sprite_tb/draw
add wave -noupdate /sprite_tb/color
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4599 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 85
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 20
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {10763 ps}
