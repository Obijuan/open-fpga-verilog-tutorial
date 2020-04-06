//-----------------------------------------------------------------------------
//-- Divisor de frecuencia entre 3
//-- (c) BQ. August 2015. written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

//-- Entrada: clk_in. Señal original
//-- Salida: clk_out. Señal de frecuencia 1/3 de la original
module div3(input wire clk_in, output wire clk_out);

reg [1:0] divcounter = 0;

//-- Contador módulo 3
always @(posedge clk_in)
  if (divcounter == 2)
    divcounter <= 0;
  else
    divcounter <= divcounter + 1;

//-- Sacar el bit mas significativo por clk_out
assign clk_out = divcounter[1];

endmodule
