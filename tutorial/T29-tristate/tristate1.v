//----------------------------------------------------------------------------
//--  Ejemplo 1 de puerta tri-estado
//-- Conectar y desconectar un biestable a 1 al led, a través de
//-- una puerta tri-estado, con una cadencia de 1 segundo
//----------------------------------------------------------------------------
//--  (C) BQ. November 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL license
//----------------------------------------------------------------------------
`default_nettype none

`include "divider.vh"


module tristate1  (
         input wire clk,      //-- Entrada de reloj
         output wire led0);   //-- Led a controlar

//-- Parametro: periodo de parpadeo
parameter DELAY = `T_1s;

//-- Cable con la señal de tiempo
wire clk_delay;

//-- Biestable que está siempre a 1
reg reg1;
always @(posedge clk)
  reg1 <= 1'b1;

//-- Conectar el biestable al led a traves de la puerta tri-estado
assign led0 = (clk_delay) ? reg1 : 1'bz;

//-- Divisor para temporizacion
divider #(DELAY)
  CH0 (
    .clk_in(clk),
    .clk_out(clk_delay)
  );

endmodule
