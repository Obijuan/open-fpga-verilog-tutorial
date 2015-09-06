//-------------------------------------------------------------------
//-- sectones_tb.v
//-- Banco de pruebas para el secuenciador de 4 notas
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module rxcar_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Salida de la uart
reg rx = 1;
wire [7:0] rxdata;

rxcar
  dut(
    .clk(clk),
    .rx(rx),
    .rxdata(rxdata),
    .act()
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("rxcar_tb.vcd");
  $dumpvars(0, rxcar_tb);

  #200 rx <= 0;    //-- Bit start dato 1
  #204 rx <= 1;   //-- Bit 0
  #204 rx <= 0;   //-- Bit 1
  #204 rx <= 1;   //-- Bit 2
  #204 rx <= 0;   //-- Bit 3
  #204 rx <= 1;   //-- Bit 4
  #204 rx <= 0;   //-- Bit 5
  #204 rx <= 1;   //-- Bit 6
  #204 rx <= 0;   //-- Bit 7
  #204 rx <= 1;   //-- Bit stop

  #2000 rx <= 0;   //-- Bit start DATO 2
  #204 rx <= 0;   //-- Bit 0
  #204 rx <= 1;   //-- Bit 1
  #204 rx <= 0;   //-- Bit 2
  #204 rx <= 1;   //-- Bit 3
  #204 rx <= 0;   //-- Bit 4
  #204 rx <= 1;   //-- Bit 5
  #204 rx <= 0;   //-- Bit 6
  #204 rx <= 1;   //-- Bit 7
  #204 rx <= 1;   //-- Bit stop


  # 40000 $display("FIN de la simulacion");
  $finish;
end

endmodule

