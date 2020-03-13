/*
music.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

/*
Generates encoded audio samples for the music of space invaders.
Each of the 4 note sequence is played for 0.1s and is synchronized with enemy movement.
C2 -> B1 -> B1b -> A1
*/
module music(clk, reset, en, move, note);
	// Input and output logic
	input logic clk, reset, en, move;
	output logic signed [23:0] note;
	
	// Internal logic
	logic move_next, next;
	logic signed [23:0] cur_note;
	logic [18:0] freq;
	logic [22:0] delay;

	// States for note sequence
	enum {N1, N2, N3, N4} ps, ns;
	
	// Next note logic
	always_comb begin
		case(ps)
			N1:
				if(next) ns = N2;
				else ns = N1;
			N2:
				if(next) ns = N3;
				else ns = N2;
			N3:
				if(next) ns = N4;
				else ns = N3;
			N4:
				if(next) ns = N1;
				else ns = N4;
		endcase
	end
	
	// Play next note on rising edge of enemy movement
	assign next = move & ~move_next;
	
	// Sequential DFF logic
	always_ff @(posedge clk) begin
		if(reset) begin
			ps <= N1;
			note <= '0;
			cur_note <= {1'b0, {7{1'b1}}, 16'b0}; // Set initial note
			freq <= 382205;
			delay <= 5000000;
		end else begin
			// Update state
			ps <= ns;
			move_next <= move;
			// Update current note based on delay
			freq <= freq - 1'b1;
			if(freq == 0) begin
				cur_note <= -cur_note;
				// Set delay for current note
				case(ps)
					N1: freq <= 382205; // C2
					N2: freq <= 404924; // B1
					N3: freq <= 429037; // B1b
					N4: freq <= 454545; // A1
				endcase
			end
			// Update note delay
			if(delay > 0)
				delay <= delay - 1'b1;
			// Reset note delay for next note
			if(ns != ps)
				delay <= 5000000;
			// Update note output when enabled
			if(en) begin
				note <= delay ? cur_note : 0;
			end
		end
	end
endmodule
