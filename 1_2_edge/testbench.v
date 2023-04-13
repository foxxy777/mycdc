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
      .rsta(rsta),
      .rstb(rstb),
      .a(ina),
      .out(outb)
  );
  integer i;
  initial begin
    ina  = 1'b0;
    rsta = 1'b1;
    rstb = 1'b1;
    #1;
    rsta = 1'b0;
    rstb = 1'b0;
    #1;
    rsta = 1'b1;
    rstb = 1'b1;
    #2;
    ina = 1'b1;
    #1;
    ina = 1'b0;
    #30;
    ina = 1'b1;
    #4.5;
    ina = 1'b0;
    #30;
    $finish;
  end
endmodule
