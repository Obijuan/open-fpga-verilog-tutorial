//-----------------------------------------------------------------------------
// setbit.v
//-----------------------------------------------------------------------------
//- (C) BQ, August 2015
//- Written by Juan Gonzalez (Obijuan)
//- GPL License
//-----------------------------------------------------------------------------
//-- Componente "hola mundo" que simplemente pone a '1'
//-- su salida
//--  Es el ejemplo mas sencillo que se puede sintetizar en 
//--  la fpga. Su principal utilidad es comprobar que toda la cadena de 
//--  compilacion/sintesis/simulacion funciona correctamente
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//--  Modulo setbit
//--
//-- Definimos nuestro componente como un modulo que tiene solo una salida, que
//-- denominamos A. Este pin esta cableado a '1'
//-----------------------------------------------------------------------------
module setbit(output A);
wire A;

	//-- Implementacion: el pin esta cableado a '1'
  assign A = 1;

endmodule


