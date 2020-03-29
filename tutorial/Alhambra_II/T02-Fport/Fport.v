//--------------------------------------------------
//-- Fixed Port
//-- Sacar un valor fijo de 4 bits
//--------------------------------------------------
//-- (c) BQ August 2015
//-- Written by Juan Gonzalez (obijuan)
//--------------------------------------------------
//-- Licensed under the GPL v2
//--------------------------------------------------


//-- El modulo tiene un bus de 4 bits de salida
//-- En verilog los arrays se define usando la notacion
//-- [B:b] donde B es el numero de bit de mayor peso y
//-- b el de menor
module Fport(output [3:0] data);

//-- La salida del modulo son 4 cables
wire [3:0] data;

  //-- Sacar el valor por el bus de salida
  //-- En verilog se indica primero el numero de bits
  //-- y luego el formato (binario, hexa, decimal, etc...)
	//-- Para sacar el valor en hexa hay que poner: 4'h4
  assign data = 4'b1010; //-- 4'hA

endmodule


