// Filename        : rowidct.v
// Description     : Aim to compute the critical time
// Author          : Bachotti Sai Krishna Shanmukh EE19B009
// Professor       : Nitin Chandrachoodan

`timescale 1 ns / 1ps
// Assumptions :
// Addition with 2 inputs has a delay of 10 ns and shift delay is 10 ns
// Maximum Hardware is utilized to achieve parallelization and least time for critical path

module rowidct (
    input clk,
    input reset,
    input [31:0] x0,  //blk[0]
    input [31:0] x1,  //blk[4] 
    input [31:0] x2,  //blk[6]
    input [31:0] x3,  //blk[2]
    input [31:0] x4,  //blk[1]
    input [31:0] x5,  //blk[7]
    input [31:0] x6,  //blk[5]
    input [31:0] x7,  //blk[3]
    output [31:0] y0,
    output [31:0] y1,
    output [31:0] y2,
    output [31:0] y3,
    output [31:0] y4,
    output [31:0] y5,
    output [31:0] y6,
    output [31:0] y7,
    output rdy
);
    
    wire signed [31:0] x0,x1,x2,x3,x4,x5,x6,x7;
    wire signed [31:0] add1a,add1b,add1c;
    wire signed [31:0] mul1a,mul1b,mul1c;
    wire signed [31:0] mul2a,mul2b,mul2c;
    wire signed [31:0] mul3a,mul3b,mul3c;
    wire signed [31:0] mul4,mul5;
    
    wire signed [31:0] x01,x21,x31,x41,x51,x61,x71,x11,x22,x44,x1000;
    wire signed [31:0] sum01,sum46,sum57,sum013,sum012,a,b;
    wire signed [31:0] diff01,diff46,diff57,diff013,diff012;
    
    wire flag;
    wire signed [31:0] yc0,yc1,yc2,yc3,yc4,yc5,yc6,yc7;
    //reg signed [31:0] Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7;
    reg signed [31:0] y0,y1,y2,y3,y4,y5,y6,y7;
    reg rdy;
    reg [4:0] ctr;
    
    assign #20 x01 = (x0 << 11) + 128;
    
    assign #10 add1a = x4 + x5;
    assign #40 mul1a = (add1a << 9) + (add1a << 5) + (add1a << 4) + (add1a << 2) + add1a; //w7 * add1a;
    assign #40 mul2a = (x4 << 11) + (x4 << 7) + (x4 << 6) + (x4 << 5) + (x4 << 2) ;//(w1-w7)*x4;
    assign #40 mul3a = (x5 << 11) + (x5 << 10) + (x5 << 8) + (x5 << 6) + (x5 << 3) + (x5 << 2) + (x5 << 1); //(w1+w7)*x3;
    assign #10 x41 = mul1a + mul2a;
    assign #10 x51 = mul1a - mul3a;
    
    assign #10 add1b = x6 + x7;
    assign #40 mul1b = (add1b << 11) + (add1b << 8) + (add1b << 6) + (add1b << 5) + (add1b << 3); //w3*add1b;
    assign #40 mul2b = (x6 << 9) + (x6 << 8) + (x6 << 4) + (x6 << 3) + (x6 << 2) + (x6 << 1) + x6;//(w3-w5) * x6;
    assign #40 mul3b = (x7 << 11) + (x7 << 10) + (x7 << 9) + (x7 << 8) + (x7 << 7) + (x7 << 5) + (x7 << 4) + x7; //(w3+w5) * x7;
    assign #10 x61 = mul1b - mul2b;
    assign #10 x71 = mul1b - mul3b;
    
    assign #10 add1c = x2 + x3;
    assign #30 mul1c = (add1c << 10) + (add1c << 6) + (add1c << 4) + (add1c << 2); //w6 * add1c;
    assign #40 mul2c = (x2 << 11) + (x2 << 10) + (x2 << 9) + (x2 << 7) + (x2 << 6)+ (x2 << 3); //(w2 +w6)  *x2;
    assign #30 mul3c = (x3 << 10) + (x3 << 9) + (x3 << 5); //(w2 - w6) *x3;
    assign #10 x21 = mul1c - mul2c;
    assign #10 x31 = mul1c + mul3c;
    
    assign #10 x11 = x1 << 11;
    assign #10 sum01 = x01 + x11;
    assign #10 diff01 = x01 - x11;
    
    assign #10 sum46 = x41 + x61;
    assign #10 diff46 = x41 - x61;
    
    assign #10 sum57 = x51 +x71;
    assign #10 diff57 = x51 - x71;
    
    assign #10 sum013 = sum01 + x31;
    assign #10 diff013 = sum01 - x31;
    
    assign #10 sum012 = diff01 +x21;
    assign #10 diff012 = diff01 -x21;
    
    assign #10 a = diff46 + diff57;
    assign #10 b = diff46 - diff57;
    
    assign #40 mul4 = (a<<7) + (a<<5) + (a<<4) + (a<<2) + a;//181* a;
    assign #40 mul5 = (b<<7) + (b<<5) + (b<<4) + (b<<2) + b;//181*b;
    
    assign #20 x22 = (mul4 + 128) >>> 8; 
    assign #20 x44 = (mul5 + 128) >>> 8;
    
    assign #20 yc0 = (sum013 + sum46) >>> 8;
    assign #20 yc1 = (sum012 + x22) >>> 8;
    assign #20 yc2 = (diff012 + x44) >>> 8;
    assign #20 yc3 = (diff013 + sum57) >>> 8;
    assign #20 yc4 = (diff013 - sum57) >>> 8;
    assign #20 yc5 = (diff012 - x44) >>> 8;
    assign #20 yc6 = (sum012 - x22) >>> 8;
    assign #20 yc7 = (sum013 - sum46) >>> 8;
    
    assign #10 x1000 = x0 << 3;
    assign flag = (x11 | x2 | x3 | x4 | x5 | x6 | x7 ) == 32'b0;
    
/*    always @(*)
        begin
            rdy = 0;
            if(((x1 << 11)| x2 | x3 | x4 | x5 | x6 | x7 ) == 32'b0)
                begin
                    {y0,y1,y2,y3,y4,y5,y6,y7}= {8{x1000}};
                end
            else
                begin
                    {y0,y1,y2,y3,y4,y5,y6,y7} = {yc0,yc1,yc2,yc3,yc4,yc5,yc6,yc7};
                end
            //rdy = 1;
        end 
*/   
    always @(posedge clk)
        begin
            if(reset)
                begin
                    rdy <= 0;
                    ctr <= 0;
                    {y0,y1,y2,y3,y4,y5,y6,y7} <= {8{32'd0}};
                end
            else
                begin
                    ctr <= ctr + 1;
                    if(flag)
                       begin
                           {y0,y1,y2,y3,y4,y5,y6,y7} <= {8{x1000}};
                           if (ctr < 1)
                               begin
                                   rdy <= 0;
                               end
                           else
                               begin
                                   ctr <= ctr;
                                   rdy <= 1;
                               end
                       end
                    else
                        begin
                            {y0,y1,y2,y3,y4,y5,y6,y7} <= {yc0,yc1,yc2,yc3,yc4,yc5,yc6,yc7};
                            if (ctr <15)
                                begin
                                    rdy <= 0;
                                end
                            else
                                begin
                                    ctr <= ctr;
                                    rdy <= 1;
                                end
                        end
                end
        end

    
endmodule

