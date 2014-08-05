pragma Warnings (Off);
with System.STM32F4; use System.STM32F4;
pragma Warnings (On);
package display is 

    LTDC_Base : constant := 16#4001_6800#;

    type Color_T is mod 2**24;
    -- Colors definitions
    Black : constant Color_T := 0;
    White : constant Color_T := Color_T'Last;

    type BCCR_Reserved is array (0 .. 7) of Bits_1 with Pack, Size => 8;
    type BCCR_Registers is record
        Color : Color_T;
        Reserved : BCCR_Reserved;
    end record with Pack, Size => 32;

    type LTDC_Registers is record
        -- 0x0
        Reserved_0 : Word;
        -- 0x4
        Reserved_4 : Word;
        -- 0x8
        SSCR : Word;
        -- 0xc
        BPCR : Word;
        -- 0x10
        AWCR : Word;
        -- 0x14
        TWCR : Word;
        -- 0x18
        GCR : Word;
        -- 0x1c
        Reserved_1c : Word;
        -- 0x20
        Reserved_20 : Word;
        -- 0x24
        SRCR : Word;
        -- 0x28
        Reserved_28 : Word;
        -- 0x2c
        BCCR : BCCR_Registers;
        -- 0x30
        Reserved_30 : Word;
        -- 0x34
        IER : Word;
        -- 0x38
        ISR : Word;
        -- 0x3c
        ICR : Word;
        -- 0x40
        LIPCR : Word;
        -- 0x44
        CPSR : Word;
        -- 0x48
        CDSR : Word;
        -- 0x4c
        Reserved_4c : Word;
        -- 0x50
        Reserved_50 : Word;
        -- 0x54
        Reserved_54 : Word;
        -- 0x58
        Reserved_58 : Word;
        -- 0x5c
        Reserved_5c : Word;
        -- 0x60
        Reserved_60 : Word;
        -- 0x64
        Reserved_64 : Word;
        -- 0x68
        Reserved_68 : Word;
        -- 0x6c
        Reserved_6c : Word;
        -- 0x70
        Reserved_70 : Word;
        -- 0x74
        Reserved_74 : Word;
        -- 0x78
        Reserved_78 : Word;
        -- 0x7c
        Reserved_7c : Word;
        -- 0x80
        Reserved_80 : Word;
        -- 0x84
        L1CR : Word;
        -- 0x88
        L1WHPCR : Word;
        -- 0x8c
        L1WVPCR : Word;
        -- 0x90
        L1CKCR : Word;
        -- 0x94
        L1PFCR : Word;
        -- 0x98
        L1CACR : Word;
        -- 0x9c
        L1DCCR : Word;
        -- 0xa0
        L1BFCR : Word;
        -- 0xa4
        Reserved_a4 : Word;
        -- 0xa8
        Reserved_a8 : Word;
        -- 0xac
        L1CFBAR : Word;
        -- 0xb0
        L1CFBLR : Word;
        -- 0xb4
        L1CFBLNR : Word;
        -- 0xb8
        Reserved_b8 : Word;
        -- 0xbc
        Reserved_bc : Word;
        -- 0xc0
        Reserved_c0 : Word;
        -- 0xc4
        L1CLUTWR : Word;
        -- 0xc8
        Reserved_c8 : Word;
        -- 0xcc
        Reserved_cc : Word;
        -- 0xd0
        Reserved_d0 : Word;
        -- 0xd4
        Reserved_d4 : Word;
        -- 0xd8
        Reserved_d8 : Word;
        -- 0xdc
        Reserved_dc : Word;
        -- 0xe0
        Reserved_e0 : Word;
        -- 0xe4
        Reserved_e4 : Word;
        -- 0xe8
        Reserved_e8 : Word;
        -- 0xec
        Reserved_ec : Word;
        -- 0xf0
        Reserved_f0 : Word;
        -- 0xf4
        Reserved_f4 : Word;
        -- 0xf8
        Reserved_f8 : Word;
        -- 0xfc
        Reserved_fc : Word;
        -- 0x100
        Reserved_100 : Word;
        -- 0x104
        L2CR : Word;
        -- 0x108
        L2WHPCR : Word;
        -- 0x10c
        L2WVPCR : Word;
        -- 0x110
        L2CKCR : Word;
        -- 0x114
        L2PFCR : Word;
        -- 0x118
        L2CACR : Word;
        -- 0x11c
        L2DCCR : Word;
        -- 0x120
        L2BFCR : Word;
        -- 0x124
        Reserved_124 : Word;
        -- 0x128
        Reserved_128 : Word;
        -- 0x12c
        L2CFBAR : Word;
        -- 0x130
        L2CFBLR : Word;
        -- 0x134
        L2CFBLNR : Word;
        -- 0x138
        Reserved_138 : Word;
        -- 0x13c
        Reserved_13c : Word;
        -- 0x140
        Reserved_140 : Word;
        -- 0x144
        L2CLUTWR : Word;
        -- 0x148
    end record with Pack, Size => 16#148# * 8, Alignment => 1;

    LTDC : LTDC_Registers with Volatile, Address => System'To_Address (LTDC_Base);


    procedure Set_Background (Color : Color_T);

end display; 

