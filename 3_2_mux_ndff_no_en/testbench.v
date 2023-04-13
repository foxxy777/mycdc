// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps
module testbench ();
  reg  clka;
  reg  clkb;
  reg  rsta;
  reg  rstb;
  reg  ina;
  wire outb;
  parameter PERIODA = 1ns;
  parameter PERIODB = 3ns;
  initial begin
    clka = 0;
    forever #(PERIODA / 2) clka = ~clka;
  end
  initial begin
    clkb = 0;
    forever #(PERIODB / 2) clkb = ~clkb;
  end
  template u_template (
      .clka(clka),
      .clkb(clkb),
      .rstn(rstn),
      .en(en),
      .data(data),
      .data_sync(data_sync)
  );
  integer i;
  initial begin
    rstn = 1'b1;
    en   = 1'b0;
    #1;
    rstn = 1'b0;
    #1;
    rstn = 1'b1;
    #1;
    data = 8'h55;
    en   = 1'b1;
    #16.5;
    en = 1'b0;
    #6;
    data = 8'hFF;
    en   = 1'b1;
    #3;
    en = 1'b0;
    #6;
    data = 8'hAC;
    en   = 1'b1;
    #20 $finish;
  end
endmodule
