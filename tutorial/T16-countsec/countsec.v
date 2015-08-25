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
module countsec(input wire clk, output wire [3:0] data);

//-- Parametro del divisor. Fijarlo a 1Hz
//-- Se define como parametro para poder modificarlo desde el testbench
//-- para hacer pruebas
parameter M = `F_1Hz;

//-- Señal de reloj de 1Hz. Salida del divisor
wire clk_1HZ;

//-- Contador de segundos
reg [3:0] counter = 0;

//-- Instanciar el divisor
divider #(M)
  DIV (
    .clk_in(clk),
    .clk_out(clk_1HZ)
  );

//-- Incrementar el contador en cada flanco de subida de la señal de 1Hz
always @(posedge clk_1HZ)
  counter <= counter + 1;

//-- Sacar los datos del contador hacia los leds
assign data = counter;

endmodule
