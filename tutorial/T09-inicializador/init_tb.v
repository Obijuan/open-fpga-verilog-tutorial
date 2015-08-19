//-------------------------------------------------------------------
//-- init_tb.v
//-- Banco de pruebas para el componente init
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL license
//-------------------------------------------------------------------

module init_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Datos de salida del componente
wire ini;

//-- Instanciar el componente
init 
  INIT (
	  .clk(clk),
	  .ini(ini)
  );

//-- Generador de reloj. Periodo 2 unidades
always #2 clk = ~clk;

//-- Proceso al inicio
initial begin

	//-- Fichero donde almacenar los resultados
	$dumpfile("init_tb.vcd");
	$dumpvars(0, init_tb);

	# 20 $display("FIN de la simulacion");
	$finish;

end

endmodule

