module mux_ExcpControl (
    input wire[1:0] in,
    output wire[31:0] out;

);

    wire[31:0] temp1;

    assign temp1=(in[0])?254:253;
    assign out =(in[1])?255:temp1;

    
endmodule