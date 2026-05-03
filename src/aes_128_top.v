
module aes_128_top (
    input  clk,
    input  [127:0] plaintext,
    input  [127:0] master_key,
    output reg [127:0] ciphertext
);
    // 1. Pipelined Key Expansion Registers
    reg [127:0] k [0:10];
    wire [127:0] next_k [1:10];

    always @(posedge clk) k[0] <= master_key;

    // Expand keys cycle-by-cycle
    key_expansion_round rk1  (k[0], 8'h01, next_k[1]);
    always @(posedge clk) k[1] <= next_k[1];

    key_expansion_round rk2  (k[1], 8'h02, next_k[2]);
    always @(posedge clk) k[2] <= next_k[2];

    key_expansion_round rk3  (k[2], 8'h04, next_k[3]);
    always @(posedge clk) k[3] <= next_k[3];

    key_expansion_round rk4  (k[3], 8'h08, next_k[4]);
    always @(posedge clk) k[4] <= next_k[4];

    key_expansion_round rk5  (k[4], 8'h10, next_k[5]);
    always @(posedge clk) k[5] <= next_k[5];

    key_expansion_round rk6  (k[5], 8'h20, next_k[6]);
    always @(posedge clk) k[6] <= next_k[6];

    key_expansion_round rk7  (k[6], 8'h40, next_k[7]);
    always @(posedge clk) k[7] <= next_k[7];

    key_expansion_round rk8  (k[7], 8'h80, next_k[8]);
    always @(posedge clk) k[8] <= next_k[8];

    key_expansion_round rk9  (k[8], 8'h1b, next_k[9]);
    always @(posedge clk) k[9] <= next_k[9];

    key_expansion_round rk10 (k[9], 8'h36, next_k[10]);
    always @(posedge clk) k[10] <= next_k[10];

    // 2. Data Path (Remains registered as before)
    reg [127:0] r_state [0:10];
    wire [127:0] next_state [1:10];

    always @(posedge clk) r_state[0] <= plaintext ^ k[0];

    genvar i;
    generate
        for (i = 1; i < 10; i = i + 1) begin : main_rounds
            aes_round r_inst (r_state[i-1], k[i], next_state[i]);
            always @(posedge clk) r_state[i] <= next_state[i];
        end
    endgenerate

    aes_final_round rf (r_state[9], k[10], next_state[10]);
    always @(posedge clk) ciphertext <= next_state[10];

endmodule



