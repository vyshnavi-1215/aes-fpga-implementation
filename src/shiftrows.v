
module shiftrows (
    input  [127:0] state_in,
    output [127:0] state_out
);

// Extract bytes (MSB first)
wire [7:0] b [0:15];

assign { b[0],  b[1],  b[2],  b[3],
         b[4],  b[5],  b[6],  b[7],
         b[8],  b[9],  b[10], b[11],
         b[12], b[13], b[14], b[15] } = state_in;


// Correct AES ShiftRows (COLUMN-WISE)
assign state_out = {
    b[0],  b[5],  b[10], b[15],   // Column 0
    b[4],  b[9],  b[14], b[3],    // Column 1
    b[8],  b[13], b[2],  b[7],    // Column 2
    b[12], b[1],  b[6],  b[11]    // Column 3
};

endmodule
