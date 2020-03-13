onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /player_testbench/clk
add wave -noupdate /player_testbench/reset
add wave -noupdate /player_testbench/left
add wave -noupdate /player_testbench/right
add wave -noupdate /player_testbench/shoot
add wave -noupdate /player_testbench/bullet_hit
add wave -noupdate -radix unsigned /player_testbench/vga_x
add wave -noupdate -radix unsigned /player_testbench/vga_y
add wave -noupdate /player_testbench/draw
add wave -noupdate -radix unsigned /player_testbench/r
add wave -noupdate -radix unsigned /player_testbench/g
add wave -noupdate -radix unsigned /player_testbench/b
add wave -noupdate -radix unsigned /player_testbench/b_x
add wave -noupdate -radix unsigned /player_testbench/b_y
add wave -noupdate -radix unsigned /player_testbench/dut/x
add wave -noupdate -radix unsigned /player_testbench/dut/y
add wave -noupdate -radix unsigned /player_testbench/dut/delay
add wave -noupdate /player_testbench/dut/ps
add wave -noupdate /player_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15170 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 188
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {94658 ps}
