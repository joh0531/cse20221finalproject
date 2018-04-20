module processor (
   input          clk,
   input          reset,
	
	input  [2:0] 	color_obs,
	output [7:0] 	x,
	output [7:0] 	y,
	output [2:0] 	color_draw,
	output 			plot,
	output [4:0]	state
   );

   
	wire s_color;
	
	wire en_timer;
	wire s_timer;
	
	wire timer_done;
	
   controller controller (
      .clk           (clk        ),
      .reset         (reset      ),
		.s_color			(s_color		),
		.plot				(plot			),
		.en_timer		(en_timer	),
		.s_timer			(s_timer		),
		
		//FLAGS
		.timer_done		(timer_done	),
		
		.state_cur		(state		)
   );
   
   datapath datapath (
      .clk           (clk        ),
		.s_color			(s_color		),
		.plot				(plot			),
		.en_timer		(en_timer	),
		.s_timer			(s_timer		),
		
		.xpos				(x				),
		.ypos				(y				),
		.color_draw		(color_draw	),
		
		.timer_done		(timer_done)
   );
   
endmodule
