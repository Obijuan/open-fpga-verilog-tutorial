//-----------------------------------------------------------------------------
//-- Reproducción de 8 notas musicales simultáneas, una por cada canal
//-- Se reproducen 7 notas basicas de la octava 4: do, re, mi, fa, sol, la, si
//-- y un DO de la octava 5
//-----------------------------------------------------------------------------
//-- (C) BQ. August 2015. Written by Juan Gonzalez
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

//-- Incluir las constantes del modulo del divisor
`include "divider.vh"


//-- Parameteros:
//-- clk: Reloj de entrada de la placa iCEstick
//-- chx: salidas de los 8 canales. Una nota por cada uno
module notas(input wire clk, output wire ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7);

//-- Parametros del divisor
//-- Se definen como parametros para poder modificarlo desde el testbench
//-- para hacer pruebas
parameter N0 = `DO_4;
parameter N1 = `RE_4;
parameter N2 = `MI_4;
parameter N3 = `FA_4;
parameter N4 = `SOL_4;
parameter N5 = `LA_4;
parameter N6 = `SI_4;
parameter N7 = `DO_5;

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



