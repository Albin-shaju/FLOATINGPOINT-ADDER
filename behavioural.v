
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
module FloatingPointAdder(
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] result
);

    // Internal signals for intermediate calculations
    reg [31:0] result_final;  
    reg [22:0] mantissa_a;       
    reg [22:0] mantissa_b;      
    reg [7:0] exponent_a;        
    reg [7:0] exponent_b;       
    reg [7:0] Modulo;    // Magnitude of the subtraction of exponents
    reg Borrow;          // Borrow flag for exponent subtraction
    reg [23:0] mux1out;  // Output of the right shifter unit
    reg [23:0] mux2out;  // Output of the adder top unit
    reg [23:0] outshift; // Output of the right shifter
    reg [4:0] shiftdiff; // Difference in exponents for right shifting
    reg [23:0] adderout; // Output of the 24-bit adder
    reg cout;            // Carry output of the 24-bit adder
    reg [7:0] maxexp;    // Maximum exponent for final exponent selection
    reg [7:0] exponent_final;  // Final exponent for the output
    reg [4:0] select;    // Selection lines for the final shifting
    reg [23:0] finalM;   // Final mantissa for the output

    // Extracting mantissa and exponent from the inputs
    always @*
    begin
        mantissa_a = A[22:0];
        mantissa_b = B[22:0];
        exponent_a = A[30:23];
        exponent_b = B[30:23];
    end

    // Calculation of the magnitude of the subtraction of the exponents
    always @*
    begin
        Modulo = (exponent_a > exponent_b) ? (exponent_a - exponent_b) : (exponent_b - exponent_a);
        Borrow = (exponent_a < exponent_b);
    end

    // Selecting the input with the lower exponent value for the right shifter unit
    always @*
    begin
        if (Borrow)
            mux1out = mantissa_a; // Right shift MB by 1 bit when Borrow is 1
        else
            mux1out = mantissa_b;      // Pass MB unchanged when Borrow is 0
    end

    // Performing 24-bit addition
    always @*
    begin
        if (Borrow)
            mux2out = mantissa_b; // Add 1 to MA when Borrow is 1
        else
            mux2out = mantissa_a;// Add MA and MB when Borrow is 0
    end

    // Performing right shifting based on the result of the exponent subtraction
    always @*
    begin
        outshift = mux1out >> Modulo[4:0];
    end

    // 24-bit adder (can be implemented as a single line, no behavioral needed)
    Adder_24Bit A1(mux2out, outshift, adderout, cout);

    // Determining the maximum exponent to be used as the final exponent
    always @*
    begin
        if (Borrow)
            maxexp = exponent_b;
        else
            maxexp = exponent_a;
    end

    // Calculating the exponent of the output based on the carry operation of the 24-bit adder
    always @*
    begin
        if (cout == 0)
            exponent_final = maxexp;
        else 
            exponent_final = maxexp +1;
    end

 
    // Performing the final shifting
    always @*
    begin
        finalM = (cout == 1) ? adderout >> 1 : adderout;
    end

    // Combining the sign, exponent, and mantissa to form the output
    always @*
    begin
        result[31] = 0;         
        result[30:23] = exponent_final; 
        result[22:0] = finalM;  
    end

endmodule

