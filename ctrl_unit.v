module ctrl_unit (
    input wire clk,
    input wire reset,

    // FLAGS

    input wire Of,
    input wire Ng,
    input wire Zr,
    input wire Eq,
    input wire Gt,
    inout wire Lt,

    // PARTE DA INTRUÇÃO QUE IMPORTA

    input wire [5:0] OPCode,
    input wire [5:0] funct;

    // FIOS DE CONTROLE COM 1 BIT

    output reg PCWrite;
    output reg MEMWrite;
    output reg MEMRead;
    output reg IRWrite;
    output reg RBWrite;
    output reg RAWrite;
    output reg LSControl;
    output reg RegWrite;
    output reg SEControl;
    output reg ALUOutCtrl;
    output reg EPCControl;
    output reg HiWrite;
    output reg LoWrite;


    // FIOS DE CONTROLE COM MAIS DE 1 BIT

    output reg [2:0] ALUOp;
    output reg [2:0] ShiftControl
    output reg [1:0] IorD;
    output reg [2:0] PCSrc;

    // FIO DE CONTROLE PARA MUX
    
    output reg [1:0]ALUSrcA;
    output reg [1:0]ALUSrcB;
    output reg [3:0]DataSrc;
    output reg RegDst;
    output reg [1:0]ShiftAmt;
    output reg ShiftSrc;
    output reg ExcpContrl;

    //FIO DE CONTROLE ESPECIAL PARA RESET
    
    output reg rst_out
);

// VARIÁVEIS

reg [1:0] STATE;
reg [2:0] COUNTER;

// PARAMETROS
    
    // PRINCIPAIS ESTADOS DA MÁQUINA
    parameter ST_COMMON = 2'b00;
    parameter ST_ADD = 2'b01;
    parameter ST_ADDI = 2'b10;
    parameter ST_RESET = 2'b11;
    
    // CÓDIGOS DE OPCODE COMO APELIDOS
    parameter ADD = 6'b000000;
    parameter ADDI = 6'b001000;
    parameter RESET = 6'b111111;


initial begin
    //FAZ RESET INICIAL NA MÁQUINA
    rst_out = 1'b1;
end

always @(posedge clk) begin
    if (reset == 1'b1) begin
        if (STATE != ST_RESET) begin
            STATE = ST_RESET;
            //SETANDO TODOS OS SINAIS
            PCWrite = 1'b0;
            MEMWrite = 1'b0;
            IRWrite = 1'b0;
            RBWrite = 1'b0;
            RAWrite = 1'b0;
            ALUOp = 3'b000;
            DataSrc = 4'b0000;
            M_ULAA = 1'b0;
            M_ULAB = 2'b00;
            rst_out = 1'b1;
            //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
            COUNTER = 3'b000;
        end
        else begin
            STATE = ST_COMMON;
            //SETANDO TODOS OS SINAIS
            PCWrite = 1'b0;
            MEMWrite = 1'b0;
            IRWrite = 1'b0;
            RBWrite = 1'b0;
            RAWrite = 1'b0;
            ALUOp = 3'b000;
            DataSrc = 4'b0000;
            M_ULAA = 1'b0;
            M_ULAB = 2'b00;
            rst_out = 1'b0; ///
            //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
            COUNTER = 3'b000;
        end
    end
    else begin
        case (STATE)
            ST_COMMON: begin
                    if (COUNTER == 3'b000 || COUNTER == 3'b001 || COUNTER == 3'b010) begin
                        STATE = ST_COMMON;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0;
                        MEMWrite = 1'b0; ///
                        IRWrite = 1'b0;
                        RBWrite = 1'b0;
                        RAWrite = 1'b0;
                        ALUOp = 3'b001; ///
                        DataSrc = 4'b0000;
                        M_ULAA = 1'b0; ///
                        M_ULAB = 2'b01; ///
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                    else if (COUNTER == 3'b011) begin
                        STATE = ST_COMMON;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b1; ///
                        MEMWrite = 1'b0; ///
                        IRWrite = 1'b1; ///
                        RBWrite = 1'b0;
                        RAWrite = 1'b0;
                        ALUOp = 3'b001; ///
                        DataSrc = 4'b0000;
                        M_ULAA = 1'b0; ///
                        M_ULAB = 2'b01; ///
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                    else if (COUNTER == 3'b100) begin
                        STATE = ST_COMMON;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0; 
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0; 
                        RBWrite = 1'b0;
                        RAWrite = 1'b0;
                        ALUOp = 3'b000; 
                        DataSrc = 4'b0000;
                        M_ULAA = 1'b0; 
                        M_ULAB = 2'b00; 
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                    else if (COUNTER == 3'b101) begin
                        case(OPCODE)
                            ADD: begin
                                STATE = ST_ADD;
                            end
                            ADDI: begin
                                STATE = ST_ADDI;
                            end
                            RESET: begin
                                STATE = ST_RESET;
                            end
                        endcase
                        STATE = ST_COMMON;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0; 
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0; 
                        RBWrite = 1'b0;
                        RAWrite = 1'b1; ///
                        ALUOp = 3'b000; 
                        DataSrc = 4'b0000;
                        M_ULAA = 1'b0; 
                        M_ULAB = 2'b00; 
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                end
                ST_ADD: begin
                    if (COUNTER == 3'b000) begin
                        //SETANDO ESTADOS FUTUROS
                        STATE = ST_ADD;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0;
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0;
                        RBWrite = 1'b1; ///
                        RAWrite = 1'b0;
                        ALUOp = 3'b001; ///
                        DataSrc = 4'b0000; ///
                        M_ULAA = 1'b1; ///
                        M_ULAB = 2'b00; ///
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                    else if (COUNTER == 3'b001) begin
                        //SETANDO ESTADOS FUTUROS
                        STATE = ST_COMMON;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0;
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0;
                        RBWrite = 1'b1; ///
                        RAWrite = 1'b0;
                        ALUOp = 3'b001; ///
                        DataSrc = 4'b0000; ///
                        M_ULAA = 1'b1; ///
                        M_ULAB = 2'b00; ///
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                    if (COUNTER == 3'b000) begin
                        //SETANDO ESTADOS FUTUROS
                        STATE = ST_ADD;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0;
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0;
                        RBWrite = 1'b1; ///
                        RAWrite = 1'b0;
                        ALUOp = 3'b001; ///
                        DataSrc = 4'b0000; ///
                        M_ULAA = 1'b1; ///
                        M_ULAB = 2'b00; ///
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                    else if (COUNTER == 3'b001) begin
                        //SETANDO ESTADOS FUTUROS
                        STATE = ST_COMMON;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0;
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0;
                        RBWrite = 1'b1; ///
                        RAWrite = 1'b0;
                        ALUOp = 3'b001; ///
                        DataSrc = 4'b0000; ///
                        M_ULAA = 1'b1; ///
                        M_ULAB = 2'b00; ///
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                end
                if (COUNTER == 3'b000) begin
                        //SETANDO ESTADOS FUTUROS
                        STATE = ST_ADDI;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0;
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0;
                        RBWrite = 1'b1; ///
                        RAWrite = 1'b0;
                        ALUOp = 3'b001; ///
                        DataSrc = 4'b0000; ///
                        M_ULAA = 1'b1; ///
                        M_ULAB = 2'b10; ///
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
                    else if (COUNTER == 3'b001) begin
                        //SETANDO ESTADOS FUTUROS
                        STATE = ST_COMMON;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0;
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0;
                        RBWrite = 1'b1; ///
                        RAWrite = 1'b0;
                        ALUOp = 3'b001; ///
                        DataSrc = 4'b0000; ///
                        M_ULAA = 1'b1; ///
                        M_ULAB = 2'b10; ///
                        rst_out = 1'b0;
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = COUNTER + 1;
                    end
            ST_RESET: begin
                if (COUNTER == 3'b000) begin
                        //SETANDO ESTADOS FUTUROS
                        STATE = ST_RESET;
                        //SETANDO TODOS OS SINAIS
                        PCWrite = 1'b0;
                        MEMWrite = 1'b0;
                        IRWrite = 1'b0;
                        RBWrite = 1'b0;
                        RAWrite = 1'b0;
                        ALUOp = 3'b000;
                        DataSrc = 4'b0000;
                        M_ULAA = 1'b0;
                        M_ULAB = 2'b10;
                        rst_out = 1'b1; ///
                        //SETANDO CONTADOR PARA PRÓXIMA OPERAÇÃO
                        COUNTER = 3'b000;
                    end
            end
        endcase
    end
end



endmodule