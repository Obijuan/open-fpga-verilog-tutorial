//----------------------------------------------------------------------------
//-- Ejemplo de uso de una memoria rom generica
//-- Se reproduce en los leds la secuencia definida en el fichero rom1.list
//------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
`default_nettype none

module buffer (input wire clk,
               input wire rx,
               output wire tx,
               output wire [4:0] leds);

//-- Fichero con la rom
parameter ROMFILE = "bufferini.list";

//-- Numero de bits de la direccione
parameter AW = 6;
parameter DW = 8;

//-- Cable para direccionar la memoria
wire [AW-1: 0] addr;
wire [DW-1: 0] data_in;
wire [DW-1: 0] data_out;
wire rw;

reg rstn = 0;
wire clk_delay;

//-- Instanciar la memoria rom
genram
  #( .ROMFILE(ROMFILE),
     .AW(AW),
     .DW(DW))
  RAM (
        .clk(clk),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out),
        .rw(rw)
      );


//-- Inicializador
always @(negedge clk)
  rstn <= 1;

endmodule

