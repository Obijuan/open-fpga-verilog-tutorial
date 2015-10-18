//-----------------------------------------------------------------------------
//-- Secuenciador de notas
//-- Se tocan por el mismo canal las notas DO, RE, MI, (silencio) repetidamente
//-----------------------------------------------------------------------------
//-- (C) BQ. August 2015. Written by Juan Gonzalez
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

//-- Incluir las constantes del modulo del divisor
`include "notegen.vh"
`include "divider.vh"

//-- Parameteros:
//-- clk: Reloj de entrada de la placa iCEstick
//-- ch_out: Canal de salida
module romnotes(input wire clk, output wire ch_out);

//-- Parametros: notas a tocar
//-- Se define como parametro para poder modificarlas desde el testbench
//-- para hacer pruebas
parameter N0 = `DO_5;
parameter N1 = `RE_5;
parameter N2 = `MI_5;
parameter DUR = `T_200ms;
parameter ROMFILE = "notas.list";

parameter AW = 6;

//-- Cables de salida de los canales
wire ch0, ch1, ch2;

//-- Selección del canal del multiplexor
reg [AW-1: 0] addr = 0;

//-- Reloj con la duracion de la nota
wire clk_dur;
reg rstn = 0;

wire [15:0] note;


//-- Instanciar la memoria rom
genrom 
  #( .ROMFILE(ROMFILE),
     .AW(AW),
     .DW(16))
  ROM (
        .clk(clk),
        .addr(addr),
        .data(note)
      );


notegen
  CH0 (
    .clk(clk),
    .rstn(rstn),
    .note(note),
    .clk_out(ch_out)
  );

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



