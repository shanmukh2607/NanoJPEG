`timescale 1ns/1ps

module col_idct_tb (
);
    
    reg [31:0] i[0:7];
    wire [31:0] o[0:7];
    integer k;
    reg clk;
    reg reset;
    wire rdy;

    col_idct u0(
        .clk(clk),
        .reset(reset),
        .in0(i[0]),
        .in1(i[1]),
        .in2(i[2]),
        .in3(i[3]),
        .in4(i[4]),
        .in5(i[5]),
        .in6(i[6]),
        .in7(i[7]),
        .y0(o[0]),
        .y1(o[1]),
        .y2(o[2]),
        .y3(o[3]),
        .y4(o[4]),
        .y5(o[5]),
        .y6(o[6]),
        .y7(o[7]),
        .rdy(rdy)
    );

    initial begin
        $monitor("time = %d, reset = %d, out0 = %d,  out1 = %d,  out2 = %d,  out3 = %d,  out4 = %d,  out5 = %d,  out6 = %d,  out7 = %d, ctr = %d, rdy = %d", $time, reset, o[0], o[1], o[2], o[3], o[4], o[5], o[6], o[7], u0.ctr, rdy);
        // $monitor("time = %d, reset = %d, out0 = %d,  out1 = %d,  out2 = %d,  out3 = %d,  out4 = %d,  out5 = %d,  out6 = %d,  out7 = %d", $time, reset, o[0], o[1], o[2], o[3], o[4], o[5], o[6], o[7]);
        // for(k = 0; k<8; k = k + 1) begin
        //     i[k] = 100 + k;
        // end
        // $display("Inputs given at T = 0.");
        clk = 1;
        reset = 1;
        #11 reset = 0;
        // #6 $display("time = %d, ctr = %d", $time, u0.ctr);
        for(k = 0; k<8; k = k + 1) begin
            i[k] = 100 + k;
        end
        $display("Inputs given at t = %d", $time);
        #1000 $finish;
        
    end

    always #5 clk = ~clk;

endmodule