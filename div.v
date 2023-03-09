module div (
  input wire clk,
  input wire reset,
  input wire MDControl,
  input wire [31:0] divisor,
  input wire [31:0] dividendo,
  output reg [31:0] resultado
);

reg [31:0] a;
reg [31:0] b;

always @(posedge clk) begin
    if(reset) begin
        a <= 0;
        b <= 0;
        resultado <= 0; 
    end
    else if(!MDControl) begin
        a <= divisor;
        b <= dividendo;
        if(b ==0) begin
            //tratamento de exceção
        end
        else begin
            resultado <= a / b;
        end
    end
end

endmodule