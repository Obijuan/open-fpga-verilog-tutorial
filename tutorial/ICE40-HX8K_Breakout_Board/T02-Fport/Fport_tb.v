//---------------------------------------------------
//-- Banco de prueba para Fport
//-- (c) BQ August 2015
//-- Written by Juan Gonzalez (obijuan)
//---------------------------------------------------
//-- GPL v2 license
//---------------------------------------------------


//-- Modulo para el test bench
module Fport_tb;

//-- Bus de 4 cables para conectarlos a la salida
//-- del componente Fport
wire [3:0] DATA;

//--Instanciar el componente. Conectado al cable DATA
Fport FP1 (
  .data (DATA)
);

//-- Comenzamos las pruebas
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("Fport_tb.vcd");
  $dumpvars(0, Fport_tb);

  //-- Pasadas 10 unidades de tiempo comprobamos
  //-- si el cable tiene el patron establecido
  # 10 if (DATA != 4'b1010)
    $display("---->¡ERROR! Salida Erronea");
  else
    $display("Componente ok!");

  //-- Terminar la simulacion 10 unidades de tiempo
  //-- despues
  # 10 $finish;
end

endmodule


