module datapath (
	input clk,
	input [7:0] keycode,
	input 		key_make,
	input			key_ext,
	input	[2:0]	obs_mem,
	input			trail,
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
	input en_obs,
	input [2:0] s_obs,
	/*
	input en_win,
	input s_win,
	*/
	input [1:0] s_color,
	input plot,
	input en_timer,
	input s_timer,
	
	//outputs
	output reg [7:0] xpos,
	output reg [6:0] ypos,
	output reg [7:0] obs_x,
	output reg [6:0] obs_y,
	output [2:0] color_draw,
	
	//flags
	output [2:0] move,
	output obs_wall,
	output obs_lava,
	output obs_ice,
	output unfrozen,
	output win,
	output timer_done,

   input en_clockt,
   input s_clockt,
   output [8:0] t
);

	parameter BLACK = 3'b000;
	parameter WHITE = 3'b111;
	
	parameter RED	 = 3'b100;
	parameter GREEN = 3'b010;
	parameter BLUE  = 3'b001;
	
	parameter PURPLE = 3'b101;
	parameter TEAL   = 3'b011;
	parameter YELLOW = 3'b110;
	
	parameter TIMER_LIMIT = 26'd2_500_000;
	parameter UNFROZEN_LIMIT = 26'd50_000_000;
	
	parameter INIT_X = 8'h86;
	parameter INIT_Y = 8'h77;
	
	parameter END_X = 8'h8E;
	parameter END_Y = 8'h77;
	
	parameter KEY_LEFT = 8'h6b;
	parameter KEY_RIGHT = 8'h74;
	parameter KEY_UP = 8'h75;
	parameter KEY_DOWN = 8'h72;
	
	reg [25:0] timer;
    reg [33:0] clockt;
	
	reg [7:0] key;

    assign t = clockt / 26'd50_000_000;

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

    always @(posedge clk)
        if (en_clockt)
            if (s_clockt)
                clockt <= clockt + 1;
            else
                clockt <= 0;
	
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
			if (s_key && key_ext && key_make) begin
				key <= keycode;
			end
			else begin
				key <= 0;
			end
			
	// obs stage
	always @(posedge clk)
		if (en_obs)
			case (s_obs)
				0:	begin obs_x <= xpos; 	 obs_y <= ypos; end
				1:	begin obs_x <= xpos - 1; obs_y <= ypos; end
				2:	begin obs_x <= xpos + 1; obs_y <= ypos; end
				3:	begin obs_x <= xpos; 	 obs_y <= ypos - 1; end
				4: begin obs_x <= xpos;		 obs_y <= ypos + 1; end
				default:begin obs_x <= xpos;obs_y <= ypos; end
			endcase
			
	assign move =
			key == KEY_LEFT ? 3'd1 :
			key == KEY_RIGHT ? 3'd2 :
			key == KEY_UP ? 3'd3 :
			key == KEY_DOWN ? 3'd4 :
			0;
				
		
	// vga stage
	assign color_draw = (
			s_color == 2'd1 ? GREEN :
			s_color == 2'd2 ? BLUE :
			trail ? PURPLE : PURPLE
	);
				
	//FLAGS
	assign timer_done = (timer == TIMER_LIMIT);
	
	assign obs_wall = (obs_mem == BLACK);
	assign obs_lava = (obs_mem == RED);
	assign obs_ice  = (obs_mem == BLUE);
	
	assign unfrozen =	(timer == UNFROZEN_LIMIT);
	
	assign win = ((xpos == END_X) && (ypos == END_Y));
	

endmodule
