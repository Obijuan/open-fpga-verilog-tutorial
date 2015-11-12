//-------------------------------------------------------------------
//-- genromleds_tb.v
//-- Banco de pruebas para el secuenciador de luces, implementado con
//-- una memoria rom generica
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module microbio_tb();

//-- Para la simulacion se usa un periodo de 2 ciclos de reloj
parameter CPU_PERIOD = 3;
parameter ROMFILE = "prog1.list";

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Datos de salida del componente
wire [3:0] leds;
wire stop;
reg rstn = 0;

//-- Instanciar el componente
microbio #(.CPU_PERIOD(CPU_PERIOD), .ROMFILE(ROMFILE))
  dut(
    .clk(clk),
    .rstn_ini(rstn),
    .leds(leds),
    .stop(stop)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("microbio_tb.vcd");
  $dumpvars(0, microbio_tb);

  #2 rstn <= 1;

  # 140 $display("FIN de la simulacion");
  $finish;
end

endmodule
