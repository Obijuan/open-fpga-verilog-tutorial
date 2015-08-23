//--------------------------------------------------------------------------
//-- register.v
//-- Registro genérico de N bits, con reset asíncrono activo a nival bajo
//--------------------------------------------------------------------------
//-- (C) BQ. August 2015. Written by Juan Gonzalez (Obijuan)
//--------------------------------------------------------------------------
//-- Parámetros:  N: Numero de bits
//--             INI: Valor inicial del registro al hacer el reset
//--------------------------------------------------------------------------

module register (rst, clk, din, dout);

//-- Parametros: número de bits del registro
parameter N = 4;     //-- Número de bits del registro
parameter INI = 0;   //-- Valor inicial

//-- Declaración de los puertos
input wire rst;
input wire clk;
input wire [N-1:0] din;
output reg [N-1:0] dout;

//-- Registro
always @(posedge(clk))
  if (rst == 0)
    dout <= INI; //-- Inicializacion
  else
    dout <= din; //-- Funcionamiento normal

endmodule


