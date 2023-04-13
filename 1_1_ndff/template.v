module template (
    input  clka,
    input  clkb,
    input  a,
    input  rsta,
    input  rstb,
    output out
);
  reg dffa, dffb;
  always @(posedge clka) begin
    dffa <= a;
  end
  wire sync_w;
  macro_ndff u_macro_ndff (
      .clk(clkb),
      .rstn(rstb),
      .d(dffa),
      .q(sync_w)
  );
  always @(posedge clkb) begin
    dffb <= sync_w;
  end
  assign out = dffb;
endmodule
