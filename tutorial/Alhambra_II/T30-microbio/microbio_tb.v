//-------------------------------------------------------------------
//-- microbio_tb
//-- Banco de pruebas para el microprocesador MICROBIO
//-------------------------------------------------------------------
//-- BQ November 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------

module microbio_tb();

//-- Para la simulacion se usa un WAIT_DELAY de 3 ciclos de reloj
parameter WAIT_DELAY = 3;
parameter ROMFILE = "prog.list";

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Datos de salida del componente
wire [3:0] leds;
wire stop;
reg rstn = 0;

//-- Instanciar el componente
microbio #(.WAIT_DELAY(WAIT_DELAY), .ROMFILE(ROMFILE))
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

  # 160 $display("FIN de la simulacion");
  $finish;
end

endmodule
