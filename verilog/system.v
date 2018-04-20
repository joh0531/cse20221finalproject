module system (
   input       	clk,
   input          reset,
   output [2:0]  	color_draw,
	output [7:0]  	x,
	output [7:0]  	y,
	output  			plot,
	output [4:0]	state
   );

   wire [2:0] color_obs;
	
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
   
   rom memory (
      .clk     (clk      ),
      .x    	(x     	 ),
		.y			(y			 ),
      .dout    (color_obs)
   );
   
endmodule
   