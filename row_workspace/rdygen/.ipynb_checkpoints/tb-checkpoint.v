`timescale 1 ns / 1ns

module testbench;
    reg signed [31:0] x0,x1,x2,x3,x4,x5,x6,x7;
    wire signed [31:0] y0,y1,y2,y3,y4,y5,y6,y7;
    wire rdy;
    reg clk,reset;
    wire lol;
    wire lol2;
    
    rowidct dut (.x0(x0),.x1(x1),.x2(x2),.x3(x3),.x4(x4),.x5(x5),.x6(x6),.x7(x7),.clk(clk),.reset(reset),
                 .y0(y0),.y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5),.y6(y6),.y7(y7),.rdy(rdy));
    
    always #5 clk = !clk;
    
    initial 
        begin
            clk = 1;
            reset = 1;
            x0 = 32'd1;
            x1 = 32'd1;
            x2 = 32'd1;
            x3 = 32'd1;
            x4 = 32'd1;
            x5 = 32'd1;
            x6 = 32'd1;
            x7 = 32'd1;
            $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            @(posedge clk);
            $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #1 reset = 0;
            $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #9 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            #10 $display($time,"%d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy);
            //$display("%d",lol == lol2);
            $finish;
        end
    
    
   
endmodule
