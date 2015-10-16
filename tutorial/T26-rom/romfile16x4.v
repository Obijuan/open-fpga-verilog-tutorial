module romfile16x4 (input clk,
                    input wire [3:0] addr,
                    output reg [3:0] data);

parameter ROMFILE = "rom1.list";

  //-- Memoria
  reg [3:0] rom [0:31];

  always @(negedge clk) begin
    data <= rom[addr];
  end

initial begin
  $readmemh(ROMFILE, rom);
end


endmodule
