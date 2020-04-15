//-------------------------------------------------------------------
//-- txtest3_tb.v
//-- Banco de pruebas para la tranmision de datos
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------
`include "baudgen.vh"
`include "divider.vh"


module txtest3_tb();

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

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Linea de tranmision
wire tx;

//-- Instanciar el componente
txtest3 #(.BAUD(BAUD), .DELAY(4000))
  dut(
    .clk(clk),
    .tx(tx)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("txtest3_tb.vcd");
  $dumpvars(0, txtest3_tb);


  #(FRAME * 10) $display("FIN de la simulacion");

  $finish;
end

endmodule

