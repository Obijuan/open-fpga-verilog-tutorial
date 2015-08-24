module div3(input wire clk_in, output wire clk_out);

reg [1:0] divcounter = 0;

//-- Contador módulo 3
always @(posedge clk_in)
  if (divcounter == 2) 
    divcounter <= 0;
  else 
    divcounter <= divcounter + 1;

//-- Sacar el bit mas significativo por clk_out
assign clk_out = divcounter[1];

endmodule

