module mult #(
    parameter WIDTH = 8
)(
    input  wire                clk,
    input  wire                rst,
    input  wire [WIDTH-1:0]    a,
    input  wire [WIDTH-1:0]    b,
    output reg [2*WIDTH-1:0]   product
);

    // -------------------------------------------------------
    // Stage 1: Register inputs
    // -------------------------------------------------------
    reg [WIDTH-1:0] a_reg, b_reg;
    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            a_reg <= 0; 
            b_reg <= 0; 
        end else begin
            a_reg <= a; 
            b_reg <= b; 
        end
    end

    // Slice 2-bit groups
    wire [1:0] a0 = a_reg[1:0], a1 = a_reg[3:2], a2 = a_reg[5:4], a3 = a_reg[7:6];
    wire [1:0] b0 = b_reg[1:0], b1 = b_reg[3:2], b2 = b_reg[5:4], b3 = b_reg[7:6];

    // -------------------------------------------------------
    // Stage 2: first 8 partial products (4-bit each)
    // -------------------------------------------------------
    reg [3:0] pp2[0:7];
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pp2[0] <= 0; pp2[1] <= 0; pp2[2] <= 0; pp2[3] <= 0;
            pp2[4] <= 0; pp2[5] <= 0; pp2[6] <= 0; pp2[7] <= 0;
        end else begin
            pp2[0] <= a0 * b0;
            pp2[1] <= a0 * b1;
            pp2[2] <= a0 * b2;
            pp2[3] <= a0 * b3;
            pp2[4] <= a1 * b0;
            pp2[5] <= a1 * b1;
            pp2[6] <= a1 * b2;
            pp2[7] <= a1 * b3;
        end
    end

    // -------------------------------------------------------
    // Stage 3: next 8 partial products
    // -------------------------------------------------------
    reg [3:0] pp3[0:15];
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i=0;i<16;i++) pp3[i] <= 0;
        end else begin
            for (int i=0;i<8;i++) pp3[i] <= pp2[i];
            pp3[8]  <= a2 * b0;
            pp3[9]  <= a2 * b1;
            pp3[10] <= a2 * b2;
            pp3[11] <= a2 * b3;
            pp3[12] <= a3 * b0;
            pp3[13] <= a3 * b1;
            pp3[14] <= a3 * b2;
            pp3[15] <= a3 * b3;
        end
    end

    // -------------------------------------------------------
    // Stage 4: group additions (8-bit regs)
    // -------------------------------------------------------
    reg [7:0] g1_4, g2_4;
    always @(posedge clk or posedge rst) begin
        if (rst) begin g1_4 <= 0; g2_4 <= 0; end
        else begin
            g1_4 <= {4'b0, pp3[1]} + {4'b0, pp3[4]};                 // extend 4->8 bits
            g2_4 <= {4'b0, pp3[2]} + {4'b0, pp3[5]} + {4'b0, pp3[8]}; // extend 4->8 bits
        end
    end

    // -------------------------------------------------------
    // Stage 5: group additions (8-bit regs)
    // -------------------------------------------------------
    reg [7:0] g1_5, g2_5, g3_5, g4_5, g5_5;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            g1_5<=0; g2_5<=0; g3_5<=0; g4_5<=0; g5_5<=0;
        end else begin
            g1_5 <= g1_4;
            g2_5 <= g2_4;
            g3_5 <= {4'b0, pp3[3]} + {4'b0, pp3[6]} + {4'b0, pp3[9]} + {4'b0, pp3[12]};
            g4_5 <= {4'b0, pp3[7]} + {4'b0, pp3[10]} + {4'b0, pp3[13]};
            g5_5 <= {4'b0, pp3[11]} + {4'b0, pp3[14]};
        end
    end

    // -------------------------------------------------------
    // Stage 6: partial sums (20-bit regs)
    // -------------------------------------------------------
    reg [19:0] part0_6, part1_6, save_pp0_6;
    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            part0_6 <= 0; 
            part1_6 <= 0; 
            save_pp0_6 <= 0; 
        end else begin
            save_pp0_6 <= pp3[0]; 
            part0_6 <= {16'b0, pp3[0]} + ({12'b0, g1_5} << 2);
            part1_6 <= ({12'b0, g2_5} << 4) + ({12'b0, g3_5} << 6);
        end
    end

    // -------------------------------------------------------
    // Stage 7: part2
    // -------------------------------------------------------
    reg [19:0] part2_7, part0_7, part1_7;
    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            part0_7 <= 0; part1_7 <= 0; part2_7 <= 0;
        end else begin
            part0_7 <= part0_6;
            part1_7 <= part1_6;
            part2_7 <= ({12'b0, g4_5} << 8) + ({12'b0, g5_5} << 10) + ({16'b0, pp3[15]} << 12);
        end
    end

    // -------------------------------------------------------
    // Stage 8: add part0 + part1
    // -------------------------------------------------------
    reg [19:0] mid_8, part2_8;
    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            mid_8 <= 0; 
            part2_8 <= 0; 
        end else begin
            mid_8 <= part0_7 + part1_7;
            part2_8 <= part2_7;
        end
    end

    // -------------------------------------------------------
    // Stage 9: final sum
    // -------------------------------------------------------
    reg [19:0] sum_9;
    always @(posedge clk or posedge rst) begin
        if (rst)
            sum_9 <= 0;
        else
            sum_9 <= mid_8 + part2_8;
    end

    // -------------------------------------------------------
    // Stage 10: truncate to 16 bits
    // -------------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst)
            product <= 0;
        else
            product <= sum_9[15:0];
    end

endmodule
