module mux_ShiftAmt (
    input wire [1:0]ShiftAmt,
	input wire [31:0] data0,
	input wire [31:0] data1,
	input wire [15:0] data2,
	output wire [4:0] out
);

	wire [4:0] temp;


	assign temp = (ShifAmt[0])? data1[4:0] : data0[4:0];
	assign out = (ShiftAmt[1]) ? data2[10:6] : temp;

endmodule 