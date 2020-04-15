//-------------------------------------------------------------------
//-- countsec_tb.v
//-- Banco de pruebas para el contador de segundos
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module countsec_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;
wire [3:0] data;


//-- Instanciar el componente y establecer el valor del divisor
//-- Se pone un valor bajo para simular (sino tardaria mucho)
countsec #(10)
  dut(
    .clk(clk),
    .data(data)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("countsec_tb.vcd");
  $dumpvars(0, countsec_tb);

  # 100 $display("FIN de la simulacion");
  $finish;
end

endmodule

