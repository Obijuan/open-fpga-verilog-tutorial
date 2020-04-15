//-------------------------------------------------------------------
//-- tristate1_tb.v
//-- Banco de pruebas para la puerta tri-estado
//-------------------------------------------------------------------
//-- BQ November 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL license
//-------------------------------------------------------------------

module tristate1_tb();

//-- Pausa pequeña: divisor
localparam DELAY = 4;

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Led a controlar
wire led0;

//-- Instanciar el componente
tristate1 #(.DELAY(DELAY))
  dut(
    .clk(clk),
    .led0(led0)
  );

//-- Generador de reloj. Periodo 2 unidades
always #1 clk = ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("tristate1_tb.vcd");
  $dumpvars(0, tristate1_tb);

  # 100 $display("FIN de la simulacion");
  $finish;
end

endmodule
