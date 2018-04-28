module system_DE2 (
	input				CLOCK_50,				//	50 MHz
	input	 [17:0]	SW,
	input	 [3:0]	KEY,
	output [17:0]	LEDR,
	output [7:0]	LEDG,
	output [6:0]	HEX0,
	output [6:0]	HEX1,
	output [6:0]	HEX2,
	output [6:0]	HEX3,
	output [6:0]	HEX4,
	output [6:0]	HEX5,
	output [6:0]	HEX6,
	output [6:0]	HEX7,
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK,				//	VGA BLANK
	output			VGA_SYNC,				//	VGA SYNC
	output [9:0]	VGA_R,   				//	VGA Red[9:0]
	output [9:0]	VGA_G,	 				//	VGA Green[9:0]
	output [9:0]	VGA_B,	   				//	VGA Blue[9:0]
	inout				PS2_CLK,
	inout				PS2_DAT
    //LCD Module 16X2
    output          LCD_ON,
    output          LCD_BLON,
    output          LCD_RW,
    output          LCD_EN,
    output          LCD_RS,
    inout [7:0]     LCD_DATA
	);

    assign LCD_ON = 1'b1;
    assign LCD_BLON = 1'b1;
    wire [8:0] t;
		
	assign LEDR = SW;
	assign HEX1 = 7'h7f;
	
	wire [7:0] vga_x;
	wire [6:0] vga_y;
	wire [2:0] vga_color;
	wire 		  vga_plot;
   wire 		  reset;
	wire [4:0] state;
	
	assign reset = ~KEY[1];
	
	// Internal keyboard wires
	wire		[7:0]	ps2_key_data;
	wire				ps2_key_en;
	
	wire key_make;
	wire key_ext;
	wire [7:0] keycode;
	
	wire [2:0] move;

	assign LEDG[2]		= key_ext;
	assign LEDG[0]		= key_make;
	
	wire [2:0] obs_mem;
	
	system sys(
		.clk			(CLOCK_50),
		.reset		(reset),
		.key_en		(ps2_key_en),
		.key_data	(ps2_key_data),
		.color_draw (vga_color),
		.x				(vga_x),
		.y				(vga_y),
		.plot			(vga_plot),
		.state		(state),
		.keycode		(keycode),
		.key_make	(key_make),
		.key_ext		(key_ext),
		.move			(move),
        .t              (t),
		.obs_mem		(obs_mem),
		.trail		(SW[17])
	);
	
	hexdigit x1 (
		.in	(vga_x[7:4]),
		.out	(HEX7)
	);
	
	hexdigit x0 (
		.in	(vga_x[3:0]),
		.out	(HEX6)
	);
	
	hexdigit y1 (
		.in	({1'b0, vga_y[6:4]}),
		.out	(HEX5)
	);
	
	hexdigit y0 (
		.in	(vga_y[3:0]),
		.out	(HEX4)
	);
	
	/*
	hexdigit s1 (
		.in	({3'b0, state[4]}),
		.out	(HEX3)
	);
	
	hexdigit s0 (
		.in	(state[3:0]),
		.out	(HEX2)
	);
	*/
	
	hexdigit key1 (
		.in	(keycode[7:4]),
		.out	(HEX3)
	);
	
	hexdigit key0 (
		.in	(keycode[3:0]),
		.out	(HEX2)
	);
	
	hexdigit hex_obs (
		.in	({2'b0, obs_mem}),
		.out	(HEX0)
	);
	
	/*
	hexdigit color (
		.in	({1'b0, vga_color[2:0]}),
		.out	(HEX0)
	);
	*/

    // LCD
    wire [4:0] disp_addr;
    wire [7:0] disp_data;
    
    wire DLY_RST;

    Reset_Delay rd1(
        .iCLK       (CLOCK_50),
        .oRESET     (DLY_RST),
    );

    LCD_message lcd1(
        .clk        (CLOCK_50),
        .raddr      (disp_addr),
        .t          (t),
        .dout       (disp_data)
    );

    LCD_Display u1(
        .iCLK_50MHZ (CLOCK_50),
        .iRST_N     (DLY_RST),
        .oMSG_INDEX (disp_addr),
        .iMSG_ASCII (disp_data),
        .DATA_BUS   (LCD_DATA),
        .LCD_RW     (LCD_RW),
        .LCD_E      (LCD_EN),
        .LCD_RS     (LCD_RS)
    );

	PS2_Controller PS2 (
		// Inputs
		.CLOCK_50			(CLOCK_50),
		.reset				(reset),

		// Bidirectionals
		.PS2_CLK				(PS2_CLK),
		.PS2_DAT				(PS2_DAT),

		// Outputs
		.received_data		(ps2_key_data),
		.received_data_en	(ps2_key_en)
	);


	
	
	vga_adapter VGA(
		.resetn		(~reset),
		.clock		(CLOCK_50),
		.colour		(vga_color),
		.x				(vga_x),
		.y				(vga_y),
		.plot			(vga_plot),
		/* Signals for the DAC to drive the monitor. */
		.VGA_R		(VGA_R),
		.VGA_G		(VGA_G),
		.VGA_B		(VGA_B),
		.VGA_HS		(VGA_HS),
		.VGA_VS		(VGA_VS),
		.VGA_BLANK	(VGA_BLANK),
		.VGA_SYNC	(VGA_SYNC),
		.VGA_CLK		(VGA_CLK)
	);
	defparam VGA.RESOLUTION = "160x120";
	defparam VGA.MONOCHROME = "FALSE";
	defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
	defparam VGA.BACKGROUND_IMAGE = "maze.mif";
	
endmodule

