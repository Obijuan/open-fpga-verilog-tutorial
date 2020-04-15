//-------------------------------------------------------------------
//-- tristate1_tb.v
//-- Banco de pruebas para la puerta tri-estado
//-------------------------------------------------------------------
//-- BQ November 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL license
//-------------------------------------------------------------------

//-------------------------------------------------------------------
//-- Este codigo simula bien, pero NO se sintetiza con Yosys + icestorm:
//-- Todavía el sopote para puertas tri-estado no es completo
//-- Mensaje de error:
/*

*/

module error2_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Led a controlar
wire [1:0] leds;

//-- Instanciar el componente
error2
  dut(
    .clk(clk),
    .leds(leds)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;

//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("error2_tb.vcd");
  $dumpvars(0, error2_tb);

  # 100 $display("FIN de la simulacion");
  $finish;
end

endmodule
