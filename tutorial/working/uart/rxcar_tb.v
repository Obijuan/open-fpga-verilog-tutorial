//-------------------------------------------------------------------
//-- Banco de pruebas para probar la UART
//-- Se envían los bits en serie
//-------------------------------------------------------------------
//-- BQ September 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------
`include "baudgen.vh"

module rxcar_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;


//-- Cables para las pruebas
reg rx = 1;
wire act;
wire [3:0] leds;

//-- Instanciar el modulo de Eco
rxcar #(.BAUD(`B115200))
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
  #204 rx <= 1;   //-- Bit 0
  #204 rx <= 0;   //-- Bit 1
  #204 rx <= 1;   //-- Bit 2
  #204 rx <= 0;   //-- Bit 3
  #204 rx <= 1;   //-- Bit 4
  #204 rx <= 0;   //-- Bit 5
  #204 rx <= 1;   //-- Bit 6
  #204 rx <= 0;   //-- Bit 7
  #204 rx <= 1;   //-- Bit stop

  # 4000 $display("FIN de la simulacion");
  $finish;
end

endmodule

