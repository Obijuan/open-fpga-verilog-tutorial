//-----------------------------------------------------------------------------
//-- Banco de prueba para setbit
//-- (c) BQ August 2015
//-- Written by Juan Gonzalez (obijuan)
//-- mods by D. Cuartielles for Arduino, 2015 December, GPLv3
//-----------------------------------------------------------------------------
//-- Para la simulacion del componente es necesario hacer un banco de pruebas
//-- que coloque el componente, asigne valor a las entradas y compruebe las
//-- salidas. En el caso del compoente setbit, es muy sencillo. Solo tiene
//-- una salida, así que colocamos un cable a su salida y comprobamos que
//-- efectivamente se encuentra a valor 1
//-----------------------------------------------------------------------------

//-- Modulo para el test bench
module setbit_tb;

//-- Cable para conectar al componente que pone
//-- el bit a uno
wire LED1;

//--Instanciar el componente. Conectado al cable A
setbit SB1 (
  .LED1 (LED1)
);

//-- Comenzamos las pruebas
initial begin

  //-- Definir el fichero donde volvar los datos
  //-- para ver graficamente la salida
  $dumpfile("T01-setbit_tb.vcd");

  //-- Volcar todos los datos a ese fichero
  $dumpvars(0, setbit_tb);

  //-- Pasadas 10 unidades de tiempo comprobamos
  //-- si el cable esta a 1
  //-- En caso de no estar a 1, se informa del problema, pero la
  //-- simulacion no se detiene
  # 10 if (LED1 != 1)
    $display("---->¡ERROR! Salida no esta a 1");
  else
    $display("Componente ok!");

  //-- Terminar la simulacion 10 unidades de tiempo
  //-- despues
  # 10 $finish;
end


endmodule
