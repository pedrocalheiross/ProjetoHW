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
    wire EPCControl;
    wire HiWrite;
    wire LoWrite;


    // FIOS DE CONTROLE COM MAIS DE 1 BIT

    wire [2:0] ALUOp;
    wire [2:0] ShiftControl;
    wire [1:0] IorD;
    wire [2:0] PCSrc;

    // FIOS DE CONTROLE PARA MUX

    wire [1:0]ALUSrcA;
    wire [1:0]ALUSrcB;
    wire [3:0]DataSrc;
    wire RegDst;
    wire [1:0]ShiftAmt;
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
    wire [31:0] ULAA_in;
    wire [31:0] ULAB_in;
    wire [31:0] HiIn;
    wire [31:0] HiOut;
    wire [31:0] LoIn;
    wire [31:0] LoOut; 
    wire [31:0] ULA_result;
    wire [31:0] AluOutOut;
    wire [31:0] EPCControlOut;
    wire [31:0] DataSrcOut;
    wire [31:0] LTSignEX;
    wire [31:0] ShiftLeft2Out;
    wire [31:0] WriteDataIn;
    wire [31:0] ExcpContrlOut;
    wire [31:0] PCSrcOut;
    wire [31:0] MemToSS;
    wire [31:0] SignExtend1_32Out;
    wire [31:0] SScontrolData;
    wire [31:0] SScontrolB;
    wire [31:0] LSControlOut;
    wire [31:0] ShiftSrcOut;
    wire [31:0] SignExtend16_32Out;
    wire [31:0] ShiftLeft16Out;
    wire [31:0] ShiftRegOut;
    wire [31:0] ShiftLeftOut;
    wire [31:0] ShiftLeft2628;
    wire [31:0] IordOut;

    // PARTES DE INSTRUÇÃO

    wire [5:0] OPCode;
    wire [4:0] RS;
    wire [4:0] RT;
    wire [15:0] OffSet;

    // FIOS DE DADOS COM MENOS DE 32 BITS

    wire [4:0] WriteRegIn;
    wire [4:0] ShiftAmtOut;


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

    RegDesloc ShiftReg(
        clk,
        reset,
        ShiftControl,
        ShiftAmtOut,
        ShiftSrcOut,
        ShiftRegOut
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


    //Made:

    Registrador PcReg(
        clk,
        reset,
        PCWrite,
        PcSrcOut,
        PcOut
    );

    Registrador AluOutReg(
        clk,
        reset,
        ALUOutCtrl,
        ULA_result,
        AluOutOut
    );

    Registrador EPCReg(
        clk,
        reset,
        EPCControl,
        ULA_result,
        EPCControlOut
    );

    Registrador HiReg(
        clk,
        reset,
        HiWrite,
        HiIn,
        HiOut
    );

    Registrador LoReg(
        clk,
        reset,
        LoWrite,
        LoIn,
        LoOut
    );

    Registrado MemDataReg(
        clk,
        reset,
        MEMWrite,
        MEM_to_IR,
        MemToSS
    );

    Registrador A (
        clk,
        reset,
        RA,
        RBtoA,
        AOut
    );

    Registrador B (
        clk,
        reset,
        RA,
        RBtoB,
        BOut
    );

    sign_extend_16 SE1632(
        OffSet,
        SignExtend16_32Out
    );

    sign_extend_1to32 SE132(
        LTSignEX,
        SignExtend1_32Out
    );

    shiftLeft_16 SL16(
        OffSet,
        ShiftLeft16Out
    );

    shiftLeft_2 SL2(
        SignExtend16_32Out,
        ShiftLeft2Out
    );

    shiftLeft_2628 SL2628(
        MEM_to_IR,
        shiftLeft2628
    );

    mux_ulaA M_ULAA (
        ALUSrA,
        PCOut,
        AOut,
        SScontrolData
    );

    mux_ulaB M_ULAB (
        ALUSrB,
        BOut,
        SignExtend16_32Out,
        ShiftLeft2Out
    );

    mux_PcSrc M_PcSrc(
        ULA_result,
        AluOutOut,
        ShiftLeft2628,
        SScontrolData,
        EPCControlOut,
        LSControlOut,
        PCSrc,
        PcSrcOut,
    );

    mux_RegDst M_RDST(
        RT,
        RS,
        LSControlOut,
        OffSet,
    );
    
    mux_DataSrc M_DataSrc(
        AluOutOut,
        LSControlOut,
        HiOut,
        LoOut,
        SignExtend1_32Out,
        SignExtend16_32Out,
        ShiftLeft16Out,
        ExcpContrlOut,
        ShiftRegOut,
        BOut,
        AOut,
        PcOut
    );

    MultDiv M_MD(
        MDControl,
        AOut,
        BOut,
        HiIn,
        LoIn
    );

    mux_ShiftAmt M_SA(
        ShiftAmt,
        SScontrolData,
        SSControlB,
        OffSet,
        ShiftAmtOut
    );

    mux_ShiftSrc M_SS(
        ShiftSrc,
        AOut,
        BOut,
        ShiftSrcOut
    );

    mux_IorD M_ID(
        PcOut,
        ULA_result,
        AluOutOut,
        ExcpContrlOut,
        IorD,
        IordOut
    );

    mux_ExcpControl M_EC(
        ExcpContrl,
        ExcpContrlOut
    );

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
        OffSet,
        PCWrite,
        MEMWrite,
        MEMRead,
        IRWrite,
        RBWrite,
        RAWrite,
        LSControl,
        RegWrite,
        SEControl,
        ALUOutCtrl,
        EPCControl,
        HiWrite,
        LoWrite,
        ALUOp,
        ShiftControl,
        IorD,
        PCSrc,
        ALUSrcA,
        ALUSrcB,
        DataSrc,
        RegDst,
        ShiftAmt,
        ShiftSrc,
        ExcpContrl,
        reset
    );


endmodule
