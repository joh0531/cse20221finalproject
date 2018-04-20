`timescale 1ns/1ns

module system_tb ();
   reg          clk;
   reg          reset;
   
	
	wire [7:0] vga_x;
	wire [7:0] vga_y;
	wire [2:0] vga_color;
	wire 		  vga_plot;
	wire [4:0] state;
	
   parameter EX_QUIT = 5'd18;
	
	system uut(
		.clk			(clk),
		.reset		(reset),
		.color_draw (vga_color),
		.x				(vga_x),
		.y				(vga_y),
		.plot			(vga_plot),
		.state		(state)
	);
   
   always #5 clk = ~clk;
   
   initial begin
      clk = 0;  reset = 1;
      #10 reset = 0;
      //while (uut.processor.controller.state != EX_QUIT)
         //#10;
      #100000000 $stop;
   end

endmodule
