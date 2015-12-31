//-------------------------------------------------------------------
//-- mpres_tb.v
//-- Banco de pruebas para los prescalers multiples
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- No se comprueba el correcto funcionamiento por software. Se
//-- colocan los elementos necesarios para comprobarlo visualmente
//-------------------------------------------------------------------

module mpres_tb();

//-- Numero de bits de los prescalers
parameter N0 = 1;
parameter N1 = 1;
parameter N2 = 2;
parameter N3 = 3;
parameter N4 = 4;

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Cables de salida
wire D1, D2, D3, D4;

//-- Instanciar el componente
mpres 
  //-- Establecer parametros
  #(
     .N0(N0), 
     .N1(N1), 
     .N2(N2), 
     .N3(N3), 
     .N4(N4) 
  )
  //-- Conectar los puertos 
  dut(
	  .clk_in(clk),
	  .D1(D1),
    .D2(D2),
    .D3(D3),
    .D4(D4)
  );


//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

	//-- Fichero donde almacenar los resultados
	$dumpfile("mpres_tb.vcd");
	$dumpvars(0, mpres_tb);


	# 99 $display("FIN de la simulacion");
	# 100 $finish;
end

endmodule

