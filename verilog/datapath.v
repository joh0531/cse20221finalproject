module datapath (
	input clk,
	input en_move,
	input [2:0] s_move,
input en_timer,
	input s_timer,
	input en_xpos,
	input [1:0] s_xpos,
	input en_ypos,
	input [1:0] s_ypos,
	input en_key,
	input [2:0] s_key,
	input en_win,
	input s_win,
	input en_obs,
	input [1:0] s_obs,
	input s_color,
	input plot,
	
	//outputs
	output reg [99:0] xpos,
	output reg [99:0] ypos,
	output reg [23:0] key,

	//flags
	output timer_done,
	output obs_black,
	output did_win
);

	

	//move stage
	always @(posedge clk)
	if (en_move)
	move <= s_move;

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
	case s_xpos
		0: xpos <= init_xpos;
		1: xpos <= xpos + 1;
		2: xpos <= xpos - 1;
	endcase
	//ypos stage
	always @(posedge clk)
	if (en_ypos)
	case s_ypos
		0: ypos <= init_ypos;
		1: ypos <= ypos + 1;
		2: ypos <= ypos - 1;
	endcase

	assign timer_done = (timer == 1 << 19);
	assign obs_black = 
	

endmodule
