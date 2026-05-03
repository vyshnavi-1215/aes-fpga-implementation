

`timescale 1ns / 1ps

module aes_top_tb;

    // Inputs
    reg clk;
    reg [127:0] plaintext;
    reg [127:0] master_key;

    // Outputs
    wire [127:0] ciphertext;

    // Instantiate the Unit Under Test (UUT)
    aes_128_top uut (
        .clk(clk),
        .plaintext(plaintext),
        .master_key(master_key),
        .ciphertext(ciphertext)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        plaintext = 0;
        master_key = 0;

        // Wait for global reset
        #100;
        
        // --- Test Case 1: NIST Standard Vector ---
        // Key: 000102030405060708090a0b0c0d0e0f
        // Plaintext: 00112233445566778899aabbccddeeff
        // Expected Ciphertext (after latency): 69c4e0d86a7b0430d8cdb78070b4c55a
        
        master_key = 128'h000102030405060708090a0b0c0d0e0f;
        plaintext  = 128'h00112233445566778899aabbccddeeff;

        // Note: Because of your pipelined key expansion and data path,
        // it takes roughly 11-12 cycles for the valid ciphertext to appear.
        
        repeat (15) @(posedge clk);
        
        $display("Time: %0t | Key: %h", $time, master_key);
        $display("Time: %0t | PT:  %h", $time, plaintext);
        $display("Time: %0t | CT:  %h", $time, ciphertext);

        #100;
        $finish;
    end
      
endmodule
