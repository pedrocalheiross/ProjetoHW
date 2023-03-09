module cpu(
    input clk, 
    input reset);

    //wires

    wire [4:0]rs;
    wire 





    //given
    Banco_reg banco_reg(clk, reset);
    Instr_Reg instr_Reg;
    Memoria memoria;
    RegDesloc regDesloc;
    ula32 alu32;

    //made




//unidade de controle
    Controler controler(
        clk,
        reset,
        rs,
    );

endmodule


