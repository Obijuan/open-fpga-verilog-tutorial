//-----------------------------------------------------------------------------
//-- inv.v  Puerta NOT
//-- (c) BQ August 2015. Written by Juan Gonzalez (Obijuan)
//-- GPL v2 License
//-----------------------------------------------------------------------------
//-- Ejemplo de una puerta not, con una entrada y una salida
//-- Es un circuito combinacional
//-----------------------------------------------------------------------------


//-- Definir el modulo con una entrada y una salida
module inv(input IN, output LED8);

//-- Tanto la entrada como la salida son "cables"
wire IN;
wire LED8;

  //-- Asignar a la salida la entrada negada
  assign LED8 = ~IN;

endmodule
