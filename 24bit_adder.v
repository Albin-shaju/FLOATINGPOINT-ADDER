module 24bit_adder(
  input [23:0] a,b,
  output [23:0] sum
  output carry);

{carry,sum} = a + b;

endmodule
