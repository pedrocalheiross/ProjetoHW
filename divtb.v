`include "div.v"

module divtb;

  reg clk;
  reg reset;
  reg MDControl;
  reg [31:0] divisor;
  reg [31:0] dividendo;
  wire [31:0] resultado;

  div uut (
    .clk(clk),
    .reset(reset),
    .MDControl(MDControl),
    .divisor(divisor),
    .dividendo(dividendo),
    .resultado(resultado)
  );

  integer i;

  initial begin
    $dumpfile("div.vcd");
    $dumpvars(1);
    
    clk = 0;
    reset = 0;
    MDControl = 0;
    divisor = 0;
    dividendo = 0;

    #10 reset = 1;
    #10 reset = 0;

    divisor = 10;
    dividendo = 2;
    #20;

    reset = 1;
    reset = 0;
    #5;

    divisor = 100;
    dividendo = 5;
    #40;    $finish;
  end

  always #5 clk = ~clk;

endmodule