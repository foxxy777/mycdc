module hs_syn (
    input  clkA,
    input  clkB,
    input  resetA,
    input  resetB,
    input  inA,
    output outB_level,
    output outB_pulse,
    output busy
);
  reg inA_level, after_mux;
  wire ack;
  always @(*) begin
    if (inA) begin
      after_mux = 1'b1;
    end else begin
      if (ack) begin
        after_mux = 1'b0;
      end else begin
        after_mux = inA_level;
      end
    end
  end
  always @(posedge clkA or negedge resetA) begin
    if (resetA) begin
      inA_level <= 1'b0;
    end else begin
      inA_level <= after_mux;
    end
  end
  macro_ndff u_ndff_1 (
      .clk(clkB),
      .rstn(resetB),
      .d(inA_level),
      .q(outB_level)
  );
  macro_ndff u_ndff_2 (
      .clk(clkA),
      .rstn(resetA),
      .d(outB_level),
      .q(ack)
  );
  //add outB pulse and busy signal
  reg outB_d;
  always @(posedge clkB or negedge resetB) begin
    if (~resetB) outB_d <= 1'b0;
    else outB_d <= outB_level;
  end
  assign outB_pulse = outB_level & (!outB_d);
  assign busy = inA_level || ack;
endmodule
