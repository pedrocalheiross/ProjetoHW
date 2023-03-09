`include "mux_PcSrc.v"

module mux_PcSrctb();
    reg[31:0]data0, data1, data2, data3, data4;
    reg[2:0]PcSrc;
    wire[31:0]out;

    mux_PcSrc dut(.data0(data0), .data1(data1), .data2(data2), .data3(data3),.data4(data4),.PcSrc(PcSrc), .out(out));

    initial begin

        $dumpfile("mux_PcSrc.vcd");
        $dumpvars(1);

        PcSrc = 3'b000; data0 = 0;data1 = 1;data2 = 2;data3 = 3;data4 =4;
        #5;
        PcSrc = 3'b001; data0 = 0;data1 = 1;data2 = 2;data3 = 3;data4 =4;
        #5;
        PcSrc = 3'b010; data0 = 0;data1 = 1;data2 = 2;data3 = 3;data4 =4;
        #5;
        PcSrc = 3'b011; data0 = 0;data1 = 1;data2 = 2;data3 = 3;data4 =4;
        #5;
        PcSrc = 3'b100; data0 = 0;data1 = 1;data2 = 2;data3 = 3;data4 =4;
        #5;

        $finish();

    end


endmodule