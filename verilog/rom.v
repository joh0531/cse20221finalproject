module rom (
   input clk,
   input [7:0] x,
	input [7:0] y,
   output reg [2:0] dout
   );
     
   reg [2:0] M [0:19199];
	
	parameter WIDTH = 8'd160;
	parameter HEIGHT = 8'd120;
	
	wire [15:0] addr;
	assign addr = (y * HEIGHT) + x;

   initial begin
      M[0]   = 3'h0;
      M[1]   = 3'h0;
      M[2]   = 3'h0;
      M[3]   = 3'h0;
      M[4]   = 3'h0;
      M[5]   = 3'h0;
      M[6]   = 3'h0;
      M[7]   = 3'h0;
      M[8]   = 3'h0;
      M[9]   = 3'h0;
      M[10]  = 3'h0;
      M[11]  = 3'h0;
      M[12]  = 3'h0;
      M[13]  = 3'h0;
      M[14]  = 3'h0;
      M[15]  = 3'h0;
      M[16]  = 3'h0;
      M[17]  = 3'h0;
      M[18]  = 3'h0;
      M[19]  = 3'h0;
      M[20]  = 3'h0;
      M[21]  = 3'h0;
      M[22]  = 3'h0;
      M[23]  = 3'h0;
      M[24]  = 3'h0;
      M[25]  = 3'h0;
      M[26]  = 3'h0;
      M[27]  = 3'h0;
      M[28]  = 3'h0;
      M[29]  = 3'h0;
      M[30]  = 3'h0;
      M[31]  = 3'h0;
   end

         
   always @(posedge clk)
      dout <= M[addr];
      
endmodule

