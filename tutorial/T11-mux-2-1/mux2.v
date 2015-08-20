module mux2(input wire clk, output reg [3:0] data);

wire [3:0] val0;
wire [3:0] val1;
wire sel;

parameter NP = 22;
parameter VAL0 = 4'b1010;
parameter VAL1 = 4'b0101;

assign val0 = VAL0;
assign val1 = VAL1;

always @(sel or val0 or val1)
  if (sel==0)
    data <= val0;
  else
    data <= val1;

prescaler #(.N(NP))
  PRES (
    .clk_in(clk),
    .clk_out(sel)
  );

endmodule
