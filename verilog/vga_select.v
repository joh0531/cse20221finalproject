module vga_select (
	input 			win,
	input [9:0] 	vga_game_R,
	input [9:0] 	vga_game_G,
	input [9:0] 	vga_game_B,
	input 			vga_game_HS,
	input 			vga_game_VS,
	input				vga_game_BLANK,
	input				vga_game_SYNC,
	input				vga_game_CLK,
	
	input [9:0] 	vga_win_R,
	input [9:0] 	vga_win_G,
	input [9:0] 	vga_win_B,
	input 			vga_win_HS,
	input 			vga_win_VS,
	input				vga_win_BLANK,
	input				vga_win_SYNC,
	input				vga_win_CLK,

	output			VGA_CLK,
	output			VGA_HS,
	output			VGA_VS,
	output			VGA_BLANK,
	output			VGA_SYNC,
	output [9:0]	VGA_R,
	output [9:0]	VGA_G,
	output [9:0]	VGA_B
	);
	
	assign VGA_CLK = win ? vga_win_CLK : vga_game_CLK;
	assign VGA_R = win ? vga_win_R : vga_game_R;
	assign VGA_G = win ? vga_win_G : vga_game_G;
	assign VGA_B = win ? vga_win_B : vga_game_B;
	assign VGA_HS = win ? vga_win_HS : vga_game_HS;
	assign VGA_VS = win ? vga_win_VS : vga_game_VS;
	assign VGA_BLANK = win ? vga_win_BLANK : vga_game_BLANK;
	assign VGA_SYNC = win ? vga_win_SYNC : vga_game_SYNC;

endmodule