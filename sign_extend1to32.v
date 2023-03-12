module sign_extend_1to32 (
    input wire in, 
    output wire[31:0] out
    );


    assign out = {31'b0, LT};;

endmodule