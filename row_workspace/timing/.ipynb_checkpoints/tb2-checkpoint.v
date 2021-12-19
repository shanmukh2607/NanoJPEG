`timescale 1 ns / 1ps

module testbench;
    reg signed [31:0] x0,x1,x2,x3,x4,x5,x6,x7;
    wire signed [31:0] y0,y1,y2,y3,y4,y5,y6,y7;
    wire rdy;
    reg clk,reset;
    wire [4:0] ctr;
    wire flag;
    
    rowidct dut (.x0(x0),.x1(x1),.x2(x2),.x3(x3),.x4(x4),.x5(x5),.x6(x6),.x7(x7),.clk(clk),.reset(reset),
                 .y0(y0),.y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5),.y6(y6),.y7(y7),.rdy(rdy));
    
    always #5 clk = !clk;
    
    initial 
        begin
            clk = 1;
            reset = 1;
            $display("RESET AT T=0.TIMESTAMP:");
            $display("OUTPUT:                        y0        y1          y2          y3          y4           y5          y6       y7 rdy ctr flag");
            $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            @(posedge clk);
            $display($time,"     All     OUTPUT      REGS     ARE     ZERO.   INPUTS   ARE     FED     NOW\nINPUTS:");
            x0 = 32'd1;
            x1 = 32'd1;
            x2 = 32'd1;
            x3 = 32'd1;
            x4 = 32'd1;
            x5 = 32'd1;
            x6 = 32'd1;
            x7 = 32'd1;
            $display($time,"%d %d %d %d %d %d %d %d\nOUTPUTS:",x0,x1,x2,x3,x4,x5,x6,x7);
            #1 reset = 0;
            $display($time,"        RESET = 0");
            $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            @(posedge clk); $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #1 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            @(posedge clk); $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #1 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #50 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #50 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #50 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #50 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #50 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            @(posedge clk); $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #1 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            @(posedge clk); $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #1 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            @(posedge clk); $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #1 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            @(posedge clk); $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #1 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            @(posedge clk); $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #1 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag); 
            @(posedge clk); $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag);
            #1 $display($time,"%d %d %d %d %d %d %d %d %d %d %d",y0,y1,y2,y3,y4,y5,y6,y7,rdy,ctr,flag); 
            //$display("%d",lol == lol2);
            $finish;
        end
    
    
   
endmodule
