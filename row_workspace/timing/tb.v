`timescale 1 ns / 1ps

module testbench;
    reg signed [31:0] x0,x1,x2,x3,x4,x5,x6,x7;
    wire signed [31:0] y0,y1,y2,y3,y4,y5,y6,y7;
    wire rdy;
    reg clk,reset;
    //integer k;
    
    rowidct dut (.x0(x0),.x1(x1),.x2(x2),.x3(x3),.x4(x4),.x5(x5),.x6(x6),.x7(x7),.clk(clk),.reset(reset),
                 .y0(y0),.y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5),.y6(y6),.y7(y7),.rdy(rdy));
    
    always #5 clk = !clk;
    
    initial 
        begin
            clk = 1;
            reset = 1;
            
            $display("\nCLOCKED TIMING ANALYSIS WITH COUNTER: ELSE- PATH OF ROWIDCT MODULE");
            //$display($time,"  RESET =1\n");
            
            $monitor("%d %d, %d %d %d %d %d %d %d %d   %d   %d   %d",$time, reset, y0,y1,y2,y3,y4,y5,y6,y7,rdy,dut.ctr,dut.flag);
            //$monitor("%d, %d %d %d %d %d %d %d %d   %d",$time, y0,y1,y2,y3,y4,y5,y6,y7,dut.flag);
            
            $display("INPUTS:\n");
            @(posedge clk);
            x0 = 32'd1;
            x1 = 32'd2;
            x2 = 32'd3;
            x3 = 32'd4;
            
            x4 = 32'd3;
            x5 = 32'd2;
            x6 = 32'd1;
            x7 = 32'd0; 
            /*
            x0 = 32'd1;
            x1 = 32'd0;
            x2 = 32'd0;
            x3 = 32'd0;
            
            x4 = 32'd0;
            x5 = 32'd0;
            x6 = 32'd0;
            x7 = 32'd0;//*/

            $display($time,"%d %d %d %d %d %d %d %d\nOUTPUTS:",x0,x1,x2,x3,x4,x5,x6,x7);
            
            #1 reset = 0;
            
            //#270 $display("%d %d, %d %d %d %d %d %d %d %d, ctr = %d,rdy = %d",$time, reset, y0,y1,y2,y3,y4,y5,y6,y7, dut.ctr, rdy);
            //#10 $display("%d %d, %d %d %d %d %d %d %d %d, ctr = %d,rdy = %d",$time, reset, y0,y1,y2,y3,y4,y5,y6,y7, dut.ctr, rdy);
            #389 $finish;
        end
    
    
   
endmodule
