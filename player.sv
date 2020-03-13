/*
player.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

/*
Encapsulates player drawing and movement logic.
Also manages bullet initialization and movement for shooting.
*/
module player (clk, reset, left, right, shoot, b_hit, vga_x, vga_y, r, g, b, bx, by);
	// Input and output logic
	input logic clk, reset, left, right, shoot, b_hit;
	input logic [9:0] vga_x;
	input logic [8:0] vga_y;
	output logic [7:0] r, g, b;
	output logic [9:0] bx;
	output logic [8:0] by;
	
	// Internal logic
	logic [10:0] data [7:0];
	logic b_data [2:0];
	logic [9:0] x;
	logic [8:0] y;
	logic color, b_color;
	logic delay;
	
	// Read sprite data
	initial begin
		$readmemb("player.txt", data);
		$readmemb("bullet.txt", b_data);
	end
	
	// Player sprite instance
	sprite #(11, 8) s (.clk, .reset, .x, .y, .vga_x, .vga_y, .data, .color);
	// Bullet sprite instance
	sprite #(1, 3) bs (.clk, .reset, .x(bx), .y(by), .vga_x, .vga_y, .data(b_data), .color(b_color));
	
	// Get player/bullet rgb values
	assign r = '1 & {8{b_color && ps != IDLE}};
	assign g = '1 & {8{color | (ps != IDLE && b_color)}};
	assign b = '1 & {8{b_color && ps != IDLE}};
	
	// States
	enum {IDLE, SHOOT, SHOOTING} ps, ns;
	
	// Next state logic
	always_comb begin
		case (ps)
			IDLE:
				if (shoot) ns = SHOOT;
				else ns = IDLE;
			SHOOT:
				ns = SHOOTING;
			SHOOTING:
				if (b_hit || (by == 0)) ns = IDLE;
				else ns = SHOOTING;
		endcase
	end
	
	// Sequential DFF logic
	always_ff @(posedge clk) begin
		if (reset) begin
			ps <= IDLE;
			delay <= 1'b1;
			x <= 120;
			y <= 170;
			bx <= 0;
			by <= 180;
		end else if(vga_x == 240 && vga_y == 180) begin // Update player/bullet after frame drawn
			ps <= ns;
			// Update movement delay
			if (delay == 0)
				delay <= 1'b1;
			else
				delay <= delay - 1'b1;
			
			// Player movement
			if (left && ~right && x > 0 && delay == 0)
				x <= x - 1'b1;
			if (~left && right && x < 228 && delay == 0)
				x <= x + 1'b1;
			
			// Update bullet position
			if (ps == IDLE) begin
				bx <= 0;
				by <= 180;
			end
			if (ps == SHOOT) begin
				bx <= x + 5;
				by <= y - 4;
			end
			if (ps == SHOOTING)
				by <= by - 1'b1;
		end
	end
endmodule

/*
Tests all possible inputs of the player module to verify the outputs and functionality.
*/
module player_testbench();
	// Test logic
	logic clk, reset, left, right, shoot, b_hit;
	logic [9:0] vga_x;
	logic [8:0] vga_y;
	logic [7:0] r, g, b;
	logic [9:0] bx;
	logic [8:0] by;
	
	// Device under test
	player dut (.*);
	
	// Setup clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) clk <= ~clk;
	end
	
	// Test inputs
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0;
		left <= 0; right <= 1; shoot <= 0; b_hit <= 0; @(posedge clk);
		for (int frame = 0; frame < 15; frame++) begin
			for (int i = 0; i < 15; i++) begin
				vga_y <= i;
				for (int j = 0; j < 15; j++) begin
					vga_x <= j; @(posedge clk);
				end
			end
		end
		
		left <= 1; right <= 0;
		for (int frame = 0; frame < 15; frame++) begin
			for (int i = 0; i < 15; i++) begin
				vga_y <= i;
				for (int j = 0; j < 15; j++) begin
					vga_x <= j; @(posedge clk);
				end
			end
		end
		$stop;
	end
endmodule
