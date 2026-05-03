
module aes_final_round (
    input  [127:0] state_in,
    input  [127:0] round_key,
    output [127:0] state_out
);
    wire [127:0] sb, sr;

    // 1. PPRM SubBytes Step
    subbytes step1 (
        .state_in(state_in), 
        .state_out(sb)
    );

    // 2. ShiftRows Step
    shiftrows   step2 (sb, sr);

    // 3. AddRoundKey Step (Using your XOR module)
    addroundkey step3 (
        .state_in(sr), 
        .round_key(round_key), 
        .state_out(state_out)
    );

endmodule
