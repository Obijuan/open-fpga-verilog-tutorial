//-------------------------------------------------------------------
//-- sectones_tb.v
//-- Banco de pruebas para el secuenciador de 4 notas
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module echowire1_tb();

reg dtr = 0;
reg rts = 0;
reg rx = 0;
wire tx, led1, led2;


echowire1
  dut(
    .dtr(dtr),
    .rts(rts),
    .D1(led1),
    .D2(led2),
    .tx(tx),
    .rx(rx)
  );

always
  #2 dtr <= ~dtr;

always
  #3 rts = ~rts;

always
  #1 rx <= ~rx;

//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("echowire1_tb.vcd");
  $dumpvars(0, echowire1_tb);

  # 200 $display("FIN de la simulacion");
  $finish;
end

endmodule

