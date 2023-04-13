module macro_ndff (
    clk,
    rstn,
    d,
    q
);
  input clk, rstn, d;
  output q;
  reg dff1, dff2;
  always @(posedge clk or negedge rstn) begin
    if (~rstn) {dff2, dff1} <= 2'b0;
    else {dff2, dff1} <= {dff1, d};
  end
  assign q = dff2;
endmodule
