`default_nettype none

module baudgen(
  input wire clk,
  input wire resetq,
  input wire [31:0] baud,
  input wire restart,
  output wire ser_clk);
  parameter CLKFREQ = 12000000;

  wire [38:0] aclkfreq = CLKFREQ;
  reg [38:0] d;
  wire [38:0] dInc = d[38] ? ({4'd0, baud}) : (({4'd0, baud}) - aclkfreq);
  wire [38:0] dN = restart ? 0 : (d + dInc);
  wire fastclk = ~d[38];
  assign ser_clk = fastclk;

  always @(negedge resetq or posedge clk)
  begin
    if (!resetq) begin
      d <= 0;
    end else begin
      d <= dN;
    end
  end
endmodule

/*

-----+     +-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+----
     |     |     |     |     |     |     |     |     |     |     |     |
     |start|  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |stop1|stop2|
     |     |     |     |     |     |     |     |     |     |     |  ?  |
     +-----+-----+-----+-----+-----+-----+-----+-----+-----+           +

*/


module rxuart(
   input wire clk,
   input wire resetq,
   input wire [31:0] baud,
   input wire uart_rx,      // UART recv wire
   input wire rd,           // read strobe
   output wire valid,       // has data 
   output wire [7:0] data); // data
  parameter CLKFREQ = 12000000;

  reg [4:0] bitcount;
  reg [7:0] shifter;

  // On starting edge, wait 3 half-bits then sample, and sample every 2 bits thereafter

  wire idle = &bitcount;
  wire sample;
  reg [2:0] hh = 3'b111;
  wire [2:0] hhN = {hh[1:0], uart_rx};
  wire startbit = idle & (hhN[2:1] == 2'b10);
  wire [7:0] shifterN = sample ? {hh[1], shifter[7:1]} : shifter;

  wire ser_clk;
  baudgen #(.CLKFREQ(CLKFREQ)) _baudgen(
    .clk(clk),
    .baud({baud[30:0], 1'b0}),
    .resetq(resetq),
    .restart(startbit),
    .ser_clk(ser_clk));

  assign valid = (bitcount == 18);
  reg [4:0] bitcountN;
  always @*
    if (startbit)
      bitcountN = 0;
    else if (!idle & !valid & ser_clk)
      bitcountN = bitcount + 5'd1;
    else if (valid & rd)
      bitcountN = 5'b11111;
    else
      bitcountN = bitcount;

  // 3,5,7,9,11,13,15,17
  assign sample = (bitcount > 2) & bitcount[0] & !valid & ser_clk;
  assign data = shifter;

  always @(negedge resetq or posedge clk)
  begin
    if (!resetq) begin
      hh <= 3'b111;
      bitcount <= 5'b11111;
      shifter <= 0;
    end else begin
      hh <= hhN;
      bitcount <= bitcountN;
      shifter <= shifterN;
    end
  end
endmodule


