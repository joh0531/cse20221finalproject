module processor (
   input          clk,
   input          reset,
	input	 [7:0]   keycode,
	input				key_make,
	input				key_ext,
	
	input  [2:0] 	color_obs,
	output [7:0] 	x,
	output [7:0] 	y,
	output [2:0] 	color_draw,
	output 			plot,
	output [4:0]	state,
	output [2:0]   move
   );

   
	wire s_color;
	
	wire en_timer;
	wire s_timer;
	
	wire timer_done;
	
	wire en_xpos;
	wire en_ypos;
	wire [1:0] s_xpos;
	wire [1:0] s_ypos;

	
	wire en_key;
	wire s_key;
	
   controller controller (
      .clk           (clk        ),
      .reset         (reset      ),
		.s_color			(s_color		),
		.plot				(plot			),
		.en_timer		(en_timer	),
		.s_timer			(s_timer		),
		.en_xpos			(en_xpos		),
		.s_xpos			(s_xpos		),
		.en_ypos			(en_ypos		),
		.s_ypos			(s_ypos		),
		.en_key			(en_key		),
		.s_key			(s_key		),
		
		//FLAGS
		.timer_done		(timer_done	),
		.move				(move			),
		
		.state_cur		(state		)
   );
   
   datapath datapath (
      .clk           (clk        ),
		.keycode			(keycode		),
		.key_make		(key_make	),
		.key_ext			(key_ext		),
		
		.s_color			(s_color		),
		.plot				(plot			),
		.en_timer		(en_timer	),
		.s_timer			(s_timer		),
		.en_xpos			(en_xpos		),
		.s_xpos			(s_xpos		),
		.en_ypos			(en_ypos		),
		.s_ypos			(s_ypos		),
		.en_key			(en_key		),
		.s_key			(s_key		),
		
		.xpos				(x				),
		.ypos				(y				),
		.color_draw		(color_draw	),
		
		.timer_done		(timer_done),
		.move				(move)
   );
   
endmodule
