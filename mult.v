module mult (
  input wire clk,
  input wire reset,
  input wire MDControl,
  input wire [31:0] multiplicando,
  input wire [31:0] multiplicador,
  output reg [63:0] resultado
);

reg [31:0] m_reg;
reg [31:0] a_reg;
reg [33:0] p_reg;
reg [31:0] high;
reg [31:0] low;
integer i;

always @(posedge clk) begin
  if (reset) begin
    resultado <= 0;
    a_reg <= 0;
    m_reg <= 0;
    p_reg <= 0;
  end else begin
    if (MDControl) begin
      m_reg <= multiplicador;
      a_reg <= multiplicando;
      p_reg <= {m_reg, 2'b0};
      for (i = 0; i < 32; i = i + 1) begin
        if (p_reg[1:0] == 2'b01) begin
          p_reg <= p_reg + ({m_reg, 1'b0} - a_reg);
        end else if (p_reg[1:0] == 2'b10) begin
          p_reg <= p_reg + ({m_reg, 1'b0} + a_reg);
        end
        p_reg[33:1] <= p_reg[32:0];
        p_reg[0] <= p_reg[31];
      end
    resultado <= p_reg[63:32];
    high <= resultado[63:31];
    low <= resultado[31:0];
    end
  end
end

endmodule