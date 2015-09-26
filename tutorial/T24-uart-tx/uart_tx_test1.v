`include "baudgen.vh"

module uart_tx_test1 (input wire clk,
                      input wire transmit,
                      output wire tx
                     );

parameter BAUD = `B115200;

//-- Reset
reg rstn = 0;

wire start;

wire ready;

//-- Inicializador
always @(posedge clk)
  rstn <= 1;

uart_tx #(.BAUD(BAUD))
  TX0 (
    .clk(clk),
    .rstn(rstn),
    .start(start),
    .ready(ready),
    .tx(tx)
  );


endmodule
