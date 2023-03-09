`include "mux_ulaA.v"


module mux_ulaAtb();
    reg [31:0] data0, data1, data2;
    reg [1:0] AluSrcA;
    wire [31:0] out;

    mux_ulaA dut(.data0(data0), .data1(data1), .data2(data2), .AluSrcA(AluSrcA), .out(out));

    initial begin
        $dumpfile("mux_ulaA.vcd");
        $dumpvars(1);
   
        AluSrcA = 2'b00 ;data0 = 0 ; data1 = 1; data2 = 2;
        #5;
        AluSrcA = 2'b01 ;data0 = 0; data1 = 1; data2 = 2;
        #5;
        AluSrcA = 2'b10; data0 = 0 ; data1 = 1; data2 = 2;
        #5;
        $finish();
    
    end

endmodule