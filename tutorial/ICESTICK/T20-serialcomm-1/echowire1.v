//-----------------------------------------------------------------------------
//-- Pruebas de conexionado del puerto serie
//-- Las señales dtr y rts se cablean a los leds
//-- La señal Rx se conecta a Tx para que se haga un eco a nivel fisico
//------------------------------------------------------------------------------
module echowire1(input wire dtr,
                 input wire rts,
                 input wire rx,
                 output wire tx,
                 output wire D1,
                 output wire D2);

//-- Sacar senal dtr y rts por los leds
assign D1 = dtr;
assign D2 = rts;

//-- Conectar rx a tx para que se haga un eco "cableado"
assign tx = rx;

endmodule
