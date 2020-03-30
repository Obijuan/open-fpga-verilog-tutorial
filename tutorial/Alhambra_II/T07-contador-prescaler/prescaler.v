//-------------------------------------------------------------
//-- Prescaler de N bits
//-- (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//-------------------------------------------------------------
//-- Prescaler generico, para ralentizar las señales de reloj
//-------------------------------------------------------------

//-- Entrada: señal de reloj de entrada
//-- Salida: Señal de reloj de salida, con menor frecuencia
module prescaler(input clk_in, output clk_out);
wire clk_in;
wire clk_out;

//-- Numero de bits del prescaler (por defecto)
parameter N = 22;

//-- Registro para implementar contador de N bits
reg [N-1:0] count = 0;

//-- El bit más significativo se saca por la salida
assign clk_out = count[N-1];

//-- Contador: se incrementa en flanco de subida
always @(posedge(clk_in)) begin
  count <= count + 1;
end

endmodule
