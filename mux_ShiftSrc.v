module mux_ShiftSrc (
    input wire ShiftSrc,
	input wire [31:0] data0,
	input wire [31:0] data1,
	output wire [31:0] out
);

	assign out = (ShiftSrc) ? data1 : data0;

endmodule 