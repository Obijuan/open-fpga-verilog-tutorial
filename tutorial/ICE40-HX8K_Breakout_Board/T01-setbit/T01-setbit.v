//-----------------------------------------------------------------------------
// setbit.v
//-----------------------------------------------------------------------------
//- (C) D. Cuartielles for Arduino, December 2015
//- GPLv3 License
//- based on previous work by Obijuan for BQ
//-----------------------------------------------------------------------------
//-- Componente "hola mundo" que simplemente pone a '1' su salida
//--  Es el ejemplo mas sencillo que se puede sintetizar en
//--  la fpga. Su principal utilidad es comprobar que toda la cadena de
//--  compilacion/sintesis/simulacion funciona correctamente
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//--  Modulo setbit
//--
//-- Definimos nuestro componente como un modulo que tiene solo una salida, que
//-- denominamos LED1. Este pin esta cableado a '1'
//-- para evitar que las otras salidas queden a nivel de voltaje incierto, hay
//-- que declararlas y asignarles una salida a nivel '0'
//-----------------------------------------------------------------------------
module setbit(
  output LED1,
  output LED2,
  output LED3,
  output LED4,
  output LED5,
  output LED6,
  output LED7,
  output LED8
);

  wire LED1;
  wire LED2;
  wire LED3;
  wire LED4;
  wire LED5;
  wire LED6;
  wire LED7;
  wire LED8;

	//-- Implementacion: el pin deseado esta cableado a '1'
  //                   los demas estan cableados a '0'
  assign LED1 = 1;
  assign LED2 = 0;
  assign LED3 = 0;
  assign LED4 = 0;
  assign LED5 = 0;
  assign LED6 = 0;
  assign LED7 = 0;
  assign LED8 = 0;

endmodule
