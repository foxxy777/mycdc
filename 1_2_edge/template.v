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
    if (~rsta) begin
      dffa <= 1'b0;
    end else begin
      dffa <= a;
    end
  end
  rising_edge u_rising_edge (
      .clkb (clkb),
      .dataa(dffa),
      .rstb (rstb),
      .doutb(out)
  );
endmodule
