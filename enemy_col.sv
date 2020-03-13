/*
enemy_col.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

/*
Assembles a column of enemies via generate.
Manages overall left and right side detection for a column.
Calculates a score for a column based on dead enemies.
Manages timing and direction of movement for enemies.
*/
module enemy_col(clk, reset, left_in, right_in, sx, sy, vga_x, vga_y, bx, by, left, right, b_hit, move, pixel, gg, score);
	input logic clk, reset, left_in, right_in;
	input logic [9:0] sx, vga_x, bx;
	input logic [8:0] sy, vga_y, by;
	output logic left, right, b_hit, move, pixel, gg;
	output logic [10:0] score;

	// Internal logic
	logic [9:0] x;
	logic [8:0] y;
	logic [6:0] delay, delay_set, delay_interval;
	logic [4:0] pixels, b_hits, deads, ggs;
	logic dead, frame;
	
	// Generate enemies
	enemy #("enemy1.txt", 8, 8) smol (.clk, .reset, .frame, .sx(2), .sy(0), .grid_x(x), .grid_y(y), .vga_x, .vga_y, .bx, .by, .b_hit(b_hits[0]), .dead(deads[0]), .pixel(pixels[0]), .gg(ggs[0]));
	enemy #("enemy2.txt", 11, 8) bird1 (.clk, .reset, .frame, .sx(1), .sy(13), .grid_x(x), .grid_y(y), .vga_x, .vga_y, .bx, .by, .b_hit(b_hits[1]), .dead(deads[1]), .pixel(pixels[1]), .gg(ggs[1]));
	enemy #("enemy2.txt", 11, 8) bird2 (.clk, .reset, .frame, .sx(1), .sy(26), .grid_x(x), .grid_y(y), .vga_x, .vga_y, .bx, .by, .b_hit(b_hits[2]), .dead(deads[2]), .pixel(pixels[2]), .gg(ggs[2]));
	enemy #("enemy3.txt", 12, 8) octo1 (.clk, .reset, .frame, .sx(0), .sy(39), .grid_x(x), .grid_y(y), .vga_x, .vga_y, .bx, .by, .b_hit(b_hits[3]), .dead(deads[3]), .pixel(pixels[3]), .gg(ggs[3]));
	enemy #("enemy3.txt", 12, 8) octo2 (.clk, .reset, .frame, .sx(0), .sy(52), .grid_x(x), .grid_y(y), .vga_x, .vga_y, .bx, .by, .b_hit(b_hits[4]), .dead(deads[4]), .pixel(pixels[4]), .gg(ggs[4]));
	
	// Reduction of enemy outputs
	assign pixel = |pixels;
	assign b_hit = |b_hits;
	assign dead = &deads;
	assign gg = |ggs;
	
	// Edge detection
	assign left = (x <= 4) & ~dead;
	assign right = (x >= 228) & ~dead;
	
	// Update score
	assign score = deads[0] * 40 + deads[1] * 20 + deads[2] * 20 + deads[3] * 10 + deads[4] * 10;
	
	// States
	enum {IDLER, RIGHT, DOWNR, IDLEL, LEFT, DOWNL} ps, ns;
	
	// Next state logic
	always_comb begin
		case(ps)
			IDLER:
				if(delay == 0 && ~right_in)
					ns = RIGHT;
				else if(delay == 0 && right_in)
					ns = DOWNR;
				else
					ns = IDLER;
			RIGHT:
				ns = IDLER;
			DOWNR:
				ns = IDLEL;
			IDLEL:
				if(delay == 0 && ~left_in)
					ns = LEFT;
				else if(delay == 0 && left_in)
					ns = DOWNL;
				else
					ns = IDLEL;
			LEFT:
				ns = IDLEL;
			DOWNL:
				ns = IDLER;
		endcase
	end
	
	// Sequential DFF logic
	always_ff @(posedge clk) begin
		if(reset) begin
			ps <= IDLER;
			delay <= '1;
			delay_set <= '1;
			delay_interval <= '1;
			x <= sx + 2;
			y <= sy;
			frame <= 0;
			move <= 0;
		end else if(vga_x == 240 && vga_y == 180) begin // Update enemies after frame drawn
			// Update current state
			ps <= ns;
			
			// Update delay
			if (delay == 0)
				delay <= delay_set;
			else
				delay <= delay - 1'b1;
			
			// Update set delay
			delay_interval <= delay_interval - 1'b1;
			if(delay_interval == 0) begin
				if(delay_set > 0)
					delay_set <= delay_set - 1'b1;
			end
			
			// Update frame
			if(ps != IDLER && ps != IDLEL) begin
				frame <= ~frame;
				move <= 1'b1;
			end else begin
				move <= 0;
			end
			
			// Update grid position
			if (ps == LEFT)
				x <= x - 2;
			if (ps == RIGHT)
				x <= x + 2;
			if (ps == DOWNL || ps == DOWNR)
				y <= y + 8;
		end	
	end
endmodule
