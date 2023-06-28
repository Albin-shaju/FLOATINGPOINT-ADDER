`timescale 1ns / 1ps

module mux_24(
  input [23:0] a,b,
  input control,
  output [23:0] out);

  if(control == 0)
    out = a;
  else
    out = b;

endmodule
