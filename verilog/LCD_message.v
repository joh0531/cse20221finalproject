module LCD_message(
	input clk,
	input [4:0] raddr,
	input [8:0] t,
	output [7:0] dout);

	// creates the message to be displayed on the LCD display
	// displays the current score and the switch pattern
	reg [7:0] m [0:31];
    wire [5:0] sec = t % 60;
    wire [2:0] min = t / 60;
	
	assign dout = m[raddr];

    parameter MIN_ADDR = 8'h10;
    parameter SEC_ADDR1 = 8'h16;
    parameter SEC_ADDR0 = 8'h17;
	
	initial begin
		m[8'h00] = "T";
		m[8'h01] = "I";
		m[8'h02] = "M";
		m[8'h03] = "E";
		m[8'h04] = ":";
		m[8'h05] = " ";
		m[8'h06] = " ";
		m[8'h07] = " ";
		m[8'h08] = " ";
		m[8'h09] = " ";
		m[8'h0a] = " ";
		m[8'h0b] = " ";
		m[8'h0c] = " ";
		m[8'h0d] = " ";
		m[8'h0e] = " ";
		m[8'h0f] = " ";
		// Line 2
		m[8'h10] = " ";
		m[8'h11] = " ";
		m[8'h12] = "M";
		m[8'h13] = "I";
		m[8'h14] = "N";
		m[8'h15] = " ";
		m[8'h16] = " ";
		m[8'h17] = " ";
		m[8'h18] = " ";
		m[8'h19] = "S";
		m[8'h1a] = "E";
		m[8'h1b] = "C";
		m[8'h1c] = " ";
		m[8'h1d] = " ";
		m[8'h1e] = " ";
		m[8'h1f] = " ";
	end
		
	always @(posedge clk) begin
         m[MIN_ADDR] = min;
         m[SEC_ADDR1] = sec / 10;
         m[SEC_ADDR0] = sec % 10;
	end

endmodule
