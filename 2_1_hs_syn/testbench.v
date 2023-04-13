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
  hs_syn u_hs_syn (
      .clkA(clkA),
      .clkB(clkB),
      .resetA(resetA),
      .resetB(resetB),
      .inA(inA),
      .outB_level(outB_level),
      .outB_pulse(outB_pulse),
      .busy(busy)
  );
  integer i;
  initial begin
    inA = 1'b0;
    resetA = 1'b1;
    resetB = 1'b1;
    #1;
    resetA = 1'b0;
    resetB = 1'b0;
    #1;
    resetA = 1'b1;
    resetB = 1'b1;
    #1;
    inA = 1'b1;
    #1;
    inA = 1'b0;
    #30;
    inA = 1'b1;
    #7;
    inA = 1'b0;
    #30;
    inA = 1'b1;
    #20;
    inA = 1'b0;
    #30;

    for (i = 0; i < 20; i = i + 1) begin
      $display("Current loop#%0d ", i);
      #1;
      inA = 1'b1;
      #1;
      inA = 1'b0;
    end
    #20 $finish;
  end
endmodule
