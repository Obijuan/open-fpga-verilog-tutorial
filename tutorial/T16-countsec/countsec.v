
module countsec(input wire clk, output wire [3:0] data);

parameter M = 12_000_000;

wire clk_1HZ;


reg [3:0] counter = 0;

divider #(M)
  DIV (
    .clk_in(clk),
    .clk_out(clk_1HZ)
  );

always @(posedge clk_1HZ)
  counter <= counter + 1;

assign data = counter;

endmodule
