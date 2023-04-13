module macro_mux_ndff (
    input clk,
    input [7:0] data,  //data of clka
    input en,  //en of clka
    input rstn,  //rstn of clkb
    output reg [7:0] data_sync
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
      data_sync <= 8'd0;
    end else if (en_sync) begin
      data_sync <= data;
    end
  end
endmodule
