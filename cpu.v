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
    wire RAWrite;
    wire LSControl;
    wire RegWrite;
    wire SEControl;
    wire ALUOutCtrl;


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
    wire ExcpContrl;


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
    wire [31:0] HiOut;
    wire [31:0] LoOut; 
    wire [31:0] ULA_result;
    wire [31:0] AluOutOut;
    wire [31:0] EPCControlOut;
    wire [31:0] DataSrcOut;
    wire [31:0] LTSignEX;
    wire [31:0] ShiftLeft2Out;
    wire [31:0] WriteDataIn;
    wire [31:0] ExcpContrlOut;

    

    // PARTES DE INSTRUÇÃO

    wire [5:0] OPCode;
    wire [4:0] RS;
    wire [4:0] RT;
    wire [15:0] OffSet;

    // FIOS DE DADOS COM MENOS DE 32 BITS

    wire [4:0] WriteRegIn;


    //MODULOS:

    //Given:
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

    Memoria MEM (
        PCOut,
        clk,
        MEMWrite,
        ULAOut,
        MEM_to_IR
    );


    Registrador PC (
        clk,
        reset,
        PCWrite,
        ULAOut,
        PCOut
    );

    RegDesloc ShiftReg();
    
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


    //Made:

    Registrador PcReg();

    Registrador AluOutReg();

    Registrador EPCReg();

    Registrador HiReg();

    Registrador LoReg();

    Registrado MemDataReg();

    Registrador A (
        clk,
        reset,
        RA
        RBtoA,
        AOut
    );

    Registrador B (
        clk,
        reset,
        RA
        RBtoB,
        BOut
    );

    sign_extend_16 SE1632(
        OffSet,
        SXTND_out
    );

    sign_extend_1to32 SE132();

    shiftLeft_16 SL16();

    shiftLeft_2 SL2();

    shiftLeft_22628 SL2628();

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

    mux_PcSrc M_PcSrc();

    mux_RegDst M_RDST();
    
    mux_DataSrc M_DataSrc(
        DataSrc,
        RT,
        OffSet,
        WriteRegIn
    );

    mux_MultDiv M_MD();

    mux_ShiftAmt M_SA();

    mux_ShiftSrc M_SS();


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
        RA
        ALUOp,
        M_WREG,
        M_ULAA,
        M_ULAB,
        reset
    );


endmodule


