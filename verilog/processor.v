module processor (
   input          clk,
   input          reset,
	
	input  [7:0] 	color_obs,
	output [7:0] 	x,
	output [7:0] 	y,
	output [7:0] 	color_draw,
	output 			plot,
	output [4:0]	state
   );

   
	wire s_color;
	
   controller controller (
      .clk           (clk        ),
      .reset         (reset      ),
		.s_color			(s_color		),
		.plot				(plot			),
		
		.state_cur		(state		)
   );
   
   datapath datapath (
      .clk           (clk        ),
		.s_color			(s_color		),
		.plot				(plot			),
		
		.xpos				(x				),
		.ypos				(y				),
		.color_draw		(color_draw	),
   );
   
endmodule
