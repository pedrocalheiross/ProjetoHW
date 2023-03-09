module mux_ulaB (
    input wire [31:0] data0, data2, data3, 
    input wire [1:0] AluSrcB, 
    output wire [31:0] out);

    wire [31:0] temp1;
    wire [31:0] temp2;

    //00 = data0
    //01 = 4
    //10 = data2 
    //11 = data3
    
    assign temp1 = (AluSrcB[0]) ? 4:data0;
    assign temp2 = (AluSrcB[0]) ? data3:data2;
    assign out = (AluSrcB[1]) ? temp2:temp1;




endmodule