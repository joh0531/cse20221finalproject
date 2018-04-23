module datapath (
	input clk,
	input [7:0] keycode,
	input 		key_make,
	input			key_ext,
	/*
	input en_move,
	input [2:0] s_move,
	*/
	input en_xpos,
	input [1:0] s_xpos,
	input en_ypos,
	input [1:0] s_ypos,
	input en_key,
	input s_key,
	/*
	input en_win,
	input s_win,
	input en_obs,
	input [1:0] s_obs,
	*/
	input s_color,
	input plot,
	input en_timer,
	input s_timer,
	
	//outputs
	output reg [7:0] xpos,
	output reg [7:0] ypos,
	output [2:0] color_draw,
	
	//flags
	output [2:0] move,
	/*
	output obs_black,
	output did_win
	*/
	output timer_done
);

	parameter BLACK = 3'b000;
	parameter RED	 = 3'b100;
	parameter GREEN = 3'b010;
	
	parameter TIMER_LIMIT = 26'd10_000_000;
	
	parameter INIT_X = 8'd80;
	parameter INIT_Y = 8'd80;
	
	parameter KEY_LEFT = 8'h6b;
	parameter KEY_RIGHT = 8'h74;
	parameter KEY_UP = 8'h75;
	parameter KEY_DOWN = 8'h72;
	
	reg [25:0] timer;
	
	reg [7:0] key;

	/*
	//move stage
	always @(posedge clk)
	if (en_move)
	move <= s_move;
	*/
	
	//timer stage
	always @(posedge clk)
		if (en_timer)
			if (s_timer)
				timer <= timer + 1;
			else
				timer <= 0;
	
	//xpos stage
	always @(posedge clk)
		if (en_xpos)
			case (s_xpos)
				0: xpos <= INIT_X;
				1: xpos <= xpos + 1;
				2: xpos <= xpos - 1;
				default: xpos <= INIT_X;
			endcase
			
	//ypos stage
	always @(posedge clk)
		if (en_ypos)
			case (s_ypos)
				0: ypos <= INIT_Y;
				1: ypos <= ypos + 1;
				2: ypos <= ypos - 1;
				default: ypos <= INIT_Y;
			endcase
		
	//key stage
	always @(posedge clk)
		if (en_key)
			if (s_key && key_ext) begin //&& key_make?
				key <= keycode;
			end
			else begin
				key <= 0;
			end
			
	assign move =
			key == KEY_LEFT ? 3'd1 :
			key == KEY_RIGHT ? 3'd2 :
			key == KEY_UP ? 3'd3 :
			key == KEY_DOWN ? 3'd4 :
			0;
				
		
	// vga stage
	assign color_draw = (s_color ? RED : BLACK);
				
	//FLAGS
	assign timer_done = (timer == TIMER_LIMIT);
	

endmodule
