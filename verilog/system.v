module system (
   input       	clk,
   input          reset,
	input				key_en,
	input  [7:0]   key_data,
   output [2:0]  	color_draw,
	output [7:0]  	x,
	output [6:0]  	y,
	output  			plot,
	output [4:0]	state,
	output [7:0]	keycode,
	output 			key_make,
	output			key_ext,
	output [2:0]	move,
	output [2:0]	obs_mem
   );
	
	wire		  keycode_ready;
	
	wire [7:0] obs_x;
	wire [6:0] obs_y;
	
   processor processor (
      .clk     	(clk      	),
      .reset   	(reset    	),
      .x    		(x			 	),
		.y				(y			 	),
		.obs_x		(obs_x		),
		.obs_y		(obs_y		),
		.obs_mem 	(obs_mem		),
      .color_draw (color_draw	),
		.plot			(plot		 	),
		.state		(state		),
		.move			(move			),
		.keycode		(keycode		),
		.key_make	(key_make	),
		.key_ext		(key_ext		)
   );
	
	keycode_recognizer (
		.clk					(clk),
		.reset_n				(~reset),
		.ps2_key_en			(key_en),
		.ps2_key_data		(key_data),
		.keycode				(keycode),
		.ext					(key_ext),
		.make					(key_make),
		.keycode_ready		(keycode_ready)
	);
   
   rom memory (
      .clk     (clk      	),
      .x    	(obs_x     	),
		.y			(obs_y		),
      .dout    (obs_mem	)
   );
   
endmodule
   