    .db 24
RTN_MAP_MOVABILITY_UPDATES?: ; 04:0001, 0x008001
    LDA LEVEL/SCREEN_ON ; Load screen.
    CMP #$0B ; If _ #$0B
    BEQ RTS ; ==, leave.
    CMP #$07 ; If _ #$07
    BEQ RTS ; ==, leave.
    LDA LEVEL/SCREEN_ON ; Load on otherwise.
    ASL A ; << 1, *2
    TAY ; To Y index.
    LDA LEVEL_DATA_UNK_PTR_L,Y ; Move data.
    STA TMP_00
    LDA LEVEL_DATA_UNK_PTR_H,Y
    STA TMP_01
    LDY 60B_STREAM_INDEX_MAP? ; Y from.
    LDA [TMP_00],Y ; Load from stream.
    CMP #$FF ; If _ #$FF
    BEQ RTS ; ==, leave.
    LDA SCRIPT_NAMETABLE_FOCUS_VAL?[2] ; Load focus.
    CMP [TMP_00],Y ; Compare to stream.
    BEQ SKIP_OTHER_CHECKS ; ==, goto.
    BCS INDEX_RTN_UNK ; >=, goto.
    BCC RTS ; <, leave.
SKIP_OTHER_CHECKS: ; 04:002C, 0x00802C
    LDA SCRIPT_SCROLL_X?[2] ; Load
    INY ; Stream++
    CMP [TMP_00],Y ; If scroll _ stream
    BCC RTS ; <, leave.
INDEX_RTN_UNK: ; 04:0033, 0x008033
    LDX #$00 ; Reset index.
LOOP_INDEXES: ; 04:0035, 0x008035
    LDA 670_MAP_DATA_A,X ; Load from.
    BEQ ARR_VALUE_ZERO_RTN ; ==, goto.
    INX ; Index++
    CPX #$04 ; If _ #$04
    BNE LOOP_INDEXES ; !=, loop.
RTS: ; 04:003F, 0x00803F
    RTS ; Leave.
ARR_VALUE_ZERO_RTN: ; 04:0040, 0x008040
    INY ; Stream++
    LDA [TMP_00],Y ; Load from stream.
    STA 670_MAP_DATA_A,X ; Store to array. Done 6x total, two auto clears.
    INY
    LDA [TMP_00],Y
    STA 688_MAP_DATA_G,X
    INY
    LDA [TMP_00],Y ; Move.
    STA 678_MAP_DATA_C,X
    INY
    LDA [TMP_00],Y
    STA 680_MAP_DATA_E,X
    INY
    LDA [TMP_00],Y
    STA 68C_MAP_DATA_H,X
    INY
    LDA [TMP_00],Y
    STA 684_MAP_DATA_F,X
    LDA #$00
    STA 67C_MAP_DATA_D,X ; Clear these.
    STA 674_MAP_DATA_B,X
    INY ; Stream++
    STY 60B_STREAM_INDEX_MAP? ; Store stream index back.
    RTS
RTS: ; 04:0071, 0x008071
    .db 60
LEVEL_DATA_UNK_PTR_L: ; 04:0072, 0x008072
    LOW(DATA_UNK_A)
LEVEL_DATA_UNK_PTR_H: ; 04:0073, 0x008073
    HIGH(DATA_UNK_A)
    LOW(DATA_UNK_A)
    HIGH(DATA_UNK_A)
    LOW(DATA_UNK_B)
    HIGH(DATA_UNK_B)
    LOW(DATA_UNK_C)
    HIGH(DATA_UNK_C)
    LOW(DATA_UNK_D)
    HIGH(DATA_UNK_D)
    LOW(DATA_UNK_E)
    HIGH(DATA_UNK_E)
    LOW(DATA_UNK_F)
    HIGH(DATA_UNK_F)
    LOW(DATA_UNK_A)
    HIGH(DATA_UNK_A)
    LOW(DATA_UNK_G)
    HIGH(DATA_UNK_G)
    LOW(DATA_UNK_H)
    HIGH(DATA_UNK_H)
    LOW(DATA_UNK_I)
    HIGH(DATA_UNK_I)
    LOW(DATA_UNK_J)
    HIGH(DATA_UNK_J)
DATA_UNK_A: ; 04:008A, 0x00808A
    .db FF
DATA_UNK_B: ; 04:008B, 0x00808B
    .db 00
    .db 00
    .db 01
    .db 09
    .db 25
    .db C2
    .db FF
    .db 00
    .db 01
    .db 00
    .db 02
    .db 16
    .db E0
    .db 98
    .db DC
    .db 80
    .db 01
    .db F0
    .db 01
    .db 0A
    .db E5
    .db 92
    .db FF
    .db 00
    .db 09
    .db 40
    .db 01
    .db 0B
    .db E5
    .db CA
    .db FF
    .db 00
    .db FF
DATA_UNK_C: ; 04:00AC, 0x0080AC
    .db 03
    .db 30
    .db 03
    .db 1C
    .db F8
    .db 80
    .db 88
    .db 80
    .db FF
DATA_UNK_E: ; 04:00B5, 0x0080B5
    .db 00
    .db C5
    .db 06
    .db 21
    .db F8
    .db 90
    .db E0
    .db 80
    .db 01
    .db 8C
    .db 05
    .db 1F
    .db F6
    .db 8E
    .db DC
    .db 80
    .db 03
    .db 05
    .db 06
    .db 22
    .db F8
    .db 90
    .db E0
    .db 80
    .db 04
    .db 80
    .db 04
    .db 1E
    .db F0
    .db 50
    .db E8
    .db 00
    .db 05
    .db CC
    .db 05
    .db 20
    .db F6
    .db 8E
    .db DC
    .db 80
    .db 06
    .db 80
    .db 04
    .db 1E
    .db F0
    .db 50
    .db E8
    .db 00
    .db 07
    .db C5
    .db 06
    .db 23
    .db F8
    .db 90
    .db E0
    .db 80
    .db FF
DATA_UNK_F: ; 04:00EE, 0x0080EE
    .db 01
    .db 00
    .db 07
    .db 29
    .db 30
    .db 90
    .db E0
    .db 00
    .db 02
    .db E0
    .db 07
    .db 29
    .db 30
    .db 90
    .db E0
    .db 00
    .db 05
    .db 00
    .db 07
    .db 29
    .db 30
    .db 90
    .db E0
    .db 00
    .db FF
DATA_UNK_G: ; 04:0107, 0x008107
    .db 00
    .db D2
    .db 08
    .db 37
    .db F8
    .db A0
    .db E8
    .db 80
    .db 01
    .db 32
    .db 08
    .db 38
    .db F8
    .db A0
    .db E8
    .db 80
    .db 01
    .db 92
    .db 08
    .db 39
    .db F8
    .db A0
    .db E8
    .db 80
    .db 01
    .db F2
    .db 08
    .db 3A
    .db F8
    .db A0
    .db E8
    .db 80
    .db 02
    .db FC
    .db 06
    .db 32
    .db F8
    .db 90
    .db E0
    .db 80
    .db 03
    .db BC
    .db 06
    .db 33
    .db F8
    .db 90
    .db E0
    .db 80
    .db 05
    .db 5C
    .db 06
    .db 34
    .db F8
    .db 90
    .db E0
    .db 80
    .db FF
DATA_UNK_I: ; 04:0140, 0x008140
    .db 01
    .db 16
    .db 0B
    .db 3D
    .db F8
    .db 90
    .db E0
    .db 80
    .db 06
    .db 96
    .db 0B
    .db 3E
    .db F8
    .db 90
    .db E0
    .db 80
    .db 0A
    .db F8
    .db 0C
    .db 40
    .db D0
    .db A0
    .db C0
    .db 00
    .db FF
DATA_UNK_J: ; 04:0159, 0x008159
    .db 00
    .db 00
    .db 09
    .db C2
    .db 00
    .db 6C
    .db E0
    .db 80
    .db 00
    .db 00
    .db 0A
    .db C3
    .db 00
    .db 7E
    .db E0
    .db 80
    .db 00
    .db 00
    .db 09
    .db C4
    .db 00
    .db A0
    .db E0
    .db 80
    .db 00
    .db 00
    .db 09
    .db C5
    .db 30
    .db 6C
    .db E0
    .db 80
    .db 00
    .db 00
    .db 0A
    .db C6
    .db 60
    .db 7E
    .db E0
    .db 80
    .db 00
    .db 00
    .db 09
    .db C7
    .db 30
    .db A0
    .db E0
    .db 80
    .db FF
DATA_UNK_D: ; 04:018A, 0x00818A
    .db 01
    .db C0
    .db 0D
    .db 49
    .db 38
    .db AC
    .db D8
    .db 00
    .db 02
    .db 30
    .db 0E
    .db 00
    .db F2
    .db B1
    .db FF
    .db 80
    .db 02
    .db B0
    .db 0E
    .db 01
    .db F2
    .db CD
    .db FF
    .db 80
    .db 03
    .db 30
    .db 0E
    .db 02
    .db F2
    .db B1
    .db FF
    .db 80
    .db 03
    .db B0
    .db 0E
    .db 03
    .db F2
    .db CD
    .db FF
    .db 80
    .db 04
    .db 70
    .db 0E
    .db 04
    .db F2
    .db B1
    .db FF
    .db 80
    .db 04
    .db 90
    .db 0E
    .db 05
    .db F2
    .db CD
    .db FF
    .db 80
    .db 05
    .db C0
    .db 0D
    .db 49
    .db 38
    .db AC
    .db D8
    .db 00
    .db FF
DATA_UNK_H: ; 04:01CB, 0x0081CB
    .db 02
    .db 70
    .db 0F
    .db 53
    .db FC
    .db C3
    .db FF
    .db 00
    .db 03
    .db 6C
    .db 0F
    .db 56
    .db FC
    .db C3
    .db FF
    .db 00
    .db 03
    .db 70
    .db 0F
    .db 54
    .db FB
    .db A3
    .db FF
    .db 00
    .db 03
    .db 80
    .db 0F
    .db 55
    .db FA
    .db B3
    .db FF
    .db 00
    .db FF
RTN_MAP_???: ; 04:01EC, 0x0081EC
    LDX #$00 ; Reset index.
LOOP_INDEXES: ; 04:01EE, 0x0081EE
    LDA 670_MAP_DATA_A,X ; Load from.
    BEQ NEXT_INDEX ; == 0, goto.
    CMP #$02 ; If _ #$02
    BNE SKIP_RTN ; !=, goto.
    LDA 684_MAP_DATA_F,X ; Load
    BMI SKIP_RTN ; Negative, goto.
    BEQ SKIP_RTN ; == 0, goto.
    LDA #$16 ; Switch val.
    JSR RTN_SWITCH_UNK
SKIP_RTN: ; 04:0203, 0x008203
    LDA OBJ_POS_X_SUBPIXEL_DELTA? ; Load val.
    ORA OBJ_POS_X_DELTA? ; Set bits.
    BEQ NEXT_INDEX ; No bits set still, skip.
    LDA 674_MAP_DATA_B,X ; Load val.
    SEC ; Prep sub.
    SBC OBJ_POS_X_SUBPIXEL_DELTA? ; -= Val.
    STA 674_MAP_DATA_B,X ; Store back.
    LDA 678_MAP_DATA_C,X ; Load
    SBC OBJ_POS_X_DELTA? ; Subtract with.
    STA 678_MAP_DATA_C,X ; Store to.
    BCC CLEAR_INDEX_DATA ; Underflow, goto.
    LDA 83_UNK ; Load
    ORA 84_UNK ; Set bits.
    BEQ NEXT_INDEX ; No bits set, next.
    LDA 67C_MAP_DATA_D,X ; Load
    SEC ; Prep sub.
    SBC 83_UNK ; Sub with.
    STA 67C_MAP_DATA_D,X ; Store back.
    LDA 680_MAP_DATA_E,X ; Load val.
    SBC 84_UNK ; Subtract with.
    STA 680_MAP_DATA_E,X ; Store back.
    BCC CLEAR_INDEX_DATA ; Underflow, do.
NEXT_INDEX: ; 04:0235, 0x008235
    INX ; Index++
    CPX #$04 ; If _ #$04
    BNE LOOP_INDEXES ; !=, loop.
    RTS ; Leave.
CLEAR_INDEX_DATA: ; 04:023B, 0x00823B
    JSR ZERO_ALL_MAP_INDEX_ROW? ; Zero all.
    JMP NEXT_INDEX ; Next index.
ZERO_ALL_MAP_INDEX_ROW?: ; 04:0241, 0x008241
    LDA #$00 ; Clear val.
    STA 670_MAP_DATA_A,X ; Clear all at index.
    STA 688_MAP_DATA_G,X
    STA 674_MAP_DATA_B,X
    STA 678_MAP_DATA_C,X
    STA 67C_MAP_DATA_D,X
    STA 680_MAP_DATA_E,X
    STA 684_MAP_DATA_F,X
    RTS ; Leave.
MAP_COLUMN_INDEX_CLEAR_RTN?: ; 04:0259, 0x008259
    STA TMP_07 ; Store to.
    TXA ; Save X,Y
    PHA
    TYA
    PHA
    LDX #$00 ; Index reset.
LOOP_NOT_COMPLETE: ; 04:0261, 0x008261
    LDA 688_MAP_DATA_G,X ; Load
    CMP TMP_07 ; If _ Var
    BNE VAL_NE_VAR ; !=, goto.
    JSR ZERO_ALL_MAP_INDEX_ROW? ; Zero row.
    JMP EXIT_ESTORE ; Done, leave.
VAL_NE_VAR: ; 04:026E, 0x00826E
    INX ; Index++
    CPX #$04 ; If _ #$04
    BNE LOOP_NOT_COMPLETE ; !=, loop.
EXIT_ESTORE: ; 04:0273, 0x008273
    PLA ; Restore X,Y
    TAY
    PLA
    TAX
    RTS ; Leave.
RTN_UNK: ; 04:0278, 0x008278
    LDA LEVEL/SCREEN_ON ; Load val.
    CMP #$07 ; If _ #$07
    BEQ RTS ; ==, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load count.
    AND #$01 ; Test if odd?
    BNE RTS ; If set, leave.
    LDY #$00 ; Clear val?
    STY TMP_09
L_04:0288: ; 04:0288, 0x008288
    LDA 684_MAP_DATA_F,Y
    BPL L_04:02D9
    LDA 670_MAP_DATA_A,Y
    BEQ L_04:02D9
    ASL A
    TAY
    LDA L_04:02E7,Y
    STA TMP_0A
    LDA L_04:02E8,Y
    STA TMP_0B
    LDY TMP_09
    LDA 4C6_OBJ_UNK[18],X
    CMP #$08
    BCC L_04:02AF
    LDA 68C_MAP_DATA_H,Y
    CMP 4C6_OBJ_UNK[18],X
    BCS L_04:02D9
L_04:02AF: ; 04:02AF, 0x0082AF
    LDA 678_MAP_DATA_C,Y
    CMP OBJ_POS_X_CONFIRMED[18],X
    BCS L_04:02D9
    LDA 678_MAP_DATA_C,Y
    CLC
    ADC TMP_0A
    BCS L_04:02C4
    CMP OBJ_POS_X_CONFIRMED[18],X
    BCC L_04:02D9
L_04:02C4: ; 04:02C4, 0x0082C4
    LDA 680_MAP_DATA_E,Y
    CMP OBJ_POS_X??[18],X
    BCS L_04:02D9
    LDA 680_MAP_DATA_E,Y
    CLC
    ADC TMP_0B
    BCS L_04:0307
    CMP OBJ_POS_X??[18],X
    BCS L_04:0307
L_04:02D9: ; 04:02D9, 0x0082D9
    LDY TMP_09
    INY
    CPY #$04
    STY TMP_09
    BNE L_04:0288
    LDA #$00
    STA TMP_00
RTS: ; 04:02E6, 0x0082E6
    RTS
L_04:02E7: ; 04:02E7, 0x0082E7
    .db 00
L_04:02E8: ; 04:02E8, 0x0082E8
    .db 00
    .db 1A
    .db 0A
    .db 34
    .db 18
    .db 20
    .db 38
    .db 60
    .db 60
    .db 28
    .db 16
    .db 3C
    .db 16
    .db 30
    .db 40
    .db 16
    .db 40
    .db CC
    .db 40
    .db 9C
    .db 40
    .db 0C
    .db 60
    .db 20
    .db 28
    .db 20
    .db 30
    .db 1A
    .db 10
    .db 1A
    .db 07
L_04:0307: ; 04:0307, 0x008307
    .db B9
    .db 70
    .db 06
    .db F0
    .db 24
    .db 38
    .db E9
    .db 01
    .db 20
    .db 98
    .db CC
    .db 31
    .db 83
    .db D1
    .db 83
    .db 74
    .db 83
    .db 9D
    .db 83
    .db 31
    .db 84
    .db AD
    .db 84
    .db A5
    .db 83
    .db EC
    .db 84
    .db 66
    .db 85
    .db 66
    .db 85
    .db 34
    .db 85
    .db 4A
    .db 85
    .db A5
    .db 83
    .db 89
    .db 85
    .db 31
    .db 83
    .db 60
    .db BD
    .db 7A
    .db 05
    .db C9
    .db 06
    .db F0
    .db 3B
    .db C9
    .db 05
    .db F0
    .db 37
    .db BD
    .db 12
    .db 04
    .db 29
    .db 04
    .db F0
    .db 05
    .db BD
    .db 7A
    .db 05
    .db F0
    .db 2B
    .db A9
    .db 00
    .db 9D
    .db C6
    .db 04
    .db B9
    .db 78
    .db 06
    .db 18
    .db 69
    .db 0C
    .db 9D
    .db 7E
    .db 04
    .db B9
    .db 80
    .db 06
    .db 18
    .db 69
    .db 06
    .db 9D
    .db A2
    .db 04
    .db A4
    .db 08
    .db A9
    .db 00
    .db 99
    .db 85
    .db 00
    .db BD
    .db 12
    .db 04
    .db 09
    .db 04
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 06
    .db 9D
    .db 7A
    .db 05
    .db 60
    .db A4
    .db 09
    .db B9
    .db 88
    .db 06
    .db A0
    .db 09
    .db C9
    .db 1C
    .db F0
    .db 01
    .db C8
    .db 84
    .db 00
    .db A0
    .db 00
    .db B9
    .db 94
    .db 06
    .db C5
    .db 00
    .db F0
    .db 07
    .db C8
    .db C0
    .db 04
    .db D0
    .db F4
    .db F0
    .db 3E
    .db B9
    .db 98
    .db 06
    .db C9
    .db 0A
    .db 90
    .db 37
    .db C9
    .db 14
    .db B0
    .db 33
    .db BD
    .db 12
    .db 04
    .db 29
    .db 04
    .db F0
    .db 10
    .db 60
    .db BD
    .db 12
    .db 04
    .db 29
    .db 04
    .db D0
    .db 24
    .db BD
    .db 36
    .db 04
    .db 49
    .db 40
    .db 9D
    .db 36
    .db 04
    .db BD
    .db 12
    .db 04
    .db 09
    .db 04
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 04
    .db 9D
    .db 7A
    .db 05
    .db A9
    .db 00
    .db 9D
    .db D4
    .db 05
    .db 20
    .db B5
    .db 85
    .db A4
    .db 08
    .db A9
    .db 06
    .db 99
    .db 91
    .db 00
    .db 60
    .db BD
    .db 12
    .db 04
    .db 29
    .db 0A
    .db F0
    .db 58
    .db A4
    .db 09
    .db B9
    .db 78
    .db 06
    .db 18
    .db 69
    .db 0C
    .db DD
    .db 7E
    .db 04
    .db 90
    .db 09
    .db BD
    .db 36
    .db 04
    .db 29
    .db 40
    .db D0
    .db 44
    .db F0
    .db 07
    .db BD
    .db 36
    .db 04
    .db 29
    .db 40
    .db F0
    .db 3B
    .db A9
    .db 16
    .db 20
    .db F2
    .db EE
    .db A5
    .db 00
    .db 30
    .db 32
    .db A9
    .db 00
    .db 20
    .db 6B
    .db AC
    .db A5
    .db AC
    .db F0
    .db 29
    .db A4
    .db 09
    .db 8A
    .db 48
    .db A6
    .db AC
    .db B9
    .db 80
    .db 06
    .db 18
    .db 69
    .db 0C
    .db 9D
    .db A2
    .db 04
    .db B9
    .db 78
    .db 06
    .db 18
    .db 69
    .db 20
    .db 9D
    .db 7E
    .db 04
    .db A9
    .db DF
    .db 9D
    .db C6
    .db 04
    .db 68
    .db AA
    .db A9
    .db 01
    .db 99
    .db 84
    .db 06
    .db A9
    .db 43
    .db 4C
    .db 52
    .db DB
    .db 60
    .db BD
    .db 12
    .db 04
    .db 29
    .db 0A
    .db F0
    .db 74
    .db A4
    .db 09
    .db B9
    .db 78
    .db 06
    .db 18
    .db 69
    .db 08
    .db DD
    .db 7E
    .db 04
    .db 90
    .db 09
    .db BD
    .db 36
    .db 04
    .db 29
    .db 40
    .db D0
    .db 60
    .db F0
    .db 07
    .db BD
    .db 36
    .db 04
    .db 29
    .db 40
    .db F0
    .db 57
    .db A4
    .db 09
    .db B9
    .db 88
    .db 06
    .db 20
    .db F2
    .db EE
    .db A5
    .db 00
    .db 30
    .db 4B
    .db A9
    .db 01
    .db 20
    .db 6B
    .db AC
    .db A5
    .db AC
    .db F0
    .db 42
    .db A4
    .db 09
    .db A9
    .db 00
    .db 99
    .db 84
    .db 06
    .db 8A
    .db 48
    .db A6
    .db AC
    .db B9
    .db 80
    .db 06
    .db 18
    .db 69
    .db 0E
    .db 9D
    .db A2
    .db 04
    .db B9
    .db 78
    .db 06
    .db 18
    .db 69
    .db 12
    .db 9D
    .db 7E
    .db 04
    .db A9
    .db FC
    .db 9D
    .db C6
    .db 04
    .db 68
    .db AA
    .db BD
    .db 36
    .db 04
    .db 29
    .db 40
    .db F0
    .db 17
    .db 8A
    .db 48
    .db A6
    .db AC
    .db A9
    .db 00
    .db 38
    .db FD
    .db FC
    .db 04
    .db 9D
    .db FC
    .db 04
    .db A9
    .db 00
    .db FD
    .db EA
    .db 04
    .db 9D
    .db EA
    .db 04
    .db 68
    .db AA
    .db 60
    .db BD
    .db 12
    .db 04
    .db 29
    .db 0A
    .db F0
    .db 37
    .db A9
    .db 02
    .db 20
    .db 6B
    .db AC
    .db A5
    .db AC
    .db F0
    .db 2E
    .db A4
    .db 09
    .db A9
    .db 00
    .db 99
    .db 84
    .db 06
    .db 8A
    .db 48
    .db A6
    .db AC
    .db B9
    .db 80
    .db 06
    .db 18
    .db 69
    .db 0C
    .db 9D
    .db A2
    .db 04
    .db B9
    .db 78
    .db 06
    .db 18
    .db 69
    .db 1C
    .db 9D
    .db 7E
    .db 04
    .db A5
    .db 42
    .db C9
    .db 05
    .db D0
    .db 04
    .db A9
    .db DE
    .db D0
    .db 02
    .db A9
    .db D8
    .db 9D
    .db C6
    .db 04
    .db 68
    .db AA
    .db 60
    .db BD
    .db 12
    .db 04
    .db 29
    .db 09
    .db D0
    .db F8
    .db A9
    .db 37
    .db 85
    .db 00
    .db A4
    .db 09
    .db B9
    .db 88
    .db 06
    .db A0
    .db 0C
    .db C5
    .db 00
    .db F0
    .db 09
    .db E6
    .db 00
    .db C8
    .db C0
    .db 10
    .db 90
    .db F5
    .db B0
    .db 28
    .db 84
    .db 00
    .db A0
    .db 00
    .db B9
    .db 94
    .db 06
    .db C5
    .db 00
    .db F0
    .db 06
    .db C8
    .db C0
    .db 04
    .db D0
    .db F4
    .db 60
    .db BD
    .db 12
    .db 04
    .db 29
    .db 04
    .db D0
    .db 10
    .db BD
    .db 12
    .db 04
    .db 09
    .db 04
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 07
    .db 9D
    .db 7A
    .db 05
    .db 20
    .db B5
    .db 85
    .db 60
    .db BD
    .db 12
    .db 04
    .db 29
    .db 09
    .db D0
    .db F8
    .db A4
    .db 09
    .db B9
    .db 88
    .db 06
    .db A0
    .db 11
    .db C9
    .db 3D
    .db F0
    .db C5
    .db C8
    .db 4C
    .db 0B
    .db 85
    .db BD
    .db 12
    .db 04
    .db 29
    .db 0D
    .db D0
    .db 14
    .db BD
    .db 12
    .db 04
    .db 09
    .db 04
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 08
    .db 9D
    .db 7A
    .db 05
    .db A4
    .db 08
    .db A9
    .db 00
    .db 99
    .db 43
    .db 00
    .db 60
    .db BD
    .db 12
    .db 04
    .db 29
    .db 09
    .db D0
    .db 1B
    .db A4
    .db 09
    .db A9
    .db 01
    .db 99
    .db 84
    .db 06
    .db BD
    .db 12
    .db 04
    .db 29
    .db 04
    .db D0
    .db 0D
    .db BD
    .db 12
    .db 04
    .db 09
    .db 04
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 09
    .db 9D
    .db 7A
    .db 05
    .db 60
    .db A4
    .db 09
    .db B9
    .db 84
    .db 06
    .db C9
    .db 81
    .db F0
    .db 17
    .db 8A
    .db 48
    .db B9
    .db 88
    .db 06
    .db A8
    .db B9
    .db AF
    .db 85
    .db 20
    .db 2D
    .db 86
    .db B0
    .db 0C
    .db 68
    .db AA
    .db A4
    .db 09
    .db A9
    .db 81
    .db 99
    .db 84
    .db 06
    .db 4C
    .db 31
    .db 83
    .db 68
    .db AA
    .db 60
    .db 54
    .db 55
    .db 56
    .db 57
    .db 58
    .db 59
    .db BD
    .db 68
    .db 05
    .db 38
    .db E9
    .db 02
    .db B0
    .db 02
    .db A9
    .db 00
    .db 9D
    .db 68
    .db 05
    .db A9
    .db 01
    .db 8D
    .db 54
    .db 06
    .db 60
MAP_DATA_OVERRIDE_RTN: ; 04:05C8, 0x0085C8
    STA TMP_07 ; Val to.
    TXA ; Save X/Y.
    PHA
    TYA
    PHA
    LDX #$00
INDEX_NE_0x4: ; 04:05D0, 0x0085D0
    LDA 688_MAP_DATA_G,X ; Load
    CMP TMP_07 ; If _ #$07
    BNE VAL_NE_PASSED ; !=, goto.
    LDY 670_MAP_DATA_A,X ; Y index from X index.
    LDA DATA_OVERRIDE_A,Y ; Load override.
    STA 684_MAP_DATA_F,X ; Store to at X index.
    JMP EXIT_RESTORE_XY ; Goto, leave.
VAL_NE_PASSED: ; 04:05E3, 0x0085E3
    INX ; Next
    CPX #$04 ; If _ #$04
    BNE INDEX_NE_0x4 ; !=, goto.
EXIT_RESTORE_XY: ; 04:05E8, 0x0085E8
    PLA ; Restore Y/X.
    TAY
    PLA
    TAX
    RTS ; Leave.
DATA_OVERRIDE_A: ; 04:05ED, 0x0085ED
    .db 00
    .db 80
    .db 00
    .db 80
    .db 80
    .db 00
    .db 00
    .db 80
    .db 80
    .db 80
    .db 80
    .db 80
    .db 80
    .db 80
    .db 80
    .db 80
MAP_DATA_MOD_RTN: ; 04:05FD, 0x0085FD
    STA TMP_07 ; Store val.
    LDX #$00 ; Index reset.
INDEX_NOT_EQ: ; 04:0601, 0x008601
    LDA 688_MAP_DATA_G,X ; Load
    CMP TMP_07 ; If _ var
    BEQ MAP_DATA_EQ_VAR ; ==, goto.
    INX ; Index++
    CPX #$04 ; If _ #$04
    BNE INDEX_NOT_EQ ; !=, goto.
    RTS ; Leave. None.
MAP_DATA_EQ_VAR: ; 04:060E, 0x00860E
    LDA 680_MAP_DATA_E,X ; Load
    CLC ; Prep add.
    ADC MOD_DATA_A,Y ; Delta.
    STA 680_MAP_DATA_E,X ; Store to map.
    LDA 678_MAP_DATA_C,X ; Load
    CLC ; Prep add.
    ADC MOD_DATA_B,Y ; Add with val.
    STA 678_MAP_DATA_C,X ; Store to map.
    RTS ; Leave.
MOD_DATA_B: ; 04:0623, 0x008623
    .db 20
    .db 30
    .db 10
    .db FC
    .db FE
MOD_DATA_A: ; 04:0628, 0x008628
    .db 20
    .db 30
    .db 10
    .db 00
    .db 00
WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS: ; 04:062D, 0x00862D
    STA TMP_00 ; Passed to TMP.
    LDX #$00 ; X reset.
LOOP_FIND_OBJ_SLOT: ; 04:0631, 0x008631
    LDA 694_PLAYER_UNK[4],X ; Load val.
    BNE NEXT_OBJ ; If set, goto.
    LDA TMP_00 ; Load val passed.
    STA 694_PLAYER_UNK[4],X ; Store passed to slot.
    CLC ; Set CC, object made.
    RTS
NEXT_OBJ: ; 04:063D, 0x00863D
    INX ; Obj++
    CPX #$04 ; If X _ #$04
    BNE LOOP_FIND_OBJ_SLOT ; !=, goto.
    SEC ; Set for failure, no object made/found.
    RTS ; Leave.
CLEAR_SLOT_EQ_A: ; 04:0644, 0x008644
    STA TMP_00 ; Val to. TODO once player stuff better known.
    LDX #$00 ; Index reset.
FIND_LOOP: ; 04:0648, 0x008648
    LDA 694_PLAYER_UNK[4],X ; Load
    CMP TMP_00 ; If _ Val
    BEQ VAL_EQ ; ==, goto.
    INX ; Slot++
    CPX #$04 ; If _ #$04
    BCC FIND_LOOP ; <, goto.
    RTS ; Leave, none found.
VAL_EQ: ; 04:0655, 0x008655
    LDA #$00
    STA 694_PLAYER_UNK[4],X ; Clear these attrs for slot.
    STA 698_PLAYER_UNK[4],X
    STA 69C_PLAYER_UNK[4],X
    RTS ; Leave.
DATA_PLAYER_PTR_UNK_L: ; 04:0661, 0x008661
    LOW(FILE_A)
DATA_PLAYER_PTR_UNK_H: ; 04:0662, 0x008662
    HIGH(FILE_A)
    LOW(FILE_B)
    HIGH(FILE_B)
    LOW(FILE_C)
    HIGH(FILE_C)
    LOW(FILE_D)
    HIGH(FILE_D)
    LOW(FILE_E)
    HIGH(FILE_E)
    LOW(FILE_F)
    HIGH(FILE_F)
    LOW(FILE_G)
    HIGH(FILE_G)
    LOW(FILE_H)
    HIGH(FILE_H)
    LOW(FILE_I)
    HIGH(FILE_I)
    LOW(FILE_J)
    HIGH(FILE_J)
    LOW(FILE_K)
    HIGH(FILE_K)
    LOW(FILE_L)
    HIGH(FILE_L)
    LOW(FILE_M)
    HIGH(FILE_M)
    LOW(FILE_N)
    HIGH(FILE_N)
    LOW(FILE_O)
    HIGH(FILE_O)
    LOW(FILE_P)
    HIGH(FILE_P)
    LOW(FILE_Q)
    HIGH(FILE_Q)
    LOW(FILE_R)
    HIGH(FILE_R)
    LOW(FILE_S)
    HIGH(FILE_S)
    LOW(FILE_T)
    HIGH(FILE_T)
    LOW(FILE_U)
    HIGH(FILE_U)
    LOW(FILE_V)
    HIGH(FILE_V)
    LOW(FILE_W)
    HIGH(FILE_W)
    LOW(FILE_X)
    HIGH(FILE_X)
    LOW(FILE_Y)
    HIGH(FILE_Y)
    LOW(FILE_Z)
    HIGH(FILE_Z)
    LOW(FILE_AA)
    HIGH(FILE_AA)
FILE_A: ; 04:0697, 0x008697
    .db 05
    .db C0
    .db 06
    .db 08
    .db 09
    .db 0A
    .db FE
FILE_B: ; 04:069E, 0x00869E
    .db 06
    .db 40
    .db 06
    .db 0B
    .db 0C
    .db 0D
    .db FE
FILE_C: ; 04:06A5, 0x0086A5
    .db FF
    .db FF
    .db 14
    .db 0E
    .db 0F
    .db FE
FILE_D: ; 04:06AB, 0x0086AB
    .db 01
    .db C0
    .db 06
    .db 08
    .db 09
    .db 0A
    .db FE
FILE_E: ; 04:06B2, 0x0086B2
    .db 03
    .db 40
    .db 06
    .db 17
    .db 18
    .db 19
    .db FE
FILE_F: ; 04:06B9, 0x0086B9
    .db 04
    .db C0
    .db 06
    .db 1A
    .db 1B
    .db 1C
    .db FE
FILE_G: ; 04:06C0, 0x0086C0
    .db 05
    .db 40
    .db 06
    .db 17
    .db 18
    .db 19
    .db FE
FILE_H: ; 04:06C7, 0x0086C7
    .db 02
    .db 10
    .db 06
    .db 3A
    .db 3B
    .db 3C
    .db FE
FILE_I: ; 04:06CE, 0x0086CE
    .db 04
    .db 38
    .db 03
    .db 4C
    .db 4D
    .db 4E
    .db 4F
    .db 50
    .db 51
    .db 52
    .db 53
    .db 54
    .db 55
    .db 56
    .db 57
    .db 58
    .db 59
    .db 5A
    .db 5B
    .db 5C
    .db 5D
    .db 5E
    .db 5F
    .db 60
    .db 61
    .db 62
    .db 63
    .db 64
    .db 65
    .db 66
    .db 67
    .db 68
    .db 69
    .db FE
FILE_J: ; 04:06F0, 0x0086F0
    .db 06
    .db 38
    .db 03
    .db 4C
    .db 4D
    .db 4E
    .db 4F
    .db 50
    .db 51
    .db 52
    .db 53
    .db 54
    .db 55
    .db 56
    .db 57
    .db 58
    .db 59
    .db 5A
    .db 5B
    .db 5C
    .db 5D
    .db 5E
    .db 5F
    .db 60
    .db 61
    .db 62
    .db 63
    .db 64
    .db 65
    .db 66
    .db 67
    .db 68
    .db 69
    .db FE
FILE_K: ; 04:0712, 0x008712
    .db FF
    .db FF
    .db 14
    .db 7E
    .db 7F
    .db FE
FILE_L: ; 04:0718, 0x008718
    .db 01
    .db E0
    .db 03
    .db 99
    .db 9A
    .db 9B
    .db 9C
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9D
    .db 9E
    .db 9F
    .db 9E
    .db A0
    .db 9E
    .db FF
FILE_M: ; 04:0742, 0x008742
    .db 02
    .db 40
    .db 03
    .db A1
    .db A2
    .db A3
    .db A4
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A5
    .db A6
    .db A7
    .db A6
    .db A8
    .db A6
    .db FF
FILE_N: ; 04:076C, 0x00876C
    .db 02
    .db A0
    .db 03
    .db A9
    .db AA
    .db AB
    .db AC
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AD
    .db AE
    .db AF
    .db AE
    .db B0
    .db AE
    .db FF
FILE_O: ; 04:0796, 0x008796
    .db 03
    .db 00
    .db 03
    .db B1
    .db B2
    .db B3
    .db B4
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B5
    .db B6
    .db B7
    .db B6
    .db B8
    .db B6
    .db FF
FILE_P: ; 04:07C0, 0x0087C0
    .db FF
    .db FF
    .db 14
    .db B9
    .db BA
    .db FE
FILE_Q: ; 04:07C6, 0x0087C6
    .db 02
    .db 18
    .db 02
    .db BC
    .db BD
    .db BE
    .db BF
    .db C0
    .db C1
    .db C0
    .db C1
    .db C0
    .db C1
    .db C0
    .db C1
    .db C0
    .db C1
    .db C2
    .db C3
    .db C4
    .db C5
    .db C6
    .db FF
FILE_R: ; 04:07DD, 0x0087DD
    .db 07
    .db A0
    .db 02
    .db C7
    .db C8
    .db C9
    .db CA
    .db CB
    .db CC
    .db CB
    .db CC
    .db CB
    .db CC
    .db CB
    .db CC
    .db CB
    .db CC
    .db CD
    .db CE
    .db CF
    .db D0
    .db D1
    .db FF
FILE_S: ; 04:07F4, 0x0087F4
    .db 0C
    .db C0
    .db 01
    .db 00
    .db 03
    .db 05
    .db 01
    .db 04
    .db 06
    .db 02
    .db 02
    .db 02
    .db FE
FILE_T: ; 04:0801, 0x008801
    .db 03
    .db 40
    .db 02
    .db 07
    .db 08
    .db 09
    .db 0A
    .db 0B
    .db FF
FILE_U: ; 04:080A, 0x00880A
    .db 03
    .db C0
    .db 02
    .db 0C
    .db 0D
    .db 0E
    .db 0F
    .db 10
    .db FF
FILE_V: ; 04:0813, 0x008813
    .db 04
    .db 40
    .db 02
    .db 11
    .db 12
    .db 13
    .db 14
    .db 15
    .db FF
FILE_W: ; 04:081C, 0x00881C
    .db 04
    .db C0
    .db 02
    .db 16
    .db 17
    .db 18
    .db 19
    .db 1A
    .db FF
FILE_X: ; 04:0825, 0x008825
    .db 05
    .db 80
    .db 02
    .db 1B
    .db 1C
    .db 1D
    .db 1E
    .db 1F
    .db FF
FILE_Y: ; 04:082E, 0x00882E
    .db 05
    .db A0
    .db 02
    .db 20
    .db 21
    .db 22
    .db 23
    .db 24
    .db FF
FILE_Z: ; 04:0837, 0x008837
    .db FF
    .db FF
    .db 08
    .db 25
    .db 26
    .db 27
    .db FE
FILE_AA: ; 04:083E, 0x00883E
    .db FF
    .db FF
    .db 02
    .db 7A
    .db 7C
    .db 7B
    .db 7D
    .db FE
UPDATE_BUF_MAKER: ; 04:0846, 0x008846
    STA TMP_00 ; Store val.
    LDA TMP_00 ; Load, ugh, rofl. Bad code.
    BPL VAL_POSITIVE ; Positive, goto.
    ASL A ; << 1
    TAX ; To index.
    LDA DATA_A,X ; Load.
    STA TMP_00 ; Store to.
    LDA DATA_B,X ; Load.
    BMI RTN_NEGATIVE ; Negative.
    BPL RTN_POSITIVE ; Positive.
VAL_POSITIVE: ; 04:085A, 0x00885A
    ASL A ; << 1
    TAX ; To index.
    LDA DATA_C,X ; Load.
    STA TMP_00 ; Store to.
    LDA DATA_D,X ; Load.
    BMI RTN_NEGATIVE ; Store to.
RTN_POSITIVE: ; 04:0866, 0x008866
    ASL A ; << 1
    TAX ; To index.
    LDA DATA_E_PTR,X ; Ptr to.
    STA TMP_04
    LDA DATA_F_PTR,X
    STA TMP_05
    JMP RTN_ENTER ; Goto.
RTN_NEGATIVE: ; 04:0875, 0x008875
    ASL A ; << 1
    TAX ; To index.
    LDA DATA_G_PTR,X ; Ptr to.
    STA TMP_04
    LDA DATA_H_PTR,X
    STA TMP_05
RTN_ENTER: ; 04:0881, 0x008881
    LDY #$00 ; Index.
RTN_CONTINUE: ; 04:0883, 0x008883
    LDA [TMP_04],Y ; From file.
    STA TMP_08 ; Store data.
    INY ; Stream++
    LDA [TMP_04],Y ; From file.
    STA TMP_01 ; Store data.
    INY ; Stream++
    LDA TMP_00 ; Load
    BPL TMP_00_POSITIVE ; Positive, goto.
    ASL A ; << 1
    TAX ; To index.
    LDA DATA_I,X ; Set data.
    STA TMP_02
    LDA DATA_J,X
    STA TMP_03
    JMP REENTER ; Run rtn.
TMP_00_POSITIVE: ; 04:08A0, 0x0088A0
    ASL A ; << 1
    TAX ; To index.
    LDA DATA_K,X ; Set data.
    STA TMP_02
    LDA DATA_L,X
    STA TMP_03
REENTER: ; 04:08AC, 0x0088AC
    JSR PPU_UPDATE_BUF_MAKER
    BCS RTN_CONTINUE ; Ret CS, goto.
    RTS ; Leave.
MULTIUPDATE_BUF_RTN: ; 04:08B2, 0x0088B2
    ASL A ; To word index.
    TAX ; To X index.
    LDA DATA_A,X ; Load.
    STA TMP_00 ; Store to.
    LDA DATA_B,X ; Load
    ASL A ; To word index.
    TAX ; To index.
    LDA DATA_C_PTR_L,X ; Move ptr.
    STA TMP_04
    LDA DATA_D_PTR_H,X
    STA TMP_05
    LDY #$00 ; Stream reset.
RET_CS: ; 04:08CA, 0x0088CA
    LDA [TMP_04],Y ; Load.
    STA TMP_08 ; Seed buf maker.
    INY ; Stream++
    LDA [TMP_04],Y ; Load
    STA TMP_01 ; Seed buf maker.
    INY ; Stream++
    LDA TMP_00 ; Load
    ASL A ; << 1
    TAX ; To X index.
    LDA DATA_E,X ; Move data for buf maker.
    STA TMP_02
    LDA DATA_F,X
    STA TMP_03
    JSR PPU_UPDATE_BUF_MAKER ; Do.
    BCS RET_CS ; Ret CS, continue.
    RTS ; Leave, done.
PPU_UPDATE_BUF_MAKER: ; 04:08E8, 0x0088E8
    LDX PPU_UPDATE_BUF_INDEX ; Load index.
    LDA TMP_01 ; Load
    STA TMP_06 ; Store to.
    LDA TMP_08 ; Load
    STA PPU_UPDATE_BUFFER[64],X ; Set to buffer.
    INX ; Buf++
    LDA TMP_02 ; Load
    STA PPU_UPDATE_BUFFER[64],X ; Store to buf.
    INX ; Buf++
    LDA TMP_03 ; Load
    STA PPU_UPDATE_BUFFER[64],X ; Store to buffer.
    INX ; Buf++
LOOP_DATA: ; 04:0900, 0x008900
    LDA [TMP_04],Y ; Load from file.
    STA PPU_UPDATE_BUFFER[64],X ; Store to buffer.
    INX ; Buf++
    INY ; Stream++
    DEC TMP_06 ; Count--
    BNE LOOP_DATA ; != 0, loop.
    LDA #$FF
    STA PPU_UPDATE_BUFFER[64],X ; Buffer EOF.
    INX ; Buf++
    STX PPU_UPDATE_BUF_INDEX ; Save.
    LDA [TMP_04],Y ; Load from file.
    CMP #$FD ; If _ #$FD
    BCC LT_0xFD ; <, goto.
    CMP #$FF
    BEQ RTS_CC ; ==, leave. Completed.
    CMP #$FE
    BEQ VAL_EQ_0xFE ; ==, goto.
    INY ; Stream++
    LDA [TMP_04],Y
    PHA ; Save forward count.
    INY ; Stream++
    LDA [TMP_04],Y
    STA TMP_08
    INY ; Stream++
    LDA [TMP_04],Y
    STA TMP_01
    INY ; Stream++
    PLA ; Pull forward.
    JMP FORWARD_A ; Goto.
LT_0xFD: ; 04:0934, 0x008934
    LDA TMP_08 ; Load
    CMP #$01 ; If _ #$01
    BEQ FORWARD_0x20 ; ==, goto.
    LDA #$01 ; Seed val.
    BNE FORWARD_A ; Always taken.
FORWARD_0x20: ; 04:093E, 0x00893E
    LDA #$20 ; 0x32
FORWARD_A: ; 04:0940, 0x008940
    LDX #$02 ; TMP_02 PTR.
    JSR FORWARD_PTR_TMP[X]_BY_A ; Forward TMP[2] ptr.
    JMP PPU_UPDATE_BUF_MAKER ; Loop.
VAL_EQ_0xFE: ; 04:0948, 0x008948
    INY ; Stream++
    LDA [TMP_04],Y ; Load from file.
    STA TMP_00 ; Store.
    INY ; Stream++
    SEC ; Ret CS, continue.
    RTS ; Leave.
RTS_CC: ; 04:0950, 0x008950
    CLC ; Ret CC. Finished.
    RTS ; Leave.
CB_A: ; 04:0952, 0x008952
    LDA #$EF ; Val?
    JSR RTN_EVENTUALLY_MAKE_PPU_UPDATE_BUF ; Do.
    LDA 87_CB_INDEX? ; Load
    BNE RTS ; != 0, leave.
    LDA #$01 ; Val to store in slot.
    JMP WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS
CB_B: ; 04:0960, 0x008960
    LDA #$F6 ; Val?
    JSR RTN_EVENTUALLY_MAKE_PPU_UPDATE_BUF
    LDA 87_CB_INDEX? ; Load.
    BNE RTS ; != 0, leave.
    LDA #$02 ; Val to store in slot.
    JMP WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS
RTN_EVENTUALLY_MAKE_PPU_UPDATE_BUF: ; 04:096E, 0x00896E
    STA TMP_00 ; Store val.
    LDA 88_UNK_SWITCH? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; Timer--
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0977, 0x008977
    LDA 87_CB_INDEX? ; Load
    CLC ; Prep add.
    ADC TMP_00 ; Add with.
    JSR UPDATE_BUF_MAKER ; Do.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$07 ; If _ #$07
    BEQ BG_UPDATER_TERMINATE ; ==, goto.
    LDA #$01
    STA 88_UNK_SWITCH? ; Set attr.
    RTS ; Leave.
BG_UPDATER_TERMINATE: ; 04:098C, 0x00898C
    LDA #$00
    STA 87_CB_INDEX? ; Clear vals.
    STA 88_UNK_SWITCH?
    STA 60A_CB_SWITCH_WHICH?
RTS: ; 04:0995, 0x008995
    RTS ; Leave.
CB_C: ; 04:0996, 0x008996
    LDA #$04 ; Seed
    LDY #$11
    BNE RTN_ENTER
CB_D: ; 04:099C, 0x00899C
    LDA #$05 ; Seed
    LDY #$13
    BNE RTN_ENTER
CB_E: ; 04:09A2, 0x0089A2
    LDA #$06 ; Seed
    LDY #$15
    BNE RTN_ENTER
CB_F: ; 04:09A8, 0x0089A8
    LDA #$07 ; Seed
    LDY #$13
RTN_ENTER: ; 04:09AC, 0x0089AC
    PHA ; Save A,Y
    TYA
    PHA
    JSR UPDATE_BUF_MAKER ; Do update.
    PLA ; Restore Y
    TAY
    INY ; Y++
    TYA ; Y val to A.
    JSR UPDATE_BUF_MAKER ; Do update, Y+1
    PLA ; Restore A.
    JSR WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Do.
    JMP BG_UPDATER_TERMINATE ; Goto.
CB_G: ; 04:09C0, 0x0089C0
    LDA #$03 ; Val?
    JSR CLEAR_SLOT_EQ_A ; Do.
    LDA #$10 ; Data.
    JSR UPDATE_BUF_MAKER ; Do.
    JMP BG_UPDATER_TERMINATE ; Goto.
CB_H: ; 04:09CD, 0x0089CD
    LDA 87_CB_INDEX? ; Load
    BNE NONZERO ; != 0, goto.
    LDA #$1D
    STA 87_CB_INDEX? ; Set if zero.
NONZERO: ; 04:09D5, 0x0089D5
    LDA 87_CB_INDEX? ; Load
    JSR UPDATE_BUF_MAKER ; Update with val.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$20 ; If _ #$20
    BNE RTS ; !=, leave.
    JMP BG_UPDATER_TERMINATE ; ==, clear these.
CB_I: ; 04:09E5, 0x0089E5
    LDA #$20
    JSR UPDATE_BUF_MAKER ; Update.
    JMP BG_UPDATER_TERMINATE ; Done.
CB_J: ; 04:09ED, 0x0089ED
    LDA 60A_CB_SWITCH_WHICH? ; Load
    JSR MAP_DATA_OVERRIDE_RTN ; Override.
    LDA 60A_CB_SWITCH_WHICH? ; Load
    CLC ; Prep add.
    ADC #$18 ; + val.
    JSR UPDATE_BUF_MAKER ; Map from.
    JMP BG_UPDATER_TERMINATE ; Goto, abuse RTS.
CB_K: ; 04:09FF, 0x0089FF
    LDA 60A_CB_SWITCH_WHICH? ; Load
    CLC ; Prep add.
    ADC #$18 ; Add with.
    JSR UPDATE_BUF_MAKER ; Make update.
    JMP BG_UPDATER_TERMINATE ; Goto.
CB_L: ; 04:0A0B, 0x008A0B
    LDA 87_CB_INDEX? ; Load
    BNE VAL_NONZERO ; != 0, goto.
    LDA #$29
    STA 87_CB_INDEX? ; If zero, reset.
VAL_NONZERO: ; 04:0A13, 0x008A13
    LDA 88_UNK_SWITCH? ; Load.
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0A1A, 0x008A1A
    LDA 87_CB_INDEX? ; Load
    JSR UPDATE_BUF_MAKER ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$2F ; If _ #$2F
    BEQ VAL_EQ_2F ; ==, goto.
    LDA #$20
    STA 88_UNK_SWITCH? ; Set value.
RTS: ; 04:0A2B, 0x008A2B
    RTS ; Leave.
VAL_EQ_2F: ; 04:0A2C, 0x008A2C
    JMP BG_UPDATER_TERMINATE ; Clear helper.
CB_M: ; 04:0A2F, 0x008A2F
    LDA #$12 ; Seed.
    LDY #$2F
    JMP VAL_SEEDED
CB_N: ; 04:0A36, 0x008A36
    LDA #$13 ; Seed.
    LDY #$33
VAL_SEEDED: ; 04:0A3A, 0x008A3A
    STA TMP_00 ; Store seed.
    STY TMP_01
    LDA 60A_CB_SWITCH_WHICH? ; Load
    SEC ; Prep sub.
    SBC TMP_00 ; Sub with.
    CLC ; Prep add.
    ADC TMP_01 ; Add with.
    ADC 87_CB_INDEX? ; Also add with.
    JSR UPDATE_BUF_MAKER ; Do update.
    INC 87_CB_INDEX? ; Move index.
    LDA 87_CB_INDEX? ; Load
    CMP #$02 ; If _ #$02
    BNE RTS ; !=, leave.
EXIT_TERMINATE: ; 04:0A54, 0x008A54
    JMP BG_UPDATER_TERMINATE ; End.
CB_O: ; 04:0A57, 0x008A57
    LDA 88_UNK_SWITCH? ; Load
    BEQ TIMER_EXPIRED ; == 0,  run routine.
    DEC 88_UNK_SWITCH? ; -- otherwise.
    RTS
TIMER_EXPIRED: ; 04:0A5E, 0x008A5E
    LDA #$06
    STA 88_UNK_SWITCH? ; Set attr.
    LDA 60A_CB_SWITCH_WHICH? ; Load
    CLC ; Prep add.
    ADC #$21 ; Add with.
    ADC 87_CB_INDEX? ; Add with.
    JSR UPDATE_BUF_MAKER ; Update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$03 ; If _ #$03
    BNE RTS ; !=, leave.
    LDA 60A_CB_SWITCH_WHICH? ; Load
    JSR MAP_DATA_OVERRIDE_RTN ; Map data mod.
    JSR BG_UPDATER_TERMINATE ; Terminate.
    LDA #$08 ; Val?
    JMP WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Goto.
CB_P: ; 04:0A83, 0x008A83
    LDA 88_UNK_SWITCH? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0A8A, 0x008A8A
    LDA 60A_CB_SWITCH_WHICH? ; Load val.
    SEC ; Prep sub.
    SBC #$17 ; Sub.
    STA TMP_00 ; Store.
    ASL A ; << 1
    CLC ; Prep add.
    ADC TMP_00 ; Add to val.
    ADC #$3D ; Add val.
    ADC 87_CB_INDEX? ; Add val.
    JSR UPDATE_BUF_MAKER ; Update using.
    LDA #$18
    STA 88_UNK_SWITCH? ; Re-seed.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$03 ; If _ #$03
    BEQ EXIT_TERMINATE ; == 0, goto.
    LDA #$32
    JMP SND_BANKED_DISPATCH ; Play sound. Abuse RTS.
CB_Q: ; 04:0AAE, 0x008AAE
    LDA 60A_CB_SWITCH_WHICH? ; Load
    SEC ; Prep sub.
    SBC #$1C ; Subtract.
    CLC ; Prep add.
    ADC #$09 ; Add with.
    JSR WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Do rtn.
    JMP BG_UPDATER_TERMINATE ; Exit.
CB_R: ; 04:0ABD, 0x008ABD
    LDA 88_UNK_SWITCH? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0AC4, 0x008AC4
    LDA 87_CB_INDEX? ; Load
    BNE VAL_NONZERO ; != 0, goto.
    LDA #$42
    JSR SND_BANKED_DISPATCH ; Play sound.
VAL_NONZERO: ; 04:0ACD, 0x008ACD
    LDA 87_CB_INDEX? ; Load
    CLC ; Prep add.
    ADC #$D8 ; Add with.
    JSR UPDATE_BUF_MAKER ; Buf update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$16 ; If _ #$16
    BEQ VAL_EQ_ZERO ; == 0, goto.
    CMP #$08 ; If _ #$08
    BNE VAL_NE_ZERO ; != 0, goto.
    LDA 60A_CB_SWITCH_WHICH? ; Load
    JSR MAP_DATA_OVERRIDE_RTN ; Do data override.
    LDY #$00 ; Zero reset.
    JMP VAL_SEEDED ; Goto.
VAL_NE_ZERO: ; 04:0AEC, 0x008AEC
    LDY #$01 ; Alt val.
    CMP #$0F ; If _ #$0F
    BEQ VAL_SEEDED ; ==, goto.
    INY ; Alt alt val.
    CMP #$14 ; If _ #$14
    BNE RTS ; !=, continue.
VAL_SEEDED: ; 04:0AF7, 0x008AF7
    LDA 60A_CB_SWITCH_WHICH? ; Load
    JSR MAP_DATA_MOD_RTN ; Do rtn.
    LDA #$01
    STA 88_UNK_SWITCH? ; Set.
RTS: ; 04:0B01, 0x008B01
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0B02, 0x008B02
    LDA 60A_CB_SWITCH_WHICH? ; Load
    JSR MAP_COLUMN_INDEX_CLEAR_RTN? ; Do.
    JMP BG_UPDATER_TERMINATE ; Terminate.
CB_S: ; 04:0B0B, 0x008B0B
    LDA 60A_CB_SWITCH_WHICH? ; Load
    CLC ; Prep add.
    ADC #$4B ; Add with.
    JSR UPDATE_BUF_MAKER ; Do update.
    JMP BG_UPDATER_TERMINATE ; Terminate the update.
CB_T: ; 04:0B17, 0x008B17
    LDA 60A_CB_SWITCH_WHICH? ; Load
    SEC ; Prep sub.
    SBC #$21 ; Sub with.
    CLC ; Prep add.
    ADC #$00 ; Add nothing, lol.
    JSR FILE_RTN_INDEX/DATA_UNK ; Do file to array.
    LDA 60A_CB_SWITCH_WHICH? ; Load
    CLC ; Prep add.
    ADC #$4B ; Add with.
    JSR UPDATE_BUF_MAKER ; Do update.
EXIT_TERMINATE: ; 04:0B2C, 0x008B2C
    JMP BG_UPDATER_TERMINATE ; Terminate.
CB_U: ; 04:0B2F, 0x008B2F
    LDA #$00 ; Seed val.
    JMP VAL_SEEDED
CB_V: ; 04:0B34, 0x008B34
    LDA #$70 ; Seed val.
VAL_SEEDED: ; 04:0B36, 0x008B36
    LDY 88_UNK_SWITCH? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave. Waiting.
VAL_EQ_ZERO: ; 04:0B3D, 0x008B3D
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR UPDATE_BUF_MAKER ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load.
    CMP #$08 ; If _ #$08
    BEQ EXIT_TERMINATE ; ==, exit. Done.
    AND #$01 ; Even/odd?
    BNE VAL_ODD ; Odd, leave.
    LDA #$01
    STA 88_UNK_SWITCH? ; Set on even.
VAL_ODD: ; 04:0B53, 0x008B53
    RTS ; Leave.
CB_W: ; 04:0B54, 0x008B54
    LDA 88_UNK_SWITCH? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0B5B, 0x008B5B
    LDA #$78 ; Load
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR UPDATE_BUF_MAKER ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$06 ; If _ #$06
    BEQ VAL_EQ ; ==, goto.
    AND #$01 ; Even/odd.
    BNE VAL_NE_ZERO ; != 0, goto.
    LDA #$03
    STA 88_UNK_SWITCH? ; Set.
VAL_NE_ZERO: ; 04:0B73, 0x008B73
    RTS ; Leave.
VAL_EQ: ; 04:0B74, 0x008B74
    LDA #$0B ; Load.
    JSR WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Find.
    JMP BG_UPDATER_TERMINATE ; Terminate.
CB_X: ; 04:0B7C, 0x008B7C
    LDA #$0B ; Load val.
    JSR CLEAR_SLOT_EQ_A ; To slow.
    LDA #$80 ; Load.
    JSR UPDATE_BUF_MAKER ; Do update.
    JMP BG_UPDATER_TERMINATE ; Terminate.
CB_Y: ; 04:0B89, 0x008B89
    LDA 87_CB_INDEX? ; Load.
    BNE VAL_NE_ZERO ; != 0, goto.
    INC 87_CB_INDEX? ; ++
    LDA #$03
    STA DA_FLAG?_UNK ; Set flag.
    LDA #$90
    STA FLAG_IRQ_I_SECONDARY_KEEP_IF_POSITIVE ; Set flag.
    LDA #$06
    STA B6_NAMETABLE_FOCUS_UNK ; Store val.
    LDA #$E0
    STA B3_SCROLL_X_IRQ_J ; Store val.
    LDA #$04
    STA BC_UNK ; Store ??
    LDA #$00
    STA B9_UNK ; Clear ??
    STA C5_UNK
    STA A7_IRQ_REPLACE_SECONDARY_INDEX
RTS: ; 04:0BAB, 0x008BAB
    RTS ; Leave.
VAL_NE_ZERO: ; 04:0BAC, 0x008BAC
    LDA 60A_CB_SWITCH_WHICH? ; Load
    LDY #$03 ; Index.
    JSR MAP_DATA_MOD_RTN ; Mod data.
    LDA 678_MAP_DATA_C,X ; Load
    CMP #$04 ; If _ #$04
    BCS VAL_GTE_CMP ; >=, goto.
    LDA #$FF
    STA 678_MAP_DATA_C,X ; Store data.
    LDA 684_MAP_DATA_F,X ; Load
    BEQ VAL_ZERO ; == 0, goto.
    BPL VAL_GTE_CMP ; If positive, goto.
    LDA #$01 ; Seed val.
    BNE VAL_SEEDED ; != 0, goto. Always taken.
VAL_ZERO: ; 04:0BCB, 0x008BCB
    LDA #$27 ; Sound.
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA #$80 ; Seed alt.
VAL_SEEDED: ; 04:0BD2, 0x008BD2
    STA 684_MAP_DATA_F,X ; Store seeded.
VAL_GTE_CMP: ; 04:0BD5, 0x008BD5
    LDA B6_NAMETABLE_FOCUS_UNK ; Load
    CMP #$09 ; If _ #$09
    BCC RTS ; <, leave.
    LDA B3_SCROLL_X_IRQ_J ; Load
    CMP #$20 ; If _ #$20
    BCC RTS ; <, leave.
    JSR ZERO_ALL_MAP_INDEX_ROW? ; Zero index.
    LDA #$00
    STA B9_UNK ; Clear attr.
    STA BC_UNK ; Clear attr.
    LDA #$01
    STA 660_FLAG_IRQ_I_RESET+DA_CLEAR_UNK ; Set attr.
    JMP BG_UPDATER_TERMINATE ; Done, terminate.
CB_Z: ; 04:0BF2, 0x008BF2
    LDA 60A_CB_SWITCH_WHICH? ; Load
    CLC ; Prep add.
    ADC #$57 ; Add with.
    JSR UPDATE_BUF_MAKER ; Do update.
JMP_EXIT_TERMINATE: ; 04:0BFB, 0x008BFB
    JMP BG_UPDATER_TERMINATE ; Exit.
CB_AA: ; 04:0BFE, 0x008BFE
    LDA #$84 ; Seed val.
    BNE VAL_SEEDED ; Always taken.
CB_AB: ; 04:0C02, 0x008C02
    LDA #$88 ; Seed val.
VAL_SEEDED: ; 04:0C04, 0x008C04
    LDY 88_UNK_SWITCH? ; Y from.
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0C0B, 0x008C0B
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR UPDATE_BUF_MAKER ; Update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$04 ; If _ #$04
    BEQ JMP_EXIT_TERMINATE ; ==, exit.
    LDA #$07
    STA 88_UNK_SWITCH? ; Set.
    LDA #$32
    JMP SND_BANKED_DISPATCH ; Play sound. Abuse RTS.
CB_AC: ; 04:0C22, 0x008C22
    LDA 60A_CB_SWITCH_WHICH? ; Load
    CLC ; Prep add.
    ADC #$5D ; Add with.
    JSR UPDATE_BUF_MAKER ; Do update.
    JMP BG_UPDATER_TERMINATE ; Exit.
CB_AD: ; 04:0C2E, 0x008C2E
    LDA 60A_CB_SWITCH_WHICH? ; Load
    SEC ; Prep sub.
    SBC #$32 ; -=
    CLC ; Prep add.
    ADC #$03 ; Add with.
    JSR FILE_RTN_INDEX/DATA_UNK ; Do from file.
    LDA 60A_CB_SWITCH_WHICH? ; Load
    CLC ; Prep add.
    ADC #$5D ; Add with.
    PHA ; Save val.
    JSR UPDATE_BUF_MAKER ; Do with val.
    PLA ; Pull val.
    CLC ; Prep add.
    ADC #$03 ; Add with.
    JSR UPDATE_BUF_MAKER ; Do pair update.
    JMP BG_UPDATER_TERMINATE ; Terminate.
CB_AE: ; 04:0C4E, 0x008C4E
    LDA 87_CB_INDEX? ; Load
    BNE VAL_NONZERO ; != 0, goto.
    LDA #$95
    STA 87_CB_INDEX? ; Set if zero.
VAL_NONZERO: ; 04:0C56, 0x008C56
    LDA 87_CB_INDEX? ; Load
    JSR UPDATE_BUF_MAKER ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$98 ; If _ #$98
    BEQ JMP_EXIT_TERMINATE ; ==, goto.
    RTS ; Leave.
CB_AF: ; 04:0C64, 0x008C64
    LDA #$98
    JSR UPDATE_BUF_MAKER ; Do update.
    JMP BG_UPDATER_TERMINATE ; Terminate.
CB_AG: ; 04:0C6C, 0x008C6C
    LDA 60A_CB_SWITCH_WHICH? ; Load
    SEC ; Prep sub.
    SBC #$37 ; Sub with.
    CLC ; Prep add.
    ADC #$0C ; Add with.
    JSR WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Set up.
    JSR BG_UPDATER_TERMINATE ; Do terminate.
    LDA #$0B
    JMP SND_BANKED_DISPATCH ; Play sound, abuse RTS.
CB_AH: ; 04:0C80, 0x008C80
    LDA #$10 ; Load
    JSR WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Set up.
    JMP BG_UPDATER_TERMINATE ; Exit.
CB_AI: ; 04:0C88, 0x008C88
    LDA 87_CB_INDEX? ; Load
    BNE VAL_NE_ZERO ; != 0, goto.
    LDA #$10
    JSR CLEAR_SLOT_EQ_A ; Write to slot.
    LDA #$BB ; Seed update.
    BNE VAL_SEEDED ; != 0, goto.
VAL_NE_ZERO: ; 04:0C95, 0x008C95
    LDA #$EE ; Update val seed.
VAL_SEEDED: ; 04:0C97, 0x008C97
    JSR UPDATE_BUF_MAKER ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$02 ; If _ #$02
    BNE RTS ; !=, goto.
    JMP BG_UPDATER_TERMINATE ; Done, abuse RTS.
CB_AJ: ; 04:0CA5, 0x008CA5
    LDA #$11 ; Seed val.
    BNE VAL_SEEDED ; Always taken.
CB_AK: ; 04:0CA9, 0x008CA9
    LDA #$12 ; Seed val.
VAL_SEEDED: ; 04:0CAB, 0x008CAB
    JSR WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Do rtn.
    LDA #$0B
    JSR SND_BANKED_DISPATCH ; Play sound.
EXIT_JMP_TERMINATE: ; 04:0CB3, 0x008CB3
    JMP BG_UPDATER_TERMINATE ; Done.
CB_AL: ; 04:0CB6, 0x008CB6
    LDA 88_UNK_SWITCH? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
RTS: ; 04:0CBC, 0x008CBC
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0CBD, 0x008CBD
    LDA #$D2 ; Load
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR UPDATE_BUF_MAKER ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$04 ; If _ #$04
    BEQ EXIT_JMP_TERMINATE ; ==, done. Terminate.
    LDA #$04
    STA 88_UNK_SWITCH? ; Set var.
RTS: ; 04:0CD1, 0x008CD1
    RTS ; Leave.
CB_AM: ; 04:0CD2, 0x008CD2
    LDA #$D6 ; Load
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR UPDATE_BUF_MAKER ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$02 ; If _ #$02
    BNE RTS ; != 0, leave.
    LDA 60A_CB_SWITCH_WHICH? ; Load
    JSR MAP_DATA_OVERRIDE_RTN ; Mod arrays.
    LDA #$18
    JSR LEVEL_RELATED_DATA_A_PASSED? ; Do, todo.
    JMP BG_UPDATER_TERMINATE ; Done, leave.
CB_BG: ; 04:0CF0, 0x008CF0
    LDA #$40 ; Load, which.
    JSR MAP_COLUMN_INDEX_CLEAR_RTN? ; Do.
    JMP BG_UPDATER_TERMINATE ; Exit.
FILE_RTN_INDEX/DATA_UNK: ; 04:0CF8, 0x008CF8
    ASL A ; To word index.
    TAY ; To index reg.
    LDA FILE_PTRS_L,Y ; Move file ptr.
    STA TMP_00
    LDA FILE_PTRS_H,Y
    STA TMP_01
    LDY #$00
LOOP_MOVE: ; 04:0D06, 0x008D06
    LDA [TMP_00],Y ; Load from file.
    CMP #$FF ; If _ #$FF, EOF.
    BEQ RTS ; ==, goto.
    TAX ; Val to X.
    INY ; Stream++
    LDA [TMP_00],Y ; Load next val.
    STA 740_UNK,X ; Store val loaded to index from file.
    INY ; Stream++
    JMP LOOP_MOVE
FILE_PTRS_L: ; 04:0D17, 0x008D17
    LOW(FILE_A)
FILE_PTRS_H: ; 04:0D18, 0x008D18
    HIGH(FILE_A)
    LOW(FILE_B)
    HIGH(FILE_B)
    LOW(FILE_C)
    HIGH(FILE_C)
    LOW(FILE_D)
    HIGH(FILE_D)
    LOW(FILE_E)
    HIGH(FILE_E)
    LOW(FILE_F)
    HIGH(FILE_F)
FILE_A: ; 04:0D23, 0x008D23
    .db 96
    .db 33
    .db 97
    .db 33
    .db FF
FILE_B: ; 04:0D28, 0x008D28
    .db 30
    .db 33
    .db 31
    .db 33
    .db FF
FILE_C: ; 04:0D2D, 0x008D2D
    .db 36
    .db 33
    .db 37
    .db 33
    .db FF
FILE_D: ; 04:0D32, 0x008D32
    .db 30
    .db 33
    .db FF
FILE_E: ; 04:0D35, 0x008D35
    .db 36
    .db 33
    .db FF
FILE_F: ; 04:0D38, 0x008D38
    .db 33
    .db 33
    .db FF
CB_AQ: ; 04:0D3B, 0x008D3B
    LDA 87_CB_INDEX? ; Load
    BNE VAL_NE_ZERO ; != 0, goto.
    INC 87_CB_INDEX? ; ++
    LDA #$98
    STA IRQ_R0/R1_BANK_VALS[2] ; Set bank.
    LDA #$9A
    STA IRQ_R0/R1_BANK_VALS+1 ; Set bank.
    LDA #$21
    JSR LEVEL_RELATED_DATA_A_PASSED? ; Do.
    LDA #$06
    STA DA_FLAG?_UNK ; Set.
    LDA #$09
    STA B6_NAMETABLE_FOCUS_UNK ; Set.
    LDA #$E0
    STA B3_SCROLL_X_IRQ_J ; Set.
    LDA #$90
    STA FLAG_IRQ_I_SECONDARY_KEEP_IF_POSITIVE ; Set.
    LDA #$02
    STA BC_UNK ; Set.
    LDA #$80
    STA B9_UNK ; Set.
    LDA #$00
    STA C5_UNK ; Set.
    LDA #$01
    STA A7_IRQ_REPLACE_SECONDARY_INDEX ; Set.
    LDA #$53
    JMP WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Do, abuse RTS.
VAL_NE_ZERO: ; 04:0D73, 0x008D73
    LDA 60A_CB_SWITCH_WHICH? ; Load mod.
    LDY #$04 ; Val?
    JSR MAP_DATA_MOD_RTN ; Mod.
    LDA 678_MAP_DATA_C,X ; Load
    CMP #$04 ; If _ #$04
    BCS SKIP_OUTPUT ; >=, goto.
    LDA #$FF
    STA 678_MAP_DATA_C,X ; Set attr.
    LDA 684_MAP_DATA_F,X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    BPL SKIP_OUTPUT ; If positive, goto.
    LDA #$01 ; Seed val.
    BNE VAL_SEEDED ; != 0, goto.
VAL_EQ_ZERO: ; 04:0D92, 0x008D92
    LDA #$80 ; Seed val.
VAL_SEEDED: ; 04:0D94, 0x008D94
    STA 684_MAP_DATA_F,X ; Store attr.
SKIP_OUTPUT: ; 04:0D97, 0x008D97
    LDA 684_MAP_DATA_F,X ; Load
    BPL VAL_POSITIVE ; If positive, goto.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    AND #$0F ; Keep bits.
    BNE VAL_POSITIVE ; Any set, goto. 15 in 16.
    LDA #$0A
    JSR SND_BANKED_DISPATCH ; Play sound. 1 in 16. TODO: Whats this?
VAL_POSITIVE: ; 04:0DA7, 0x008DA7
    LDA B6_NAMETABLE_FOCUS_UNK ; Load
    CMP #$0C ; If _ #$0C
    BCC EXIT_CONTINUING ; <, goto.
    LDA B3_SCROLL_X_IRQ_J ; Load
    CMP #$04 ; If _ #$04
    BCS SCROLL_GTE_0x04 ; >=, goto.
    LDA #$53 ; Clear match val.
    JMP CLEAR_SLOT_EQ_A ; Clear.
SCROLL_GTE_0x04: ; 04:0DB8, 0x008DB8
    LDA B3_SCROLL_X_IRQ_J ; Load
    CMP #$C0 ; If _ #$C0
    BCC EXIT_CONTINUING ; <, goto.
    JSR ZERO_ALL_MAP_INDEX_ROW? ; Zero row.
    LDA #$94
    STA IRQ_R0/R1_BANK_VALS[2] ; Set banks.
    LDA #$96
    STA IRQ_R0/R1_BANK_VALS+1
    LDA #$20
    JSR LEVEL_RELATED_DATA_A_PASSED? ; Level related.
    LDA #$00
    STA B9_UNK ; Clear vars.
    STA BC_UNK
    LDA #$01
    STA 660_FLAG_IRQ_I_RESET+DA_CLEAR_UNK ; Set flag.
    JMP BG_UPDATER_TERMINATE ; Terminate.
EXIT_CONTINUING: ; 04:0DDC, 0x008DDC
    RTS ; Leave.
CB_AR: ; 04:0DDD, 0x008DDD
    LDA #$5A
    JSR WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Make.
    JMP BG_UPDATER_TERMINATE ; Leave.
CB_AS: ; 04:0DE5, 0x008DE5
    LDA #$28 ; Seed.
    BNE VAL_SEEDED ; Always taken.
CB_AT: ; 04:0DE9, 0x008DE9
    LDA #$2A ; Seed.
VAL_SEEDED: ; 04:0DEB, 0x008DEB
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR MULTIUPDATE_BUF_RTN ; Do.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$02 ; If _ #$02
    BNE EXIT_CONTINUING ; !=, goto.
EXIT_JMP_TERMINATE: ; 04:0DF9, 0x008DF9
    JMP BG_UPDATER_TERMINATE ; Done.
CB_AU: ; 04:0DFC, 0x008DFC
    LDA 88_UNK_SWITCH? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0E03, 0x008E03
    LDA #$2C ; Load
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR MULTIUPDATE_BUF_RTN ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$06 ; If _ #$06
    BEQ EXIT_JMP_TERMINATE ; ==, goto.
    LDA #$04
    STA 88_UNK_SWITCH? ; Set attr.
    RTS ; Leave.
CB_AW: ; 04:0E18, 0x008E18
    LDA #$39 ; Seed val.
    BNE VAL_SEEDED ; Always taken.
CB_AV: ; 04:0E1C, 0x008E1C
    LDA #$32 ; Val.
VAL_SEEDED: ; 04:0E1E, 0x008E1E
    LDY 88_UNK_SWITCH? ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0E25, 0x008E25
    CLC ; Prfep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR MULTIUPDATE_BUF_RTN ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load.
    CMP #$07 ; If _ #$07
    BEQ EXIT_JMP_TERMINATE ; == 0, goto.
    LDA #$03
    STA 88_UNK_SWITCH? ; Set var.
    RTS ; Leave.
CB_AX: ; 04:0E38, 0x008E38
    LDA 87_CB_INDEX? ; Load
    CLC ; Prep add.
    ADC #$40 ; Add with.
    JSR MULTIUPDATE_BUF_RTN ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$02 ; If _ #$02
    BEQ EXIT_JMP_TERMINATE ; ==, done.
    RTS ; Leave.
CB_AY: ; 04:0E49, 0x008E49
    LDA #$42 ; Load val.
    BNE VAL_SEEDED ; Always taken.
CB_AZ: ; 04:0E4D, 0x008E4D
    LDA #$4A ; Load val.
VAL_SEEDED: ; 04:0E4F, 0x008E4F
    LDY 88_UNK_SWITCH? ; Load.
    BEQ VAL_EQ_ZERO
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0E56, 0x008E56
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR MULTIUPDATE_BUF_RTN ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$08 ; If _ #$08
    BEQ EXIT_JMP_TERMINATE ; ==, done.
    CMP #$05 ; If _ #$05. TODO: Mistake/bad code here?
    BNE VAL_NOT_0x5 ; !=, goto. Next line, lol.
VAL_NOT_0x5: ; 04:0E68, 0x008E68
    LDA #$0E
    STA 88_UNK_SWITCH? ; Set var.
    RTS ; Leave.
CB_BA: ; 04:0E6D, 0x008E6D
    LDY 88_UNK_SWITCH? ; Load 
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0E74, 0x008E74
    LDA 60A_CB_SWITCH_WHICH? ; Load
    SEC ; Prep sub.
    SBC #$53 ; -=, get base val.
    STA TMP_00 ; Store val.
    ASL A ; << 1, double.
    CLC ; Prep add.
    ADC TMP_00 ; Add with original. 3x val.
    CLC ; Prep add.
    ADC #$52 ; Add with.
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR MULTIUPDATE_BUF_RTN ; Do updates.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$03 ; If _ #$03
    BEQ VAL_EQ_0x3 ; ==, goto.
    LDA #$03
    STA 88_UNK_SWITCH? ; Set var.
    RTS ; Leave.
VAL_EQ_0x3: ; 04:0E96, 0x008E96
    LDA 60A_CB_SWITCH_WHICH? ; Load
    JSR MAP_DATA_OVERRIDE_RTN ; Do mod.
    JMP BG_UPDATER_TERMINATE ; Done.
CB_BB: ; 04:0E9F, 0x008E9F
    LDY 88_UNK_SWITCH? ; LOad
    BEQ VAL_EQ_ZERO
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0EA6, 0x008EA6
    LDA 60A_CB_SWITCH_WHICH? ; Load.
    SEC ; Prep sub.
    SBC #$57 ; Sub.
    ASL A ; << 2, *4.
    ASL A
    CLC ; Prep add.
    ADC #$5E ; Add with.
    CLC ; Prep add.
    ADC 87_CB_INDEX? ; Add with.
    JSR MULTIUPDATE_BUF_RTN ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA 87_CB_INDEX? ; Load
    CMP #$04 ; If _ #$04
    BNE VAL_NE_0x4 ; !=, goto.
EXIT_JMP_TERMINATE: ; 04:0EBF, 0x008EBF
    JMP BG_UPDATER_TERMINATE ; Done, terminate.
VAL_NE_0x4: ; 04:0EC2, 0x008EC2
    LDA #$04
    STA 88_UNK_SWITCH? ; Set attr.
    RTS ; Leave.
CB_BC: ; 04:0EC7, 0x008EC7
    LDY 88_UNK_SWITCH? ; Load.
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 88_UNK_SWITCH? ; --
    RTS ; Leave.
VAL_EQ_ZERO: ; 04:0ECE, 0x008ECE
    LDY 87_CB_INDEX? ; Load
    LDA UPDATE_DATA_A,Y ; Load.
    CMP #$FF ; If _ #$FF
    BEQ EXIT_JMP_TERMINATE ; ==, goto.
    JSR MULTIUPDATE_BUF_RTN ; Do update.
    INC 87_CB_INDEX? ; ++
    LDA #$0C
    STA 88_UNK_SWITCH? ; Set var.
    RTS ; Leave.
UPDATE_DATA_A: ; 04:0EE1, 0x008EE1
    .db 78 ; Updates.
    .db 76
    .db 77
    .db 76
    .db 78
    .db 76
    .db 77
    .db 76
    .db FF
CB_BD: ; 04:0EEA, 0x008EEA
    LDA #$79 ; Update.
    JSR MULTIUPDATE_BUF_RTN ; Do update.
    JMP BG_UPDATER_TERMINATE ; Done.
CB_BE: ; 04:0EF2, 0x008EF2
    LDA #$5B ; Update.
    JSR WRITE_VAL_TO_EMPTY_SLOT_RET_CS_FAIL_CC_PASS ; Write to slot.
    JMP BG_UPDATER_TERMINATE ; Terminate.
CB_BF: ; 04:0EFA, 0x008EFA
    LDA #$5B ; Slot to clear.
    JSR CLEAR_SLOT_EQ_A ; Clear.
    JMP BG_UPDATER_TERMINATE ; Done.
DATA_C: ; 04:0F02, 0x008F02
    .db A4
DATA_D: ; 04:0F03, 0x008F03
    .db 57
    .db A5
    .db 58
    .db A4
    .db 59
    .db A5
    .db 5A
    .db A6
    .db 96
    .db A7
    .db 97
    .db A6
    .db 98
    .db A7
    .db 99
    .db 02
    .db 04
    .db 02
    .db 05
    .db 02
    .db 06
    .db 03
    .db 04
    .db 03
    .db 05
    .db 03
    .db 06
    .db 04
    .db 07
    .db 04
    .db 08
    .db 04
    .db 09
    .db 00
    .db 03
    .db 09
    .db 0A
    .db 05
    .db 03
    .db 0A
    .db 0A
    .db 06
    .db 03
    .db 0B
    .db 0A
    .db 07
    .db 04
    .db 07
    .db 05
    .db 07
    .db 06
    .db 08
    .db 04
    .db 08
    .db 05
    .db 08
    .db 06
    .db 0C
    .db 0B
    .db 0D
    .db 0C
    .db 0E
    .db 0D
    .db 0E
    .db 0E
    .db 14
    .db 0F
    .db 15
    .db 0F
    .db 16
    .db 0F
    .db 17
    .db 10
    .db 18
    .db 11
    .db 19
    .db 11
    .db 1A
    .db 11
    .db 1B
    .db 11
    .db 1C
    .db 12
    .db 1D
    .db 13
    .db 1D
    .db 14
    .db 1C
    .db 15
    .db 1D
    .db 16
    .db 1D
    .db 17
    .db 1E
    .db 18
    .db 1F
    .db 19
    .db 22
    .db 18
    .db 23
    .db 19
    .db 20
    .db 1A
    .db 21
    .db 1B
    .db 24
    .db 1A
    .db 25
    .db 1B
    .db 26
    .db 1C
    .db 26
    .db 1D
    .db 26
    .db 1E
    .db 26
    .db 1F
    .db 26
    .db 20
    .db 26
    .db 21
    .db 27
    .db 22
    .db 27
    .db 23
    .db 27
    .db 24
    .db 28
    .db 22
    .db 28
    .db 23
    .db 28
    .db 24
    .db 29
    .db 22
    .db 29
    .db 23
    .db 29
    .db 24
    .db 2A
    .db 22
    .db 2A
    .db 23
    .db 2A
    .db 24
    .db 2B
    .db 22
    .db 2B
    .db 23
    .db 2B
    .db 24
    .db 2C
    .db 25
    .db 2D
    .db 26
    .db 2E
    .db 27
    .db 30
    .db 28
    .db 32
    .db 29
    .db 35
    .db 2A
    .db 39
    .db 2B
    .db 3D
    .db 2C
    .db 41
    .db 2D
    .db 45
    .db 2E
    .db 49
    .db 2F
    .db 4D
    .db 30
    .db 51
    .db 31
    .db 55
    .db 32
    .db 59
    .db 33
    .db 59
    .db 34
    .db 55
    .db 35
    .db 51
    .db 36
    .db 4D
    .db 37
    .db 49
    .db 38
    .db 45
    .db 39
    .db 41
    .db 3A
    .db 3D
    .db 3B
    .db 39
    .db 3C
    .db 35
    .db 3D
    .db 32
    .db 3E
    .db 30
    .db 3F
    .db 2E
    .db 40
    .db 2D
    .db 41
    .db 2C
    .db 42
    .db 9F
    .db 55
    .db A0
    .db 55
    .db A1
    .db 56
    .db A2
    .db 56
    .db A3
    .db 56
    .db A2
    .db 56
    .db D6
    .db 57
    .db D7
    .db 58
    .db D6
    .db 59
    .db D7
    .db 5A
    .db D8
    .db 96
    .db D9
    .db 97
    .db D8
    .db 98
    .db D9
    .db 99
    .db A8
    .db 5B
    .db A9
    .db 5C
    .db A8
    .db 5D
    .db A9
    .db 5E
    .db A8
    .db 5F
    .db A9
    .db 60
    .db AA
    .db 61
    .db AA
    .db 62
DATA_A: ; 04:1002, 0x009002
    .db AA
DATA_B: ; 04:1003, 0x009003
    .db 63
    .db AB
    .db 64
    .db AC
    .db 65
    .db AD
    .db 66
    .db B1
    .db 67
    .db B1
    .db 68
    .db B1
    .db 69
    .db B1
    .db 6A
    .db B2
    .db 67
    .db B2
    .db 68
    .db B2
    .db 69
    .db B2
    .db 6A
    .db B3
    .db 6B
    .db B4
    .db 6B
    .db B5
    .db 6B
    .db B6
    .db 6C
    .db B7
    .db 6C
    .db B8
    .db 6C
    .db B9
    .db 6D
    .db BA
    .db 6D
    .db BB
    .db 6D
    .db BC
    .db 6E
    .db BD
    .db 6F
    .db BE
    .db 70
    .db C3
    .db 71
    .db C4
    .db 72
    .db C4
    .db 73
    .db C4
    .db 74
    .db C4
    .db 75
    .db C4
    .db 76
    .db C4
    .db 77
    .db C4
    .db 78
    .db C4
    .db 79
    .db C5
    .db 72
    .db C5
    .db 73
    .db C5
    .db 74
    .db C5
    .db 75
    .db C5
    .db 76
    .db C5
    .db 77
    .db C5
    .db 78
    .db C5
    .db 79
    .db C6
    .db 72
    .db C6
    .db 73
    .db C6
    .db 74
    .db C6
    .db 75
    .db C6
    .db 76
    .db C6
    .db 77
    .db C6
    .db 78
    .db C6
    .db 79
    .db C7
    .db 72
    .db C7
    .db 73
    .db C7
    .db 74
    .db C7
    .db 75
    .db C7
    .db 76
    .db C7
    .db 77
    .db C7
    .db 78
    .db C7
    .db 79
    .db C9
    .db 7A
    .db C9
    .db 7B
    .db C8
    .db 7C
    .db CF
    .db 7D
    .db CF
    .db 7E
    .db CF
    .db 7F
    .db CF
    .db 80
    .db CF
    .db 81
    .db CF
    .db 82
    .db CF
    .db 83
    .db CF
    .db 84
    .db CF
    .db 85
    .db CF
    .db 86
    .db CF
    .db 87
    .db D0
    .db 7D
    .db D0
    .db 7E
    .db D0
    .db 7F
    .db D0
    .db 80
    .db D0
    .db 81
    .db D0
    .db 82
    .db D0
    .db 83
    .db D0
    .db 84
    .db D0
    .db 85
    .db D0
    .db 86
    .db D0
    .db 87
    .db DA
    .db 88
    .db DB
    .db 89
    .db DC
    .db 8A
    .db DD
    .db 8B
    .db D2
    .db 8C
    .db D3
    .db 8D
    .db 5D
    .db 43
    .db 5F
    .db 44
    .db 61
    .db 45
    .db 63
    .db 46
    .db 65
    .db 8E
    .db 67
    .db 47
    .db 69
    .db 8F
    .db 6B
    .db 48
    .db 71
    .db 49
    .db 75
    .db 4A
    .db 84
    .db 92
    .db 7B
    .db 4B
    .db 7D
    .db 4C
    .db 7F
    .db 4D
    .db 81
    .db 4E
    .db 88
    .db 4F
    .db 8A
    .db 50
    .db 8E
    .db 51
    .db 90
    .db 90
    .db 92
    .db 52
    .db 88
    .db 53
    .db 9B
    .db 54
    .db CB
    .db 91
    .db 00
    .db 00
    .db D4
    .db 93
    .db 00
    .db 01
    .db D4
    .db 94
    .db 00
    .db 02
    .db D4
    .db 95
    .db 00
    .db 03
    .db 01
    .db 00
    .db D5
    .db 93
    .db 01
    .db 01
    .db D5
    .db 94
    .db 01
    .db 02
    .db D5
    .db 95
    .db 01
    .db 03
DATA_K: ; 04:10FC, 0x0090FC
    .db 14
DATA_L: ; 04:10FD, 0x0090FD
    .db 25
    .db 04
    .db 21
    .db 94
    .db 25
    .db 84
    .db 21
    .db 95
    .db 21
    .db 04
    .db 25
    .db 14
    .db 21
    .db 84
    .db 25
    .db 94
    .db 21
    .db DD
    .db 27
    .db D9
    .db 27
    .db DD
    .db 23
    .db E2
    .db 24
    .db 62
    .db 25
    .db 01
    .db 26
    .db 42
    .db 26
    .db C8
    .db 27
    .db D0
    .db 27
    .db D8
    .db 27
    .db E0
    .db 27
    .db E4
    .db 22
    .db 3A
    .db 22
    .db 04
    .db 23
    .db F8
    .db 20
    .db 46
    .db 22
    .db CA
    .db 22
    .db D2
    .db 20
    .db 56
    .db 21
    .db 54
    .db 25
    .db 12
    .db 25
    .db EB
    .db 24
    .db 6B
    .db 25
    .db AB
    .db 26
    .db EB
    .db 26
    .db F7
    .db 24
    .db 77
    .db 25
    .db B7
    .db 26
    .db F7
    .db 26
    .db E0
    .db 21
    .db B8
    .db 25
    .db A8
    .db 21
    .db BC
    .db 25
    .db BC
    .db 21
    .db A8
    .db 25
    .db E8
    .db 20
    .db 08
    .db 21
    .db 28
    .db 21
    .db E7
    .db 20
    .db 48
    .db 21
    .db 07
    .db 21
    .db 68
    .db 21
    .db 27
    .db 21
    .db E6
    .db 20
    .db 88
    .db 21
    .db 47
    .db 21
    .db 06
    .db 21
    .db E5
    .db 20
    .db A8
    .db 21
    .db 67
    .db 21
    .db 26
    .db 21
    .db 05
    .db 21
    .db C8
    .db 21
    .db 87
    .db 21
    .db 46
    .db 21
    .db 25
    .db 21
    .db E8
    .db 21
    .db A7
    .db 21
    .db 66
    .db 21
    .db 45
    .db 21
    .db 08
    .db 22
    .db C7
    .db 21
    .db 86
    .db 21
    .db 65
    .db 21
    .db 28
    .db 22
    .db E7
    .db 21
    .db A6
    .db 21
    .db 85
    .db 21
    .db 48
    .db 22
    .db 07
    .db 22
    .db C6
    .db 21
    .db A5
    .db 21
    .db 68
    .db 22
    .db 27
    .db 22
    .db E6
    .db 21
    .db C5
    .db 21
    .db 88
    .db 22
    .db 47
    .db 22
    .db 06
    .db 22
    .db E5
    .db 21
    .db A8
    .db 22
    .db 67
    .db 22
    .db 26
    .db 22
    .db 05
    .db 22
    .db B0
    .db 26
    .db 8F
    .db 26
    .db 6C
    .db 26
    .db 4C
    .db 26
    .db 2C
    .db 26
    .db 0B
    .db 26
    .db E8
    .db 25
    .db C8
    .db 25
    .db A8
    .db 25
    .db 87
    .db 25
    .db 66
    .db 25
    .db 45
    .db 25
    .db 26
    .db 25
    .db 06
    .db 25
    .db E6
    .db 24
    .db EB
    .db 27
    .db E2
    .db 27
    .db DA
    .db 27
    .db D1
    .db 27
    .db C9
    .db 27
    .db 76
    .db 27
    .db 55
    .db 27
    .db 32
    .db 27
    .db 12
    .db 27
    .db F2
    .db 26
    .db D1
    .db 26
    .db B0
    .db 26
    .db 8F
    .db 26
    .db 6C
    .db 26
    .db 4C
    .db 26
    .db 2A
    .db 26
    .db 0A
    .db 26
    .db EA
    .db 25
    .db C9
    .db 25
    .db A8
    .db 25
DATA_I: ; 04:11FC, 0x0091FC
    .db 87
DATA_J: ; 04:11FD, 0x0091FD
    .db 25
    .db 66
    .db 25
    .db 45
    .db 25
    .db F4
    .db 27
    .db EB
    .db 27
    .db E2
    .db 27
    .db D9
    .db 27
    .db D1
    .db 27
    .db B8
    .db 27
    .db 97
    .db 27
    .db 74
    .db 27
    .db 54
    .db 27
    .db 32
    .db 27
    .db 12
    .db 27
    .db F0
    .db 26
    .db D0
    .db 26
    .db AE
    .db 26
    .db 8E
    .db 26
    .db 70
    .db 26
    .db 50
    .db 26
    .db 30
    .db 26
    .db 10
    .db 26
    .db FD
    .db 27
    .db F4
    .db 27
    .db EB
    .db 27
    .db E4
    .db 27
    .db 78
    .db 27
    .db 58
    .db 27
    .db 38
    .db 27
    .db 18
    .db 27
    .db F6
    .db 27
    .db 71
    .db 21
    .db 79
    .db 21
    .db F9
    .db 25
    .db E1
    .db 21
    .db F9
    .db 21
    .db 0E
    .db 21
    .db 10
    .db 21
    .db 13
    .db 21
    .db 15
    .db 21
    .db EC
    .db 20
    .db 8C
    .db 21
    .db CE
    .db 21
    .db 8C
    .db 25
    .db 0D
    .db 26
    .db 8F
    .db 26
    .db DB
    .db 27
    .db E3
    .db 27
    .db EB
    .db 27
    .db F0
    .db 21
    .db E0
    .db 25
    .db E4
    .db 20
    .db F4
    .db 20
    .db FC
    .db 20
    .db C0
    .db 21
    .db D8
    .db 21
    .db CC
    .db 21
    .db E0
    .db 23
    .db E6
    .db 23
    .db E3
    .db 23
    .db EE
    .db 24
    .db 8E
    .db 25
    .db 0D
    .db 26
    .db CB
    .db 27
    .db D3
    .db 27
    .db DB
    .db 27
    .db E0
    .db 27
    .db 0D
    .db 26
    .db 7A
    .db 26
    .db 66
    .db 22
    .db 72
    .db 22
    .db 7E
    .db 22
    .db FB
    .db 20
    .db 5A
    .db 21
    .db B9
    .db 21
    .db 99
    .db 21
    .db D6
    .db 23
    .db DE
    .db 23
    .db E6
    .db 23
    .db C2
    .db 21
    .db D2
    .db 25
    .db 5C
    .db 21
    .db 78
    .db 25
    .db 58
    .db 26
    .db 16
    .db 25
    .db 06
    .db 21
    .db 16
    .db 25
    .db 18
    .db 25
    .db 1B
    .db 25
    .db 1D
    .db 25
    .db 5C
    .db 21
    .db 5D
    .db 21
    .db 5E
    .db 21
    .db 5F
    .db 21
DATA_E_PTR: ; 04:12B8, 0x0092B8
    .db A8
DATA_F_PTR: ; 04:12B9, 0x0092B9
    .db 95
    .db CE
    .db 95
    .db F4
    .db 95
    .db 1A
    .db 96
    .db 3D
    .db 96
    .db 4C
    .db 96
    .db 5B
    .db 96
    .db 6E
    .db 96
    .db 7D
    .db 96
    .db 8C
    .db 96
    .db 6A
    .db 96
    .db 9B
    .db 96
    .db B6
    .db 96
    .db D7
    .db 96
    .db 0C
    .db 97
    .db 2F
    .db 97
    .db 3A
    .db 97
    .db 59
    .db 97
    .db 6A
    .db 97
    .db 85
    .db 97
    .db A0
    .db 97
    .db BB
    .db 97
    .db D6
    .db 97
    .db F1
    .db 97
    .db 0C
    .db 98
    .db 23
    .db 98
    .db 35
    .db 98
    .db 4A
    .db 98
    .db 5F
    .db 98
    .db 66
    .db 98
    .db 71
    .db 98
    .db 84
    .db 98
    .db 97
    .db 98
    .db A0
    .db 98
    .db A9
    .db 98
    .db B8
    .db 98
    .db C7
    .db 98
    .db D6
    .db 98
    .db DA
    .db 98
    .db DE
    .db 98
    .db E7
    .db 98
    .db F0
    .db 98
    .db FE
    .db 98
    .db 11
    .db 99
    .db 24
    .db 99
    .db 37
    .db 99
    .db 4A
    .db 99
    .db 5D
    .db 99
    .db 70
    .db 99
    .db 83
    .db 99
    .db 96
    .db 99
    .db A9
    .db 99
    .db BC
    .db 99
    .db CF
    .db 99
    .db E2
    .db 99
    .db F5
    .db 99
    .db 08
    .db 9A
    .db 1B
    .db 9A
    .db 2E
    .db 9A
    .db 41
    .db 9A
    .db 54
    .db 9A
    .db 67
    .db 9A
    .db 7A
    .db 9A
    .db 88
    .db 9A
    .db 91
    .db 9A
    .db 9A
    .db 9A
    .db 9E
    .db 9A
    .db A2
    .db 9A
    .db CE
    .db 9A
    .db FE
    .db 9A
    .db 2F
    .db 9B
    .db 8B
    .db 9B
    .db E3
    .db 9B
    .db FC
    .db 9B
    .db 44
    .db 9C
    .db D3
    .db 9C
    .db 0B
    .db 9D
    .db 3D
    .db 9D
    .db 73
    .db 9D
    .db A8
    .db 9D
    .db C7
    .db 9D
    .db 12
    .db 9E
    .db 6D
    .db 9E
    .db C0
    .db 9E
    .db EB
    .db 9E
    .db 14
    .db 9F
    .db 2F
    .db 9F
    .db 4A
    .db 9F
    .db 61
    .db 9F
    .db 82
    .db 9F
    .db 99
    .db 9F
    .db 2A
    .db A0
    .db 55
    .db A0
    .db 88
    .db A0
    .db B3
    .db A0
    .db E6
    .db A0
    .db 11
    .db A1
    .db 44
    .db A1
    .db 53
    .db A1
    .db 62
    .db A1
    .db 71
    .db A1
    .db 92
    .db A1
    .db B7
    .db A1
    .db DD
    .db A1
    .db E3
    .db A1
    .db E9
    .db A1
    .db EF
    .db A1
    .db F5
    .db A1
    .db 14
    .db A2
    .db 33
    .db A2
    .db 37
    .db A2
    .db 58
    .db A2
    .db 73
    .db A2
    .db 8E
    .db A2
    .db A9
    .db A2
    .db B0
    .db A2
    .db B7
    .db A2
    .db C1
    .db A2
    .db CB
    .db A2
    .db D9
    .db A2
    .db E7
    .db A2
    .db F5
    .db A2
    .db 03
    .db A3
    .db 1F
    .db A3
    .db 3B
    .db A3
    .db 73
    .db A3
    .db 7B
    .db A3
    .db 83
    .db A3
DATA_G_PTR: ; 04:13B8, 0x0093B8
    .db 90
DATA_H_PTR: ; 04:13B9, 0x0093B9
    .db A3
    .db 9D
    .db A3
    .db B0
    .db A3
    .db C3
    .db A3
    .db D6
    .db A3
    .db E9
    .db A3
    .db FC
    .db A3
    .db 0F
    .db A4
    .db 22
    .db A4
    .db 45
    .db A4
    .db 60
    .db A4
    .db 73
    .db A4
    .db 7E
    .db A4
    .db 9D
    .db A4
    .db 59
    .db 9B
    .db B6
    .db 9B
    .db 39
    .db 9E
    .db 49
    .db A3
    .db 91
    .db 9C
    .db BB
    .db 95
    .db E1
    .db 95
    .db 07
    .db 96
    .db BA
    .db 9F
    .db D1
    .db 9F
    .db F2
    .db 9F
    .db 09
    .db A0
DATA_A: ; 04:13EC, 0x0093EC
    .db 00
DATA_B: ; 04:13ED, 0x0093ED
    .db 00
    .db 01
    .db 01
    .db 01
    .db 02
    .db 02
    .db 03
    .db 02
    .db 04
    .db 03
    .db 03
    .db 03
    .db 04
    .db 04
    .db 05
    .db 04
    .db 06
    .db 04
    .db 07
    .db 04
    .db 08
    .db 04
    .db 09
    .db 05
    .db 05
    .db 05
    .db 06
    .db 05
    .db 07
    .db 05
    .db 08
    .db 05
    .db 09
    .db 06
    .db 05
    .db 06
    .db 06
    .db 06
    .db 07
    .db 06
    .db 08
    .db 06
    .db 09
    .db 07
    .db 05
    .db 07
    .db 06
    .db 07
    .db 07
    .db 07
    .db 08
    .db 07
    .db 09
    .db 08
    .db 05
    .db 08
    .db 06
    .db 08
    .db 07
    .db 08
    .db 08
    .db 08
    .db 09
    .db 09
    .db 05
    .db 09
    .db 06
    .db 09
    .db 07
    .db 09
    .db 08
    .db 09
    .db 09
    .db 0A
    .db 0A
    .db 0A
    .db 0B
    .db 0A
    .db 0C
    .db 0B
    .db 17
    .db 0C
    .db 18
    .db 0D
    .db 17
    .db 0E
    .db 18
    .db 0F
    .db 21
    .db 0F
    .db 22
    .db 0F
    .db 23
    .db 0F
    .db 24
    .db 0F
    .db 25
    .db 0F
    .db 26
    .db 10
    .db 27
    .db 11
    .db 27
    .db 12
    .db 27
    .db 13
    .db 27
    .db 14
    .db 27
    .db 15
    .db 27
    .db 16
    .db 27
    .db 16
    .db 28
    .db 15
    .db 29
    .db 14
    .db 2A
    .db 13
    .db 2B
    .db 12
    .db 2C
    .db 11
    .db 2D
    .db 10
    .db 2E
    .db 17
    .db 2F
    .db 18
    .db 30
    .db 19
    .db 19
    .db 19
    .db 1A
    .db 19
    .db 1B
    .db 19
    .db 1C
    .db 19
    .db 1D
    .db 19
    .db 1E
    .db 19
    .db 1F
    .db 19
    .db 20
    .db 1A
    .db 19
    .db 1A
    .db 1A
    .db 1A
    .db 1B
    .db 1A
    .db 1C
    .db 1A
    .db 1D
    .db 1A
    .db 1E
    .db 1A
    .db 1F
    .db 1A
    .db 20
    .db 1B
    .db 0D
    .db 1B
    .db 0E
    .db 1B
    .db 0F
    .db 1C
    .db 0D
    .db 1C
    .db 0E
    .db 1C
    .db 0F
    .db 1D
    .db 0D
    .db 1D
    .db 0E
    .db 1D
    .db 0F
    .db 1E
    .db 0D
    .db 1E
    .db 0E
    .db 1E
    .db 0F
    .db 1F
    .db 14
    .db 1F
    .db 15
    .db 1F
    .db 16
    .db 1F
    .db 13
    .db 20
    .db 14
    .db 20
    .db 15
    .db 20
    .db 16
    .db 20
    .db 13
    .db 21
    .db 14
    .db 21
    .db 15
    .db 21
    .db 16
    .db 21
    .db 13
    .db 22
    .db 14
    .db 22
    .db 15
    .db 22
    .db 16
    .db 22
    .db 13
    .db 23
    .db 14
    .db 23
    .db 15
    .db 23
    .db 16
    .db 23
    .db 13
    .db 24
    .db 14
    .db 24
    .db 15
    .db 24
    .db 16
    .db 24
    .db 13
    .db 25
    .db 31
    .db 25
    .db 32
    .db 25
    .db 33
    .db 26
    .db 34
    .db 27
    .db 35
    .db 27
    .db 36
    .db 28
    .db 35
    .db 28
    .db 36
DATA_E: ; 04:14E8, 0x0094E8
    .db E6
DATA_F: ; 04:14E9, 0x0094E9
    .db 26
    .db C7
    .db 26
    .db 2F
    .db 27
    .db 37
    .db 27
    .db C4
    .db 26
    .db 54
    .db 27
    .db C4
    .db 22
    .db 54
    .db 23
    .db CC
    .db 26
    .db 50
    .db 27
    .db D2
    .db 25
    .db 40
    .db 21
    .db C0
    .db 21
    .db 58
    .db 21
    .db D8
    .db 21
    .db D0
    .db 26
    .db CA
    .db 21
    .db C9
    .db 21
    .db C8
    .db 21
    .db C7
    .db 21
    .db C6
    .db 21
    .db C5
    .db 21
    .db C4
    .db 21
    .db 0B
    .db 21
    .db AC
    .db 21
    .db 44
    .db 21
    .db 4C
    .db 21
    .db 0D
    .db 27
    .db 8D
    .db 22
    .db CF
    .db 22
    .db 0D
    .db 23
    .db 44
    .db 25
    .db 4C
    .db 25
    .db 44
    .db 21
    .db 4C
    .db 21
    .db 5C
    .db 21
    .db 44
    .db 25
    .db B4
    .db 21
    .db 6D
    .db 21
    .db 96
    .db 22
    .db 88
    .db 22
DATA_C_PTR_L: ; 04:153A, 0x00953A
    LOW(FILE_A)
DATA_D_PTR_H: ; 04:153B, 0x00953B
    HIGH(FILE_A)
    LOW(FILE_B)
    HIGH(FILE_B)
    LOW(FILE_C)
    HIGH(FILE_C)
    LOW(FILE_D)
    HIGH(FILE_D)
    LOW(FILE_E)
    HIGH(FILE_E)
    LOW(FILE_F)
    HIGH(FILE_F)
    LOW(FILE_G)
    HIGH(FILE_G)
    LOW(FILE_H)
    HIGH(FILE_H)
    LOW(FILE_I)
    HIGH(FILE_I)
    LOW(FILE_J)
    HIGH(FILE_J)
    LOW(FILE_K)
    HIGH(FILE_K)
    LOW(FILE_L)
    HIGH(FILE_L)
    LOW(FILE_M)
    HIGH(FILE_M)
    LOW(FILE_N)
    HIGH(FILE_N)
    LOW(FILE_O)
    HIGH(FILE_O)
    LOW(FILE_P)
    HIGH(FILE_P)
    LOW(FILE_Q)
    HIGH(FILE_Q)
    LOW(FILE_R)
    HIGH(FILE_R)
    LOW(FILE_S)
    HIGH(FILE_S)
    LOW(FILE_T)
    HIGH(FILE_T)
    LOW(FILE_U)
    HIGH(FILE_U)
    LOW(FILE_V)
    HIGH(FILE_V)
    LOW(FILE_W)
    HIGH(FILE_W)
    LOW(FILE_X)
    HIGH(FILE_X)
    LOW(FILE_Y)
    HIGH(FILE_Y)
    LOW(FILE_Z)
    HIGH(FILE_Z)
    LOW(FILE_AA)
    HIGH(FILE_AA)
    LOW(FILE_AB)
    HIGH(FILE_AB)
    LOW(FILE_AC)
    HIGH(FILE_AC)
    LOW(FILE_AD)
    HIGH(FILE_AD)
    LOW(FILE_AE)
    HIGH(FILE_AE)
    LOW(FILE_AF)
    HIGH(FILE_AF)
    LOW(FILE_AG)
    HIGH(FILE_AG)
    LOW(FILE_AH)
    HIGH(FILE_AH)
    LOW(FILE_AI)
    HIGH(FILE_AI)
    LOW(FILE_AJ)
    HIGH(FILE_AJ)
    LOW(FILE_AK)
    HIGH(FILE_AK)
    LOW(FILE_AL)
    HIGH(FILE_AL)
    LOW(FILE_AM)
    HIGH(FILE_AM)
    LOW(FILE_AN)
    HIGH(FILE_AN)
    LOW(FILE_AO)
    HIGH(FILE_AO)
    LOW(FILE_AP)
    HIGH(FILE_AP)
    LOW(FILE_AQ)
    HIGH(FILE_AQ)
    LOW(FILE_AR)
    HIGH(FILE_AR)
    LOW(FILE_AS)
    HIGH(FILE_AS)
    LOW(FILE_AT)
    HIGH(FILE_AT)
    LOW(FILE_AU)
    HIGH(FILE_AU)
    LOW(FILE_AV)
    HIGH(FILE_AV)
    LOW(FILE_AW)
    HIGH(FILE_AW)
    LOW(FILE_AX)
    HIGH(FILE_AX)
    LOW(FILE_AY)
    HIGH(FILE_AY)
    LOW(FILE_AZ)
    HIGH(FILE_AZ)
    LOW(FILE_BA)
    HIGH(FILE_BA)
    LOW(FILE_BB)
    HIGH(FILE_BB)
    LOW(FILE_BC)
    HIGH(FILE_BC)
    .db 02
    .db 08
    .db 48
    .db 07
    .db 07
    .db 07
    .db 07
    .db 07
    .db 07
    .db 09
    .db 49
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 0A
    .db FF
    .db 02
    .db 08
    .db 4A
    .db 0B
    .db 0B
    .db 0B
    .db 0B
    .db 0B
    .db 0B
    .db 0C
    .db 49
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 0A
    .db FF
    .db 02
    .db 08
    .db 48
    .db 07
    .db 07
    .db 07
    .db 07
    .db 07
    .db 07
    .db 07
    .db 4B
    .db 0D
    .db 0D
    .db 0D
    .db 0D
    .db 9B
    .db 9C
    .db 0E
    .db FF
    .db 02
    .db 08
    .db 4C
    .db 0F
    .db 0F
    .db 0F
    .db 0F
    .db 9D
    .db 3F
    .db 10
    .db 49
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 0A
    .db FF
    .db 02
    .db 08
    .db 4D
    .db 11
    .db 11
    .db 11
    .db 11
    .db 11
    .db 11
    .db 12
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5B
    .db 6B
    .db 3B
    .db 00
    .db FF
    .db 02
    .db 08
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5C
    .db 6C
    .db 3C
    .db 00
    .db 4E
    .db 13
    .db 13
    .db 13
    .db 13
    .db 13
    .db 13
    .db 14
    .db FF
    .db 02
    .db 08
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 6A
    .db 3A
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5B
    .db 6B
    .db 3B
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5C
    .db 6C
    .db 3C
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5D
    .db 6D
    .db 3D
    .db 00
    .db FF
    .db 01
    .db 04
    .db 52
    .db 53
    .db 54
    .db 55
    .db 62
    .db 63
    .db 64
    .db 65
    .db 32
    .db 33
    .db 34
    .db 35
    .db FF
    .db 01
    .db 04
    .db 56
    .db 57
    .db 58
    .db 59
    .db 66
    .db 67
    .db 68
    .db 69
    .db 36
    .db 37
    .db 38
    .db 39
    .db FF
    .db 01
    .db 04
    .db 5A
    .db 5B
    .db 5C
    .db 5D
    .db 6A
    .db 6B
    .db 6C
    .db 6D
    .db 3A
    .db 3B
    .db 3C
    .db 3D
    .db FF
    .db 01
    .db 01
    .db 00
    .db FF
    .db 01
    .db 02
    .db 3E
    .db 3F
    .db 4E
    .db 4F
    .db 5E
    .db 5F
    .db 6E
    .db 6F
    .db 7E
    .db 04
    .db 8E
    .db 8F
    .db FF
    .db 01
    .db 02
    .db 9E
    .db 9F
    .db AE
    .db AF
    .db BE
    .db BF
    .db CE
    .db CF
    .db 24
    .db 13
    .db E0
    .db E1
    .db FF
    .db 01
    .db 02
    .db 23
    .db 8A
    .db 01
    .db 01
    .db 3C
    .db 3C
    .db 10
    .db 1F
    .db 00
    .db 00
    .db 00
    .db 00
    .db FF
    .db 01
    .db 06
    .db A8
    .db A9
    .db AA
    .db AB
    .db AC
    .db AD
    .db B8
    .db B9
    .db BA
    .db BB
    .db BC
    .db BD
    .db C8
    .db C9
    .db CA
    .db CB
    .db CC
    .db CD
    .db 55
    .db 00
    .db 00
    .db 36
    .db 37
    .db CD
    .db FF
    .db 01
    .db 06
    .db 0E
    .db 00
    .db 00
    .db 00
    .db 25
    .db CD
    .db 0E
    .db 00
    .db 00
    .db 00
    .db 56
    .db 57
    .db 0E
    .db 00
    .db 00
    .db 00
    .db 0F
    .db CD
    .db 0E
    .db 00
    .db 00
    .db 00
    .db 0F
    .db CD
    .db 0E
    .db 00
    .db 00
    .db 00
    .db 0F
    .db CD
    .db FF
    .db 01
    .db 08
    .db E2
    .db 0E
    .db 00
    .db 00
    .db 00
    .db 0F
    .db CD
    .db 38
    .db F3
    .db D3
    .db 00
    .db 00
    .db 00
    .db 0F
    .db F9
    .db DD
    .db FE
    .db 0F
    .db 01
    .db 06
    .db D6
    .db F4
    .db F5
    .db F6
    .db F7
    .db F8
    .db FE
    .db 10
    .db 01
    .db 02
    .db 40
    .db 55
    .db FE
    .db 11
    .db 01
    .db 02
    .db 44
    .db 55
    .db FE
    .db 12
    .db 01
    .db 02
    .db 44
    .db 55
    .db FE
    .db 13
    .db 01
    .db 02
    .db A4
    .db A5
    .db FF
    .db 01
    .db 08
    .db E2
    .db 9C
    .db 9B
    .db 02
    .db 98
    .db 0F
    .db CD
    .db 38
    .db F3
    .db 93
    .db 94
    .db 02
    .db 98
    .db 99
    .db 9A
    .db DD
    .db FE
    .db 0F
    .db 01
    .db 06
    .db D6
    .db F4
    .db F5
    .db F6
    .db F7
    .db F8
    .db FE
    .db 13
    .db 01
    .db 02
    .db A4
    .db A5
    .db FF
    .db 01
    .db 04
    .db E4
    .db E5
    .db E6
    .db E7
    .db F4
    .db AB
    .db AC
    .db AD
    .db FF
    .db 01
    .db 04
    .db 14
    .db 00
    .db 00
    .db 15
    .db 24
    .db 00
    .db 00
    .db 00
    .db 34
    .db 00
    .db 00
    .db 25
    .db 54
    .db 00
    .db 00
    .db 35
    .db 24
    .db 00
    .db 00
    .db 55
    .db 64
    .db 00
    .db 00
    .db 65
    .db 74
    .db 00
    .db 00
    .db 75
    .db FF
    .db 02
    .db 07
    .db 82
    .db 83
    .db 00
    .db 00
    .db 85
    .db 87
    .db 54
    .db 64
    .db 84
    .db 00
    .db 00
    .db 86
    .db 88
    .db 89
    .db FF
    .db 01
    .db 06
    .db 3A
    .db 7B
    .db 7C
    .db 7D
    .db 7E
    .db 3F
    .db 4A
    .db 8B
    .db 8C
    .db 8D
    .db 8E
    .db 8F
    .db 4A
    .db 9B
    .db 9C
    .db 9D
    .db 9E
    .db 4F
    .db 6A
    .db F5
    .db F6
    .db F7
    .db A2
    .db A3
    .db FF
    .db 01
    .db 06
    .db 03
    .db 03
    .db 03
    .db 03
    .db 03
    .db 03
    .db 03
    .db F8
    .db F9
    .db FA
    .db FB
    .db 03
    .db 03
    .db 03
    .db 03
    .db A7
    .db A7
    .db 03
    .db 90
    .db 97
    .db 4A
    .db 9F
    .db 8C
    .db 8D
    .db FF
    .db 01
    .db 06
    .db 80
    .db 3E
    .db 3E
    .db 3E
    .db 3E
    .db 3E
    .db 90
    .db 00
    .db 33
    .db 5A
    .db 5A
    .db 5A
    .db 90
    .db 97
    .db 3A
    .db 7B
    .db 7C
    .db 7D
    .db 90
    .db 97
    .db 4A
    .db 8B
    .db 8C
    .db 8D
    .db FF
    .db 01
    .db 06
    .db 3A
    .db 3B
    .db 3C
    .db 3D
    .db 3B
    .db 3F
    .db 4A
    .db 4B
    .db 4C
    .db 4D
    .db 4E
    .db 4F
    .db 4A
    .db 5B
    .db 5C
    .db 5D
    .db 5E
    .db 5F
    .db 6A
    .db 6B
    .db 6C
    .db 6D
    .db 6E
    .db 6F
    .db FF
    .db 01
    .db 06
    .db A4
    .db A5
    .db A6
    .db 03
    .db 03
    .db 03
    .db 03
    .db A4
    .db A5
    .db A6
    .db 03
    .db 03
    .db 03
    .db 03
    .db A4
    .db A5
    .db A6
    .db 03
    .db 90
    .db 97
    .db 4A
    .db 7F
    .db 4C
    .db 4D
    .db FF
    .db 01
    .db 06
    .db 80
    .db 3E
    .db 3E
    .db 3E
    .db 3E
    .db 3E
    .db 90
    .db 00
    .db 33
    .db 5A
    .db 5A
    .db 5A
    .db 90
    .db 97
    .db 3A
    .db 3B
    .db 3C
    .db 3D
    .db 90
    .db 97
    .db 4A
    .db 4B
    .db 4C
    .db 4D
    .db FF
    .db 01
    .db 05
    .db A3
    .db A2
    .db A2
    .db A2
    .db A6
    .db A7
    .db 06
    .db 06
    .db 06
    .db A7
    .db A7
    .db 06
    .db 06
    .db 06
    .db A7
    .db A4
    .db A2
    .db A2
    .db A2
    .db A7
    .db FF
    .db 01
    .db 05
    .db A7
    .db 06
    .db 06
    .db 06
    .db A7
    .db A7
    .db 06
    .db 06
    .db 06
    .db A7
    .db A5
    .db A2
    .db A2
    .db A2
    .db 95
    .db FF
    .db 01
    .db 09
    .db BA
    .db E7
    .db E7
    .db E7
    .db BB
    .db BC
    .db AF
    .db AF
    .db AF
    .db ED
    .db BD
    .db E7
    .db E7
    .db E7
    .db E7
    .db BE
    .db ED
    .db ED
    .db FF
    .db 01
    .db 09
    .db AE
    .db AE
    .db C8
    .db E7
    .db E7
    .db E7
    .db E7
    .db C9
    .db AE
    .db AE
    .db AE
    .db AE
    .db CA
    .db CB
    .db CC
    .db CC
    .db CD
    .db CE
    .db FF
    .db 01
    .db 02
    .db B9
    .db B8
    .db C9
    .db C8
    .db FF
    .db 01
    .db 04
    .db BD
    .db BC
    .db BE
    .db BF
    .db CD
    .db CC
    .db CE
    .db CF
    .db FF
    .db 01
    .db 08
    .db B5
    .db B6
    .db B7
    .db B6
    .db B7
    .db B6
    .db B7
    .db B8
    .db C5
    .db C6
    .db C7
    .db C6
    .db C7
    .db C6
    .db C7
    .db C8
    .db FF
    .db 01
    .db 08
    .db B9
    .db BB
    .db BC
    .db AE
    .db AE
    .db AE
    .db AE
    .db AE
    .db C9
    .db CB
    .db CC
    .db AE
    .db AE
    .db AE
    .db AE
    .db AE
    .db FF
    .db 01
    .db 03
    .db BD
    .db BE
    .db BF
    .db CD
    .db CE
    .db CF
    .db FF
    .db 01
    .db 03
    .db B5
    .db B7
    .db B8
    .db C5
    .db C7
    .db C8
    .db FF
    .db 01
    .db 04
    .db 9C
    .db 9D
    .db 9E
    .db 9F
    .db AC
    .db AD
    .db AE
    .db AF
    .db BC
    .db 6D
    .db 6A
    .db BD
    .db FF
    .db 01
    .db 04
    .db 98
    .db 99
    .db 9A
    .db 9B
    .db A8
    .db A9
    .db AA
    .db AB
    .db B8
    .db B9
    .db BA
    .db BD
    .db FF
    .db 01
    .db 04
    .db 98
    .db 94
    .db 95
    .db 96
    .db BB
    .db 00
    .db 00
    .db 97
    .db A4
    .db A5
    .db A6
    .db A7
    .db FF
    .db 01
    .db 01
    .db A3
    .db FF
    .db 01
    .db 01
    .db B3
    .db FF
    .db 01
    .db 01
    .db 93
    .db FE
    .db 2F
    .db 01
    .db 01
    .db A2
    .db FF
    .db 01
    .db 01
    .db A3
    .db FE
    .db 31
    .db 01
    .db 01
    .db B2
    .db FF
    .db 01
    .db 01
    .db B3
    .db FE
    .db 33
    .db 01
    .db 01
    .db 92
    .db FE
    .db 34
    .db 01
    .db 01
    .db A1
    .db FF
    .db 01
    .db 01
    .db 93
    .db FE
    .db 36
    .db 01
    .db 01
    .db A2
    .db FE
    .db 37
    .db 01
    .db 01
    .db B1
    .db FE
    .db 38
    .db 01
    .db 01
    .db A0
    .db FF
    .db 01
    .db 01
    .db A3
    .db FE
    .db 3A
    .db 01
    .db 01
    .db B2
    .db FE
    .db 3B
    .db 01
    .db 01
    .db 91
    .db FE
    .db 3C
    .db 01
    .db 01
    .db B0
    .db FF
    .db 01
    .db 01
    .db B3
    .db FE
    .db 3E
    .db 01
    .db 01
    .db 92
    .db FE
    .db 3F
    .db 01
    .db 01
    .db A1
    .db FE
    .db 40
    .db 01
    .db 01
    .db 90
    .db FF
    .db 01
    .db 01
    .db B7
    .db FE
    .db 42
    .db 01
    .db 01
    .db A2
    .db FE
    .db 43
    .db 01
    .db 01
    .db B1
    .db FE
    .db 44
    .db 01
    .db 01
    .db A0
    .db FF
    .db 01
    .db 01
    .db C1
    .db FE
    .db 46
    .db 01
    .db 01
    .db B2
    .db FE
    .db 47
    .db 01
    .db 01
    .db 91
    .db FE
    .db 48
    .db 01
    .db 01
    .db B0
    .db FF
    .db 01
    .db 01
    .db C2
    .db FE
    .db 4A
    .db 01
    .db 01
    .db B6
    .db FE
    .db 4B
    .db 01
    .db 01
    .db A1
    .db FE
    .db 4C
    .db 01
    .db 01
    .db 90
    .db FF
    .db 01
    .db 01
    .db C5
    .db FE
    .db 4E
    .db 01
    .db 01
    .db C0
    .db FE
    .db 4F
    .db 01
    .db 01
    .db B1
    .db FE
    .db 50
    .db 01
    .db 01
    .db A0
    .db FF
    .db 01
    .db 01
    .db C7
    .db FE
    .db 52
    .db 01
    .db 01
    .db C3
    .db FE
    .db 53
    .db 01
    .db 01
    .db B5
    .db FE
    .db 54
    .db 01
    .db 01
    .db B0
    .db FF
    .db 01
    .db 01
    .db D6
    .db FE
    .db 56
    .db 01
    .db 01
    .db C4
    .db FE
    .db 57
    .db 01
    .db 01
    .db C1
    .db FE
    .db 58
    .db 01
    .db 01
    .db B4
    .db FF
    .db 01
    .db 01
    .db D7
    .db FE
    .db 5A
    .db 01
    .db 01
    .db C6
    .db FE
    .db 5B
    .db 01
    .db 01
    .db C2
    .db FE
    .db 5C
    .db 01
    .db 01
    .db C0
    .db FF
    .db 01
    .db 01
    .db E4
    .db FE
    .db 5A
    .db 01
    .db 01
    .db E3
    .db FE
    .db 5B
    .db 01
    .db 01
    .db E0
    .db FE
    .db 5C
    .db 01
    .db 01
    .db D1
    .db FF
    .db 01
    .db 01
    .db D4
    .db FE
    .db 56
    .db 01
    .db 01
    .db D3
    .db FE
    .db 57
    .db 01
    .db 01
    .db D0
    .db FE
    .db 58
    .db 01
    .db 01
    .db 6D
    .db FF
    .db 01
    .db 01
    .db E2
    .db FE
    .db 52
    .db 01
    .db 01
    .db E1
    .db FE
    .db 53
    .db 01
    .db 01
    .db 6A
    .db FE
    .db 54
    .db 01
    .db 01
    .db 63
    .db FF
    .db 01
    .db 01
    .db D2
    .db FE
    .db 4E
    .db 01
    .db 01
    .db D1
    .db FE
    .db 4F
    .db 01
    .db 01
    .db 60
    .db FE
    .db 50
    .db 01
    .db 01
    .db 53
    .db FF
    .db 01
    .db 01
    .db E0
    .db FE
    .db 4A
    .db 01
    .db 01
    .db 6B
    .db FE
    .db 4B
    .db 01
    .db 01
    .db 50
    .db FE
    .db 4C
    .db 01
    .db 01
    .db 43
    .db FF
    .db 01
    .db 01
    .db D0
    .db FE
    .db 46
    .db 01
    .db 01
    .db 61
    .db FE
    .db 47
    .db 01
    .db 01
    .db 40
    .db FE
    .db 48
    .db 01
    .db 01
    .db 63
    .db FF
    .db 01
    .db 01
    .db 6C
    .db FE
    .db 42
    .db 01
    .db 01
    .db 51
    .db FE
    .db 43
    .db 01
    .db 01
    .db 60
    .db FE
    .db 44
    .db 01
    .db 01
    .db 53
    .db FF
    .db 01
    .db 01
    .db 62
    .db FE
    .db 3E
    .db 01
    .db 01
    .db 41
    .db FE
    .db 3F
    .db 01
    .db 01
    .db 50
    .db FE
    .db 40
    .db 01
    .db 01
    .db 43
    .db FF
    .db 01
    .db 01
    .db 52
    .db FE
    .db 3A
    .db 01
    .db 01
    .db 61
    .db FE
    .db 3B
    .db 01
    .db 01
    .db 40
    .db FE
    .db 3C
    .db 01
    .db 01
    .db 63
    .db FF
    .db 01
    .db 01
    .db 42
    .db FE
    .db 36
    .db 01
    .db 01
    .db 51
    .db FE
    .db 37
    .db 01
    .db 01
    .db 60
    .db FE
    .db 38
    .db 01
    .db 01
    .db 53
    .db FF
    .db 01
    .db 01
    .db 62
    .db FE
    .db 33
    .db 01
    .db 01
    .db 41
    .db FE
    .db 34
    .db 01
    .db 01
    .db 50
    .db FF
    .db 01
    .db 01
    .db 52
    .db FE
    .db 31
    .db 01
    .db 01
    .db 61
    .db FF
    .db 01
    .db 01
    .db 42
    .db FE
    .db 2F
    .db 01
    .db 01
    .db 51
    .db FF
    .db 01
    .db 01
    .db 62
    .db FF
    .db 01
    .db 01
    .db 52
    .db FF
    .db 01
    .db 0E
    .db 53
    .db 5A
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 36
    .db 37
    .db FE
    .db 5E
    .db 01
    .db 0E
    .db 62
    .db 61
    .db 4A
    .db 4B
    .db 63
    .db 63
    .db 63
    .db 63
    .db 63
    .db 63
    .db 63
    .db 63
    .db 5E
    .db 5F
    .db FE
    .db 6C
    .db 01
    .db 05
    .db 00
    .db 02
    .db 00
    .db 00
    .db 00
    .db FF
    .db 01
    .db 10
    .db 03
    .db 03
    .db 53
    .db 57
    .db 58
    .db 59
    .db 38
    .db 39
    .db 3A
    .db 3B
    .db 3C
    .db 3C
    .db 3C
    .db 3D
    .db 3E
    .db 3F
    .db FE
    .db 60
    .db 01
    .db 10
    .db 03
    .db 53
    .db 61
    .db 47
    .db 48
    .db 49
    .db 28
    .db 29
    .db 2A
    .db 2B
    .db 2C
    .db 2C
    .db 2C
    .db 2D
    .db 2E
    .db 2F
    .db FE
    .db 6D
    .db 01
    .db 05
    .db 00
    .db A6
    .db 15
    .db 05
    .db 09
    .db FF
    .db 01
    .db 10
    .db 53
    .db 61
    .db 64
    .db 65
    .db 66
    .db 67
    .db 68
    .db 69
    .db 6A
    .db 6B
    .db 6B
    .db 6B
    .db 6C
    .db 6D
    .db 6E
    .db 6F
    .db FE
    .db 62
    .db 01
    .db 11
    .db 60
    .db 61
    .db 26
    .db 27
    .db 20
    .db 10
    .db 01
    .db 06
    .db 07
    .db 5C
    .db 5C
    .db 5C
    .db 5D
    .db 4D
    .db 4E
    .db 4F
    .db 53
    .db FE
    .db 6D
    .db 01
    .db 05
    .db 00
    .db A6
    .db 15
    .db 05
    .db 09
    .db FF
    .db 01
    .db 12
    .db 01
    .db 01
    .db 53
    .db 61
    .db 16
    .db 17
    .db 18
    .db 10
    .db 01
    .db 06
    .db 07
    .db 08
    .db 01
    .db 01
    .db 4C
    .db 4D
    .db 4E
    .db 4F
    .db FE
    .db 64
    .db 01
    .db 11
    .db 01
    .db 60
    .db 50
    .db 51
    .db 52
    .db 20
    .db 54
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 56
    .db FF
    .db 01
    .db 11
    .db 01
    .db 01
    .db 40
    .db 41
    .db 42
    .db 43
    .db 44
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 45
    .db FA
    .db FE
    .db 66
    .db 01
    .db 11
    .db 8F
    .db 01
    .db 01
    .db 30
    .db 31
    .db 32
    .db 33
    .db 34
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db EF
    .db FE
    .db 6E
    .db 01
    .db 05
    .db 84
    .db 55
    .db 55
    .db 59
    .db A6
    .db FF
    .db 01
    .db 12
    .db 02
    .db 8F
    .db 01
    .db 01
    .db 20
    .db 21
    .db 22
    .db 23
    .db 24
    .db 68
    .db 68
    .db 68
    .db 68
    .db 68
    .db 68
    .db 68
    .db E8
    .db A8
    .db FE
    .db 68
    .db 01
    .db 12
    .db 02
    .db 02
    .db 8F
    .db EA
    .db EA
    .db 10
    .db 11
    .db 12
    .db 13
    .db 14
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 60
    .db A6
    .db FF
    .db 01
    .db 0F
    .db 02
    .db 8F
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db ED
    .db FE
    .db 6A
    .db 01
    .db 0E
    .db 8B
    .db 7F
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db FE
    .db 6F
    .db 01
    .db 05
    .db 00
    .db 40
    .db 50
    .db 50
    .db 6A
    .db FF
    .db 01
    .db 0E
    .db 7A
    .db C6
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db EC
    .db FE
    .db 70
    .db 01
    .db 04
    .db 0F
    .db 0F
    .db 0F
    .db 0F
    .db FF
    .db 01
    .db 0A
    .db 53
    .db 5A
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db 5B
    .db FE
    .db 72
    .db 01
    .db 0B
    .db 62
    .db 61
    .db 4A
    .db 4B
    .db 63
    .db 63
    .db 63
    .db 63
    .db 63
    .db 63
    .db 63
    .db FE
    .db 73
    .db 01
    .db 0E
    .db 03
    .db 03
    .db 53
    .db 57
    .db 58
    .db 59
    .db 38
    .db 39
    .db 3A
    .db 3B
    .db 3C
    .db 3C
    .db 3C
    .db 3D
    .db FE
    .db 74
    .db 01
    .db 0E
    .db 03
    .db 53
    .db 61
    .db 47
    .db 48
    .db 49
    .db 28
    .db 29
    .db 2A
    .db 2B
    .db 2C
    .db 2C
    .db 2C
    .db 2D
    .db FE
    .db 83
    .db 01
    .db 04
    .db 08
    .db 86
    .db 00
    .db 00
    .db FF
    .db 01
    .db 0E
    .db 53
    .db 61
    .db 64
    .db 65
    .db 66
    .db 67
    .db 68
    .db 69
    .db 6A
    .db 6B
    .db 6B
    .db 6B
    .db 6C
    .db 6D
    .db FE
    .db 76
    .db 01
    .db 0F
    .db 60
    .db 61
    .db 26
    .db 27
    .db 20
    .db 10
    .db 01
    .db 06
    .db 07
    .db 5C
    .db 5C
    .db 5C
    .db 5D
    .db 4D
    .db 4E
    .db FE
    .db 77
    .db 01
    .db 10
    .db 53
    .db 61
    .db 16
    .db 17
    .db 18
    .db 10
    .db 01
    .db 06
    .db 07
    .db 08
    .db 01
    .db 01
    .db 4C
    .db 4D
    .db 4E
    .db 4F
    .db FE
    .db 78
    .db 01
    .db 11
    .db 60
    .db 50
    .db 51
    .db 52
    .db 20
    .db 54
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 55
    .db 56
    .db 03
    .db FF
    .db 01
    .db 05
    .db 00
    .db 86
    .db 55
    .db 55
    .db 59
    .db FE
    .db 79
    .db 01
    .db 14
    .db EE
    .db EE
    .db EE
    .db EE
    .db 40
    .db 41
    .db 42
    .db 43
    .db 44
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 45
    .db B6
    .db 03
    .db FE
    .db 7A
    .db 01
    .db 14
    .db EE
    .db EE
    .db EE
    .db EE
    .db 30
    .db 31
    .db 32
    .db 33
    .db 34
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db AD
    .db 03
    .db 03
    .db FE
    .db 85
    .db 01
    .db 06
    .db 00
    .db 00
    .db 55
    .db 55
    .db 55
    .db A2
    .db FF
    .db 01
    .db 14
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 20
    .db 21
    .db 22
    .db 23
    .db 24
    .db 68
    .db 68
    .db 68
    .db 68
    .db 68
    .db 68
    .db 68
    .db E8
    .db D7
    .db FE
    .db 7C
    .db 01
    .db 13
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 10
    .db 11
    .db 12
    .db 13
    .db 14
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db D8
    .db 93
    .db FE
    .db 85
    .db 01
    .db 06
    .db 00
    .db 00
    .db 55
    .db 55
    .db 55
    .db A2
    .db FF
    .db 01
    .db 10
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 03
    .db 03
    .db FE
    .db 7E
    .db 01
    .db 11
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 03
    .db 53
    .db FE
    .db 86
    .db 01
    .db 06
    .db AA
    .db 00
    .db 00
    .db 00
    .db 08
    .db A6
    .db FF
    .db 01
    .db 12
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 03
    .db 03
    .db 53
    .db 61
    .db FE
    .db 80
    .db 01
    .db 13
    .db 8F
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 03
    .db 53
    .db 61
    .db 26
    .db FE
    .db 86
    .db 01
    .db 06
    .db 00
    .db 00
    .db 00
    .db 00
    .db 08
    .db A6
    .db FF
    .db 01
    .db 12
    .db 02
    .db 8F
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 03
    .db 03
    .db 53
    .db 61
    .db FE
    .db 82
    .db 01
    .db 13
    .db 02
    .db 02
    .db 8F
    .db EA
    .db EA
    .db EA
    .db EA
    .db EA
    .db EA
    .db EA
    .db EA
    .db EA
    .db EA
    .db EA
    .db EA
    .db EB
    .db B7
    .db 50
    .db 51
    .db FE
    .db 87
    .db 01
    .db 05
    .db 00
    .db 00
    .db 00
    .db 00
    .db A6
    .db FF
    .db 01
    .db 08
    .db 53
    .db 61
    .db 16
    .db 17
    .db 18
    .db 10
    .db 01
    .db 06
    .db FE
    .db 89
    .db 01
    .db 09
    .db 60
    .db 50
    .db 51
    .db 52
    .db 20
    .db 54
    .db 55
    .db 55
    .db 55
    .db FE
    .db 96
    .db 01
    .db 03
    .db 00
    .db 06
    .db 05
    .db FF
    .db 01
    .db 0C
    .db EE
    .db EE
    .db EE
    .db EE
    .db 40
    .db 41
    .db 42
    .db 43
    .db 44
    .db 00
    .db 00
    .db 00
    .db FE
    .db 8B
    .db 01
    .db 0C
    .db EE
    .db EE
    .db EE
    .db EE
    .db 30
    .db 31
    .db 32
    .db 33
    .db 34
    .db 00
    .db 00
    .db 00
    .db FE
    .db 8C
    .db 01
    .db 0E
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db 20
    .db 21
    .db 22
    .db 23
    .db 24
    .db 68
    .db 68
    .db 68
    .db FE
    .db 8D
    .db 01
    .db 0E
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db 10
    .db 11
    .db 12
    .db 13
    .db 14
    .db 01
    .db 01
    .db 01
    .db FE
    .db 97
    .db 01
    .db 04
    .db 00
    .db 00
    .db 55
    .db 55
    .db FF
    .db 01
    .db 10
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 8F
    .db 01
    .db 10
    .db EE
    .db EE
    .db EE
    .db EE
    .db FB
    .db FC
    .db FC
    .db FC
    .db FC
    .db FC
    .db FC
    .db FC
    .db FC
    .db FC
    .db FC
    .db FD
    .db FF
    .db 01
    .db 12
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 91
    .db 01
    .db 12
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 98
    .db 01
    .db 05
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db FF
    .db 01
    .db 10
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 93
    .db 01
    .db 10
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 94
    .db 01
    .db 0E
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 53
    .db 5A
    .db FE
    .db 95
    .db 01
    .db 0E
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 01
    .db 62
    .db 61
    .db 4A
    .db FE
    .db 99
    .db 01
    .db 04
    .db 00
    .db 00
    .db 00
    .db 02
    .db FF
    .db 01
    .db 08
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 89
    .db 01
    .db 09
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 9A
    .db 01
    .db 08
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 96
    .db 01
    .db 03
    .db 00
    .db 00
    .db 00
    .db FF
    .db 01
    .db 08
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 9C
    .db 01
    .db 08
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 9D
    .db 01
    .db 08
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db EE
    .db FE
    .db 9E
    .db 01
    .db 02
    .db 00
    .db 00
    .db FF
    .db 01
    .db 03
    .db 17
    .db 75
    .db 98
    .db 26
    .db 17
    .db 75
    .db 93
    .db 26
    .db 65
    .db 60
    .db 93
    .db 70
    .db 01
    .db 60
    .db 80
    .db 01
    .db 01
    .db 90
    .db 37
    .db 01
    .db 01
    .db EE
    .db CB
    .db EE
    .db FF
    .db 01
    .db 04
    .db A0
    .db A1
    .db A2
    .db 01
    .db A0
    .db A1
    .db A2
    .db 01
    .db 9E
    .db C2
    .db C3
    .db AE
    .db EE
    .db EE
    .db F1
    .db EE
    .db F2
    .db F3
    .db F4
    .db F5
    .db F6
    .db F7
    .db F8
    .db F9
    .db FF
    .db 02
    .db 0A
    .db 05
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 08
    .db 2A
    .db 5B
    .db 06
    .db 09
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 2B
    .db 5B
    .db FF
    .db 02
    .db 0A
    .db 07
    .db 0A
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 02
    .db 2C
    .db 51
    .db 0B
    .db 1B
    .db 1B
    .db 1B
    .db 0C
    .db 1C
    .db 1B
    .db 1B
    .db 2D
    .db 51
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 5B
    .db FF
    .db 02
    .db 0A
    .db 43
    .db 53
    .db 53
    .db 53
    .db 53
    .db 53
    .db 53
    .db 53
    .db 50
    .db 5B
    .db 44
    .db 54
    .db 64
    .db 64
    .db 64
    .db 45
    .db 55
    .db 64
    .db 64
    .db 61
    .db FF
    .db 02
    .db 0A
    .db 51
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 5B
    .db 51
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 5B
    .db 51
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 5B
    .db FF
    .db 02
    .db 0A
    .db 51
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 5B
    .db 51
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 5B
    .db FF
    .db 02
    .db 0A
    .db 51
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 5B
    .db 18
    .db 28
    .db 38
    .db 38
    .db 38
    .db 0D
    .db 1D
    .db 38
    .db 38
    .db 27
    .db 19
    .db 29
    .db 29
    .db 29
    .db 29
    .db 29
    .db 29
    .db 29
    .db 1A
    .db 5B
    .db FF
    .db 02
    .db 0A
    .db 51
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 5A
    .db 5B
    .db 51
    .db 00
