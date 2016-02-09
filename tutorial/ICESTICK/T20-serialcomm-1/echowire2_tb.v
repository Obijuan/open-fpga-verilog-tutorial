//-------------------------------------------------------------------
//-- echowire2_tb.v
//-- Banco de pruebas para el eco cableado del puerto serie y las 
//-- comprobaciones de las señales DTR y RTS
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module echowire2_tb();

//-- Declaracion de los cables
reg dtr = 0;
reg rts = 0;
reg rx = 0;
wire tx, led1, led2;
wire tx2, rx2;
wire extwire;

//-- Instanciar el componente
echowire2
  dut(
    .dtr(dtr),
    .rts(rts),
    .D1(led1),
    .D2(led2),
    .tx2(tx2),
    .rx2(rx2),
    .tx(tx),
    .rx(rx)
  );

//-- Generar cambios en dtr. Los mismos deben reflejarse en el cable D1
always
  #2 dtr <= ~dtr;

//-- Generar cambios en rts. Se deben reflejar en el cable D2
always
  #3 rts = ~rts;

//-- Generar cambios en rs. Se reflejan en TX
always
  #1 rx <= ~rx;

//-- Conectar el cable externo
assign tx2 = rx2;

//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("echowire2_tb.vcd");
  $dumpvars(0, echowire2_tb);

  # 200 $display("FIN de la simulacion");
  $finish;
end

endmodule

