module mux_ulaA (
    input wire [31:0] data0, data1, data2, 
    input wire [1:0] AluSrcA, 
    output wire [31:0] out);

    wire [31:0] temp;

    //00 = data0
    //01 = data1
    //10 = data2 
    
    assign temp = (AluSrcA[0]) ? data1:data0;
    assign out = (AluSrcA[1]) ? data2:temp;




endmodule