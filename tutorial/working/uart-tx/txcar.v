`include "divider.vh"

module txcar(input wire clk, output wire tx);
parameter DELAY = `T_1s;


wire busy;
reg wr;
reg rst = 0;
wire clk_tx;
wire led;


uart_tx UART_TX (
  .clk(clk),
  .rstn(rst),
  .data("B"),
  .ws(clk_tx),
  .tx(tx)
);

divider #(DELAY)
  DIV0 (
    .clk_in(clk),
    .clk_out(clk_tx)
  );

//-- Inicializador
always @(posedge(clk))
  rst <= 1;

endmodule




  
