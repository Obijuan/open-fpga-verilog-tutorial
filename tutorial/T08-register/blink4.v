//--------------------------------------------------------------
//--  blink4.v
//--  (C) BQ. August 2015. Written by Juan Gonzalez (obijuan)
//--------------------------------------------------------------
//-- Parpadeo de los 4 leds usando un registro de 4 bits
//--------------------------------------------------------------

module blink4(input wire clk,           //--Reloj
              output wire [3:0] data    //-- Salida del registro
             );

//-- Bits para el prescaler
parameter N = 22;

//-- Reloj principal (prescalado)
wire clk_base;

//-- Datos del registro
reg [3:0] dout = 0;

//-- Cable de entrada al registro
wire [3:0] din;


//-- Instanciar el prescaler
prescaler #(.N(N))
  PRES (
    .clk_in(clk),
    .clk_out(clk_base)
  );

//-- Registro
always @(posedge(clk_base))
  dout <= din;

//-- Puerta NOT entra la salida y la entrada
assign din = ~dout;

//-- Sacar datos del registro por la salida
assign data = dout;

endmodule

