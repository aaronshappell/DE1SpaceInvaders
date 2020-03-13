onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /enemy_tb/clk
add wave -noupdate /enemy_tb/reset
add wave -noupdate -radix unsigned /enemy_tb/sx
add wave -noupdate -radix unsigned /enemy_tb/sy
add wave -noupdate -radix unsigned /enemy_tb/vga_x
add wave -noupdate -radix unsigned /enemy_tb/vga_y
add wave -noupdate -radix unsigned /enemy_tb/bx
add wave -noupdate -radix unsigned /enemy_tb/by
add wave -noupdate /enemy_tb/draw
add wave -noupdate /enemy_tb/dead
add wave -noupdate -radix unsigned /enemy_tb/r
add wave -noupdate -radix unsigned /enemy_tb/g
add wave -noupdate -radix unsigned /enemy_tb/b
add wave -noupdate -radix unsigned /enemy_tb/dut/x
add wave -noupdate -radix unsigned /enemy_tb/dut/y
add wave -noupdate /enemy_tb/edgeL
add wave -noupdate /enemy_tb/edgeR
add wave -noupdate -radix unsigned /enemy_tb/dut/delay
add wave -noupdate /enemy_tb/dut/ps
add wave -noupdate /enemy_tb/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21297 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 87
configure wave -valuecolwidth 67
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
WaveRestoreZoom {0 ps} {118493 ps}
