//-------------------------------------------------------------------
//-- inv_tb.v  Banco de pruebas para el inversor
//-------------------------------------------------------------------
//-- (c) BQ August 2015. Written by Juan Gonzalez
//-------------------------------------------------------------------
//-- GPL LICENSE
//-------------------------------------------------------------------
//-- Pruebas del inversor. Se instancia el inversor. Se conecta un 
//-- cable a su salida y un registro a su entrada. Desde el programa
//-- principal se dan valores a las entradas (mediante din) y se
//-- comprueba si la salida es la correcta
//-------------------------------------------------------------------
module inv_tb();


//-- Registro de 1 bit conectado a la entrada del inversor
reg din;

//-- Cable conectado a la salida del inversor
wire dout;

//-- Instaciar el inversor, conectado din a la entrada A, y dout a la salida B
inv NOT1 (
 .IN (din),
 .LED8 (dout)
);

//-- Comenzamos las pruebas
initial begin

  //-- Fichero donde almacenar los resultados
  $dumpfile("inv_tb.vcd");
  $dumpvars(0, inv_tb);

  //-- Ponemos la entrada del inversor a 0
  //-- OJO! Esto lo estamos haciendo a partir del instante 5.
  //-- Antes su estado es indefinido, por lo que la salida tambien
  //-- estará en un estado indefinido
  #5 din = 0;
  
  //-- Tras 5 unidades de tiempo comprobamos la salida
  # 5 if (dout != 1)
    $display("---->¡ERROR! Esperado: 1. Leido: %d", dout);

  //-- Tras otras 5 unidades ponemos un 1 en la entrada
  # 5 din = 1;

  //-- Tras 5 unidades comprobamos si hay un 0 en la entrada
  # 5 if (dout != 0)
    $display("---> ¡ERROR! Esperado: 0. Leido: %d", dout);

  # 5 $display("FIN de la simulacion");

  //-- Terminar la simulacion 10 unidades de tiempo
  //-- despues
  # 10 $finish;
end

endmodule
