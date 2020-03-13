/*
DE1_SoC.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

/*
Overall module to interact and run space invaders on the DE1_SoC board
via VGA video output, with encoded audio output, and key inputs for the player.
*/
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW,
					 CLOCK_50, CLOCK2_50, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS,
					 FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);
	// Input and output logic
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	input CLOCK_50, CLOCK2_50;
	// VGA signals
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	
	logic read_ready, write_ready, read, write;
	logic signed [23:0] readdata_left, readdata_right;
	logic signed [23:0] writedata_left, writedata_right;

	// Internal logic
	logic reset, b_hit, move, wave_reset, gg;
	logic [9:0] x, bx;
	logic [8:0] y, by;
	logic [7:0] r, r_eg, r_p, r_s;
	logic [7:0] g, g_eg, g_p, g_s;
	logic [7:0] b, b_eg, b_p, b_s;
	logic signed [23:0] note;
	logic [10:0] score;
	
	// VGA driver module
	video_driver #(.WIDTH(240), .HEIGHT(180))
		v1 (.CLOCK_50, .reset(SW[1]), .x, .y, .r, .g, .b,
			 .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N,
			 .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
	/////////////////////////////////////////////////////////////////////////////////
	// Audio CODEC interface. 
	//
	// The interface consists of the following wires:
	// read_ready, write_ready - CODEC ready for read/write operation 
	// readdata_left, readdata_right - left and right channel data from the CODEC
	// read - send data from the CODEC (both channels)
	// writedata_left, writedata_right - left and right channel data to the CODEC
	// write - send data to the CODEC (both channels)
	// AUD_* - should connect to top-level entity I/O of the same name.
	//         These signals go directly to the Audio CODEC
	// I2C_* - should connect to top-level entity I/O of the same name.
	//         These signals go directly to the Audio/Video Config module
	/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		1'b0,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		1'b0,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		1'b0,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);
	
	// Instantiate design components
	enemy_grid eg (.clk(CLOCK_50), .reset(reset | wave_reset), .vga_x(x), .vga_y(y), .bx, .by, .b_hit, .move, .r(r_eg), .g(g_eg), .b(b_eg), .score, .gg);
	player p (.clk(CLOCK_50), .reset, .left(~KEY[1]), .right(~KEY[0]), .shoot(~KEY[3]), .b_hit, .vga_x(x), .vga_y(y), .r(r_p), .g(g_p), .b(b_p), .bx, .by);
	music m (.clk(CLOCK_50), .reset, .en(read), .move, .note);
	score s (.clk(CLOCK_50), .reset, .win(wave_reset), .vga_x(x), .vga_y(y), .wave_score(score), .r(r_s), .g(g_s), .b(b_s));
	
	assign reset = SW[0] | gg;
	
	// Assign overall rgb value
	assign r = r_eg | r_p | r_s;
	assign g = g_eg | g_p | g_s;
	assign b = b_eg | b_p | b_s;
	
	// Only read or write when both are possible
	assign read = read_ready & write_ready;
	assign write = read_ready & write_ready;
	
	// Assign audio data (mono to both channels)
	assign writedata_left = note;
	assign writedata_right = note;
	
	// Reset wave once cleared
	assign wave_reset = (score == 1100);
	
	// Unused outputs
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
endmodule
