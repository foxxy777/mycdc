module macro_mux_ndff_no_en (
    input clk,  //clkb
    input [7:0] data,  //data of clka
    input rstnb,  //rstn of clkb
    input rstna,  //rstn of clka
    input clka,
    output reg [7:0] data_sync
);
  reg [7:0] data_d;
  always @(posedge clka, negedge rstna) begin
    if (~rstna) begin
      data_d <= 8'b0;
    end else begin
      data_d <= data;
    end
  end
  wire data_same;
  assign data_same = (data_d == data) ? 1'b1 : 1'b0;
  reg en_d;
  always @(posedge clka, negedge rstna) begin
    if (~rstna) begin
      en_d <= 1'b0;
    end else begin
      en_d <= data_same;
    end
  end
  wire en_r;
  assign en_r = ~en_d & data_same;
  wire en_sync;
  sync_pulse_mux u_sync_pulse_mux (
      .clka(clka),
      .clkb(clk),
      .ina (en_r),
      .rsta(rstna),
      .rstb(rstnb),
      .outb(en_sync)
  );
  always @(posedge clk or negedge rstnb) begin
    if (~rstnb) begin
      data_sync <= 8'd0;
    end else if (en_sync) begin
      data_sync <= data;
    end
  end
endmodule
