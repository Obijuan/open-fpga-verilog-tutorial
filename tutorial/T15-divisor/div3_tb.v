//-------------------------------------------------------------------
//-- regreset_tb.v
//-- Banco de pruebas para el secuenciador de 2 estados con 2 registros
//-- con precarga
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module div3_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;
wire clk_3;


//-- Instanciar el componente, con prescaler de 1 bit (para la simulacion)
div3
  dut(
    .clk_in(clk),
    .clk_out(clk_3)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("div3_tb.vcd");
  $dumpvars(0, div3_tb);

  # 30 $display("FIN de la simulacion");
  $finish;
end

endmodule

