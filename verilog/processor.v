module processor (
   input          clk,
   input          reset,
	input	 [7:0]   keycode,
	input				key_make,
	input				key_ext,
	
	input  [2:0] 	obs_mem,
	output [7:0] 	x,
	output [6:0] 	y,
	output [7:0]	obs_x,
	output [6:0]	obs_y,
	output [2:0] 	color_draw,
	output 			plot,
	output [4:0]	state,
	output [2:0]   move,
   output [8:0]   t,
	output			win,
	input				trail
   );

   
	wire [1:0] s_color;
	
	wire en_timer;
	wire s_timer;
	
	wire timer_done;
	
	wire en_xpos;
	wire en_ypos;
	wire [1:0] s_xpos;
	wire [1:0] s_ypos;

	
	wire en_key;
	wire s_key;

   wire en_clockt;
   wire s_clockt;
	
	wire en_obs;
	wire [2:0] s_obs;
	
	wire obs_wall;
	wire obs_lava;
	wire obs_ice;
	wire unfrozen;
	
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
		.en_obs			(en_obs		),
		.s_obs			(s_obs		),
        .en_clockt           (en_clockt),
        .s_clockt            (s_clockt),
		
		//FLAGS
		.timer_done		(timer_done	),
		.move				(move			),
		.obs_wall		(obs_wall	),
		.obs_lava		(obs_lava	),
		.obs_ice			(obs_ice		),
		.unfrozen		(unfrozen	),
		.win				(win			),
		
		.state_cur		(state		)
   );
   
   datapath datapath (
      .clk           (clk        ),
		.keycode			(keycode		),
		.key_make		(key_make	),
		.key_ext			(key_ext		),
		.obs_mem			(obs_mem		),
		
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
		.en_obs			(en_obs		),
		.s_obs			(s_obs		),
      .en_clockt     (en_clockt  ),
      .s_clockt      (s_clockt   ),
      .t             (t				),
		
		.xpos				(x				),
		.ypos				(y				),
		.obs_x			(obs_x		),
		.obs_y			(obs_y		),
		.color_draw		(color_draw	),
		
		.timer_done		(timer_done	),
		.move				(move			),
		.obs_wall		(obs_wall	),
		.obs_lava		(obs_lava	),
		.obs_ice			(obs_ice		),
		.unfrozen		(unfrozen	),
		.win				(win			),
		.trail			(trail		)
   );
   
endmodule
