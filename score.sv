/*
score.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

/*
Manages a total cumulative score for the game.
Displays the current score on the VGA screen.
Updates the current score once a wave is cleared (win).
*/
module score (clk, reset, win, vga_x, vga_y, wave_score, r, g, b);
	// Input and Output logic
	input logic clk, reset, win;
	input logic [9:0] vga_x;
	input logic [8:0] vga_y;
	input logic [10:0] wave_score; // Max wave score is 1100
	output logic [7:0] r, g, b;
	
	// Internal logic
	logic [9:0] x;
	logic [8:0] y;
	logic [14:0] disp_score, total_score; // Max score is 32768
	logic [4:0] pixels;
	logic [19:0] digits;
	
	// Convert score value to BCD
	bcd converter (.clk, .reset, .in(disp_score), .out(digits));
	
	// Score display digits
	score_disp ones (.clk, .reset, .x(x+24), .y, .vga_x, .vga_y, .num(digits[3:0]), .pixel(pixels[0]));
	score_disp tens (.clk, .reset, .x(x+18), .y, .vga_x, .vga_y, .num(digits[7:4]), .pixel(pixels[1]));
	score_disp thous (.clk, .reset, .x(x+12), .y, .vga_x, .vga_y, .num(digits[11:8]), .pixel(pixels[2]));
	score_disp tenthous (.clk, .reset, .x(x+6), .y, .vga_x, .vga_y, .num(digits[15:12]), .pixel(pixels[3]));
	score_disp hunthous (.clk, .reset, .x, .y, .vga_x, .vga_y, .num(digits[19:16]), .pixel(pixels[4]));
	
	// Get current rgb via reduction of pixels
	assign r = {8{|pixels}};
	assign g = {8{|pixels}};
	assign b = {8{|pixels}};
	
	// Display score
	assign disp_score = total_score + wave_score;
	
	// Sequential DFF logic
	always_ff @(posedge clk) begin
		if (reset) begin
			x <= 0;
			y <= 0;
			total_score <= 0;
		end else if(win) // Update total score in wave won
			total_score <= total_score + wave_score;
	end
endmodule

/*
Tests all possible inputs of the score module to verify the outputs and functionality.
*/
module score_tb();
	// Test logic
	logic clk, reset, win;
	logic [9:0] vga_x;
	logic [8:0] vga_y;
	logic [10:0] wave_score; // Max wave score is 1100
	logic [7:0] r, g, b;
	
	// Device under test
	score dut (.*);
	
	// Setup clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) clk <= ~clk;
	end
	
	// Test inputs
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; wave_score <= 1024; @(posedge clk);
		for(int row = 0; row < 10; row++) begin
			vga_y <= row;
			for(int col = 0; col < 10; col++) begin
				vga_x <= col; @(posedge clk);
			end
		end
		$stop;
	end
endmodule
