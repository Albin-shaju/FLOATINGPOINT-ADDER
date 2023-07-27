
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2023 10:21:17 PM
// Design Name: 
// Module Name: floating_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module floating_adder(
    input [31:0] a,b,
    output reg [31:0] result
    );
    
    wire [22:0] m_a,m_b;
    wire [7:0] e_a,e_b;
    wire s_a,s_b;
    
    assign s_a = a[31];
    assign s_b = b[31];
    assign e_a = a[30:23];
    assign e_b = b[30:23];
    assign m_a = a[22:0];
    assign m_b = b[22:0];
     
  wire [7:0] sub_result;
  wire borrow;
  always @(e_a,e_b)
    begin
      sub_result = e_a - e_b;
      if(e_a < e_b)
        borrow = 1;
    end

  wire [23:0] mux1out,mux2out;
  if(e_
    
endmodule
