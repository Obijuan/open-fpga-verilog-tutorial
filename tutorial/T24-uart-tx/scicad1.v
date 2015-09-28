`include "baudgen.vh"

module scicad1 (input wire clk,
                input wire dtr,
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
    .start(dtr),
    .ready(ready),
    .tx(tx)
  );

//-- Controlador


endmodule
