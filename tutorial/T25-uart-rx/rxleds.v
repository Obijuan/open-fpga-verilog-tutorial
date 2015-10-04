//-- tested at: 300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 

`default_nettype none

`include "baudgen.vh"


module rxleds(input wire clk,
              input wire rx,
              output reg [3:0] leds,
              output wire act);

localparam BAUD = `B115200;

wire rcv;
wire [7:0] data;
reg rstn = 0;

//-- Inicializador
always @(posedge clk)
  rstn <= 1;

uart_rx #(BAUD)
  RX0 (.clk(clk),
       .rstn(rstn),
       .rx(rx),
       .rcv(rcv),
       .data(data)
      );

//-- Sacar 4 bits menos significativos del dato recibido por los leds
always @(posedge clk)
    leds <= data[3:0]; 

//-- Led de actividad
assign act = ~rx;

endmodule
