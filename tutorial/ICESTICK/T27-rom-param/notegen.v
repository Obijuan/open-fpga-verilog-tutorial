//-----------------------------------------------------------------------------
//-- Divisor de frecuencias para generacion de notas musicales
//-- (c) BQ. October 2015. written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------
//-- Esta formado por dos divisores en cadena. El primero genera un pulso
//-- de anchura 1 ciclo de reloj, y frecuencia de la nota 2 * note
//-- Esta señal se pasa por un divisor entre 2, para generar una señal con
//-- ciclo de trabajo del 50% y frecuencia note
//-----------------------------------------------------------------------------

module notegen(input wire clk,          //-- Senal de reloj global
               input wire rstn,         //-- Reset
               input wire [15:0] note,  //-- Divisor
               output reg clk_out);     //-- Señal de salida

wire clk_tmp;

//-- Registro para implementar el contador modulo note
reg [15:0] divcounter = 0;

//-- Contador módulo note
always @(posedge clk)

  //-- Reset
  if (rstn == 0)
    divcounter <= 0;      

  //-- Si la nota es 0 no se incrementa contador
  else if (note == 0)
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



