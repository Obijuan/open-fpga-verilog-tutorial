//-----------------------------------------------------------------------------
//-- Pruebas de conexionado del puerto serie
//-- Las señales dtr y rts se cablean a los leds
//-- La señal Rx y Tx se sacan por los pines de la FPGA para unirlos con un 
//-- cable exterior
//------------------------------------------------------------------------------
module echowire2(input wire dtr,
                 input wire rts,
                 input wire rx,
                 input wire tx2,
                 output wire tx,
                 output wire rx2,
                 output wire D1,
                 output wire D2);

//-- Sacar senal dtr y rts por los leds
assign D1 = dtr;
assign D2 = rts;

//-- Sacar señales tx y rx al exterior
assign rx2 = rx;
assign tx = tx2;

endmodule
