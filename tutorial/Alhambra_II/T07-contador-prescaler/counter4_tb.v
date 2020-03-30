//-------------------------------------------------------------------
//-- counter4_tb.v
//-- Banco de pruebas para el contador de 4 bits con prescaler
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module counter4_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Datos de salida del contador
wire [3:0] data;


//-- Registro para comprobar si el contador cuenta correctamente
reg [3:0] counter_check = 0;


//-- Instanciar el contador, con prescaler de 1 bit (para la simulacion)
counter4 #(.N(1))
  C1(
	  .clk(clk),
	  .data(data)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;

//-- Proceso de comprobación. Cada vez que hay un cambio en
//-- el contador se comprueba con el valor de prueba
always @(data) begin

  if (counter_check != data)
	  $display("-->ERROR!. Esperado: %d. Leido: %d",counter_check, data);

  counter_check = counter_check + 1;
end


//-- Proceso al inicio
initial begin

	//-- Fichero donde almacenar los resultados
	$dumpfile("counter4_tb.vcd");
	$dumpvars(0, counter4_tb);

	//-- Comprobación del reset.
	# 0.5 if (data != 0)
					$display("ERROR! Contador NO está a 0!");
				else
					$display("Contador inicializado. OK.");

	# 99 $display("FIN de la simulacion");
	# 100 $finish;
end

endmodule

