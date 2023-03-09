`include "mux_MultDiv.v"

module mux_MultDivtb();
    reg  MDControl;
    reg [31:0] mult, div;
    wire [31:0] out;

    mux_MultDiv dut(. MDControl( MDControl), .mult(mult), .div(div), .out(out));

    initial begin
        $dumpfile("mux_MultDiv.vcd");
        $dumpvars(1);
   
        MDControl = 0 ;mult = 2 ; div = 4;
        #5;
        MDControl = 1 ;mult = 2 ; div = 4;
        #5;

        $finish();
    
    end

endmodule