module mpres(input clk_in, output D1, output D2, output D3, output D4);
wire clk_in;
wire D1;
wire D2;
wire D3;
wire D4;

//-- Bits para los diferentes prescalers
parameter N0 = 21;  //-- Prescaler base
parameter N1 = 1;
parameter N2 = 2;
parameter N3 = 1;
parameter N4 = 2;

wire clk_base;

//-- Prescaler base
prescaler #(.N(N0))  
  Pres0(
	  .clk_in(clk_in),
	  .clk_out(clk_base)
  );

//-- Canal 1: Prescaler 1
prescaler #(.N(N1))
  Pres1(
    .clk_in(clk_base),
    .clk_out(D1)
  );

//-- Canal 2: Prescaler 2
prescaler #(.N(N2))
  Pres2(
    .clk_in(clk_base),
    .clk_out(D2)
  );

//-- Canal 3: Prescaler 3
prescaler #(.N(N3))
  Pres3(
    .clk_in(clk_base),
    .clk_out(D3)
  );

//-- Canal 4: Prescaler 4
prescaler #(.N(N4))
  Pres4(
    .clk_in(clk_base),
    .clk_out(D4)
  );

endmodule


