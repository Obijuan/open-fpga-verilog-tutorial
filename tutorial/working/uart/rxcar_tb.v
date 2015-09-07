//-------------------------------------------------------------------
//-- Banco de pruebas para probar la UART
//-- Se envían los bits en serie
//-------------------------------------------------------------------
//-- BQ September 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------
`include "baudgen.vh"

`define BA

`define BITRATE (`BAUD)

module rxcar_tb();

localparam BAUD = `B19200;

//-- Tics de reloj para envio de datos a esa velocidad
//-- Se multiplica por 2 porque el periodo del reloj es de 2 unidades
localparam BITRATE = (BAUD << 1);

//-- Registro para generar la señal de reloj
reg clk = 0;


//-- Cables para las pruebas
reg rx = 1;
wire act;
wire [3:0] leds;

//-- Instanciar el modulo de Eco
rxcar #(.BAUD(BAUD))
  dut(
    .clk(clk),
    .rx(rx),
    .act(act),
    .leds(leds)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("rxcar_tb.vcd");
  $dumpvars(0, rxcar_tb);

  //-- Enviar el dato de prueba 0x55:  01010101
  #20 rx <= 0;    //-- Bit start 
  # BITRATE rx <= 1;   //-- Bit 0
  # BITRATE rx <= 0;   //-- Bit 1
  # BITRATE rx <= 1;   //-- Bit 2
  # BITRATE rx <= 0;   //-- Bit 3
  # BITRATE rx <= 1;   //-- Bit 4
  # BITRATE rx <= 0;   //-- Bit 5
  # BITRATE rx <= 1;   //-- Bit 6
  # BITRATE rx <= 0;   //-- Bit 7
  # BITRATE rx <= 1;   //-- Bit stop

  # BITRATE rx <= 1;

  # 4000 $display("FIN de la simulacion");
  $finish;
end

endmodule

