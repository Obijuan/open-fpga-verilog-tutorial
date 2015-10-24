//-------------------------------------------------------------------
//-- buffer_tb.v
//-- Banco de pruebas para el secuenciador de luces, implementado con
//-- una memoria rom generica
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module buffer_tb();

//-- Para la simulacion se usa un retraso de 2 ciclos de reloj
parameter ROMFILE = "bufferini.list";

//-- Registro para generar la señal de reloj
reg clk = 0;
wire tx;
wire rx;

//-- Datos de salida del componente
wire [4:0] leds;

//-- Instanciar el componente
buffer #(.ROMFILE(ROMFILE))
  dut(
    .clk(clk),
    .tx(tx),
    .rx(rx)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("buffer_tb.vcd");
  $dumpvars(0, buffer_tb);

  # 140 $display("FIN de la simulacion");
  $finish;
end

endmodule
