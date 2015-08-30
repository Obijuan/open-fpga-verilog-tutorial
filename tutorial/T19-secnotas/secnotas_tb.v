//-------------------------------------------------------------------
//-- tones_tb.v
//-- Banco de pruebas para el generador de 4 tonos
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module secnotas_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Salidas de los canales
wire ch_out;


//-- Instanciar el componente y establecer el valor del divisor
//-- Se pone un valor bajo para simular (de lo contrario tardaria mucho)
secnotas #(2, 3, 4, 6, 24)
  dut(
    .clk(clk),
    .ch_out(ch_out)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("secnotas_tb.vcd");
  $dumpvars(0, secnotas_tb);

  # 200 $display("FIN de la simulacion");
  $finish;
end

endmodule

