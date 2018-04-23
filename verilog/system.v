module system (
   input       	clk,
   input          reset,
	input				key_en,
	input  [7:0]   key_data,
   output [2:0]  	color_draw,
	output [7:0]  	x,
	output [7:0]  	y,
	output  			plot,
	output [4:0]	state,
	output [7:0]	keycode,
	output 			key_make,
	output			key_ext
   );

   wire [2:0] color_obs;
	
	wire				keycode_ready;
	
   processor processor (
      .clk     	(clk      	),
      .reset   	(reset    	),
      .x    		(x			 	),
		.y				(y			 	),
		.color_obs 	(color_obs	),
      .color_draw (color_draw	),
		.plot			(plot		 	),
		.state		(state		)
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
      .clk     (clk      ),
      .x    	(x     	 ),
		.y			(y			 ),
      .dout    (color_obs)
   );
   
endmodule
   