    .db 09
    LDA 740_UNK,X ; Load
    AND #$0F ; Get bottom bits.
    JMP SKIP_UPPER
USE_UPPER_NIBBLE: ; 1F:0009, 0x03E009
    LDA 740_UNK,X ; Load
    AND #$F0 ; Get upper bits.
SKIP_UPPER: ; 1F:000E, 0x03E00E
    ORA TMP_09 ; Or val with.
    STA 740_UNK,X ; Store to.
    INC TMP_01 ; ++
    LDA TMP_01 ; Load
    CMP #$04 ; If _ #$04
    BEQ RTS ; ==, goto.
    CMP #$02 ; If _ #$02
    BNE LOOP_RTN_UNK ; !=, goto.
    LDA TMP_00 ; Load
    CLC ; Prep add.
    ADC #$08 ; += #$08
    STA TMP_00 ; Store back.
    JMP LOOP_RTN_UNK
RTS: ; 1F:0029, 0x03E029
    RTS
DATA_UNK_A: ; 1F:002A, 0x03E02A
    .db C0
DATA_UNK_B: ; 1F:002B, 0x03E02B
    .db 20
DATA_UNK_C: ; 1F:002C, 0x03E02C
    .db C8
DATA_UNK_D: ; 1F:002D, 0x03E02D
    .db 23
    .db 40
    .db 21
    .db D0
    .db 23
    .db C0
    .db 21
    .db D8
    .db 23
    .db 40
    .db 22
    .db E0
    .db 23
    .db C0
    .db 22
    .db E8
    .db 23
    .db 40
    .db 23
    .db F0
    .db 23
    .db C0
    .db 24
    .db C8
    .db 27
    .db 40
    .db 25
    .db D0
    .db 27
    .db C0
    .db 25
    .db D8
    .db 27
    .db 40
    .db 26
    .db E0
    .db 27
    .db C0
    .db 26
    .db E8
    .db 27
    .db 40
    .db 27
    .db F0
    .db 27
DATA_UNK: ; 1F:005A, 0x03E05A
    .db 00
    .db 02
    .db 08
    .db 0A
BG_UPDATE_RELATED?: ; 1F:005E, 0x03E05E
    LDA #$00
    STA 634_UNK_INDEX ; Clear.
LOOP_LARGEST: ; 1F:0063, 0x03E063
    LDY 605_UNK ; Stream val.
    LDA [72_STREAM_PTR_UNK[2]],Y ; From stream.
    ASL A ; << 1, *2
    TAX ; To X index.
    LDA DATA_UNK_A,X ; Load data.
    STA 74_STREAM_UNK_A ; Store to.
    LDA DATA_UNK_B,X ; Load data.
    STA 75_STREAM_UNK_B ; Store to.
    LDX PPU_UPDATE_BUF_INDEX ; Get update index.
    LDA #$01 ; Type.
    STA PPU_UPDATE_BUFFER[20],X ; Store to.
    INX ; Index++
    LDA TMP_04 ; Load
    STA PPU_UPDATE_BUFFER[20],X ; Store addr.
    INX ; Index++
    LDA TMP_05 ; Load
    STA PPU_UPDATE_BUFFER[20],X ; Store addr.
    INX ; Index++
    STX PPU_UPDATE_BUF_INDEX ; Store index back.
LOOP_LARGER: ; 1F:008A, 0x03E08A
    LDA 9D_UNK ; Load
    ASL A ; << 3, *8.
    ASL A
    ASL A
    CLC ; Prep add.
    ADC 9C_UNK ; Add var.
    TAY ; To stream pointer?
    LDA #$00
    STA TMP_00 ; Clear.
    LDA [74_STREAM_UNK_A],Y ; Load data from stream.
    LDX 634_UNK_INDEX ; Index from.
    STA 61C_UNK,X ; Store data to.
    INC 634_UNK_INDEX ; ++
    LDX #$04 ; Loop counter.
LOOP_FOUR: ; 1F:00A4, 0x03E0A4
    ASL A ; << 1, *2.
    ROL TMP_00 ; << 1 with carry.
    DEX ; Loop--
    BNE LOOP_FOUR ; != 0, loop.
    CLC ; Prep add.
    ADC 9A_UNK ; += var.
    STA TMP_02 ; Store to.
    STA TMP_0A ; Store to.
    LDA TMP_00 ; Load var.
    ADC 9B_UNK ; Add. TODO: Carry?
    STA TMP_03 ; Store to.
    STA TMP_0B ; Store 2.
    LDA 603_unk ; Load
    AND #$03 ; Keep 0000.0011
    STA TMP_00 ; Store to.
    LDA 604_UNK ; Load
    AND #$03 ; Keep 0000.0011
    ASL A ; << 2, *4
    ASL A
    CLC ; Prep add.
    ADC TMP_00 ; Add with.
    TAY ; To Y index.
    LDX PPU_UPDATE_BUF_INDEX ; Load index.
LOOP_STREAM: ; 1F:00CD, 0x03E0CD
    LDA [TMP_02],Y ; Load from stream.
    STA PPU_UPDATE_BUFFER[20],X ; To buffer.
    INY ; Stream++
    INX ; Index++
    STX PPU_UPDATE_BUF_INDEX ; Store X back.
    DEC 609_UNK ; --
    LDA 609_UNK ; Load
    BEQ 609_ZERO ; == 0, goto.
    CMP #$14 ; If _ #$14
    BEQ 609_EQ_14 ; ==, goto.
    INC 603_unk ; ++
    LDA 603_unk ; Load
    AND #$03 ; Keep 0000.0011
    BNE LOOP_STREAM ; Any bits sets, loop more data.
    JSR RTN_UNK_BG? ; BG update?
    INC 9C_UNK ; ++
    LDA 9C_UNK ; Load
    CMP #$08 ; If _ #$08
    BNE LOOP_LARGER ; !=, goto.
    LDX PPU_UPDATE_BUF_INDEX ; Load index.
    LDA #$FF
    STA PPU_UPDATE_BUFFER[20],X ; Store EOF.
    INX ; Index++
    STX PPU_UPDATE_BUF_INDEX ; Store index back.
    LDA #$00 ; Clear val.
    STA 9C_UNK ; Clear.
    STA 603_unk
    INC 605_UNK ; ++
    LDA 607_UNK ; Load
    EOR #$01 ; Invert 0000.0001
    STA 607_UNK ; Store back.
    LDA TMP_05 ; Load
    EOR #$04 ; Invert 0000.0100
    STA TMP_05 ; Store back.
    LDA TMP_04 ; Load.
    AND #$E0 ; Keep 1110.0000
    STA TMP_04 ; Store back.
    JMP LOOP_LARGEST
609_ZERO: ; 1F:0122, 0x03E122
    LDY #$00
    STY 609_UNK ; Clear
    INY
    STY 602_COUNTER?_UNK ; Set to 1.
609_EQ_14: ; 1F:012B, 0x03E12B
    LDA #$FF
    STA PPU_UPDATE_BUFFER[20],X ; Set EOF.
    INX ; Index++
    STX PPU_UPDATE_BUF_INDEX ; Store index.
    LDA 604_UNK ; Load
    CMP #$16 ; If _ #$16
    BEQ 604_EQ_16 ; ==, goto.
    AND #$03 ; Keep 0000.0011
    BEQ 604_BITS_0x03_NOT_SET ; ==, goto.
    RTS ; Leave.
604_BITS_0x03_NOT_SET: ; 1F:013F, 0x03E13F
    LDA 604_UNK ; Load
    CMP #$02 ; If _ #$02
    BCS 604_EQ_16 ; >=, goto.
    LDA 635_UNK_INDEX? ; Load
    BNE 604_EQ_16 ; != 0, goto.
    LDY #$00 ; Index
LOOP_C_TIMES: ; 1F:014D, 0x03E14D
    LDA #$0F ; A
    STA 628_UNK,Y ; Store to.
    INY ; Index++
    CPY #$0C ; If _ #$0C
    BNE LOOP_C_TIMES
604_EQ_16: ; 1F:0157, 0x03E157
    LDA 635_UNK_INDEX? ; Load
    STA TMP_01 ; Store to.
    LDA 604_UNK ; Load
    CMP #$16 ; If _ #$16
    BEQ 604_EQ_16_PT_2
    INC TMP_01 ; ++ val.
604_EQ_16_PT_2: ; 1F:0165, 0x03E165
    LDA #$00
    STA TMP_00 ; Clear.
LOOP_PREP_SHIFTS: ; 1F:0169, 0x03E169
    LDX PPU_UPDATE_BUF_INDEX ; Load index.
    LDA #$01
    STA PPU_UPDATE_BUFFER[20],X ; Type.
    INX ; Index++
    LDA TMP_06 ; Load.
    STA PPU_UPDATE_BUFFER[20],X ; Store addr.
    INX ; Index++
    LDA TMP_07 ; Load.
    STA PPU_UPDATE_BUFFER[20],X ; Store addr.
    INX ; Index++
LOOP_STREAM_SHIFTS: ; 1F:017D, 0x03E17D
    LDY TMP_00 ; Y from.
    LDA 61C_UNK,Y ; Load val.
    TAY ; To Y, stream val.
    LDA [76_UNK],Y ; Load from stream.
    ASL A ; << 4, *16
    ASL A
    ASL A
    ASL A
    LDY TMP_01 ; Y from
    ORA 628_UNK,Y ; Or val with, indexed.
    STA PPU_UPDATE_BUFFER[20],X ; Store to buffer.
    INX ; Index++
    LDY TMP_00 ; Y from
    LDA 61C_UNK,Y ; Load val.
    TAY ; To Y, stream val.
    LDA [76_UNK],Y ; Load data again.
    LSR A ; >> 4, /16.
    LSR A
    LSR A
    LSR A
    LDY 635_UNK_INDEX? ; Y from, index.
    STA 628_UNK,Y ; Store val to index.
    INC 635_UNK_INDEX? ; ++
    INC TMP_01 ; ++
    INC TMP_00 ; ++
    LDA TMP_00 ; Load
    CMP 634_UNK_INDEX ; If _ var. Target.
    BEQ RTS_EOF ; ==, goto.
    INC TMP_06 ; ++
    LDA TMP_06 ; Load
    AND #$07 ; Keep 0000.0111
    BNE LOOP_STREAM_SHIFTS ; !=, goto.
    LDA TMP_06 ; Load
    SEC ; Prep sub.
    SBC #$08 ; -= 8
    STA TMP_06 ; Store back.
    LDA TMP_07 ; Load
    EOR #$04 ; Invert 0000.0100
    STA TMP_07 ; Store back.
    LDA #$FF
    STA PPU_UPDATE_BUFFER[20],X ; Store EOF.
    INX ; Index++
    STX PPU_UPDATE_BUF_INDEX ; Store index.
    JMP LOOP_PREP_SHIFTS
RTS_EOF: ; 1F:01D2, 0x03E1D2
    LDA #$FF
    STA PPU_UPDATE_BUFFER[20],X
    INX
    STX PPU_UPDATE_BUF_INDEX
    RTS
BANK_SWITCH_BASED_ON_SCREEN/LEVEL: ; 1F:01DB, 0x03E1DB
    LDY LEVEL_SCREEN_ON ; Load index.
    LDA BANK_USE_DATA,Y ; Load bank.
    JMP BANK_PAIR_USE_A ; Goto bank.
BANK_USE_DATA: ; 1F:01E3, 0x03E1E3
    .db 26 ; Unk size.
    .db 26
    .db 26
    .db 26
    .db 2E
    .db 26
    .db 26
    .db 26
    .db 2E
    .db 2E
    .db 2E
    .db 2E ; Guessing this is the end as the data past looks like ptrs.
    .db 1F
    .db E2
    .db 24
    .db E2
    .db 29
    .db E2
    .db 2E
    .db E2
    .db 33
    .db E2
    .db 38
    .db E2
    .db 3D
    .db E2
    .db 42
    .db E2
    .db 47
    .db E2
    .db 4C
    .db E2
    .db 51
    .db E2
    .db 56
    .db E2
    .db 5B
    .db E2
    .db 60
    .db E2
    .db 65
    .db E2
    .db 6A
    .db E2
    .db 6F
    .db E2
    .db 74
    .db E2
    .db 79
    .db E2
    .db 7E
    .db E2
    .db 83
    .db E2
    .db 88
    .db E2
    .db 8D
    .db E2
    .db 92
    .db E2
    .db 08
    .db 08
    .db 00
    .db 20
    .db 0E
    .db 10
    .db 10
    .db 00
    .db 28
    .db 0E
    .db 08
    .db 08
    .db 00
    .db 10
    .db 0E
    .db 14
    .db 14
    .db 00
    .db 40
    .db 0E
    .db 20
    .db 00
    .db 00
    .db 30
    .db 10
    .db 20
    .db 20
    .db 00
    .db 30
    .db 0E
    .db 14
    .db 10
    .db 00
    .db 40
    .db 0E
    .db 18
    .db 18
    .db 00
    .db 40
    .db 18
    .db 10
    .db 10
    .db 00
    .db 20
    .db 0E
    .db 03
    .db 03
    .db 00
    .db 30
    .db 0E
    .db 10
    .db 10
    .db 00
    .db 30
    .db 0E
    .db 04
    .db 04
    .db 00
    .db 20
    .db 0E
    .db 0C
    .db 0C
    .db 00
    .db 14
    .db 14
    .db 0A
    .db 0A
    .db 00
    .db 30
    .db 0E
    .db 1C
    .db 00
    .db 00
    .db 30
    .db 0E
    .db 18
    .db 08
    .db 00
    .db 40
    .db 0E
    .db 18
    .db 18
    .db 00
    .db 20
    .db 0E
    .db 14
    .db 14
    .db 00
    .db 18
    .db 0E
    .db 0C
    .db 0C
    .db 00
    .db 30
    .db 0E
    .db 10
    .db 10
    .db 00
    .db 30
    .db 0E
    .db 14
    .db 0C
    .db 00
    .db 18
    .db 0E
    .db 08
    .db 08
    .db 00
    .db 20
    .db 0E
    .db 06
    .db 06
    .db 00
    .db 20
    .db 0E
    .db 10
    .db 10
    .db 00
    .db 40
    .db 0E
    .db 25
    .db E3
    .db 2C
    .db E3
    .db 33
    .db E3
    .db 3A
    .db E3
    .db 41
    .db E3
    .db 48
    .db E3
    .db 4F
    .db E3
    .db 56
    .db E3
    .db 5D
    .db E3
    .db 64
    .db E3
    .db 6B
    .db E3
    .db 72
    .db E3
    .db 79
    .db E3
    .db 80
    .db E3
    .db 87
    .db E3
    .db 8E
    .db E3
    .db 95
    .db E3
    .db 9C
    .db E3
    .db A3
    .db E3
    .db AA
    .db E3
    .db B1
    .db E3
    .db B8
    .db E3
    .db BF
    .db E3
    .db C6
    .db E3
    .db CD
    .db E3
    .db D4
    .db E3
    .db DB
    .db E3
    .db E2
    .db E3
    .db E9
    .db E3
    .db F0
    .db E3
    .db F7
    .db E3
    .db FE
    .db E3
    .db 05
    .db E4
    .db 0C
    .db E4
    .db 13
    .db E4
    .db 1A
    .db E4
    .db 21
    .db E4
    .db 28
    .db E4
    .db 2F
    .db E4
    .db 36
    .db E4
    .db 3D
    .db E4
    .db 44
    .db E4
    .db 4B
    .db E4
    .db 52
    .db E4
    .db 59
    .db E4
    .db 60
    .db E4
    .db 67
    .db E4
    .db 6E
    .db E4
    .db 75
    .db E4
    .db 7C
    .db E4
    .db 83
    .db E4
    .db 8A
    .db E4
    .db 91
    .db E4
    .db 98
    .db E4
    .db 9F
    .db E4
    .db A6
    .db E4
    .db AD
    .db E4
    .db B4
    .db E4
    .db BB
    .db E4
    .db C2
    .db E4
    .db C9
    .db E4
    .db D0
    .db E4
    .db D7
    .db E4
    .db DE
    .db E4
    .db E5
    .db E4
    .db EC
    .db E4
    .db F3
    .db E4
    .db FA
    .db E4
    .db 01
    .db E5
    .db 08
    .db E5
    .db 0F
    .db E5
    .db 04
    .db 38
    .db F8
    .db 10
    .db 0E
    .db 00
    .db 10
    .db 00
    .db 18
    .db F0
    .db 18
    .db 0E
    .db 01
    .db 41
    .db 08
    .db 10
    .db 00
    .db 22
    .db 0E
    .db 01
    .db 41
    .db 02
    .db 02
    .db 02
    .db 02
    .db 0E
    .db 83
    .db 41
    .db 05
    .db 05
    .db 00
    .db 10
    .db 0E
    .db 01
    .db 01
    .db 04
    .db 38
    .db F4
    .db 10
    .db 0E
    .db 00
    .db 11
    .db 08
    .db 08
    .db 06
    .db 04
    .db 0E
    .db 00
    .db 41
    .db 10
    .db 10
    .db 00
    .db 20
    .db 10
    .db 00
    .db 48
    .db 08
    .db 08
    .db 00
    .db 10
    .db 0E
    .db 02
    .db 21
    .db 08
    .db 08
    .db 00
    .db 10
    .db 0E
    .db 89
    .db 44
    .db 18
    .db 18
    .db 00
    .db 20
    .db 0E
    .db 8A
    .db 44
    .db 18
    .db 18
    .db 10
    .db 10
    .db 16
    .db 8B
    .db 44
    .db 10
    .db 20
    .db 00
    .db 20
    .db 0E
    .db 03
    .db 44
    .db 00
    .db 20
    .db F0
    .db 20
    .db 0E
    .db 03
    .db 44
    .db 00
    .db 1C
    .db 00
    .db 10
    .db 0E
    .db 04
    .db 44
    .db 00
    .db 1C
    .db 00
    .db 20
    .db 0E
    .db 04
    .db 44
    .db 00
    .db 20
    .db 00
    .db 20
    .db 0E
    .db 90
    .db 44
    .db 20
    .db 20
    .db 00
    .db 30
    .db 0E
    .db 91
    .db 44
    .db 30
    .db 18
    .db 18
    .db 08
    .db 0E
    .db 92
    .db 44
    .db 04
    .db 04
    .db 04
    .db 04
    .db 0E
    .db 93
    .db 42
    .db 00
    .db 20
    .db 00
    .db 30
    .db 0E
    .db 94
    .db 44
    .db 05
    .db 05
    .db 05
    .db 05
    .db 0E
    .db 95
    .db A4
    .db 04
    .db 04
    .db 06
    .db 04
    .db 0E
    .db 03
    .db 41
    .db 00
    .db 20
    .db 00
    .db 18
    .db 0E
    .db 97
    .db 44
    .db 03
    .db 03
    .db 03
    .db 03
    .db 0E
    .db 98
    .db 44
    .db 04
    .db 24
    .db E0
    .db 38
    .db 0E
    .db 03
    .db 44
    .db 05
    .db 05
    .db 05
    .db 05
    .db 0E
    .db 03
    .db 42
    .db 05
    .db 05
    .db 07
    .db 07
    .db 0E
    .db 03
    .db 42
    .db 05
    .db 05
    .db 0A
    .db 0A
    .db 0E
    .db 03
    .db 42
    .db 06
    .db 06
    .db 10
    .db 10
    .db 0E
    .db 03
    .db 42
    .db 05
    .db 05
    .db 05
    .db 05
    .db 0E
    .db 9E
    .db 44
    .db 03
    .db 20
    .db 00
    .db 30
    .db 0E
    .db 09
    .db 84
    .db 03
    .db 03
    .db 03
    .db 03
    .db 0E
    .db A0
    .db 42
    .db 06
    .db 06
    .db 06
    .db 06
    .db 0E
    .db A1
    .db 70
    .db 02
    .db 02
    .db 00
    .db 06
    .db 0E
    .db A2
    .db 44
    .db 00
    .db 30
    .db E8
    .db 48
    .db 0E
    .db A3
    .db 31
    .db 08
    .db 08
    .db 70
    .db 00
    .db 0E
    .db A4
    .db 44
    .db 03
    .db 03
    .db 03
    .db 03
    .db 0E
    .db A5
    .db 42
    .db 20
    .db 00
    .db 00
    .db 30
    .db 0E
    .db A6
    .db 44
    .db 00
    .db 20
    .db E0
    .db 28
    .db 0E
    .db 0F
    .db 44
    .db 00
    .db 30
    .db 00
    .db 28
    .db 0E
    .db 0F
    .db 44
    .db 1C
    .db 1C
    .db 1C
    .db 1C
    .db 18
    .db A9
    .db 48
    .db 04
    .db 04
    .db FC
    .db 0C
    .db 0E
    .db AA
    .db 42
    .db 08
    .db 08
    .db FE
    .db 0E
    .db 0E
    .db AB
    .db 42
    .db 04
    .db 04
    .db FC
    .db 0C
    .db 0E
    .db AC
    .db 44
    .db 00
    .db 28
    .db 00
    .db 10
    .db 0E
    .db 01
    .db 44
    .db 00
    .db 0C
    .db F0
    .db 20
    .db 0E
    .db 01
    .db 44
    .db 18
    .db 18
    .db 10
    .db 10
    .db 0E
    .db AF
    .db 46
    .db 10
    .db 10
    .db 00
    .db 20
    .db 10
    .db B0
    .db 48
    .db 0E
    .db 0E
    .db 04
    .db 04
    .db 0A
    .db B1
    .db 46
    .db 04
    .db 04
    .db 00
    .db 08
    .db 0E
    .db B2
    .db 46
    .db 04
    .db 04
    .db 00
    .db 10
    .db 0E
    .db B3
    .db 46
    .db 04
    .db 04
    .db 00
    .db 20
    .db 0E
    .db B4
    .db 46
    .db 04
    .db 04
    .db 00
    .db 30
    .db 0E
    .db B5
    .db 46
    .db 04
    .db 04
    .db 00
    .db 40
    .db 0E
    .db B6
    .db 46
    .db 18
    .db 1C
    .db 00
    .db 1C
    .db 0E
    .db 11
    .db 44
    .db 00
    .db 18
    .db F0
    .db 20
    .db 0E
    .db 12
    .db 41
    .db 04
    .db 04
    .db 04
    .db 04
    .db 0E
    .db B9
    .db 41
    .db 18
    .db 18
    .db 00
    .db 1C
    .db 0E
    .db 11
    .db 42
    .db 01
    .db 01
    .db 01
    .db 01
    .db 0E
    .db BB
    .db 44
    .db 00
    .db 40
    .db 00
    .db 20
    .db 0E
    .db 13
    .db 44
    .db 08
    .db 08
    .db 10
    .db 20
    .db 0E
    .db 14
    .db 42
    .db 08
    .db 20
    .db 10
    .db 20
    .db 0E
    .db 14
    .db 42
    .db 08
    .db 08
    .db FA
    .db 0A
    .db 0E
    .db BF
    .db 43
    .db 0E
    .db 0E
    .db 00
    .db 1C
    .db 0E
    .db C0
    .db 44
    .db 01
    .db 01
    .db 01
    .db 01
    .db 0E
    .db C1
    .db 41
    .db 04
    .db 04
    .db 00
    .db 02
    .db 0E
    .db 15
    .db 44
    .db 00
    .db 24
    .db 10
    .db 20
    .db 10
    .db 17
    .db 44
    .db 18
    .db 18
    .db 00
    .db 30
    .db 0E
    .db C4
    .db 48
    .db 10
    .db 10
    .db 10
    .db 10
    .db 10
    .db C5
    .db 48
    .db 14
    .db 14
    .db 14
    .db 14
    .db 0E
    .db C6
    .db 46
    .db 22
    .db E5
    .db 22
    .db E5
    .db 22
    .db E5
    .db 36
    .db E5
    .db 72
    .db E3
    .db 6E
    .db E4
    .db 0C
    .db 0C
    .db 00
    .db 28
    .db 08
    .db 08
    .db FC
    .db 1C
    .db 10
    .db 04
    .db 00
    .db 1C
    .db 16
    .db 08
    .db 00
    .db 28
    .db 18
    .db 08
    .db 00
    .db 28
    .db 0C
    .db 0C
    .db 00
    .db 28
    .db 08
    .db 08
    .db FC
    .db 1C
    .db 10
    .db 04
    .db 00
    .db 1C
    .db 1A
    .db 0C
    .db 00
    .db 28
    .db 1C
    .db 0C
    .db 00
    .db 28
DATA_UNK_A: ; 1F:054A, 0x03E54A
    .db AC
DATA_UNK_B: ; 1F:054B, 0x03E54B
    .db E5
    .db AC
    .db E5
    .db AA
    .db E5
    .db AA
    .db E5
    .db DA
    .db E5
    .db DA
    .db E5
    .db B2
    .db E5
    .db B2
    .db E5
    .db BA
    .db E5
    .db BA
    .db E5
    .db C4
    .db E5
    .db C4
    .db E5
    .db D2
    .db E5
    .db D2
    .db E5
    .db E6
    .db E5
    .db E6
    .db E5
    .db E6
    .db E5
    .db E6
    .db E5
    .db EA
    .db E5
    .db EA
    .db E5
    .db AA
    .db E5
    .db AA
    .db E5
    .db F2
    .db E5
    .db F2
    .db E5
    .db FA
    .db E5
    .db FA
    .db E5
    .db 02
    .db E6
    .db 02
    .db E6
    .db 16
    .db E6
    .db 16
    .db E6
    .db EE
    .db E5
    .db AA
    .db E5
    .db 08
    .db E6
    .db 08
    .db E6
    .db 10
    .db E6
    .db 10
    .db E6
    .db 26
    .db E6
    .db 26
    .db E6
    .db 26
    .db E6
    .db 26
    .db E6
    .db 2A
    .db E6
    .db 2A
    .db E6
    .db 1E
    .db E6
    .db 1E
    .db E6
    .db 22
    .db E6
    .db 22
    .db E6
    .db AA
    .db E5
    .db AA
    .db E5
    .db FF
    .db 00
    .db BF
    .db 01
    .db FA
    .db 03
    .db FD
    .db 03
    .db CF
    .db 01
    .db F9
    .db 03
    .db FB
    .db 01
    .db FD
    .db 03
    .db 4F
    .db 01
    .db 52
    .db 08
    .db AA
    .db 01
    .db FC
    .db 03
    .db FD
    .db 03
    .db A8
    .db 01
    .db DF
    .db 03
    .db E4
    .db 05
    .db EF
    .db 03
    .db F5
    .db 05
    .db F6
    .db 03
    .db FD
    .db 03
    .db A8
    .db 01
    .db F4
    .db 03
    .db F7
    .db 01
    .db FD
    .db 03
    .db 00
    .db 01
    .db 3A
    .db 07
    .db BD
    .db 01
    .db EC
    .db 05
    .db F8
    .db 06
    .db FD
    .db 05
    .db ED
    .db 01
    .db FD
    .db 03
    .db 59
    .db 01
    .db FD
    .db 03
    .db 47
    .db 01
    .db 7F
    .db 03
    .db D9
    .db 01
    .db F6
    .db 03
    .db FC
    .db 05
    .db FD
    .db 03
    .db D9
    .db 01
    .db F6
    .db 03
    .db FB
    .db 05
    .db FD
    .db 03
    .db D4
    .db 01
    .db FC
    .db 03
    .db FD
    .db 03
    .db C2
    .db 01
    .db D8
    .db 03
    .db DF
    .db 01
    .db FD
    .db 03
    .db C8
    .db 01
    .db F8
    .db 03
    .db FD
    .db 03
    .db 8F
    .db 01
    .db D8
    .db 03
    .db DF
    .db 01
    .db FD
    .db 03
    .db BF
    .db 01
    .db FF
    .db 03
    .db 3F
    .db 01
    .db FF
    .db 03
    .db 9C
    .db 01
    .db FF
    .db 03
    .db 7E
    .db 01
    .db F9
    .db 03
    .db FD
    .db 03
RTN_UNK_RTS_CARRY_SET_FAIL?: ; 1F:0630, 0x03E630
    STA 8E_UNK ; A to.
    AND #$7F ; Get bottom bits.
    STA 8C_UNK ; Store to.
    LDA LEVEL_SCREEN_ON ; Load
    CMP #$07 ; If _ #$07
    BNE 42_NE_SEVEN ; !=, goto.
    LDA 8E_UNK ; Load
    CMP #$0D ; If _ #$0D
    BEQ 8E_WAS_DEE ; ==, goto.
    BNE RETURN_CARRY_CLEAR ; !=, goto. Always taken.
42_NE_SEVEN: ; 1F:0644, 0x03E644
    TXA ; Save X+Y
    PHA
    TYA
    PHA
    LDA OBJ_POS_Y[18],X ; Load obj val.
    LDY 8E_UNK ; Y from.
    BPL 8E_VAL_POSITIVE ; If positive, goto.
    LDA OBJ_STATE/SWITCH[18],X ; Load
    AND #$09 ; Keep 0000.1001.
    BEQ NONE_SET ; If none set, goto.
    LDY TMP_08 ; Get player focus.
    LDA A0_PLAYER_UNK[2],Y ; Load
    CLC
    ADC 4A2_OBJ_UNK_POS?[18],X ; += Obj.
    JMP 8E_VAL_POSITIVE ; Goto.
NONE_SET: ; 1F:0662, 0x03E662
    LDA 4A2_OBJ_UNK_POS?[18],X ; Load val.
8E_VAL_POSITIVE: ; 1F:0665, 0x03E665
    STA 8E_UNK ; A to 8E.
    LDA 8C_UNK ; Load 8C.
    ASL A ; << 2, *4.
    ASL A
    TAY ; To Y index.
    LDA DATA_UNK_A,Y ; Load
    CLC
    ADC 8E_UNK ; Add with.
    CLC
    ADC DATA_UNK_B,Y ; Add also.
    PHA ; Save value.
    LDA DATA_UNK_C,Y ; Load val.
    STA 8E_UNK ; Store to.
    LDA DATA_UNK_D,Y ; Load val.
    CLC
    ADC OBJ_POS_X[18],X ; Add val.
    TAY ; To Y index.
    PLA ; Pull previous.
    JSR RTN_SCREEN?_UNK ; Do ?
    LDA 8E_UNK ; Load val.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA DATA_UNK_A,Y ; Set up 8D stream pointer.
    STA 8D_UNK
    LDA DATA_UNK_B,Y
    STA 8E_UNK
    LDY #$00 ; Stream reset.
LOOP_DATA_STREAM: ; 1F:0698, 0x03E698
    LDA [8D_UNK],Y ; Load from stream.
    CMP 8C_UNK ; If _ var
    BEQ RTS_RESTORE_YX_CARRY_SET ; ==, goto.
    INY ; Stream++
    LDA [8D_UNK],Y ; Load from stream again.
    CMP #$FF ; If _ #$FF
    BNE LOOP_DATA_STREAM ; !=, goto.
    PLA ; Restore Y and X.
    TAY
    PLA
    TAX
RETURN_CARRY_CLEAR: ; 1F:06A9, 0x03E6A9
    CLC
    RTS
RTS_RESTORE_YX_CARRY_SET: ; 1F:06AB, 0x03E6AB
    PLA ; Restore Y and X.
    TAY
    PLA
    TAX
8E_WAS_DEE: ; 1F:06AF, 0x03E6AF
    SEC
    RTS
DATA_UNK_A: ; 1F:06B1, 0x03E6B1
    .db 00
DATA_UNK_D: ; 1F:06B2, 0x03E6B2
    .db 08
DATA_UNK_C: ; 1F:06B3, 0x03E6B3
    .db 00
DATA_UNK_B: ; 1F:06B4, 0x03E6B4
    .db 00
    .db 01
    .db F8
    .db 01
    .db 00
    .db F8
    .db 00
    .db 02
    .db 00
    .db 00
    .db 00
    .db 03
    .db 00
    .db 00
    .db 00
    .db 04
    .db 00
    .db 04
    .db 00
    .db 05
    .db 00
    .db 04
    .db 00
    .db 06
    .db 00
    .db 02
    .db 08
    .db 07
    .db 00
    .db 02
    .db F8
    .db 08
    .db 00
    .db F8
    .db 00
    .db 09
    .db 00
    .db 02
    .db 10
    .db 07
    .db 00
    .db 02
    .db F0
    .db 08
    .db 00
    .db E8
    .db 00
    .db 09
    .db 00
    .db F8
    .db 00
    .db 0A
    .db 00
DATA_UNK_A: ; 1F:06E9, 0x03E6E9
    .db FF
DATA_UNK_B: ; 1F:06EA, 0x03E6EA
    .db E6
    .db 03
    .db E7
    .db 07
    .db E7
    .db 0B
    .db E7
    .db 0D
    .db E7
    .db 10
    .db E7
    .db 13
    .db E7
    .db 15
    .db E7
    .db 17
    .db E7
    .db 1A
    .db E7
    .db 1D
    .db E7
    .db 01
    .db 07
    .db 08
    .db FF
    .db 01
    .db 07
    .db 08
    .db FF
    .db 01
    .db 07
    .db 08
    .db FF
    .db 05
    .db FF
    .db 01
    .db 08
    .db FF
    .db 01
    .db 07
    .db FF
    .db 06
    .db FF
    .db 01
    .db FF
    .db 01
    .db 08
    .db FF
    .db 01
    .db 08
    .db FF
    .db 03
    .db 05
    .db 06
    .db FF
RTN_UNK: ; 1F:0721, 0x03E721
    STA 8C_UNK
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BEQ 1F:0798
    CMP #$02
    BEQ 1F:0735
    CMP #$03
    BEQ 1F:0735
    CMP #$08
    BNE 1F:07A8
    TXA
    PHA
    TYA
    PHA
    LDY TMP_08
    LDA **:$064F,Y
    BEQ 1F:0749
    LDA #$00
    SEC
    SBC **:$0651,Y
    JMP 1F:074F
    LDA #$00
    SEC
    SBC 4C6_OBJ_UNK_POS?[18],X
    LSR A
    STA 8E_UNK
    LDA #$00
    SEC
    SBC 8E_UNK
    CLC
    ADC 4A2_OBJ_UNK_POS?[18],X
    STA 8E_UNK
    LDA 8C_UNK
    ASL A
    ASL A
    TAY
    LDA DATA_UNK_A,Y
    CLC
    ADC 8E_UNK
    CLC
    ADC DATA_UNK_B,Y
    PHA
    LDA DATA_UNK_D,Y
    CLC
    ADC OBJ_POS_X[18],X
    TAY
    PLA
    JSR RTN_SCREEN?_UNK
    LDY TMP_08
    LDA 8C_UNK
    CMP #$01
    BEQ 1F:079A
    CMP #$05
    BNE 1F:078F
    LDA 4C6_OBJ_UNK_POS?[18],X
    STA **:$0651,Y
    LDA #$01
    BNE 1F:0791
    LDA #$00
    STA **:$064F,Y
    PLA
    TAY
    PLA
    TAX
    CLC
    RTS
    LDA A0_PLAYER_UNK[2],Y
    BNE 1F:078F
    LDA #$00
    STA **:$064F,Y
    PLA
    TAY
    PLA
    TAX
    SEC
    RTS
RTN_SCREEN?_UNK: ; 1F:07AA, 0x03E7AA
    PHA ; Save A.
    LDA LEVEL_SCREEN_ON ; Load
    CMP #$02 ; If _ #$02
    BNE 42_NOT_TWO ; !=, goto.
    PLA ; Pull
    SEC
    SBC #$04 ; -= 4.
    PHA ; Save.
42_NOT_TWO: ; 1F:07B6, 0x03E7B6
    PLA ; Pull.
    SEC
    SBC #$30 ; -= 0x30
    BCS NO_UNDERFLOW_SUB ; No underflow.
    LDA #$01
    BNE RTS_A_TO_8C ; Always taken.
NO_UNDERFLOW_SUB: ; 1F:07C0, 0x03E7C0
    CLC
    ADC 81_UNK ; A += val.
    BCS ADD_OVERFLOW ; Overflow, goto.
    CMP #$C0 ; If _ #$C0
    BCC 1F:07CB ; <, goto.
ADD_OVERFLOW: ; 1F:07C9, 0x03E7C9
    SBC #$C0 ; Subtract 0xC0.
    AND #$F0 ; Keep only 1111.0000
    LSR A ; >> 1, /2.
    STA 8C_UNK ; To 8C.
    TYA ; Y to A.
    CLC
    ADC B1_SCROLL_X_COPY_IRQ_ZP[2] ; += Var.
    STA 8D_UNK ; Store to.
    PHA ; Save A.
    LDA NAMETABLE_FOCUS_VAL[2] ; Load 
    ADC #$00 ; Carry from last add.
    PHA ; Save val.
    LDA 8D_UNK ; Load
    LSR A ; > 5, /32.
    LSR A
    LSR A
    LSR A
    LSR A
    AND #$07 ; Keep only 0000.0111
    CLC ; Prep add.
    ADC 8C_UNK ; += var.
    STA 8D_UNK ; Store to.
    TAY ; Val to Y.
    PLA ; Pull value.
    AND #$01 ; Get bottom bit.
    BEQ BOTTOM_BIT_UNSET ; Not set, goto.
    LDA 8D_UNK ; Load
    CLC
    ADC #$60 ; += 0x60
    TAY ; To Y instead.
BOTTOM_BIT_UNSET: ; 1F:07F6, 0x03E7F6
    PLA ; Pull val.
    AND #$10 ; Test 0001.0000
    BEQ BIT_0x10_UNSET
    LDA 740_UNK,Y ; Load from, indexed.
    LSR A
    LSR A
    LSR A
    LSR A ; >> 4, /16. Upper nibble lower.
    JMP RTS_A_TO_8C
BIT_0x10_UNSET: ; 1F:0805, 0x03E805
    LDA 740_UNK,Y ; Load from, indexed.
    AND #$0F ; Keep bottom bits.
RTS_A_TO_8C: ; 1F:080A, 0x03E80A
    STA 8C_UNK ; Store val.
    RTS ; Leave.
    LDA #$00
    BEQ RTS_A_TO_8C
    STX TMP_08
    LDA 556_ARR_UNK[18],X
    AND #$03
    BEQ 1F:0823
    LDA #$00
    STA TMP_0C
    STA ZP_0D_UNK
    LDX TMP_08
    RTS
    LDY #$02
    STY TMP_0B
    LDX #$04
    STX TMP_09
    LDA OBJ_ANIMATION_FRAME_TO[18],X
    BEQ 1F:0835
    JSR 1F:086E
    BNE 1F:086B
    INC TMP_0B
    INC TMP_09
    LDY TMP_0B
    LDX TMP_09
    CPX #$07
    BCC 1F:082B
    LDY #$00
    LDX #$00
    LDA NUM_PLAYER_LIVES[2]
    BPL 1F:084D
    LDA #$00
    BEQ 1F:0850
    JSR 1F:086E
    STA TMP_0C
    LDA 47_TWO_PLAYERS_FLAG
    BEQ 1F:0865
    LDY #$01
    LDX #$02
    LDA NUM_PLAYER_LIVES+1
    BPL 1F:0862
    LDA #$00
    BEQ 1F:0865
    JSR 1F:086E
    STA ZP_0D_UNK
    LDA TMP_0C
    ORA ZP_0D_UNK
    LDX TMP_08
    RTS
    STY TMP_0B
    STX TMP_09
    LDX TMP_08
    LDA OBJECT_DATA_EXTRA_B?[18],X
    BPL 1F:088B
    ASL A
    TAY
    LDA 1F:0297,Y
    STA **:$00AA
    LDA 1F:0298,Y
    STA **:$00AB
    LDY #$05
    LDA [**:$00AA],Y
    BMI 1F:0897
    ASL A
    TAY
    LDA 1F:01EF,Y
    STA **:$00A8
    LDA 1F:01F0,Y
    STA **:$00A9
    LDX TMP_09
    CPX #$04
    BCS 1F:08A4
    LDA OBJ_STATE/SWITCH[18],X
    AND #$02
    BEQ 1F:08B5
    LDY TMP_08
    LDA OBJ_POS_X[18],X
    CMP OBJ_POS_X[18],Y
    BCC 1F:08B8
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BNE 1F:08BF
    JMP 1F:0AD0
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BNE 1F:08B5
    LDX TMP_08
    LDA OBJECT_DATA_EXTRA_B?[18],X
    BPL 1F:08E9
    LDY #$05
    LDA [**:$00AA],Y
    BPL 1F:08E9
    LDY #$00
    LDA [**:$00AA],Y
    STA TMP_00
    INY
    LDA [**:$00AA],Y
    STA TMP_01
    INY
    LDA [**:$00AA],Y
    STA TMP_02
    INY
    LDA [**:$00AA],Y
    STA TMP_03
    INY
    LDA [**:$00AA],Y
    STA TMP_0A
    JMP 1F:0903
    LDY #$00
    LDA [**:$00A8],Y
    STA TMP_00
    INY
    LDA [**:$00A8],Y
    STA TMP_01
    INY
    LDA [**:$00A8],Y
    STA TMP_02
    INY
    LDA [**:$00A8],Y
    STA TMP_03
    INY
    LDA [**:$00A8],Y
    STA TMP_0A
    CLC
    LDA 4C6_OBJ_UNK_POS?[18],X
    ADC TMP_02
    BMI 1F:090D
    LDA #$FF
    STA TMP_02
    LDA 4C6_OBJ_UNK_POS?[18],X
    SEC
    SBC TMP_03
    BMI 1F:0919
    LDA #$80
    STA TMP_03
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BEQ 1F:092C
    LDA TMP_00
    PHA
    LDA TMP_01
    STA TMP_00
    PLA
    STA TMP_01
    LDA TMP_00
    CLC
    ADC OBJ_POS_X[18],X
    BCC 1F:0936
    LDA #$FC
    STA TMP_00
    LDA OBJ_POS_X[18],X
    SEC
    SBC TMP_01
    BCS 1F:0942
    LDA #$04
    STA TMP_01
    LDA 4A2_OBJ_UNK_POS?[18],X
    STA TMP_07
    JSR 1F:0C3E
    BCS 1F:0951
    JMP 1F:0AD0
    LDY TMP_08
    CPX #$04
    BCC 1F:095A
    JMP 1F:0AB4
    LDA OBJ_STATE/SWITCH[18],X
    AND #$04
    BEQ 1F:0964
    LDA #$00
    RTS
    LDA OBJ_STATE/SWITCH[18],X
    AND #$08
    BNE 1F:0974
    LDA OBJ_STATE/SWITCH[18],X
    AND #$0B
    CMP #$03
    BNE 1F:0980
    LDA OBJ_STATE/SWITCH[18],Y
    CMP #$03
    BNE 1F:0980
    LDA OBJECT_DATA_EXTRA_B?[18],Y
    BMI 1F:094E
    LDA OBJECT_DATA_EXTRA_B?[18],Y
    CMP #$8B
    BEQ 1F:0998
    CMP #$AF
    BEQ 1F:098E
    JMP 1F:0A7A
    STA ZP_0E_UNK
    LDA #$19
    JSR SND_BANKED_DISPATCH
    JMP 1F:099F
    STA ZP_0E_UNK
    LDA #$2C
    JSR SND_BANKED_DISPATCH
    LDX #$04
    LDA OBJ_ANIMATION_FRAME_TO[18],X
    BEQ 1F:09B0
    INX
    CPX #$07
    BCC 1F:09A1
    LDX TMP_09
    JMP 1F:0A7A
    LDA OBJ_ANIMATION_FRAME_TO[18],Y
    STA OBJ_ANIMATION_FRAME_TO[18],X
    LDA OBJ_STATE/SWITCH[18],Y
    STA OBJ_STATE/SWITCH[18],X
    LDA ARR_OBJECT_ENABLED+MORE?[18],Y
    STA ARR_OBJECT_ENABLED+MORE?[18],X
    LDA OBJ_DIRECTION_RELATED?[18],Y
    STA OBJ_DIRECTION_RELATED?[18],X
    LDA OBJ_ANIM_HOLD_TIMER?[18],Y
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA 45A_OBJ_DATA_ENTRY?[18],Y
    STA 45A_OBJ_DATA_ENTRY?[18],X
    LDA OBJ_POS_Y[18],Y
    STA OBJ_POS_Y[18],X
    LDA OBJ_POS_X[18],Y
    STA OBJ_POS_X[18],X
    LDA 490_OBJ_UNK_SPEED?[18],Y
    STA 490_OBJ_UNK_SPEED?[18],X
    LDA 4A2_OBJ_UNK_POS?[18],Y
    STA 4A2_OBJ_UNK_POS?[18],X
    LDA 4B4_OBJ_SPEED?[18],Y
    STA 4B4_OBJ_SPEED?[18],X
    LDA 4C6_OBJ_UNK_POS?[18],Y
    STA 4C6_OBJ_UNK_POS?[18],X
    LDA 4D8_ARR_UNK[18],Y
    STA 4D8_ARR_UNK[18],X
    LDA 4EA_ARR_UNK[18],Y
    STA 4EA_ARR_UNK[18],X
    LDA 4FC_ARR_UNK[18],Y
    STA 4FC_ARR_UNK[18],X
    LDA 50E_ARR_UNK[18],Y
    STA 50E_ARR_UNK[18],X
    LDA 520_ARR_UNK[18],Y
    STA 520_ARR_UNK[18],X
    LDA 532_OBJ_UNK_POS?[18],Y
    STA 532_OBJ_UNK_POS?[18],X
    LDA 544_OBJ_UNK_POS?[18],Y
    STA 544_OBJ_UNK_POS?[18],X
    LDA 556_ARR_UNK[18],Y
    STA 556_ARR_UNK[18],X
    LDA OBJECT_DATA_EXTRA_A?[18],Y
    STA OBJECT_DATA_EXTRA_A?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA 58C_ARR_UNK[18],Y
    STA 58C_ARR_UNK[18],X
    LDA 59E_OBJ_UNK_TIMER?[18],Y
    STA 59E_OBJ_UNK_TIMER?[18],X
    LDA 5B0_ARR_UNK[18],Y
    STA 5B0_ARR_UNK[18],X
    LDA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],Y
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDA 5D4_ARR_OBJ_TIMER?[18],Y
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDA #$00
    SEC
    SBC 4FC_ARR_UNK[18],Y
    STA 4FC_ARR_UNK[18],X
    LDA #$00
    SBC 4EA_ARR_UNK[18],Y
    STA 4EA_ARR_UNK[18],X
    LDA ZP_0E_UNK
    CMP #$8B
    BEQ 1F:0A6C
    LDA #$05
    BNE 1F:0A6E
    LDA #$04
    DEX
    DEX
    STA TURTLE_SELECT_POSITIONS[2],X
    TYA
    TAX
    JSR INIT_OBJECT[X]_DATA?
    LDA #$00
    RTS
    LDA **:$070E
    BNE 1F:0AD0
    LDA OBJ_STATE/SWITCH[18],Y
    CMP #$04
    BEQ 1F:0AD0
    LDA OBJECT_DATA_EXTRA_A?[18],Y
    CMP #$FF
    BEQ 1F:0AD0
    LDA OBJ_STATE/SWITCH[18],X
    AND #$01
    BEQ 1F:0AA3
    LDA OBJ_STATE/SWITCH[18],X
    AND #$08
    BEQ 1F:0A9F
    LDA #$04
    BNE 1F:0AA5
    LDA #$03
    BNE 1F:0AA5
    LDA #$02
    STA ZP_0E_UNK
    LDA **:$06D6
    BNE 1F:0AB4
    LDA OBJECT_DATA_EXTRA_A?[18],Y
    SEC
    SBC ZP_0E_UNK
    BCS 1F:0AB6
    LDA #$00
    STA OBJECT_DATA_EXTRA_A?[18],Y
    BNE 1F:0ACD
    CPX #$03
    BCS 1F:0ACD
    TYA
    PHA
    LDY TMP_0B
    LDA #$01
    STA **:$03F6,Y
    JSR 1E:1C72
    PLA
    TAY
    LDA #$01
    RTS
    CPX #$04
    BCS 1F:0B49
    LDX TMP_08
    LDA OBJECT_DATA_EXTRA_B?[18],X
    BPL 1F:0B49
    LDY #$00
    LDA [**:$00AA],Y
    STA TMP_00
    INY
    LDA [**:$00AA],Y
    STA TMP_01
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BEQ 1F:0AF7
    LDA TMP_00
    PHA
    LDA TMP_01
    STA TMP_00
    PLA
    STA TMP_01
    LDA TMP_00
    CLC
    ADC OBJ_POS_X[18],X
    BCC 1F:0B01
    LDA #$FC
    STA TMP_00
    LDA OBJ_POS_X[18],X
    SEC
    SBC TMP_01
    BCS 1F:0B0D
    LDA #$04
    STA TMP_01
    INY
    LDA [**:$00AA],Y
    CLC
    ADC 4C6_OBJ_UNK_POS?[18],X
    BMI 1F:0B1A
    LDA #$FF
    STA TMP_02
    INY
    LDA 4C6_OBJ_UNK_POS?[18],X
    SEC
    SBC [**:$00AA],Y
    BMI 1F:0B27
    LDA #$80
    STA TMP_03
    INY
    LDA [**:$00AA],Y
    STA TMP_0A
    LDA 4A2_OBJ_UNK_POS?[18],X
    STA TMP_07
    LDX TMP_09
    LDA OBJECT_DATA_EXTRA_B?[18],X
    PHA
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR 1F:0C3E
    BCS 1F:0B4C
    LDX TMP_09
    PLA
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$00
    RTS
    LDX TMP_09
    PLA
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDY TMP_08
    LDA OBJECT_DATA_EXTRA_B?[18],Y
    BPL 1F:0B49
    LDA OBJ_STATE/SWITCH[18],Y
    CMP #$06
    BEQ 1F:0B49
    LDY #$06
    LDA [**:$00AA],Y
    AND #$F0
    CMP #$70
    BEQ 1F:0B70
    CMP #$80
    BEQ 1F:0B49
    BNE 1F:0B8B
    LDA OBJ_STATE/SWITCH[18],X
    AND #$0D
    BNE 1F:0B49
    LDA #$3C
    STA OBJECT_DATA_EXTRA_A?[18],X
    LDY TMP_0B
    LDA #$01
    STA **:$0662,Y
    LDA #$5C
    JSR SND_BANKED_DISPATCH
    LDA #$01
    RTS
    LDY TMP_0B
    LDA 93_PLAYER_UNK[2],Y
    BNE 1F:0B49
    LDA OBJ_STATE/SWITCH[18],X
    AND #$04
    BNE 1F:0B49
    LDA OBJ_STATE/SWITCH[18],X
    ORA #$04
    STA OBJ_STATE/SWITCH[18],X
    LDY #$06
    LDA [**:$00AA],Y
    AND #$0F
    STA ZP_0E_UNK
    LDA [**:$00AA],Y
    LSR A
    LSR A
    LSR A
    LSR A
    STA OBJECT_DATA_EXTRA_B?[18],X
    CMP #$03
    BCS 1F:0BDE
    LDA OBJ_STATE/SWITCH[18],X
    AND #$01
    BEQ 1F:0BC8
    LDA OBJ_STATE/SWITCH[18],X
    AND #$FB
    STA OBJ_STATE/SWITCH[18],X
    JMP 1F:0B49
    LDA TMP_08
    STA 5D4_ARR_OBJ_TIMER?[18],X
    TAY
    LDA #$06
    STA OBJ_STATE/SWITCH[18],Y
    LDA #$00
    STA 58C_ARR_UNK[18],Y
    JSR 1F:0C16
    LDA #$FF
    RTS
    CMP #$03
    BEQ 1F:0BE6
    CMP #$0A
    BNE 1F:0BED
    LDA OBJ_STATE/SWITCH[18],X
    AND #$01
    BNE 1F:0BBD
    LDA TMP_08
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDA **:$06D6
    BNE 1F:0C0B
    LDA OBJECT_DATA_EXTRA_A?[18],X
    SEC
    SBC ZP_0E_UNK
    BCS 1F:0C01
    LDA #$00
    STA OBJECT_DATA_EXTRA_A?[18],X
    LDY TMP_0B
    LDA #$01
    STA **:$0662,Y
    LDY TMP_0B
    LDA **:$0091,Y
    CLC
    ADC ZP_0E_UNK
    STA **:$0091,Y
    LDY TMP_0B
    LDA #$00
    STA 43_PLAYER_UNK[2],Y
    STA 4FC_ARR_UNK[18],X
    STA 4EA_ARR_UNK[18],X
    STA 520_ARR_UNK[18],X
    STA 50E_ARR_UNK[18],X
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    STA 4FC_ARR_UNK+1,X
    STA 4EA_ARR_UNK+1,X
    STA 520_ARR_UNK+1,X
    STA 50E_ARR_UNK+1,X
    LDA #$02
    RTS
    LDX TMP_09
    CPX #$04
    BCC 1F:0C68
    LDA OBJECT_DATA_EXTRA_B?[18],X
    BPL 1F:0C5A
    LDY #$05
    LDA [**:$00AA],Y
    BPL 1F:0C5A
    LDA **:$00AA
    STA TMP_04
    LDA **:$00AB
    STA TMP_05
    JMP 1F:0C62
    LDA **:$00A8
    STA TMP_04
    LDA **:$00A9
    STA TMP_05
    LDY #$00
    STY TMP_06
    BEQ 1F:0C80
    LDA OBJECT_DATA_EXTRA_B?[18],X
    ASL A
    ASL A
    STA TMP_06
    LDY TMP_0B
    LDA TURTLE_SELECT_POSITIONS[2],Y
    ASL A
    TAY
    LDA 1F:0516,Y
    STA TMP_04
    LDA 1F:0517,Y
    STA TMP_05
    LDA 4A2_OBJ_UNK_POS?[18],X
    SEC
    SBC TMP_07
    BPL 1F:0C8F
    STA TMP_07
    LDA #$00
    SEC
    SBC TMP_07
    CMP TMP_0A
    BCS 1F:0CE4
    LDY TMP_06
    INY
    INY
    LDA [TMP_04],Y
    CLC
    ADC 4C6_OBJ_UNK_POS?[18],X
    BMI 1F:0CA1
    LDA #$FF
    CMP TMP_03
    BCC 1F:0CE4
    INY
    LDA 4C6_OBJ_UNK_POS?[18],X
    SEC
    SBC [TMP_04],Y
    BMI 1F:0CB4
    CMP #$70
    BCS 1F:0CB4
    LDA #$FF
    CMP TMP_02
    BCS 1F:0CE4
    LDY TMP_06
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BEQ 1F:0CC2
    INY
    LDA [TMP_04],Y
    CLC
    ADC OBJ_POS_X[18],X
    BCS 1F:0CCE
    CMP TMP_01
    BCC 1F:0CE4
    LDY TMP_06
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$40
    BNE 1F:0CD8
    INY
    LDA OBJ_POS_X[18],X
    SEC
    SBC [TMP_04],Y
    BCC 1F:0CE6
    CMP TMP_00
    BCC 1F:0CE6
    CLC
    RTS
    SEC
    RTS
DATA_UNK_L: ; 1F:0CE8, 0x03ECE8
    .db 00
DATA_UNK_H: ; 1F:0CE9, 0x03ECE9
    .db ED
    .db 0B
    .db ED
    .db 11
    .db ED
    .db 3F
    .db ED
    .db B4
    .db ED
    .db 49
    .db ED
    .db 5A
    .db ED
    .db 69
    .db ED
    .db 93
    .db ED
    .db C6
    .db ED
    .db A0
    .db ED
    .db AF
    .db ED
    .db 06
    .db 00
    .db 07
    .db 01
    .db 02
    .db 03
    .db 04
    .db 05
    .db 06
    .db 07
    .db 00
    .db 00
    .db 80
    .db 02
    .db 08
    .db 09
    .db 00
    .db 05
    .db 00
    .db 0B
    .db 0A
    .db 0B
    .db 0C
    .db 0D
    .db 0E
    .db 0F
    .db 10
    .db 16
    .db 17
    .db 18
    .db 19
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 11
    .db 12
    .db 13
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 14
    .db 15
    .db 16
    .db 17
    .db 18
    .db 19
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 14
    .db 15
    .db 16
    .db 17
    .db 00
    .db 05
    .db 00
    .db 06
    .db 1A
    .db 1B
    .db 1C
    .db 1F
    .db 20
    .db 21
    .db 00
    .db 0A
    .db 00
    .db 0D
    .db 22
    .db 23
    .db 24
    .db 25
    .db 26
    .db 27
    .db 28
    .db 29
    .db 2A
    .db 2B
    .db 2C
    .db 2D
    .db 2E
    .db 00
    .db 07
    .db 00
    .db 0B
    .db 2F
    .db 30
    .db 31
    .db 35
    .db 32
    .db 31
    .db 2F
    .db 33
    .db 34
    .db 2F
    .db 2F
    .db 00
    .db 26
    .db 00
    .db 27
    .db 39
    .db 38
    .db 36
    .db 37
    .db 36
    .db 37
    .db 38
    .db 38
    .db 38
    .db 3A
    .db 3A
    .db 3A
    .db 3B
    .db 3C
    .db 3C
    .db 3C
    .db 3D
    .db 3A
    .db 3A
    .db 3A
    .db 3A
    .db 3A
    .db 3A
    .db 3A
    .db 3B
    .db 3C
    .db 3C
    .db 3C
    .db 3D
    .db 3A
    .db 3F
    .db 3E
    .db 3E
    .db 3E
    .db 3E
    .db 3E
    .db 40
    .db 3E
    .db 00
    .db 08
    .db 00
    .db 09
    .db 41
    .db 42
    .db 43
    .db 44
    .db 45
    .db 46
    .db 47
    .db 48
    .db 49
    .db 00
    .db 0B
    .db 00
    .db 0C
    .db 4A
    .db 4B
    .db 4C
    .db 4D
    .db 55
    .db 56
    .db 4E
    .db 4F
    .db 50
    .db 51
    .db 52
    .db 53
    .db 00
    .db 00
    .db 01
    .db 54
    .db 00
    .db 09
    .db 00
    .db 0E
    .db 57
    .db 58
    .db 59
    .db 5A
    .db 5B
    .db 5C
    .db 59
    .db 5D
    .db 5E
    .db 5F
    .db 59
    .db 60
    .db 59
    .db 59
    .db 00
    .db 0B
    .db 00
    .db 0C
    .db 61
    .db 62
    .db 63
    .db 64
    .db 6B
    .db 6C
    .db 65
    .db 66
    .db 67
    .db 68
    .db 69
    .db 6A
    .db 00
DATA_UNK_A: ; 1F:0DD6, 0x03EDD6
    .db B0
DATA_UNK_B: ; 1F:0DD7, 0x03EDD7
    .db EE
    .db 4D
    .db 95
    .db 7D
    .db 95
    .db AD
    .db 95
    .db DD
    .db 95
    .db 0D
    .db 96
    .db 3D
    .db 96
    .db 6D
    .db 96
    .db 9D
    .db 96
    .db CD
    .db 96
    .db CB
    .db AB
    .db FB
    .db AB
    .db 2B
    .db AC
    .db 5B
    .db AC
    .db 8B
    .db AC
    .db BB
    .db AC
    .db EB
    .db AC
    .db 1B
    .db AD
    .db 4B
    .db AD
    .db 7B
    .db AD
    .db AB
    .db AD
    .db DB
    .db AD
    .db 0B
    .db AE
    .db 3B
    .db AE
    .db 6B
    .db AE
    .db 9B
    .db AE
    .db FD
    .db 96
    .db 2D
    .db 97
    .db 5D
    .db 97
    .db 8D
    .db 97
    .db BD
    .db 97
    .db ED
    .db 97
    .db 1D
    .db 98
    .db 4D
    .db 98
    .db 7D
    .db 98
    .db AD
    .db 98
    .db DD
    .db 98
    .db 0D
    .db 99
    .db 3D
    .db 99
    .db 6D
    .db 99
    .db 9D
    .db 99
    .db CD
    .db 99
    .db FD
    .db 99
    .db 2D
    .db 9A
    .db 5D
    .db 9A
    .db 8D
    .db 9A
    .db BD
    .db 9A
    .db E2
    .db B9
    .db 12
    .db BA
    .db 42
    .db BA
    .db 72
    .db BA
    .db A2
    .db BA
    .db D2
    .db BA
    .db 02
    .db BB
    .db 32
    .db BB
    .db 62
    .db BB
    .db 92
    .db BB
    .db C2
    .db BB
    .db F2
    .db BB
    .db 22
    .db BC
    .db 52
    .db BC
    .db 82
    .db BC
    .db B2
    .db BC
    .db E2
    .db BC
    .db 12
    .db BD
    .db FB
    .db 91
    .db 2B
    .db 92
    .db 5B
    .db 92
    .db 8B
    .db 92
    .db BB
    .db 92
    .db EB
    .db 92
    .db 1B
    .db 93
    .db 4B
    .db 93
    .db 7B
    .db 93
    .db 03
    .db A2
    .db 33
    .db A2
    .db 63
    .db A2
    .db 93
    .db A2
    .db C3
    .db A2
    .db F3
    .db A2
    .db 23
    .db A3
    .db 53
    .db A3
    .db 83
    .db A3
    .db B3
    .db A3
    .db E3
    .db A3
    .db 13
    .db A4
    .db 43
    .db A4
    .db F0
    .db AF
    .db 20
    .db B0
    .db 50
    .db B0
    .db 80
    .db B0
    .db B0
    .db B0
    .db E0
    .db B0
    .db 10
    .db B1
    .db 40
    .db B1
    .db 70
    .db B1
    .db A0
    .db B1
    .db D0
    .db B1
    .db 00
    .db B2
    .db 30
    .db B2
    .db 60
    .db B2
    .db 90
    .db B2
    .db C0
    .db B2
    .db F0
    .db B2
    .db 20
    .db B3
    .db 50
    .db B3
    .db 80
    .db B3
    .db B0
    .db B3
    .db E0
    .db B3
DATA_UNK: ; 1F:0EB0, 0x03EEB0
    .db 00
    .db 00
    .db 01
    .db 00
    .db 05
    .db 00
    .db 02
    .db 02
    .db 03
    .db 05
    .db 04
    .db 04
DATA_UNK_A: ; 1F:0EBC, 0x03EEBC
    .db BD
DATA_UNK_B: ; 1F:0EBD, 0x03EEBD
    .db 86
DATA_UNK_C: ; 1F:0EBE, 0x03EEBE
    .db D4
DATA_UNK_D: ; 1F:0EBF, 0x03EEBF
    .db 85
    .db EB
    .db 9B
    .db ED
    .db 9A
    .db 72
    .db AF
    .db CB
    .db AE
    .db 8B
    .db 86
    .db D4
    .db 85
    .db 83
    .db 94
    .db AB
    .db 93
    .db 20
    .db A5
    .db 73
    .db A4
    .db 85
    .db 00
    .db 8A
    .db 48
    .db 98
    .db 48
    .db A5
    .db 00
    .db 30
    .db 04
    .db A9
    .db 24
    .db D0
    .db 02
    .db A9
    .db 30
    .db 20
    .db 07
    .db DB
    .db 20
    .db 00
    .db EF
    .db 20
    .db 0F
    .db DB
    .db 68
    .db A8
    .db 68
    .db AA
    .db 60
    .db 85
    .db 00
    .db 8A
    .db 48
    .db 98
    .db 48
    .db 20
    .db 00
    .db EF
    .db 68
    .db A8
    .db 68
    .db AA
    .db 60
    .db A5
    .db 00
    .db 48
    .db AC
    .db 0A
    .db 06
    .db F0
    .db 05
    .db CD
    .db 0A
    .db 06
    .db D0
    .db 0C
    .db A5
    .db 78
    .db F0
    .db 0E
    .db A5
    .db 87
    .db D0
    .db 04
    .db A9
    .db FF
    .db 85
    .db 87
    .db 68
    .db A9
    .db FF
    .db 85
    .db 00
    .db 60
    .db A5
    .db 87
    .db C9
    .db FF
    .db D0
    .db 04
    .db A9
    .db 00
    .db 85
    .db 87
    .db 68
    .db 8D
    .db 0A
    .db 06
    .db 20
    .db 35
    .db EF
    .db A9
    .db 00
    .db 85
    .db 00
    .db 60
    .db 20
    .db 98
    .db CC
    .db 52
    .db 89
    .db 60
    .db 89
    .db 96
    .db 89
    .db 9C
    .db 89
    .db A2
    .db 89
    .db A8
    .db 89
    .db C0
    .db 89
    .db CD
    .db 89
    .db E5
    .db 89
    .db ED
    .db 89
    .db ED
    .db 89
    .db ED
    .db 89
    .db FF
    .db 89
    .db FF
    .db 89
    .db FF
    .db 89
    .db FF
    .db 89
    .db FF
    .db 89
    .db 0B
    .db 8A
    .db 2F
    .db 8A
    .db 36
    .db 8A
    .db 2F
    .db 8A
    .db 36
    .db 8A
    .db 57
    .db 8A
    .db 83
    .db 8A
    .db 83
    .db 8A
    .db 83
    .db 8A
    .db 83
    .db 8A
    .db 83
    .db 8A
    .db AE
    .db 8A
    .db AE
    .db 8A
    .db BD
    .db 8A
    .db 0B
    .db 8B
    .db 0B
    .db 8B
    .db 17
    .db 8B
    .db 17
    .db 8B
    .db 17
    .db 8B
    .db 17
    .db 8B
    .db 2F
    .db 8B
    .db 34
    .db 8B
    .db 54
    .db 8B
    .db 7C
    .db 8B
    .db 89
    .db 8B
    .db F2
    .db 8B
    .db F2
    .db 8B
    .db F2
    .db 8B
    .db FE
    .db 8B
    .db 02
    .db 8C
    .db 22
    .db 8C
    .db 22
    .db 8C
    .db 22
    .db 8C
    .db 2E
    .db 8C
    .db 2E
    .db 8C
    .db 2E
    .db 8C
    .db 4E
    .db 8C
    .db 64
    .db 8C
    .db 6C
    .db 8C
    .db 6C
    .db 8C
    .db 6C
    .db 8C
    .db 6C
    .db 8C
    .db 80
    .db 8C
    .db 88
    .db 8C
    .db A5
    .db 8C
    .db A9
    .db 8C
    .db B6
    .db 8C
    .db D2
    .db 8C
    .db 4B
    .db 87
    .db 8D
    .db 87
    .db 8D
    .db 87
    .db 8D
    .db 87
    .db 8D
    .db 87
    .db 8D
    .db 87
    .db 8D
    .db 87
    .db 2C
    .db 88
    .db 3B
    .db 8D
    .db DD
    .db 8D
    .db E5
    .db 8D
    .db E9
    .db 8D
    .db FC
    .db 8D
    .db 1C
    .db 8E
    .db 18
    .db 8E
    .db 38
    .db 8E
    .db 49
    .db 8E
    .db 4D
    .db 8E
    .db 6D
    .db 8E
    .db 6D
    .db 8E
    .db 6D
    .db 8E
    .db 6D
    .db 8E
    .db 9F
    .db 8E
    .db 9F
    .db 8E
    .db 9F
    .db 8E
    .db 9F
    .db 8E
    .db 9F
    .db 8E
    .db 9F
    .db 8E
    .db C7
    .db 8E
    .db EA
    .db 8E
    .db F2
    .db 8E
    .db FA
    .db 8E
    .db F0
    .db 8C
WAIT_UPDATES_AND_???: ; 1F:0FFC, 0x03EFFC
    LDA PLAYER?_UNK[2] ; Load P1 unk.
    ORA PPU_UPDATE_BUF_INDEX ; Combine with BG updates.
    BEQ GAME_STATE_SETTLED ; If neither active/set, do.
    RTS ; Leave, not settled.
GAME_STATE_SETTLED: ; 1F:1003, 0x03F003
    LDX #$00 ; P1 object.
LOOP_PLAYER_OBJS: ; 1F:1005, 0x03F005
    LDA 694_OBJ/PLAYER_UNK?[4],X ; Load
    BNE P1_SET ; != 0, goto.
    JMP NEXT_OBJ
P1_SET: ; 1F:100D, 0x03F00D
    BMI P1_NEG ; If negative, goto.
    LDA #$24
    JSR BANK_PAIR_USE_A ; Bank 4/5
    LDA 694_OBJ/PLAYER_UNK?[4],X ; Load
    CMP #$09 ; If _ #$09
    BEQ VAL_EQ_9/A ; ==, goto.
    CMP #$0A ; If _ #$0A
    BNE VAL_NE_9/A ; !=, goto.
VAL_EQ_9/A: ; 1F:101F, 0x03F01F
    LDA PLAYER_UNK_698[4],X ; Load
    CMP #$10 ; If _ #$10
    BNE VAL_NE_9/A ; !=, goto.
    LDA #$4A
    JSR SND_BANKED_DISPATCH ; Play sound.
VAL_NE_9/A: ; 1F:102B, 0x03F02B
    LDA 694_OBJ/PLAYER_UNK?[4],X ; Load
    AND #$3F ; Isolate 0011.1111
    TAY ; A -= 1, but fancy.
    DEY
    TYA
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA DATA_PLAYER_PTR_UNK_L,Y
    STA TMP_02
    LDA DATA_PLAYER_PTR_UNK_H,Y
    STA TMP_03
    JMP PLAYER_DATA_PTR_SETUP ; Skip other code.
P1_NEG: ; 1F:1042, 0x03F042
    LDA #$30
    JSR BANK_PAIR_USE_A ; Bank in bank 10/11.
    LDA 694_OBJ/PLAYER_UNK?[4],X ; Load val.
    AND #$7F ; Isolate 0111.1111
    TAY ; A -= 1, but fancy.
    DEY
    TYA
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA DATA_PLAYER_PTR_UNK_L_ALT,Y ; Set up ptr.
    STA TMP_02
    LDA DATA_PLAYER_PTR_UNK_H_ALT,Y
    STA TMP_03
PLAYER_DATA_PTR_SETUP: ; 1F:105B, 0x03F05B
    LDY #$00 ; Reset stream index.
    LDA NAMETABLE_FOCUS_VAL[2] ; Load
    CMP [TMP_02],Y ; If _ Stream
    INY ; Stream++
    BCC STREAM_LESS ; <, goto.
    LDA B1_SCROLL_X_COPY_IRQ_ZP[2] ; Load
    CMP [TMP_02],Y ; If _ Stream
    BCS OBJECT_CLEAR_UNK_AND_NEXT_OBJ ; >=, goto.
STREAM_LESS: ; 1F:106A, 0x03F06A
    LDA PLAYER_UNK_69C[4],X ; Load
    BEQ P_VAL_ZERO ; No value, goto.
    DEC PLAYER_UNK_69C[4],X ; --
    BNE NEXT_OBJ ; Next object.
P_VAL_ZERO: ; 1F:1074, 0x03F074
    INY ; Stream++
    LDA [TMP_02],Y ; Load val.
    STA PLAYER_UNK_69C[4],X ; Store to player.
    LDA PLAYER_UNK_698[4],X ; Load other val.
    CLC
    ADC #$03 ; += 3
    TAY ; To Y index.
    LDA [TMP_02],Y ; Load from stream set val.
    CMP #$FF ; If _ #$FF
    BEQ OBJECT_CLEAR_UNK_AND_NEXT_OBJ ; ==, goto. Clear more.
    CMP #$FE ; If _ #$FE
    BEQ OBJECT_LIMITED_CLEAR_AND_NEXT_OBJ ; ==, goto. Clear less.
    TXA ; Save X.
    PHA
    LDA 694_OBJ/PLAYER_UNK?[4],X ; Load val.
    BPL VAL_POSITIVE
    LDA [TMP_02],Y ; Load from stream.
    JSR RTN_UNK_A ; Do sub from bank 10.
    JMP RESTORE_SAVED_INC_PLAYER_VAR
VAL_POSITIVE: ; 1F:109A, 0x03F09A
    LDA 694_OBJ/PLAYER_UNK?[4],X ; Load val from player.
    AND #$40 ; Test 0100.0000
    BEQ BIT_NOT_SET ; Not set, goto.
    LDA [TMP_02],Y ; Load from stream.
    JSR RTN_UNK_B ; Do sub other bank.
    JMP RESTORE_SAVED_INC_PLAYER_VAR
BIT_NOT_SET: ; 1F:10A9, 0x03F0A9
    LDA [TMP_02],Y ; Load val from stream.
    JSR RTN_UNK_B_PAIR
RESTORE_SAVED_INC_PLAYER_VAR: ; 1F:10AE, 0x03F0AE
    PLA ; Pull saved val.
    TAX ; To X.
    INC PLAYER_UNK_698[4],X ; ++ val.
NEXT_OBJ: ; 1F:10B3, 0x03F0B3
    INX ; Obj++
    CPX #$04 ; If Obj _ #$04
    BCS RTS ; >=, goto.
    JMP LOOP_PLAYER_OBJS ; Loop all.
RTS: ; 1F:10BB, 0x03F0BB
    RTS
OBJECT_CLEAR_UNK_AND_NEXT_OBJ: ; 1F:10BC, 0x03F0BC
    LDA #$00
    STA 694_OBJ/PLAYER_UNK?[4],X ; Clear
OBJECT_LIMITED_CLEAR_AND_NEXT_OBJ: ; 1F:10C1, 0x03F0C1
    LDA #$00
    STA PLAYER_UNK_698[4],X ; Clear
    STA PLAYER_UNK_69C[4],X
    BEQ NEXT_OBJ ; Next object, always taken.
OBJECTS_PROCESS_0x04-0x11_UNK: ; 1F:10CB, 0x03F0CB
    LDX #$04 ; Obj start.
LOOP_ALL_OBJS: ; 1F:10CD, 0x03F0CD
    LDA ARR_OBJECT_ENABLED+MORE?[18],X ; Test enabled.
    BEQ NEXT_OBJ ; If no value set, skip all.
    BMI 1F:10FA ; If negative, goto.
    CMP #$30
    BCC 1F:10EC
    CMP #$36
    BCC 1F:1102
    CMP #$3B
    BCC 1F:1106
    CMP #$50
    BCC 1F:10FE
    CMP #$6D
    BCS 1F:10FE
    LDA #$2C
    BNE 1F:10EE
    LDA #$2A
    JSR BANK_PAIR_USE_A ; Bank A/B
    JSR 1F:110A
NEXT_OBJ: ; 1F:10F4, 0x03F0F4
    INX ; Obj++
    CPX #$12 ; If _ #$12
    BCC LOOP_ALL_OBJS ; <, goto.
    RTS ; Leave.
    LDA #$20
    BNE 1F:10EE
    LDA #$36
    BNE 1F:10EE
    LDA #$22
    BNE 1F:10EE
    LDA #$28
    BNE 1F:10EE
    LDA ARR_OBJECT_ENABLED+MORE?[18],X
    ASL A
    TAY
    BCC 1F:111C
    LDA 1F:1229,Y
    STA TMP_00
    LDA 1F:122A,Y
    JMP 1F:1124
    LDA CODE_PTR_L,Y
    STA TMP_00
    LDA CODE_PTR_H,Y
    STA TMP_01
    JMP [TMP_00]
CODE_PTR_L: ; 1F:1129, 0x03F129
    .db F9
CODE_PTR_H: ; 1F:112A, 0x03F12A
    .db F0
    .db BD
    .db 83
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db 6B
    .db 84
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db C6
    .db A5
    .db 3A
    .db 80
    .db F2
    .db 82
    .db 17
    .db 83
    .db 41
    .db 83
    .db 3A
    .db 80
    .db 3A
    .db 80
    .db 3A
    .db 80
    .db 3A
    .db 80
    .db 3A
    .db 80
    .db 3A
    .db 80
    .db 3A
    .db 80
    .db 3A
    .db 80
    .db 3A
    .db 80
    .db B7
    .db AA
    .db 76
    .db F3
    .db EF
    .db A9
    .db A3
    .db AA
    .db 25
    .db B3
    .db 38
    .db AA
    .db B0
    .db B5
    .db 07
    .db BB
    .db 2B
    .db BB
    .db D5
    .db BB
    .db A2
    .db BA
    .db B4
    .db AD
    .db E2
    .db B2
    .db FF
    .db B2
    .db 41
    .db B3
    .db 18
    .db BA
    .db 5C
    .db BA
    .db A3
    .db AA
    .db A3
    .db AA
    .db A3
    .db AA
    .db A3
    .db AA
    .db A3
    .db AA
    .db A3
    .db AA
    .db A3
    .db AA
    .db A3
    .db AA
    .db ED
    .db 93
    .db C7
    .db 93
    .db D5
    .db 98
    .db BA
    .db 98
    .db 3F
    .db 8C
    .db 90
    .db 8F
    .db B2
    .db 8F
    .db 01
    .db 80
    .db 15
    .db 83
    .db F3
    .db 8A
    .db E0
    .db 8B
    .db 79
    .db 91
    .db 22
    .db 92
    .db 50
    .db 92
    .db 0F
    .db 98
    .db 9F
    .db 9B
    .db 92
    .db 9C
    .db 7C
    .db A1
    .db 07
    .db A2
    .db 44
    .db A0
    .db F0
    .db 91
    .db 68
    .db A8
    .db 43
    .db AB
    .db DD
    .db B1
    .db F6
    .db B0
    .db 29
    .db B2
    .db 3F
    .db B5
    .db 1F
    .db B6
    .db 3E
    .db B6
    .db 3E
    .db B6
    .db 98
    .db B6
    .db E4
    .db BA
    .db 88
    .db BC
    .db 8E
    .db B6
    .db 8F
    .db B6
    .db 8E
    .db B6
    .db 03
    .db 80
    .db 01
    .db 80
    .db A4
    .db 8B
    .db 13
    .db 9B
    .db 89
    .db 9E
    .db 66
    .db 9E
    .db E1
    .db A3
    .db 92
    .db A4
    .db 0B
    .db A5
    .db 2E
    .db AB
    .db 23
    .db AC
    .db 98
    .db AC
    .db 03
    .db 80
    .db 03
    .db 80
    .db 03
    .db 80
    .db 03
    .db 80
    .db 03
    .db 80
    .db 03
    .db 80
    .db 03
    .db 80
    .db 01
    .db 80
    .db 67
    .db 81
    .db 51
    .db 81
    .db 80
    .db 87
    .db 2F
    .db 81
    .db 8C
    .db 80
    .db 6D
    .db 88
    .db B6
    .db 89
    .db 9F
    .db 8A
    .db DE
    .db 8A
    .db 75
    .db 8C
    .db CF
    .db 97
    .db 9F
    .db 95
    .db E7
    .db 8C
    .db A0
    .db 89
    .db 05
    .db 8D
    .db 25
    .db 8D
    .db 25
    .db 8D
    .db 13
    .db 98
    .db 94
    .db 8D
    .db 6F
    .db 8D
    .db 2F
    .db 9A
    .db 0F
    .db 96
    .db 9C
    .db 97
    .db B2
    .db F6
    .db 0B
    .db 8E
    .db 66
    .db 8E
    .db C0
    .db 8E
    .db 5A
    .db 8F
    .db 20
    .db 90
    .db 93
    .db 8A
    .db 16
    .db 92
    .db 33
    .db 93
    .db 04
    .db 94
    .db 70
    .db 90
    .db 6A
    .db 91
    .db E8
    .db 91
    .db 05
    .db 92
    .db FA
    .db 8D
    .db 6C
    .db 82
    .db 78
    .db 89
    .db 04
    .db 94
    .db 04
    .db 94
    .db 04
    .db 94
    .db 04
    .db 94
    .db 04
    .db 94
    .db 04
    .db 94
    .db F3
    .db F2
    .db 97
    .db 82
    .db 26
    .db 83
    .db 66
    .db 87
    .db F5
    .db 84
    .db CB
    .db 85
    .db 4F
    .db 84
    .db 9A
    .db 85
    .db 27
    .db 86
    .db 07
    .db 86
    .db 1B
    .db 87
    .db 9D
    .db 8C
    .db 62
    .db 88
    .db DC
    .db 83
    .db 97
    .db 94
    .db 4A
    .db 95
    .db 4A
    .db 95
    .db 43
    .db 8D
LEVEL_8_PLAYERS_NOT_ENABLED: ; 1F:12AB, 0x03F2AB
    LDA DC_UNK ; Load
    BNE DC_SET ; If set, goto.
    JSR INIT_LEVEL_AND_OBJ[7]_STUFF ; Do rtn.
    INC DC_UNK ; Set.
    RTS ; Leave.
DC_SET: ; 1F:12B5, 0x03F2B5
    JSR OBJECTS_PROCESS_0x04-0x11_UNK ; Do..
    JSR SUB_CHECK_OBJS-0x7-0x11_RET_CS_FINISHED ; Check to see if stil in use.
    BCC RTS ; Not finished, RTS.
    LDA #$4A
    JSR LEVEL_RELATED_DATA_A_PASSED? ; Level data.
    LDA #$00
    STA DC_UNK ; Clear.
    INC 4B_SWITCH_GAME_OVER/FINISHED ; ++
RTS: ; 1F:12C8, 0x03F2C8
    RTS
INIT_LEVEL_AND_OBJ[7]_STUFF: ; 1F:12C9, 0x03F2C9
    LDA #$00
    STA DISABLE_RENDERING_X_FRAMES ; Enable rendering.
    LDA #$69
    STA ZP_R2-R5_BANK_VALUES+2 ; GFX, R4.
    LDA #$E7
    STA ZP_R2-R5_BANK_VALUES+3 ; GFX, R5.
    LDA #$49
    JSR LEVEL_RELATED_DATA_A_PASSED? ; Level data?
    LDA #$E8
    STA OBJ_POS_X+7 ; Set unk.
    LDA #$D0
    STA 4A2_OBJ_UNK_POS?+7 ; Set unk.
    LDA #$40
    STA ARR_OBJECT_ENABLED+MORE?+7 ; Set obj 7 state.
    LDA #$02
    STA 556_ARR_UNK+7 ; Set obj 7 unk.
    LDA #$70
    JMP SND_BANKED_DISPATCH ; Sound. Abuse RTS.
    JMP INIT_OBJECT[X]_DATA? ; Mistake? TODO: See if gets to anyhow.
RTN_ALL_OBJS_DISABLED?_UNK: ; 1F:12F6, 0x03F2F6
    LDA 5F8_UNK ; Load
    BMI 5F8_IS_NEG ; If negative.
    LDA 70C_UNK ; Load
    BEQ RTS ; Not set, goto.
    JSR TEST_OBJ[7-19]_DISABLED/!8B_RET_CS_TRUE ; Enabled?
    BCC RTS ; Not all finished, RTS.
5F8_IS_NEG: ; 1F:1305, 0x03F305
    DEC 5FB_TIMER_ALL_FINISHED? ; --
    BNE RTS ; != 0, leave.
    LDA #$00
    STA 70C_UNK ; Clear these.
    STA 5F8_UNK
    LDA #$04 ; Switch to cutscene?
    STA 3C_SWITCH_CORE
RTS: ; 1F:1316, 0x03F316
    RTS
    LDX #$07
L_1F:1319: ; 1F:1319, 0x03F319
    LDA ARR_OBJECT_ENABLED+MORE?[18],X
    BEQ L_1F:1325
L_1F:131E: ; 1F:131E, 0x03F31E
    INX
    INX
    CPX #$11
    BCC L_1F:1319
    RTS
L_1F:1325: ; 1F:1325, 0x03F325
    LDA ARR_OBJECT_ENABLED+MORE?+1,X
    BNE L_1F:131E
    CLC
    RTS
    LDA #$11
    STA BCD_VAL_XY+1
    LDY #$07
L_1F:1332: ; 1F:1332, 0x03F332
    LDA ARR_OBJECT_ENABLED+MORE?[18],Y
    BEQ L_1F:133E
L_1F:1337: ; 1F:1337, 0x03F337
    INY
    INY
    CPY BCD_VAL_XY+1
    BCC L_1F:1332
    RTS
L_1F:133E: ; 1F:133E, 0x03F33E
    LDA ARR_OBJECT_ENABLED+MORE?+1,Y
    BNE L_1F:1337
    CLC
    RTS
    LDY #$07
L_1F:1347: ; 1F:1347, 0x03F347
    LDA ARR_OBJECT_ENABLED+MORE?[18],Y
    BEQ L_1F:1353
    INY
    INY
    CPY #$11
    BCC L_1F:1347
    RTS
L_1F:1353: ; 1F:1353, 0x03F353
    CLC
    RTS
SUB_CHECK_OBJS-0x7-0x11_RET_CS_FINISHED: ; 1F:1355, 0x03F355
    TXA ; Save X
    PHA
    TYA ; Save Y.
    PHA
    STX TMP_08 ; X to.
    LDY #$07 ; Y=
LOOP_MORE_OBJS: ; 1F:135D, 0x03F35D
    CPY TMP_08 ; If Y _ Var
    BEQ Y_EQ_TMP8 ; ==, goto.
    LDA ARR_OBJECT_ENABLED+MORE?[18],Y ; Load object value.
    BNE OBJ_NONZERO. ; If set..
Y_EQ_TMP8: ; 1F:1366, 0x03F366
    INY ; Obj++
    CPY #$11 ; If Y _ #$11
    BCC LOOP_MORE_OBJS ; <, goto.
    PLA
    TAY ; Restore Y.
    PLA
    TAX ; Restore X.
    RTS
OBJ_NONZERO.: ; 1F:1370, 0x03F370
    CLC ; Return CC clear, not finished.
    PLA
    TAY ; Restore Y
    PLA
    TAX ; Restore X.
    RTS ; Leave.
    JSR L_1F:13F1
    JMP L_1F:13CB
    LDA 58C_ARR_UNK[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    .db 8E
    .db F3
    .db A0
    .db F3
    .db A0
    .db F3
    .db A0
    .db F3
    .db A0
    .db F3
    .db D1
    .db F4
    .db 20
    .db 46
    .db F5
    .db 20
    .db 4F
    .db F5
    .db 20
    .db 58
    .db F5
    .db A9
    .db 10
    .db 9D
    .db 9E
    .db 05
    .db FE
    .db 8C
    .db 05
    .db 60
    .db DE
    .db 9E
    .db 05
    .db D0
    .db 23
    .db BC
    .db 8C
    .db 05
    .db 88
    .db D0
    .db 05
    .db A9
    .db 2A
    .db 20
    .db 52
    .db DB
    .db BD
    .db 8C
    .db 05
    .db 38
    .db E9
    .db 01
    .db 18
    .db 69
    .db 01
    .db C9
    .db 04
    .db F0
    .db 08
    .db 9D
    .db 00
    .db 04
    .db A9
    .db 08
    .db 9D
    .db 9E
    .db 05
    .db FE
    .db 8C
    .db 05
    .db 4C
    .db F1
    .db F3
L_1F:13CB: ; 1F:13CB, 0x03F3CB
    .db BD
    .db 6C
    .db 04
    .db C9
    .db 30
    .db 90
    .db 1C
    .db BD
    .db 56
    .db 05
    .db 29
    .db 03
    .db F0
    .db 14
    .db 29
    .db 02
    .db D0
    .db 09
    .db BD
    .db 7E
    .db 04
    .db C9
    .db 30
    .db 90
    .db 09
    .db B0
    .db 08
    .db BD
    .db 7E
    .db 04
    .db C9
    .db D0
    .db 90
    .db 01
    .db 60
    .db 4C
    .db D1
    .db F4
L_1F:13F1: ; 1F:13F1, 0x03F3F1
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 9D
    .db 36
    .db 04
    .db BD
    .db 56
    .db 05
    .db 29
    .db 04
    .db F0
    .db 08
    .db BD
    .db 36
    .db 04
    .db 09
    .db 40
    .db 9D
    .db 36
    .db 04
    .db 38
    .db BD
    .db 20
    .db 05
    .db E5
    .db 83
    .db 85
    .db 02
    .db BD
    .db 0E
    .db 05
    .db E5
    .db 84
    .db 85
    .db 03
    .db 38
    .db BD
    .db FC
    .db 04
    .db E5
    .db B7
    .db 85
    .db 00
    .db BD
    .db EA
    .db 04
    .db E5
    .db BA
    .db 85
    .db 01
    .db BD
    .db 7E
    .db 04
    .db 85
    .db 08
    .db 20
    .db 94
    .db F4
    .db A5
    .db 01
    .db 10
    .db 1B
    .db A5
    .db 08
    .db DD
    .db 7E
    .db 04
    .db B0
    .db 37
    .db BD
    .db 56
    .db 05
    .db 29
    .db 03
    .db F0
    .db 04
    .db 29
    .db 01
    .db D0
    .db 1B
    .db BD
    .db 56
    .db 05
    .db 09
    .db 02
    .db 9D
    .db 56
    .db 05
    .db 60
    .db BD
    .db 7E
    .db 04
    .db C5
    .db 08
    .db B0
    .db 1C
    .db BD
    .db 56
    .db 05
    .db 29
    .db 03
    .db F0
    .db 0D
    .db 29
    .db 02
    .db F0
    .db 09
    .db BD
    .db 56
    .db 05
    .db 29
    .db FC
    .db 9D
    .db 56
    .db 05
    .db 60
    .db BD
    .db 56
    .db 05
    .db 09
    .db 01
    .db 9D
    .db 56
    .db 05
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 56
    .db 05
    .db 38
    .db BD
    .db FC
    .db 04
    .db E5
    .db B7
    .db 85
    .db 00
    .db BD
    .db EA
    .db 04
    .db E5
    .db BA
    .db 85
    .db 01
    .db 38
    .db BD
    .db 20
    .db 05
    .db E5
    .db 83
    .db 85
    .db 02
    .db BD
    .db 0E
    .db 05
    .db E5
    .db 84
    .db 85
    .db 03
    .db 18
    .db BD
    .db 90
    .db 04
    .db 65
    .db 00
    .db 9D
    .db 90
    .db 04
    .db BD
    .db 7E
    .db 04
    .db 65
    .db 01
    .db 9D
    .db 7E
    .db 04
    .db 18
    .db BD
    .db B4
    .db 04
    .db 65
    .db 02
    .db 9D
    .db B4
    .db 04
    .db BD
    .db A2
    .db 04
    .db 65
    .db 03
    .db 9D
    .db A2
    .db 04
    .db 18
    .db BD
    .db B4
    .db 04
    .db 7D
    .db D8
    .db 04
    .db BD
    .db A2
    .db 04
    .db 7D
    .db C6
    .db 04
    .db 9D
    .db 6C
    .db 04
    .db 60
    .db BD
    .db 56
    .db 05
    .db 29
    .db 02
    .db F0
    .db F8
    .db 4C
    .db D1
    .db F4
INIT_OBJECT[X]_DATA?: ; 1F:14D1, 0x03F4D1
    LDA #$00
    STA 556_ARR_UNK[18],X
    STA OBJ_POS_X[18],X
    STA 4A2_OBJ_UNK_POS?[18],X
    STA 4C6_OBJ_UNK_POS?[18],X
    STA OBJ_POS_Y[18],X
    STA OBJ_ANIMATION_FRAME_TO[18],X
    STA ARR_OBJECT_ENABLED+MORE?[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?[18],X
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    STA OBJ_STATE/SWITCH[18],X
    STA 490_OBJ_UNK_SPEED?[18],X
    STA 4B4_OBJ_SPEED?[18],X
    STA 4D8_ARR_UNK[18],X
    STA 4FC_ARR_UNK[18],X
    STA 4EA_ARR_UNK[18],X
    STA 520_ARR_UNK[18],X
    STA 50E_ARR_UNK[18],X
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    STA OBJ_DIRECTION_RELATED?[18],X
    STA OBJECT_DATA_EXTRA_A?[18],X
    STA OBJECT_DATA_EXTRA_B?[18],X
    STA 58C_ARR_UNK[18],X
    STA 59E_OBJ_UNK_TIMER?[18],X
    STA 5B0_ARR_UNK[18],X
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    STA 5D4_ARR_OBJ_TIMER?[18],X
    RTS
TEST_OBJ[7-19]_DISABLED/!8B_RET_CS_TRUE: ; 1F:1527, 0x03F527
    TXA ; Save X.
    PHA
    TYA ; Save Y.
    PHA
    LDY #$07 ; Objject.
LOOP_CHECK_ALL_OBJS: ; 1F:152D, 0x03F52D
    LDA ARR_OBJECT_ENABLED+MORE?[18],Y
    BNE OBJ_VAL_NONZERO ; Set to something, goto.
RE-ENTER_CHECK_LOOP: ; 1F:1532, 0x03F532
    INY ; Next obj.
    CPY #$12 ; Do obj 7-18.
    BCC LOOP_CHECK_ALL_OBJS
    PLA
    TAY ; Restore Y.
    PLA
    TAX ; Restore X.
    RTS ; Carry set return, all disabled/finished.
OBJ_VAL_NONZERO: ; 1F:153C, 0x03F53C
    CMP #$8B ; If val _ #$8B
    BEQ RE-ENTER_CHECK_LOOP ; ==, goto. This counts as finished, not enabled?
    CLC ; Clear carry, ret flag.
    PLA
    TAY ; Restore Y.
    PLA
    TAX ; Restore X.
    RTS ; Ret carry cleared, not all finished/done.
    LDA #$00
    STA 4FC_ARR_UNK[18],X
    STA 4EA_ARR_UNK[18],X
    RTS
    LDA #$00
    STA 520_ARR_UNK[18],X
    STA 50E_ARR_UNK[18],X
    RTS
    LDA #$00
    STA 544_OBJ_UNK_POS?[18],X
    STA 532_OBJ_UNK_POS?[18],X
    RTS
    JSR 1F:1576
    SEC
    LDA #$00
    SBC 520_ARR_UNK[18],X
    STA 520_ARR_UNK[18],X
    LDA #$00
    SBC 50E_ARR_UNK[18],X
    STA 50E_ARR_UNK[18],X
    RTS
    SEC
    LDA #$00
    SBC 4FC_ARR_UNK[18],X
    STA 4FC_ARR_UNK[18],X
    LDA #$00
    SBC 4EA_ARR_UNK[18],X
    STA 4EA_ARR_UNK[18],X
    RTS
    STY TMP_00
    CLC
    ADC 4FC_ARR_UNK[18],X
    STA 4FC_ARR_UNK[18],X
    LDA 4EA_ARR_UNK[18],X
    ADC TMP_00
    STA 4EA_ARR_UNK[18],X
    RTS
    STY TMP_00
    CLC
    ADC 520_ARR_UNK[18],X
    STA 520_ARR_UNK[18],X
    LDA 50E_ARR_UNK[18],X
    ADC TMP_00
    STA 50E_ARR_UNK[18],X
    RTS
    STY TMP_00
    CLC
    ADC 544_OBJ_UNK_POS?[18],X
    STA 544_OBJ_UNK_POS?[18],X
    LDA 532_OBJ_UNK_POS?[18],X
    ADC TMP_00
    STA 532_OBJ_UNK_POS?[18],X
    RTS
    CLC
    LDA 4D8_ARR_UNK[18],X
    ADC 544_OBJ_UNK_POS?[18],X
    STA 4D8_ARR_UNK[18],X
    LDA 4C6_OBJ_UNK_POS?[18],X
    ADC 532_OBJ_UNK_POS?[18],X
    STA 4C6_OBJ_UNK_POS?[18],X
    RTS
    LDA #$00
    STA 58C_ARR_UNK[18],X
    STA 59E_OBJ_UNK_TIMER?[18],X
    LDA #$02
    STA OBJ_STATE/SWITCH[18],X
    RTS
    LDA #$00
    STA TMP_10
    LDA 4A2_OBJ_UNK_POS?[18],Y
    SEC
    SBC 4A2_OBJ_UNK_POS?[18],X
    BCS 1F:15F4
    INC TMP_10
    EOR #$FF
    CLC
    ADC #$01
    RTS
    LDA #$00
    STA ZP_12_UNK
    LDA OBJ_POS_X[18],Y
    SEC
    SBC OBJ_POS_X[18],X
    BCS 1F:1609
    INC ZP_12_UNK
    EOR #$FF
    CLC
    ADC #$01
    RTS
    LDA 556_ARR_UNK[18],X
    AND #$FB
    STA 556_ARR_UNK[18],X
    JSR 1F:15F5
    LDA ZP_12_UNK
    BNE 1F:1621
    LDA 556_ARR_UNK[18],X
    ORA #$04
    STA 556_ARR_UNK[18],X
    RTS
    LDA 47_TWO_PLAYERS_FLAG
    BEQ 1F:163D
    LDA OBJ_ANIMATION_FRAME_TO[18]
    BEQ 1F:1639
    LDA OBJ_ANIMATION_FRAME_TO+2
    BEQ 1F:163D
    TXA
    LSR A
    CLC
    ADC INF_LOOP_COUNTER_UNK
    AND #$01
    BEQ 1F:163D
    LDA #$02
    BNE 1F:163F
    LDA #$00
    STA 5B0_ARR_UNK[18],X
    RTS
    LDA 556_ARR_UNK[18],X
    AND #$FB
    STA 556_ARR_UNK[18],X
    RTS
    LDA 556_ARR_UNK[18],X
    ORA #$04
    STA 556_ARR_UNK[18],X
    RTS
    TXA
    PHA
    TYA
    JSR 1E:1455
    PLA
    TAX
    RTS
    LDA #$30
    STA ARR_OBJECT_ENABLED+MORE?+1,X
    LDA OBJ_POS_X[18],X
    STA OBJ_POS_X+1,X
    LDA 4A2_OBJ_UNK_POS?[18],X
    STA 4A2_OBJ_UNK_POS?+1,X
    STA OBJ_POS_Y+1,X
    RTS
    LDA #$22
    JSR BANK_PAIR_USE_A
    JSR $B3C3
    LDA #$2C
    JMP BANK_PAIR_USE_A
    PHA
    LDA #$2A
    JSR BANK_PAIR_USE_A
    PLA
    JSR $87A0
    LDA #$20
    JMP BANK_PAIR_USE_A
    LDX #$07
    LDA ARR_OBJECT_ENABLED+MORE?[18],X
    BEQ 1F:169D
    INX
    CPX #$12
    BCC 1F:1691
    CLC
    RTS
    SEC
    RTS
    STA ARR_OBJECT_ENABLED+MORE?[18],X
    LDA #$01
    STA OBJ_ANIMATION_FRAME_TO[18],X
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
    JSR 1F:17BC
    BCS 1F:16CB
    DEC OBJ_ANIM_HOLD_TIMER?[18],X
    BPL 1F:16B1
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    INC OBJ_ANIMATION_FRAME_TO[18],X
    LDA OBJ_ANIMATION_FRAME_TO[18],X
    CMP #$04
    BCC 1F:16B1
    JMP INIT_OBJECT[X]_DATA?
    LDA 47_TWO_PLAYERS_FLAG
    BNE 1F:16D7
    LDA #$00
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDA 5D4_ARR_OBJ_TIMER?[18],X
    LSR A
    TAY
    LDA NUM_PLAYER_LIVES[2],Y
    BPL 1F:16F8
    LDA 47_TWO_PLAYERS_FLAG
    BEQ 1F:16F6
    TYA
    EOR #$01
    TAY
    LDA NUM_PLAYER_LIVES[2],Y
    BMI 1F:16F6
    TYA
    ASL A
    STA 5D4_ARR_OBJ_TIMER?[18],X
    JMP 1F:16F8
    SEC
    RTS
    CLC
    RTS
    LDA #$00
    BEQ 1F:1700
    LDA #$80
    STA TMP_01
    LDA 47_TWO_PLAYERS_FLAG
    BEQ 1F:1741
    LDA NUM_PLAYER_LIVES[2]
    ORA NUM_PLAYER_LIVES+1
    BMI 1F:1741
    SEC
    LDA OBJ_POS_X[18],X
    PHA
    SBC OBJ_POS_X[18]
    BCS 1F:171B
    EOR #$FF
    CLC
    ADC #$01
    STA TMP_00
    PLA
    SEC
    SBC OBJ_POS_X+2
    BCS 1F:1729
    EOR #$FF
    CLC
    ADC #$01
    CMP TMP_00
    LDA TMP_01
    BMI 1F:1738
    LDA #$00
    BCS 1F:1735
    LDA #$02
    JMP 1F:173E
    LDA #$00
    BCC 1F:173E
    LDA #$02
    STA 5D4_ARR_OBJ_TIMER?[18],X
    RTS
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    LDA OBJ_POS_X[18],Y
    STA R_**:$0014
    LDA 4A2_OBJ_UNK_POS?[18],Y
    STA R_**:$0015
    LDA OBJ_POS_X[18],X
    SEC
    SBC R_**:$0014
    STA ZP_12_UNK
    BCS 1F:175E
    EOR #$FF
    CLC
    ADC #$01
    STA TMP_10
    LDA 4A2_OBJ_UNK_POS?[18],X
    SEC
    SBC R_**:$0015
    STA ZP_13_UNK
    BCS 1F:176F
    EOR #$FF
    CLC
    ADC #$01
    STA ZP_11_UNK
    RTS
    LDA OBJ_POS_X[18],X
    LDY 5D4_ARR_OBJ_TIMER?[18],X
    CMP OBJ_POS_X[18],Y
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$03
    BCS 1F:1784
    ORA #$40
    STA OBJ_DIRECTION_RELATED?[18],X
    RTS
MOVE_FINALIZE?: ; 1F:1788, 0x03F788
    CLC ; Prep add.
    LDA 4C6_OBJ_UNK_POS?[18],X ; Load
    ADC 4A2_OBJ_UNK_POS?[18],X ; Add with.
    STA OBJ_POS_Y[18],X ; Store.
    RTS ; Leave.
    SEC
    LDA 490_OBJ_UNK_SPEED?[18],X
    SBC B7_UNK_SPRITES?
    STA 490_OBJ_UNK_SPEED?[18],X
    LDA OBJ_POS_X[18],X
    SBC BA_UNK_SPRITES?
    BCS 1F:17A5
    LDA #$00
    STA OBJ_POS_X[18],X
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BNE 1F:17BB
    CLC
    LDA OBJ_POS_X[18],X
    ADC #$04
    BCC 1F:17B8
    LDA #$00
    STA OBJ_POS_X[18],X
    RTS
    SEC
    LDA 490_OBJ_UNK_SPEED?[18],X
    SBC B7_UNK_SPRITES?
    STA 490_OBJ_UNK_SPEED?[18],X
    LDA OBJ_POS_X[18],X
    SBC BA_UNK_SPRITES?
    STA OBJ_POS_X[18],X
    BCC 1F:17E4
    LDA LEVEL_SCREEN_ON
    CMP #$07
    BNE 1F:17E2
    CLC
    LDA OBJ_POS_X[18],X
    ADC #$04
    BCC 1F:17DF
    LDA #$00
    STA OBJ_POS_X[18],X
    CLC
    RTS
    SEC
    RTS
    SEC
    LDA 4B4_OBJ_SPEED?[18],X
    SBC 83_UNK
    STA 4B4_OBJ_SPEED?[18],X
    LDA 4A2_OBJ_UNK_POS?[18],X
    SBC 84_UNK
    BCS 1F:17F8
    LDA #$00
    STA 4A2_OBJ_UNK_POS?[18],X
    RTS
    LDA 47_TWO_PLAYERS_FLAG
    BEQ 1F:183B
    LDA NUM_PLAYER_LIVES[2]
    ORA NUM_PLAYER_LIVES+1
    BPL 1F:1813
    LDY NUM_PLAYER_LIVES[2]
    BPL 1F:183B
    LDA #$02
    LDY NUM_PLAYER_LIVES+1
    BPL 1F:183D
    JMP 1F:183B
    LDY #$00
    LDA OBJ_POS_X[18],X
    SEC
    SBC OBJ_POS_X[18],Y
    BCS 1F:1823
    EOR #$FF
    CLC
    ADC #$01
    STA TMP_00
    LDY #$02
    LDA OBJ_POS_X[18],X
    SEC
    SBC OBJ_POS_X[18],Y
    BCS 1F:1835
    EOR #$FF
    CLC
    ADC #$01
    CMP TMP_00
    LDA #$02
    BCC 1F:183D
    LDA #$00
    STA 5D4_ARR_OBJ_TIMER?[18],X
    RTS
    LDA 47_TWO_PLAYERS_FLAG
    BEQ 1F:184C
    LDA ZP_0D_UNK
    LSR A
    LDY #$02
    BCS 1F:184E
    LDY #$00
    TYA
    STA 5D4_ARR_OBJ_TIMER?[18],X
    RTS
    LDA #$40
    BNE MOVE_RTN?
MOVE_RTN?: ; 1F:1857, 0x03F857
    CLC ; Prep add.
    ADC 544_OBJ_UNK_POS?[18],X ; Add
    STA 544_OBJ_UNK_POS?[18],X ; Store.
    BCC NO_OVERFLOW
    INC 532_OBJ_UNK_POS?[18],X ; Inc if overflow.
NO_OVERFLOW: ; 1F:1863, 0x03F863
    CLC ; Prep add.
    LDA 544_OBJ_UNK_POS?[18],X ; Load
    ADC 4D8_ARR_UNK[18],X ; Add
    STA 4D8_ARR_UNK[18],X ; Store.
    LDA 532_OBJ_UNK_POS?[18],X ; Load
    ADC 4C6_OBJ_UNK_POS?[18],X ; Add
    STA 4C6_OBJ_UNK_POS?[18],X ; Store.
    BPL CARRY_SET_RET ; If positive result...?
    CLC ; Carry cleared.
    RTS
CARRY_SET_RET: ; 1F:187A, 0x03F87A
    SEC ; Carry set.
    RTS
FUNKY_ADD/ROT_RTN: ; 1F:187C, 0x03F87C
    CLC ; Prep add.
    LDA 4FC_ARR_UNK[18],X ; Load
    ADC 490_OBJ_UNK_SPEED?[18],X ; Add with.
    STA 490_OBJ_UNK_SPEED?[18],X ; Store.
    LDA 4EA_ARR_UNK[18],X ; Load
    ADC OBJ_POS_X[18],X ; Add with.
    STA OBJ_POS_X[18],X ; Store to.
    ROR A ; Rotate A
    EOR 4EA_ARR_UNK[18],X ; Eor val.
    ASL A ; Shift A back.
    RTS ; RTS
    .db 18
    LDA 520_ARR_UNK[18],X
    ADC 4B4_OBJ_SPEED?[18],X
    STA 4B4_OBJ_SPEED?[18],X
    LDA 50E_ARR_UNK[18],X
    ADC 4A2_OBJ_UNK_POS?[18],X
    STA 4A2_OBJ_UNK_POS?[18],X
    ROR A
    EOR 50E_ARR_UNK[18],X
    ASL A
    RTS
    .db 02
    .db 03
    .db 04
    .db 05
    .db 01
    .db 00
    .db 09
    .db 0C
    .db 11
    .db 0A
    .db 0D
    .db 0E
    .db 0F
    .db 10
    .db 12
    .db 13
    .db 14
    .db 15
    .db 0B
    .db 17
    .db 18
    .db 17
    .db 1C
    .db 1B
    .db 1E
    .db 1E
    .db 25
    .db 26
    .db 27
    .db 29
    .db 29
    .db 29
    .db 2A
    .db 2B
    .db 2C
    .db 2D
    .db 2E
    .db 2F
    .db 30
    .db 31
    .db AE
    .db F8
    .db AE
    .db F8
    .db B4
    .db F8
    .db C1
    .db F8
    .db D6
    .db F8
    .db C6
    .db F8
    .db CB
    .db F8
    .db CB
    .db F8
    .db D1
    .db F8
    .db D6
    .db F8
    .db D1
    .db F8
    .db D1
    .db F8
DISABLE_MAPPER_IRQ+SOUND: ; 1F:18EE, 0x03F8EE
    LDA #$00
    STA MMC3_BANK_CFG ; MMC3 config.
    STA MMC3_IRQ_DISABLE ; Disable IRQ.
    LDA #$00
    STA APU_DMC_CTRL ; Silence audio.
    LDA #$40
    STA APU_FSEQUENCE ; 4 step, no IRQ's.
    LDA PPU_STATUS ; Reset PPU latch.
    LDA #$10 ; PPU_A12_HIGH
    TAX ; To times.
LOOP_PPU_BOGUS_MANUAL_CLOCK: ; 1F:1906, 0x03F906
    STA PPU_ADDR ; Set PPU_ADDR to (try) to clock A12.
    STA PPU_ADDR ; Which doesn't work btw.
    EOR #$10 ; Invert A12, lol.
    DEX ; X--
    BNE LOOP_PPU_BOGUS_MANUAL_CLOCK ; !=0, loop.
    RTS ; Leave.
CLEAR_IRQ_FLAGS_UNK: ; 1F:1912, 0x03F912
    LDA #$00
    STA IRQ_FLAG_R2-R5_BANK_7E
    STA IRQ_VAL_UNK
    STA IRQ_56_OR'D
MAPPER_IRQ_DISABLE+RTS: ; 1F:191A, 0x03F91A
    STA MMC3_IRQ_DISABLE
    RTS
RTS_SET_IRQ_5E_UNK: ; 1F:191E, 0x03F91E
    LDA #$80
    STA IRQ_VAL_UNK ; Set
    RTS ; RTS.
0x00_TO_MAPPER_MIRROR_COPY: ; 1F:1923, 0x03F923
    LDA #$00
    BEQ STORE_A_TO_MIRROR_COPY ; Always taken
0x01_TO_MAPPER_MIRROR_COPY: ; 1F:1927, 0x03F927
    LDA #$01
STORE_A_TO_MIRROR_COPY: ; 1F:1929, 0x03F929
    STA MMC3_MIRRORING_COPY
    RTS
SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A: ; 1F:192C, 0x03F92C
    TAY ; IRQ selection index to Y.
    ORA IRQ_VAL_UNK ; Or passed with value.
    STA IRQ_56_OR'D ; To addr.
    LDA IRQ_LATCH_VALUES,Y ; Load data.
    STA IRQ_LATCH_VALUE_COPY_57 ; Store to.
    TYA ; IRQ selection index back to A.
    ASL A ; Shift to make word index.
    TAY ; Back to Y again.
    LDA IRQ_RTNS_LOWER,Y ; Store IRQ addr.
    STA IRQ_HANDLER_JMP+1
    LDA IRQ_RTNS_UPPER,Y
    STA IRQ_HANDLER_JMP+2
    LDA #$4C ; JMP opcode.
    STA IRQ_HANDLER_JMP[3] ; Store.
    RTS
IRQ_LATCH_VALUES: ; 1F:1948, 0x03F948
    .db 00
    .db 30
    .db 08
    .db 08
    .db 8C
    .db 02
    .db B0
    .db B8
    .db 0A
    .db 1D
    .db 90
    .db 3D
    .db 74
    .db 2E
    .db 6C
    .db B0
    .db 3F
    .db 51
    .db 96
    .db 18
    .db 2E
    .db 30
IRQ_RTNS_LOWER: ; 1F:195E, 0x03F95E
    LOW(IRQ_RTN_DISABLE_IRQ) ; Basic disable IRQ and leave.
IRQ_RTNS_UPPER: ; 1F:195F, 0x03F95F
    HIGH(IRQ_RTN_DISABLE_IRQ)
    LOW(IRQ_RTN_B) ; Normal, gfx and whatnot.
    HIGH(IRQ_RTN_B)
    LOW(IRQ_RTN_C) ; Just a bit diff...
    HIGH(IRQ_RTN_C)
    LOW(IRQ_RTN_D) ; Pretty normal, gfx.
    HIGH(IRQ_RTN_D)
    LOW(IRQ_RTN_E) ; BG GFX swap.
    HIGH(IRQ_RTN_E)
    LOW(IRQ_RTN_F) ; Chr update.
    HIGH(IRQ_RTN_F)
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F)
    LOW(IRQ_RTN_G) ; Scrolling down diagonal sections?
    HIGH(IRQ_RTN_G)
    LOW(IRQ_RTN_H) ; Not much diff.
    HIGH(IRQ_RTN_H)
    LOW(IRQ_RTN_I) ; Secondary can switch.
    HIGH(IRQ_RTN_I)
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F)
    LOW(IRQ_RTN_I)
    HIGH(IRQ_RTN_I)
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F)
    LOW(IRQ_RTN_J) ; Alternate scrolling values?
    HIGH(IRQ_RTN_J)
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F)
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F)
    LOW(IRQ_RTN_J)
    HIGH(IRQ_RTN_J)
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F)
    LOW(IRQ_RTN_I)
    HIGH(IRQ_RTN_I)
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F)
    LOW(IRQ_RTN_K) ; Does a bit, similar still.
    HIGH(IRQ_RTN_K)
    LOW(IRQ_RTN_L) ; Does a bit, still not too dissimilar.
    HIGH(IRQ_RTN_L)
IRQ_RTN_DISABLE_IRQ: ; 1F:198A, 0x03F98A
    STA MMC3_IRQ_DISABLE ; These two looking kinda sus.
    RTI
IRQ_UPDATING_RTN: ; 1F:198E, 0x03F98E
    LDA IRQ_VAL_UNK ; Load val.
    BEQ MAPPER_IRQ_DISABLE+RTS ; No val, disable IRQ's and leave.
    STA MMC3_IRQ_DISABLE ; Disable.
    STA MMC3_IRQ_ENABLE ; Enable.
    LDA PPU_STATUS ; Reset latch.
    LDA #$00
    STA PPU_SCROLL ; Set scroll.
    STA PPU_SCROLL
    LDA PPU_STATUS
    LDA #$FF
    STA MMC3_IRQ_LATCH ; Write latch value.
    STA MMC3_IRQ_RELOAD ; Reload, full screen just in case disabled?
    LDA #$00 ; Address trickery. MMC3 IRQ manual clocking, probably. DOES NOT WORK PER NESDEV WIKI.
    STA PPU_ADDR
    STA PPU_ADDR
    LDA #$10
    STA PPU_ADDR
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    STA PPU_ADDR
    LDA #$10
    STA PPU_ADDR
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    STA PPU_ADDR
    LDY #$30 ; Latch value.
    LDX LEVEL_SCREEN_ON ; Get level.
    DEX ; X-=2
    DEX
    BNE SCREEN_NOT_2 ; Level/screen wasn't 2.
    DEY ; Latch -= 2 scanlines. Move up screen.
    DEY
    BNE COMMIT_Y_VAL_LATCH
SCREEN_NOT_2: ; 1F:19E2, 0x03F9E2
    LDA PPU_FLAG_UNK ; Load
    BEQ COMMIT_Y_VAL_LATCH ; If not set, use Y as is.
    DEY ; Latch -= 1 scanline. Move up screen.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$02 ; If even nonzero.
    BNE COMMIT_Y_VAL_LATCH ; If true, keep  latch value.
    INY ; Latch += 2 scanlines. Move down screen.
    INY
COMMIT_Y_VAL_LATCH: ; 1F:19F0, 0x03F9F0
    STY MMC3_IRQ_LATCH ; Store latch.
    STA MMC3_IRQ_RELOAD ; Reload it.
    STA MMC3_IRQ_ENABLE ; Enable IRQ's.
    CLI ; Enable interrupt disable.
    LDA FLAG_IRQ_660 ; Load.
    BEQ FLAG_NOT_SET ; Not set, don't clear.
    LDA #$00 ; Load value.
    STA IRQ_I_SECONDARY_KEEP_IF_POSITIVE ; Clear both.
    STA DA_UNK
    STA FLAG_IRQ_660 ; Clear flag.
FLAG_NOT_SET: ; 1F:1A08, 0x03FA08
    LDA FLAG_IRQ_65F_INDEX_UNK ; Load
    BEQ FLAG_65F_NOT_SET ; If not set, goto.
    ASL A ; A to index.
    TAY ; To Y.
    LDA D9_DATA,Y ; Move index to vars.
    STA IRQ_D9_PAIR_UNK
    LDA D8_DATA,Y
    STA IRQ_D8_PAIR_UNK
    LDA #$00
    STA FLAG_IRQ_65F_INDEX_UNK ; Clear flag.
FLAG_65F_NOT_SET: ; 1F:1A1E, 0x03FA1E
    LDA IRQ_D9_PAIR_UNK ; Load
    CMP #$04 ; If A _ 0x04
    BEQ ALT_SCREEN_FOUR? ; ==, goto.
    CMP #$07 ; A _ 0x07
    BNE USE_IRQ_RTNS_BASED_ON_LEVEL ; !=, goto.
    LDA #$15 ; Load. Alt screen 7.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Do.
    LDA #$12 ; Load.
    BNE SET_EXTENDED_IRQ_FROM_A ; Always taken.
ALT_SCREEN_FOUR?: ; 1F:1A31, 0x03FA31
    LDA #$15 ; Load.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Do.
    LDA #$0B ; Load.
    BNE SET_EXTENDED_IRQ_FROM_A ; Always taken.
USE_IRQ_RTNS_BASED_ON_LEVEL: ; 1F:1A3A, 0x03FA3A
    LDX LEVEL_SCREEN_ON ; Index from.
    LDA IRQ_HANDLER_PER_LEVEL,X ; Load data.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Do.
    LDX LEVEL_SCREEN_ON ; Re-load.
    LDA IRQ_EXTENSION_PER_LEVEL,X ; Data from.
SET_EXTENDED_IRQ_FROM_A: ; 1F:1A47, 0x03FA47
    STA IRQ_EXTENDED/HANDLER/SECONDARY ; Store to.
    LDA #$00 ; Switch R0/R1 to status bar GFX.
    JSR SETUP_R0/R1_IRQ_DATA ; Set up.
    JSR BANKSWITCH_R0/R1 ; Swap to.
RTS: ; 1F:1A51, 0x03FA51
    RTS ; Leave.
D9_DATA: ; 1F:1A52, 0x03FA52
    .db 00 ; D9
D8_DATA: ; 1F:1A53, 0x03FA53
    .db 00 ; D8
    .db 00 ; D9
    .db 00 ; D8
    .db 07 ; D9
    .db 08 ; D8
IRQ_HANDLER_PER_LEVEL: ; 1F:1A58, 0x03FA58
    .db 01
    .db 01
    .db 14
    .db 01
    .db 15
    .db 01
    .db 15
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
IRQ_EXTENSION_PER_LEVEL: ; 1F:1A64, 0x03FA64
    .db 04
    .db 04
    .db 02
    .db 00
    .db 09
    .db 00
    .db 09
    .db 0F
    .db 06
    .db 06
    .db 06
    .db 06
IRQ_L_SECONDARY_DATA: ; 1F:1A70, 0x03FA70
    .db 0D
    .db 10
IRQ_SECONDARY_NEXT: ; 1F:1A72, 0x03FA72
    .db 0E
    .db 11
IRQ_RTN_B: ; 1F:1A74, 0x03FA74
    PHA ; Save A
    TXA
    PHA ; Save X
    TYA
    PHA ; Save Y
    STA MMC3_IRQ_DISABLE ; Disable+enable for no IRQ's.
    STA MMC3_IRQ_ENABLE
    LDA IRQ_EXTENDED/HANDLER/SECONDARY
    BNE EXTENDED_RTN
    STA MMC3_IRQ_DISABLE ; Disable otherwise.
    JMP IRQ_WAIT/PPU/UNK/GFX/CFG_GENERAL
EXTENDED_RTN: ; 1F:1A89, 0x03FA89
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A
    LDA IRQ_LATCH_VALUE_COPY_57
    STA MMC3_IRQ_LATCH
IRQ_WAIT/PPU/UNK/GFX/CFG_GENERAL: ; 1F:1A91, 0x03FA91
    LDY #$0C ; Delay amount.
DELAY_LOOP: ; 1F:1A93, 0x03FA93
    DEY ; Y--
    BNE DELAY_LOOP ; != 0, loop.
    LDA PPU_STATUS ; Reset latch.
    LDX PPU_ADDR_IRQ+1
    LDY PPU_ADDR_IRQ[2]
    STX PPU_ADDR ; Store addr.
    STY PPU_ADDR
    LDA PPU_STATUS ; Reset latch more.
    LDX PPU_SCROLL_X_COPY_IRQ
    LDY PPU_SCROLL_Y_COPY_IRQ
    LDA NAMETABLE_VAR_UNK
    AND #$01 ; Isolate.
    ORA PPU_CTRL_RAM_COPY ; Set to proper nametable.
    STX PPU_SCROLL ; Set X and Y scroll. Bonus points for proper registers.
    STY PPU_SCROLL
    STA PPU_CTRL ; Set CTRL.
    LDA IRQ_BANK_VALUES_R[0/1][2]
    STA IRQ_GFX_DATA_BANK_R0
    LDA IRQ_BANK_VALUES_R[0/1]+1
    STA IRQ_GFX_DATA_BANK_R1
    JSR BANKSWITCH_R0/R1 ; Switch graphics.
    LDA #$00
    STA IRQ_FLAG_R2-R5_BANK_7E ; Use RAM ones.
    JSR BANK_R2-R5_FROM_60D ; Switch graphics.
    LDX LEVEL_SCREEN_ON ; X from
    LDA RTN_EXTRA_DATA,X
    STA IRQ_EXTENDED/HANDLER/SECONDARY
RTI_AND_RESTORE_BANK_CFG: ; 1F:1AD4, 0x03FAD4
    LDX 28_BANK_CFG_INDEX? ; X from.
    LDA COPY_BANK_CFG_F5,X ; Bank config.
    STA MMC3_BANK_CFG ; Set config.
    PLA ; Restore Y
    TAY
    PLA
    TAX ; Restore X
    PLA ; Restore A
    RTI
RTN_EXTRA_DATA: ; 1F:1AE1, 0x03FAE1
    .db 08
    .db 08
    .db 00
    .db 00
    .db 0A
    .db 00
    .db 0A
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
IRQ_RTN_L: ; 1F:1AED, 0x03FAED
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; MMC3 IRQ dis/enable.
    STA MMC3_IRQ_ENABLE
    LDA IRQ_EXTENDED/HANDLER/SECONDARY ; Set next.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A
    LDA IRQ_LATCH_VALUE_COPY_57 ; Set latch.
    STA MMC3_IRQ_LATCH
    LDY #$11 ; Delay val.
DELAY_LOOP: ; 1F:1B04, 0x03FB04
    DEY ; Y--
    BNE DELAY_LOOP ; != 0, continue.
    LDA PPU_STATUS ; Reset PPU latch.
    LDX PPU_ADDR_IRQ+1 ; Store addr.
    LDY PPU_ADDR_IRQ[2]
    STX PPU_ADDR
    STY PPU_ADDR
    LDA PPU_STATUS ; Reset latch again? Mistake? TODO: Eh.
    LDX IRQ_L_SCROLL_X ; X scroll.
    LDY PPU_SCROLL_Y_COPY_IRQ ; Y scroll.
    LDA IRQ_L_NAMETABLE_FOCUS ; Get focus.
    AND #$01
    ORA PPU_CTRL_RAM_COPY ; Combine with CTRL.
    STX PPU_SCROLL ; Commit data to PPU.
    STY PPU_SCROLL
    STA PPU_CTRL
    LDA #$00
    STA IRQ_FLAG_R2-R5_BANK_7E ; From RAM.
    JSR BANK_R2-R5_FROM_60D ; Set GFX.
    LDA IRQ_BANK_VALUES_R[0/1][2] ; Move BG banks wanted.
    STA IRQ_GFX_DATA_BANK_R0
    LDA IRQ_BANK_VALUES_R[0/1]+1
    STA IRQ_GFX_DATA_BANK_R1
    JSR BANKSWITCH_R0/R1 ; Commit to hardware.
    LDA IRQ_I_SECONDARY_KEEP_IF_POSITIVE ; Load.
    BPL VAL_POSITIVE ; Positive, don't set other secondary.
    LDX A7_IRQ_REPLACE_SECONDARY_INDEX ; Load index.
    LDA IRQ_L_SECONDARY_DATA,X ; Load next secondary.
    JMP SET_SECONDARY ; Store to.
VAL_POSITIVE: ; 1F:1B4A, 0x03FB4A
    LDA IRQ_D9_PAIR_UNK ; Load
    CMP #$07 ; If _ #$07
    BEQ SECONDARY_OPT_A ; ==, goto.
    CMP #$04
    BNE SECONDARY_DEFAULT ; Not 4 or 7, goto.
    LDA #$0C ; D9 == 4, set secondary.
    BNE SET_SECONDARY ; Set.
SECONDARY_OPT_A: ; 1F:1B58, 0x03FB58
    LDA #$13 ; D9 == 7, set secondary.
    BNE SET_SECONDARY ; Set.
SECONDARY_DEFAULT: ; 1F:1B5C, 0x03FB5C
    LDA #$0A ; Default.
SET_SECONDARY: ; 1F:1B5E, 0x03FB5E
    STA IRQ_EXTENDED/HANDLER/SECONDARY ; Set secondary.
    JMP RTI_AND_RESTORE_BANK_CFG ; Leave.
IRQ_RTN_K: ; 1F:1B63, 0x03FB63
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; Disable and enable IRQ's.
    STA MMC3_IRQ_ENABLE
    LDY #$07 ; Y=
    LDA 601_IRQ_FLAG_DELAY_MOD_+ ; Load to test.
    BPL USE_Y_LATCH ; If positive, use Y as is.
    LDA 81_UNK ; Load
    AND #$07 ; Keep bottom bits.
    STA IRQ_LATCH_VALUE_COPY_5A ; Store to.
    LDA #$09 ; Load val.
    SEC
    SBC IRQ_LATCH_VALUE_COPY_5A ; -= Val.
    TAY ; To Y.
USE_Y_LATCH: ; 1F:1B81, 0x03FB81
    STY MMC3_IRQ_LATCH ; Store to mapper.
    STY IRQ_LATCH_VALUE_COPY_5A ; Store to copy.
    LDA 601_IRQ_FLAG_DELAY_MOD_+ ; Load to test.
    BMI DELAY_SMALLER ; If negative, goto.
    LDY #$0B ; Delay val.
DELAY_LOOP: ; 1F:1B8D, 0x03FB8D
    DEY ; Y--
    BNE DELAY_LOOP ; != 0, keep looping.
    BEQ DELAY_FINISHED ; Always taken.
DELAY_SMALLER: ; 1F:1B92, 0x03FB92
    LDY #$08 ; Delay val.
DELAY_LOOP_SMOL: ; 1F:1B94, 0x03FB94
    DEY ; Y--
    BNE DELAY_LOOP_SMOL ; != 0, keep looping.
DELAY_FINISHED: ; 1F:1B97, 0x03FB97
    LDA #$00
    STA IRQ_FLAG_R2-R5_BANK_7E ; Use from RAM.
    JSR BANK_R2-R5_FROM_60D ; Set GFX.
    LDA #$7E
    STA IRQ_GFX_DATA_BANK_R0 ; Set manually to 7E.
    STA IRQ_GFX_DATA_BANK_R1
    JSR BANKSWITCH_R0/R1 ; Switch in.
    LDA #$02
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Set next.
    JMP RTI_AND_RESTORE_BANK_CFG
IRQ_RTN_C: ; 1F:1BAF, 0x03FBAF
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE
    STA MMC3_IRQ_ENABLE
    LDA #$0A ; Load...
    SEC
    SBC IRQ_LATCH_VALUE_COPY_5A ; -=Addr
    TAY ; To Y...y?
    STY MMC3_IRQ_LATCH ; Store latch.
    LDA PPU_STATUS ; Reset latch.
    LDX PPU_ADDR_IRQ+1
    LDY PPU_ADDR_IRQ[2]
    STX PPU_ADDR ; Store IRQ Addr.
    STY PPU_ADDR
    LDY #$06 ; Y=
    LDA 601_IRQ_FLAG_DELAY_MOD_+ ; Load. BIT would have been better.
    BPL POSITIVE ; If positive, extend 6.
    INY ; Extend val 7.
POSITIVE: ; 1F:1BD8, 0x03FBD8
    STY IRQ_EXTENDED/HANDLER/SECONDARY ; Store to.
    TYA ; To A
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Set handler somehow.
    LDA IRQ_EXTENDED/HANDLER/SECONDARY ; Load
    CMP #$06 ; If _ 6
    BEQ HANDLER_3_BANK_MOVED? ; ==, goto.
    LDA IRQ_LATCH_VALUE_COPY_5A ; Load val.
    CMP #$01 ; If _ 1
    BNE LATCH_NOT_1 ; !=, goto.
    LDA 58_IRQ_UNK ; Load
    CMP #$B8 ; If _ B8
    BEQ LATCH_NOT_1 ; ==, goto. Don't inc var.
    INC IRQ_LATCH_VALUE_COPY_57 ; Inc var
LATCH_NOT_1: ; 1F:1BF2, 0x03FBF2
    LDA IRQ_LATCH_VALUE_COPY_57 ; Load
    SEC ; Prep sub.
    SBC 58_IRQ_UNK ; Sub value.
    BEQ A_VAL_AE ; Result == 0, goto.
    BCC A_VAL_AE ; A < SUB, goto.
    CMP #$AE ; If result _ AE
    BCC USE_A_AS_5D ; <, goto.
A_VAL_AE: ; 1F:1BFF, 0x03FBFF
    LDA #$AE ; Cap.
    BNE USE_A_AS_5D ; Goto, always taken.
HANDLER_3_BANK_MOVED?: ; 1F:1C03, 0x03FC03
    LDA IRQ_LATCH_VALUE_COPY_57 ; Load IRQ bank.
USE_A_AS_5D: ; 1F:1C05, 0x03FC05
    STA 5D_IRQ_BANK? ; Store to.
    LDA #$03 ; Load
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Set handler somehow.
    JMP RTI_AND_RESTORE_BANK_CFG ; Finish.
IRQ_RTN_D: ; 1F:1C0F, 0x03FC0F
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; Stop IRQ.
    STA MMC3_IRQ_ENABLE
    LDA 5D_IRQ_BANK? ; Load val.
    STA MMC3_IRQ_LATCH ; Store to latch.
    LDA IRQ_EXTENDED/HANDLER/SECONDARY ; Load
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A
    LDA PPU_STATUS ; Reset
    LDX PPU_SCROLL_X_COPY_IRQ ; Set scroll.
    LDY PPU_SCROLL_Y_COPY_IRQ
    LDA NAMETABLE_VAR_UNK
    AND #$01
    ORA PPU_CTRL_RAM_COPY
    STX PPU_SCROLL
    STY PPU_SCROLL
    STA PPU_CTRL
    LDA 601_IRQ_FLAG_DELAY_MOD_+ ; Load val.
    BMI DELAY_SMALLER ; If set, goto.
    LDY #$0C
DELAY_LARGE_LOOP: ; 1F:1C43, 0x03FC43
    DEY
    BNE DELAY_LARGE_LOOP
    BEQ DELAY_FINSIHED ; Skip smaller delay.
DELAY_SMALLER: ; 1F:1C48, 0x03FC48
    LDY #$09
DELAY_SMALL_LOOP: ; 1F:1C4A, 0x03FC4A
    DEY
    BNE DELAY_SMALL_LOOP
DELAY_FINSIHED: ; 1F:1C4D, 0x03FC4D
    LDA IRQ_BANK_VALUES_R[0/1][2] ; Move bank vals.
    STA IRQ_GFX_DATA_BANK_R0
    LDA IRQ_BANK_VALUES_R[0/1]+1
    STA IRQ_GFX_DATA_BANK_R1
    JSR BANKSWITCH_R0/R1 ; Swap GFX.
    JMP RTI_AND_RESTORE_BANK_CFG ; Leave.
IRQ_RTN_G: ; 1F:1C5B, 0x03FC5B
    PHA ; Save X.
    TXA
    PHA ; Save Y.
    TYA
    PHA ; Save A.
    STA MMC3_IRQ_DISABLE ; Disable IRQ's.
    LDY #$2E ; Delay timer.
WAIT_LOOP: ; 1F:1C65, 0x03FC65
    DEY ; Y--
    BNE WAIT_LOOP ; != 0, keep waiting.
    LDX #$00
    STX MMC3_BANK_CFG ; Reset CFG, R0.
    LDY #$7E ; Val?
    STY MMC3_BANK_DATA ; Bank to R0.
    INX ; X = 1
    STX MMC3_BANK_CFG ; R1
    STY MMC3_BANK_DATA ; Also copy to R1.
    LDA NAMETABLE_VAR_UNK ; Load
    AND #$01 ; Keep bottom bit.
    ORA PPU_CTRL_RAM_COPY ; Set base nametable for PPUCTRL.
    TAX ; Save to X.
    LDY #$C0 ; Y=
    LDA PPU_STATUS ; Reset latch.
    LDA #$20
    STA PPU_ADDR ; Addr 20C0.
    STY PPU_ADDR
    STX PPU_CTRL ; Store PPU CTRL.
    LDA PPU_SCROLL_X_COPY_IRQ ; Load ammount X scrolling.
    STA PPU_SCROLL ; Store to X.
    STA PPU_SCROLL ; And Y.
    LDX #$00
    STX MMC3_BANK_CFG ; Reset bank cfg, R0.
    LDA IRQ_BANK_VALUES_R[0/1][2] ; Load bank.
    STA MMC3_BANK_DATA ; Store.
    INX ; R1
    STX MMC3_BANK_CFG ; R1.
    LDA IRQ_BANK_VALUES_R[0/1]+1 ; Load R1.
    STA MMC3_BANK_DATA ; Store.
    LDX 28_BANK_CFG_INDEX? ; Set previous CFG.
    LDA COPY_BANK_CFG_F5,X
    STA MMC3_BANK_CFG
    PLA ; Restore Y.
    TAY
    PLA ; Restore X.
    TAX
    PLA ; Restore A.
    RTI ; Leave IRQ.
IRQ_RTN_I: ; 1F:1CBA, 0x03FCBA
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; Disable.
    STA MMC3_IRQ_ENABLE ; Enable.
    LDA IRQ_EXTENDED/HANDLER/SECONDARY ; Load extended.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Set next.
    LDA IRQ_LATCH_VALUE_COPY_57 ; Set latch.
    STA MMC3_IRQ_LATCH
    LDA PPU_STATUS ; Reset PPU latch.
    LDX B1_SCROLL_X_COPY_IRQ_ZP[2] ; Load X scroll.
    LDY PPU_SCROLL_Y_COPY_IRQ ; Load Y scroll.
    LDA NAMETABLE_FOCUS_VAL[2] ; Load nametable focus.
    AND #$01 ; Keep focus bit.
    ORA PPU_CTRL_RAM_COPY ; Set PPU otherwise.
    STX PPU_SCROLL ; Store scroll.
    STY PPU_SCROLL ; Store scroll.
    STA PPU_CTRL ; Store nametable.
    LDA IRQ_I_SECONDARY_KEEP_IF_POSITIVE ; Load..
    BPL EXIT_IRQ ; Is positive, keep secondary as is.
    LDX A7_IRQ_REPLACE_SECONDARY_INDEX ; Index.
    LDA IRQ_SECONDARY_NEXT,X ; Get value.
    STA IRQ_EXTENDED/HANDLER/SECONDARY ; Next one is this instead.
EXIT_IRQ: ; 1F:1CF0, 0x03FCF0
    JMP RTI_AND_RESTORE_BANK_CFG ; Leave.
IRQ_RTN_E: ; 1F:1CF3, 0x03FCF3
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; Disable IRQ's.
    STA MMC3_IRQ_ENABLE
    LDA IRQ_EXTENDED/HANDLER/SECONDARY ; Load val
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Handler from.
    LDA IRQ_LATCH_VALUE_COPY_57 ; Load val.
    STA MMC3_IRQ_LATCH ; To latch.
    LDX 612_STEP?_UNK ; X=
    LDA IRQ/SCRIPT_RUN_COUNT? ; A=
    AND #$07 ; Get bottom bits.
    BNE KEEP_X_ASIS ; Only mod every 8th frame.
    INX ; X++
    CPX #$03 ; If X _ 3
    BNE STORE_X_ASIS ; !=, goto.
    LDX #$00 ; Reset X.
STORE_X_ASIS: ; 1F:1D18, 0x03FD18
    STX 612_STEP?_UNK ; X back to.
KEEP_X_ASIS: ; 1F:1D1B, 0x03FD1B
    LDY #$10 ; Y=
DELAY_LOOP: ; 1F:1D1D, 0x03FD1D
    DEY ; Y--
    BNE DELAY_LOOP ; !=0, loop.
    LDA ANIM_DATA_BANKS_R1,X ; A from, X indexed.
    STA IRQ_GFX_DATA_BANK_R1 ; Change to bank.
    JSR BANKSWITCH_R0/R1 ; Swap BG GFX
    LDA #$05 ; A=
    STA IRQ_EXTENDED/HANDLER/SECONDARY ; Change handler.
    JMP RTI_AND_RESTORE_BANK_CFG ; Goto.
ANIM_DATA_BANKS_R1: ; 1F:1D2F, 0x03FD2F
    .db 02
    .db 04
    .db 06
IRQ_RTN_H: ; 1F:1D32, 0x03FD32
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; Stop IRQ's.
    STA MMC3_IRQ_ENABLE ; Enable again.
    LDA IRQ_EXTENDED/HANDLER/SECONDARY ; Load.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Set.
    LDA IRQ_LATCH_VALUE_COPY_57 ; Load.
    STA MMC3_IRQ_LATCH ; Store.
    LDX #$08 ; Delay val.
DELAY_LOOP: ; 1F:1D49, 0x03FD49
    DEX ; X--
    BNE DELAY_LOOP ; != 0, keep delaying.
    LDA #$01
    STA IRQ_FLAG_R2-R5_BANK_7E ; Set flag.
    JSR BANK_R2-R5_FROM_60D ; Write values.
    JMP RTI_AND_RESTORE_BANK_CFG ; Leave.
IRQ_RTN_F: ; 1F:1D56, 0x03FD56
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; Stop IRQ's.
    STA MMC3_IRQ_ENABLE
    STA MMC3_IRQ_DISABLE ; Disable again.
    LDA #$01
    STA IRQ_FLAG_R2-R5_BANK_7E ; True, set to 7E.
    JSR BANK_R2-R5_FROM_60D ; Switch GFX for sprites.
    JMP RTI_AND_RESTORE_BANK_CFG ; Commit, abuse RTI.
IRQ_RTN_J: ; 1F:1D6E, 0x03FD6E
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; IRQ Disable.
    STA MMC3_IRQ_ENABLE
    LDA IRQ_EXTENDED/HANDLER/SECONDARY ; Set secondary.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A
    LDA IRQ_LATCH_VALUE_COPY_57 ; Set latch.
    STA MMC3_IRQ_LATCH
    LDY #$02 ; Y=
LOOP_DELAY: ; 1F:1D85, 0x03FD85
    DEY ; Y=1
    BNE LOOP_DELAY ; Delay very smol.
    LDA PPU_STATUS ; Reset latch.
    LDA B3_SCROLL_X_IRQ_J
    STA PPU_SCROLL ; Set X scroll.
    LDA PPU_SCROLL_Y_COPY_IRQ
    STA PPU_SCROLL ; Set Y scroll.
    LDA B6_NAMETABLE_FOCUS_UNK ; Load
    AND #$01 ; Keep nametable.
    ORA PPU_CTRL_RAM_COPY ; Config CTRL with.
    STA PPU_CTRL ; Store to CTRL.
    JMP RTI_AND_RESTORE_BANK_CFG ; Leave.
RESET_HANDLER: ; 1F:1DA1, 0x03FDA1
    SEI ; Disable interrupts.
    CLD ; Clear decimal.
    LDX #$FF ; Load stack with FF.
    TXS
    LDA #$28
    STA PPU_CTRL ; Set PPU 8x16, sprites table 1.
    LDA #$1E
    STA PPU_MASK ; Enable rendering.
    LDX #$02 ; Wait this many frames.
PPU_WAIT_A: ; 1F:1DB2, 0x03FDB2
    BIT PPU_STATUS
    BPL PPU_WAIT_A
PPU_WAIT_B: ; 1F:1DB7, 0x03FDB7
    BIT PPU_STATUS
    BMI PPU_WAIT_B ; If minus, loop again?
    DEX ; X--
    BNE PPU_WAIT_A ; Wait more.
    JSR DISABLE_MAPPER_IRQ+SOUND
    JSR MAPPER_IRQ_DISABLE+RTS ; Did this need to be a subroutine? lol.
    JSR SET_APU_STATUS+SEQUENCE_F_C0
    LDA #$00
    STA TMP_00 ; Setup ram clear PTR.
    STA TMP_01
    LDY #$00 ; Index
    LDX #$08 ; Loop count.
RAM_CLEAR_LOOP: ; 1F:1DD2, 0x03FDD2
    STA [TMP_00],Y ; Clear.
    INY ; Stream++
    BNE RAM_CLEAR_LOOP ; Loop 256
    INC TMP_01 ; Inc high addr.
    CPX TMP_01 ; Compare to X.
    BNE RAM_CLEAR_LOOP ; Not done, loop more.
    JSR SOUND_INIT_RTN? ; Sound.
    JSR INIT_STREAM+MISC_UNK
    JSR ENABLE_NMI+INIT_UNK
    CLI ; Enable interrupts.
INFINITE_LOOP: ; 1F:1DE7, 0x03FDE7
    INC INF_LOOP_COUNTER_UNK ; Inc
    CLC
    LDA INF_LOOP_COUNTER_UNK ; Load
    ADC IRQ/SCRIPT_RUN_COUNT? ; Add with...
    STA INF_LOOP_COUNTER_UNK ; Store back.
    JMP INFINITE_LOOP ; Loop forever.
ALT_NMI_CODE: ; 1F:1DF3, 0x03FDF3
    JSR SET_PPU_ADDR/SCROLL/CTRL ; Set scroll.
    JSR IRQ_UPDATING_RTN
    JSR BANKSWITCH_R0/R1
    JSR WRITE_R2-R5_FROM_RAM
    JSR SOUND_FORWARD?
    LDX 28_BANK_CFG_INDEX? ; Load
    LDA COPY_BANK_CFG_F5,X ; A from.
    STA MMC3_BANK_CFG ; Restore config.
    JMP RTI_RESTORE_AXY ; Leave NMI.
NMI_HANDLER: ; 1F:1E0C, 0x03FE0C
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    LDA PPU_STATUS ; Reset latch.
    LDY FLAG_NMI_ALT_UNK ; Y from.
    BNE ALT_NMI_CODE ; If set, do other.
    INC FLAG_NMI_ALT_UNK ; Set to true.
    LDA #$00
    STA PPU_OAM_ADDR ; Set addr.
    LDY #$02
    STY OAM_DMA ; Upload sprites from 0x0200.
    JSR DISABLE_PPU_RENDERING
    JSR UPDATE_BUF_0x300_TO_PPU
    JSR PPU_READING_SHENANIGANS_RTN ; I think this is to mod health values?
    LDA PPU_MASK_RAM_COPY? ; Load mask
    LDX DISABLE_RENDERING_X_FRAMES ; X from
    BEQ A_TO_PPU_MASK ; == 0, skip.
    DEC DISABLE_RENDERING_X_FRAMES ; --
    BEQ A_TO_PPU_MASK ; If now 0, enable.
    AND #$E7 ; Disable sprites and BG.
A_TO_PPU_MASK: ; 1F:1E39, 0x03FE39
    STA PPU_MASK ; Store mask.
    JSR SET_PPU_ADDR/SCROLL/CTRL ; Set PPU stuff.
    JSR IRQ_UPDATING_RTN ; IRQ stuffs here. <<<<<<<<<<<<<<<<<<<<<
    LDA MMC3_MIRRORING_COPY ; Load copy.
    STA MMC3_MIRRORING ; Store to mapper.
    LDX #$00 ; Index 0.
LOOP_MOVE_3DATA: ; 1F:1E49, 0x03FE49
    LDA AE_ARR_UNK[2],X ; Move unk...
    STA 656_ARR_AE_COPY_UNK[2],X
    LDA B1_SCROLL_X_COPY_IRQ_ZP[2],X
    STA PPU_SCROLL_X_COPY_IRQ,X
    LDA NAMETABLE_FOCUS_VAL[2],X
    STA NAMETABLE_VAR_UNK,X
    INX ; X++
    CPX #$02 ; If X _ #$02
    BNE LOOP_MOVE_3DATA ; Move both sets.
    JSR MOVE_R2-R5_VALUES_ZP_TO_60D
    JSR BANK_R2-R5_FROM_60D
    JSR BANKSWITCH_R0/R1
    JSR SOUND_FORWARD?
    JSR CTRL_READ_SAFE ; Read controllers.
    JSR BUF_MGMT_UNK
    JSR GAME_SCRIPT_SWITCHES ; Game script, you're probably looking for this. <<<<<<<<<<<<<<<
    JSR SPRITES_UPDATE?
    LDX PPU_UPDATE_BUF_INDEX ; Load index.
    LDA #$00 ; Load
    STA PPU_UPDATE_BUFFER[20],X ; Store EOF in buf.
    INX ; X++
    STX PPU_UPDATE_BUF_INDEX ; Store index past EOF.
    STA FLAG_NMI_ALT_UNK ; Clear.
RTI_RESTORE_AXY: ; 1F:1E81, 0x03FE81
    PLA
    TAY ; Restore Y
    PLA
    TAX ; Restore X.
    PLA ; Restore A.
    RTI ; Leave NMI.
SET_PPU_ADDR/SCROLL/CTRL: ; 1F:1E87, 0x03FE87
    LDA PPU_STATUS ; Reset latch.
    LDA #$20 ; Set addr.
    STA PPU_ADDR
    LDA #$00
    STA PPU_ADDR
    LDA PPU_STATUS ; Reset latch again.
    LDA PPU_SCROLL_X_COPY_IRQ ; Set scroll.
    STA PPU_SCROLL
    LDA PPU_SCROLL_Y_COPY_IRQ
    STA PPU_SCROLL
WRITE_PPU_CTRL_COPY: ; 1F:1EA1, 0x03FEA1
    LDA PPU_CTRL_RAM_COPY ; Set CTRL.
    STA PPU_CTRL
    RTS
SET_APU_STATUS+SEQUENCE_F_C0: ; 1F:1EA7, 0x03FEA7
    LDA #$0F
    STA APU_STATUS
    LDA #$C0
    STA APU_FSEQUENCE
    RTS
ENABLE_NMI+INIT_UNK: ; 1F:1EB2, 0x03FEB2
    LDA #$A8 ; Load. NMI, LSprites, Sprites table 1.
    STA PPU_CTRL_RAM_COPY ; Store
    STA PPU_CTRL ; Store.
    LDA #$1E
    STA PPU_MASK_RAM_COPY? ; Mask RAM copy?
    LDA #$05
    STA DISABLE_RENDERING_X_FRAMES ; 5 frames until we do stuff?
    RTS
DISABLE_PPU_RENDERING: ; 1F:1EC2, 0x03FEC2
    LDA PPU_CTRL_RAM_COPY ; Load copy.
    AND #$7F ; Disable NMI.
    STA PPU_CTRL ; Commit.
    LDA #$00
    STA PPU_ADDR
    STA PPU_ADDR ; Reset addr.
    LDA PPU_MASK_RAM_COPY? ; Load...copy?
    AND #$E7 ; Disable rendering both sprites and BG.
    STA PPU_MASK ; Store.
    RTS
CTRL_READ_SAFE: ; 1F:1ED9, 0x03FED9
    LDX #$00 ; X=
    JSR LATCH_READ_CTRL
    LDX #$02 ; Index to store other ctrl bits.
    JSR LATCH_READ_CTRL
    LDA TMP_00 ; Load first bits.
    CMP TMP_02 ; Compare to 2nd read.
    BNE CTRL_FAIL_NO_NEW_PRESSES ; !=, goto.
    LDA TMP_01
    CMP TMP_03
    BNE CTRL_FAIL_NO_NEW_PRESSES ; Same idea.
    LDX #$00 ; P1 index.
    JSR CTRL_X_PROCESS ; Process
    INX ; P2 index.
CTRL_X_PROCESS: ; 1F:1EF5, 0x03FEF5
    LDA TMP_00,X ; Load CTRL buttons.
    TAY ; To Y
    EOR CTRL_PREV_B[2],X ; Get newly pressed only.
    AND TMP_00,X ; Newly pressed only.
    STA CTRL_NEWLY_PRESSED_A[2],X
    STA CTRL_NEWLY_PRESSED_B[2],X
    STY CTRL_PREV_A[2],X
    STY CTRL_PREV_B[2],X
    RTS
CTRL_FAIL_NO_NEW_PRESSES: ; 1F:1F05, 0x03FF05
    LDA #$00
    STA CTRL_NEWLY_PRESSED_A[2]
    STA CTRL_NEWLY_PRESSED_B[2]
    STA CTRL_NEWLY_PRESSED_A+1
    STA CTRL_NEWLY_PRESSED_B+1
    RTS
LATCH_READ_CTRL: ; 1F:1F10, 0x03FF10
    LDY #$01 ; Y=
    STY NES_CTRL1 ; Reset CTRL.
    DEY ; Y=0
    STY NES_CTRL1 ; Complete latch.
    LDY #$08 ; Loop count.
LOOP_READ_CTRL: ; 1F:1F1B, 0x03FF1B
    LDA NES_CTRL1 ; Load ctrl.
    STA TMP_04 ; Store to RAM.
    LSR A ; Shift.
    ORA TMP_04 ; Or other bits...
    LSR A ; Shift again.
    ROL TMP_00,X ; P1 bits.
    LDA NES_CTRL2 ; Load ctrl.
    STA TMP_05 ; Store to RAM.
    LSR A ; Shift
    ORA TMP_05 ; Gather bits.
    LSR A ; Shift
    ROL TMP_01,X ; P2 bits/
    DEY ; Loop--
    BNE LOOP_READ_CTRL
    RTS
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db FF
    .db 4D ; 'MAST900801', online says this is the version/date info.
    .db 41
    .db 53
    .db 54
    .db 39
    .db 30
    .db 30
    .db 38
    .db 30
    .db 31
VECTOR_NMI: ; 1F:1FFA, 0x03FFFA
    LOW(NMI_HANDLER)
    HIGH(NMI_HANDLER)
VECTOR_RESET: ; 1F:1FFC, 0x03FFFC
    LOW(RESET_HANDLER)
    HIGH(RESET_HANDLER)
VECTOR_IRQ/BRK: ; 1F:1FFE, 0x03FFFE
    LOW(IRQ_HANDLER_JMP)
    HIGH(IRQ_HANDLER_JMP)
