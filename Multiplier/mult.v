// Pipelined 8x8 Multiplier using Carry-Save Adder (CSA) Reduction,
// which is the practical implementation of the Wallace Tree.
// Latency: 4 Cycles.

module mult(
    input  wire         clk,
    input  wire         rst,      // Active-low reset
    input  wire [7:0]   a,
    input  wire [7:0]   b,
    output reg  [15:0]  product_out
);

    integer i_loop;

    // --- Pipelining Registers ---
    // Stage 1: Input Register
    reg [7:0] a_r1, b_r1;
    // Stage 2: Partial Products (64 bits)
    reg [15:0] PPs_r2 [7:0];
    // Stage 3: Sum and Carry vectors after 1st Reduction
    reg [15:0] S_r3 [1:0], C_r3 [1:0];
    reg [15:0] PPs_r3_remain [1:0]; 
    // Stage 4: Sum and Carry vectors after 2nd Reduction
    reg [15:0] S_r4, C_r4;

    // --- Stage 1: Register Inputs ---
    always @(posedge clk or negedge rst) begin
        if (!rst) begin a_r1 <= 0; b_r1 <= 0; end
        else begin a_r1 <= a; b_r1 <= b; end
    end

    // --- Stage 2: Partial Product Generation & Registration ---
    wire [15:0] PPs_w [7:0]; // 8 partial product vectors, 16 bits wide
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : pp_gen_and_shift
            // PPs_w[i] = (A[i] & B) shifted left by i bits.
            // The multiplication A[i] * B (8 bits) yields 8 bits (A[i] ? B : 0).
            // We zero-extend this 8-bit result to 16 bits, then shift it left by 'i'.
            assign PPs_w[i] = {{8{1'b0}}, a_r1[i] & b_r1} << i;
        end
    endgenerate

    // Register the PPs - MUST use 'integer' for procedural loop
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i_loop = 0; i_loop < 8; i_loop = i_loop + 1) PPs_r2[i_loop] <= 0;
        end else begin
            for (i_loop = 0; i_loop < 8; i_loop = i_loop + 1) PPs_r2[i_loop] <= PPs_w[i_loop];
        end
    end

    // --- Stage 3: First Layer of Reduction (8 vectors -> 4 vectors) ---
    wire [15:0] S_w3 [1:0], C_w3 [1:0];

    // Function to perform 3:2 CSA reduction (Sum/Carry generation)
    // Returns 32 bits: [31:16] for the Carry vector (shifted), [15:0] for the Sum vector.
    function automatic [2*16-1:0] csa_3_to_2;
        input [15:0] A, B, C;
        reg [15:0] sum_out;
        reg [15:0] carry_gen;
        reg [15:0] carry_out;
    begin
        // The 16-bit Sum vector (XOR operation)
        sum_out   = A ^ B ^ C;
        // The 16-bit Carry vector (Majority operation)
        carry_gen = (A & B) | (B & C) | (A & C);
        // The shifted carry vector C_out, which is 16 bits wide.
        // It drops the MSB carry (carry_gen[15]) and adds a LSB zero (1'b0).
        // This is equivalent to C << 1, where C is carry_gen
        carry_out = {carry_gen[14:0], 1'b0};
        // Output: {16-bit Carry_out, 16-bit Sum_out} -> Total 32 bits
        csa_3_to_2 = {carry_out, sum_out};
    end
    endfunction

    // 4 parallel reductions:
    // PPs 0,1,2 -> S_w3[0], C_w3[0]
    // PPs 3,4,5 -> S_w3[1], C_w3[1]
    assign {C_w3[0], S_w3[0]} = csa_3_to_2(PPs_r2[0], PPs_r2[1], PPs_r2[2]);
    assign {C_w3[1], S_w3[1]} = csa_3_to_2(PPs_r2[3], PPs_r2[4], PPs_r2[5]);

    // Register Sum/Carry pairs, and the remaining PPs
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            S_r3[0] <= 0; C_r3[0] <= 0;
            S_r3[1] <= 0; C_r3[1] <= 0;
            PPs_r3_remain[0] <= 0; PPs_r3_remain[1] <= 0;
        end else begin
            S_r3[0] <= S_w3[0]; C_r3[0] <= C_w3[0];
            S_r3[1] <= S_w3[1]; C_r3[1] <= C_w3[1];
            // The remaining two PPs are registered for the next stage
            PPs_r3_remain[0] <= PPs_r2[6];
            PPs_r3_remain[1] <= PPs_r2[7];
        end
    end

    // --- Stage 4: Final Reduction (6 vectors -> 2 vectors) & Registration ---
    // Vectors entering this stage: S_r3[0], C_r3[0], S_r3[1], C_r3[1], PPs_r3_remain[0], PPs_r3_remain[1]
    // First 3:2 reduction: (S_r3[0], C_r3[0], S_r3[1]) -> S_w4_a, C_w4_a
    wire [15:0] S_w4_a, C_w4_a;
    assign {C_w4_a, S_w4_a} = csa_3_to_2(S_r3[0], C_r3[0], S_r3[1]);

    // Second 3:2 reduction: (C_r3[1], PPs_r3_remain[0], PPs_r3_remain[1]) -> S_w4_b, C_w4_b
    wire [15:0] S_w4_b, C_w4_b;
    assign {C_w4_b, S_w4_b} = csa_3_to_2(C_r3[1], PPs_r3_remain[0], PPs_r3_remain[1]);

    // Let the last stage handle the addition of the four final vectors.
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            S_r4 <= 0; C_r4 <= 0;
        end else begin
            // S_r4 holds the accumulated Sum of the two reduction results
            S_r4 <= S_w4_a + S_w4_b; // This is a 16-bit addition (faster than a 4:2 compressor, relying on synthesis)
            // C_r4 holds the accumulated Carry of the two reduction results
            C_r4 <= C_w4_a + C_w4_b; // This is a 16-bit addition
        end
    end

    // --- Stage 5: Final Carry Propagate Adder (CPA) ---
    // The delay here is the full 16-bit CPA, but it has multiple cycles of slack built in.
    wire [15:0] final_sum_w = S_r4 + C_r4;

    always @(posedge clk or negedge rst) begin
        if (!rst)
            product_out <= 0;
        else
            product_out <= final_sum_w;
    end

endmodule