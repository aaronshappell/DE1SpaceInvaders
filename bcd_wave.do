onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /bcd_tb/clk
add wave -noupdate /bcd_tb/reset
add wave -noupdate /bcd_tb/in
add wave -noupdate /bcd_tb/out
add wave -noupdate /bcd_tb/dut/bin
add wave -noupdate /bcd_tb/dut/ones
add wave -noupdate /bcd_tb/dut/tens
add wave -noupdate /bcd_tb/dut/huns
add wave -noupdate /bcd_tb/dut/thous
add wave -noupdate /bcd_tb/dut/tenthous
add wave -noupdate /bcd_tb/dut/done
add wave -noupdate /bcd_tb/dut/ps
add wave -noupdate /bcd_tb/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7250 ps} 0}
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
WaveRestoreZoom {0 ps} {10553 ps}
