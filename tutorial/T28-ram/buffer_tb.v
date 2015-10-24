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

//-- Baudios con los que realizar la simulacion
localparam BAUD = `B115200;
localparam DELAY = 10000;

//-- Tics de reloj para envio de datos a esa velocidad
//-- Se multiplica por 2 porque el periodo del reloj es de 2 unidades
localparam BITRATE = (BAUD << 1);

//-- Tics necesarios para enviar una trama serie completa, mas un bit adicional
localparam FRAME = (BITRATE * 11);

//-- Tiempo entre dos bits enviados
localparam FRAME_WAIT = (BITRATE * 4);


//-- Registro para generar la señal de reloj
reg clk = 0;
wire tx;
wire rx;
reg rstn = 0;

//-- Datos de salida del componente
wire [4:0] leds;

//-- Instanciar el componente
buffer #(.ROMFILE(ROMFILE), .BAUD(BAUD))
  dut(
    .clk(clk),
    .rstn(rstn),
    .tx(tx),
    .rx(rx),
    .leds(leds)
  );


//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("buffer_tb.vcd");
  $dumpvars(0, buffer_tb);

  # 20  rstn <= 1;


   #(FRAME * 20) $display("FIN de la simulacion");
  $finish;
end

endmodule
