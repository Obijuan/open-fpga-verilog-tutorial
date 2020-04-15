//-------------------------------------------------------------------
//-- romleds_tb.v
//-- Banco de pruebas para el secuenciador de luces, implementado con
//-- una memoria rom
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module romleds_tb();

//-- Para la simulacion se usa un retraso de 2 ciclos de reloj
parameter DELAY = 2;

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Datos de salida del componente
wire [3:0] leds;

//-- Instanciar el componente
romleds #(DELAY)
  dut(
    .clk(clk),
    .leds(leds)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("romleds_tb.vcd");
  $dumpvars(0, romleds_tb);

  # 100 $display("FIN de la simulacion");
  $finish;
end

endmodule
