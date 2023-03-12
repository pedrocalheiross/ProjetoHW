module mux_RegDst (
    input wire [31:0] data0, data1, data4, data5,
    input wire [2:0] RegDst, 
    output wire [31:0] out);

    //data0 000|temp1|
    //data1 001|     |
    //               | temp4| 
    //29    010|temp2|      |
    //31    011|            | out
    //                      |
    //data4 100|       temp3|
    //data5 101|

    wire [31:0] temp1;
    wire [31:0] temp2;
    wire [31:0] temp3;
    wire [31:0] temp4;

    assign temp1 = (RegDst[0])? data1:data0;
    assign temp2 = (RegDst[0])? 31:29;
    assign temp3 = (RegDst[0])? data4:data5;
    assign temp4 = (RegDst[1])? temp2:temp1;
    assign out = (RegDst[2])? temp3:temp4;


endmodule