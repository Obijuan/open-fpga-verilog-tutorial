//-----------------------------------------------------------------------------
//-- Divisor de frecuencia entre 3
//-- (c) BQ. August 2015. written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

//-- Entrada: clk_in. Señal original
//-- Salida: clk_out. Señal de frecuencia 1/3 de la original
module divM(input wire clk_in, output wire clk_out);

//-- Valor del divisor
parameter M = 12_000_000;

//-- Numero de bits para almacenar el divisor
localparam N = $clog2(M);

reg [N-1:0] divcounter = 0;

//-- Contador módulo M
always @(posedge clk_in)
  if (divcounter == M - 1) 
    divcounter <= 0;
  else 
    divcounter <= divcounter + 1;

//-- Sacar el bit mas significativo por clk_out
assign clk_out = divcounter[N-1];

endmodule

