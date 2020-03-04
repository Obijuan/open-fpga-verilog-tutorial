//---------------------------------------------------------
//-- counter.v  
//-- Contador de 26 bits
//---------------------------------------------------------
//-- BQ  August 2015. Written by Juan Gonzalez (Obijuan)
//---------------------------------------------------------
//-- GPL license
//---------------------------------------------------------


//-----------------------------------
//-- Entrada: señal de reloj
//-- Salida: contador de 26 bits
//-----------------------------------
module counter(input clk, output [3:0] data);
  wire clk;

  //-- La salida es un registro de 26 bits
  //-- inicializado a 16777214 para testbench
  //-- (0011)1111111111111111111110
  reg [25:0] counter = 16777214;

  assign data = counter[25:22];

  //-- Sensible al flanco de subida
  always @(posedge clk) begin
    //-- Incrementar el registro
    counter <= counter + 1;
  end

`ifdef FORMAL
  assert property (data[3:0] == counter[25:22]);
`endif

endmodule
