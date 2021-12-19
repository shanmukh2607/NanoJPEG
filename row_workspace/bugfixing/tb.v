`timescale 1 ns / 1 ps

module testbench;
    reg signed [31:0] x0,x1,x2,x3,x4,x5,x6,x7;
    wire signed [31:0] y0,y1,y2,y3,y4,y5,y6,y7;
    wire rdy;
    
    rowidct uut (.x0(x0),.x1(x1),.x2(x2),.x3(x3),.x4(x4),.x5(x5),.x6(x6),.x7(x7),
                 .y0(y0),.y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5),.y6(y6),.y7(y7),.rdy(rdy));
    
    initial 
        begin
            x0 = 32'd1;
            x1 = 32'd2;
            x2 = 32'd3;
            x3 = 32'd4;
            x4 = 32'd3;
            x5 = 32'd2;
            x6 = 32'd1;
            x7 = 32'd0;
            #1
            $display("%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
        end
endmodule
