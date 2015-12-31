//-------------------------------------------------------------------
//-- blink4_tb.v
//-- Banco de pruebas para el componente blink4
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module blink4_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Datos de salida del componente
wire [3:0] data;

//-- Instanciar el componente
blink4 #(.N(1))
  TOP (
	  .clk(clk),
	  .data(data)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;

//-- Proceso al inicio
initial begin

	//-- Fichero donde almacenar los resultados
	$dumpfile("blink4_tb.vcd");
	$dumpvars(0, blink4_tb);


	# 100 $display("FIN de la simulacion");
	$finish;

end

endmodule

