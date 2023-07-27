`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2023 11:02:12 PM
// Design Name: 
// Module Name: adder_24
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


module Adder_24Bit(
    input [23:0] A,
    input [23:0] B,
    output reg [23:0] sum,
    output reg carry_out
);

    always @* begin
        {carry_out, sum} = A + B;
    end

endmodule
