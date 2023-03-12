module mux_DataSrc (
    input wire [31:0] data0, data1, data2, data3, data4, data5, data6, data7, data8,data9, data10,
    input wire [3:0] DataSrc, 
    output wire [31:0] out);

    //data0 0000|
    //data1 0001|temp1|
    //                |
    //data2 0010|     |temp7|
    //data3 0011|temp2|     |
    //                      |
    //data4 0100|           |temp10|
    //data5 0101|temp3|     |      |
    //                |     |      |
    //data6 0110|     |temp8|      |
    //data7 0111|temp4|            |
    //                             |out
    //data8 1000|                  |
    //data9 1001|temp5||           |
    //                 |           |
    //data10 1010|     |||||||temp9|
    //227    1011|temp6|


    wire[31:0] temp1;
    wire[31:0] temp2;
    wire[31:0] temp3;
    wire[31:0] temp4;
    wire[31:0] temp5;
    wire[31:0] temp6;
    wire[31:0] temp7;
    wire[31:0] temp8;
    wire[31:0] temp9;
    wire[31:0] temp10;

    assign temp1 = (DataSrc[0])? data1:data0;
    assign temp2 = (DataSrc[0])? data3:data2;
    assign temp3 = (DataSrc[0])? data5:data4;
    assign temp4 = (DataSrc[0])? data7:data6;
    assign temp5 = (DataSrc[0])? data9:data8;
    assign temp6 = (DataSrc[0])? 227:data10;
    assign temp7 = (DataSrc[1])? temp2:temp1;
    assign temp8 = (DataSrc[1])? temp4:temp3;
    assign temp9 = (DataSrc[1])? temp6:temp5;
    assign temp10 =(DataSrc[2])? temp8:temp7;
    assign out = (DataSrc[3])? temp10:temp9;


endmodule