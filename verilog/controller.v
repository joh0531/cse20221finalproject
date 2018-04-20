module controller(
	input clk,
	input reset,
	/*
	output reg en_xpos,
	output reg [1:0] s_xpos,
	output reg en_ypos,
	output reg [1:0] s_ypos,

	output reg en_move,
	output reg [2:0] s_move,
	output reg en_key,
	output reg [2:0] s_key,
	output reg en_obs,
	output reg [1:0] s_obs,
	output reg en_win,
	output reg s_win,
	*/
	output reg s_color,
	output reg plot,
	output reg en_timer,
	output reg s_timer,
	/*
	input [2:0] move,
	input [99:0] timer,
	input [99:0] xpos,
	input [99:0] ypos,
	input [23:0] key,
	input win,
	input ObsMemOut,
	input obs_black,
	input did_win
	*/
	input timer_done,
	
	output [4:0] state_cur
	);

	parameter NONE = 3'd0;
	parameter LEFT = 3'd1;
	parameter RIGHT = 3'd2;
	parameter UP = 3'd3;
	parameter DOWN = 3'd4;

	parameter KEY_NONE = 3'd0;
	parameter KEY_LEFT = 3'd1;
	parameter KEY_RIGHT = 3'd2;
	parameter KEY_UP = 3'd3;
	parameter KEY_DOWN = 3'd4;

	parameter INIT = 5'd0;
	parameter WAIT_TIMER = 5'd1;
	parameter ERASE = 5'd2;
	parameter READ_KEY = 5'd3;
	parameter UPDATE_MOVE = 5'd4;
	parameter SET_MOVE_LEFT = 5'd5;
	parameter SET_MOVE_RIGHT = 5'd6;
	parameter SET_MOVE_UP = 5'd7;
	parameter SET_MOVE_DOWN = 5'd8;
	parameter LOOK_LEFT = 5'd9;
	parameter LOOK_RIGHT = 5'd10;
	parameter LOOK_UP = 5'd11;
	parameter LOOK_DOWN = 5'd12;
	parameter TEST_OB = 5'd13;
	parameter UPDATE_POS = 5'd14;
	parameter INC_XPOS = 5'd15;
	parameter DEC_XPOS = 5'd16;
	parameter INC_YPOS = 5'd17;
	parameter DEC_YPOS = 5'd18;
	parameter CHECK_WIN = 5'd19;
	parameter DRAW = 5'd20;
	parameter WIN = 5'd21;

	
	reg [4:0] state, next_state;
	assign state_cur = state;

	always @(posedge clk)
		if (reset)
			state <= INIT;
		else
			state <= next_state;

	always @(*) begin
		/*
		en_move = 0;
		s_move = 0;
		en_xpos = 0;
		s_xpos = 0;
		en_ypos = 0;
		s_ypos = 0;
		en_key = 0;
		s_key = 0;
		en_obs = 0;
		s_obs = 0;
		en_win = 0;
		s_win = 0;
		*/
		plot = 0;
		s_color = 0;
		en_timer = 0;
		s_timer = 0;
		next_state = INIT;
		case (state)
			INIT: begin
				en_timer = 1;	s_timer = 0;
				
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
				
				next_state = DRAW;
			end
			DRAW: begin
				plot = 1; s_color = 1;
				
				next_state = WAIT_TIMER;
			end
		endcase
	end

endmodule
