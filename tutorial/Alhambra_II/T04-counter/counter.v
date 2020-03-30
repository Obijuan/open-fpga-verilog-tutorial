//---------------------------------------------------------
//-- counter.v  
//-- Contador de 26 bits
//---------------------------------------------------------
//-- BQ  August 2015. Written by Juan Gonzalez (Obijuan)
//---------------------------------------------------------
//-- GPL license
//---------------------------------------------------------


//-----------------------------------
//-- Entrada: señal de reloj
//-- Salida: contador de 26 bits
//-----------------------------------
module counter(input clk, output [25:0] data);
wire clk;

//-- La salida es un registro de 26 bits, inicializado a 0
reg [25:0] data = 0;

//-- Sensible al flanco de subida
always @(posedge clk) begin

	//-- Incrementar el registro
	data <= data + 1;
end


endmodule

