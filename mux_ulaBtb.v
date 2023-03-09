`include "mux_ulaB.v"

module mux_ulaBtb();
    reg [31:0] data0, data2, data3;
    reg [1:0] AluSrcB;
    wire [31:0] out;

    mux_ulaB dut(.data0(data0), .data2(data2), .data3(data3), .AluSrcB(AluSrcB), .out(out));

    initial begin
        $dumpfile("mux_ulaB.vcd");
        $dumpvars(1);
   
        AluSrcB = 2'b00 ;data0 = 0 ; data2 = 1; data3 = 2;
        #5;
        AluSrcB = 2'b01 ;data0 = 0 ; data2 = 1; data3 = 2;
        #5;
        AluSrcB = 2'b10;data0 = 0 ; data2 = 1; data3 = 2;
        #5;
        AluSrcB = 2'b11;data0 = 0 ; data2 = 1; data3 = 2;
        #5;
        $finish();
    
    end

endmodule