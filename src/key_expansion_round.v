
module key_expansion_round (
    // input clk,            // REMOVED: No longer needed for combinational logic
    input  [127:0] prev_key,
    input  [7:0]   rcon,
    output [127:0] next_key
);
    wire [31:0] w0, w1, w2, w3;
    wire [31:0] sub_out;
    wire [31:0] g_out;

    assign {w0, w1, w2, w3} = prev_key;

    // S-Box instances are now strictly combinational
    // Note: Ensure you removed 'clk' from your sbox_lut module ports too!
    sbox_lut sb0 ( .in(w3[23:16]), .out(sub_out[31:24]) );
    sbox_lut sb1 ( .in(w3[15:8]),  .out(sub_out[23:16]) );
    sbox_lut sb2 ( .in(w3[7:0]),   .out(sub_out[15:8])  );
    sbox_lut sb3 ( .in(w3[31:24]), .out(sub_out[7:0])   );

    assign g_out = sub_out ^ {rcon, 24'b0};

    // AES Key Schedule XOR logic
    assign next_key[127:96] = w0 ^ g_out;
    assign next_key[95:64]  = w1 ^ next_key[127:96];
    assign next_key[63:32]  = w2 ^ next_key[95:64];
    assign next_key[31:0]   = w3 ^ next_key[63:32];
endmodule

