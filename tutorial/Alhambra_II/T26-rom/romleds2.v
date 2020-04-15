//----------------------------------------------------------------------------
//-- Ejemplo que saca una secuencia en los leds, usando una memoria
//-- rom de 16x4, que se inicializa desde un fichero
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
`default_nettype none

`include "divider.vh"

module romleds2 (input wire clk,
                 output wire [3:0] leds);

//-- Parametros:
//- Tiempo de envio
parameter DELAY = `T_500ms; //`T_1s;

//-- Fichero para cargar la rom
parameter ROMFILE = "rom1.list";  //--  rom2.list

reg [3:0] addr;
reg rstn = 0;
wire clk_delay;

//-- Instanciar la memoria rom
romfile16x4 #(ROMFILE)
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
