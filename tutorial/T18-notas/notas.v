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
module notas(input wire clk, output wire ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7);

//-- Parametro del divisor. Fijarlo a 1Hz
//-- Se define como parametro para poder modificarlo desde el testbench
//-- para hacer pruebas
parameter N0 = `DO;
parameter N1 = `RE;
parameter N2 = `MI;
parameter N3 = `FA;
parameter N4 = `SOL;
parameter N5 = `LA;
parameter N6 = `SI;
parameter N7 = `DO_1;


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

divider #(N4)
  CH4 (
    .clk_in(clk),
    .clk_out(ch4)
  );

divider #(N5)
  CH5 (
    .clk_in(clk),
    .clk_out(ch5)
  );

divider #(N6)
  CH6 (
    .clk_in(clk),
    .clk_out(ch6)
  );

divider #(N7)
  CH7 (
    .clk_in(clk),
    .clk_out(ch7)
  );


endmodule



