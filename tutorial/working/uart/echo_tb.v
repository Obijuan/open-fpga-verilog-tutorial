//-------------------------------------------------------------------
//-- sectones_tb.v
//-- Banco de pruebas para el secuenciador de 4 notas
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module echo_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;


//-- Salida de la uart
wire tx;
reg rx = 1;
wire act;
wire [3:0] leds;

echo
  dut(
    .clk(clk),
    .tx(tx),
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
  $dumpfile("echo_tb.vcd");
  $dumpvars(0, echo_tb);

  #20 rx <= 0;    //-- Bit start dato 1
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

