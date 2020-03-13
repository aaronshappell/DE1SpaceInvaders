onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /enemy_grid_tb/clk
add wave -noupdate /enemy_grid_tb/reset
add wave -noupdate -radix unsigned /enemy_grid_tb/vga_x
add wave -noupdate -radix unsigned /enemy_grid_tb/vga_y
add wave -noupdate -radix unsigned /enemy_grid_tb/bx
add wave -noupdate -radix unsigned /enemy_grid_tb/by
add wave -noupdate -radix unsigned /enemy_grid_tb/r
add wave -noupdate -radix unsigned /enemy_grid_tb/g
add wave -noupdate -radix unsigned /enemy_grid_tb/b
add wave -noupdate -radix unsigned -childformat {{{/enemy_grid_tb/dut/rs[1]} -radix unsigned} {{/enemy_grid_tb/dut/rs[0]} -radix unsigned}} -subitemconfig {{/enemy_grid_tb/dut/rs[1]} {-radix unsigned} {/enemy_grid_tb/dut/rs[0]} {-radix unsigned}} /enemy_grid_tb/dut/rs
add wave -noupdate -radix unsigned /enemy_grid_tb/dut/gs
add wave -noupdate -radix unsigned /enemy_grid_tb/dut/bs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {25298 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 80
configure wave -valuecolwidth 39
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
WaveRestoreZoom {0 ps} {228877 ps}
