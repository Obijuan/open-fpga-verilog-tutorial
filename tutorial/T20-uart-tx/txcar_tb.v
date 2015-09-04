//-------------------------------------------------------------------
//-- sectones_tb.v
//-- Banco de pruebas para el secuenciador de 4 notas
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module txcar_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Salida de la uart
wire tx;
wire led;

txcar #(.DELAY(4000) )
  dut(
    .clk(clk),
    .tx(tx),
    .D1(led)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("txcar_tb.vcd");
  $dumpvars(0, txcar_tb);

  # 40000 $display("FIN de la simulacion");
  $finish;
end

endmodule

