/*
module init(input wire clk, output wire ini);

wire din;
reg dout = 0;

//-- Registro
always @(posedge(clk))
  dout <= din;

//-- Entrada conectadad a 1
assign din = 1;

//-- Conectar la salida
assign ini = dout;

endmodule
*/

module init(input wire clk, output ini);
reg ini = 0;
  
always @(posedge(clk))
  ini <= 1;

endmodule



