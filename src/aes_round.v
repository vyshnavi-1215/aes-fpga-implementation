
module aes_round (
    input  [127:0] state_in,
    input  [127:0] round_key,
    output [127:0] state_out
);
    wire [127:0] sb, sr, mc;

    // STEP 1: Replace LUT-based SubBytes with your PPRM version
    subbytes step1 (
        .state_in(state_in), 
        .state_out(sb)
    );

    // STEP 2: ShiftRows (Stays the same)
    shiftrows step2 (
        .state_in(sb), 
        .state_out(sr)
    );

    // STEP 3: MixColumns (Stays the same)
    mixcolumns step3 (
        .state_in(sr), 
        .state_out(mc)
    );

    // STEP 4: AddRoundKey (Stays the same)
    // Note: Most designs use a simple XOR here: assign state_out = mc ^ round_key;
    addroundkey step4 (
        .state_in(mc), 
        .round_key(round_key), 
        .state_out(state_out)
    );

endmodule
