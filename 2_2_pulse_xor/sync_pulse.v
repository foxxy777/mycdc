module sync_pulse (
    input  clka,
    input  clkb,
    input  ina,
    input  rsta,
    input  rstb,
    output outb
);
  wire xor_a;
  reg  toggle_a;
  always @(posedge clka or negedge rsta) begin
    if (~rsta) begin
      toggle_a <= 1'b0;
    end else begin
      toggle_a <= xor_a;
    end
  end
  assign xor_a = toggle_a ^ ina;
  wire ndff;
  macro_ndff u_macro_ndff (
      .clk(clkb),
      .rstn(rstb),
      .d(toggle_a),
      .q(ndff)
  );
  reg ndff_d;
  always @(posedge clkb or negedge rstb) begin
    if (~rstb) begin
      ndff_d <= 1'b0;
    end else begin
      ndff_d <= ndff;
    end
  end
  assign outb = ndff_d ^ ndff;
endmodule
