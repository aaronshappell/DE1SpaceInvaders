# Create work library
vlib work

# INCLUDING MODULES
# All Verilog files that are part of this design should have
# their own "vlog" line below.
vlog "./player.sv"
vlog "./sprite.sv"

# SELECTING TESTBENCH
# Make sure the last item on the line is the name of the
# testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work player_testbench

# SELECTING WAVE FILE
# This should be the file that sets up the signal window for
# the module you are testing.
do player_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
