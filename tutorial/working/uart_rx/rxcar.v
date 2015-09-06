

module rxcar(input wire clk, input wire rx, output wire [7:0] rxdata, output wire act);


reg rstn = 0;
wire [7:0] data;



uart_rx UART_RX (
    .clk(clk), 
    .rstn(rstn),
    .rx(rx),
    .data(data)
  );

//-- Sacar dato recibido por los leds
assign rxdata = data;

//-- Sacar actividad por led verde
assign act = rx;

//-- Inicializador
always @(posedge(clk)) begin
  rstn <= 1;
end


endmodule




  
