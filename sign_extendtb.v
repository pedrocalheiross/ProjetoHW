`include "sign_extend.v"

module sign_extendtb();
    reg [15:0] in;
    wire [31:0] out;

    sign_extend dut(. in( in), .out(out));

    initial begin
        $dumpfile("sign_extend.vcd");
        $dumpvars(1);
   
        in = 16'b1000000000000000;
        #5;
        in = 16'b0000000000000001;
        #5;

        $finish();
    
    end

endmodule