module sync_pulse_mux (
    input  clka,
    input  clkb,
    input  ina,
    input  rsta,
    input  rstb,
    output outb
);
  wire enable;
  assign enable = ina;
  wire mux_a;
  reg  toggle_a;
  always @(posedge clka or negedge rsta) begin
    if (~rsta) begin
      toggle_a <= 1'b0;
    end else begin
      toggle_a <= mux_a;
    end
  end
  assign mux_a = enable ? ~toggle_a : toggle_a;
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
  assign outb = ndff ^ dndff;
endmodule
