

module prescaler(input clk_in, output clk_out);
wire clk_in;
wire clk_out;

//-- Numero de bits del prescaler (por defecto)
parameter N = 22;

reg [N-1:0] count = 0;

assign clk_out = count[N-1];

always @(posedge(clk_in)) begin
  count <= count + 1;
end

endmodule
