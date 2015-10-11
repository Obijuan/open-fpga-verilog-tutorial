`default_nettype none

`include "divider.vh"

module romleds2 (input wire clk,
                 output wire [3:0] leds);

//- Tiempo de envio
parameter DELAY = `T_500ms; //`T_1s;
parameter ROMFILE = "rom2_sec2.list";

reg [3:0] addr;
reg rstn = 0;
wire clk_delay;

//-- Instanciar la memoria rom
rom_memory2 #(ROMFILE)
  ROM (
        .clk(clk),
        .addr(addr),
        .rd(1),
        .data(leds)
      );


//-- Contador
always @(negedge clk)
  if (rstn == 0)
    addr <= 0;
  else if (clk_delay)
    addr <= addr + 1;

//---------------------------
//--  Temporizador
//---------------------------
dividerp1 #(.M(DELAY))
  DIV0 ( .clk(clk),
         .clk_out(clk_delay)
       );


//-- Inicializador
always @(negedge clk)
  rstn <= 1;


endmodule



