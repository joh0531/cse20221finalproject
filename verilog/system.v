module system (
   input          clk,
   input          reset,
   output  [2:0]  color_out,
	output  [7:0]  x,
	output  [7:0]  y,
	output  			plot
   );
	
	wire we;
   wire color_in;

	
   processor processor (
      .clk     (clk      ),
      .reset   (reset    ),
      .din     (color_out),
      .x    	(x			 ),
		.y			(y			 )
      .dout    (color_in ),
      .we      (we       ),
		.en_plot	(plot		 )
   );
   
   ram memory (
      .clk     (clk      ),
      .x    	(x     	 ),
		.y			(y			 ),
      .din     (color_in ),
      .we      (we       ),
      .dout    (color_out)
   );
   
endmodule
   