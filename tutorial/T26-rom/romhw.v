//----------------------------------------------------------------------------
//-- Ejemplo hola mundo de uso de la Memoria ROM de 32 x 4
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
//-- Este ejemplo saca por los leds el contenido de la memoria ROM de la
//-- direccion dada por el parametro ADDR
//----------------------------------------------------------------------------
`default_nettype none

module romhw (input wire clk,
              output wire [3:0] leds);

localparam ADDR = 5'h5;  //-- Direccion 5 por defecto

//-- Instanciar la memoria rom
rom32x4 
  ROM (
        .clk(clk),
        .addr(ADDR),
        .data(leds)
      );


endmodule



