onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /score_tb/clk
add wave -noupdate /score_tb/reset
add wave -noupdate -radix unsigned /score_tb/vga_x
add wave -noupdate -radix unsigned /score_tb/vga_y
add wave -noupdate -radix unsigned /score_tb/wave_score
add wave -noupdate -radix unsigned /score_tb/r
add wave -noupdate -radix unsigned /score_tb/g
add wave -noupdate -radix unsigned /score_tb/b
add wave -noupdate -radix unsigned /score_tb/dut/prev_score
add wave -noupdate -radix unsigned /score_tb/dut/total_score
add wave -noupdate -radix binary -childformat {{{/score_tb/dut/digits[19]} -radix binary} {{/score_tb/dut/digits[18]} -radix binary} {{/score_tb/dut/digits[17]} -radix binary} {{/score_tb/dut/digits[16]} -radix binary} {{/score_tb/dut/digits[15]} -radix binary} {{/score_tb/dut/digits[14]} -radix binary} {{/score_tb/dut/digits[13]} -radix binary} {{/score_tb/dut/digits[12]} -radix binary} {{/score_tb/dut/digits[11]} -radix binary} {{/score_tb/dut/digits[10]} -radix binary} {{/score_tb/dut/digits[9]} -radix binary} {{/score_tb/dut/digits[8]} -radix binary} {{/score_tb/dut/digits[7]} -radix binary} {{/score_tb/dut/digits[6]} -radix binary} {{/score_tb/dut/digits[5]} -radix binary} {{/score_tb/dut/digits[4]} -radix binary} {{/score_tb/dut/digits[3]} -radix binary} {{/score_tb/dut/digits[2]} -radix binary} {{/score_tb/dut/digits[1]} -radix binary} {{/score_tb/dut/digits[0]} -radix binary}} -subitemconfig {{/score_tb/dut/digits[19]} {-radix binary} {/score_tb/dut/digits[18]} {-radix binary} {/score_tb/dut/digits[17]} {-radix binary} {/score_tb/dut/digits[16]} {-radix binary} {/score_tb/dut/digits[15]} {-radix binary} {/score_tb/dut/digits[14]} {-radix binary} {/score_tb/dut/digits[13]} {-radix binary} {/score_tb/dut/digits[12]} {-radix binary} {/score_tb/dut/digits[11]} {-radix binary} {/score_tb/dut/digits[10]} {-radix binary} {/score_tb/dut/digits[9]} {-radix binary} {/score_tb/dut/digits[8]} {-radix binary} {/score_tb/dut/digits[7]} {-radix binary} {/score_tb/dut/digits[6]} {-radix binary} {/score_tb/dut/digits[5]} {-radix binary} {/score_tb/dut/digits[4]} {-radix binary} {/score_tb/dut/digits[3]} {-radix binary} {/score_tb/dut/digits[2]} {-radix binary} {/score_tb/dut/digits[1]} {-radix binary} {/score_tb/dut/digits[0]} {-radix binary}} /score_tb/dut/digits
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2021 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {10658 ps}
