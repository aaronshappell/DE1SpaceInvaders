/*
enemy.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

/*
Encapsulates logic for an individual enemy in the game.
Handles sprite drawing, death detection, and end game detection.
*/
module enemy
	#(parameter FILE = "enemy1.txt", parameter W = 8, parameter H = 8)
	(clk, reset, frame, sx, sy, grid_x, grid_y, vga_x, vga_y, bx, by, b_hit, dead, pixel, gg);
	
	// Input and output logic
	input logic clk, reset, frame;
	input logic [9:0] sx, grid_x, vga_x, bx;
	input logic [8:0] sy, grid_y, vga_y, by;
	output logic b_hit, dead, pixel, gg;
	
	// Internal logic
	logic [W-1:0] data [2*H-1:0]; // sprite data for two frames
	logic [W-1:0] frame0 [H-1:0];
	logic [W-1:0] frame1 [H-1:0];
	logic [9:0] x;
	logic [8:0] y;
	logic color, intersects;
	
	// Read sprite data
	initial
		$readmemb(FILE, data);
	
	// Sprite instance
	sprite #(W, H) s (.clk, .reset, .x, .y, .vga_x, .vga_y, .data(frame ? frame1 : frame0), .color);
	
	// Assign frame data
	assign frame0 = data[H-1:0];
	assign frame1 = data[2*H-1:H];
	
	// Draw pixel if alive and colored
	assign pixel = color & ~dead;
	
	// Calc absolute x position based on the grid and setpoint
	assign x = grid_x + sx;
	assign y = grid_y + sy;
	
	// Intersection/end game detection
	assign intersects = (bx >= x && bx <= (x + W - 1)) && (by >= y && by <= (y + H - 1));
	assign gg = ~dead & (y >= 162);
	
	// Sequential DFF logic
	always_ff @(posedge clk) begin
		if(reset) begin
			dead <= 0;
			b_hit <= 0;
		end else if(vga_x == 240 && vga_y == 180) begin // Update enemy after frame drawn
			dead <= ~dead ? intersects : dead;
			b_hit <= ~dead & intersects;
		end
	end
endmodule

/*
Tests all possible inputs of the enemy module to verify the outputs and functionality.
*/
module enemy_tb();
	// Test logic
	logic clk, reset, frame;
	logic [9:0] sx, grid_x, vga_x, bx;
	logic [8:0] sy, grid_y, vga_y, by;
	logic b_hit, dead, pixel, gg;
	
	// Device under test
	enemy dut (.*);
	
	// Setup clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) clk <= ~clk;
	end
	
	// Test inputs
	initial begin
		reset <= 1; sx <= 10; sy <= 10; @(posedge clk);
		reset <= 0; bx <= 6; by <= 15; frame <= 0;
		for (int i = 0; i < 15; i++) begin	
			for(int row = 8; row < 20; row++) begin
				vga_y <= row;
				for(int col = 8; col < 20; col++) begin
					vga_x <= col; @(posedge clk);
				end
			end
			vga_x <= 240; vga_y <= 180; @(posedge clk);
		end
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule
