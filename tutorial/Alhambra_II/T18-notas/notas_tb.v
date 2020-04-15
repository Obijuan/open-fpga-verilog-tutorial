//-------------------------------------------------------------------
//-- notas_tb.v
//-- Banco de pruebas para el generador de 8 notas
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------

module notas_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Salidas de los canales
wire ch0, ch1, ch2, ch3, ch4, ch5, ch6, ch7;


//-- Instanciar el componente y establecer el valor del divisor
//-- Se pone un valor bajo para simular (de lo contrario tardaria mucho)
notas #(2, 3, 4, 5, 6, 7, 8, 9)
  dut(
    .clk(clk),
    .ch0(ch0),
    .ch1(ch1),
    .ch2(ch2),
    .ch3(ch3),
    .ch4(ch4),
    .ch5(ch5),
    .ch6(ch6),
    .ch7(ch7)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("notas_tb.vcd");
  $dumpvars(0, notas_tb);

  # 200 $display("FIN de la simulacion");
  $finish;
end

endmodule

