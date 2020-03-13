/*
enemy_grid.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

/*
Assembles a full grid of enemies via generated columns
*/
module enemy_grid(clk, reset, vga_x, vga_y, bx, by, b_hit, move, r, g, b, score, gg);
	// Input and output logic
	input logic clk, reset;
	input logic [9:0] vga_x, bx;
	input logic [8:0] vga_y, by;
	output logic b_hit, move, gg;
	output logic [7:0] r, g, b;
	output logic [10:0] score;

	// Internal logic
	logic left, right;
	logic [10:0] lefts, rights, b_hits, moves, pixels, ggs;
	logic [10:0] scores [10:0];
	
	// Generate enemy cols
	genvar col;
	generate
		for(col = 0; col < 11; col++) begin : cols
			enemy_col e_col (.clk, .reset, .left_in(left), .right_in(right), .sx(5+col*15), .sy(8), .vga_x, .vga_y, .bx, .by, .left(lefts[col]), .right(rights[col]), .b_hit(b_hits[col]), .move(moves[col]), .pixel(pixels[col]), .score(scores[col]), .gg(ggs[col]));
		end
	endgenerate
	
	// Edge detection
	assign left = |lefts;
	assign right = |rights;
	
	// Update score
	assign score = scores.sum();
	
	// End game detection
	assign gg = |ggs;
	
	// Get current rgb via reduction of pixels
	assign r = {8{|pixels}};
	assign g = {8{|pixels}};
	assign b = {8{|pixels}};
	
	// Bullet hit reduction of enemies
	assign b_hit = |b_hits;
	
	// Enemy movement detection
	assign move = |moves;
endmodule

/*
Tests all possible inputs of the enemy_grid module to verify the outputs and functionality.
*/
module enemy_grid_tb();
	// Test logic
	logic clk, reset, b_hit, move, gg;
	logic [9:0] vga_x, bx;
	logic [8:0] vga_y, by;
	logic [7:0] r, g, b;
	logic [10:0] score;
	
	// Device under test
	enemy_grid dut(.*);
	
	// Setup clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) clk <= ~clk;
	end
	
	// Test inputs
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; bx <= 0; by <= 0;
		for (int frame = 0; frame < 2; frame++) begin	
			for(int row = 8; row < 20; row++) begin
				vga_y <= row;
				for(int col = 8; col < 40; col++) begin
					vga_x <= col; @(posedge clk);
				end
			end
			vga_x <= 240; vga_y <= 180; @(posedge clk);
		end
		@(posedge clk);
		$stop;
	end
endmodule
