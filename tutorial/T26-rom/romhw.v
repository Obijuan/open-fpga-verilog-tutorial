`default_nettype none


module romhw (input wire clk,
              output wire [3:0] leds);

//-- Instanciar la memoria rom
rom32x4 
  ROM (
        .clk(clk),
        .addr(4'h5),
        .data(leds)
      );


endmodule



