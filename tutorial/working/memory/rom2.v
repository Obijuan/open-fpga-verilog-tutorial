module rom_memory2 (input clk,
                   input wire [3:0] addr,
                   input wire rd,
                   output reg [3:0] data);

parameter ROMFILE = "rom2.list";

  //-- Memoria
  reg [3:0] rom [0:31];

  always @(negedge clk) begin
    data <= rom[addr];
  end
    
initial begin
  $readmemh(ROMFILE, rom);
end


endmodule


