//-----------------------------------------------------------------------------
//-- Reproductor de melodias almacenadas en memoria rom
//-- Los 5 bits menos significativos de la nota se sacan por los leds
//-----------------------------------------------------------------------------
//-- (C) BQ. October 2015. Written by Juan Gonzalez
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

//-- Incluir las constantes del modulo del divisor
`include "divider.vh"

//-- Parameteros:
//-- clk: Reloj de entrada de la placa iCEstick
//-- ch_out: Canal de salida
module romnotes(input wire clk, 
                output wire [4:0] leds,
                output wire ch_out);

//-- Parametros
//-- Duracion de las notas
parameter DUR = `T_200ms;

//-- Fichero con las notas para cargar en la rom
parameter ROMFILE = "imperial.list";

//-- Tamaño del bus de direcciones de la rom
parameter AW = 6;

//-- Tamaño de las notas
parameter DW = 16;

//-- Cables de salida de los canales
wire ch0, ch1, ch2;

//-- Selección del canal del multiplexor
reg [AW-1: 0] addr = 0;

//-- Reloj con la duracion de la nota
wire clk_dur;
reg rstn = 0;

wire [DW-1: 0] note;

//-- Instanciar la memoria rom
genrom 
  #( .ROMFILE(ROMFILE),
     .AW(AW),
     .DW(DW))
  ROM (
        .clk(clk),
        .addr(addr),
        .data(note)
      );


//-- Generador de notas
notegen
  CH0 (
    .clk(clk),
    .rstn(rstn),
    .note(note),
    .clk_out(ch_out)
  );

//-- Sacar los 5 bits menos significativos de la nota por los leds
assign leds = note[4:0];

//-- Inicializador
always @(posedge clk)
  rstn <= 1;


//-- Contador para seleccion de nota
always @(posedge clk)
  if (clk_dur)
    addr <= addr + 1;

//-- Divisor para marcar la duración de cada nota
dividerp1 #(DUR)
  TIMER0 (
    .clk(clk),
    .clk_out(clk_dur)
  );


endmodule



