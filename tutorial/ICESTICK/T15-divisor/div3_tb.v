//-------------------------------------------------------------------
//-- div3_tb.v
//-- Banco de pruebas para el divisor de frecuencia entre 3
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module div3_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;
wire clk_out;


//-- Instanciar el divisor
div3
  dut(
    .clk_in(clk),
    .clk_out(clk_out)
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

