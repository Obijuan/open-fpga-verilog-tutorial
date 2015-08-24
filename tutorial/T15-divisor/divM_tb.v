//-------------------------------------------------------------------
//-- regreset_tb.v
//-- Banco de pruebas para el secuenciador de 2 estados con 2 registros
//-- con precarga
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module divM_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;
wire clk_out;


//-- Instanciar el componente, con prescaler de 1 bit (para la simulacion)
divM #(7)
  dut(
    .clk_in(clk),
    .clk_out(clk_out)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("divM_tb.vcd");
  $dumpvars(0, divM_tb);

  # 30 $display("FIN de la simulacion");
  $finish;
end

endmodule

