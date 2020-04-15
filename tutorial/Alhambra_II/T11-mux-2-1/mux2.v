//-----------------------------------------------------------------------------
//-- mux2.v  Secuenciador de dos estados con multiplexor
//-- Sacar por los leds dos datos de 4 bits alternativamente para generar una
//-- secuencia
//-----------------------------------------------------------------------------
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-- License GPL
//-----------------------------------------------------------------------------

//-- Entradas: Reloj
//-- Salida: Dato de 4 bits a conectar a los leds
module mux2(input wire clk, output reg [3:0] data);

//-- Parametros del secuenciador:
parameter NP = 22;         //-- Bits del prescaler
parameter VAL0 = 4'b1010;  //-- Valor secuencia 0
parameter VAL1 = 4'b0101;  //-- Valor secuencia 1

//-- Cables de las 3 entradas del multiplexor
wire [3:0] val0;
wire [3:0] val1;
wire sel;

//-- Por las entradas del mux cableamos los datos de entrada
assign val0 = VAL0;
assign val1 = VAL1;

//-- Implementacion del multiplexor
always @(sel or val0 or val1)
  if (sel==0)
    data <= val0;
  else
    data <= val1;

//-- Presaler que controla la señal de seleccion del multiplexor
prescaler #(.N(NP))
  PRES (
    .clk_in(clk),
    .clk_out(sel)
  );

endmodule
