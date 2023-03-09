module mux_MultDiv (
    input wire MDControl,
	input wire [31:0] mult,
	input wire [31:0] div,
	output wire [31:0] out
);

	assign out = (MDControl) ? mult : div;
    
endmodule 