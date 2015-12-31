//-------------------------------------------------------------------
//-- romhw_tb.v
//-- Banco de pruebas para el modulo romhw (hola mundo de la rom)
//-------------------------------------------------------------------
//-- Simplemente se instancia el componente y se genera la señal de
//-- reloj
//-------------------------------------------------------------------
//-- BQ October 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module romhw_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Datos de salida de la rom
wire [3:0] leds;

//-- Instanciar el componente a probar
romhw
  dut(
    .clk(clk),
    .leds(leds)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("romhw_tb.vcd");
  $dumpvars(0, romhw_tb);

  # 100 $display("FIN de la simulacion");
  $finish;
end

endmodule

