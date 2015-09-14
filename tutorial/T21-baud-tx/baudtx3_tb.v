//-------------------------------------------------------------------
//-- baudtx3_tb.v
//-- Banco de pruebas para la tranmision de datos periodica
//-------------------------------------------------------------------
//-- BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-------------------------------------------------------------------
//-- GPL License
//-------------------------------------------------------------------
`include "baudgen.vh"

module baudtx3_tb();

//-- Registro para generar la señal de reloj
reg clk = 0;

//-- Linea de tranmision
wire tx;


//-- Instanciar el componente para que funcione a 115200 baudios
baudtx3 #(.BAUD(`B115200), .DELAY(4000))
  dut(
    .clk(clk),
    .tx(tx)
  );

//-- Generador de reloj. Periodo 2 unidades
always 
  # 1 clk <= ~clk;


//-- Proceso al inicio
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("baudtx3_tb.vcd");
  $dumpvars(0, baudtx3_tb);

  #40000 $display("FIN de la simulacion");
  $finish;
end

endmodule

