module sync_pulse (
    input  clka,
    input  clkb,
    input  ina,
    input  rsta,
    input  rstb,
    output outb
);
  wire enable;
  assign enable = ina;
  wire pulse_2_level;
  reg  p2l_d;
  always @(posedge clka or negedge rsta) begin
    if (~rsta) begin
      p2l_d <= 1'b0;
    end else begin
      p2l_d <= pulse_2_level;
    end
  end
  assign pulse_2_level = enable ? ~p2l_d : p2l_d;
  wire ndff;
  macro_ndff u_macro_ndff (
      .clk(clkb),
      .rstn(rstb),
      .d(p2l_d),
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
