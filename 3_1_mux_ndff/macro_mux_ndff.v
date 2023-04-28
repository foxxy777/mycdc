module macro_mux_ndff #(
    MUXNDFF_WIDTH = 8
) (
    input clk,
    input [MUXNDFF_WIDTH-1:0] data,  //data of clka
    input en,  //en of clka
    input rstn,  //rstn of clkb
    output reg [MUXNDFF_WIDTH-1:0] data_sync
);
  wire en_sync;
  macro_ndff u_macro_ndff (
      .clk(clk),
      .rstn(rstn),
      .d(en),
      .q(en_sync)
  );
  always @(posedge clk or negedge rstn) begin
    if (~rstn) begin
      data_sync <= {MUXNDFF_WIDTH{1'b0}};
    end else if (en_sync) begin
      data_sync <= data;
    end
  end
endmodule
