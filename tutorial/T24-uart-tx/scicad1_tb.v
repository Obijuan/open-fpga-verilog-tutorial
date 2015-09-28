//-------------------------------------------------------------------
//-- uart_tx_test1_tb.v
//-- Banco de pruebas para la tranmision de datos
//-------------------------------------------------------------------
//-- BQ September 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------
`include "baudgen.vh"


module uart_tx_test1_tb();

//-- Baudios con los que realizar la simulacion
//-- A 300 baudios, la simulacion tarda mas en realizarse porque los
//-- tiempos son mas largos. A 115200 baudios la simulacion es mucho
//-- mas rapida
localparam BAUD = `B115200;

//-- Tics de reloj para envio de datos a esa velocidad
//-- Se multiplica por 2 porque el periodo del reloj es de 2 unidades
localparam BITRATE = (BAUD << 1);

//-- Tics necesarios para enviar una trama serie completa, mas un bit adicional
localparam FRAME = (BITRATE * 11);

//-- Tiempo entre dos bits enviados
localparam FRAME_WAIT = (BITRATE * 4);

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Linea de tranmision
wire tx;

//-- Simulacion de la señal dtr
reg dtr = 0;

//-- Instanciar el componente
uart_tx_test1 #(.BAUD(BAUD))
  dut(
    .clk(clk),
    .dtr(dtr),
    .tx(tx)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("uart_tx_test1_tb.vcd");
  $dumpvars(0, uart_tx_test1_tb);

  #1 dtr <= 0;

  //-- Enviar primer caracter
  #FRAME_WAIT dtr <= 1;
  #(BITRATE * 2) dtr <=0;

  //-- Segundo envio (2 caracteres mas)
  #(FRAME_WAIT * 2) dtr <=1;
  #(FRAME * 1) dtr <=0;

  #(FRAME_WAIT * 4) $display("FIN de la simulacion");
  $finish;
end

endmodule

