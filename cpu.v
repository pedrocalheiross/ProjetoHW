module cpu(
    input clk, 
    input reset);

    // FLAGS

    wire Of;
    wire Ng;
    wire Zr;
    wire Eq;
    wire Gt;
    wire Lt;

    // FIOS DE CONTROLE COM 1 BIT

    wire PCWrite;
    wire MEMWrite;
    wire MEMRead;
    wire IRWrite;
    wire RBWrite;
    wire ABWrite;//????
    wire LSControl;
    wire RegWrite;
    wire ExcpContrl;
    

    // FIOS DE CONTROLE COM MAIS DE 1 BIT

    wire [2:0] ALUOp;
    wire [2:0] ShiftControl
    wire [2:0] IorD;
    wire [2:0] PCSrc;

    // FIOS DE CONTROLE PARA MUX

    wire [1:0]ALUSrcA;
    wire [1:0]ALUSrcB;
    wire [3:0]DataSrc;
    wire RegDst;
    wire ShiftAmt;
    wire ShiftSrc;


    // FIOS DE DADOS COM 32 BITS

    wire [31:0] ULAOut;
    wire [31:0] PCOut;
    wire [31:0] MEM_to_IR;
    wire [31:0] RBtoA;
    wire [31:0] RBtoB;
    wire [31:0] AOut;
    wire [31:0] BOut;
    wire [31:0] SXTND_out;
    wire [31:0] ULAA_in;
    wire [31:0] ULAB_in;

    // PARTES DE INSTRUÇÃO

    wire [5:0] OPCode;
    wire [4:0] RS;
    wire [4:0] RT;
    wire [15:0] OffSet;

    // FIOS DE DADOS COM MENOS DE 32 BITS

    wire [4:0] WriteRegIn;
    
    //wires

    wire [4:0]rs;


    //MODULOS:

    Registrador PC (
        clk,
        reset,
        PCWrite,
        ULAOut,
        PCOut
    );

    Memoria MEM (
        PCOut,
        clk,
        MEMWrite,
        ULAOut,
        MEM_to_IR
    );

    Instr_Reg IR (
        clk,
        reset,
        IRWrite,
        MEM_to_IR,
        OPCode,
        RS,
        RT,
        OffSet

    );



    mux_DataSrc M_DataSrc(
        DataSrc,
        RT,
        OffSet,
        WriteRegIn
    );

    Banco_reg RegBase (
        clk,
        reset,
        RBWrite,
        RS,
        RT,
        WriteRegIn,
        ULAOut,
        RBtoA,
        RBtoB
    );

    Registrador A (
        clk,
        reset,
        ABWrite,
        RBtoA,
        AOut
    );

    Registrador B (
        clk,
        reset,
        ABWrite,
        RBtoB,
        BOut
    );

    sign_extend_16 SXTND (
        OffSet,
        SXTND_out
    );

    mux_ulaA M_ULAA (
        ALUSrA,
        PCOut,
        AOut,
        ULAA_in
    );

    mux_ulaB M_ULAB (
        ALUSrB,
        BOut,
        SXTND_out,
        ULAB_in
    );

    ula32 ULA (
        ULAA_in,
        ULAB_in,
        ALUOp,
        ULAOut,
        Of,
        Ng,
        Zr,
        Eq,
        Gt,
        Lt
    );


    //AJEITAR ORDEM!
    ctrl_unit CTRL (
        clk,
        reset,
        Of,
        Ng,
        Zr,
        Eq,
        Gt,
        Lt,
        OPCode,
        PCWrite,
        MEMWrite,
        IRWrite,
        RBWrite,
        ABWrite,
        ALUOp,
        M_WREG,
        M_ULAA,
        M_ULAB,
        reset
    );


endmodule


