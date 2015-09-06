`include "divider.vh"

module txcar(input wire clk,
             input wire  rx, 
             output wire tx,
             output wire [3:0] leds,
             output wire act);

reg rstn = 0;
wire [7:0] data;
wire rs;

uart_rx UART_RX (
    .clk(clk), 
    .rstn(rstn),
    .rx(rx),
    .data(data),
    .rs(rs)
  );

uart_tx UART_TX (
  .clk(clk),
  .rstn(rstn),
  .data(data),
  .ws(rs),
  .tx(tx)
);



//-- Sacar dato recibido por los leds
assign leds = data;

//-- Sacar actividad por led verde
assign act = rx;


//-- Inicializador
always @(posedge(clk))
  rstn <= 1;

endmodule




  
