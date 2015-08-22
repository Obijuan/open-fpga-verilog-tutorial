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
    dout <= INI;
  else
    dout <= din;

endmodule
