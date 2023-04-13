module rising_edge (
    input  clkb,
    input  dataa,
    input  rstb,
    output doutb
);
  wire sync_w;
  macro_ndff u_macro_ndff (
      .clk(clkb),
      .rstn(rstb),
      .d(dataa),
      .q(sync_w)
  );
  reg sync_d;
  always @(posedge clkb) begin
    if (~rstb) begin
      sync_d <= 1'b0;
    end else begin
      sync_d <= sync_w;
    end
  end

  assign doutb = (~sync_d) & sync_w;
endmodule
