module mux_ShiftAmt (
    input wire [31:0] ShiftAmt,
	input wire [31:0] data0,
	input wire [31:0] data1,
	input wire [31:0] data2,
	output wire [31:0] out
);

	wire [31:0] temp;


	assign temp = (ShifAmt[0])? data1 : data0;
	assign out = (ShiftAmt[1]) ? data2 : temp;

endmodule 