//-----------------------------------------------------------------------------
//-- Generador de tonos de 1Khz, 2Khz, 3Khz y 4Khz
//-- (C) BQ. August 2015. Written by Juan Gonzalez
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

//-- Incluir las constantes del modulo del divisor
`include "divider.vh"


//-- Parameteros:
//-- clk: Reloj de entrada de la placa iCEstick
//-- data: Valor del contador de segundos, a sacar por los leds de la iCEstick
module tones(input wire clk, output wire ch0, ch1, ch2, ch3);

//-- Parametro del divisor. Fijarlo a 1Hz
//-- Se define como parametro para poder modificarlo desde el testbench
//-- para hacer pruebas
parameter F0 = `F_1KHz;
parameter F1 = `F_2KHz;
parameter F2 = `F_3KHz;
parameter F3 = `F_4KHz;


//-- Generador de tono 0
divider #(F0)
  CH0 (
    .clk_in(clk),
    .clk_out(ch0)
  );


//-- Generador de tono 1
divider #(F1)
  CH1 (
    .clk_in(clk),
    .clk_out(ch1)
  );

//-- Generador de tono 2
divider #(F2)
  CH2 (
    .clk_in(clk),
    .clk_out(ch2)
  );

//-- Generador de tono 3
divider #(F3)
  CH3 (
    .clk_in(clk),
    .clk_out(ch3)
  );


endmodule



