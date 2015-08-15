//-------------------------------------------------------------------
//-- prescaler_tb.v
//-- Banco de pruebas para el prescaler
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module prescaler_tb();

//-- Numero de bits del prescaler a comprobar
parameter N = 2;

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Salida del prescaler
wire clk_out;


//-- Registro para comprobar si el prescaler funciona
reg [N-1:0] counter_check = 0;


//-- Instanciar el prescaler de N bits
prescaler #(.N(N))  //-- Parámetro N
  Pres1(
	  .clk_in(clk),
	  .clk_out(clk_out)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;

//-- Comprobacion del valor del contador
//-- En cada flanco de bajada se comprueba la salida del contador
//-- y se incrementa el valor esperado
always @(negedge clk) begin

  //-- Incrementar variable del contador de prueba
  counter_check = counter_check + 1;

	//-- El bit de mayor peso debe coincidir con clk_out
  if (counter_check[N-1] != clk_out) begin
	  $display("--->ERROR! Prescaler no funciona correctamente");
		$display("Clk out: %d, counter_check[2]: %d", 
               clk_out, counter_check[N-1]);
  end

end

//-- Proceso al inicio
initial begin

	//-- Fichero donde almacenar los resultados
	$dumpfile("prescaler_tb.vcd");
	$dumpvars(0, prescaler_tb);


	# 99 $display("FIN de la simulacion");
	# 100 $finish;
end

endmodule

