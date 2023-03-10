module mux_PcSrc (
    input wire [31:0] data0, data1, data2, data3, data4,data5, 
    input wire [2:0] PcSrc, 
    output wire [31:0] out);

    //data0 000
    //data1 001
    //data2 010
    //data3 011
    //data4 100
    //data5 101

    wire [31:0] temp1;
    wire [31:0] temp2;
    wire [31:0] temp3;
    wire [31:0] temp4;

    assign temp1 = (PcSrc[0])? data1:data0;
    assign temp2 = (PcSrc[0])? data3:data2;
    assign temp4 = (PcSrc[0])? data5:data4;
    assign temp3 = (PcSrc[1])? temp2:temp1;
    assign out = (PcSrc[2])? temp4:temp3;


endmodule