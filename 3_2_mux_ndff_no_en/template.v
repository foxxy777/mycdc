module template (
    input clka,
    input clkb,
    input [7:0] data,  //data of clka
    input en,  //en of clka
    input rstn,  //rstn of clkb
    output reg [7:0] data_sync
);
  reg en_dff;
  always @(posedge clka) begin
    en_dff <= en;
  end
  reg [7:0] data_dff;
  always @(posedge clka) begin
    data_dff <= data;
  end
  macro_mux_ndff_no_en u_macro_mux_ndff_no_en (
      .clk(clkb),
      .data(data_dff),
      .en(en_dff),
      .rstn(rstn),
      .data_sync(data_sync)
  );
endmodule
