module ram (
   input clk,
   input [7:0] x,
	input [7:0] y,
   input [2:0] din,
   input we,
   output reg [2:0] dout
   );
     
   reg [2:0] M [0:19199];
	
	parameter WIDTH = 8'd160;
	parameter HEIGHT = 8'd160;
	
	wire [15:0] addr;
	assign addr = (y * HEIGHT) + x;

   initial begin
      M[0]   = 16'h7EFF;
      M[1]   = 16'h7003;
      M[2]   = 16'h1EE0;
      M[3]   = 16'h7003;
      M[4]   = 16'h900E;
      M[5]   = 16'h7004;
      M[6]   = 16'h910E;
      M[7]   = 16'hD00E;
      M[8]   = 16'h802E;
      M[9]   = 16'h7140;
      M[10]  = 16'h9001;
      M[11]  = 16'h7003;
      M[12]  = 16'h0EE0;
      M[13]  = 16'hF000;
      M[14]  = 16'h7003;
      M[15]  = 16'h1EE0;
      M[16]  = 16'h92FE;
      M[17]  = 16'h803E;
      M[18]  = 16'h900E;
      M[19]  = 16'hD01C;
      M[20]  = 16'h801E;
      M[21]  = 16'h814E;
      M[22]  = 16'h0001;
      M[23]  = 16'h950E;
      M[24]  = 16'h8F2E;
      M[25]  = 16'h7003;
      M[26]  = 16'h0EE0;
      M[27]  = 16'hE0F0;
      M[28]  = 16'h800E;
      M[29]  = 16'h5002;
      M[30]  = 16'h910E;
      M[31]  = 16'hE0F0;
   end
   

   
   always @(posedge clk)
      if (we)
         M[addr] <= din;
         
   always @(posedge clk)
      dout <= M[addr];
      
endmodule

