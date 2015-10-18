//----------------------------------------------------------------------------
//-- Ejemplo que saca una secuencia en los leds, usando una memoria
//-- rom de 16x4
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
`default_nettype none

`include "divider.vh"

module genromleds (input wire clk,
                   output wire [4:0] leds);

//- Tiempo de envio
parameter DELAY = `T_500ms;
parameter ROMFILE = "rom1.list";

reg [4:0] addr;
reg rstn = 0;
wire clk_delay;

//-- Instanciar la memoria rom
genrom 
  #( .ROMFILE(ROMFILE),
     .AW(5),
     .DW(5))
  ROM (
        .clk(clk),
        .addr(addr),
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

