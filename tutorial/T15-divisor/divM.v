//-----------------------------------------------------------------------------
//-- Divisor de frecuencia entre M
//-- (c) BQ. August 2015. written by Juan Gonzalez (obijuan)
//-----------------------------------------------------------------------------
//-- GPL license
//-----------------------------------------------------------------------------

//-- Entrada: clk_in. Señal original
//-- Salida: clk_out. Señal de frecuencia 1/M de la original
module divM(input wire clk_in, output wire clk_out);

//-- Valor por defecto del divisor
//-- Como en la iCEstick el reloj es de 12MHz, ponermos un valor de 12M
//-- para obtener una frecuencia de salida de 1Hz
parameter M = 12_000_000;

//-- Numero de bits para almacenar el divisor
//-- Se calculan con la funcion de verilog $clog2, que nos devuelve el 
//-- numero de bits necesarios para representar el numero M
//-- Es un parametro local, que no se puede modificar al instanciar
localparam N = $clog2(M);

//-- Registro para implementar el contador modulo M
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

