//----------------------------------------------------------------------------
//-- Ejemplo de uso de una memoria rom generica
//-- Se reproduce en los leds la secuencia definida en el fichero rom1.list
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

//-- Fichero con la rom
parameter ROMFILE = "rom1.list";

//-- Numero de bits de la direccione
parameter AW = 5;
parameter DW = 5;

//-- Cable para direccionar la memoria
reg [AW-1: 0] addr;

reg rstn = 0;
wire clk_delay;

//-- Instanciar la memoria rom
genrom 
  #( .ROMFILE(ROMFILE),
     .AW(AW),
     .DW(DW))
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

