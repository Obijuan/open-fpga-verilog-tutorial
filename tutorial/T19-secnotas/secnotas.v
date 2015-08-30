//-----------------------------------------------------------------------------
//-- Contador de segundos
//-- (C) BQ. August 2015. Written by Juan Gonzalez
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

//-- Incluir las constantes del modulo del divisor
`include "divider.vh"


//-- Parameteros:
//-- clk: Reloj de entrada de la placa iCEstick
//-- data: Valor del contador de segundos, a sacar por los leds de la iCEstick
module secnotas(input wire clk, output reg ch_out);

//-- Parametro del divisor. Fijarlo a 1Hz
//-- Se define como parametro para poder modificarlo desde el testbench
//-- para hacer pruebas
parameter N0 = `DO;
parameter N1 = `RE;
parameter N2 = `MI;
parameter N3 = `FA;
parameter DUR = `T_250ms;


//-- Cables de salida de los canales
wire ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7;

reg [1:0] sel = 0;

wire clk_dur;

//-- Generador de tono 0
divider #(N0)
  CH0 (
    .clk_in(clk),
    .clk_out(ch0)
  );


//-- Generador de tono 1
divider #(N1)
  CH1 (
    .clk_in(clk),
    .clk_out(ch1)
  );

//-- Generador de tono 2
divider #(N2)
  CH2 (
    .clk_in(clk),
    .clk_out(ch2)
  );

//-- Generador de tono 3
divider #(N3)
  CH3 (
    .clk_in(clk),
    .clk_out(ch3)
  );


//-- Multiplexor de seleccion del canal de salida
always @*
  case (sel)
     0 : ch_out <= ch0;
     1 : ch_out <= ch1;
     2 : ch_out <= ch2;
     3 : ch_out <= 0;
     default : ch_out <= 0;
  endcase

//-- Contador para seleccion de nota
always @(posedge clk_dur)
  sel <= sel + 1;


//-- Divisor para marcar el tiempo
divider #(DUR)
  TIMER0 (
    .clk_in(clk),
    .clk_out(clk_dur)
  );

endmodule



