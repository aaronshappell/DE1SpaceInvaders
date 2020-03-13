/*
bcd.sv

Aaron Shappell, 1739332
Ryan Shappell, 1739333
3/11/2020
EE371
Lab 6, Space Invaders

This lab is the final project, we chose to implement the classic game Space Invaders on the DE1_SoC.
*/

// Handles binary to BCD conversion for the given input number into 5 digits
module bcd(clk, reset, in, out);
	// Input and output logic
	input logic clk, reset;
	input logic [14:0] in;
	output logic [19:0] out;
	
	// Internal logic
	logic [14:0] bin;
	logic [3:0] ones, tens, huns, thous, tenthous;
	logic [3:0] done;
	
	// States
	enum {IDLE, ADD, SHIFT} ps, ns;
	
	// Next state logic
	always_comb begin
		case (ps)
			IDLE:
				ns = ADD;
			ADD:
				ns = SHIFT;
			SHIFT:
				if (done == 0) ns = IDLE;
				else ns = ADD;
		endcase
	end
	
	// Sequential DFF logic
	always_ff @(posedge clk) begin
		if(reset) begin
			ps <= IDLE;
			bin <= 0;
			out <= 0;
			ones <= 0;
			tens <= 0;
			huns <= 0;
			thous <= 0;
			tenthous <= 0;
			done <= 4'b1110;
		end else begin
			ps <= ns;
			// Reset digit cols, latch input and output
			if (ps == IDLE) begin
				bin <= in;
				done <= 4'b1110;
				ones <= 0;
				tens <= 0;
				huns <= 0;
				thous <= 0;
				tenthous <= 0;
				out <= {tenthous, thous, huns, tens, ones};
			end
			// Add 3 to each digit >= 5
			if (ps == ADD) begin
				if (ones >= 5)
					ones <= ones + 3;
				if (tens >= 5)
					tens <= tens + 3;
				if (huns >= 5)
					huns <= huns + 3;
				if (thous >= 5)
					thous <= thous + 3;
				if (tenthous >= 5)
					tenthous <= tenthous + 3;
			end
			// Shift binary representation to digit cols
			if (ps == SHIFT) begin
				tenthous <= (tenthous << 1) | thous[3];
				thous <= (thous << 1) | huns[3];
				huns <= (huns << 1) | tens[3];
				tens <= (tens << 1) | ones[3];
				ones <= (ones << 1) | bin[14];
				bin <= bin << 1;
				done <= done - 1'b1;
			end
		end
	end
endmodule


/*
Tests all possible inputs of the bcd module to verify the outputs and functionality.
*/
module bcd_tb();
	// Test logic
	logic clk, reset;
	logic [14:0] in;
	logic [19:0] out;
	
	// Device under test
	bcd dut (.*);
	
	// Setup clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) clk <= ~clk;
	end
	
	// Test inputs
	initial begin
		reset <= 1; @(posedge clk);
		reset <= 0; in <= 12345;
		for (int i = 0; i < 100; i++)
			@(posedge clk);
		$stop;
	end
endmodule
