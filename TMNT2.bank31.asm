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
    STA PPU_UPDATE_BUFFER[64],X ; Store to.
    INX ; Index++
    LDA TMP_04 ; Load
    STA PPU_UPDATE_BUFFER[64],X ; Store addr.
    INX ; Index++
    LDA TMP_05 ; Load
    STA PPU_UPDATE_BUFFER[64],X ; Store addr.
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
    STA PPU_UPDATE_BUFFER[64],X ; To buffer.
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
    STA PPU_UPDATE_BUFFER[64],X ; Store EOF.
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
    STA PPU_UPDATE_BUFFER[64],X ; Set EOF.
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
    STA PPU_UPDATE_BUFFER[64],X ; Type.
    INX ; Index++
    LDA TMP_06 ; Load.
    STA PPU_UPDATE_BUFFER[64],X ; Store addr.
    INX ; Index++
    LDA TMP_07 ; Load.
    STA PPU_UPDATE_BUFFER[64],X ; Store addr.
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
    STA PPU_UPDATE_BUFFER[64],X ; Store to buffer.
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
    STA PPU_UPDATE_BUFFER[64],X ; Store EOF.
    INX ; Index++
    STX PPU_UPDATE_BUF_INDEX ; Store index.
    JMP LOOP_PREP_SHIFTS
RTS_EOF: ; 1F:01D2, 0x03E1D2
    LDA #$FF
    STA PPU_UPDATE_BUFFER[64],X ; Set index.
    INX ; ++
    STX PPU_UPDATE_BUF_INDEX ; Store index.
    RTS
BANK_SWITCH_BASED_ON_SCREEN/LEVEL: ; 1F:01DB, 0x03E1DB
    LDY LEVEL/SCREEN_ON ; Load screen for index.
    LDA BANK_USE_DATA,Y ; Load bank for data.
    JMP BANK_PAIR_USE_A ; Bank in data.
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
FILE_PTRS_POSITIVE_L: ; 1F:01EF, 0x03E1EF
    LOW(AAAAAA)
FILE_PTRS_POSITIVE_H: ; 1F:01F0, 0x03E1F0
    HIGH(AAAAAA)
    LOW(BBBBBB)
    HIGH(BBBBBB)
    LOW(CCCCCC)
    HIGH(CCCCCC)
    LOW(DDDDDD)
    HIGH(DDDDDD)
    LOW(EEEEEE)
    HIGH(EEEEEE)
    LOW(FFFFFF)
    HIGH(FFFFFF)
    LOW(GGGGGG)
    HIGH(GGGGGG)
    LOW(HHHHHH)
    HIGH(HHHHHH)
    LOW(IIIIII)
    HIGH(IIIIII)
    LOW(JJJJJJ)
    HIGH(JJJJJJ)
    LOW(KKKKKK)
    HIGH(KKKKKK)
    LOW(LLLLLL)
    HIGH(LLLLLL)
    LOW(MMMMMM)
    HIGH(MMMMMM)
    LOW(NNNNNN)
    HIGH(NNNNNN)
    LOW(OOOOOO)
    HIGH(OOOOOO)
    LOW(PPPPPP)
    HIGH(PPPPPP)
    LOW(QQQQQQ)
    HIGH(QQQQQQ)
    LOW(RRRRRR)
    HIGH(RRRRRR)
    LOW(SSSSSS)
    HIGH(SSSSSS)
    LOW(TTTTTT)
    HIGH(TTTTTT)
    LOW(UUUUUU)
    HIGH(UUUUUU)
    LOW(VVVVVV)
    HIGH(VVVVVV)
    LOW(WWWWWW)
    HIGH(WWWWWW)
    LOW(XXXXXX)
    HIGH(XXXXXX)
AAAAAA: ; 1F:021F, 0x03E21F
    .db 08
    .db 08
    .db 00
    .db 20
    .db 0E
BBBBBB: ; 1F:0224, 0x03E224
    .db 10
    .db 10
    .db 00
    .db 28
    .db 0E
CCCCCC: ; 1F:0229, 0x03E229
    .db 08
    .db 08
    .db 00
    .db 10
    .db 0E
DDDDDD: ; 1F:022E, 0x03E22E
    .db 14
    .db 14
    .db 00
    .db 40
    .db 0E
EEEEEE: ; 1F:0233, 0x03E233
    .db 20
    .db 00
    .db 00
    .db 30
    .db 10
FFFFFF: ; 1F:0238, 0x03E238
    .db 20
    .db 20
    .db 00
    .db 30
    .db 0E
GGGGGG: ; 1F:023D, 0x03E23D
    .db 14
    .db 10
    .db 00
    .db 40
    .db 0E
HHHHHH: ; 1F:0242, 0x03E242
    .db 18
    .db 18
    .db 00
    .db 40
    .db 18
IIIIII: ; 1F:0247, 0x03E247
    .db 10
    .db 10
    .db 00
    .db 20
    .db 0E
JJJJJJ: ; 1F:024C, 0x03E24C
    .db 03
    .db 03
    .db 00
    .db 30
    .db 0E
KKKKKK: ; 1F:0251, 0x03E251
    .db 10
    .db 10
    .db 00
    .db 30
    .db 0E
LLLLLL: ; 1F:0256, 0x03E256
    .db 04
    .db 04
    .db 00
    .db 20
    .db 0E
MMMMMM: ; 1F:025B, 0x03E25B
    .db 0C
    .db 0C
    .db 00
    .db 14
    .db 14
NNNNNN: ; 1F:0260, 0x03E260
    .db 0A
    .db 0A
    .db 00
    .db 30
    .db 0E
OOOOOO: ; 1F:0265, 0x03E265
    .db 1C
    .db 00
    .db 00
    .db 30
    .db 0E
PPPPPP: ; 1F:026A, 0x03E26A
    .db 18
    .db 08
    .db 00
    .db 40
    .db 0E
QQQQQQ: ; 1F:026F, 0x03E26F
    .db 18
    .db 18
    .db 00
    .db 20
    .db 0E
RRRRRR: ; 1F:0274, 0x03E274
    .db 14
    .db 14
    .db 00
    .db 18
    .db 0E
SSSSSS: ; 1F:0279, 0x03E279
    .db 0C
    .db 0C
    .db 00
    .db 30
    .db 0E
TTTTTT: ; 1F:027E, 0x03E27E
    .db 10
    .db 10
    .db 00
    .db 30
    .db 0E
UUUUUU: ; 1F:0283, 0x03E283
    .db 14
    .db 0C
    .db 00
    .db 18
    .db 0E
VVVVVV: ; 1F:0288, 0x03E288
    .db 08
    .db 08
    .db 00
    .db 20
    .db 0E
WWWWWW: ; 1F:028D, 0x03E28D
    .db 06
    .db 06
    .db 00
    .db 20
    .db 0E
XXXXXX: ; 1F:0292, 0x03E292
    .db 10
    .db 10
    .db 00
    .db 40
    .db 0E
DATA_PTRS_NEGATIVE_L: ; 1F:0297, 0x03E297
    LOW(AAA)
DATA_PTRS_NEGATIVE_H: ; 1F:0298, 0x03E298
    HIGH(AAA)
    LOW(BBB)
    HIGH(BBB)
    LOW(CCC)
    HIGH(CCC)
    LOW(DDD)
    HIGH(DDD)
    LOW(EEE)
    HIGH(EEE)
    LOW(FFF)
    HIGH(FFF)
    LOW(GGG)
    HIGH(GGG)
    LOW(HHH)
    HIGH(HHH)
    LOW(III)
    HIGH(III)
    LOW(JJJ)
    HIGH(JJJ)
    LOW(KKK)
    HIGH(KKK)
    LOW(CC)
    HIGH(CC)
    LOW(LLL)
    HIGH(LLL)
    LOW(MMM)
    HIGH(MMM)
    LOW(NNN)
    HIGH(NNN)
    LOW(OOO)
    HIGH(OOO)
    LOW(PPP)
    HIGH(PPP)
    LOW(QQQ)
    HIGH(QQQ)
    LOW(RRR)
    HIGH(RRR)
    LOW(SSS)
    HIGH(SSS)
    LOW(TTT)
    HIGH(TTT)
    LOW(UUU)
    HIGH(UUU)
    LOW(VVV)
    HIGH(VVV)
    LOW(WWW)
    HIGH(WWW)
    LOW(XXX)
    HIGH(XXX)
    LOW(YYY)
    HIGH(YYY)
    LOW(ZZZ)
    HIGH(ZZZ)
    LOW(AAAA)
    HIGH(AAAA)
    LOW(BBBB)
    HIGH(BBBB)
    LOW(CCCC)
    HIGH(CCCC)
    LOW(DDDD)
    HIGH(DDDD)
    LOW(EEEE)
    HIGH(EEEE)
    LOW(FFFF)
    HIGH(FFFF)
    LOW(GGGG)
    HIGH(GGGG)
    LOW(HHHH)
    HIGH(HHHH)
    LOW(IIII)
    HIGH(IIII)
    LOW(JJJJ)
    HIGH(JJJJ)
    LOW(KKKK)
    HIGH(KKKK)
    LOW(LLLL)
    HIGH(LLLL)
    LOW(MMMM)
    HIGH(MMMM)
    LOW(NNNN)
    HIGH(NNNN)
    LOW(OOOO)
    HIGH(OOOO)
    LOW(PPPP)
    HIGH(PPPP)
    LOW(QQQQ)
    HIGH(QQQQ)
    LOW(RRRR)
    HIGH(RRRR)
    LOW(SSSS)
    HIGH(SSSS)
    LOW(TTTT)
    HIGH(TTTT)
    LOW(DD)
    HIGH(DD)
    LOW(UUUU)
    HIGH(UUUU)
    LOW(VVVV)
    HIGH(VVVV)
    LOW(WWWW)
    HIGH(WWWW)
    LOW(XXXX)
    HIGH(XXXX)
    LOW(YYYY)
    HIGH(YYYY)
    LOW(ZZZZ)
    HIGH(ZZZZ)
    LOW(AAAAA)
    HIGH(AAAAA)
    LOW(BBBBB)
    HIGH(BBBBB)
    LOW(CCCCC)
    HIGH(CCCCC)
    LOW(DDDDD)
    HIGH(DDDDD)
    LOW(EEEEE)
    HIGH(EEEEE)
    LOW(FFFFF)
    HIGH(FFFFF)
    LOW(GGGGG)
    HIGH(GGGGG)
    LOW(HHHHHH)
    HIGH(HHHHHH)
    LOW(IIIII)
    HIGH(IIIII)
    LOW(JJJJJ)
    HIGH(JJJJJ)
    LOW(KKKKK)
    HIGH(KKKKK)
    LOW(LLLLL)
    HIGH(LLLLL)
    LOW(MMMMM)
    HIGH(MMMMM)
    LOW(NNNNN)
    HIGH(NNNNN)
    LOW(OOOOO)
    HIGH(OOOOO)
    LOW(PPPPP)
    HIGH(PPPPP)
    LOW(QQQQQ)
    HIGH(QQQQQ)
AAA: ; 1F:0325, 0x03E325
    .db 04
    .db 38
    .db F8
    .db 10
    .db 0E
    .db 00
    .db 10
BBB: ; 1F:032C, 0x03E32C
    .db 00
    .db 18
    .db F0
    .db 18
    .db 0E
    .db 01
    .db 41
CCC: ; 1F:0333, 0x03E333
    .db 08
    .db 10
    .db 00
    .db 22
    .db 0E
    .db 01
    .db 41
DDD: ; 1F:033A, 0x03E33A
    .db 02
    .db 02
    .db 02
    .db 02
    .db 0E
    .db 83
    .db 41
EEE: ; 1F:0341, 0x03E341
    .db 05
    .db 05
    .db 00
    .db 10
    .db 0E
    .db 01
    .db 01
FFF: ; 1F:0348, 0x03E348
    .db 04
    .db 38
    .db F4
    .db 10
    .db 0E
    .db 00
    .db 11
GGG: ; 1F:034F, 0x03E34F
    .db 08
    .db 08
    .db 06
    .db 04
    .db 0E
    .db 00
    .db 41
HHH: ; 1F:0356, 0x03E356
    .db 10
    .db 10
    .db 00
    .db 20
    .db 10
    .db 00
    .db 48
III: ; 1F:035D, 0x03E35D
    .db 08
    .db 08
    .db 00
    .db 10
    .db 0E
    .db 02
    .db 21
JJJ: ; 1F:0364, 0x03E364
    .db 08
    .db 08
    .db 00
    .db 10
    .db 0E
    .db 89
    .db 44
KKK: ; 1F:036B, 0x03E36B
    .db 18
    .db 18
    .db 00
    .db 20
    .db 0E
    .db 8A
    .db 44
CC: ; 1F:0372, 0x03E372
    .db 18
    .db 18
    .db 10
    .db 10
    .db 16
    .db 8B
    .db 44
LLL: ; 1F:0379, 0x03E379
    .db 10
    .db 20
    .db 00
    .db 20
    .db 0E
    .db 03
    .db 44
MMM: ; 1F:0380, 0x03E380
    .db 00
    .db 20
    .db F0
    .db 20
    .db 0E
    .db 03
    .db 44
NNN: ; 1F:0387, 0x03E387
    .db 00
    .db 1C
    .db 00
    .db 10
    .db 0E
    .db 04
    .db 44
OOO: ; 1F:038E, 0x03E38E
    .db 00
    .db 1C
    .db 00
    .db 20
    .db 0E
    .db 04
    .db 44
PPP: ; 1F:0395, 0x03E395
    .db 00
    .db 20
    .db 00
    .db 20
    .db 0E
    .db 90
    .db 44
QQQ: ; 1F:039C, 0x03E39C
    .db 20
    .db 20
    .db 00
    .db 30
    .db 0E
    .db 91
    .db 44
RRR: ; 1F:03A3, 0x03E3A3
    .db 30
    .db 18
    .db 18
    .db 08
    .db 0E
    .db 92
    .db 44
SSS: ; 1F:03AA, 0x03E3AA
    .db 04
    .db 04
    .db 04
    .db 04
    .db 0E
    .db 93
    .db 42
TTT: ; 1F:03B1, 0x03E3B1
    .db 00
    .db 20
    .db 00
    .db 30
    .db 0E
    .db 94
    .db 44
UUU: ; 1F:03B8, 0x03E3B8
    .db 05
    .db 05
    .db 05
    .db 05
    .db 0E
    .db 95
    .db A4
VVV: ; 1F:03BF, 0x03E3BF
    .db 04
    .db 04
    .db 06
    .db 04
    .db 0E
    .db 03
    .db 41
WWW: ; 1F:03C6, 0x03E3C6
    .db 00
    .db 20
    .db 00
    .db 18
    .db 0E
    .db 97
    .db 44
XXX: ; 1F:03CD, 0x03E3CD
    .db 03
    .db 03
    .db 03
    .db 03
    .db 0E
    .db 98
    .db 44
YYY: ; 1F:03D4, 0x03E3D4
    .db 04
    .db 24
    .db E0
    .db 38
    .db 0E
    .db 03
    .db 44
ZZZ: ; 1F:03DB, 0x03E3DB
    .db 05
    .db 05
    .db 05
    .db 05
    .db 0E
    .db 03
    .db 42
AAAA: ; 1F:03E2, 0x03E3E2
    .db 05
    .db 05
    .db 07
    .db 07
    .db 0E
    .db 03
    .db 42
BBBB: ; 1F:03E9, 0x03E3E9
    .db 05
    .db 05
    .db 0A
    .db 0A
    .db 0E
    .db 03
    .db 42
CCCC: ; 1F:03F0, 0x03E3F0
    .db 06
    .db 06
    .db 10
    .db 10
    .db 0E
    .db 03
    .db 42
DDDD: ; 1F:03F7, 0x03E3F7
    .db 05
    .db 05
    .db 05
    .db 05
    .db 0E
    .db 9E
    .db 44
EEEE: ; 1F:03FE, 0x03E3FE
    .db 03
    .db 20
    .db 00
    .db 30
    .db 0E
    .db 09
    .db 84
FFFF: ; 1F:0405, 0x03E405
    .db 03
    .db 03
    .db 03
    .db 03
    .db 0E
    .db A0
    .db 42
GGGG: ; 1F:040C, 0x03E40C
    .db 06
    .db 06
    .db 06
    .db 06
    .db 0E
    .db A1
    .db 70
HHHH: ; 1F:0413, 0x03E413
    .db 02
    .db 02
    .db 00
    .db 06
    .db 0E
    .db A2
    .db 44
IIII: ; 1F:041A, 0x03E41A
    .db 00
    .db 30
    .db E8
    .db 48
    .db 0E
    .db A3
    .db 31
JJJJ: ; 1F:0421, 0x03E421
    .db 08
    .db 08
    .db 70
    .db 00
    .db 0E
    .db A4
    .db 44
KKKK: ; 1F:0428, 0x03E428
    .db 03
    .db 03
    .db 03
    .db 03
    .db 0E
    .db A5
    .db 42
LLLL: ; 1F:042F, 0x03E42F
    .db 20
    .db 00
    .db 00
    .db 30
    .db 0E
    .db A6
    .db 44
MMMM: ; 1F:0436, 0x03E436
    .db 00
    .db 20
    .db E0
    .db 28
    .db 0E
    .db 0F
    .db 44
NNNN: ; 1F:043D, 0x03E43D
    .db 00
    .db 30
    .db 00
    .db 28
    .db 0E
    .db 0F
    .db 44
OOOO: ; 1F:0444, 0x03E444
    .db 1C
    .db 1C
    .db 1C
    .db 1C
    .db 18
    .db A9
    .db 48
PPPP: ; 1F:044B, 0x03E44B
    .db 04
    .db 04
    .db FC
    .db 0C
    .db 0E
    .db AA
    .db 42
QQQQ: ; 1F:0452, 0x03E452
    .db 08
    .db 08
    .db FE
    .db 0E
    .db 0E
    .db AB
    .db 42
RRRR: ; 1F:0459, 0x03E459
    .db 04
    .db 04
    .db FC
    .db 0C
    .db 0E
    .db AC
    .db 44
SSSS: ; 1F:0460, 0x03E460
    .db 00
    .db 28
    .db 00
    .db 10
    .db 0E
    .db 01
    .db 44
TTTT: ; 1F:0467, 0x03E467
    .db 00
    .db 0C
    .db F0
    .db 20
    .db 0E
    .db 01
    .db 44
DD: ; 1F:046E, 0x03E46E
    .db 18
    .db 18
    .db 10
    .db 10
    .db 0E
    .db AF
    .db 46
UUUU: ; 1F:0475, 0x03E475
    .db 10
    .db 10
    .db 00
    .db 20
    .db 10
    .db B0
    .db 48
VVVV: ; 1F:047C, 0x03E47C
    .db 0E
    .db 0E
    .db 04
    .db 04
    .db 0A
    .db B1
    .db 46
WWWW: ; 1F:0483, 0x03E483
    .db 04
    .db 04
    .db 00
    .db 08
    .db 0E
    .db B2
    .db 46
XXXX: ; 1F:048A, 0x03E48A
    .db 04
    .db 04
    .db 00
    .db 10
    .db 0E
    .db B3
    .db 46
YYYY: ; 1F:0491, 0x03E491
    .db 04
    .db 04
    .db 00
    .db 20
    .db 0E
    .db B4
    .db 46
ZZZZ: ; 1F:0498, 0x03E498
    .db 04
    .db 04
    .db 00
    .db 30
    .db 0E
    .db B5
    .db 46
AAAAA: ; 1F:049F, 0x03E49F
    .db 04
    .db 04
    .db 00
    .db 40
    .db 0E
    .db B6
    .db 46
BBBBB: ; 1F:04A6, 0x03E4A6
    .db 18
    .db 1C
    .db 00
    .db 1C
    .db 0E
    .db 11
    .db 44
CCCCC: ; 1F:04AD, 0x03E4AD
    .db 00
    .db 18
    .db F0
    .db 20
    .db 0E
    .db 12
    .db 41
DDDDD: ; 1F:04B4, 0x03E4B4
    .db 04
    .db 04
    .db 04
    .db 04
    .db 0E
    .db B9
    .db 41
EEEEE: ; 1F:04BB, 0x03E4BB
    .db 18
    .db 18
    .db 00
    .db 1C
    .db 0E
    .db 11
    .db 42
FFFFF: ; 1F:04C2, 0x03E4C2
    .db 01
    .db 01
    .db 01
    .db 01
    .db 0E
    .db BB
    .db 44
GGGGG: ; 1F:04C9, 0x03E4C9
    .db 00
    .db 40
    .db 00
    .db 20
    .db 0E
    .db 13
    .db 44
HHHHHH: ; 1F:04D0, 0x03E4D0
    .db 08
    .db 08
    .db 10
    .db 20
    .db 0E
    .db 14
    .db 42
IIIII: ; 1F:04D7, 0x03E4D7
    .db 08
    .db 20
    .db 10
    .db 20
    .db 0E
    .db 14
    .db 42
JJJJJ: ; 1F:04DE, 0x03E4DE
    .db 08
    .db 08
    .db FA
    .db 0A
    .db 0E
    .db BF
    .db 43
KKKKK: ; 1F:04E5, 0x03E4E5
    .db 0E
    .db 0E
    .db 00
    .db 1C
    .db 0E
    .db C0
    .db 44
LLLLL: ; 1F:04EC, 0x03E4EC
    .db 01
    .db 01
    .db 01
    .db 01
    .db 0E
    .db C1
    .db 41
MMMMM: ; 1F:04F3, 0x03E4F3
    .db 04
    .db 04
    .db 00
    .db 02
    .db 0E
    .db 15
    .db 44
NNNNN: ; 1F:04FA, 0x03E4FA
    .db 00
    .db 24
    .db 10
    .db 20
    .db 10
    .db 17
    .db 44
OOOOO: ; 1F:0501, 0x03E501
    .db 18
    .db 18
    .db 00
    .db 30
    .db 0E
    .db C4
    .db 48
PPPPP: ; 1F:0508, 0x03E508
    .db 10
    .db 10
    .db 10
    .db 10
    .db 10
    .db C5
    .db 48
QQQQQ: ; 1F:050F, 0x03E50F
    .db 14
    .db 14
    .db 14
    .db 14
    .db 0E
    .db C6
    .db 46
DPTRS_UNK_L: ; 1F:0516, 0x03E516
    LOW(AA)
DPTRS_UNK_H: ; 1F:0517, 0x03E517
    HIGH(AA)
    LOW(AA)
    HIGH(AA)
    LOW(AA)
    HIGH(AA)
    LOW(BB)
    HIGH(BB)
    LOW(CC)
    HIGH(CC)
    LOW(DD)
    HIGH(DD)
AA: ; 1F:0522, 0x03E522
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
BB: ; 1F:0536, 0x03E536
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
PTR_UNK_L: ; 1F:054A, 0x03E54A
    LOW(A)
PTR_UNK_H: ; 1F:054B, 0x03E54B
    HIGH(A)
    LOW(A)
    HIGH(A)
    LOW(B)
    HIGH(B)
    LOW(B)
    HIGH(B)
    LOW(C)
    HIGH(C)
    LOW(C)
    HIGH(C)
    LOW(D)
    HIGH(D)
    LOW(D)
    HIGH(D)
    LOW(E)
    HIGH(E)
    LOW(E)
    HIGH(E)
    LOW(F)
    HIGH(F)
    LOW(F)
    HIGH(F)
    LOW(G)
    HIGH(G)
    LOW(G)
    HIGH(G)
    LOW(H)
    HIGH(H)
    LOW(H)
    HIGH(H)
    LOW(H)
    HIGH(H)
    LOW(H)
    HIGH(H)
    LOW(I)
    HIGH(I)
    LOW(I)
    HIGH(I)
    LOW(B)
    HIGH(B)
    LOW(B)
    HIGH(B)
    LOW(J)
    HIGH(J)
    LOW(J)
    HIGH(J)
    LOW(K)
    HIGH(K)
    LOW(K)
    HIGH(K)
    LOW(L)
    HIGH(L)
    LOW(L)
    HIGH(L)
    LOW(M)
    HIGH(M)
    LOW(M)
    HIGH(M)
    LOW(N)
    HIGH(N)
    LOW(B)
    HIGH(B)
    LOW(O)
    HIGH(O)
    LOW(O)
    HIGH(O)
    LOW(P)
    HIGH(P)
    LOW(P)
    HIGH(P)
    LOW(Q)
    HIGH(Q)
    LOW(Q)
    HIGH(Q)
    LOW(Q)
    HIGH(Q)
    LOW(Q)
    HIGH(Q)
    LOW(R)
    HIGH(R)
    LOW(R)
    HIGH(R)
    LOW(S)
    HIGH(S)
    LOW(S)
    HIGH(S)
    LOW(T)
    HIGH(T)
    LOW(T)
    HIGH(T)
    LOW(B)
    HIGH(B)
    LOW(B)
    HIGH(B)
B: ; 1F:05AA, 0x03E5AA
    .db FF
    .db 00
A: ; 1F:05AC, 0x03E5AC
    .db BF
    .db 01
    .db FA
    .db 03
    .db FD
    .db 03
D: ; 1F:05B2, 0x03E5B2
    .db CF
    .db 01
    .db F9
    .db 03
    .db FB
    .db 01
    .db FD
    .db 03
E: ; 1F:05BA, 0x03E5BA
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
F: ; 1F:05C4, 0x03E5C4
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
G: ; 1F:05D2, 0x03E5D2
    .db A8
    .db 01
    .db F4
    .db 03
    .db F7
    .db 01
    .db FD
    .db 03
C: ; 1F:05DA, 0x03E5DA
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
H: ; 1F:05E6, 0x03E5E6
    .db ED
    .db 01
    .db FD
    .db 03
I: ; 1F:05EA, 0x03E5EA
    .db 59
    .db 01
    .db FD
    .db 03
N: ; 1F:05EE, 0x03E5EE
    .db 47
    .db 01
    .db 7F
    .db 03
J: ; 1F:05F2, 0x03E5F2
    .db D9
    .db 01
    .db F6
    .db 03
    .db FC
    .db 05
    .db FD
    .db 03
K: ; 1F:05FA, 0x03E5FA
    .db D9
    .db 01
    .db F6
    .db 03
    .db FB
    .db 05
    .db FD
    .db 03
L: ; 1F:0602, 0x03E602
    .db D4
    .db 01
    .db FC
    .db 03
    .db FD
    .db 03
O: ; 1F:0608, 0x03E608
    .db C2
    .db 01
    .db D8
    .db 03
    .db DF
    .db 01
    .db FD
    .db 03
P: ; 1F:0610, 0x03E610
    .db C8
    .db 01
    .db F8
    .db 03
    .db FD
    .db 03
M: ; 1F:0616, 0x03E616
    .db 8F
    .db 01
    .db D8
    .db 03
    .db DF
    .db 01
    .db FD
    .db 03
S: ; 1F:061E, 0x03E61E
    .db BF
    .db 01
    .db FF
    .db 03
T: ; 1F:0622, 0x03E622
    .db 3F
    .db 01
    .db FF
    .db 03
Q: ; 1F:0626, 0x03E626
    .db 9C
    .db 01
    .db FF
    .db 03
R: ; 1F:062A, 0x03E62A
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
    LDA LEVEL/SCREEN_ON ; Load
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
    LDA OBJ_POS_Y_CONFIRMED[18],X ; Load obj val.
    LDY 8E_UNK ; Y from.
    BPL 8E_VAL_POSITIVE ; If positive, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$09 ; Keep 0000.1001.
    BEQ NONE_SET ; If none set, goto.
    LDY TMP_08 ; Get player focus.
    LDA A0_PLAYER_UNK[2],Y ; Load
    CLC
    ADC OBJ_POS_X??[18],X ; += Obj.
    JMP 8E_VAL_POSITIVE ; Goto.
NONE_SET: ; 1F:0662, 0x03E662
    LDA OBJ_POS_X??[18],X ; Load val.
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
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add val.
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
    LDA LEVEL/SCREEN_ON
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
    SBC 4C6_OBJ_UNK[18],X
    LSR A
    STA 8E_UNK
    LDA #$00
    SEC
    SBC 8E_UNK
    CLC
    ADC OBJ_POS_X??[18],X
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
    ADC OBJ_POS_X_CONFIRMED[18],X
    TAY
    PLA
    JSR RTN_SCREEN?_UNK
    LDY TMP_08
    LDA 8C_UNK
    CMP #$01
    BEQ 1F:079A
    CMP #$05
    BNE 1F:078F
    LDA 4C6_OBJ_UNK[18],X
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
    LDA LEVEL/SCREEN_ON ; Load
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
    ADC SCRIPT_SCROLL_X?[2] ; += Var.
    STA 8D_UNK ; Store to.
    PHA ; Save A.
    LDA SCRIPT_NAMETABLE_FOCUS_VAL?[2] ; Load 
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
    BEQ RTS_A_TO_8C ; RTS, store 0.
OBJ_RTN_UNK_RET_VAL_UNK: ; 1F:0811, 0x03E811
    STX TMP_08 ; TMP_XOBJ. TODO: I have a feeling this is hit related?
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load obj update flags.
    AND #$03 ; Keep 0000.0011
    BEQ CONTINUE_A ; If not set, goto next.
    LDA #$00
    STA TMP_0C ; Clear these.
    STA TMP_0D
    LDX TMP_08 ; Load X again even though it isn't needed.
    RTS ; Leave.
CONTINUE_A: ; 1F:0823, 0x03E823
    LDY #$02 ; Val? OBJ#?
    STY TMP_0B ; Seed TMP.
    LDX #$04 ; Val? OBJ#?
    STX TMP_09 ; Seed TMP.
LOOP_PLAYER_OBJS: ; 1F:082B, 0x03E82B
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load anim.
    BEQ ANIM_MOD_SKIP
    JSR POS_RTN_UNK ; Do.
    BNE RTS_XOBJ_RESTORE ; If return nonzero, leave with restore.
ANIM_MOD_SKIP: ; 1F:0835, 0x03E835
    INC TMP_0B ; Shift focus to other set, doing both players and their pairs.
    INC TMP_09 ; Shift
    LDY TMP_0B
    LDX TMP_09
    CPX #$07 ; If TMP_09 OBJ# _ 7
    BCC LOOP_PLAYER_OBJS ; <, goto. 4 .. 6
    LDY #$00 ; P1 Index
    LDX #$00 ; P1 Data
    LDA NUM_PLAYER_LIVES[2] ; Load lives.
    BPL P1_HAS_LIVES ; Positive.
    LDA #$00
    BEQ SKIP_P1_RTN ; Clear if negative.
P1_HAS_LIVES: ; 1F:084D, 0x03E84D
    JSR POS_RTN_UNK ; Do.
SKIP_P1_RTN: ; 1F:0850, 0x03E850
    STA TMP_0C ; Store result.
    LDA TWO_PLAYERS_FLAG ; Load
    BEQ SINGLE_PLAYER_ONLY ; Zero, goto.
    LDY #$01 ; P2 index.
    LDX #$02 ; P2 Data.
    LDA NUM_PLAYER_LIVES+1 ; Load P2 lives.
    BPL P2_HAS_LIVES ; Has lives.
    LDA #$00
    BEQ SINGLE_PLAYER_ONLY
P2_HAS_LIVES: ; 1F:0862, 0x03E862
    JSR POS_RTN_UNK
SINGLE_PLAYER_ONLY: ; 1F:0865, 0x03E865
    STA TMP_0D ; Store result.
    LDA TMP_0C ; Load P1 result.
    ORA TMP_0D ; Combine with P2 result.
RTS_XOBJ_RESTORE: ; 1F:086B, 0x03E86B
    LDX TMP_08 ; Restore Xobj.
    RTS ; Leave with A return.
POS_RTN_UNK: ; 1F:086E, 0x03E86E
    STY TMP_0B ; Y to. Lower OBJ #.
    STX TMP_09 ; X to. Higher OBJ #.
    LDX TMP_08 ; X from original RTN.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BPL EXTRA_POSITIVE ; If positive, goto.
    ASL A ; << 1, *2. Word index.
    TAY
    LDA DATA_PTRS_NEGATIVE_L,Y ; Set up file for ptr.
    STA FILE_PLAYER_OBJ_USE_A[2]
    LDA DATA_PTRS_NEGATIVE_H,Y
    STA FILE_PLAYER_OBJ_USE_A+1
    LDY #$05 ; Index file.
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load from.
    BMI NEGATIVE_INDEX_FILE[5]_NEGATIVE ; If negative, don't load other.
EXTRA_POSITIVE: ; 1F:088B, 0x03E88B
    ASL A ; << 1, *2. Word index.
    TAY ; To Y index.
    LDA FILE_PTRS_POSITIVE_L,Y ; Set up file for ptr.
    STA FILE_PLAYER_OBJ_USE_B[2]
    LDA FILE_PTRS_POSITIVE_H,Y
    STA FILE_PLAYER_OBJ_USE_B+1
NEGATIVE_INDEX_FILE[5]_NEGATIVE: ; 1F:0897, 0x03E897
    LDX TMP_09 ; X from TMP, higher.
    CPX #$04 ; If _ #$04
    BCS HIGHER_GTE_4 ; >=, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary
    AND #$02 ; Keep 0000.0010
    BEQ GOTO_RTN_WAY_OUT ; == 0, goto.
HIGHER_GTE_4: ; 1F:08A4, 0x03E8A4
    LDY TMP_08 ; Y from TMP. XOBJ original from OBJ handler.
    LDA OBJ_POS_X_CONFIRMED[18],X
    CMP OBJ_POS_X_CONFIRMED[18],Y ; If XHigher.Xpos _ XOriginal.Xpos
    BCC SKIP_UNK_B ; <, goto.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load dir
    AND #$40 ; Keep only 0100.0000
    BNE CONTINUE_B ; If set, goto.
GOTO_RTN_WAY_OUT: ; 1F:08B5, 0x03E8B5
    JMP RTN_UNK ; Goto.
SKIP_UNK_B: ; 1F:08B8, 0x03E8B8
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$40 ; Test bit 0x40
    BNE GOTO_RTN_WAY_OUT ; If set, goto.
CONTINUE_B: ; 1F:08BF, 0x03E8BF
    LDX TMP_08 ; Get original Xobj.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load from
    BPL FILE_B_USE ; If positive, alternate file.
    LDY #$05 ; File index.
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load from file A.
    BPL FILE_B_USE ; If positive, alternate file.
    LDY #$00 ; Set index.
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Move data.
    STA TMP_00
    INY
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y
    STA TMP_01
    INY
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y
    STA TMP_02
    INY
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y
    STA TMP_03
    INY
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y
    STA TMP_0A
    JMP CONTINUE_C ; Skip alt.
FILE_B_USE: ; 1F:08E9, 0x03E8E9
    LDY #$00 ; Set index.
    LDA [FILE_PLAYER_OBJ_USE_B[2]],Y ; Move data.
    STA TMP_00
    INY
    LDA [FILE_PLAYER_OBJ_USE_B[2]],Y
    STA TMP_01
    INY
    LDA [FILE_PLAYER_OBJ_USE_B[2]],Y
    STA TMP_02
    INY
    LDA [FILE_PLAYER_OBJ_USE_B[2]],Y
    STA TMP_03
    INY
    LDA [FILE_PLAYER_OBJ_USE_B[2]],Y
    STA TMP_0A
CONTINUE_C: ; 1F:0903, 0x03E903
    CLC ; Prep add
    LDA 4C6_OBJ_UNK[18],X ; Load OBJ.
    ADC TMP_02 ; Add with from file.
    BMI ADD_F[2]_NEGATIVE ; If negative, goto.
    LDA #$FF ; Seed val.
ADD_F[2]_NEGATIVE: ; 1F:090D, 0x03E90D
    STA TMP_02 ; Store to TMP.
    LDA 4C6_OBJ_UNK[18],X ; Load from obj.
    SEC ; Prep sub.
    SBC TMP_03 ; Subtract with from file.
    BMI SUB_F[3]_NEGATIVE
    LDA #$80 ; Seed val.
SUB_F[3]_NEGATIVE: ; 1F:0919, 0x03E919
    STA TMP_03 ; Store back.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$40 ; Test 0100.0000
    BEQ SKIP_SWAP
    LDA TMP_00 ; Load F[0]. This swaps TMP_00 and TMP_01
    PHA ; Save
    LDA TMP_01 ; Load F[1]
    STA TMP_00 ; Store.
    PLA ; Restore
    STA TMP_01 ; Store.
SKIP_SWAP: ; 1F:092C, 0x03E92C
    LDA TMP_00 ; Load
    CLC ; Prep add
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add with
    BCC ADD_NO_OVERFLOW
    LDA #$FC ; Overflow val.
ADD_NO_OVERFLOW: ; 1F:0936, 0x03E936
    STA TMP_00 ; Store to.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    SEC ; Prep sub.
    SBC TMP_01 ; Sub with.
    BCS SUB_NO_UNDERFLOW
    LDA #$04 ; Seed
SUB_NO_UNDERFLOW: ; 1F:0942, 0x03E942
    STA TMP_01 ; Store.
    LDA OBJ_POS_X??[18],X ; Load
    STA TMP_07 ; Store to TMP.
    JSR SUB_UNK_HIT_DETECT_CC_TRUE_CS_FALSE?
    BCS CS_RET ; CS ret, goto.
SWITCH_NEGATIVE: ; 1F:094E, 0x03E94E
    JMP RTN_UNK ; Do instead.
CS_RET: ; 1F:0951, 0x03E951
    LDY TMP_08 ; Y from.
    CPX #$04 ; If Xobj _ #$04
    BCC XOBJ_LT_0x04 ; <, goto.
    JMP HEALTH_AND_SCORE ; Goto if not.
XOBJ_LT_0x04: ; 1F:095A, 0x03E95A
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load switch.
    AND #$04 ; Test bit 0x04
    BEQ BIT_0x04_NOT_SET
    LDA #$00 ; Return 0x00.
    RTS
BIT_0x04_NOT_SET: ; 1F:0964, 0x03E964
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load 
    AND #$08 ; Test bit 0x80
    BNE BIT_0x80_SET ; If set, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$0B ; Keep 0000.1011
    CMP #$03 ; If _ #$03
    BNE SWITCH_&0x0B_NE_0x03 ; !=, goto.
BIT_0x80_SET: ; 1F:0974, 0x03E974
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load
    CMP #$03 ; If _ #$03
    BNE SWITCH_&0x0B_NE_0x03 ; !=, goto.
    LDA OBJECT_DATA_EXTRA_B?[18],Y ; Load
    BMI SWITCH_NEGATIVE ; If negative, goto.
SWITCH_&0x0B_NE_0x03: ; 1F:0980, 0x03E980
    LDA OBJECT_DATA_EXTRA_B?[18],Y ; Load
    CMP #$8B ; If _ #$8B
    BEQ EQ_8B ; ==, goto.
    CMP #$AF ; If _ #$AF
    BEQ EQ_AF ; ==, goto.
    JMP RTN_UNK
EQ_AF: ; 1F:098E, 0x03E98E
    STA TMP_0E ; Store to TMP.
    LDA #$19
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP RTN_UNK
EQ_8B: ; 1F:0998, 0x03E998
    STA TMP_0E ; Store to TMP.
    LDA #$2C
    JSR SND_BANKED_DISPATCH ; Play sound.
RTN_UNK: ; 1F:099F, 0x03E99F
    LDX #$04 ; Obj #
LOOP_OBJS: ; 1F:09A1, 0x03E9A1
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Get disp.
    BEQ COPY_FROM_YOBJ_TO_XOBJ ; == 0, goto.
    INX ; Obj++
    CPX #$07 ; If _ #$07
    BCC LOOP_OBJS ; <, goto.
    LDX TMP_09 ; Xobj from.
    JMP RTN_UNK ; Do instead.
COPY_FROM_YOBJ_TO_XOBJ: ; 1F:09B0, 0x03E9B0
    LDA OBJ_ANIMATION_DISPLAY[18],Y ; Copy ObjY to ObjX
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA OBJ_SECONDARY_SWITCH?[18],Y
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA OBJ_ENABLED_STATE+MORE?[18],Y
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],Y
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    LDA OBJ_ANIM_HOLD_TIMER?[18],Y
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],Y
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA OBJ_POS_Y_CONFIRMED[18],Y
    STA OBJ_POS_Y_CONFIRMED[18],X
    LDA OBJ_POS_X_CONFIRMED[18],Y
    STA OBJ_POS_X_CONFIRMED[18],X
    LDA OBJ_POS_X_SUBPIXEL?[18],Y
    STA OBJ_POS_X_SUBPIXEL?[18],X
    LDA OBJ_POS_X??[18],Y
    STA OBJ_POS_X??[18],X
    LDA 4B4_OBJ_SPEED?[18],Y
    STA 4B4_OBJ_SPEED?[18],X
    LDA 4C6_OBJ_UNK[18],Y
    STA 4C6_OBJ_UNK[18],X
    LDA 4D8_OBJ_UNK[18],Y
    STA 4D8_OBJ_UNK[18],X
    LDA OBJ_POS_X_DELTA?[18],Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA 503_OBJ_POS_X_LARGEST?[18],Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    LDA 520_OBJ_POS_X_LARGE?[18],Y
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA 532_OBJ_UNK_POS_DELTA?[18],Y
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA 544_OBJ_UNK_POS_DELTA?[18],Y
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA 556_OBJ_STATUS_FLAGS_A[18],Y
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    LDA OBJECT_DATA_HEALTH?[18],Y
    STA OBJECT_DATA_HEALTH?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear this.
    LDA OBJ_TERTIARY_SWITCH?[18],Y
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],Y
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],Y
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA #$00 ; Load
    SEC ; Prep sub.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],Y ; Sub from Y.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; To X.
    LDA #$00
    SBC OBJ_POS_X_DELTA?[18],Y ; Sub from Y.
    STA OBJ_POS_X_DELTA?[18],X ; To X.
    LDA TMP_0E ; Load
    CMP #$8B ; If _ #$8B
    BEQ VAL_USE_0x04 ; ==, goto.
    LDA #$05
    BNE ALT_VAL ; Always taken.
VAL_USE_0x04: ; 1F:0A6C, 0x03EA6C
    LDA #$04
ALT_VAL: ; 1F:0A6E, 0x03EA6E
    DEX ; X-=2
    DEX
    STA TURTLE_SELECTION[2],X ; Store val to.
    TYA ; Y to A
    TAX ; A to X.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init Xobj.
    LDA #$00 ; Return 0x00.
    RTS ; Leave.
RTN_UNK: ; 1F:0A7A, 0x03EA7A
    LDA 70E_OBJ_UNK ; Load
    BNE RTN_UNK ; If != 0, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Load
    CMP #$04 ; If _ #$04
    BEQ RTN_UNK ; ==, goto.
    LDA OBJECT_DATA_HEALTH?[18],Y ; Load
    CMP #$FF ; If _ #$FF
    BEQ RTN_UNK ; ==, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$01 ; Keep 0x01
    BEQ BIT_0x01_CLEAR ; Bit 0x01 clear, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$08 ; Keep 0x08
    BEQ BIT_0x08_CLEAR ; Clear, goto.
    LDA #$04 ; Val
    BNE VAL_PICKED ; Always taken.
BIT_0x08_CLEAR: ; 1F:0A9F, 0x03EA9F
    LDA #$03 ; Val
    BNE VAL_PICKED
BIT_0x01_CLEAR: ; 1F:0AA3, 0x03EAA3
    LDA #$02 ; Val
VAL_PICKED: ; 1F:0AA5, 0x03EAA5
    STA TMP_0E ; Store damage.
    LDA 6D6_OBJ_UNK ; Load
    BNE HEALTH_AND_SCORE ; != 0, goto.
    LDA OBJECT_DATA_HEALTH?[18],Y ; Load Yobj
    SEC ; Prep sub.
    SBC TMP_0E ; Subtract from.
    BCS HEALTH_STORE
HEALTH_AND_SCORE: ; 1F:0AB4, 0x03EAB4
    LDA #$00 ; Min val.
HEALTH_STORE: ; 1F:0AB6, 0x03EAB6
    STA OBJECT_DATA_HEALTH?[18],Y ; Store health.
    BNE RTS_RET_0x01 ; Never taken?
    CPX #$03 ; If Xobj _ #$03
    BCS RTS_RET_0x01 ; >=, goto.
    TYA ; Yobj to A
    PHA ; Save
    LDY TMP_0B
    LDA #$01
    STA 3F6_PLAYER_SCORE_ADD_VALUE[2],Y ; Set to 0x01.
    JSR UPDATE_PLAY_SCORE_AND_DISPLAY ; Update score.
    PLA ; Restore Yobj.
    TAY
RTS_RET_0x01: ; 1F:0ACD, 0x03EACD
    LDA #$01 ; Return true.
    RTS
RTN_UNK: ; 1F:0AD0, 0x03EAD0
    CPX #$04 ; If Xobj _ #$04
    BCS RTS_ZERO ; >=, goto.
    LDX TMP_08 ; Load original object.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load from obj.
    BPL RTS_ZERO ; If positive, leave.
    LDY #$00 ; File index.
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load from file.
    STA TMP_00 ; Store to.
    INY ; Stream++
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load
    STA TMP_01 ; Store to.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$40 ; Test bit 0x40
    BEQ DIR_BIT_CLEAR ; Clear, goto.
    LDA TMP_00 ; Swap TMP_00 and TMP_01
    PHA
    LDA TMP_01
    STA TMP_00
    PLA
    STA TMP_01
DIR_BIT_CLEAR: ; 1F:0AF7, 0x03EAF7
    LDA TMP_00 ; Load
    CLC ; Prep add
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add with obj.
    BCC DONT_SEED_ADD ; No overflow, skip seed.
    LDA #$FC ; Seed
DONT_SEED_ADD: ; 1F:0B01, 0x03EB01
    STA TMP_00 ; Store to.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    SEC ; Prep sub.
    SBC TMP_01 ; Sub with file.
    BCS DONT_SEED_SUB ; No underflow, skip seed.
    LDA #$04 ; Seed
DONT_SEED_SUB: ; 1F:0B0D, 0x03EB0D
    STA TMP_01 ; Store result.
    INY ; Stream++
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load from stream.
    CLC ; Prep add.
    ADC 4C6_OBJ_UNK[18],X ; Add with OBJ.
    BMI FILE_OBJ_ADD_NEGATIVE ; If negative, skip seed.
    LDA #$FF ; Seed
FILE_OBJ_ADD_NEGATIVE: ; 1F:0B1A, 0x03EB1A
    STA TMP_02 ; Store result.
    INY ; Stream++
    LDA 4C6_OBJ_UNK[18],X ; Load OBJ.
    SEC ; Prep sub.
    SBC [FILE_PLAYER_OBJ_USE_A[2]],Y ; Sub.
    BMI SKIP_SEED ; If negative, goto.
    LDA #$80 ; Seed
SKIP_SEED: ; 1F:0B27, 0x03EB27
    STA TMP_03 ; Store.
    INY ; Stream++
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load from file.
    STA TMP_0A ; Store to.
    LDA OBJ_POS_X??[18],X ; Load obj.
    STA TMP_07 ; Store to.
    LDX TMP_09 ; Load object higher.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Get data from.
    PHA ; Save
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear obj.
    JSR SUB_UNK_HIT_DETECT_CC_TRUE_CS_FALSE? ; Do sub.
    BCS RET_FALSE ; False.
    LDX TMP_09 ; Load obj higher.
    PLA ; Restore extra.
    STA OBJECT_DATA_EXTRA_B?[18],X
RTS_ZERO: ; 1F:0B49, 0x03EB49
    LDA #$00 ; Load zero.
    RTS ; Return.
RET_FALSE: ; 1F:0B4C, 0x03EB4C
    LDX TMP_09 ; Load higher OBJ.
    PLA ; Restore extra.
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDY TMP_08 ; Load OBJ.
    LDA OBJECT_DATA_EXTRA_B?[18],Y ; Get extra from.
    BPL RTS_ZERO ; If positive, leave.
    LDA OBJ_SECONDARY_SWITCH?[18],Y ; Get switch.
    CMP #$06 ; If _ #$06, state?
    BEQ RTS_ZERO ; ==, leave.
    LDY #$06 ; File index.
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Get from file.
    AND #$F0 ; Keep 1111.0000
    CMP #$70 ; If _ #$70
    BEQ FILE_EQ_0x70 ; ==, goto.
    CMP #$80 ; If _ #$80
    BEQ RTS_ZERO ; ==, leave.
    BNE NOT_SPECIALS ; Always taken.
FILE_EQ_0x70: ; 1F:0B70, 0x03EB70
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load switch
    AND #$0D ; Keep 0000.1101
    BNE RTS_ZERO ; If any set, leave.
    LDA #$3C
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDY TMP_0B ; Get obj.
    LDA #$01
    STA 662_PLAYER_UPDATE_UNK[2],Y ; Set.
    LDA #$5C
    JSR SND_BANKED_DISPATCH ; Set sound.
    LDA #$01 ; Return true.
    RTS ; Leave.
NOT_SPECIALS: ; 1F:0B8B, 0x03EB8B
    LDY TMP_0B ; Get lower object.
    LDA 93_PLAYER_UNK[2],Y ; Load from player.
    BNE RTS_ZERO ; If any set, leave.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Get switch
    AND #$04 ; Keep 0000.0100
    BNE RTS_ZERO ; If set, leave.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Set 0x04 bit.
    ORA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDY #$06 ; File index.
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load from file.
    AND #$0F ; Keep 0000.1111
    STA TMP_0E ; Store to TMP.
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load from file again.
    LSR A
    LSR A
    LSR A
    LSR A ; Shift 0xF0 to 0x0F
    STA OBJECT_DATA_EXTRA_B?[18],X ; Store to.
    CMP #$03 ; If _ #$03
    BCS UNK_GTE_0x03 ; >=, goto.
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    AND #$01 ; Keep 0x01
    BEQ BIT_0x01_CLEARED ; If 0, goto.
UNSET_0x04_SECONDARY: ; 1F:0BBD, 0x03EBBD
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$FB ; Keep 1111.1011
    STA OBJ_SECONDARY_SWITCH?[18],X ; Save
    JMP RTS_ZERO ; Leave zero.
BIT_0x01_CLEARED: ; 1F:0BC8, 0x03EBC8
    LDA TMP_08 ; Load
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to OBJ.
    TAY ; To index.
    LDA #$06
    STA OBJ_SECONDARY_SWITCH?[18],Y ; Set switches, Sec 0x06 Tert 0x00.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],Y
    JSR REMOVE_PLAYER?
    LDA #$FF ; Leave with 0xFF. Player killed?
    RTS
UNK_GTE_0x03: ; 1F:0BDE, 0x03EBDE
    CMP #$03 ; If OBJ.unk _ #$03
    BEQ EQ_0x03 ; ==, goto.
    CMP #$0A ; If OBJ.unk _ #$0A
    BNE NE_0x0A ; !=, goto.
EQ_0x03: ; 1F:0BE6, 0x03EBE6
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load
    AND #$01 ; Remove 0x01
    BNE UNSET_0x04_SECONDARY
NE_0x0A: ; 1F:0BED, 0x03EBED
    LDA TMP_08 ; Load
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to obj.
    LDA 6D6_OBJ_UNK ; Load
    BNE 6D6_HAS_VAL ; If value, goto.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    SEC ; Set sub.
    SBC TMP_0E ; Sub val.
    BCS WRITE_HEALTH
    LDA #$00 ; Val min.
WRITE_HEALTH: ; 1F:0C01, 0x03EC01
    STA OBJECT_DATA_HEALTH?[18],X ; Store new health.
    LDY TMP_0B ; Y from.
    LDA #$01
    STA 662_PLAYER_UPDATE_UNK[2],Y ; Set player to true.
6D6_HAS_VAL: ; 1F:0C0B, 0x03EC0B
    LDY TMP_0B ; Y from.
    LDA PLAYERS_UNK[2],Y ; Load
    CLC ; Prep add.
    ADC TMP_0E ; Add
    STA PLAYERS_UNK[2],Y ; Store back.
REMOVE_PLAYER?: ; 1F:0C16, 0x03EC16
    LDY TMP_0B ; Y from.
    LDA #$00 ; Clear
    STA 43_PLAYER_UNK[2],Y ; Player
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; And misc.
    STA OBJ_POS_X_DELTA?[18],X
    STA 520_OBJ_POS_X_LARGE?[18],X
    STA 503_OBJ_POS_X_LARGEST?[18],X
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    STA OBJ_POS_X_SUBPIXEL_DELTA?+1,X ; Clear pair.
    STA OBJ_POS_X_DELTA?+1,X
    STA 520_OBJ_POS_X_LARGE?+1,X
    STA 503_OBJ_POS_X_LARGEST?+1,X
    LDA #$02 ; Return val.
    RTS
SUB_UNK_HIT_DETECT_CC_TRUE_CS_FALSE?: ; 1F:0C3E, 0x03EC3E
    LDX TMP_09 ; Load higher. 9 higher, B lower.
    CPX #$04 ; If Obj # _ #$04
    BCC HIGHER_LT_0x04 ; <, goto.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BPL FILE_B_MOVE
    LDY #$05
    LDA [FILE_PLAYER_OBJ_USE_A[2]],Y ; Load FILE[5]
    BPL FILE_B_MOVE ; Positive, goto.
    LDA FILE_PLAYER_OBJ_USE_A[2] ; Move file ptr.
    STA TMP_04
    LDA FILE_PLAYER_OBJ_USE_A+1
    STA TMP_05
    JMP RTN_CONTINUE
FILE_B_MOVE: ; 1F:0C5A, 0x03EC5A
    LDA FILE_PLAYER_OBJ_USE_B[2] ; Move file ptr.
    STA TMP_04
    LDA FILE_PLAYER_OBJ_USE_B+1
    STA TMP_05
RTN_CONTINUE: ; 1F:0C62, 0x03EC62
    LDY #$00
    STY TMP_06 ; Clear, index.
    BEQ RTN_START_UNK ; Always taken.
HIGHER_LT_0x04: ; 1F:0C68, 0x03EC68
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load obj.
    ASL A ; << 2, *4. Data size.
    ASL A
    STA TMP_06 ; Store index.
    LDY TMP_0B ; Load lower OBJ?
    LDA TURTLE_SELECTION[2],Y ; Load, UNK. Not selection. $35
    ASL A ; >> 1, *2. Word size.
    TAY ; To Index.
    LDA DPTRS_UNK_L,Y ; Move file pointer into place.
    STA TMP_04
    LDA DPTRS_UNK_H,Y
    STA TMP_05
RTN_START_UNK: ; 1F:0C80, 0x03EC80
    LDA OBJ_POS_X??[18],X ; Load
    SEC ; Prep sub.
    SBC TMP_07 ; Sub with.
    BPL SUB_POSITIVE
    STA TMP_07 ; Store result.
    LDA #$00 ; Seed
    SEC ; Prep sub.
    SBC TMP_07 ; Get negative difference.
SUB_POSITIVE: ; 1F:0C8F, 0x03EC8F
    CMP TMP_0A ; If _ #$0A
    BCS RTS_CC ; >=, goto.
    LDY TMP_06 ; Get index.
    INY ; Move index.
    INY
    LDA [TMP_04],Y ; Load from file.
    CLC ; Prep add.
    ADC 4C6_OBJ_UNK[18],X ; Add with obj.
    BMI DONT_SEE_ADD
    LDA #$FF ; Seed if positive.
DONT_SEE_ADD: ; 1F:0CA1, 0x03ECA1
    CMP TMP_03 ; If value _ F[3]
    BCC RTS_CC ; <, goto.
    INY ; Pointer++
    LDA 4C6_OBJ_UNK[18],X ; Load from obj.
    SEC ; Prep sub.
    SBC [TMP_04],Y ; Subtract from file.
    BMI DONT_SEED_SUB ; If negative.
    CMP #$70 ; If result _ #$70
    BCS DONT_SEED_SUB ; <, goto.
    LDA #$FF ; Seed
DONT_SEED_SUB: ; 1F:0CB4, 0x03ECB4
    CMP TMP_02 ; If result _ F[2]
    BCS RTS_CC ; >=, goto.
    LDY TMP_06 ; Reload index.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load from OBJ.
    AND #$40 ; Test bit 0100.0000
    BEQ BIT_CLEAR
    INY ; Mod index.
BIT_CLEAR: ; 1F:0CC2, 0x03ECC2
    LDA [TMP_04],Y ; Load from file.
    CLC ; Prep add.
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add from OBJ.
    BCS ADD_OVERFLOW
    CMP TMP_01 ; If result _ #$01
    BCC RTS_CC ; <, goto.
ADD_OVERFLOW: ; 1F:0CCE, 0x03ECCE
    LDY TMP_06 ; Load index.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Get again.
    AND #$40 ; Test 0x40 again.
    BNE BIT_0x40_SET
    INY ; Next index if clear.
BIT_0x40_SET: ; 1F:0CD8, 0x03ECD8
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from OBJ.
    SEC ; Prep sub.
    SBC [TMP_04],Y ; Sub from file.
    BCC RTS_CS ; If underflow, leave.
    CMP TMP_00 ; If result _ TMP_00
    BCC RTS_CS ; If < , leave CS.
RTS_CC: ; 1F:0CE4, 0x03ECE4
    CLC ; Passed, carry clear.
    RTS
RTS_CS: ; 1F:0CE6, 0x03ECE6
    SEC ; Failed, carry set.
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
BACKGROUND_UPDATING_INTERFACE: ; 1F:0ED4, 0x03EED4
    STA TMP_00 ; Store loaded.
    TXA ; Save X.
    PHA
    TYA ; Save Y.
    PHA
    LDA TMP_00 ; Load
    BMI VAL_NEGATIVE ; Is taken at times.
    LDA #$24 ; Bank A. 0x04
    BNE BANK_SEEDED ; Always taken.
VAL_NEGATIVE: ; 1F:0EE2, 0x03EEE2
    LDA #$30 ; Bank B. 0x10
BANK_SEEDED: ; 1F:0EE4, 0x03EEE4
    JSR BANK_PAIRED ; Bank in.
    JSR RTN_CROSS_BANK ; Do
    JSR RESTORE_BANK_PAIRED ; Restore bank.
    PLA
    TAY
    PLA
    TAX
    RTS
RTN_SWITCH_UNK: ; 1F:0EF2, 0x03EEF2
    STA TMP_00 ; A to. Switch value in JSR.
    TXA ; Save X.
    PHA
    TYA ; Save Y.
    PHA
    JSR RTN_CROSS_BANK
    PLA ; Restore Y.
    TAY
    PLA ; Restore X.
    TAX
    RTS
RTN_CROSS_BANK: ; 1F:0F00, 0x03EF00
    LDA TMP_00 ; Load val.
    PHA ; Save.
    LDY 60A_CB_SWITCH_WHICH? ; Load
    BEQ 60A_EQ_ZERO ; == 0, goto.
    CMP 60A_CB_SWITCH_WHICH? ; If A _ var
    BNE RTS_WITH_FF ; !=, goto.
60A_EQ_ZERO: ; 1F:0F0D, 0x03EF0D
    LDA PLAYER?_UNK[2] ; Load val.
    BEQ UNK_OTHER ; ==, goto.
    LDA 87_CB_INDEX? ; Load
    BNE RTS_WITH_FF ; != 0, RTS.
    LDA #$FF
    STA 87_CB_INDEX? ; Set to 0xFF.
RTS_WITH_FF: ; 1F:0F19, 0x03EF19
    PLA ; Fix stack.
    LDA #$FF
    STA TMP_00 ; Set to 0xFF.
    RTS ; Leave.
UNK_OTHER: ; 1F:0F1F, 0x03EF1F
    LDA 87_CB_INDEX? ; Load
    CMP #$FF ; If _ #$FF
    BNE VAL_NOT_FF ; !=, goto.
    LDA #$00
    STA 87_CB_INDEX? ; Clear if not FF.
VAL_NOT_FF: ; 1F:0F29, 0x03EF29
    PLA ; Pull A.
    STA 60A_CB_SWITCH_WHICH? ; Store to.
    JSR SWITCH_RTN ; Do switch.
    LDA #$00
    STA TMP_00 ; Clear after switch.
    RTS ; RTS.
SWITCH_RTN: ; 1F:0F35, 0x03EF35
    JSR SWITCH_CODE_PTRS_PAST_JSR ; CB = Cross Bank.
    LOW(CB_A) ; 0x00
    HIGH(CB_A)
    LOW(CB_B) ; 0x01
    HIGH(CB_B)
    LOW(CB_C) ; 0x02
    HIGH(CB_C)
    LOW(CB_D) ; 0x03
    HIGH(CB_D)
    LOW(CB_E) ; 0x04
    HIGH(CB_E)
    LOW(CB_F) ; 0x05
    HIGH(CB_F)
    LOW(CB_G) ; 0x06
    HIGH(CB_G)
    LOW(CB_H) ; 0x07
    HIGH(CB_H)
    LOW(CB_I) ; 0x08
    HIGH(CB_I)
    LOW(CB_J) ; 0x09
    HIGH(CB_J)
    LOW(CB_J) ; 0x0A
    HIGH(CB_J)
    LOW(CB_J) ; 0x0B
    HIGH(CB_J)
    LOW(CB_K) ; 0x0C
    HIGH(CB_K)
    LOW(CB_K) ; 0x0D
    HIGH(CB_K)
    LOW(CB_K) ; 0x0E
    HIGH(CB_K)
    LOW(CB_K) ; 0x0F
    HIGH(CB_K)
    LOW(CB_K) ; 0x10
    HIGH(CB_K)
    LOW(CB_L) ; 0x11
    HIGH(CB_L)
    LOW(CB_M) ; 0x12
    HIGH(CB_M)
    LOW(CB_N) ; 0x13
    HIGH(CB_N)
    LOW(CB_M) ; 0x14
    HIGH(CB_M)
    LOW(CB_N) ; 0x15
    HIGH(CB_N)
    LOW(CB_O) ; 0x16
    HIGH(CB_O)
    LOW(CB_P) ; 0x17
    HIGH(CB_P)
    LOW(CB_P) ; 0x18
    HIGH(CB_P)
    LOW(CB_P) ; 0x19
    HIGH(CB_P)
    LOW(CB_P) ; 0x1A
    HIGH(CB_P)
    LOW(CB_P) ; 0x1B
    HIGH(CB_P)
    LOW(CB_Q) ; 0x1C
    HIGH(CB_Q)
    LOW(CB_Q) ; 0x1D
    HIGH(CB_Q)
    LOW(CB_R) ; 0x1E
    HIGH(CB_R)
    LOW(CB_S) ; 0x1F
    HIGH(CB_S)
    LOW(CB_S) ; 0x20
    HIGH(CB_S)
    LOW(CB_T) ; 0x21
    HIGH(CB_T)
    LOW(CB_T) ; 0x22
    HIGH(CB_T)
    LOW(CB_T) ; 0x23
    HIGH(CB_T)
    LOW(CB_T) ; 0x24
    HIGH(CB_T)
    LOW(CB_U) ; 0x25
    HIGH(CB_U)
    LOW(CB_V) ; 0x26
    HIGH(CB_V)
    LOW(CB_W) ; 0x27
    HIGH(CB_W)
    LOW(CB_X) ; 0x28
    HIGH(CB_X)
    LOW(CB_Y) ; 0x29
    HIGH(CB_Y)
    LOW(CB_Z) ; 0x2A
    HIGH(CB_Z)
    LOW(CB_Z) ; 0x2B
    HIGH(CB_Z)
    LOW(CB_Z) ; 0x2C
    HIGH(CB_Z)
    LOW(CB_AA) ; 0x2D <<<
    HIGH(CB_AA)
    LOW(CB_AB) ; 0x2E
    HIGH(CB_AB)
    LOW(CB_AC) ; 0x2F
    HIGH(CB_AC)
    LOW(CB_AC) ; 0x30
    HIGH(CB_AC)
    LOW(CB_AC) ; 0x31
    HIGH(CB_AC)
    LOW(CB_AD) ; 0x32
    HIGH(CB_AD)
    LOW(CB_AD) ; 0x33
    HIGH(CB_AD)
    LOW(CB_AD) ; 0x34
    HIGH(CB_AD)
    LOW(CB_AE) ; 0x35
    HIGH(CB_AE)
    LOW(CB_AF) ; 0x36
    HIGH(CB_AF)
    LOW(CB_AG) ; 0x37
    HIGH(CB_AG)
    LOW(CB_AG) ; 0x38
    HIGH(CB_AG)
    LOW(CB_AG) ; 0x39
    HIGH(CB_AG)
    LOW(CB_AG) ; 0x3A
    HIGH(CB_AG)
    LOW(CB_AH) ; 0x3B
    HIGH(CB_AH)
    LOW(CB_AI) ; 0x3C
    HIGH(CB_AI)
    LOW(CB_AJ) ; 0x3D
    HIGH(CB_AJ)
    LOW(CB_AK) ; 0x3E
    HIGH(CB_AK)
    LOW(CB_AL) ; 0x3F
    HIGH(CB_AL)
    LOW(CB_AM) ; 0x40
    HIGH(CB_AM)
    LOW(CB_0x10_A) ; 0x41
    HIGH(CB_0x10_A)
    LOW(BOSS_RTN) ; 0x42
    HIGH(BOSS_RTN)
    LOW(BOSS_RTN) ; 0x43
    HIGH(BOSS_RTN)
    LOW(BOSS_RTN) ; 0x44
    HIGH(BOSS_RTN)
    LOW(BOSS_RTN) ; 0x45
    HIGH(BOSS_RTN)
    LOW(BOSS_RTN) ; 0x46
    HIGH(BOSS_RTN)
    LOW(BOSS_RTN) ; 0x47
    HIGH(BOSS_RTN)
    LOW(CB_0x10_B) ; 0x48
    HIGH(CB_0x10_B)
    LOW(CB_AQ) ; 0x49
    HIGH(CB_AQ)
    LOW(CB_AR) ; 0x4A
    HIGH(CB_AR)
    LOW(CB_AS) ; 0x4B
    HIGH(CB_AS)
    LOW(CB_AT) ; 0x4C
    HIGH(CB_AT)
    LOW(CB_AU) ; 0x4D
    HIGH(CB_AU)
    LOW(CB_AV) ; 0x4E
    HIGH(CB_AV)
    LOW(CB_AW) ; 0x4F
    HIGH(CB_AW)
    LOW(CB_AX) ; 0x50
    HIGH(CB_AX)
    LOW(CB_AY) ; 0x51
    HIGH(CB_AY)
    LOW(CB_AZ) ; 0x52
    HIGH(CB_AZ)
    LOW(CB_BA) ; 0x53
    HIGH(CB_BA)
    LOW(CB_BA) ; 0x54
    HIGH(CB_BA)
    LOW(CB_BA) ; 0x55
    HIGH(CB_BA)
    LOW(CB_BA) ; 0x56
    HIGH(CB_BA)
    LOW(CB_BB) ; 0x57
    HIGH(CB_BB)
    LOW(CB_BB) ; 0x58
    HIGH(CB_BB)
    LOW(CB_BB) ; 0x59
    HIGH(CB_BB)
    LOW(CB_BB) ; 0x5A
    HIGH(CB_BB)
    LOW(CB_BB) ; 0x5B
    HIGH(CB_BB)
    LOW(CB_BB) ; 0x5C
    HIGH(CB_BB)
    LOW(CB_BC) ; 0x5D
    HIGH(CB_BC)
    LOW(CB_BD) ; 0x5E
    HIGH(CB_BD)
    LOW(CB_BE) ; 0x5F
    HIGH(CB_BE)
    LOW(CB_BF) ; 0x60
    HIGH(CB_BF)
    LOW(CB_BG) ; 0x61
    HIGH(CB_BG)
WAIT_UPDATES_AND_???: ; 1F:0FFC, 0x03EFFC
    LDA PLAYER?_UNK[2] ; Load P1 unk.
    ORA PPU_UPDATE_BUF_INDEX ; Combine with BG updates.
    BEQ GAME_STATE_SETTLED ; If neither active/set, do.
    RTS ; Leave, not settled.
GAME_STATE_SETTLED: ; 1F:1003, 0x03F003
    LDX #$00 ; P1 object.
LOOP_PLAYER_OBJS: ; 1F:1005, 0x03F005
    LDA 694_PLAYER_UNK[4],X ; Load
    BNE P1_SET ; != 0, goto.
    JMP NEXT_OBJ
P1_SET: ; 1F:100D, 0x03F00D
    BMI P1_NEG ; If negative, goto.
    LDA #$24
    JSR BANK_PAIR_USE_A ; Bank 4/5
    LDA 694_PLAYER_UNK[4],X ; Load
    CMP #$09 ; If _ #$09
    BEQ VAL_EQ_9/A ; ==, goto.
    CMP #$0A ; If _ #$0A
    BNE VAL_NE_9/A ; !=, goto.
VAL_EQ_9/A: ; 1F:101F, 0x03F01F
    LDA 698_PLAYER_UNK[4],X ; Load
    CMP #$10 ; If _ #$10
    BNE VAL_NE_9/A ; !=, goto.
    LDA #$4A
    JSR SND_BANKED_DISPATCH ; Play sound.
VAL_NE_9/A: ; 1F:102B, 0x03F02B
    LDA 694_PLAYER_UNK[4],X ; Load
    AND #$3F ; Isolate 0011.1111
    TAY ; A -= 1, but fancy.
    DEY
    TYA
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA DATA_PLAYER_PTR_UNK_L,Y ; Move ptr.
    STA TMP_02
    LDA DATA_PLAYER_PTR_UNK_H,Y
    STA TMP_03
    JMP PLAYER_DATA_PTR_SETUP ; Skip other code.
P1_NEG: ; 1F:1042, 0x03F042
    LDA #$30
    JSR BANK_PAIR_USE_A ; Bank in bank 10/11.
    LDA 694_PLAYER_UNK[4],X ; Load val.
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
    LDA SCRIPT_NAMETABLE_FOCUS_VAL?[2] ; Load
    CMP [TMP_02],Y ; If _ Stream
    INY ; Stream++
    BCC STREAM_LESS ; <, goto.
    LDA SCRIPT_SCROLL_X?[2] ; Load
    CMP [TMP_02],Y ; If _ Stream
    BCS OBJECT_CLEAR_UNK_AND_NEXT_OBJ ; >=, goto.
STREAM_LESS: ; 1F:106A, 0x03F06A
    LDA 69C_PLAYER_UNK[4],X ; Load
    BEQ P_VAL_ZERO ; No value, goto.
    DEC 69C_PLAYER_UNK[4],X ; --
    BNE NEXT_OBJ ; Next object.
P_VAL_ZERO: ; 1F:1074, 0x03F074
    INY ; Stream++
    LDA [TMP_02],Y ; Load val.
    STA 69C_PLAYER_UNK[4],X ; Store to player.
    LDA 698_PLAYER_UNK[4],X ; Load other val.
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
    LDA 694_PLAYER_UNK[4],X ; Load val.
    BPL VAL_POSITIVE
    LDA [TMP_02],Y ; Load from stream.
    JSR MULTI-UPDATES_RTN ; Do sub from bank 10.
    JMP RESTORE_SAVED_INC_PLAYER_VAR
VAL_POSITIVE: ; 1F:109A, 0x03F09A
    LDA 694_PLAYER_UNK[4],X ; Load val from player.
    AND #$40 ; Test 0100.0000
    BEQ BIT_NOT_SET ; Not set, goto.
    LDA [TMP_02],Y ; Load from stream.
    JSR MULTIUPDATE_BUF_RTN ; Do sub other bank.
    JMP RESTORE_SAVED_INC_PLAYER_VAR
BIT_NOT_SET: ; 1F:10A9, 0x03F0A9
    LDA [TMP_02],Y ; Load val from stream.
    JSR UPDATE_BUF_MAKER
RESTORE_SAVED_INC_PLAYER_VAR: ; 1F:10AE, 0x03F0AE
    PLA ; Pull saved val.
    TAX ; To X.
    INC 698_PLAYER_UNK[4],X ; ++ val.
NEXT_OBJ: ; 1F:10B3, 0x03F0B3
    INX ; Obj++
    CPX #$04 ; If Obj _ #$04
    BCS RTS ; >=, goto.
    JMP LOOP_PLAYER_OBJS ; Loop all.
RTS: ; 1F:10BB, 0x03F0BB
    RTS
OBJECT_CLEAR_UNK_AND_NEXT_OBJ: ; 1F:10BC, 0x03F0BC
    LDA #$00
    STA 694_PLAYER_UNK[4],X ; Clear
OBJECT_LIMITED_CLEAR_AND_NEXT_OBJ: ; 1F:10C1, 0x03F0C1
    LDA #$00
    STA 698_PLAYER_UNK[4],X ; Clear
    STA 69C_PLAYER_UNK[4],X
    BEQ NEXT_OBJ ; Next object, always taken.
OBJ[0x4-0x11]_RUN_STATE_HANDLERS: ; 1F:10CB, 0x03F0CB
    LDX #$04 ; Obj start.
LOOP_ALL_OBJS: ; 1F:10CD, 0x03F0CD
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Test enabled.
    BEQ NEXT_OBJ ; If no value set, skip.
    BMI BANK_0 ; If negative, goto.
    CMP #$30 ; If _ #$30
    BCC BANK_A/B ; <, goto.
    CMP #$36
    BCC BANK_2/3 ; <, goto.
    CMP #$3B
    BCC BANK_8/9 ; <, goto.
    CMP #$50
    BCC BANK_16/17 ; <, goto.
    CMP #$6D
    BCS BANK_16/17 ; >=, goto.
    LDA #$2C ; State 0x50 - 0x6C, bank C/D.
    BNE BANK_COMMIT ; Always taken.
BANK_A/B: ; 1F:10EC, 0x03F0EC
    LDA #$2A ; Bank A/B
BANK_COMMIT: ; 1F:10EE, 0x03F0EE
    JSR BANK_PAIR_USE_A ; Bank 0/1, 2/3, 8/9, A/B, 16/17.
    JSR OBJECT_HANDLER_RUN ; Do object code. <<<<<<<<<
NEXT_OBJ: ; 1F:10F4, 0x03F0F4
    INX ; Obj++
    CPX #$12 ; If _ #$12
    BCC LOOP_ALL_OBJS ; <, goto.
OBJ_STATE_0x00_HANDLER: ; 1F:10F9, 0x03F0F9
    RTS ; Leave.
BANK_0: ; 1F:10FA, 0x03F0FA
    LDA #$20 ; Bank 0/1
    BNE BANK_COMMIT ; Always taken.
BANK_16/17: ; 1F:10FE, 0x03F0FE
    LDA #$36 ; Bank 16/17
    BNE BANK_COMMIT ; Always taken.
BANK_2/3: ; 1F:1102, 0x03F102
    LDA #$22 ; Bank 2/3
    BNE BANK_COMMIT ; Always taken.
BANK_8/9: ; 1F:1106, 0x03F106
    LDA #$28 ; Bank 8/9
    BNE BANK_COMMIT ; Always taken.
OBJECT_HANDLER_RUN: ; 1F:110A, 0x03F10A
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load from object.
    ASL A ; << 1, *2
    TAY ; To index.
    BCC POSITIVE_STATE ; Carry clear, value positive, goto.
    LDA OBJ_HANDLERS_NEGATIVE_L,Y ; Negative here.
    STA TMP_00 ; Store low.
    LDA OBJ_HANDLERS_NEGATIVE_H,Y
    JMP STORE_HANDLER_HIGH_AND_INDIR_JMP ; Store high and JMP.
POSITIVE_STATE: ; 1F:111C, 0x03F11C
    LDA OBJ_HANDLERS_POSITIVE_L,Y
    STA TMP_00
    LDA OBJ_HANDLERS_POSITIVE_H,Y
STORE_HANDLER_HIGH_AND_INDIR_JMP: ; 1F:1124, 0x03F124
    STA TMP_01
    JMP [TMP_00] ; Jump to handler.
OBJ_HANDLERS_POSITIVE_L: ; 1F:1129, 0x03F129
    LOW(OBJ_STATE_0x00_HANDLER) ; 0x00, RTS.
OBJ_HANDLERS_POSITIVE_H: ; 1F:112A, 0x03F12A
    HIGH(OBJ_STATE_0x00_HANDLER)
    LOW(OBJ_STATE_0x01_HANDLER) ; 0x01. Very simple.
    HIGH(OBJ_STATE_0x01_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x02. Does a ton of stuff.
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x03
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x04
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x05
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x06
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x07
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x08
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x09
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x0A
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x0B
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x0C
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x0D
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x0E
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x0F
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x10
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x11
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x12
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x13
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x02_HANDLER) ; 0x14
    HIGH(OBJ_STATE_0x02_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x15. Very similar to 0x02 handler.
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x16
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x17
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x18
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x19
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x1A
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x1B
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x1C
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x1D
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x1E
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x1F
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x20
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x21
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x15_HANDLER) ; 0x22
    HIGH(OBJ_STATE_0x15_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x23. Smaller.
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x24_HANDLER) ; 0x24. Pair objs create first seen in these.
    HIGH(OBJ_STATE_0x24_HANDLER)
    LOW(OBJ_STATE_0x25_HANDLER) ; 0x25. More pairs.
    HIGH(OBJ_STATE_0x25_HANDLER)
    LOW(OBJ_STATE_0x26_HANDLER) ; 0x26. IRQ run accounted for in these.
    HIGH(OBJ_STATE_0x26_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x27. Dups again.
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x28
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x29
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x2A
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x2B
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x2C
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x2D
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x2E
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x23_HANDLER) ; 0x2F
    HIGH(OBJ_STATE_0x23_HANDLER)
    LOW(OBJ_STATE_0x30_HANDLER) ; 0x30. No multiswitch. BG Stuff?
    HIGH(OBJ_STATE_0x30_HANDLER)
    LOW(OBJ_STATE_0x31_HANDLER) ; 0x31. Sound, decently simple.
    HIGH(OBJ_STATE_0x31_HANDLER)
    LOW(OBJ_STATE_0x32_HANDLER) ; 0x32
    HIGH(OBJ_STATE_0x32_HANDLER)
    LOW(OBJ_STATE_0x33_HANDLER) ; 0x33
    HIGH(OBJ_STATE_0x33_HANDLER)
    LOW(OBJ_STATE_0x34_HANDLER) ; 0x34
    HIGH(OBJ_STATE_0x34_HANDLER)
    LOW(OBJ_STATE_0x35_HANDLER) ; 0x35
    HIGH(OBJ_STATE_0x35_HANDLER)
    LOW(OBJ_STATE_0x36_HANDLER) ; 0x36
    HIGH(OBJ_STATE_0x36_HANDLER)
    LOW(OBJ_STATE_0x37_HANDLER) ; 0x37 Smol.
    HIGH(OBJ_STATE_0x37_HANDLER)
    LOW(OBJ_STATE_0x38_HANDLER) ; 0x38
    HIGH(OBJ_STATE_0x38_HANDLER)
    LOW(OBJ_STATE_0x39_HANDLER) ; 0x39
    HIGH(OBJ_STATE_0x39_HANDLER)
    LOW(OBJ_STATE_0x3A_HANDLER) ; 0x3A
    HIGH(OBJ_STATE_0x3A_HANDLER)
    LOW(OBJ_STATE_0x3B_HANDLER) ; 0x3B
    HIGH(OBJ_STATE_0x3B_HANDLER)
    LOW(OBJ_STATE_0x3C_HANDLER) ; 0x3C
    HIGH(OBJ_STATE_0x3C_HANDLER)
    LOW(OBJ_STATE_0x3D_HANDLER) ; 0x3D
    HIGH(OBJ_STATE_0x3D_HANDLER)
    LOW(OBJ_STATE_0x3E_HANDLER) ; 0x3E
    HIGH(OBJ_STATE_0x3E_HANDLER)
    LOW(OBJ_STATE_0x3F_HANDLER) ; 0x3F
    HIGH(OBJ_STATE_0x3F_HANDLER)
    LOW(OBJ_STATE_0x40_HANDLER) ; 0x40
    HIGH(OBJ_STATE_0x40_HANDLER)
    LOW(OBJ_STATE_0x41_HANDLER) ; 0x41, definitely fucked up. Off by +1 on address.
    HIGH(OBJ_STATE_0x41_HANDLER)
    LOW(OBJ_STATE_0x41_HANDLER) ; 0x42
    HIGH(OBJ_STATE_0x41_HANDLER)
    LOW(OBJ_STATE_0x41_HANDLER) ; 0x43
    HIGH(OBJ_STATE_0x41_HANDLER)
    LOW(OBJ_STATE_0x41_HANDLER) ; 0x44
    HIGH(OBJ_STATE_0x41_HANDLER)
    LOW(OBJ_STATE_0x41_HANDLER) ; 0x45
    HIGH(OBJ_STATE_0x41_HANDLER)
    LOW(OBJ_STATE_0x41_HANDLER) ; 0x46
    HIGH(OBJ_STATE_0x41_HANDLER)
    LOW(OBJ_STATE_0x41_HANDLER) ; 0x47
    HIGH(OBJ_STATE_0x41_HANDLER)
    LOW(OBJ_STATE_0x41_HANDLER) ; 0x48
    HIGH(OBJ_STATE_0x41_HANDLER)
    LOW(OBJ_STATE_0x49_HANDLER) ; 0x49
    HIGH(OBJ_STATE_0x49_HANDLER)
    LOW(OBJ_STATE_0x4A_HANDLER) ; 0x4A
    HIGH(OBJ_STATE_0x4A_HANDLER)
    LOW(OBJ_STATE_0x4B_HANDLER) ; 0x4B
    HIGH(OBJ_STATE_0x4B_HANDLER)
    LOW(OBJ_STATE_0x4C_HANDLER) ; 0x4C
    HIGH(OBJ_STATE_0x4C_HANDLER)
    LOW(OBJ_STATE_0x4D_HANDLER) ; 0x4D - Diff types around here. Earlier forms?
    HIGH(OBJ_STATE_0x4D_HANDLER)
    LOW(OBJ_STATE_0x4E_HANDLER) ; 0x4E
    HIGH(OBJ_STATE_0x4E_HANDLER)
    LOW(OBJ_STATE_0x4F_HANDLER) ; 0x4F
    HIGH(OBJ_STATE_0x4F_HANDLER)
    LOW(OBJ_STATE_0x50_HANDLER) ; 0x50
    HIGH(OBJ_STATE_0x50_HANDLER)
    LOW(OBJ_STATE_0x51_HANDLER) ; 0x51. Seem to get more complex here. Bosses/advanced enemies here?
    HIGH(OBJ_STATE_0x51_HANDLER) ; This seems to be rocksteady.
    LOW(OBJ_STATE_0x52_HANDLER) ; 0x52
    HIGH(OBJ_STATE_0x52_HANDLER) ; Rocksteady's gunshots?
    LOW(OBJ_STATE_0x53_HANDLER) ; 0x53
    HIGH(OBJ_STATE_0x53_HANDLER)
    LOW(OBJ_STATE_0x54_HANDLER) ; 0x54
    HIGH(OBJ_STATE_0x54_HANDLER)
    LOW(OBJ_STATE_0x55_HANDLER) ; 0x55
    HIGH(OBJ_STATE_0x55_HANDLER) ; Odd stuff dealing with one-off script vars. Complex as fuck, too.
    LOW(OBJ_STATE_0x56_HANDLER) ; 0x56
    HIGH(OBJ_STATE_0x56_HANDLER)
    LOW(OBJ_STATE_0x57_HANDLER) ; 0x57
    HIGH(OBJ_STATE_0x57_HANDLER)
    LOW(OBJ_STATE_0x58_HANDLER) ; 0x58
    HIGH(OBJ_STATE_0x58_HANDLER)
    LOW(OBJ_STATE_0x59_HANDLER) ; 0x59
    HIGH(OBJ_STATE_0x59_HANDLER) ; Pretty simple.
    LOW(OBJ_STATE_0x5A_HANDLER) ; 0x5A
    HIGH(OBJ_STATE_0x5A_HANDLER) ; Large. I think this is flying guy? Idk maybe not.
    LOW(OBJ_STATE_0x5B_HANDLER) ; 0x5B
    HIGH(OBJ_STATE_0x5B_HANDLER)
    LOW(OBJ_STATE_0x5C_HANDLER) ; 0x5C
    HIGH(OBJ_STATE_0x5C_HANDLER)
    LOW(OBJ_STATE_0x5D_HANDLER) ; 0x5D
    HIGH(OBJ_STATE_0x5D_HANDLER) ; Large. Mainly copy of 0x51 with 1 unique routine.
    LOW(OBJ_STATE_0x5E_HANDLER) ; 0x5E
    HIGH(OBJ_STATE_0x5E_HANDLER) ; Old type, large. Some shit code at the end, interesting.
    LOW(OBJ_STATE_0x5F_HANDLER) ; 0x5F
    HIGH(OBJ_STATE_0x5F_HANDLER)
    LOW(OBJ_STATE_0x60_HANDLER) ; 0x60
    HIGH(OBJ_STATE_0x60_HANDLER)
    LOW(OBJ_STATE_0x61_HANDLER) ; 0x61
    HIGH(OBJ_STATE_0x61_HANDLER)
    LOW(OBJ_STATE_0x62_HANDLER) ; 0x62
    HIGH(OBJ_STATE_0x62_HANDLER) ; Not too big.
    LOW(OBJ_STATE_0x63_HANDLER) ; 0x63
    HIGH(OBJ_STATE_0x63_HANDLER) ; Pretty small.
    LOW(OBJ_STATE_0x64_HANDLER) ; 0x64
    HIGH(OBJ_STATE_0x64_HANDLER) ; Pretty small.
    LOW(OBJ_STATE_0x65_HANDLER) ; 0x65
    HIGH(OBJ_STATE_0x65_HANDLER) ; Pretty small.
    LOW(OBJ_STATE_0x65_HANDLER) ; 0x66
    HIGH(OBJ_STATE_0x65_HANDLER)
    LOW(OBJ_STATE_0x67_HANDLER) ; 0x67
    HIGH(OBJ_STATE_0x67_HANDLER) ; Old type, large.
    LOW(OBJ_STATE_0x68_HANDLER) ; 0x68
    HIGH(OBJ_STATE_0x68_HANDLER) ; Seems small.
    LOW(OBJ_STATE_0x69_HANDLER) ; 0x69
    HIGH(OBJ_STATE_0x69_HANDLER) ; Seems small.
    LOW(OBJ_STATE_0x6A_HANDLER) ; 0x6A RTS
    HIGH(OBJ_STATE_0x6A_HANDLER)
    LOW(OBJ_STATE_0x6B_HANDLER) ; 0x6B
    HIGH(OBJ_STATE_0x6B_HANDLER) ; Very small.
    LOW(OBJ_STATE_0x6A_HANDLER) ; 0x6C, RTS.
    HIGH(OBJ_STATE_0x6A_HANDLER)
    LOW(OBJ_STATE_0x6D_HANDLER) ; 0x6D, Also fucked up, but -1. This is during the shredder fight.
    HIGH(OBJ_STATE_0x6D_HANDLER)
    LOW(OBJ_STATE_0x6E_HANDLER) ; 0x6E RTS RTS. lol.
    HIGH(OBJ_STATE_0x6E_HANDLER)
    LOW(OBJ_STATE_0x6F_HANDLER) ; 0x6F
    HIGH(OBJ_STATE_0x6F_HANDLER) ; Small.
    LOW(OBJ_STATE_0x70_HANDLER) ; 0x70
    HIGH(OBJ_STATE_0x70_HANDLER) ; Old, large.
    LOW(OBJ_STATE_0x71_HANDLER) ; 0x71
    HIGH(OBJ_STATE_0x71_HANDLER) ; Large.
    LOW(OBJ_STATE_0x72_HANDLER) ; 0x72
    HIGH(OBJ_STATE_0x72_HANDLER) ; Small.
    LOW(OBJ_STATE_0x73_HANDLER) ; 0x73
    HIGH(OBJ_STATE_0x73_HANDLER) ; Seems small.
    LOW(OBJ_STATE_0x74_HANDLER) ; 0x74
    HIGH(OBJ_STATE_0x74_HANDLER) ; Seems small.
    LOW(OBJ_STATE_0x75_HANDLER) ; 0x75
    HIGH(OBJ_STATE_0x75_HANDLER) ; Boss? I think THIS might be shredder, idk.
    LOW(OBJ_STATE_0x76_HANDLER) ; 0x76
    HIGH(OBJ_STATE_0x76_HANDLER)
    LOW(OBJ_STATE_0x77_HANDLER) ; 0x77
    HIGH(OBJ_STATE_0x77_HANDLER) ; Medium.
    LOW(OBJ_STATE_0x78_HANDLER) ; 0x78
    HIGH(OBJ_STATE_0x78_HANDLER) ; Very small.
    LOW(OBJ_STATE_0x79_HANDLER) ; 0x79
    HIGH(OBJ_STATE_0x79_HANDLER) ; Old, large.
    LOW(OBJ_STATE_0x79_HANDLER) ; 0x7A
    HIGH(OBJ_STATE_0x79_HANDLER)
    LOW(OBJ_STATE_0x79_HANDLER) ; 0x7B
    HIGH(OBJ_STATE_0x79_HANDLER)
    LOW(OBJ_STATE_0x79_HANDLER) ; 0x7C
    HIGH(OBJ_STATE_0x79_HANDLER)
    LOW(OBJ_STATE_0x79_HANDLER) ; 0x7D
    HIGH(OBJ_STATE_0x79_HANDLER)
    LOW(OBJ_STATE_0x79_HANDLER) ; 0x7E
    HIGH(OBJ_STATE_0x79_HANDLER)
    LOW(OBJ_STATE_0x79_HANDLER) ; 0x7F
    HIGH(OBJ_STATE_0x79_HANDLER)
OBJ_HANDLERS_NEGATIVE_L: ; 1F:1229, 0x03F229
    LOW(OBJ_STATE_0x80_HANDLER) ; 0x00. All these are | 0x80 for actual value.
OBJ_HANDLERS_NEGATIVE_H: ; 1F:122A, 0x03F22A
    HIGH(OBJ_STATE_0x80_HANDLER)
    LOW(OBJ_STATE_0x81_HANDLER) ; 0x01
    HIGH(OBJ_STATE_0x81_HANDLER)
    LOW(OBJ_STATE_0x82_HANDLER) ; 0x02
    HIGH(OBJ_STATE_0x82_HANDLER)
    LOW(OBJ_STATE_0x83_HANDLER) ; 0x03
    HIGH(OBJ_STATE_0x83_HANDLER)
    LOW(OBJ_STATE_0x84_HANDLER) ; 0x04
    HIGH(OBJ_STATE_0x84_HANDLER)
    LOW(OBJ_STATE_0x85_HANDLER) ; 0x05
    HIGH(OBJ_STATE_0x85_HANDLER)
    LOW(OBJ_STATE_Ox86_HANDLER) ; 0x06
    HIGH(OBJ_STATE_Ox86_HANDLER)
    LOW(OBJ_STATE_0x87_HANDLER) ; 0x07
    HIGH(OBJ_STATE_0x87_HANDLER)
    LOW(OBJ_STATE_0x88_HANDLER) ; 0x08
    HIGH(OBJ_STATE_0x88_HANDLER)
    LOW(OBJ_STATE_0x89_HANDLER) ; 0x09
    HIGH(OBJ_STATE_0x89_HANDLER)
    LOW(OBJ_STATE_0x8A_HANDLER) ; 0x0A
    HIGH(OBJ_STATE_0x8A_HANDLER)
    LOW(OBJ_STATE_0x8B_HANDLER) ; 0x0B
    HIGH(OBJ_STATE_0x8B_HANDLER)
    LOW(OBJ_STATE_0x8C_HANDLER) ; 0x0C
    HIGH(OBJ_STATE_0x8C_HANDLER)
    LOW(OBJ_STATE_0x8D_HANDLER) ; 0x0D
    HIGH(OBJ_STATE_0x8D_HANDLER)
    LOW(OBJ_STATE_0x8E_HANDLER) ; 0x0E
    HIGH(OBJ_STATE_0x8E_HANDLER)
    LOW(OBJ_STATE_0x8F_HANDLER) ; 0x0F
    HIGH(OBJ_STATE_0x8F_HANDLER)
    LOW(OBJ_STATE_0x90_HANDLER) ; 0x10
    HIGH(OBJ_STATE_0x90_HANDLER)
    LOW(OBJ_STATE_0x90_HANDLER) ; 0x11
    HIGH(OBJ_STATE_0x90_HANDLER)
    LOW(OBJ_STATE_0x92_HANDLER) ; 0x12
    HIGH(OBJ_STATE_0x92_HANDLER)
    LOW(OBJ_STATE_0x93_HANDLER) ; 0x13
    HIGH(OBJ_STATE_0x93_HANDLER)
    LOW(OBJ_STATE_0x94_HANDLER) ; 0x14
    HIGH(OBJ_STATE_0x94_HANDLER)
    LOW(OBJ_STATE_0x95_HANDLER) ; 0x15
    HIGH(OBJ_STATE_0x95_HANDLER)
    LOW(OBJ_STATE_0x96_HANDLER) ; 0x16
    HIGH(OBJ_STATE_0x96_HANDLER)
    LOW(OBJ_STATE_0x97_HANDLER) ; 0x17
    HIGH(OBJ_STATE_0x97_HANDLER)
    LOW(OBJ_STATE_0x98_HANDLER) ; 0x18
    HIGH(OBJ_STATE_0x98_HANDLER)
    LOW(OBJ_STATE_0x99_HANDLER) ; 0x19
    HIGH(OBJ_STATE_0x99_HANDLER)
    LOW(OBJ_STATE_0x9A_HANDLER) ; 0x1A
    HIGH(OBJ_STATE_0x9A_HANDLER)
    LOW(OBJ_STATE_0x9B_HANDLER) ; 0x1B
    HIGH(OBJ_STATE_0x9B_HANDLER)
    LOW(OBJ_STATE_0x9C_HANDLER) ; 0x1C
    HIGH(OBJ_STATE_0x9C_HANDLER)
    LOW(OBJ_STATE_0x9D_HANDLER) ; 0x1D
    HIGH(OBJ_STATE_0x9D_HANDLER)
    LOW(OBJ_STATE_0x9E_HANDLER) ; 0x1E
    HIGH(OBJ_STATE_0x9E_HANDLER)
    LOW(OBJ_STATE_0x9F_HANDLER) ; 0x1F
    HIGH(OBJ_STATE_0x9F_HANDLER)
    LOW(OBJ_STATE_0xA0_HANDLER) ; 0x20
    HIGH(OBJ_STATE_0xA0_HANDLER)
    LOW(OBJ_STATE_0xA1_HANDLER) ; 0x21
    HIGH(OBJ_STATE_0xA1_HANDLER)
    LOW(OBJ_STATE_0xA2_HANDLER) ; 0x22
    HIGH(OBJ_STATE_0xA2_HANDLER)
    LOW(OBJ_STATE_0xA3_HANDLER) ; 0x23
    HIGH(OBJ_STATE_0xA3_HANDLER)
    LOW(OBJ_STATE_0xA4_HANDLER) ; 0x24
    HIGH(OBJ_STATE_0xA4_HANDLER)
    LOW(OBJ_STATE_0xA5_HANDLER) ; 0x25
    HIGH(OBJ_STATE_0xA5_HANDLER)
    LOW(OBJ_STATE_0xA6_HANDLER) ; 0x26
    HIGH(OBJ_STATE_0xA6_HANDLER)
    LOW(OBJ_STATE_0xA7_HANDLER) ; 0x27
    HIGH(OBJ_STATE_0xA7_HANDLER)
    LOW(OBJ_STATE_0xA8_HANDLER) ; 0x28
    HIGH(OBJ_STATE_0xA8_HANDLER)
    LOW(OBJ_STATE_0xA1_HANDLER) ; 0x29
    HIGH(OBJ_STATE_0xA1_HANDLER)
    LOW(OBJ_STATE_0xA1_HANDLER) ; 0x2A
    HIGH(OBJ_STATE_0xA1_HANDLER)
    LOW(OBJ_STATE_0xA1_HANDLER) ; 0x2B
    HIGH(OBJ_STATE_0xA1_HANDLER)
    LOW(OBJ_STATE_0xA1_HANDLER) ; 0x2C
    HIGH(OBJ_STATE_0xA1_HANDLER)
    LOW(OBJ_STATE_0xA1_HANDLER) ; 0x2D
    HIGH(OBJ_STATE_0xA1_HANDLER)
    LOW(OBJ_STATE_0xA1_HANDLER) ; 0x2E
    HIGH(OBJ_STATE_0xA1_HANDLER)
    LOW(OBJ_STATE_0xAF_HANDLER) ; 0x2F
    HIGH(OBJ_STATE_0xAF_HANDLER)
    LOW(OBJ_STATE_0xB0_HANDLER) ; 0x30
    HIGH(OBJ_STATE_0xB0_HANDLER)
    LOW(OBJ_STATE_0xB1_HANDLER) ; 0x31
    HIGH(OBJ_STATE_0xB1_HANDLER)
    LOW(OBJ_STATE_0xB2_HANDLER) ; 0x32
    HIGH(OBJ_STATE_0xB2_HANDLER)
    LOW(OBJ_STATE_0xB3_HANDLER) ; 0x33
    HIGH(OBJ_STATE_0xB3_HANDLER)
    LOW(OBJ_STATE_0xB4_HANDLER) ; 0x34
    HIGH(OBJ_STATE_0xB4_HANDLER)
    LOW(OBJ_STATE_0xB5_HANDLER) ; 0x35
    HIGH(OBJ_STATE_0xB5_HANDLER)
    LOW(OBJ_STATE_0xB6_HANDLER) ; 0x36
    HIGH(OBJ_STATE_0xB6_HANDLER)
    LOW(OBJ_STATE_0xB7_HANDLER) ; 0x37
    HIGH(OBJ_STATE_0xB7_HANDLER)
    LOW(OBJ_STATE_0xB8_HANDLER) ; 0x38
    HIGH(OBJ_STATE_0xB8_HANDLER)
    LOW(OBJ_STATE_0xB9_HANDLER) ; 0x39
    HIGH(OBJ_STATE_0xB9_HANDLER)
    LOW(OBJ_STATE_0xBA_HANDLER) ; 0x3A
    HIGH(OBJ_STATE_0xBA_HANDLER)
    LOW(OBJ_STATE_0xBB_HANDLER) ; 0x3B
    HIGH(OBJ_STATE_0xBB_HANDLER)
    LOW(OBJ_STATE_0xBC_HANDLER) ; 0x3C
    HIGH(OBJ_STATE_0xBC_HANDLER)
    LOW(OBJ_STATE_0xBD_HANDLER) ; 0x3D
    HIGH(OBJ_STATE_0xBD_HANDLER)
    LOW(OBJ_STATE_0xBE_HANDLER) ; 0x3E
    HIGH(OBJ_STATE_0xBE_HANDLER)
    LOW(OBJ_STATE_0xBE_HANDLER) ; 0x3F
    HIGH(OBJ_STATE_0xBE_HANDLER)
    LOW(OBJ_STATE_0xC0_HANDLER) ; 0x40
    HIGH(OBJ_STATE_0xC0_HANDLER)
LEVEL_8_PLAYERS_NOT_ENABLED: ; 1F:12AB, 0x03F2AB
    LDA LEVEL_8_CUTSCENE_IN_PROGRESS_FLAG ; Load
    BNE IN_PROGRESS ; If set, goto.
    JSR INIT_LEVEL_AND_OBJ[7]_STUFF ; Do rtn.
    INC LEVEL_8_CUTSCENE_IN_PROGRESS_FLAG ; Set.
    RTS ; Leave.
IN_PROGRESS: ; 1F:12B5, 0x03F2B5
    JSR OBJ[0x4-0x11]_RUN_STATE_HANDLERS ; Do..
    JSR SUB_CHECK_OBJS-0x7-0x11_RET_CS_FINISHED ; Check to see if stil in use.
    BCC RTS ; Not finished, RTS.
    LDA #$4A
    JSR LEVEL_RELATED_DATA_A_PASSED? ; Level data.
    LDA #$00
    STA LEVEL_8_CUTSCENE_IN_PROGRESS_FLAG ; Clear, finished.
    INC 4B_SWITCH_GAME_PREP/OVER ; ++
RTS: ; 1F:12C8, 0x03F2C8
    RTS
INIT_LEVEL_AND_OBJ[7]_STUFF: ; 1F:12C9, 0x03F2C9
    LDA #$00
    STA DISABLE_RENDERING_X_FRAMES ; Enable rendering.
    LDA #$69
    STA SCRIPT_R0-R5_GFX_BANK_VALS+4 ; GFX, R4.
    LDA #$E7
    STA SCRIPT_R0-R5_GFX_BANK_VALS+5 ; GFX, R5.
    LDA #$49
    JSR LEVEL_RELATED_DATA_A_PASSED? ; Level data?
    LDA #$E8
    STA OBJ_POS_X_CONFIRMED+7 ; Set unk.
    LDA #$D0
    STA OBJ_POS_X??+7 ; Set unk.
    LDA #$40
    STA OBJ_ENABLED_STATE+MORE?+7 ; Set obj 7 state.
    LDA #$02
    STA 556_OBJ_STATUS_FLAGS_A+7 ; Set obj 7 unk.
    LDA #$70
    JMP SND_BANKED_DISPATCH ; Sound. Abuse RTS.
OBJ_STATE_0xAF_HANDLER: ; 1F:12F3, 0x03F2F3
    JMP INIT_OBJECT[X]_DATA_FULL ; Simple handler, lol.
RTN_ALL_OBJS_DISABLED?_UNK: ; 1F:12F6, 0x03F2F6
    LDA 5F8_OBJ_SETS_UNK ; Load
    BMI 5F8_IS_NEG ; If negative.
    LDA 70C_END_OF_LEVEL_HOLDER? ; Load
    BEQ RTS ; Not set, goto.
    JSR TEST_OBJ[7-18]_DISABLED/!8B_RET_CS_TRUE ; Enabled?
    BCC RTS ; Not all finished, RTS.
5F8_IS_NEG: ; 1F:1305, 0x03F305
    DEC 5FB_TIMER_ALL_FINISHED? ; --
    BNE RTS ; != 0, leave.
    LDA #$00
    STA 70C_END_OF_LEVEL_HOLDER? ; Clear these.
    STA 5F8_OBJ_SETS_UNK
    LDA #$04 ; Switch to end of level things.
    STA 3C_SWITCH_CORE
RTS: ; 1F:1316, 0x03F316
    RTS
OBJ_SEARCH_UNUSED_PAIR_RET_CS_FAIL: ; 1F:1317, 0x03F317
    LDX #$07 ; Obj start.
OBJ_SEARCH_LOOP: ; 1F:1319, 0x03F319
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load state.
    BEQ STATE_EQ_ZERO ; Not enabled, goto.
PAIR_ENABLED: ; 1F:131E, 0x03F31E
    INX ; Next obj pair.
    INX
    CPX #$11 ; End obj pairs.
    BCC OBJ_SEARCH_LOOP ; <, loop.
    RTS ; Ret CS, fail.
STATE_EQ_ZERO: ; 1F:1325, 0x03F325
    LDA OBJ_ENABLED_STATE+MORE?+1,X ; Load pair state.
    BNE PAIR_ENABLED ; If enabled, next obj.
    CLC ; Ret CC, pass.
    RTS
RTN_GET_OBJ_PAIR_IN_Y_RET_CC_SUCCESS: ; 1F:132C, 0x03F32C
    LDA #$11 ; Load unk.
    STA TMP_17 ; Store to. End obj for rtn.
    LDY #$07 ; Obj
LOOP_ALL_OBJS: ; 1F:1332, 0x03F332
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from obj.
    BEQ VAL_NOT_ENABLED ; Not active, goto.
NEXT_YOBJ_PAIR: ; 1F:1337, 0x03F337
    INY
    INY
    CPY TMP_17 ; If Yobj _ var
    BCC LOOP_ALL_OBJS ; <, loop.
    RTS
VAL_NOT_ENABLED: ; 1F:133E, 0x03F33E
    LDA OBJ_ENABLED_STATE+MORE?+1,Y ; Load next obj.
    BNE NEXT_YOBJ_PAIR ; If active, goto next pair.
    CLC ; Clear carry, success. Yobj pair found.
    RTS
    LDY #$07
L_1F:1347: ; 1F:1347, 0x03F347
    LDA OBJ_ENABLED_STATE+MORE?[18],Y
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
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load object value.
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
OBJ_STATE_0x31_HANDLER: ; 1F:1376, 0x03F376
    JSR OBJECT_X_MOVE? ; Do.
    JMP OBJ_POS_BASED_INIT_CLEAR ; Goto. Abuse RTS.
STATE_0x32_SWITCH_F: ; 1F:137C, 0x03F37C
    LDA OBJ_TERTIARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(STATE_0x31_SWITCH_A) ; Clear attrs, setup.
    HIGH(STATE_0x31_SWITCH_A)
    LOW(STATE_0x31_SWITCH_B) ; Plays sounds on this, not others.
    HIGH(STATE_0x31_SWITCH_B)
    LOW(STATE_0x31_SWITCH_B)
    HIGH(STATE_0x31_SWITCH_B)
    LOW(STATE_0x31_SWITCH_B)
    HIGH(STATE_0x31_SWITCH_B)
    LOW(STATE_0x31_SWITCH_B)
    HIGH(STATE_0x31_SWITCH_B)
    LOW(INIT_OBJECT[X]_DATA_FULL) ; That's cute. Diverted initialization.
    HIGH(INIT_OBJECT[X]_DATA_FULL)
STATE_0x31_SWITCH_A: ; 1F:138E, 0x03F38E
    JSR CLEAR_OBJ_ATTRS_UNK_1546 ; Clear attrs.
    JSR CLEAR_OBJ_ATTRS_UNK_154F
    JSR CLEAR_OBJ_ATTRS_DELTAS?
    LDA #$10
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    RTS ; Leave.
STATE_0x31_SWITCH_B: ; 1F:13A0, 0x03F3A0
    DEC 59E_OBJ_UNK/EXTRA_TIMER[18],X ; --
    BNE EXIT_X_MOVE ; != 0, goto.
    LDY OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    DEY ; Val--
    BNE SKIP_SOUND ; != 0, goto. Won't happen except tert 0x01.
    LDA #$2A
    JSR SND_BANKED_DISPATCH ; Play sound.
SKIP_SOUND: ; 1F:13B0, 0x03F3B0
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    SEC ; Prep sub.
    SBC #$01 ; -= 1
    CLC ; Prep add..
    ADC #$01 ; += 1. ???? TODO: Wtf.
    CMP #$04 ; If _ #$04
    BEQ EXIT_MOVE_TERT ; ==, goto.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Store animation display.
    LDA #$08 ; Val?
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set.
EXIT_MOVE_TERT: ; 1F:13C5, 0x03F3C5
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
EXIT_X_MOVE: ; 1F:13C8, 0x03F3C8
    JMP OBJECT_X_MOVE? ; Finalize. Abuse RTS.
OBJ_POS_BASED_INIT_CLEAR: ; 1F:13CB, 0x03F3CB
    LDA OBJ_POS_Y_CONFIRMED[18],X ; Load.
    CMP #$30 ; If _ #$30
    BCC EXIT_REINIT ; <, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$03 ; Keep 0000.0011
    BEQ RTS ; None set, leave.
    AND #$02 ; Test if this bit is set specifically.
    BNE BIT_0x02_SET ; Was set, goto.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$30 ; If _ #$30
    BCC RTS ; <, leave.
    BCS EXIT_REINIT ; >=, exit.
BIT_0x02_SET: ; 1F:13E6, 0x03F3E6
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    CMP #$D0 ; If _ #$D0
    BCC EXIT_REINIT ; <, exit reinit.
RTS: ; 1F:13ED, 0x03F3ED
    RTS ; Leave.
EXIT_REINIT: ; 1F:13EE, 0x03F3EE
    JMP INIT_OBJECT[X]_DATA_FULL ; Init.
OBJECT_X_MOVE?: ; 1F:13F1, 0x03F3F1
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load from X obj. TODO: Important to really solve.
    AND #$BF ; Keep all but Hflip.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load attr.
    AND #$04 ; Test 0000.0100 bit.
    BEQ BIT_0x04_NOT_SET ; Not set, goto.
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    ORA #$40 ; Set bit when other set.
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Store back.
BIT_0x04_NOT_SET: ; 1F:1408, 0x03F408
    SEC ; Prep sub.
    LDA 520_OBJ_POS_X_LARGE?[18],X ; Load
    SBC 83_UNK ; -= Val
    STA TMP_02 ; Store to TMP.
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load
    SBC 84_UNK ; -= Val. Carry sub.
    STA TMP_03 ; Store to TMP.
    SEC ; Prep sub.
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Load
    SBC OBJ_POS_X_SUBPIXEL_DELTA? ; -= Val
    STA TMP_00 ; Store to TMP.
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    SBC OBJ_POS_X_DELTA? ; -= val. Carry sub.
    STA TMP_01 ; Store to TMP.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load POS.
    STA TMP_08 ; Store to TMP.
    JSR RTN_OBJ_MOVE?_UNK ; Do rtn.
    LDA TMP_01 ; Load TMP.
    BPL MOVE_POSITIVE ; If positive, goto.
    LDA TMP_08 ; Load, XPOS previous.
    CMP OBJ_POS_X_CONFIRMED[18],X ; Compare to current.
    BCS OBJ_XPOS_[OVER/UNDER]FLOW ; Previous was greater after sub, wrong.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$03 ; Keep 0000.0011
    BEQ NO_BITS_SET_0x03 ; If none set, goto.
    AND #$01 ; Keep bit 0000.0001
    BNE BIT_0x01_SET ; If set, do.
NO_BITS_SET_0x03: ; 1F:1444, 0x03F444
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    ORA #$02 ; Set 0x02
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store back.
    RTS
MOVE_POSITIVE: ; 1F:144D, 0x03F44D
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load current.
    CMP TMP_08 ; Compare to previous.
    BCS OBJ_XPOS_[OVER/UNDER]FLOW ; If XPOS_CURR > PREV after add, wrong.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$03 ; Keep 0000.0011
    BEQ NO_BITS_SET_0x03 ; None set, goto.
    AND #$02 ; Test bit 0000.0010
    BEQ NO_BITS_SET_0x03 ; Not set, goto.
BIT_0x01_SET: ; 1F:145F, 0x03F45F
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store back.
    RTS ; Leave.
NO_BITS_SET_0x03: ; 1F:1468, 0x03F468
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    ORA #$01 ; Set 0000.0001
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store back.
OBJ_XPOS_[OVER/UNDER]FLOW: ; 1F:1470, 0x03F470
    RTS
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    SEC
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    SBC OBJ_POS_X_SUBPIXEL_DELTA?
    STA TMP_00
    LDA OBJ_POS_X_DELTA?[18],X
    SBC OBJ_POS_X_DELTA?
    STA TMP_01
    SEC
    LDA 520_OBJ_POS_X_LARGE?[18],X
    SBC 83_UNK
    STA TMP_02
    LDA 503_OBJ_POS_X_LARGEST?[18],X
    SBC 84_UNK
    STA TMP_03
RTN_OBJ_MOVE?_UNK: ; 1F:1494, 0x03F494
    CLC ; Prep add.
    LDA OBJ_POS_X_SUBPIXEL?[18],X ; Load from OBJ.
    ADC TMP_00 ; Add to.
    STA OBJ_POS_X_SUBPIXEL?[18],X ; Store back.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    ADC TMP_01 ; Add with.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store back.
    CLC ; Prep add.
    LDA 4B4_OBJ_SPEED?[18],X ; Load from OBJ.
    ADC TMP_02 ; Add with.
    STA 4B4_OBJ_SPEED?[18],X ; Store back.
    LDA OBJ_POS_X??[18],X ; Load
    ADC TMP_03 ; Add with.
    STA OBJ_POS_X??[18],X ; Store back.
    CLC ; Prep add.
    LDA 4B4_OBJ_SPEED?[18],X ; Load from obj.
    ADC 4D8_OBJ_UNK[18],X ; Add with.
    LDA OBJ_POS_X??[18],X ; Load
    ADC 4C6_OBJ_UNK[18],X ; Add with. Carry add.
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store to.
RTS: ; 1F:14C6, 0x03F4C6
    RTS ; Leave.
TEST_OBJ_UPDATE_FLAG_INIT: ; 1F:14C7, 0x03F4C7
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    AND #$02 ; If 0000.00X0...
    BEQ RTS ; == 0, leave.
    JMP INIT_OBJECT[X]_DATA_FULL ; Init data.
INIT_OBJECT[X]_DATA_FULL: ; 1F:14D1, 0x03F4D1
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    STA OBJ_POS_X_CONFIRMED[18],X
    STA OBJ_POS_X??[18],X
    STA 4C6_OBJ_UNK[18],X
    STA OBJ_POS_Y_CONFIRMED[18],X
    STA OBJ_ANIMATION_DISPLAY[18],X
    STA OBJ_ENABLED_STATE+MORE?[18],X
INT_OBJECT[X]_DATA_SMOL: ; 1F:14E8, 0x03F4E8
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    STA OBJ_SECONDARY_SWITCH?[18],X
    STA OBJ_POS_X_SUBPIXEL?[18],X
    STA 4B4_OBJ_SPEED?[18],X
    STA 4D8_OBJ_UNK[18],X
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA OBJ_POS_X_DELTA?[18],X
    STA 520_OBJ_POS_X_LARGE?[18],X
    STA 503_OBJ_POS_X_LARGEST?[18],X
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    STA OBJECT_DATA_HEALTH?[18],X
    STA OBJECT_DATA_EXTRA_B?[18],X
    STA OBJ_TERTIARY_SWITCH?[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    RTS
TEST_OBJ[7-18]_DISABLED/!8B_RET_CS_TRUE: ; 1F:1527, 0x03F527
    TXA ; Save X.
    PHA
    TYA ; Save Y.
    PHA
    LDY #$07 ; Objject.
LOOP_CHECK_ALL_OBJS: ; 1F:152D, 0x03F52D
    LDA OBJ_ENABLED_STATE+MORE?[18],Y
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
CLEAR_OBJ_ATTRS_UNK_1546: ; 1F:1546, 0x03F546
    LDA #$00
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA OBJ_POS_X_DELTA?[18],X
    RTS
CLEAR_OBJ_ATTRS_UNK_154F: ; 1F:154F, 0x03F54F
    LDA #$00
    STA 520_OBJ_POS_X_LARGE?[18],X
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS
CLEAR_OBJ_ATTRS_DELTAS?: ; 1F:1558, 0x03F558
    LDA #$00
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    RTS
    JSR SUB_INVERT_X_DELTA? ; Mistake line?
SUB_INVERT_X_POS?: ; 1F:1564, 0x03F564
    SEC ; Prep sub.
    LDA #$00 ; Seed inversion.
    SBC 520_OBJ_POS_X_LARGE?[18],X ; Invert.
    STA 520_OBJ_POS_X_LARGE?[18],X ; Store back.
    LDA #$00 ; Seed inversion.
    SBC 503_OBJ_POS_X_LARGEST?[18],X ; Invert.
    STA 503_OBJ_POS_X_LARGEST?[18],X ; Store back.
    RTS ; Leave.
SUB_INVERT_X_DELTA?: ; 1F:1576, 0x03F576
    SEC ; Prep sub.
    LDA #$00 ; Seed inversion.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Invert with data.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store back.
    LDA #$00 ; Seed inversion.
    SBC OBJ_POS_X_DELTA?[18],X ; Invert with data.
    STA OBJ_POS_X_DELTA?[18],X ; Store back.
    RTS ; Leave.
L_1F:1588: ; 1F:1588, 0x03F588
    STY TMP_00
    CLC
    ADC OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_POS_X_DELTA?[18],X
    ADC TMP_00
    STA OBJ_POS_X_DELTA?[18],X
    RTS
L_1F:159A: ; 1F:159A, 0x03F59A
    STY TMP_00
    CLC
    ADC 520_OBJ_POS_X_LARGE?[18],X
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA 503_OBJ_POS_X_LARGEST?[18],X
    ADC TMP_00
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS
ADD_A/Y_TO_OBJ_DELTA?: ; 1F:15AC, 0x03F5AC
    STY TMP_00 ; Y to TMP.
    CLC ; Prep add.
    ADC 544_OBJ_UNK_POS_DELTA?[18],X ; Add to val.
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Store back.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load val.
    ADC TMP_00 ; Add with original Y.
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Store back.
    RTS
MOVE_OBJ_POS_DELTA_AMOUNT?: ; 1F:15BE, 0x03F5BE
    CLC ; Prep add.
    LDA 4D8_OBJ_UNK[18],X ; Load
    ADC 544_OBJ_UNK_POS_DELTA?[18],X ; Add with.
    STA 4D8_OBJ_UNK[18],X ; Store back.
    LDA 4C6_OBJ_UNK[18],X ; Load
    ADC 532_OBJ_UNK_POS_DELTA?[18],X ; Add with.
    STA 4C6_OBJ_UNK[18],X ; Store back.
    RTS ; Leave.
EXIT_SET_SEC_CLEAR_TERT/EXTRA: ; 1F:15D2, 0x03F5D2
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
    RTS
FIND_YPOS_DIFF_OBJY/OBJS_TMP_10_FLAG_XVAL_GT_YVAL: ; 1F:15E0, 0x03F5E0
    LDA #$00
    STA TMP_10 ; Clear TMP. Used as a flag for negative.
    LDA OBJ_POS_X??[18],Y ; Load from Yobj.
    SEC ; Prep sub.
    SBC OBJ_POS_X??[18],X ; Sub with Xobj.
    BCS RTS ; Yobj >= Xobj, leave as is.
    INC TMP_10 ; Set flag. This means Xobj > Yobj.
    EOR #$FF ; Compliment for ABS value.
    CLC
    ADC #$01 ; Fix compliment.
RTS: ; 1F:15F4, 0x03F5F4
    RTS ; Leave. A is ABS(DIFF), TMP_12 is Y-X < 0 flag. AKA Yobj val >= Xobj val.
FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL: ; 1F:15F5, 0x03F5F5
    LDA #$00
    STA TMP_12 ; Clear TMP. Used as flag for negative.
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load Yobj pos.
    SEC ; Prep sub.
    SBC OBJ_POS_X_CONFIRMED[18],X ; Sub with Xobj.
    BCS RTS ; Yobj >= Xobj, leave as is.
    INC TMP_12 ; Set flag. This means Xobj > Yobj.
    EOR #$FF ; Compliment for ABS value.
    CLC
    ADC #$01 ; Fix compliment.
RTS: ; 1F:1609, 0x03F609
    RTS ; Leave. A is ABS(DIFF), TMP_12 is Y-X < 0 flag. AKA Yobj val >= Xobj val.
SET_FOCUS_LEFT/RIGHT_FLAG_FOR_OBJ_X->Y: ; 1F:160A, 0x03F60A
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load.
    AND #$FB ; Keep 1111.1011 bits.
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store back, unset bits.
    JSR FIND_XPOS_DIFF_OBJY/OBJX_TMP_12_FLAG_XVAL_GT_YVAL ; Do
    LDA TMP_12 ; Load flag.
    BNE RTS ; != 0, set, leave.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Set flag.
    ORA #$04
    STA 556_OBJ_STATUS_FLAGS_A[18],X
RTS: ; 1F:1621, 0x03F621
    RTS ; Leave.
FIND_PLAYER_FOCUS_HELPER: ; 1F:1622, 0x03F622
    LDA TWO_PLAYERS_FLAG ; Load 2P flag.
    BEQ EXIT_FOCUS_P1 ; Not set, 1P, goto.
    LDA OBJ_ANIMATION_DISPLAY[18] ; Load display P1.
    BEQ EXIT_FOCUS_P2 ; == 0, seed P2, goto.
    LDA OBJ_ANIMATION_DISPLAY+2 ; Load P2 display.
    BEQ EXIT_FOCUS_P1 ; == 0, seed P1, goto.
    TXA ; Xobj to A.
    LSR A ; >> 1, /2.
    CLC ; Prep add.
    ADC INF_LOOP_COUNTER ; Add with count.
    AND #$01 ; Keep 0000.0001
    BEQ EXIT_FOCUS_P1 ; == 0, goto.
EXIT_FOCUS_P2: ; 1F:1639, 0x03F639
    LDA #$02 ; Attr val.
    BNE EXIT_ATTR_SEEDED ; Always taken.
EXIT_FOCUS_P1: ; 1F:163D, 0x03F63D
    LDA #$00
EXIT_ATTR_SEEDED: ; 1F:163F, 0x03F63F
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    RTS
MOD_UPDATE_FLAG_&_0xFB: ; 1F:1643, 0x03F643
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    AND #$FB ; Keep 1111.1011
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    RTS
SUB_XOBJ_SET_UPDATE_ATTR_0x04: ; 1F:164C, 0x03F64C
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    ORA #$04
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    RTS
UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ: ; 1F:1655, 0x03F655
    TXA ; Save X.
    PHA
    TYA ; Y to A.
    JSR UPDATE_PALETTE[0x1C]_WITH_A_ENTRY
    PLA
    TAX ; Restore Xobj.
    RTS ; Leave.
    LDA #$30
    STA OBJ_ENABLED_STATE+MORE?+1,X
    LDA OBJ_POS_X_CONFIRMED[18],X
    STA OBJ_POS_X_CONFIRMED+1,X
    LDA OBJ_POS_X??[18],X
    STA OBJ_POS_X??+1,X
    STA OBJ_POS_Y_CONFIRMED+1,X
    RTS
CROSSBANK_SPAWN_OBJECT_RTN: ; 1F:1673, 0x03F673
    LDA #$22 ; Bank 0x02/0x03.
    JSR BANK_PAIR_USE_A ; Get pair in.
    JSR SPAWN_OBJECT_RTN ; Do other bank rtn.
    LDA #$2C ; Bank 0x0C/0x0D.
    JMP BANK_PAIR_USE_A ; Goto, abuse RTS.
L_1F:1680: ; 1F:1680, 0x03F680
    PHA
    LDA #$2A
    JSR BANK_PAIR_USE_A
    PLA
    JSR $87A0
    LDA #$20
    JMP BANK_PAIR_USE_A
QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE: ; 1F:168F, 0x03F68F
    LDX #$07 ; Xobj
LOOP_OBJS: ; 1F:1691, 0x03F691
    LDA OBJ_ENABLED_STATE+MORE?[18],X ; Load
    BEQ XOBJ_NOT_ENABLED ; If enable == 0x00, goto.
    INX ; Obj++
    CPX #$12 ; If Xobj _ #$12
    BCC LOOP_OBJS ; <, loop.
    CLC ; None found, fail.
    RTS
XOBJ_NOT_ENABLED: ; 1F:169D, 0x03F69D
    SEC
    RTS
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    RTS
OBJ_STATE_0x98_HANDLER: ; 1F:16B2, 0x03F6B2
    JSR X_MOVE_RET_CS_UNDERFLOW_CC_OKAY
    BCS 1F:16CB
    DEC OBJ_ANIM_HOLD_TIMER?[18],X
    BPL 1F:16B1
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    INC OBJ_ANIMATION_DISPLAY[18],X
    LDA OBJ_ANIMATION_DISPLAY[18],X
    CMP #$04
    BCC 1F:16B1
    JMP INIT_OBJECT[X]_DATA_FULL
FOCUS_EITHER_PLAYER_HELPER_RET_CS_FAIL_TO_FOCUS: ; 1F:16CE, 0x03F6CE
    LDA TWO_PLAYERS_FLAG ; Load flag.
    BNE TWO_PLAYERS ; != 0, goto.
    LDA #$00
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Force to P1 focus if only one player.
TWO_PLAYERS: ; 1F:16D7, 0x03F6D7
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load player focus.
    LSR A ; >> 1, /2. Index val of 0/1.
    TAY ; To index.
    LDA NUM_PLAYER_LIVES[2],Y ; Load lives for player.
    BPL RTS_CC ; If has, goto. Pass.
    LDA TWO_PLAYERS_FLAG ; Load flag
    BEQ RTS_CS ; 1P only, forced but no lives, fail.
    TYA ; Y to A. Attempting other player here.
    EOR #$01 ; Invert player.
    TAY ; Back to index.
    LDA NUM_PLAYER_LIVES[2],Y ; Get other players lives.
    BMI RTS_CS ; If negative, goto. No lives. Fail.
    TYA ; Index to A.
    ASL A ; << 1, *2. Focus 0/2.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set focus.
    JMP RTS_CC ; Leave CC, pass.
RTS_CS: ; 1F:16F6, 0x03F6F6
    SEC ; Fail, nobody to target.
    RTS
RTS_CC: ; 1F:16F8, 0x03F6F8
    CLC ; Pass. Target exists.
    RTS
FOCUS_FIND_CLOSEST_SEED_0x00: ; 1F:16FA, 0x03F6FA
    LDA #$00 ; Seed.
    BEQ A_SEED_ENTER ; Always taken.
FOCUS_FIND_SEED_0x80: ; 1F:16FE, 0x03F6FE
    LDA #$80 ; Seed.
A_SEED_ENTER: ; 1F:1700, 0x03F700
    STA TMP_01 ; Store seed.
    LDA TWO_PLAYERS_FLAG ; Load flag.
    BEQ RTS ; Not two players, leave.
    LDA NUM_PLAYER_LIVES[2] ; Load P1 Lives.
    ORA NUM_PLAYER_LIVES+1 ; Combine with P2.
    BMI RTS ; If either game over, RTS.
    SEC ; Prep sub.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load Xobj.pos
    PHA ; Save.
    SBC OBJ_POS_X_CONFIRMED[18] ; Sub P1.Xpos
    BCS DONT_INVERT_P1 ; Xobj.xpos >= P1.xpos
    EOR #$FF ; Compliment to find positive difference.
    CLC ; Carry was already clear, lol. Macro, probably. Mistake not mistake.
    ADC #$01
DONT_INVERT_P1: ; 1F:171B, 0x03F71B
    STA TMP_00 ; Store to TMP.
    PLA ; Restore Xpos.
    SEC
    SBC OBJ_POS_X_CONFIRMED+2 ; Sub P2.Xpos
    BCS DONT_INVERT_P2 ; Xobj.xpos >= P2.xpos, goto.
    EOR #$FF ; Compliment to find positive difference.
    CLC
    ADC #$01
DONT_INVERT_P2: ; 1F:1729, 0x03F729
    CMP TMP_00 ; If P2.diff - P1.diff
    LDA TMP_01 ; Load seed.
    BMI SEED_WAS_0x80 ; Goto seed.
    LDA #$00
    BCS COMMIT_FOCUS ; Write P1 focus.
    LDA #$02
COMMIT_FOCUS: ; 1F:1735, 0x03F735
    JMP COMMIT_FOCUS ; Write P2 focus.
SEED_WAS_0x80: ; 1F:1738, 0x03F738
    LDA #$00
    BCC COMMIT_FOCUS ; Always taken.
    LDA #$02
COMMIT_FOCUS: ; 1F:173E, 0x03F73E
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store player to focus on.
RTS: ; 1F:1741, 0x03F741
    RTS ; Leave.
RTN_BOX_DETECT?: ; 1F:1742, 0x03F742
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load index from OBJ.
    LDA OBJ_POS_X_CONFIRMED[18],Y ; Load from Yobj.
    STA TMP_14 ; Store to.
    LDA OBJ_POS_X??[18],Y ; Move
    STA TMP_15
HIT_DETECT_HELPER_UNK: ; 1F:174F, 0x03F74F
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    SEC ; Prep sub.
    SBC TMP_14 ; Sub with.
    STA TMP_12 ; Store result.
    BCS NO_UNDERFLOW_A ; No underflow, goto.
    EOR #$FF ; Compliment if underflow.
    CLC
    ADC #$01
NO_UNDERFLOW_A: ; 1F:175E, 0x03F75E
    STA TMP_10 ; Store result.
    LDA OBJ_POS_X??[18],X ; Load
    SEC ; Prep sub.
    SBC TMP_15 ; Sub with.
    STA TMP_13 ; Store result.
    BCS NO_UNDERFLOW_B ; No underflow, goto.
    EOR #$FF ; Compliment.
    CLC
    ADC #$01
NO_UNDERFLOW_B: ; 1F:176F, 0x03F76F
    STA TMP_11 ; Store result.
    RTS
SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK: ; 1F:1772, 0x03F772
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load from Xobj.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj
    CMP OBJ_POS_X_CONFIRMED[18],Y ; If X.Xpos _ Y.Xpos
    LDA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X ; Load
    AND #$03 ; Keep
    BCS DONT_MOD_DIRECTION ; >=, goto.
    ORA #$40 ; Set other direction.
DONT_MOD_DIRECTION: ; 1F:1784, 0x03F784
    STA OBJ_STATE_DIR_RELATED_C_SPR_DATA?[18],X
    RTS
MOVE_Y_FINALIZE: ; 1F:1788, 0x03F788
    CLC ; Prep add.
    LDA 4C6_OBJ_UNK[18],X ; Load
    ADC OBJ_POS_X??[18],X ; Add with.
    STA OBJ_POS_Y_CONFIRMED[18],X ; Store.
    RTS ; Leave.
SUB_OBJ_SPEED_AND_XPOS_STUFF: ; 1F:1793, 0x03F793
    SEC ; Prep sub.
    LDA OBJ_POS_X_SUBPIXEL?[18],X ; Load
    SBC OBJ_POS_X_SUBPIXEL_DELTA? ; Sub
    STA OBJ_POS_X_SUBPIXEL?[18],X ; Store back.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    SBC OBJ_POS_X_DELTA? ; Sub.
    BCS NO_UNDERFLOW ; If no underflow, goto.
    LDA #$00 ; Min.
NO_UNDERFLOW: ; 1F:17A5, 0x03F7A5
    STA OBJ_POS_X_CONFIRMED[18],X ; Set.
    LDA LEVEL/SCREEN_ON ; Load screen.
    CMP #$07 ; If _ #$07
    BNE RTS ; !=, oto.
    CLC ; Prep add.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    ADC #$04 ; Add 
    BCC NO_OVERFLOW ; If no overflow, goto.
    LDA #$00
NO_OVERFLOW: ; 1F:17B8, 0x03F7B8
    STA OBJ_POS_X_CONFIRMED[18],X ; Store
RTS: ; 1F:17BB, 0x03F7BB
    RTS
X_MOVE_RET_CS_UNDERFLOW_CC_OKAY: ; 1F:17BC, 0x03F7BC
    SEC ; Prep sub.
    LDA OBJ_POS_X_SUBPIXEL?[18],X ; Load 
    SBC OBJ_POS_X_SUBPIXEL_DELTA? ; Sub
    STA OBJ_POS_X_SUBPIXEL?[18],X ; Store back.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    SBC OBJ_POS_X_DELTA? ; Carry to upper.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to.
    BCC RTS_CS ; If underflow, leave with carry set.
    LDA LEVEL/SCREEN_ON ; Load level.
    CMP #$07 ; If _ #$07
    BNE LEVEL_NOT_SEVEN ; If not 7, ret CC.
    CLC ; Prep add.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load
    ADC #$04 ; Add
    BCC OUTPUT_XPOS ; If no overflow, write as-is.
    LDA #$00 ; Seed with val.
OUTPUT_XPOS: ; 1F:17DF, 0x03F7DF
    STA OBJ_POS_X_CONFIRMED[18],X ; Store XPOS.
LEVEL_NOT_SEVEN: ; 1F:17E2, 0x03F7E2
    CLC ; Return CC.
    RTS
RTS_CS: ; 1F:17E4, 0x03F7E4
    SEC ; Return CS.
    RTS
FIND_PLAYER_TO_FOCUS_ON_TO_OBJ: ; 1F:17E6, 0x03F7E6
    SEC ; Prep sub.
    LDA 4B4_OBJ_SPEED?[18],X ; Load
    SBC 83_UNK ; Sub.
    STA 4B4_OBJ_SPEED?[18],X ; Store back.
    LDA OBJ_POS_X??[18],X ; Load
    SBC 84_UNK ; Sub.
    BCS NO_UNDERFLOW ; No underflow, skip.
    LDA #$00 ; Min.
NO_UNDERFLOW: ; 1F:17F8, 0x03F7F8
    STA OBJ_POS_X??[18],X ; Store.
    RTS ; Leave.
FOCUS_CLOSEST_PLAYER: ; 1F:17FC, 0x03F7FC
    LDA TWO_PLAYERS_FLAG ; Load
    BEQ RTS_FOCUS_P1 ; If not set, one player game, set obj and leave.
    LDA NUM_PLAYER_LIVES[2] ; Load P1 lives.
    ORA NUM_PLAYER_LIVES+1 ; Combine with P2 lives.
    BPL 2P_2_ALIVE ; Both have lives.
    LDY NUM_PLAYER_LIVES[2] ; Y from P1 lives.
    BPL RTS_FOCUS_P1 ; If 1P has lives, goto.
    LDA #$02 ; Extra set.
    LDY NUM_PLAYER_LIVES+1 ; Load P2 lives. This code is weird.
    BPL RTS_STORE_FOCUS_TO_OBJ ; P2 has lives, goto.
    JMP RTS_FOCUS_P1 ; Clear extra otherwise.
2P_2_ALIVE: ; 1F:1813, 0x03F813
    LDY #$00 ; Obj index, P1.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load XObj.XPos
    SEC ; Prep sub.
    SBC OBJ_POS_X_CONFIRMED[18],Y ; Sub P1.XPos
    BCS SKIP_COMPLEMENT ; If no underflow, skip complement.
    EOR #$FF ; Two compliment.
    CLC
    ADC #$01
SKIP_COMPLEMENT: ; 1F:1823, 0x03F823
    STA TMP_00 ; Store different between P1 and OBJ.
    LDY #$02 ; Obj index, P2.
    LDA OBJ_POS_X_CONFIRMED[18],X ; Load Xobj.XPos
    SEC ; Prep sub.
    SBC OBJ_POS_X_CONFIRMED[18],Y ; Sub P2.XPos
    BCS SKIP_COMPEMENT_P2
    EOR #$FF ; Compliment
    CLC
    ADC #$01
SKIP_COMPEMENT_P2: ; 1F:1835, 0x03F835
    CMP TMP_00 ; Compare differences.
    LDA #$02 ; Focus P2.
    BCC RTS_STORE_FOCUS_TO_OBJ ; If P2 diff < P1 diff, goto, storing obj 2 focus.
RTS_FOCUS_P1: ; 1F:183B, 0x03F83B
    LDA #$00 ; Clear.
RTS_STORE_FOCUS_TO_OBJ: ; 1F:183D, 0x03F83D
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Clear.
    RTS
XOBJ_WRITE_PLAYER_FOCUS: ; 1F:1841, 0x03F841
    LDA TWO_PLAYERS_FLAG ; Load 2P flag.
    BEQ 1P_GAME ; Not set, goto.
    LDA TMP_0D ; Load.
    LSR A ; >> 1, /2.
    LDY #$02 ; P2 obj index.
    BCS USE_INDEX ; If shifted off 1, goto.
1P_GAME: ; 1F:184C, 0x03F84C
    LDY #$00 ; P1 Index if shifted off zero.
USE_INDEX: ; 1F:184E, 0x03F84E
    TYA ; Index val to A.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to OBJ.
    RTS ; leave.
MOVE_UNK_RET_??_SEEDED_VAL: ; 1F:1853, 0x03F853
    LDA #$40 ; Val.
    BNE MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE ; Always taken. Mistake, next line lol.
MOVE_UNK_RET_CS_POS_CS_NEG_ADD_USE: ; 1F:1857, 0x03F857
    CLC ; Prep add.
    ADC 544_OBJ_UNK_POS_DELTA?[18],X ; Add
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Store.
    BCC MOVE_UNK_RET_CS_POS_CS_NEG
    INC 532_OBJ_UNK_POS_DELTA?[18],X ; Inc if overflow.
MOVE_UNK_RET_CS_POS_CS_NEG: ; 1F:1863, 0x03F863
    CLC ; Prep add.
    LDA 544_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC 4D8_OBJ_UNK[18],X ; Add
    STA 4D8_OBJ_UNK[18],X ; Store.
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load
    ADC 4C6_OBJ_UNK[18],X ; Add
    STA 4C6_OBJ_UNK[18],X ; Store.
    BPL CARRY_SET_RET ; If positive result, ret CS.
    CLC ; Carry cleared if negative.
    RTS
CARRY_SET_RET: ; 1F:187A, 0x03F87A
    SEC ; Carry set if positive.
    RTS
XPOS_MOD_DELTA_RET_CS_WRAPAROUND: ; 1F:187C, 0x03F87C
    CLC ; Prep add.
    LDA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Load
    ADC OBJ_POS_X_SUBPIXEL?[18],X ; Add with.
    STA OBJ_POS_X_SUBPIXEL?[18],X ; Store.
    LDA OBJ_POS_X_DELTA?[18],X ; Load
    ADC OBJ_POS_X_CONFIRMED[18],X ; Add with, carried.
    STA OBJ_POS_X_CONFIRMED[18],X ; Store to.
    ROR A ; Rotate carry into A.
    EOR OBJ_POS_X_DELTA?[18],X ; Invert carry for top bit because negative carries other way.
    ASL A ; Shift carry back. Will now be correct for add and sub.
    RTS ; RTS
MOVE_UNK_RET_??: ; 1F:1895, 0x03F895
    .db 18 ; Prep add.
    LDA 520_OBJ_POS_X_LARGE?[18],X ; Load
    ADC 4B4_OBJ_SPEED?[18],X ; Add with.
    STA 4B4_OBJ_SPEED?[18],X ; Store back.
    LDA 503_OBJ_POS_X_LARGEST?[18],X ; Load
    ADC OBJ_POS_X??[18],X ; Add with.
    STA OBJ_POS_X??[18],X ; Store back.
    ROR A ; Shift value final.
    EOR 503_OBJ_POS_X_LARGEST?[18],X ; Exclusive or with.
    ASL A ; Shift back.
    RTS ; Leave.
DATA_A: ; 1F:18AE, 0x03F8AE
    .db 02
    .db 03
    .db 04
    .db 05
    .db 01
    .db 00
DATA_B: ; 1F:18B4, 0x03F8B4
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
DATA_C: ; 1F:18C1, 0x03F8C1
    .db 17
    .db 18
    .db 17
    .db 1C
    .db 1B
DATA_D: ; 1F:18C6, 0x03F8C6
    .db 1E
    .db 1E
    .db 25
    .db 26
    .db 27
DATA_E: ; 1F:18CB, 0x03F8CB
    .db 29
    .db 29
    .db 29
    .db 2A
    .db 2B
    .db 2C
DATA_F: ; 1F:18D1, 0x03F8D1
    .db 2D
    .db 2E
    .db 2F
    .db 30
    .db 31
OBJ_DATA_A_LOW: ; 1F:18D6, 0x03F8D6
    LOW(DATA_A)
OBJ_DATA_A_HIGH: ; 1F:18D7, 0x03F8D7
    HIGH(DATA_A)
    LOW(DATA_A)
    HIGH(DATA_A)
    LOW(DATA_B)
    HIGH(DATA_B)
    LOW(DATA_C)
    HIGH(DATA_C)
    LOW(OBJ_DATA_A_LOW) ; Pre-named?
    HIGH(OBJ_DATA_A_LOW)
    LOW(DATA_D)
    HIGH(DATA_D)
    LOW(DATA_E)
    HIGH(DATA_E)
    LOW(DATA_E)
    HIGH(DATA_E)
    LOW(DATA_F)
    HIGH(DATA_F)
    LOW(OBJ_DATA_A_LOW) ; Pre-named?
    HIGH(OBJ_DATA_A_LOW)
    LOW(DATA_F)
    HIGH(DATA_F)
    LOW(DATA_F)
    HIGH(DATA_F)
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
    STA IRQ_FLAG_R2-R5_GFX_USE_BANK_7E ; Use GFX.
    STA FLAG_IRQ_ENABLE ; Disable IRQ.
    STA IRQ_56_OR'D ; Clear. ?? TODO.
MAPPER_IRQ_DISABLE+RTS: ; 1F:191A, 0x03F91A
    STA MMC3_IRQ_DISABLE
    RTS
ENABLE_IRQ?: ; 1F:191E, 0x03F91E
    LDA #$80
    STA FLAG_IRQ_ENABLE ; Set
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
    ORA FLAG_IRQ_ENABLE ; Or passed with value.
    STA IRQ_56_OR'D ; To addr.
    LDA IRQ_LATCH_VALUES,Y ; Load data.
    STA 57_IRQ_LATCH_VAL_COPY ; Store to.
    TYA ; IRQ selection index back to A.
    ASL A ; Shift to make word index.
    TAY ; Back to Y again.
    LDA IRQ_RTNS_LOWER,Y ; Store IRQ addr.
    STA IRQ_HANDLER_JMP+1 ; Set JMP addr.
    LDA IRQ_RTNS_UPPER,Y
    STA IRQ_HANDLER_JMP+2
    LDA #$4C ; JMP opcode.
    STA IRQ_HANDLER_JMP[3] ; Store always.
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
    HIGH(IRQ_RTN_DISABLE_IRQ) ; 0x00
    LOW(IRQ_RTN_B) ; Normal, gfx and whatnot.
    HIGH(IRQ_RTN_B) ; 0x01
    LOW(IRQ_RTN_C) ; Just a bit diff...
    HIGH(IRQ_RTN_C) ; 0x02
    LOW(IRQ_RTN_D) ; Pretty normal, gfx.
    HIGH(IRQ_RTN_D) ; 0x03
    LOW(IRQ_RTN_E) ; BG GFX swap.
    HIGH(IRQ_RTN_E) ; 0x04
    LOW(IRQ_RTN_F) ; Chr update.
    HIGH(IRQ_RTN_F) ; 0x05
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F) ; 0x06
    LOW(IRQ_RTN_G) ; Scrolling down diagonal sections?
    HIGH(IRQ_RTN_G) ; 0x07
    LOW(IRQ_RTN_H) ; Not much diff.
    HIGH(IRQ_RTN_H) ; 0x08
    LOW(IRQ_RTN_I) ; Secondary can switch.
    HIGH(IRQ_RTN_I) ; 0x09
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F) ; 0x0A
    LOW(IRQ_RTN_I)
    HIGH(IRQ_RTN_I) ; 0x0B
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F) ; 0x0C
    LOW(IRQ_RTN_J) ; Alternate scrolling values?
    HIGH(IRQ_RTN_J) ; 0x0D
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F) ; 0x0E
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F) ; 0x0F
    LOW(IRQ_RTN_J)
    HIGH(IRQ_RTN_J) ; 0x10
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F) ; 0x11
    LOW(IRQ_RTN_I)
    HIGH(IRQ_RTN_I) ; 0x12
    LOW(IRQ_RTN_F)
    HIGH(IRQ_RTN_F) ; 0x13
    LOW(IRQ_RTN_K) ; Does a bit, similar still.
    HIGH(IRQ_RTN_K) ; 0x14
    LOW(IRQ_RTN_L) ; Does a bit, still not too dissimilar.
    HIGH(IRQ_RTN_L) ; 0x15
IRQ_RTN_DISABLE_IRQ: ; 1F:198A, 0x03F98A
    STA MMC3_IRQ_DISABLE ; These two looking kinda sus.
    RTI
IRQ_UPDATING_RTN: ; 1F:198E, 0x03F98E
    LDA FLAG_IRQ_ENABLE ; Load val.
    BEQ MAPPER_IRQ_DISABLE+RTS ; No val, disable IRQ's and leave.
    STA MMC3_IRQ_DISABLE ; Disable.
    STA MMC3_IRQ_ENABLE ; Enable.
    LDA PPU_STATUS ; Reset latch.
    LDA #$00
    STA PPU_SCROLL ; Set scroll.
    STA PPU_SCROLL
    LDA PPU_STATUS ; Reset latch again.
    LDA #$FF
    STA MMC3_IRQ_LATCH ; Write latch value.
    STA MMC3_IRQ_RELOAD ; Reload.
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
    LDY #$30 ; Latch value default.
    LDX LEVEL/SCREEN_ON ; Get level.
    DEX ; X-=2
    DEX
    BNE SCREEN_NOT_2 ; Level/screen != 2
    DEY ; Latch -= 2 scanlines. Move up screen.
    DEY
    BNE COMMIT_Y_VAL_LATCH ; Use this.
SCREEN_NOT_2: ; 1F:19E2, 0x03F9E2
    LDA PPU_FLAG_UNK_MODIFY_LATCH_UNK ; Load
    BEQ COMMIT_Y_VAL_LATCH ; == 0, unset. Use latch as-is.
    DEY ; Latch -= 1 scanline. Move up screen.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$02 ; Test if even and non-zero.
    BNE COMMIT_Y_VAL_LATCH ; True, keep latch as-is.
    INY ; Latch += 2 scanlines. Move down screen.
    INY
COMMIT_Y_VAL_LATCH: ; 1F:19F0, 0x03F9F0
    STY MMC3_IRQ_LATCH ; Store latch.
    STA MMC3_IRQ_RELOAD ; Reload it.
    STA MMC3_IRQ_ENABLE ; Enable IRQ's.
    CLI ; Enable interrupt disable.
    LDA 660_FLAG_IRQ_I_RESET+DA_CLEAR_UNK ; Load flag.
    BEQ FLAG_660_NOT_SET ; Not set, don't clear.
    LDA #$00 ; Clear value.
    STA FLAG_IRQ_I_SECONDARY_KEEP_IF_POSITIVE ; Clear.
    STA DA_FLAG?_UNK ; Clear unk.
    STA 660_FLAG_IRQ_I_RESET+DA_CLEAR_UNK ; Clear flag.
FLAG_660_NOT_SET: ; 1F:1A08, 0x03FA08
    LDA IRQ_CONFIG_CHANGE ; Load
    BEQ NO_IRQ_CONFIG_CHANGE ; If not set, goto.
    ASL A ; Val to index.
    TAY ; To Y.
    LDA D9_DATA,Y ; Move config.
    STA D9_IRQ_CONFIG_A
    LDA D8_DATA,Y
    STA D8_IRQ_CONFIG_B
    LDA #$00
    STA IRQ_CONFIG_CHANGE ; Clear val.
NO_IRQ_CONFIG_CHANGE: ; 1F:1A1E, 0x03FA1E
    LDA D9_IRQ_CONFIG_A ; Load
    CMP #$04 ; If A _ 0x04
    BEQ CONFIG_A_EQ_0x04 ; ==, goto.
    CMP #$07 ; A _ 0x07
    BNE USE_IRQ_RTNS_BASED_ON_LEVEL ; CFG_A != 0x04 | 0x07, level decides IRQ handler.
    LDA #$15 ; Load. Alt for CFG_A == 0x07.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Do.
    LDA #$12 ; Load.
    BNE SET_EXTENDED_IRQ_FROM_A ; Always taken.
CONFIG_A_EQ_0x04: ; 1F:1A31, 0x03FA31
    LDA #$15 ; Load. Alt for XFG_A == 0x04
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Do.
    LDA #$0B ; Load.
    BNE SET_EXTENDED_IRQ_FROM_A ; Always taken.
USE_IRQ_RTNS_BASED_ON_LEVEL: ; 1F:1A3A, 0x03FA3A
    LDX LEVEL/SCREEN_ON ; Index from.
    LDA IRQ_HANDLER_PER_LEVEL,X ; Load data.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Do.
    LDX LEVEL/SCREEN_ON ; Re-load.
    LDA IRQ_EXTENSION_PER_SCREEN,X ; Data from.
SET_EXTENDED_IRQ_FROM_A: ; 1F:1A47, 0x03FA47
    STA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Store to.
    LDA #$00 ; Switch R0/R1 to status bar GFX.
    JSR SETUP_R0/R1_IRQ_DATA ; Set up.
    JSR SCRIPT_GFX_R0-R1_TO_MAPPER ; Swap to.
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
IRQ_EXTENSION_PER_SCREEN: ; 1F:1A64, 0x03FA64
    .db 04 ; 0x00
    .db 04 ; 0x01
    .db 02 ; 0x02
    .db 00 ; 0x03
    .db 09 ; 0x04
    .db 00 ; 0x05
    .db 09 ; 0x06
    .db 0F ; 0x07
    .db 06 ; 0x08
    .db 06 ; 0x09
    .db 06 ; 0x0A
    .db 06 ; 0x0B
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
    LDA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Load extend.
    BNE REPLACE_RTN ; Set, goto.
    STA MMC3_IRQ_DISABLE ; Disable IRQ.
    JMP IRQ_WAIT/PPU/UNK/GFX/CFG_GENERAL
REPLACE_RTN: ; 1F:1A89, 0x03FA89
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Assign mapper things from A.
    LDA 57_IRQ_LATCH_VAL_COPY ; Load latch.
    STA MMC3_IRQ_LATCH ; Store to mapper.
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
    LDX COMMITTED_SCROLL_X?
    LDY PPU_SCROLL_Y_COPY_IRQ
    LDA COMMITTED_NAMETABLE_FOCUS_VAL?
    AND #$01 ; Isolate.
    ORA PPU_CTRL_RAM_COPY ; Set to proper nametable.
    STX PPU_SCROLL ; Set X and Y scroll. Bonus points for proper registers.
    STY PPU_SCROLL
    STA PPU_CTRL ; Set CTRL.
    LDA IRQ_R0/R1_BANK_VALS[2]
    STA SCRIPT_R0-R5_GFX_BANK_VALS[6]
    LDA IRQ_R0/R1_BANK_VALS+1
    STA SCRIPT_R0-R5_GFX_BANK_VALS+1
    JSR SCRIPT_GFX_R0-R1_TO_MAPPER ; Switch graphics.
    LDA #$00
    STA IRQ_FLAG_R2-R5_GFX_USE_BANK_7E ; Use RAM ones, not 0x7E.
    JSR COMMITTED_R2-R5_TO_MAPPER ; Switch graphics.
    LDX LEVEL/SCREEN_ON ; X from
    LDA RTN_EXTRA_DATA,X
    STA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE
RTI_AND_RESTORE_BANK_CFG: ; 1F:1AD4, 0x03FAD4
    LDX BANK_CFG_RESTORE_INDEX ; X from.
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
    LDA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Set next.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A
    LDA 57_IRQ_LATCH_VAL_COPY ; Set latch.
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
    STA IRQ_FLAG_R2-R5_GFX_USE_BANK_7E ; From RAM.
    JSR COMMITTED_R2-R5_TO_MAPPER ; Set GFX.
    LDA IRQ_R0/R1_BANK_VALS[2] ; Move BG banks wanted.
    STA SCRIPT_R0-R5_GFX_BANK_VALS[6]
    LDA IRQ_R0/R1_BANK_VALS+1
    STA SCRIPT_R0-R5_GFX_BANK_VALS+1
    JSR SCRIPT_GFX_R0-R1_TO_MAPPER ; Commit to hardware.
    LDA FLAG_IRQ_I_SECONDARY_KEEP_IF_POSITIVE ; Load.
    BPL VAL_POSITIVE ; Positive, don't set other secondary.
    LDX A7_IRQ_REPLACE_SECONDARY_INDEX ; Load index.
    LDA IRQ_L_SECONDARY_DATA,X ; Load next secondary.
    JMP SET_SECONDARY ; Store to.
VAL_POSITIVE: ; 1F:1B4A, 0x03FB4A
    LDA D9_IRQ_CONFIG_A ; Load
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
    STA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Set secondary.
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
    STA IRQ_FLAG_R2-R5_GFX_USE_BANK_7E ; Use from RAM.
    JSR COMMITTED_R2-R5_TO_MAPPER ; Set GFX.
    LDA #$7E
    STA SCRIPT_R0-R5_GFX_BANK_VALS[6] ; Set manually to 7E.
    STA SCRIPT_R0-R5_GFX_BANK_VALS+1
    JSR SCRIPT_GFX_R0-R1_TO_MAPPER ; Switch in.
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
    STY IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Store to.
    TYA ; To A
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Set handler somehow.
    LDA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Load
    CMP #$06 ; If _ 6
    BEQ HANDLER_3_BANK_MOVED? ; ==, goto.
    LDA IRQ_LATCH_VALUE_COPY_5A ; Load val.
    CMP #$01 ; If _ 1
    BNE LATCH_NOT_1 ; !=, goto.
    LDA 58_IRQ_UNK ; Load
    CMP #$B8 ; If _ B8
    BEQ LATCH_NOT_1 ; ==, goto. Don't inc var.
    INC 57_IRQ_LATCH_VAL_COPY ; Inc var
LATCH_NOT_1: ; 1F:1BF2, 0x03FBF2
    LDA 57_IRQ_LATCH_VAL_COPY ; Load
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
    LDA 57_IRQ_LATCH_VAL_COPY ; Load IRQ bank.
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
    LDA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Load
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A
    LDA PPU_STATUS ; Reset
    LDX COMMITTED_SCROLL_X? ; Set scroll.
    LDY PPU_SCROLL_Y_COPY_IRQ
    LDA COMMITTED_NAMETABLE_FOCUS_VAL?
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
    LDA IRQ_R0/R1_BANK_VALS[2] ; Move bank vals.
    STA SCRIPT_R0-R5_GFX_BANK_VALS[6]
    LDA IRQ_R0/R1_BANK_VALS+1
    STA SCRIPT_R0-R5_GFX_BANK_VALS+1
    JSR SCRIPT_GFX_R0-R1_TO_MAPPER ; Swap GFX.
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
    LDA COMMITTED_NAMETABLE_FOCUS_VAL? ; Load
    AND #$01 ; Keep bottom bit.
    ORA PPU_CTRL_RAM_COPY ; Set base nametable for PPUCTRL.
    TAX ; Save to X.
    LDY #$C0 ; Y=
    LDA PPU_STATUS ; Reset latch.
    LDA #$20
    STA PPU_ADDR ; Addr 20C0.
    STY PPU_ADDR
    STX PPU_CTRL ; Store PPU CTRL.
    LDA COMMITTED_SCROLL_X? ; Load ammount X scrolling.
    STA PPU_SCROLL ; Store to X.
    STA PPU_SCROLL ; And Y.
    LDX #$00
    STX MMC3_BANK_CFG ; Reset bank cfg, R0.
    LDA IRQ_R0/R1_BANK_VALS[2] ; Load bank.
    STA MMC3_BANK_DATA ; Store.
    INX ; R1
    STX MMC3_BANK_CFG ; R1.
    LDA IRQ_R0/R1_BANK_VALS+1 ; Load R1.
    STA MMC3_BANK_DATA ; Store.
    LDX BANK_CFG_RESTORE_INDEX ; Set previous CFG.
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
    LDA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Load extended.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Set next.
    LDA 57_IRQ_LATCH_VAL_COPY ; Set latch.
    STA MMC3_IRQ_LATCH
    LDA PPU_STATUS ; Reset PPU latch.
    LDX SCRIPT_SCROLL_X?[2] ; Load X scroll.
    LDY PPU_SCROLL_Y_COPY_IRQ ; Load Y scroll.
    LDA SCRIPT_NAMETABLE_FOCUS_VAL?[2] ; Load nametable focus.
    AND #$01 ; Keep focus bit.
    ORA PPU_CTRL_RAM_COPY ; Set PPU otherwise.
    STX PPU_SCROLL ; Store scroll.
    STY PPU_SCROLL ; Store scroll.
    STA PPU_CTRL ; Store nametable.
    LDA FLAG_IRQ_I_SECONDARY_KEEP_IF_POSITIVE ; Load..
    BPL EXIT_IRQ ; Is positive, keep secondary as is.
    LDX A7_IRQ_REPLACE_SECONDARY_INDEX ; Index.
    LDA IRQ_SECONDARY_NEXT,X ; Get value.
    STA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Next one is this instead.
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
    LDA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Load val
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Handler from.
    LDA 57_IRQ_LATCH_VAL_COPY ; Load val.
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
    STA SCRIPT_R0-R5_GFX_BANK_VALS+1 ; Change to bank.
    JSR SCRIPT_GFX_R0-R1_TO_MAPPER ; Swap BG GFX
    LDA #$05 ; A=
    STA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Change handler.
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
    LDA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Load.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A ; Set.
    LDA 57_IRQ_LATCH_VAL_COPY ; Load.
    STA MMC3_IRQ_LATCH ; Store.
    LDX #$08 ; Delay val.
DELAY_LOOP: ; 1F:1D49, 0x03FD49
    DEX ; X--
    BNE DELAY_LOOP ; != 0, keep delaying.
    LDA #$01
    STA IRQ_FLAG_R2-R5_GFX_USE_BANK_7E ; Set flag.
    JSR COMMITTED_R2-R5_TO_MAPPER ; Write values.
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
    STA IRQ_FLAG_R2-R5_GFX_USE_BANK_7E ; True, set to 7E.
    JSR COMMITTED_R2-R5_TO_MAPPER ; Switch GFX for sprites.
    JMP RTI_AND_RESTORE_BANK_CFG ; Commit, abuse RTI.
IRQ_RTN_J: ; 1F:1D6E, 0x03FD6E
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    STA MMC3_IRQ_DISABLE ; IRQ Disable.
    STA MMC3_IRQ_ENABLE
    LDA IRQ_EXTENDED/HANDLER/SECONDARY_REPLACE ; Set secondary.
    JSR SET_IRQ_LATCH_COPY_AND_HANDLER_FROM_A
    LDA 57_IRQ_LATCH_VAL_COPY ; Set latch.
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
    JSR SOUND_RESET/INIT_RTN? ; Sound.
    JSR INITIAL_PALETTE_TO_CREATED_UPDATE
    JSR ENABLE_NMI+INIT_UNK
    CLI ; Enable interrupts.
INFINITE_LOOP: ; 1F:1DE7, 0x03FDE7
    INC INF_LOOP_COUNTER ; Inc
    CLC
    LDA INF_LOOP_COUNTER ; Load
    ADC IRQ/SCRIPT_RUN_COUNT? ; Add with...
    STA INF_LOOP_COUNTER ; Store back.
    JMP INFINITE_LOOP ; Loop forever.
FRAME_OVERRUN_NMI: ; 1F:1DF3, 0x03FDF3
    JSR SET_PPU_ADDR/SCROLL/CTRL ; Set scroll.
    JSR IRQ_UPDATING_RTN
    JSR SCRIPT_GFX_R0-R1_TO_MAPPER
    JSR WRITE_R2-R5_FROM_RAM
    JSR SOUND_FORWARD
    LDX BANK_CFG_RESTORE_INDEX ; Load
    LDA COPY_BANK_CFG_F5,X ; Load from index.
    STA MMC3_BANK_CFG ; Restore config set.
    JMP RTI_RESTORE_AXY ; Leave NMI.
NMI_HANDLER: ; 1F:1E0C, 0x03FE0C
    PHA ; Save A.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    LDA PPU_STATUS ; Reset latch.
    LDY FLAG_FRAME_UNFINISHED ; Load flag.
    BNE FRAME_OVERRUN_NMI ; If set, do this instead. No scripty things, as not completed previously.
    INC FLAG_FRAME_UNFINISHED ; Set to true.
    LDA #$00
    STA PPU_OAM_ADDR ; Set addr.
    LDY #$02
    STY OAM_DMA ; Upload sprites from 0x0200.
    JSR DISABLE_PPU_RENDERING
    JSR PPU_UPDATE_BUFFER_COMMIT ; Upload all PPU update packets.
    JSR PPU_ONEOFF_ATTRMOD? ; Set one-off attributes needing modification? TODO: Find use, verify.
    LDA PPU_MASK_RAM_COPY ; Load mask
    LDX DISABLE_RENDERING_X_FRAMES ; X from
    BEQ WRITE_ENABLED_MASK ; == 0, skip.
    DEC DISABLE_RENDERING_X_FRAMES ; Frames--
    BEQ WRITE_ENABLED_MASK ; If now 0, enable.
    AND #$E7 ; Disable sprites and BG.
WRITE_ENABLED_MASK: ; 1F:1E39, 0x03FE39
    STA PPU_MASK ; Store mask, usually enabling background.
    JSR SET_PPU_ADDR/SCROLL/CTRL ; Set PPU display attrs.
    JSR IRQ_UPDATING_RTN ; IRQ stuffs here. <<<<<<<<<<<<<<<<<<<<<
    LDA MMC3_MIRRORING_COPY ; Load copy.
    STA MMC3_MIRRORING ; Store to mapper.
    LDX #$00 ; Index 0. Mistake: counts up, smh.
LOOP_MOVE_3DATA: ; 1F:1E49, 0x03FE49
    LDA SCRIPT_VAL_UNK[2],X ; Move unk...
    STA COMMITTED_UNK_VAL[2],X
    LDA SCRIPT_SCROLL_X?[2],X
    STA COMMITTED_SCROLL_X?,X
    LDA SCRIPT_NAMETABLE_FOCUS_VAL?[2],X
    STA COMMITTED_NAMETABLE_FOCUS_VAL?,X
    INX ; X++
    CPX #$02 ; If X _ #$02
    BNE LOOP_MOVE_3DATA ; Move both sets.
    JSR COMMIT_SCRIPT_R2-R5_VALS
    JSR COMMITTED_R2-R5_TO_MAPPER
    JSR SCRIPT_GFX_R0-R1_TO_MAPPER
    JSR SOUND_FORWARD
    JSR CTRL_READ_SAFE ; Read controllers.
    JSR UPDATE_BUF_FILL_EXTRAS ; Puts ppu update packets to buffer.
    JSR GAME_SCRIPT_SWITCHES ; Game script, you're probably looking for this. <<<<<<<<<<<<<<<
    JSR DISPLAY_OBJECTS_ROUTINE ;  Order, display, blank leftovers.
    LDX PPU_UPDATE_BUF_INDEX ; Load index.
    LDA #$00 ; Load
    STA PPU_UPDATE_BUFFER[64],X ; Store EOF in buf.
    INX ; X++
    STX PPU_UPDATE_BUF_INDEX ; Store index past EOF for this group.
    STA FLAG_FRAME_UNFINISHED ; Clear flag.
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
WRITE_PPU_COPY_TO_CTRL: ; 1F:1EA1, 0x03FEA1
    LDA PPU_CTRL_RAM_COPY ; Set CTRL.
    STA PPU_CTRL
    RTS
SET_APU_STATUS+SEQUENCE_F_C0: ; 1F:1EA7, 0x03FEA7
    LDA #$0F
    STA APU_STATUS ; Set status.
    LDA #$C0
    STA APU_FSEQUENCE ; Set sequence.
    RTS
ENABLE_NMI+INIT_UNK: ; 1F:1EB2, 0x03FEB2
    LDA #$A8 ; Load. NMI, LSprites, Sprites table 1.
    STA PPU_CTRL_RAM_COPY ; Store
    STA PPU_CTRL ; Store.
    LDA #$1E
    STA PPU_MASK_RAM_COPY ; Mask RAM copy?
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
    LDA PPU_MASK_RAM_COPY ; Load...copy?
    AND #$E7 ; Disable rendering both sprites and BG.
    STA PPU_MASK ; Store.
    RTS
CTRL_READ_SAFE: ; 1F:1ED9, 0x03FED9
    LDX #$00 ; Index to store ctrl bits.
    JSR LATCH_READ_CTRL
    LDX #$02 ; Index to store other ctrl bits.
    JSR LATCH_READ_CTRL
    LDA TMP_00 ; Load first bits.
    CMP TMP_02 ; Compare to 2nd read.
    BNE CTRL_FAIL_NO_NEW_PRESSES ; !=, goto.
    LDA TMP_01 ; Load first bits.
    CMP TMP_03 ; Compare to 2nd read.
    BNE CTRL_FAIL_NO_NEW_PRESSES ; Same idea.
    LDX #$00 ; P1 index.
    JSR CTRL_X_PROCESS ; Process
    INX ; P2 index.
CTRL_X_PROCESS: ; 1F:1EF5, 0x03FEF5
    LDA TMP_00,X ; Load CTRL buttons now.
    TAY ; To Y
    EOR CTRL_PREV_B[2],X ; Get newly pressed only. Turns off pressed previously.
    AND TMP_00,X ; Newly pressed only by anding with pressed now.
    STA CTRL_NEWLY_PRESSED_A[2],X
    STA CTRL_NEWLY_PRESSED_B[2],X
    STY CTRL_PREV_A[2],X
    STY CTRL_PREV_B[2],X
    RTS ; Leave to main program/jsr.
CTRL_FAIL_NO_NEW_PRESSES: ; 1F:1F05, 0x03FF05
    LDA #$00
    STA CTRL_NEWLY_PRESSED_A[2] ; Clear all newly pressed.
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
    BNE LOOP_READ_CTRL ; != 0, loop more buttons.
    RTS ; Done, leave.
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
    LOW(NMI_HANDLER) ; NMI handler ptr.
    HIGH(NMI_HANDLER)
VECTOR_RESET: ; 1F:1FFC, 0x03FFFC
    LOW(RESET_HANDLER) ; Reset handler ptr.
    HIGH(RESET_HANDLER)
VECTOR_IRQ/BRK: ; 1F:1FFE, 0x03FFFE
    LOW(IRQ_HANDLER_JMP) ; IRQ handler ptr.
    HIGH(IRQ_HANDLER_JMP)
