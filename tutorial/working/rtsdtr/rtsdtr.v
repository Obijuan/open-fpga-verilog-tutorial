module rtsdtr(input wire dtr,
              input wire rts,
              output wire D1,
              output wire D2);

assign D1 = dtr;
assign D2 = rts;

endmodule
