module mux_IorD (
    input wire [31:0] data0, data1, data2, data3, 
    input wire [1:0] IorD, 
    output wire [31:0] out);

    wire [31:0] temp1;
    wire [31:0] temp2;

    //00 = data0
    //01 = data1
    //10 = data2 
    //11 = data3
    
    assign temp1 = (IorD[0]) ? data1:data0;
    assign temp2 = (IorD[0]) ? data3:data2;
    assign out = (IorD[1]) ? temp2:temp1;

endmodule