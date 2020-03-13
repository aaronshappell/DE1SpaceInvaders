/*
sprite.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

/*
Displays a sprite on the VGA screen with the given data and parameterized size.
Only draws pixels if the vga x and y are within the sprite bounds.
*/
module sprite #(parameter W = 8, parameter H = 8)(clk, reset, x, y, vga_x, vga_y, data, color);
	// Input and output logic
	input logic clk, reset;
	input logic [9:0] x, vga_x;
	input logic [8:0] y, vga_y;
	input logic [W-1:0] data [H-1:0];
	output logic color;
	
	// Internal logic
	logic draw;
	
	// Check if drawing is valid for the current pixel
	assign draw = (vga_x >= x && vga_x <= (x + W - 1)) && (vga_y >= y && vga_y <= (y + H - 1));
	// Get color data for given pixel
	assign color = draw ? data[vga_y - y][vga_x - x] : 1'b0;
endmodule

/*
Tests all possible inputs of the sprite module to verify the outputs and functionality.
*/
module sprite_tb();
	// Test logic
	parameter W = 4;
	parameter H = 4;
	
	logic clk, reset;
	logic [9:0] x, vga_x;
	logic [8:0] y, vga_y;
	logic [W-1:0] data [H-1:0];
	logic color;
	
	// Device under test
	sprite #(W, H) dut (.*);
	
	// Setup clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) clk <= ~clk;
	end
	
	// Test inputs
	initial begin
		reset <= 1;
		data <= {{1'b1,1'b0,1'b0,1'b0}, {1'b0,1'b1,1'b0,1'b0}, {1'b0,1'b0,1'b1,1'b0}, {1'b0,1'b0,1'b0,1'b1}};
		x <= 4; y <= 4;
		vga_x <= 0; vga_y <= 0;
		@(posedge clk);
		reset <= 0;
		@(posedge clk);
		for(int row = 0; row < 10; row++) begin
			vga_y <= row;
			for(int col = 0; col < 10; col++) begin
				vga_x <= col; @(posedge clk);
			end
		end
		@(posedge clk);
		$stop;
	end
endmodule
