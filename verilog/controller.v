module controller(
	input clk,
	input reset,
	output reg en_xpos,
	output reg [1:0] s_xpos,

	output reg en_ypos,
	output reg [1:0] s_ypos,
	output reg en_key,
	output reg s_key,
	output reg en_obs,
	output reg [2:0] s_obs,
	/*
	output reg en_win,
	output reg s_win,
	*/
	output reg [1:0] s_color,
	output reg plot,
	output reg en_timer,
	output reg s_timer,
    output reg en_clockt,
    output reg s_clockt,
	/*
	input [2:0] move,
	input [99:0] timer,
	input [99:0] xpos,
	input [99:0] ypos,
	input [23:0] key,
	input win,
	input obs_black,
	*/
	input win,
	input timer_done,
	input [2:0] move,
	input obs_wall,
	input obs_lava,
	input obs_ice,
	input unfrozen,
	
	output [4:0] state_cur
	);

	parameter NONE = 3'd0;
	parameter LEFT = 3'd1;
	parameter RIGHT = 3'd2;
	parameter UP = 3'd3;
	parameter DOWN = 3'd4;

	parameter INIT = 5'd0;
	parameter WAIT_TIMER = 5'd1;
	parameter ERASE = 5'd2;
	parameter READ_KEY = 5'd3;
	parameter UPDATE_OBS_MEM = 5'd4;
	parameter WAIT_OBS_MEM = 5'd5;
	parameter TEST_OBS = 5'd6;
	parameter RESTART = 5'd7;
	parameter FROZEN = 5'd8;
	
	parameter INC_XPOS = 5'd15;
	parameter DEC_XPOS = 5'd16;
	parameter INC_YPOS = 5'd17;
	parameter DEC_YPOS = 5'd18;
	parameter CHECK_WIN = 5'd19;
	parameter DRAW = 5'd20;
	parameter WIN = 5'd21;
	parameter INIT_RESET = 5'd22;
	parameter INIT_SET_END_PIXEL = 5'd23;

	
	reg [4:0] state, next_state;
	assign state_cur = state;

	always @(posedge clk)
		if (reset)
			state <= INIT_RESET;
		else
			state <= next_state;

	always @(*) begin
		/*
		en_win = 0;
		s_win = 0;
		*/
		plot = 0;
		s_color = 0;
		en_timer = 0;
		s_timer = 0;
		en_xpos = 0;
		s_xpos = 0;
		en_ypos = 0;
		s_ypos = 0;
		en_key = 0;
		s_key = 0;
		en_obs = 0;
		s_obs = 0;
      en_clockt = 1;
      s_clockt = 1;
		next_state = INIT_RESET;
		case (state)
			INIT_RESET: begin
				plot = 1; 		s_color = 0;
				en_xpos = 1;	s_xpos = 3;
				en_ypos = 1;	s_ypos = 3;
				
				next_state = INIT_SET_END_PIXEL;
			end
			INIT_SET_END_PIXEL: begin
				plot = 1; s_color = 3;
				
				next_state = INIT;
			end
			INIT: begin
				en_timer = 1;	s_timer = 0;
				en_xpos = 1;	s_xpos = 0;
				en_ypos = 1;	s_ypos = 0;
				en_key = 1;		s_key = 0;
				en_obs = 1;		s_obs = 0;
									s_clockt = 0;
				
				next_state = WAIT_TIMER;
			end
			WAIT_TIMER: begin
				en_timer = 1; 	s_timer = 1;
				
				if (timer_done)
					next_state = ERASE;
				else
					next_state = WAIT_TIMER;
			end
			ERASE: begin
				plot = 1; 		s_color = 0;
				en_timer = 1; 	s_timer = 0;
				
				next_state = READ_KEY;
			end
			READ_KEY: begin
				en_key = 1; 	s_key = 1;
				
				next_state = UPDATE_OBS_MEM;
			end
			UPDATE_OBS_MEM: begin
				en_obs = 1; s_obs = move;
				
				next_state = WAIT_OBS_MEM;
			end
			WAIT_OBS_MEM: begin
				next_state = TEST_OBS;
			end
			TEST_OBS: begin
				if (obs_wall)
					next_state = DRAW;
				else if (obs_lava)
					next_state = RESTART;
				else if (obs_ice)
					next_state = FROZEN;
				else
					case (move)
						3'd0:	next_state = DRAW;
						3'd1: next_state = DEC_XPOS;
						3'd2: next_state = INC_XPOS;
						3'd3: next_state = DEC_YPOS;
						3'd4:	next_state = INC_YPOS;
						default: next_state = DRAW;
					endcase
			end
			RESTART: begin
				en_xpos = 1;	s_xpos = 0;
				en_ypos = 1;	s_ypos = 0;
				
				next_state = DRAW;
			end
			FROZEN: begin
				en_timer = 1; 	s_timer = 1;
				plot = 1;		s_color = 2;
				
				if (unfrozen)
					next_state = WAIT_TIMER;
				else
					next_state = FROZEN;
			end
			INC_XPOS: begin
				en_xpos = 1; s_xpos = 1;
				
				next_state = DRAW;
			end
			DEC_XPOS: begin
				en_xpos = 1; s_xpos = 2;
				
				next_state = DRAW;
			end
			INC_YPOS: begin
				en_ypos = 1; s_ypos = 1;
				
				next_state = DRAW;
			end
			DEC_YPOS: begin
				en_ypos = 1; s_ypos = 2;
				
				next_state = DRAW;
			end
			DRAW: begin
				plot = 1; 		s_color = 1;
				
				if (win)
					next_state = WIN;
				else
					next_state = WAIT_TIMER;
			end
			WIN: begin
				en_clockt = 0;
				plot = 1;		s_color = 0;
				next_state = WIN;
			end
			default :;
		endcase
	end

endmodule
