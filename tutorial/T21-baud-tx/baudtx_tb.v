//-------------------------------------------------------------------
//-- sectones_tb.v
//-- Banco de pruebas para el secuenciador de 4 notas
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------
`include "baudgen.vh"

module baudtx_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Salida de la uart
wire tx;
reg dtr = 0;

baudtx #( .BAUD(`B115200), .DELAY(4000) )
  dut(
    .clk(clk),
    .load(dtr),
    .tx(tx)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("baudtx_tb.vcd");
  $dumpvars(0, baudtx_tb);

  #10 dtr <= 0;
  #300 dtr <= 1;
 
  #20000 dtr <=0;

  #30000 dtr <=1;

  # 40000 $display("FIN de la simulacion");
  $finish;
end

endmodule

