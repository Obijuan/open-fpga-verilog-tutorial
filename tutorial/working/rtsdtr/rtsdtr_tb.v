//-------------------------------------------------------------------
//-- sectones_tb.v
//-- Banco de pruebas para el secuenciador de 4 notas
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module rtsdtr_tb();

reg dtr = 0;
wire rts, led1, led2;


rtsdtr
  dut(
    .dtr(dtr),
    .rts(rts),
    .D1(led1),
    .D2(led2)
  );

always
  #1 dtr <= ~dtr;

assign rts = ~dtr;

//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("rtsdtr_tb.vcd");
  $dumpvars(0, rtsdtr_tb);

  # 200 $display("FIN de la simulacion");
  $finish;
end

endmodule

