module col_idct (
    input clk,
    input reset,
    input wire signed [31:0] in0, // blk[0] variable in C code
    input wire signed [31:0] in1, // blk[8*4]
    input wire signed [31:0] in2, // blk[8*6]
    input wire signed [31:0] in3, // blk[8*2]
    input wire signed [31:0] in4, // blk[8*1]
    input wire signed [31:0] in5, // blk[8*7]
    input wire signed [31:0] in6, // blk[8*5]
    input wire signed [31:0] in7, // blk[8*3]
    output reg signed [31:0] y0, // y0 to y7 are the final outputs.
    output reg signed [31:0] y1,
    output reg signed [31:0] y2,
    output reg signed [31:0] y3,
    output reg signed [31:0] y4,
    output reg signed [31:0] y5,
    output reg signed [31:0] y6,
    output reg signed [31:0] y7,
    output reg rdy
);

    // reg signed [31:0] y0;
    // reg signed [31:0] y1;
    // reg signed [31:0] y2;
    // reg signed [31:0] y3;
    // reg signed [31:0] y4;
    // reg signed [31:0] y5;
    // reg signed [31:0] y6;
    // reg signed [31:0] y7;

    // wire signed [31:0] in0;
    // wire signed [31:0] in1;
    // wire signed [31:0] in2;
    // wire signed [31:0] in3;
    // wire signed [31:0] in4;
    // wire signed [31:0] in5;
    // wire signed [31:0] in6;
    // wire signed [31:0] in7;

    wire signed [31:0] i0;
    wire signed [31:0] i1;
    wire signed [31:0] i2;
    wire signed [31:0] i3;
    wire signed [31:0] i4;
    wire signed [31:0] i5;
    wire signed [31:0] i6;
    wire signed [31:0] i7;

    wire signed [31:0] t0;
    wire signed [31:0] t1;
    wire signed [31:0] t2;
    wire signed [31:0] t3;
    wire signed [31:0] t4;
    wire signed [31:0] t5;
    wire signed [31:0] t6;
    wire signed [31:0] t7;
    wire signed [31:0] t8;
    wire signed [31:0] t9;
    wire signed [31:0] t10;
    wire signed [31:0] t11;
    wire signed [31:0] t12;
    wire signed [31:0] t13;
    wire signed [31:0] t14;
    wire signed [31:0] t15;

    wire signed [31:0] i21;
    wire signed [31:0] i31;
    wire signed [31:0] i41;
    wire signed [31:0] i51;
    wire signed [31:0] i61;
    wire signed [31:0] i71;

    wire signed [31:0] i011;
    wire signed [31:0] i111;
    wire signed [31:0] i211;
    wire signed [31:0] i311;
    wire signed [31:0] i411;
    wire signed [31:0] i511;
    wire signed [31:0] i611;
    wire signed [31:0] i711;
    wire signed [31:0] i811;

    wire signed [31:0] i0111;
    wire signed [31:0] i4111;
    wire signed [31:0] i8111;

    wire signed [31:0] p0;
    wire signed [31:0] p1;
    wire signed [31:0] p2;
    wire signed [31:0] p3;
    wire signed [31:0] p4;
    wire signed [31:0] p5;
    wire signed [31:0] p6;
    wire signed [31:0] p7;

    wire signed [31:0] yc0;
    wire signed [31:0] yc1;
    wire signed [31:0] yc2;
    wire signed [31:0] yc3;
    wire signed [31:0] yc4;
    wire signed [31:0] yc5;
    wire signed [31:0] yc6;
    wire signed [31:0] yc7;

    wire signed [31:0] alt_out;
    wire signed [31:0] alt_out_clipped;

    reg [9:0] ctr;
    //reg rdy;

    always @(posedge clk) begin
        if(reset) begin
            ctr <= 0;
            rdy <= 0;
            {y0, y1, y2, y3, y4, y5, y6, y7} <= {8{32'b0}};
        end
        else begin
            ctr <= ctr + !rdy;
            if(!(i1 | i2 | i3 | i4 | i5 | i6 | i7)) begin
                {y0, y1, y2, y3, y4, y5, y6, y7} <= {8{alt_out_clipped}};
                if(ctr < 3) begin
                    rdy <= 0;
                end
                else begin
                    rdy <= 1;
                end
            end
            else begin
                {y0, y1, y2, y3, y4, y5, y6, y7} <= {yc0, yc1, yc2, yc3, yc4, yc5, yc6, yc7};
                if(ctr < 17) begin
                    rdy <= 0;
                end
                else begin
                    rdy <= 1;
                end
            end
        end
    end

    assign i0 = (in0 << 8) + 8192; // x0 = (blk[0] << 8) + 8192;
    assign i1 = in1 << 8;          // x1 = blk[8*4] << 8;
    assign i2 = in2;               // x2 = blk[8*6];
    assign i3 = in3;               // x3 = blk[8*2];
    assign i4 = in4;               // x4 = blk[8*1];
    assign i5 = in5;               // x5 = blk[8*7];
    assign i6 = in6;               // x6 = blk[8*5];
    assign i7 = in7;               // x7 = blk[8*3];

    assign alt_out = ((in0 + 32) >>> 6) + 128; // ((blk[0] + 32) >> 6) + 128;
    assign alt_out_clipped = (alt_out[31]) ? 0 : ((|alt_out[30:8]) ? 255 : alt_out); // njClip(((blk[0] + 32) >> 6) + 128);
    
    assign t0 = i4 + i5;                                                                                    // x4 + x5;
    assign t1 = t0 + (t0 << 2) + (t0 << 4) + (t0 << 5) + (t0 << 9) + 4;                                     // x8 = (x4 + x5)*W7 + 4;
    assign t2 = (i4 << 2) + (i4 << 5) + (i4 << 6) + (i4 << 7) + (i4 << 11);                                 // x4*(W1 - W7);
    assign t3 = (i5 << 1) + (i5 << 2) + (i5 << 3) + (i5 << 6) + (i5 << 8) + (i5 << 10) + (i5 << 11);        // x5*(W1 + W7);
    assign t4 = i6 + i7;                                                                                    // x6 + x7;
    assign t5 = (t4 << 3) + (t4 << 5) + (t4 << 6) + (t4 << 8) + (t4 << 11) + 4;                             // x8 = (x6 + x7)*W3 + 4;
    assign t6 = i6 + (i6 << 1) + (i6 << 2) + (i6 << 3) + (i6 << 4) + (i6 << 8) + (i6 << 9);                 // x6*(W3 - W5);
    assign t7 = i7 + (i7 << 4) + (i7 << 5) + (i7 << 7) + (i7 << 8) + (i7 << 9) + (i7 << 10) + (i7 << 11);   // x7*(W3 + W5);
    assign t8 = i2 + i3;                                                                                    // x2 + x3;
    assign t9 = (t8 << 2) + (t8 << 4) + (t8 << 6) + (t8 << 10) + 4;                                         // x1 = (x2 + x3)*W6 + 4;
    assign t10 = (i2 << 3) + (i2 << 6) + (i2 << 7) + (i2 << 9) + (i2 << 10) + (i2 << 11);                   // x2*(W2 + W6);
    assign t11 = (i3 << 5) + (i3 << 9) + (i3 << 10);                                                        // x3*(W2 - W6);

    assign i21 = (t9 - t10) >>> 3; // x2 = (x1 - (W2 + W6) * x2) >> 3;
    assign i31 = (t9 + t11) >>> 3; // x3 = (x1 + (W2 - W6) * x3) >> 3;
    assign i41 = (t1 + t2) >>> 3;  // x4 = (x8 + (W1 - W7) * x4) >> 3;
    assign i51 = (t1 - t3) >>> 3;  // x5 = (x8 - (W1 + W7) * x5) >> 3;
    assign i61 = (t5 - t6) >>> 3;  // x6 = (x8 - (W3 - W5) * x6) >> 3;
    assign i71 = (t5 - t7) >>> 3;  // x7 = (x8 - (W3 + W5) * x7) >> 3;

    assign i011 = i0 - i1;    // x0 -= x1;
    assign i811 = i0 + i1;    // x8 = x0 + x1;
    assign i111 = i41 + i61;  // x1 = x4 + x6;
    assign i311 = i011 + i21; // x3 = x0 + x2;
    assign i411 = i41 - i61;  // x4 -= x6;
    assign i511 = i51 - i71;  // x5 -= x7;
    assign i611 = i51 + i71;  // x6 = x5 + x7;
    assign i711 = i811 + i31; // x7 = x8 + x3;
    assign t12 = i411 + i511;                                                   // (x4 + x5)
    assign t13 = t12 + (t12 << 2) + (t12 << 4) + (t12 << 5) + (t12 << 7) + 128; // (181 * (x4 + x5) + 128)
    assign t14 = i411 - i511;                                                   // (x4 - x5)
    assign t15 = t14 + (t14 << 2) + (t14 << 4) + (t14 << 5) + (t14 << 7) + 128; // (181 * (x4 - x5) + 128)

    assign i0111 = i011 - i21; // x0 -= x2;
    assign i211 = t13 >>> 8;   // x2 = (181 * (x4 + x5) + 128) >> 8;
    assign i4111 = t15 >>> 8;  // x4 = (181 * (x4 - x5) + 128) >> 8;
    assign i8111 = i811 - i31; // x8 -= x3;

    assign p0 = ((i711 + i111) >>> 14) + 128;   // ((x7 + x1) >> 14) + 128
    assign p1 = ((i311 + i211) >>> 14) + 128;   // ((x3 + x2) >> 14) + 128
    assign p2 = ((i0111 + i4111) >>> 14) + 128; // ((x0 + x4) >> 14) + 128
    assign p3 = ((i8111 + i611) >>> 14) + 128;  // ((x8 + x6) >> 14) + 128
    assign p4 = ((i8111 - i611) >>> 14) + 128;  // ((x8 - x6) >> 14) + 128
    assign p5 = ((i0111 - i4111) >>> 14) + 128; // ((x0 - x4) >> 14) + 128
    assign p6 = ((i311 - i211) >>> 14) + 128;   // ((x3 - x2) >> 14) + 128
    assign p7 = ((i711 - i111) >>> 14) + 128;   // ((x7 - x1) >> 14) + 128

    assign yc0 = (p0[31]) ? 0 : ((|p0[30:8]) ? 255 : p0); // doing the njClip function.
    assign yc1 = (p1[31]) ? 0 : ((|p1[30:8]) ? 255 : p1);
    assign yc2 = (p2[31]) ? 0 : ((|p2[30:8]) ? 255 : p2);
    assign yc3 = (p3[31]) ? 0 : ((|p3[30:8]) ? 255 : p3);
    assign yc4 = (p4[31]) ? 0 : ((|p4[30:8]) ? 255 : p4);
    assign yc5 = (p5[31]) ? 0 : ((|p5[30:8]) ? 255 : p5);
    assign yc6 = (p6[31]) ? 0 : ((|p6[30:8]) ? 255 : p6);
    assign yc7 = (p7[31]) ? 0 : ((|p7[30:8]) ? 255 : p7);
    
    
endmodule