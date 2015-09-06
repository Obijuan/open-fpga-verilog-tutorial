//-----------------------------------------------------------------------------
//-- Divisor de frecuencia generico
//-- (c) BQ. August 2015. written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

`include "divider.vh"

//-- Entrada: clk_in. Señal original
//-- Salida: clk_out. Señal de frecuencia 1/M de la original
module baudgen(input wire clk_in,
               input wire restart, 
               output wire clk_out);

//-- Valor por defecto del divisor
//-- Lo ponemos a 1 Hz
parameter M = `F_2KHz;

//-- Numero de bits para almacenar el divisor
//-- Se calculan con la funcion de verilog $clog2, que nos devuelve el 
//-- numero de bits necesarios para representar el numero M
//-- Es un parametro local, que no se puede modificar al instanciar
localparam N = $clog2(M);

//-- Registro para implementar el contador modulo M
reg [N-1:0] divcounter = 0;

//-- Contador módulo M
always @(posedge clk_in)
  if (restart == 1)
    divcounter <= 0;
  else
    divcounter <= (divcounter == M - 1) ? 0 : divcounter + 1;

assign clk_out = (divcounter == 0) ? 1 : 0;

endmodule

