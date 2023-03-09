module mux_ShiftAmt (
    input wire ShiftAmt,
	input wire [31:0] data0,
	input wire [31:0] data1,
	output wire [31:0] out
);

	assign out = (ShiftAmt) ? data1 : data0;

endmodule 