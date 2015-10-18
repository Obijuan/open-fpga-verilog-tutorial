//-----------------------------------------------------------------------------
//-- Divisor de frecuencia generico
//-- (c) BQ. August 2015. written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

`include "notegen.vh"

//-- Entrada: clk_in. Señal original
//-- Salida: clk_out. Señal de frecuencia 1/M de la original
module notegen(input wire clk,
               input wire rstn,
               input wire [15:0] note,  
               output reg clk_out);

wire clk_tmp;

//-- Registro para implementar el contador modulo M
reg [15:0] divcounter = 0;

//-- Contador módulo note
always @(posedge clk)

  //-- Si la nota es 0, poner contador a 0 (silencio)
  if (note == 0)
    divcounter <= 0;      

  //-- Si se alcanza el tope, poner a 0
  else if (divcounter == note - 1)
    divcounter <= 0;

  //-- Incrementar contador
  else
    divcounter <= divcounter + 1;

//-- Sacar un pulso de anchura 1 ciclo de reloj si el generador
assign clk_tmp = (divcounter == 0) ? 1 : 0;

//-- Divisor de frecuencia entre 2, para obtener como salida una señal
//-- con un ciclo de trabajo del 50%
always @(posedge clk)
  if (rstn == 0)
    clk_out <= 0;

  else if (note == 0)
    clk_out <= 0;

  else if (clk_tmp == 1)
    clk_out <= ~clk_out;
 
endmodule



