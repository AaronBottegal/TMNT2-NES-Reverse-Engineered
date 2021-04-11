    .db 32
RTN_UNK_RET_CC_CONTINUE?: ; 12:0001, 0x024001
    LDA 639_UNK ; Load
    BMI VAL_NEG ; If negative, goto.
    JSR SWITCH_RTN_639 ; Do script.
    CLC ; Clear carry.
    LDA 639_UNK ; Load
    BNE RTS ; If set, goto.
    LDY LEVEL_SCREEN_ON ; Load level.
    LDA LEVEL_DATA_UNK,Y
    BEQ LEVEL_DATA_ZERO
    STA 63A_UNK ; Otherwise set.
    LDA #$FF
    STA 639_UNK ; Set flag unk.
    LDA #$00
    STA DISABLE_RENDERING_X_FRAMES ; Enable rendering.
    CLC ; Clear.
    JMP RTS ; Bad code, coulda just RTS'd here.
VAL_NEG: ; 12:0026, 0x024026
    CLC ; Clear carry.
    DEC 63A_UNK ; --
    BNE RTS ; Not done, RTS.
LEVEL_DATA_ZERO: ; 12:002C, 0x02402C
    LDA 6A8_COPIED_TO_PLAYERS_UNK[2] ; Load val.
    STA OBJECT_DATA_EXTRA_A?[18] ; Store to P1.
    LDA 6A8_COPIED_TO_PLAYERS_UNK+1 ; Load val.
    STA OBJECT_DATA_EXTRA_A?+2 ; Store to P2.
    LDA #$00
    STA 4C_UNK ; Clear these.
    STA 639_UNK
    SEC ; Set carry.
RTS: ; 12:0040, 0x024040
    RTS
SWITCH_RTN_639: ; 12:0041, 0x024041
    LDA 639_UNK ; Switch on.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(SWITCH_RTN_A)
    HIGH(SWITCH_RTN_A)
    LOW(SWITCH_RTN_B)
    HIGH(SWITCH_RTN_B)
    LOW(SWITCH_RTN_C)
    HIGH(SWITCH_RTN_C)
    LOW(SWITCH_RTN_D)
    HIGH(SWITCH_RTN_D)
    LOW(SWITCH_RTN_E)
    HIGH(SWITCH_RTN_E)
    LOW(SWITCH_RTN_F)
    HIGH(SWITCH_RTN_F)
    LOW(SWITCH_RTN_G)
    HIGH(SWITCH_RTN_G)
    LOW(SWITCH_RTN_H)
    HIGH(SWITCH_RTN_H)
    LOW(SWITCH_RTN_I)
    HIGH(SWITCH_RTN_I)
    LOW(SWITCH_RTN_J)
    HIGH(SWITCH_RTN_J)
    LOW(SWITCH_RTN_K)
    HIGH(SWITCH_RTN_K)
    LOW(SWITCH_RTN_L)
    HIGH(SWITCH_RTN_L)
    LOW(SWITCH_RTN_M)
    HIGH(SWITCH_RTN_M)
    LOW(SWITCH_RTN_N)
    HIGH(SWITCH_RTN_N)
    LOW(SWITCH_RTN_B)
    HIGH(SWITCH_RTN_B)
    LOW(SWITCH_RTN_O)
    HIGH(SWITCH_RTN_O)
    LOW(SWITCH_RTN_P)
    HIGH(SWITCH_RTN_P)
    LOW(SWITCH_RTN_Q)
    HIGH(SWITCH_RTN_Q)
    LOW(SWITCH_RTN_R)
    HIGH(SWITCH_RTN_R)
    LOW(SWITCH_RTN_S)
    HIGH(SWITCH_RTN_S)
    LOW(SWITCH_RTN_U)
    HIGH(SWITCH_RTN_U)
    LOW(SWITCH_RTN_V)
    HIGH(SWITCH_RTN_V)
    .db 01
    .db 02
    .db 05
    .db 06
    .db 07
    .db 09
    .db 0D
    .db 0C
    .db 0F
    .db 0B
    .db 0E
    .db 0A
LEVEL_DATA_UNK: ; 12:007F, 0x02407F
    .db 40
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 60
    .db 00
SWITCH_RTN_A: ; 12:008B, 0x02408B
    .db AD
    .db 68
    .db 05
    .db 8D
    .db A8
    .db 06
    .db AD
    .db 6A
    .db 05
    .db 8D
    .db A9
    .db 06
    .db A4
    .db 42
    .db B9
    .db 73
    .db 80
    .db 8D
    .db 39
    .db 06
    .db 98
    .db 20
    .db 98
    .db CC
    .db BB
    .db 80
    .db 44
    .db 81
    .db 7E
    .db 81
    .db AE
    .db 81
    .db 3C
    .db 82
    .db B0
    .db 82
    .db E9
    .db 81
    .db B0
    .db 82
    .db B0
    .db 82
    .db B0
    .db 82
    .db BB
    .db 80
    .db B0
    .db 82
    .db A9
    .db 00
    .db A4
    .db 42
    .db C0
    .db 0A
    .db F0
    .db 02
    .db A9
    .db 01
    .db 85
    .db 4C
    .db A9
    .db 30
    .db 8D
    .db 3A
    .db 06
    .db A5
    .db 42
    .db D0
    .db 0A
    .db A9
    .db 78
    .db 8D
    .db 3A
    .db 06
    .db A9
    .db 0A
    .db 8D
    .db 66
    .db 01
    .db A9
    .db 00
    .db 8D
    .db 12
    .db 04
    .db 8D
    .db 14
    .db 04
    .db A2
    .db 00
    .db A5
    .db 4D
    .db 30
    .db 03
    .db 20
    .db F9
    .db 80
    .db A2
    .db 02
    .db A5
    .db 47
    .db F0
    .db 07
    .db A5
    .db 4E
    .db 30
    .db 03
    .db 20
    .db F9
    .db 80
    .db 60
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db A9
    .db 84
    .db 20
    .db 71
    .db 8F
    .db A9
    .db 01
    .db 9D
    .db 12
    .db 04
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 9D
    .db 36
    .db 04
    .db BD
    .db 7E
    .db 04
    .db 85
    .db 08
    .db BD
    .db A2
    .db 04
    .db 85
    .db 0A
    .db A5
    .db 42
    .db 0A
    .db A8
    .db B9
    .db 2A
    .db 81
    .db 85
    .db 0C
    .db B9
    .db 2B
    .db 81
    .db 85
    .db 0E
    .db 4C
    .db A0
    .db 98
    .db E8
    .db 90
    .db DA
    .db 9D
    .db B0
    .db CC
    .db E8
    .db 90
    .db 01
    .db D0
    .db E8
    .db 90
    .db E8
    .db 90
    .db E8
    .db 90
    .db E8
    .db 90
    .db E8
    .db 90
    .db D4
    .db B8
    .db E8
    .db 90
    .db E8
    .db 90
    .db A9
    .db 01
    .db 85
    .db 4C
    .db A2
    .db 07
    .db 20
    .db D1
    .db F4
    .db A9
    .db C4
    .db 85
    .db 31
    .db A9
    .db C7
    .db 85
    .db 32
    .db A9
    .db 70
    .db 9D
    .db 24
    .db 04
    .db A9
    .db A0
    .db 9D
    .db 7E
    .db 04
    .db A9
    .db 90
    .db 9D
    .db A2
    .db 04
    .db AD
    .db 95
    .db 83
    .db 9D
    .db 00
    .db 04
    .db A9
    .db 20
    .db 9D
    .db 48
    .db 04
    .db 20
    .db 88
    .db F7
    .db A9
    .db 02
    .db 20
    .db 55
    .db 8D
    .db 60
    .db 80
    .db FE
    .db 80
    .db 01
    .db 40
    .db FE
    .db A9
    .db 01
    .db 85
    .db 4C
    .db 20
    .db BB
    .db 80
    .db A2
    .db 00
    .db 20
    .db 8C
    .db 81
    .db A2
    .db 02
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db A9
    .db 84
    .db 20
    .db 71
    .db 8F
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 20
    .db 9D
    .db D4
    .db 05
    .db AD
    .db AC
    .db 81
    .db 9D
    .db 45
    .db 05
    .db AD
    .db AD
    .db 81
    .db 9D
    .db 33
    .db 05
    .db 60
    .db 00
    .db F9
    .db A9
    .db 01
    .db 85
    .db 4C
    .db A2
    .db 00
    .db 20
    .db B9
    .db 81
    .db A2
    .db 02
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db A9
    .db 84
    .db 20
    .db 71
    .db 8F
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 20
    .db 9D
    .db D4
    .db 05
    .db AD
    .db E5
    .db 81
    .db 9D
    .db FC
    .db 04
    .db AD
    .db E6
    .db 81
    .db 9D
    .db EA
    .db 04
    .db AD
    .db E7
    .db 81
    .db 9D
    .db 44
    .db 05
    .db AD
    .db E8
    .db 81
    .db 9D
    .db 32
    .db 05
    .db 60
    .db 00
    .db FE
    .db 00
    .db F9
    .db A9
    .db 01
    .db 85
    .db 4C
    .db A9
    .db 20
    .db 8D
    .db 3A
    .db 06
    .db A9
    .db 00
    .db 8D
    .db 12
    .db 04
    .db 8D
    .db 14
    .db 04
    .db A2
    .db 00
    .db 20
    .db 05
    .db 82
    .db A5
    .db 47
    .db F0
    .db 2F
    .db A2
    .db 02
    .db 8A
    .db 4A
    .db A8
    .db B9
    .db 4D
    .db 00
    .db 30
    .db 24
    .db A9
    .db 01
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 20
    .db 9D
    .db D4
    .db 05
    .db BD
    .db 7E
    .db 04
    .db 85
    .db 08
    .db BD
    .db A2
    .db 04
    .db 85
    .db 0A
    .db A9
    .db E0
    .db 85
    .db 0C
    .db A9
    .db 10
    .db 85
    .db 0E
    .db 20
    .db A0
    .db 98
    .db 60
    .db A9
    .db FF
    .db 85
    .db 4E
    .db A9
    .db 00
    .db 8D
    .db 02
    .db 04
    .db 60
    .db A9
    .db 01
    .db 85
    .db 4C
    .db A9
    .db 00
    .db 8D
    .db 3A
    .db 06
    .db 8D
    .db 12
    .db 04
    .db 8D
    .db 14
    .db 04
    .db 8D
    .db C2
    .db 05
    .db 8D
    .db C4
    .db 05
    .db A9
    .db 08
    .db 8D
    .db 8C
    .db 05
    .db 8D
    .db 8E
    .db 05
    .db A2
    .db 00
    .db A5
    .db 47
    .db F0
    .db 06
    .db A5
    .db 4D
    .db 10
    .db 02
    .db A2
    .db 02
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 01
    .db 9D
    .db C2
    .db 05
    .db A2
    .db 00
    .db 20
    .db 7D
    .db 82
    .db A5
    .db 47
    .db F0
    .db BA
    .db A2
    .db 02
    .db 4C
    .db 86
    .db 82
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db A9
    .db 84
    .db 20
    .db 71
    .db 8F
    .db 8A
    .db 4A
    .db A8
    .db B9
    .db 4D
    .db 00
    .db 30
    .db 21
    .db A9
    .db 01
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 20
    .db 9D
    .db D4
    .db 05
    .db BD
    .db 7E
    .db 04
    .db 85
    .db 08
    .db BD
    .db A2
    .db 04
    .db 85
    .db 0A
    .db AD
    .db 15
    .db 88
    .db 85
    .db 0C
    .db AD
    .db 16
    .db 88
    .db 85
    .db 0E
    .db 20
    .db A0
    .db 98
    .db 60
    .db 60
SWITCH_RTN_B: ; 12:02B1, 0x0242B1
    .db AD
    .db 3A
    .db 06
    .db F0
    .db 0F
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 28
    .db A5
    .db 42
    .db D0
    .db 24
    .db A9
    .db 7D
    .db 20
    .db 52
    .db DB
    .db 60
    .db 20
    .db E4
    .db 82
    .db AD
    .db 12
    .db 04
    .db D0
    .db 03
    .db 8D
    .db 00
    .db 04
    .db AD
    .db 14
    .db 04
    .db D0
    .db 03
    .db 8D
    .db 02
    .db 04
    .db AD
    .db 12
    .db 04
    .db 0D
    .db 14
    .db 04
    .db D0
    .db 03
    .db 20
    .db 00
    .db 8D
    .db 60
    .db A2
    .db 00
    .db A5
    .db 4D
    .db 30
    .db 0A
    .db 20
    .db 09
    .db 83
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db A2
    .db 02
    .db A5
    .db 47
    .db F0
    .db 0E
    .db A5
    .db 4E
    .db 30
    .db 0A
    .db 20
    .db 09
    .db 83
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db 60
    .db A4
    .db 42
    .db B9
    .db 2B
    .db 83
    .db 30
    .db 0B
    .db 25
    .db 1B
    .db D0
    .db 16
    .db 20
    .db 63
    .db 99
    .db B0
    .db 0C
    .db 90
    .db 0F
    .db 20
    .db 63
    .db 99
    .db B0
    .db 05
    .db 20
    .db 63
    .db 99
    .db 90
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 12
    .db 04
    .db 60
    .db FF
    .db 01
    .db 00
    .db 00
    .db FF
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db FF
    .db 00
    .db 00
SWITCH_RTN_C: ; 12:0338, 0x024338
    .db A2
    .db 07
    .db BD
    .db 12
    .db 04
    .db 20
    .db 98
    .db CC
    .db 48
    .db 83
    .db 5D
    .db 83
    .db 96
    .db 83
    .db E1
    .db 83
    .db DE
    .db 48
    .db 04
    .db D0
    .db 0F
    .db FE
    .db 12
    .db 04
    .db AD
    .db 78
    .db 81
    .db 9D
    .db FC
    .db 04
    .db AD
    .db 79
    .db 81
    .db 9D
    .db EA
    .db 04
    .db 60
    .db A9
    .db BC
    .db 85
    .db 31
    .db A9
    .db BD
    .db 85
    .db 32
    .db 20
    .db 7C
    .db F8
    .db DE
    .db 48
    .db 04
    .db 10
    .db 08
    .db A9
    .db 06
    .db 9D
    .db 48
    .db 04
    .db FE
    .db 5A
    .db 04
    .db BD
    .db 5A
    .db 04
    .db 29
    .db 03
    .db A8
    .db B9
    .db 91
    .db 83
    .db 9D
    .db 00
    .db 04
    .db BD
    .db 7E
    .db 04
    .db C9
    .db 31
    .db B0
    .db 58
    .db FE
    .db 12
    .db 04
    .db A9
    .db 18
    .db 9D
    .db 48
    .db 04
    .db 60
    .db 04
    .db 05
    .db 06
    .db 05
    .db 01
    .db A9
    .db BE
    .db 85
    .db 31
    .db A9
    .db BF
    .db 85
    .db 32
    .db A9
    .db 07
    .db 9D
    .db 00
    .db 04
    .db DE
    .db 48
    .db 04
    .db D0
    .db 38
    .db 8A
    .db 48
    .db 20
    .db BB
    .db 80
    .db 68
    .db AA
    .db FE
    .db 12
    .db 04
    .db AD
    .db 7A
    .db 81
    .db 9D
    .db FC
    .db 04
    .db AD
    .db 7B
    .db 81
    .db 9D
    .db EA
    .db 04
    .db AD
    .db 7C
    .db 81
    .db 9D
    .db 44
    .db 05
    .db AD
    .db 7D
    .db 81
    .db 9D
    .db 32
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 36
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 5A
    .db 04
    .db 9D
    .db 48
    .db 04
    .db 8A
    .db 48
    .db A9
    .db 06
    .db 20
    .db D4
    .db EE
    .db 68
    .db AA
    .db 60
    .db 8A
    .db 48
    .db 20
    .db E4
    .db 82
    .db 68
    .db AA
    .db A9
    .db C4
    .db 85
    .db 31
    .db A9
    .db C7
    .db 85
    .db 32
    .db DE
    .db 48
    .db 04
    .db 10
    .db 08
    .db A9
    .db 07
    .db 9D
    .db 48
    .db 04
    .db FE
    .db 5A
    .db 04
    .db BD
    .db 5A
    .db 04
    .db 4A
    .db A9
    .db 02
    .db 90
    .db 02
    .db A9
    .db 03
    .db 9D
    .db 00
    .db 04
    .db A9
    .db 08
    .db 20
    .db 57
    .db F8
    .db 20
    .db 88
    .db F7
    .db 20
    .db 7C
    .db F8
    .db BD
    .db 7E
    .db 04
    .db C9
    .db CB
    .db 90
    .db 0D
    .db A9
    .db 03
    .db 85
    .db 1D
    .db EE
    .db 39
    .db 06
    .db 20
    .db D1
    .db F4
    .db 20
    .db 0E
    .db 8D
    .db 60
SWITCH_RTN_D: ; 12:042A, 0x02442A
    .db A9
    .db 80
    .db 85
    .db 4C
    .db 20
    .db 12
    .db F9
    .db A9
    .db C5
    .db 85
    .db 2F
    .db A9
    .db C6
    .db 85
    .db 30
    .db A9
    .db E5
    .db 85
    .db 2D
    .db A9
    .db E6
    .db 85
    .db 2E
    .db A2
    .db 0A
    .db 20
    .db FD
    .db DB
    .db 20
    .db A1
    .db FE
    .db A9
    .db 01
    .db 20
    .db 55
    .db 8D
    .db A9
    .db 0A
    .db 8D
    .db 26
    .db 04
    .db A9
    .db 90
    .db 8D
    .db 80
    .db 04
    .db A9
    .db 80
    .db 8D
    .db 6E
    .db 04
    .db A9
    .db 00
    .db 8D
    .db 38
    .db 04
    .db A9
    .db 70
    .db 8D
    .db 02
    .db 04
    .db A2
    .db 00
    .db A5
    .db 4D
    .db 30
    .db 03
    .db 20
    .db A4
    .db 84
    .db E8
    .db A5
    .db 47
    .db F0
    .db 07
    .db A5
    .db 4E
    .db 30
    .db 03
    .db 20
    .db A4
    .db 84
    .db A9
    .db 03
    .db 85
    .db 1D
    .db A9
    .db CC
    .db 8D
    .db 3A
    .db 06
    .db 20
    .db FC
    .db 8C
    .db A9
    .db 4F
    .db 20
    .db 52
    .db DB
    .db 60
SWITCH_RTN_E: ; 12:048E, 0x02448E
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 10
    .db A2
    .db 00
    .db 20
    .db D1
    .db F4
    .db E8
    .db 20
    .db D1
    .db F4
    .db E8
    .db 20
    .db D1
    .db F4
    .db 4C
    .db 00
    .db 8D
    .db 60
    .db B5
    .db 33
    .db 0A
    .db 0A
    .db A8
    .db A9
    .db 0A
    .db 9D
    .db 24
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 36
    .db 04
    .db B9
    .db C6
    .db 84
    .db 9D
    .db 7E
    .db 04
    .db B9
    .db C7
    .db 84
    .db 9D
    .db 6C
    .db 04
    .db B9
    .db C8
    .db 84
    .db 9D
    .db 00
    .db 04
    .db 60
    .db C0
    .db 70
    .db 6C
    .db 00
    .db 70
    .db 60
    .db 6D
    .db 00
    .db 60
    .db B0
    .db 6E
    .db 00
    .db 38
    .db 80
    .db 6F
    .db 00
SWITCH_RTN_F: ; 12:04D6, 0x0244D6
    .db A2
    .db 00
    .db 20
    .db 01
    .db 85
    .db A2
    .db 02
    .db A5
    .db 47
    .db D0
    .db 04
    .db A9
    .db FF
    .db 85
    .db 4E
    .db 20
    .db 01
    .db 85
    .db AD
    .db 8C
    .db 05
    .db C9
    .db 05
    .db D0
    .db 11
    .db AD
    .db 8E
    .db 05
    .db C9
    .db 05
    .db D0
    .db 0A
    .db 20
    .db 0E
    .db 8D
    .db 20
    .db 00
    .db 8D
    .db A9
    .db 0A
    .db 85
    .db 1D
    .db 60
    .db 8A
    .db 4A
    .db A8
    .db B9
    .db 4D
    .db 00
    .db 10
    .db 06
    .db A9
    .db 05
    .db 9D
    .db 8C
    .db 05
    .db 60
    .db BD
    .db 8C
    .db 05
    .db 20
    .db 98
    .db CC
    .db 21
    .db 85
    .db 37
    .db 85
    .db 79
    .db 85
    .db 99
    .db 85
    .db 21
    .db 85
    .db C9
    .db 85
    .db DE
    .db D4
    .db 05
    .db D0
    .db 10
    .db FE
    .db 8C
    .db 05
    .db BD
    .db 8C
    .db 05
    .db C9
    .db 01
    .db D0
    .db 06
    .db AD
    .db 2E
    .db 81
    .db 20
    .db 45
    .db 8D
    .db 60
    .db 20
    .db 09
    .db 83
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db 38
    .db AD
    .db 2E
    .db 81
    .db FD
    .db 7E
    .db 04
    .db 10
    .db 05
    .db 49
    .db FF
    .db 18
    .db 69
    .db 01
    .db C9
    .db 30
    .db B0
    .db 25
    .db 38
    .db AD
    .db 2F
    .db 81
    .db FD
    .db A2
    .db 04
    .db 10
    .db 05
    .db 49
    .db FF
    .db 18
    .db 69
    .db 01
    .db C9
    .db 30
    .db B0
    .db 13
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db A9
    .db 90
    .db 20
    .db 71
    .db 8F
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db FE
    .db 8C
    .db 05
    .db 60
    .db 20
    .db 09
    .db 83
    .db A9
    .db 40
    .db 20
    .db 1F
    .db 8D
    .db 90
    .db 0B
    .db FE
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db D4
    .db 05
    .db 9D
    .db C6
    .db 04
    .db 4C
    .db 88
    .db F7
    .db 93
    .db 94
    .db 95
    .db 96
    .db 25
    .db 25
    .db 25
    .db 25
    .db FE
    .db D4
    .db 05
    .db BC
    .db D4
    .db 05
    .db C0
    .db 10
    .db B0
    .db 19
    .db C0
    .db 08
    .db 08
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 28
    .db A9
    .db 0F
    .db 90
    .db 02
    .db A9
    .db 15
    .db 20
    .db 71
    .db 8F
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db 60
    .db FE
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 00
    .db 04
    .db A9
    .db 20
    .db 9D
    .db D4
    .db 05
    .db 60
    .db 54
    .db 97
    .db 92
    .db 98
SWITCH_RTN_G: ; 12:05CE, 0x0245CE
    .db A2
    .db 00
    .db 20
    .db F9
    .db 85
    .db A2
    .db 02
    .db 20
    .db F9
    .db 85
    .db AD
    .db 8C
    .db 05
    .db C9
    .db 04
    .db D0
    .db 19
    .db AD
    .db 8E
    .db 05
    .db C9
    .db 04
    .db D0
    .db 12
    .db A9
    .db 20
    .db 8D
    .db 3A
    .db 06
    .db A9
    .db 10
    .db 8D
    .db 39
    .db 06
    .db 4C
    .db 0E
    .db 8D
    .db A9
    .db 04
    .db 9D
    .db 8C
    .db 05
    .db 60
    .db 8A
    .db 4A
    .db A8
    .db B9
    .db 4D
    .db 00
    .db 30
    .db F2
    .db 98
    .db F0
    .db 04
    .db A5
    .db 47
    .db F0
    .db EB
    .db BD
    .db 8C
    .db 05
    .db 20
    .db 98
    .db CC
    .db 18
    .db 86
    .db 29
    .db 86
    .db 50
    .db 86
    .db 18
    .db 86
    .db 72
    .db 86
    .db DE
    .db D4
    .db 05
    .db D0
    .db 0B
    .db BD
    .db 36
    .db 04
    .db 09
    .db 40
    .db 9D
    .db 36
    .db 04
    .db FE
    .db 8C
    .db 05
    .db 60
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db 20
    .db 7C
    .db F8
    .db BD
    .db 7E
    .db 04
    .db C9
    .db 30
    .db B0
    .db EE
    .db AD
    .db 4E
    .db 86
    .db 9D
    .db FC
    .db 04
    .db AD
    .db 4F
    .db 86
    .db 9D
    .db EA
    .db 04
    .db A9
    .db FB
    .db 9D
    .db C6
    .db 04
    .db 4C
    .db 25
    .db 86
    .db 00
    .db FF
    .db 20
    .db 5F
    .db 8C
    .db A9
    .db 08
    .db 20
    .db 73
    .db 86
    .db B0
    .db 0B
    .db 20
    .db 7C
    .db F8
    .db 90
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 7E
    .db 04
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 00
    .db 04
    .db A9
    .db 40
    .db 9D
    .db D4
    .db 05
    .db 4C
    .db 25
    .db 86
    .db 60
    .db 18
    .db 7D
    .db 44
    .db 05
    .db 9D
    .db 44
    .db 05
    .db 90
    .db 11
    .db FE
    .db 32
    .db 05
    .db BD
    .db 32
    .db 05
    .db 30
    .db 09
    .db C9
    .db 07
    .db 90
    .db 05
    .db A9
    .db 06
    .db 9D
    .db 32
    .db 05
    .db 18
    .db BD
    .db 44
    .db 05
    .db 7D
    .db D8
    .db 04
    .db 9D
    .db D8
    .db 04
    .db BD
    .db 32
    .db 05
    .db 7D
    .db 6C
    .db 04
    .db 9D
    .db 6C
    .db 04
    .db C9
    .db 10
    .db 2A
    .db 49
    .db 01
    .db 4A
    .db 60
SWITCH_RTN_P: ; 12:06A7, 0x0246A7
    .db AD
    .db 3A
    .db 06
    .db F0
    .db 05
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 0B
    .db 20
    .db 71
    .db AD
    .db AD
    .db D6
    .db 03
    .db D0
    .db 03
    .db EE
    .db 39
    .db 06
    .db 60
SWITCH_RTN_Q: ; 12:06BD, 0x0246BD
    .db A9
    .db 80
    .db 85
    .db 4C
    .db 20
    .db 12
    .db F9
    .db A9
    .db FC
    .db 85
    .db 2D
    .db A9
    .db FE
    .db 85
    .db 2E
    .db A9
    .db 08
    .db 85
    .db 2F
    .db A9
    .db 09
    .db 85
    .db 30
    .db A9
    .db 0A
    .db 85
    .db 31
    .db A9
    .db 0B
    .db 85
    .db 32
    .db A2
    .db 20
    .db 20
    .db FD
    .db DB
    .db A9
    .db 13
    .db 20
    .db 55
    .db 8D
    .db A2
    .db 07
    .db A0
    .db 00
    .db A9
    .db 70
    .db 9D
    .db 24
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 36
    .db 04
    .db B9
    .db 26
    .db 87
    .db 9D
    .db 7E
    .db 04
    .db B9
    .db 27
    .db 87
    .db 9D
    .db A2
    .db 04
    .db 9D
    .db 6C
    .db 04
    .db B9
    .db 28
    .db 87
    .db 9D
    .db 00
    .db 04
    .db C8
    .db C8
    .db C8
    .db E8
    .db E0
    .db 0B
    .db 90
    .db D9
    .db A9
    .db 02
    .db 85
    .db 1D
    .db A9
    .db 40
    .db 8D
    .db 3A
    .db 06
    .db EE
    .db 39
    .db 06
    .db A9
    .db 6B
    .db 20
    .db 52
    .db DB
    .db 20
    .db A1
    .db FE
    .db 60
    .db 10
    .db 6F
    .db 4D
    .db 78
    .db 4F
    .db 4E
    .db 90
    .db 7F
    .db 4F
    .db D0
    .db 6F
    .db 50
SWITCH_RTN_R: ; 12:0732, 0x024732
    .db AD
    .db 3A
    .db 06
    .db F0
    .db 09
    .db A9
    .db 02
    .db 85
    .db 1D
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 10
    .db 20
    .db 37
    .db AD
    .db AD
    .db D6
    .db 03
    .db D0
    .db 08
    .db A9
    .db A0
    .db 8D
    .db 3A
    .db 06
    .db EE
    .db 39
    .db 06
    .db 60
SWITCH_RTN_S: ; 12:0751, 0x024751
    .db A5
    .db 1B
    .db 4A
    .db 90
    .db 11
    .db CE
    .db 3A
    .db 06
    .db F0
    .db 0D
    .db AD
    .db 3A
    .db 06
    .db C9
    .db 70
    .db D0
    .db 05
    .db A9
    .db 09
    .db 20
    .db 0C
    .db 97
    .db 60
    .db EE
    .db 39
    .db 06
    .db 60
SWITCH_RTN_U: ; 12:076C, 0x02476C
    .db 20
    .db 71
    .db AD
    .db AD
    .db D6
    .db 03
    .db D0
    .db 08
    .db A9
    .db 50
    .db 8D
    .db 3A
    .db 06
    .db EE
    .db 39
    .db 06
    .db 60
SWITCH_RTN_V: ; 12:077D, 0x02477D
    .db CE
    .db 3A
    .db 06
    .db D0
    .db FA
    .db 4C
    .db 00
    .db 8D
SWITCH_RTN_N: ; 12:0785, 0x024785
    .db A2
    .db 00
    .db 20
    .db 9E
    .db 87
    .db A2
    .db 02
    .db 20
    .db 9E
    .db 87
    .db AD
    .db 12
    .db 04
    .db 0D
    .db 14
    .db 04
    .db D0
    .db 06
    .db 20
    .db 0E
    .db 8D
    .db 4C
    .db 00
    .db 8D
    .db 60
    .db BD
    .db 12
    .db 04
    .db F0
    .db FA
    .db BD
    .db 8C
    .db 05
    .db 20
    .db 98
    .db CC
    .db B1
    .db 87
    .db C2
    .db 87
    .db B1
    .db 87
    .db E1
    .db 87
    .db DE
    .db D4
    .db 05
    .db D0
    .db 0B
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 9D
    .db 36
    .db 04
    .db FE
    .db 8C
    .db 05
    .db 60
    .db 20
    .db 5F
    .db 8C
    .db A0
    .db 05
    .db 98
    .db 48
    .db 20
    .db 63
    .db 99
    .db 68
    .db A8
    .db B0
    .db 04
    .db 88
    .db D0
    .db F4
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 00
    .db 04
    .db A9
    .db A0
    .db 9D
    .db D4
    .db 05
    .db 4C
    .db BE
    .db 87
    .db A9
    .db 00
    .db 9D
    .db 12
    .db 04
    .db 60
SWITCH_RTN_H: ; 12:07E7, 0x0247E7
    .db A2
    .db 00
    .db 20
    .db F8
    .db 87
    .db A2
    .db 02
    .db 20
    .db F8
    .db 87
    .db 60
    .db 20
    .db 54
    .db 8C
    .db 4C
    .db 00
    .db 8D
    .db BD
    .db 12
    .db 04
    .db F0
    .db F4
    .db BD
    .db 8C
    .db 05
    .db 20
    .db 98
    .db CC
    .db 17
    .db 88
    .db BE
    .db 88
    .db 32
    .db 88
    .db E1
    .db 88
    .db 69
    .db 88
    .db 47
    .db 89
    .db B5
    .db 88
    .db 31
    .db 88
    .db 31
    .db 88
    .db 40
    .db B0
    .db DE
    .db D4
    .db 05
    .db D0
    .db 15
    .db BD
    .db 7E
    .db 04
    .db CD
    .db 15
    .db 88
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 90
    .db 02
    .db 09
    .db 40
    .db 9D
    .db 36
    .db 04
    .db FE
    .db 8C
    .db 05
    .db 60
    .db DE
    .db D4
    .db 05
    .db D0
    .db 2D
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 9D
    .db 36
    .db 04
    .db FE
    .db 8C
    .db 05
    .db A9
    .db FD
    .db 9D
    .db C6
    .db 04
    .db AD
    .db 67
    .db 88
    .db 9D
    .db 44
    .db 05
    .db AD
    .db 68
    .db 88
    .db 9D
    .db 32
    .db 05
    .db AD
    .db 65
    .db 88
    .db 9D
    .db FC
    .db 04
    .db AD
    .db 66
    .db 88
    .db 9D
    .db EA
    .db 04
    .db A9
    .db 08
    .db 8D
    .db 3A
    .db 06
    .db 60
    .db 00
    .db 01
    .db 80
    .db FC
    .db 8E
    .db 00
    .db 07
    .db 20
    .db 35
    .db 8A
    .db AE
    .db 00
    .db 07
    .db DE
    .db D4
    .db 05
    .db D0
    .db 3D
    .db 20
    .db F9
    .db 80
    .db A9
    .db 20
    .db 8D
    .db 3A
    .db 06
    .db A9
    .db 05
    .db 9D
    .db 8C
    .db 05
    .db BD
    .db 36
    .db 04
    .db 09
    .db 40
    .db 9D
    .db 36
    .db 04
    .db A5
    .db 47
    .db F0
    .db 24
    .db 8A
    .db 49
    .db 02
    .db 85
    .db 00
    .db 4A
    .db A8
    .db B9
    .db 4D
    .db 00
    .db 30
    .db 18
    .db 8E
    .db 00
    .db 07
    .db A6
    .db 00
    .db 20
    .db F9
    .db 80
    .db BD
    .db 36
    .db 04
    .db 09
    .db 40
    .db 9D
    .db 36
    .db 04
    .db A9
    .db 05
    .db 9D
    .db 8C
    .db 05
    .db AE
    .db 00
    .db 07
    .db 60
    .db DE
    .db D4
    .db 05
    .db D0
    .db 03
    .db FE
    .db 8C
    .db 05
    .db 60
    .db 20
    .db 09
    .db 83
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db BD
    .db 12
    .db 04
    .db D0
    .db 13
    .db FE
    .db 12
    .db 04
    .db FE
    .db 8C
    .db 05
    .db A9
    .db 20
    .db 9D
    .db D4
    .db 05
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 9D
    .db 36
    .db 04
    .db 60
    .db 8E
    .db 00
    .db 07
    .db 20
    .db 35
    .db 8A
    .db AE
    .db 00
    .db 07
    .db BD
    .db 32
    .db 05
    .db 30
    .db 0C
    .db AD
    .db 45
    .db 89
    .db 9D
    .db FC
    .db 04
    .db AD
    .db 46
    .db 89
    .db 9D
    .db EA
    .db 04
    .db 20
    .db 7C
    .db F8
    .db BD
    .db 32
    .db 05
    .db 0A
    .db A9
    .db 18
    .db B0
    .db 02
    .db A9
    .db 20
    .db 20
    .db 57
    .db F8
    .db B0
    .db 22
    .db 20
    .db 88
    .db F7
    .db 20
    .db 5F
    .db 8C
    .db BD
    .db 32
    .db 05
    .db 30
    .db 16
    .db 20
    .db 80
    .db 8C
    .db AD
    .db 3A
    .db 06
    .db F0
    .db 0E
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 09
    .db 8E
    .db 00
    .db 07
    .db 20
    .db 74
    .db 8A
    .db AE
    .db 00
    .db 07
    .db 60
    .db A9
    .db 00
    .db 9D
    .db C6
    .db 04
    .db 9D
    .db 00
    .db 04
    .db A9
    .db 20
    .db 9D
    .db D4
    .db 05
    .db 20
    .db 88
    .db F7
    .db 20
    .db A1
    .db 8C
    .db 4C
    .db 2E
    .db 88
    .db 80
    .db 02
    .db BD
    .db C2
    .db 05
    .db F0
    .db 0E
    .db CE
    .db 3A
    .db 06
    .db F0
    .db 23
    .db 8E
    .db 00
    .db 07
    .db 20
    .db 35
    .db 8A
    .db AE
    .db 00
    .db 07
    .db 20
    .db 09
    .db 83
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db BD
    .db 12
    .db 04
    .db D0
    .db 0A
    .db A9
    .db 01
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 00
    .db 04
    .db 60
    .db A9
    .db 05
    .db 85
    .db 1D
    .db A9
    .db 00
    .db A2
    .db 07
    .db 9D
    .db 00
    .db 04
    .db E8
    .db E0
    .db 12
    .db 90
    .db F8
    .db A9
    .db 00
    .db 8D
    .db 13
    .db 04
    .db 20
    .db FC
    .db 8C
    .db 60
SWITCH_RTN_I: ; 12:098D, 0x02498D
    .db AD
    .db 13
    .db 04
    .db 20
    .db 98
    .db CC
    .db 08
    .db 8A
    .db A3
    .db 89
    .db C1
    .db 89
    .db F3
    .db 89
    .db 85
    .db 8B
    .db E2
    .db 89
    .db FF
    .db 89
    .db 00
    .db 8D
    .db A9
    .db 00
    .db AA
    .db 9D
    .db 00
    .db 04
    .db E8
    .db E0
    .db 12
    .db 90
    .db F8
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 0D
    .db A9
    .db 50
    .db 20
    .db 52
    .db DB
    .db A9
    .db 6C
    .db 8D
    .db 3A
    .db 06
    .db EE
    .db 13
    .db 04
    .db 60
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 12
    .db A9
    .db 20
    .db 8D
    .db 3A
    .db 06
    .db EE
    .db 8C
    .db 05
    .db AD
    .db 8C
    .db 05
    .db C9
    .db 0C
    .db B0
    .db 04
    .db 20
    .db 55
    .db 8D
    .db 60
    .db A9
    .db 40
    .db 8D
    .db 3A
    .db 06
    .db EE
    .db 13
    .db 04
    .db 60
    .db 20
    .db 71
    .db AD
    .db AD
    .db D6
    .db 03
    .db D0
    .db 08
    .db A9
    .db 40
    .db 8D
    .db 3A
    .db 06
    .db EE
    .db 13
    .db 04
    .db 60
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 06
    .db EE
    .db 13
    .db 04
    .db 20
    .db 0C
    .db 8B
    .db 60
    .db CE
    .db 3A
    .db 06
    .db D0
    .db 03
    .db EE
    .db 13
    .db 04
    .db 60
    .db A9
    .db 01
    .db 85
    .db 4C
    .db 20
    .db 12
    .db F9
    .db A9
    .db F0
    .db 85
    .db 2D
    .db A9
    .db F2
    .db 85
    .db 2E
    .db A2
    .db 18
    .db 20
    .db FD
    .db DB
    .db A9
    .db 06
    .db 20
    .db 55
    .db 8D
    .db A9
    .db 04
    .db 85
    .db 1D
    .db A9
    .db 07
    .db 8D
    .db 8C
    .db 05
    .db A9
    .db 50
    .db 8D
    .db 3A
    .db 06
    .db EE
    .db 13
    .db 04
    .db 4C
    .db A1
    .db FE
    .db A2
    .db 07
    .db BD
    .db 24
    .db 04
    .db F0
    .db 03
    .db 20
    .db 45
    .db 8A
    .db E8
    .db E0
    .db 12
    .db 90
    .db F3
    .db 60
    .db BD
    .db 5A
    .db 04
    .db D0
    .db 15
    .db DE
    .db 48
    .db 04
    .db 10
    .db 0F
    .db A9
    .db 07
    .db 9D
    .db 48
    .db 04
    .db FE
    .db 00
    .db 04
    .db BD
    .db 00
    .db 04
    .db C9
    .db 1E
    .db B0
    .db 51
    .db 60
    .db DE
    .db 5A
    .db 04
    .db D0
    .db 0F
    .db A9
    .db 05
    .db 9D
    .db 48
    .db 04
    .db A9
    .db 1B
    .db 9D
    .db 00
    .db 04
    .db A9
    .db 2A
    .db 20
    .db 52
    .db DB
    .db 60
    .db A0
    .db 00
    .db 20
    .db 8F
    .db F6
    .db 90
    .db 2A
    .db 20
    .db D1
    .db F4
    .db A9
    .db 30
    .db 9D
    .db 24
    .db 04
    .db 18
    .db B9
    .db B2
    .db 8A
    .db 69
    .db A0
    .db 9D
    .db 7E
    .db 04
    .db 18
    .db B9
    .db B3
    .db 8A
    .db 69
    .db 80
    .db 9D
    .db A2
    .db 04
    .db 9D
    .db 6C
    .db 04
    .db B9
    .db B4
    .db 8A
    .db 9D
    .db 5A
    .db 04
    .db C8
    .db C8
    .db C8
    .db C0
    .db 1E
    .db 90
    .db D1
    .db A9
    .db 40
    .db 8D
    .db 3A
    .db 06
    .db A9
    .db 29
    .db 85
    .db 32
    .db 60
    .db 4C
    .db D1
    .db F4
    .db 08
    .db 08
    .db 01
    .db F8
    .db F8
    .db 0B
    .db 0A
    .db F6
    .db 16
    .db F8
    .db 08
    .db 21
    .db F6
    .db 00
    .db 2C
    .db F4
    .db F4
    .db 37
    .db 00
    .db 07
    .db 42
    .db 04
    .db FC
    .db 4D
    .db F4
    .db 00
    .db 58
    .db 0C
    .db 0C
    .db 63
    .db A9
    .db 00
    .db 8D
    .db 12
    .db 04
    .db 8D
    .db 14
    .db 04
    .db 8D
    .db 56
    .db 05
    .db 8D
    .db 58
    .db 05
    .db A2
    .db 00
    .db A5
    .db 4D
    .db 30
    .db 03
    .db 20
    .db F5
    .db 8A
    .db A2
    .db 02
    .db A5
    .db 47
    .db F0
    .db 07
    .db A5
    .db 4E
    .db 30
    .db 03
    .db 20
    .db F5
    .db 8A
    .db 60
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db A9
    .db 84
    .db 20
    .db 71
    .db 8F
    .db A9
    .db 01
    .db 9D
    .db 12
    .db 04
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db 9D
    .db 36
    .db 04
    .db 60
    .db A9
    .db 01
    .db 8D
    .db DA
    .db 05
    .db A9
    .db 55
    .db 85
    .db 31
    .db 20
    .db D0
    .db 8A
    .db AD
    .db 00
    .db 04
    .db 8D
    .db B0
    .db 05
    .db AD
    .db 02
    .db 04
    .db 8D
    .db B2
    .db 05
    .db A9
    .db 00
    .db 8D
    .db 00
    .db 04
    .db 8D
    .db 02
    .db 04
    .db 8D
    .db 8C
    .db 05
    .db 8D
    .db 8E
    .db 05
    .db 8D
    .db D4
    .db 05
    .db 8D
    .db D6
    .db 05
    .db 8D
    .db 7E
    .db 04
    .db 8D
    .db 80
    .db 04
    .db A9
    .db C8
    .db 8D
    .db A2
    .db 04
    .db 8D
    .db 6C
    .db 04
    .db A9
    .db D8
    .db 8D
    .db A4
    .db 04
    .db 8D
    .db 6E
    .db 04
    .db A9
    .db 01
    .db 8D
    .db C2
    .db 05
    .db 8D
    .db C4
    .db 05
    .db AD
    .db 83
    .db 8B
    .db 8D
    .db FC
    .db 04
    .db 8D
    .db FE
    .db 04
    .db AD
    .db 84
    .db 8B
    .db 8D
    .db EA
    .db 04
    .db 8D
    .db EC
    .db 04
    .db A2
    .db 00
    .db A5
    .db 47
    .db F0
    .db 06
    .db A5
    .db 4D
    .db 10
    .db 02
    .db A2
    .db 02
    .db A9
    .db 01
    .db 9D
    .db D4
    .db 05
    .db 8A
    .db 49
    .db 02
    .db AA
    .db A9
    .db 18
    .db 9D
    .db C2
    .db 05
    .db 60
    .db C0
    .db 00
    .db A2
    .db 00
    .db 20
    .db 90
    .db 8B
    .db A2
    .db 02
    .db 20
    .db 90
    .db 8B
    .db 60
    .db BD
    .db 12
    .db 04
    .db F0
    .db FA
    .db BD
    .db 8C
    .db 05
    .db 20
    .db 98
    .db CC
    .db A1
    .db 8B
    .db C4
    .db 8B
    .db 0F
    .db 8C
    .db DE
    .db C2
    .db 05
    .db D0
    .db 1D
    .db BD
    .db B0
    .db 05
    .db 9D
    .db 00
    .db 04
    .db A9
    .db A0
    .db 9D
    .db C2
    .db 05
    .db FE
    .db 8C
    .db 05
    .db AD
    .db DA
    .db 05
    .db F0
    .db 0A
    .db A9
    .db 00
    .db 8D
    .db DA
    .db 05
    .db A9
    .db 6C
    .db 20
    .db 52
    .db DB
    .db 60
    .db 8A
    .db 4A
    .db 85
    .db 08
    .db 20
    .db 1D
    .db 90
    .db 20
    .db 7C
    .db F8
    .db 90
    .db 05
    .db A9
    .db 01
    .db 9D
    .db 56
    .db 05
    .db BD
    .db D4
    .db 05
    .db F0
    .db 34
    .db BD
    .db 7E
    .db 04
    .db C9
    .db 90
    .db 90
    .db 2D
    .db 20
    .db A1
    .db 8C
    .db A0
    .db 07
    .db A9
    .db 70
    .db 99
    .db 24
    .db 04
    .db A9
    .db 98
    .db 99
    .db 7E
    .db 04
    .db A9
    .db 9C
    .db 99
    .db A2
    .db 04
    .db 99
    .db 6C
    .db 04
    .db A9
    .db 00
    .db 99
    .db 36
    .db 04
    .db A9
    .db 51
    .db 99
    .db 00
    .db 04
    .db A9
    .db 55
    .db 85
    .db 31
    .db A9
    .db D0
    .db 9D
    .db C2
    .db 05
    .db FE
    .db 8C
    .db 05
    .db 60
    .db DE
    .db C2
    .db 05
    .db D0
    .db 03
    .db EE
    .db 13
    .db 04
    .db 60
SWITCH_RTN_J: ; 12:0C18, 0x024C18
    .db 20
    .db 14
    .db A0
    .db AD
    .db 11
    .db 06
    .db D0
    .db 03
    .db 20
    .db 00
    .db 8D
    .db 60
SWITCH_RTN_K: ; 12:0C24, 0x024C24
    .db 20
    .db E4
    .db A6
    .db AD
    .db 11
    .db 06
    .db D0
    .db 03
    .db 20
    .db 04
    .db 8D
    .db 60
SWITCH_RTN_L: ; 12:0C30, 0x024C30
    .db 20
    .db F7
    .db A8
    .db AD
    .db 11
    .db 06
    .db D0
    .db 03
    .db 20
    .db 00
    .db 8D
    .db 60
SWITCH_RTN_M: ; 12:0C3C, 0x024C3C
    .db 20
    .db F6
    .db A3
    .db AD
    .db 11
    .db 06
    .db D0
    .db 03
    .db 20
    .db 00
    .db 8D
    .db 60
SWITCH_RTN_O: ; 12:0C48, 0x024C48
    .db 20
    .db 93
    .db A4
    .db AD
    .db 11
    .db 06
    .db D0
    .db 03
    .db 20
    .db 00
    .db 8D
    .db 60
    .db A2
    .db 00
    .db 20
    .db D1
    .db F4
    .db E8
    .db E0
    .db 12
    .db 90
    .db F8
    .db 60
    .db 8A
    .db 4A
    .db 85
    .db 00
    .db A8
    .db B9
    .db 33
    .db 00
    .db 0A
    .db A8
    .db B9
    .db 78
    .db 8C
    .db 9D
    .db 00
    .db 04
    .db B9
    .db 79
    .db 8C
    .db A4
    .db 00
    .db 99
    .db 2F
    .db 00
    .db 60
    .db 14
    .db 25
    .db 23
    .db 25
    .db 30
    .db 25
    .db 3D
    .db 25
    .db 8A
    .db 4A
    .db 85
    .db 00
    .db A8
    .db B9
    .db 33
    .db 00
    .db 0A
    .db A8
    .db B9
    .db 99
    .db 8C
    .db 9D
    .db 00
    .db 04
    .db B9
    .db 9A
    .db 8C
    .db A4
    .db 00
    .db 99
    .db 2F
    .db 00
    .db 60
    .db 09
    .db 21
    .db 09
    .db 21
    .db 09
    .db 21
    .db 09
    .db 21
    .db 8A
    .db 4A
    .db 85
    .db 00
    .db A8
    .db B9
    .db 33
    .db 00
    .db 0A
    .db A8
    .db B9
    .db BA
    .db 8C
    .db 9D
    .db 00
    .db 04
    .db B9
    .db BB
    .db 8C
    .db A4
    .db 00
    .db 99
    .db 2F
    .db 00
    .db 60
    .db 12
    .db 22
    .db 21
    .db 39
    .db 2E
    .db 3E
    .db 3B
    .db 43
    .db A9
    .db 07
    .db 9D
    .db 48
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 5A
    .db 04
    .db 60
    .db DE
    .db 48
    .db 04
    .db 10
    .db 08
    .db A9
    .db 07
    .db 9D
    .db 48
    .db 04
    .db FE
    .db 5A
    .db 04
    .db BD
    .db 5A
    .db 04
    .db 29
    .db 03
    .db 85
    .db 00
    .db 8A
    .db 4A
    .db A8
    .db B9
    .db 33
    .db 00
    .db 48
    .db 0A
    .db 0A
    .db 05
    .db 00
    .db A8
    .db B9
    .db F8
    .db 96
    .db 9D
    .db 00
    .db 04
    .db 68
    .db A8
    .db B9
    .db 08
    .db 97
    .db 99
    .db 2F
    .db 00
    .db 60
    .db EE
    .db 39
    .db 06
    .db 60
    .db A9
    .db 03
    .db 85
    .db 1D
    .db A9
    .db 00
    .db 85
    .db 4C
    .db 8D
    .db 39
    .db 06
    .db 4C
    .db 0E
    .db 8D
PREP_OBJS_0-3: ; 12:0D0E, 0x024D0E
    LDX #$00
    JSR INIT_OBJECT[X]_DATA? ; Init 0-3
    INX
    JSR INIT_OBJECT[X]_DATA?
    INX
    JSR INIT_OBJECT[X]_DATA?
    INX
    JMP INIT_OBJECT[X]_DATA? ; Abuse RTS.
    CLC
    ADC 544_ARR_UNK+1,X
    STA 544_ARR_UNK+1,X
    BCC 12:0D2B
    INC 532_ARR_UNK+1,X
    CLC
    LDA 544_ARR_UNK+1,X
    ADC 4D8_ARR_UNK[18],X
    STA 4D8_ARR_UNK[18],X
    LDA 532_ARR_UNK+1,X
    ADC 4C6_ARR_UNK[18],X
    STA 4C6_ARR_UNK[18],X
    BPL 12:0D43
    CLC
    BMI 12:0D44
    SEC
    RTS
    CMP 47E_ARR_UNK[18],X
    LDA OBJ_DIRECTION_RELATED?[18],X
    AND #$BF
    BCS 12:0D51
    ORA #$40
    STA OBJ_DIRECTION_RELATED?[18],X
    RTS
RTN_PALETTE+BG_MOD: ; 12:0D55, 0x024D55
    JSR PALETTE_MOD_FROM_FILE
    TXA ; Save X.
    PHA
    LDA #$05 ; File 5.
    JSR UNK_STREAM_0x300_SETUP_BANK_1C/1D
    PLA
    TAX ; Restore X.
    RTS
PALETTE_MOD_FROM_FILE: ; 12:0D62, 0x024D62
    ASL A ; A to index.
    TAY ; To Y.
    TXA ; X to A.
    PHA ; Save X.
    LDA PALETTE_DATA_PTRS_LOW,Y ; Set up data file ptr from Y.
    STA TMP_00
    LDA PALETTE_DATA_PTRS_HIGH,Y
    STA TMP_01
    LDY #$00 ; Reset stream pointer.
LOOP_MORE_PALETTE_MANIPS: ; 12:0D72, 0x024D72
    LDA [TMP_00],Y ; Load palette manipulating.
    CMP #$FF
    BEQ EOF_MARKER
    STA TMP_02 ; Store to.
    INY ; Stream++
    ASL A ; << 2, *4
    ASL A
    TAX ; To X index.
    LDA [TMP_00],Y ; Data from.
    STA PPU_PALETTE_BUF?[32],X ; Store to X index.
    INY ; Stream++
    LDA [TMP_00],Y ; A from file.
    STA ARR_6D7_UNK+3,X ; To.
    INY
    LDA [TMP_00],Y
    STA ARR_6D7_UNK+4,X ; To
    INY
    LDA [TMP_00],Y
    STA ARR_6D7_UNK+5,X ; To
    INY ; Stream++
    JMP LOOP_MORE_PALETTE_MANIPS
EOF_MARKER: ; 12:0D99, 0x024D99
    PLA ; Restore X.
    TAX
    RTS ; Leave.
PALETTE_DATA_PTRS_LOW: ; 12:0D9C, 0x024D9C
    LOW(PALETTE_DATA_A)
PALETTE_DATA_PTRS_HIGH: ; 12:0D9D, 0x024D9D
    HIGH(PALETTE_DATA_A)
    LOW(PALETTE_DATA_A)
    HIGH(PALETTE_DATA_A)
    LOW(PALETTE_DATA_B)
    HIGH(PALETTE_DATA_B)
    LOW(PALETTE_DATA_C)
    HIGH(PALETTE_DATA_C)
    LOW(PALETTE_DATA_D)
    HIGH(PALETTE_DATA_D)
    LOW(PALETTE_DATA_E)
    HIGH(PALETTE_DATA_E)
    LOW(PALETTE_DATA_F)
    HIGH(PALETTE_DATA_F)
    LOW(PALETTE_DATA_10)
    HIGH(PALETTE_DATA_10)
    LOW(PALETTE_DATA_11)
    HIGH(PALETTE_DATA_11)
    LOW(PALETTE_DATA_12)
    HIGH(PALETTE_DATA_12)
    LOW(PALETTE_DATA_13)
    HIGH(PALETTE_DATA_13)
    LOW(PALETTE_DATA_14)
    HIGH(PALETTE_DATA_14)
    LOW(PALETTE_DATA_15)
    HIGH(PALETTE_DATA_15)
    LOW(PALETTE_DATA_16)
    HIGH(PALETTE_DATA_16)
    LOW(PALETTE_DATA_17)
    HIGH(PALETTE_DATA_17)
    LOW(PALETTE_DATA_18)
    HIGH(PALETTE_DATA_18)
    LOW(PALETTE_DATA_19)
    HIGH(PALETTE_DATA_19)
    LOW(PALETTE_DATA_1A)
    HIGH(PALETTE_DATA_1A)
    LOW(PALETTE_DATA_1B)
    HIGH(PALETTE_DATA_1B)
    LOW(PALETTE_DATA_1C)
    HIGH(PALETTE_DATA_1C)
PALETTE_DATA_A: ; 12:0DC4, 0x024DC4
    .db 00
    .db 0F
    .db 14
    .db 28
    .db 10
    .db 01
    .db 0F
    .db 17
    .db 06
    .db 0C
    .db 02
    .db 0F
    .db 14
    .db 28
    .db 37
    .db 03
    .db 0F
    .db 28
    .db 10
    .db 37
    .db 04
    .db 0F
    .db 20
    .db 1A
    .db 11
    .db 05
    .db 0F
    .db 0F
    .db 1A
    .db 27
    .db 06
    .db 0F
    .db 0F
    .db 1A
    .db 14
    .db 07
    .db 0F
    .db 0F
    .db 1A
    .db 16
    .db FF
PALETTE_DATA_B: ; 12:0DED, 0x024DED
    .db 06
    .db 0F
    .db 16
    .db 28
    .db 20
    .db 07
    .db 0F
    .db 08
    .db 23
    .db 20
    .db FF
PALETTE_DATA_C: ; 12:0DF8, 0x024DF8
    .db 00
    .db 0F
    .db 20
    .db 20
    .db 20
    .db 01
    .db 0F
    .db 20
    .db 20
    .db 20
    .db 02
    .db 0F
    .db 20
    .db 20
    .db 20
    .db 03
    .db 0F
    .db 20
    .db 20
    .db 20
    .db 04
    .db 0F
    .db 20
    .db 20
    .db 20
    .db 05
    .db 0F
    .db 20
    .db 20
    .db 20
    .db 06
    .db 0F
    .db 20
    .db 20
    .db 20
    .db 07
    .db 0F
    .db 20
    .db 20
    .db 20
    .db FF
PALETTE_DATA_D: ; 12:0E21, 0x024E21
    .db 00
    .db 0F
    .db 16
    .db 00
    .db 3C
    .db 01
    .db 0F
    .db 00
    .db 16
    .db 27
    .db 02
    .db 0F
    .db 0C
    .db 14
    .db 3C
    .db 03
    .db 0F
    .db 25
    .db 00
    .db 27
    .db 04
    .db 0F
    .db 0F
    .db 19
    .db 11
    .db 05
    .db 0F
    .db 0F
    .db 19
    .db 27
    .db 06
    .db 0F
    .db 0F
    .db 19
    .db 14
    .db 07
    .db 0F
    .db 0F
    .db 19
    .db 16
    .db FF
PALETTE_DATA_E: ; 12:0E4A, 0x024E4A
    .db 00
    .db 0F
    .db 06
    .db 00
    .db 3C
    .db 01
    .db 0F
    .db 16
    .db 26
    .db 37
    .db 02
    .db 0F
    .db 16
    .db 0C
    .db 1C
    .db 03
    .db 0F
    .db 0C
    .db 24
    .db 00
    .db 04
    .db 0F
    .db 0A
    .db 29
    .db 11
    .db 05
    .db 0F
    .db 0A
    .db 29
    .db 27
    .db 06
    .db 0F
    .db 0A
    .db 29
    .db 14
    .db 07
    .db 0F
    .db 0A
    .db 29
    .db 16
    .db FF
PALETTE_DATA_F: ; 12:0E73, 0x024E73
    .db 00
    .db 0F
    .db 19
    .db 00
    .db 20
    .db 01
    .db 0F
    .db 0F
    .db 00
    .db 10
    .db 02
    .db 0F
    .db 1C
    .db 2C
    .db 20
    .db 03
    .db 0F
    .db 1C
    .db 00
    .db 10
    .db FF
PALETTE_DATA_10: ; 12:0E88, 0x024E88
    .db 00
    .db 0F
    .db 19
    .db 00
    .db 20
    .db 01
    .db 0F
    .db 0F
    .db 00
    .db 10
    .db 02
    .db 0F
    .db 2C
    .db 3C
    .db 20
    .db 03
    .db 0F
    .db 2C
    .db 00
    .db 10
    .db FF
PALETTE_DATA_11: ; 12:0E9D, 0x024E9D
    .db 00
    .db 0F
    .db 19
    .db 00
    .db 20
    .db 01
    .db 0F
    .db 0F
    .db 00
    .db 10
    .db 02
    .db 0F
    .db 2C
    .db 3C
    .db 3C
    .db 03
    .db 0F
    .db 2C
    .db 00
    .db 10
    .db FF
PALETTE_DATA_12: ; 12:0EB2, 0x024EB2
    .db 00
    .db 0F
    .db 19
    .db 10
    .db 20
    .db 01
    .db 0F
    .db 00
    .db 10
    .db 20
    .db 02
    .db 0F
    .db 3C
    .db 31
    .db 31
    .db 03
    .db 0F
    .db 3C
    .db 10
    .db 20
    .db FF
PALETTE_DATA_13: ; 12:0EC7, 0x024EC7
    .db 00
    .db 0F
    .db 19
    .db 10
    .db 31
    .db 01
    .db 0F
    .db 00
    .db 10
    .db 20
    .db 02
    .db 0F
    .db 31
    .db 31
    .db 31
    .db 03
    .db 0F
    .db 31
    .db 10
    .db 20
    .db FF
PALETTE_DATA_14: ; 12:0EDC, 0x024EDC
    .db 00
    .db 0F
    .db 19
    .db 10
    .db 39
    .db 01
    .db 0F
    .db 00
    .db 10
    .db 20
    .db 02
    .db 0F
    .db 31
    .db 31
    .db 31
    .db 03
    .db 0F
    .db 31
    .db 10
    .db 20
    .db FF
PALETTE_DATA_15: ; 12:0EF1, 0x024EF1
    .db 00
    .db 0F
    .db 00
    .db 10
    .db 20
    .db 01
    .db 0F
    .db 18
    .db 10
    .db 20
    .db 02
    .db 0F
    .db 00
    .db 10
    .db 20
    .db 03
    .db 0F
    .db 31
    .db 10
    .db 20
    .db 04
    .db 0F
    .db 37
    .db 19
    .db 39
    .db 05
    .db 0F
    .db 2A
    .db 3A
    .db 0F
    .db 06
    .db 0F
    .db 28
    .db 10
    .db 20
    .db 07
    .db 0F
    .db 0F
    .db 0F
    .db 20
    .db FF
PALETTE_DATA_16: ; 12:0F1A, 0x024F1A
    .db 02
    .db 0F
    .db 21
    .db 29
    .db 20
    .db FF
PALETTE_DATA_17: ; 12:0F20, 0x024F20
    .db 02
    .db 0F
    .db 28
    .db 29
    .db 20
    .db FF
PALETTE_DATA_18: ; 12:0F26, 0x024F26
    .db 02
    .db 0F
    .db 26
    .db 29
    .db 20
    .db FF
PALETTE_DATA_19: ; 12:0F2C, 0x024F2C
    .db 02
    .db 0F
    .db 24
    .db 29
    .db 20
    .db FF
PALETTE_DATA_1A: ; 12:0F32, 0x024F32
    .db 02
    .db 0F
    .db 10
    .db 24
    .db 20
    .db FF
PALETTE_DATA_1B: ; 12:0F38, 0x024F38
    .db 00
    .db 0F
    .db 00
    .db 10
    .db 20
    .db 01
    .db 0F
    .db 17
    .db 26
    .db 37
    .db 02
    .db 0F
    .db 14
    .db 24
    .db 34
    .db FF
PALETTE_DATA_1C: ; 12:0F48, 0x024F48
    .db 00
    .db 0F
    .db 37
    .db 28
    .db 24
    .db 01
    .db 0F
    .db 37
    .db 10
    .db 24
    .db 02
    .db 0F
    .db 20
    .db 10
    .db 24
    .db 03
    .db 0F
    .db 20
    .db 18
    .db 24
    .db 04
    .db 0F
    .db 2B
    .db 26
    .db 28
    .db 05
    .db 0F
    .db 18
    .db 20
    .db 0F
    .db 06
    .db 0F
    .db 20
    .db 20
    .db 20
    .db 07
    .db 0F
    .db 20
    .db 20
    .db 20
    .db FF
    .db C9
    .db 80
    .db B0
    .db 14
    .db A8
    .db BD
    .db 12
    .db 04
    .db 29
    .db 20
    .db F0
    .db 06
    .db B9
    .db CF
    .db 8F
    .db 4C
    .db A6
    .db 8F
    .db B9
    .db B9
    .db 8F
    .db 4C
    .db A6
    .db 8F
    .db 29
    .db 7F
    .db 85
    .db 00
    .db A4
    .db 08
    .db B9
    .db 33
    .db 00
    .db 18
    .db 65
    .db 00
    .db A8
    .db BD
    .db 12
    .db 04
    .db 29
    .db 20
    .db F0
    .db 06
    .db B9
    .db FD
    .db 8F
    .db 4C
    .db A6
    .db 8F
    .db B9
    .db D9
    .db 8F
    .db DD
    .db 24
    .db 04
    .db F0
    .db 0B
    .db 9D
    .db 24
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 48
    .db 04
    .db 9D
    .db 5A
    .db 04
    .db A4
    .db 08
    .db 60
    .db 00
    .db 01
    .db 02
    .db 03
    .db 04
    .db 05
    .db 08
    .db 0A
    .db 13
    .db 0F
    .db 0F
    .db 09
    .db 0C
    .db 10
    .db 11
    .db 0B
    .db 12
    .db 06
    .db 07
    .db 16
    .db 17
    .db 18
    .db 00
    .db 0D
    .db 02
    .db 0E
    .db 04
    .db 05
    .db 15
    .db 0A
    .db 14
    .db 0F
    .db 19
    .db 29
    .db 39
    .db 49
    .db 1A
    .db 2A
    .db 3A
    .db 4A
    .db 1B
    .db 2B
    .db 3B
    .db 4B
    .db 1D
    .db 2D
    .db 3D
    .db 4D
    .db 1E
    .db 2E
    .db 3E
    .db 4E
    .db 1F
    .db 2F
    .db 3F
    .db 4F
    .db 20
    .db 30
    .db 40
    .db 50
    .db 1C
    .db 2C
    .db 3C
    .db 4C
    .db 25
    .db 35
    .db 45
    .db 55
    .db 24
    .db 34
    .db 44
    .db 54
    .db 21
    .db 31
    .db 41
    .db 51
    .db 22
    .db 32
    .db 42
    .db 52
    .db 1D
    .db 2D
    .db 3D
    .db 4D
    .db 23
    .db 33
    .db 43
    .db 53
    .db 27
    .db 37
    .db 47
    .db 57
    .db 28
    .db 38
    .db 48
    .db 58
    .db 26
    .db 36
    .db 46
    .db 56
    .db BD
    .db 48
    .db 04
    .db F0
    .db 04
    .db DE
    .db 48
    .db 04
    .db 60
    .db BD
    .db 24
    .db 04
    .db 30
    .db FA
    .db 0A
    .db A8
    .db B9
    .db 99
    .db 90
    .db 85
    .db 00
    .db B9
    .db 9A
    .db 90
    .db 85
    .db 01
    .db A4
    .db 08
    .db B9
    .db 60
    .db 00
    .db 85
    .db 03
    .db BD
    .db 5A
    .db 04
    .db FE
    .db 5A
    .db 04
    .db 85
    .db 02
    .db 0A
    .db 18
    .db 65
    .db 02
    .db A8
    .db B1
    .db 00
    .db C9
    .db FF
    .db F0
    .db 2E
    .db C9
    .db FE
    .db F0
    .db 3D
    .db A5
    .db 03
    .db F0
    .db 04
    .db A9
    .db 00
    .db F0
    .db 02
    .db B1
    .db 00
    .db 9D
    .db 00
    .db 04
    .db C8
    .db B1
    .db 00
    .db C9
    .db FF
    .db F0
    .db 0F
    .db E0
    .db 02
    .db F0
    .db 09
    .db E0
    .db 00
    .db D0
    .db 07
    .db 85
    .db 2F
    .db 4C
    .db 78
    .db 90
    .db 85
    .db 30
    .db C8
    .db B1
    .db 00
    .db 9D
    .db 48
    .db 04
    .db 60
    .db A4
    .db 08
    .db A9
    .db 00
    .db 9D
    .db 5A
    .db 04
    .db 9D
    .db 48
    .db 04
    .db BD
    .db 24
    .db 04
    .db 09
    .db 80
    .db 9D
    .db 24
    .db 04
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 5A
    .db 04
    .db F0
    .db A5
    .db 4B
    .db 91
    .db 4F
    .db 91
    .db 53
    .db 91
    .db 57
    .db 91
    .db 5E
    .db 91
    .db 6B
    .db 91
    .db 6F
    .db 91
    .db 73
    .db 91
    .db 7A
    .db 91
    .db 81
    .db 91
    .db 8F
    .db 91
    .db 93
    .db 91
    .db A9
    .db 91
    .db AD
    .db 91
    .db B1
    .db 91
    .db B8
    .db 91
    .db BC
    .db 91
    .db C3
    .db 91
    .db CA
    .db 91
    .db D4
    .db 91
    .db D8
    .db 91
    .db DC
    .db 91
    .db 88
    .db 91
    .db E3
    .db 91
    .db ED
    .db 91
    .db F1
    .db 91
    .db F8
    .db 91
    .db 05
    .db 92
    .db 12
    .db 92
    .db 1F
    .db 92
    .db 29
    .db 92
    .db 2D
    .db 92
    .db 31
    .db 92
    .db 35
    .db 92
    .db 42
    .db 92
    .db 29
    .db 92
    .db 4F
    .db 92
    .db 56
    .db 92
    .db 63
    .db 92
    .db 70
    .db 92
    .db 74
    .db 92
    .db 78
    .db 92
    .db 7F
    .db 92
    .db 90
    .db 92
    .db 9D
    .db 92
    .db AA
    .db 92
    .db 8C
    .db 92
    .db B7
    .db 92
    .db BB
    .db 92
    .db BF
    .db 92
    .db CC
    .db 92
    .db 8C
    .db 92
    .db D9
    .db 92
    .db E0
    .db 92
    .db ED
    .db 92
    .db FA
    .db 92
    .db FE
    .db 92
    .db 02
    .db 93
    .db 09
    .db 93
    .db 1A
    .db 93
    .db 27
    .db 93
    .db 34
    .db 93
    .db 16
    .db 93
    .db 41
    .db 93
    .db 45
    .db 93
    .db 49
    .db 93
    .db 56
    .db 93
    .db 16
    .db 93
    .db 63
    .db 93
    .db 6A
    .db 93
    .db 77
    .db 93
    .db 84
    .db 93
    .db 88
    .db 93
    .db 8C
    .db 93
    .db 93
    .db 93
    .db A4
    .db 93
    .db B1
    .db 93
    .db BE
    .db 93
    .db A0
    .db 93
    .db CB
    .db 93
    .db CF
    .db 93
    .db D3
    .db 93
    .db E0
    .db 93
    .db A0
    .db 93
    .db ED
    .db 93
    .db F4
    .db 93
    .db 01
    .db 94
    .db 0E
    .db 94
    .db 12
    .db 94
    .db 00
    .db FF
    .db FF
    .db FF
    .db 01
    .db 20
    .db 04
    .db FF
    .db 02
    .db 20
    .db 10
    .db FE
    .db 03
    .db 20
    .db 06
    .db 04
    .db 20
    .db 06
    .db FE
    .db 05
    .db 21
    .db 06
    .db 06
    .db 21
    .db 06
    .db 07
    .db 21
    .db 06
    .db 08
    .db 21
    .db 06
    .db FE
    .db 09
    .db 21
    .db 03
    .db FE
    .db 0A
    .db 21
    .db 80
    .db FF
    .db 0B
    .db BA
    .db 06
    .db 0C
    .db BA
    .db 06
    .db FE
    .db 0D
    .db 20
    .db 08
    .db 0E
    .db 20
    .db 08
    .db FE
    .db 9A
    .db B9
    .db 04
    .db 1D
    .db 20
    .db 05
    .db FE
    .db 9B
    .db B9
    .db 04
    .db 01
    .db 20
    .db 04
    .db FE
    .db 53
    .db B9
    .db 04
    .db FE
    .db 54
    .db B8
    .db 06
    .db 55
    .db B8
    .db 1C
    .db 00
    .db 00
    .db 1C
    .db 56
    .db B8
    .db 30
    .db 00
    .db 00
    .db 20
    .db 57
    .db B8
    .db 0C
    .db 58
    .db B8
    .db 0C
    .db FF
    .db 47
    .db FF
    .db 0C
    .db FE
    .db AA
    .db 20
    .db 04
    .db FF
    .db 4B
    .db 25
    .db 06
    .db 4C
    .db 25
    .db 06
    .db FE
    .db 15
    .db FF
    .db FF
    .db FE
    .db 60
    .db FF
    .db 06
    .db 61
    .db FF
    .db 06
    .db FE
    .db 51
    .db FF
    .db 04
    .db 52
    .db FF
    .db 04
    .db FF
    .db 54
    .db B8
    .db 06
    .db 55
    .db B8
    .db 1C
    .db 00
    .db 00
    .db FF
    .db FF
    .db A8
    .db 20
    .db 04
    .db FF
    .db A9
    .db 20
    .db 04
    .db FF
    .db 0D
    .db 20
    .db 08
    .db 0E
    .db 20
    .db 08
    .db FE
    .db 19
    .db FF
    .db 07
    .db 1A
    .db FF
    .db 07
    .db 1B
    .db FF
    .db 07
    .db FE
    .db CA
    .db B8
    .db 06
    .db FE
    .db 12
    .db 22
    .db 80
    .db 13
    .db 22
    .db 18
    .db FE
    .db 0F
    .db 22
    .db 07
    .db 10
    .db 22
    .db 07
    .db 11
    .db 22
    .db 07
    .db 10
    .db 22
    .db 07
    .db FE
    .db 0F
    .db 22
    .db 03
    .db 16
    .db 24
    .db 03
    .db 17
    .db 24
    .db 04
    .db 18
    .db 24
    .db 06
    .db FF
    .db 0F
    .db 22
    .db 03
    .db 5A
    .db C0
    .db 03
    .db 5B
    .db C0
    .db 04
    .db 5C
    .db C0
    .db 06
    .db FF
    .db 19
    .db 23
    .db 06
    .db 1A
    .db 23
    .db 06
    .db 1B
    .db 23
    .db 12
    .db FF
    .db 14
    .db 25
    .db 03
    .db FE
    .db 43
    .db 38
    .db 06
    .db FE
    .db 44
    .db 38
    .db 06
    .db FE
    .db 0F
    .db 26
    .db 07
    .db 10
    .db 26
    .db 07
    .db 11
    .db 26
    .db 07
    .db 10
    .db 26
    .db 07
    .db FE
    .db 0F
    .db 26
    .db 03
    .db 16
    .db 27
    .db 03
    .db 17
    .db 27
    .db 04
    .db 18
    .db 27
    .db 06
    .db FF
    .db 12
    .db 26
    .db 80
    .db 13
    .db 26
    .db 18
    .db FE
    .db 9C
    .db BA
    .db 08
    .db 9D
    .db BA
    .db 10
    .db 9E
    .db BA
    .db 06
    .db 9D
    .db BA
    .db E0
    .db FE
    .db 0F
    .db 26
    .db 03
    .db AD
    .db C0
    .db 03
    .db AE
    .db C0
    .db 04
    .db AF
    .db C0
    .db 06
    .db FF
    .db C2
    .db 38
    .db 06
    .db FE
    .db C3
    .db 38
    .db 06
    .db FE
    .db 21
    .db 39
    .db 80
    .db 22
    .db 39
    .db 14
    .db FE
    .db 1E
    .db 39
    .db 07
    .db 1F
    .db 39
    .db 07
    .db 20
    .db 39
    .db 07
    .db 1F
    .db 39
    .db 07
    .db FE
    .db 23
    .db 25
    .db 03
    .db FE
    .db 1E
    .db 39
    .db 03
    .db 25
    .db 3B
    .db 03
    .db 26
    .db 3B
    .db 04
    .db 27
    .db 3B
    .db 07
    .db FF
    .db 1E
    .db 39
    .db 03
    .db 5D
    .db C1
    .db 03
    .db 5E
    .db C1
    .db 04
    .db 5F
    .db C1
    .db 07
    .db FF
    .db 28
    .db 3A
    .db 06
    .db 29
    .db 3A
    .db 06
    .db 2A
    .db 3A
    .db 12
    .db 23
    .db 3A
    .db 06
    .db FF
    .db 45
    .db 38
    .db 06
    .db FE
    .db 46
    .db 38
    .db 06
    .db FE
    .db 1E
    .db 3C
    .db 07
    .db 1F
    .db 3C
    .db 07
    .db 20
    .db 3C
    .db 07
    .db 1F
    .db 3C
    .db 07
    .db FE
    .db 1E
    .db 3C
    .db 06
    .db 25
    .db 3D
    .db 06
    .db 26
    .db 3D
    .db 06
    .db 27
    .db 3D
    .db 06
    .db FF
    .db 21
    .db 3C
    .db 80
    .db 22
    .db 3C
    .db 14
    .db FE
    .db 9F
    .db BA
    .db 08
    .db A0
    .db BA
    .db 10
    .db A1
    .db BA
    .db 06
    .db A0
    .db BA
    .db E0
    .db FE
    .db 1E
    .db 3C
    .db 03
    .db B0
    .db C1
    .db 03
    .db B1
    .db C1
    .db 04
    .db B2
    .db C1
    .db 07
    .db FF
    .db C4
    .db 38
    .db 06
    .db FE
    .db C5
    .db 38
    .db 06
    .db FE
    .db 2E
    .db 3E
    .db 80
    .db 2F
    .db 3E
    .db 14
    .db FE
    .db 2B
    .db 3E
    .db 07
    .db 2C
    .db 3E
    .db 07
    .db 2D
    .db 3E
    .db 07
    .db 2C
    .db 3E
    .db 07
    .db FE
    .db 30
    .db 25
    .db 03
    .db FE
    .db 2B
    .db 3E
    .db 03
    .db 32
    .db 40
    .db 03
    .db 33
    .db 40
    .db 04
    .db 34
    .db 40
    .db 07
    .db FF
    .db 2B
    .db 3E
    .db 03
    .db 64
    .db C2
    .db 03
    .db 65
    .db C2
    .db 04
    .db 66
    .db C2
    .db 07
    .db FF
    .db 35
    .db 3F
    .db 06
    .db 36
    .db 3F
    .db 06
    .db 37
    .db 3F
    .db 12
    .db 30
    .db 3F
    .db 06
    .db FF
    .db 47
    .db 38
    .db 06
    .db FE
    .db 48
    .db 38
    .db 06
    .db FE
    .db 2B
    .db 41
    .db 07
    .db 2C
    .db 41
    .db 07
    .db 2D
    .db 41
    .db 07
    .db 2C
    .db 41
    .db 07
    .db FE
    .db 2B
    .db 41
    .db 06
    .db 32
    .db 42
    .db 06
    .db 33
    .db 42
    .db 06
    .db 34
    .db 42
    .db 06
    .db FF
    .db 2E
    .db 41
    .db 80
    .db 2F
    .db 41
    .db 14
    .db FE
    .db A2
    .db BA
    .db 08
    .db A3
    .db BA
    .db 10
    .db A4
    .db BA
    .db 06
    .db A3
    .db BA
    .db E0
    .db FE
    .db 2B
    .db 41
    .db 03
    .db B3
    .db C2
    .db 03
    .db B4
    .db C2
    .db 04
    .db B5
    .db C2
    .db 07
    .db FF
    .db C6
    .db 38
    .db 06
    .db FE
    .db C7
    .db 38
    .db 06
    .db FE
    .db 3B
    .db 43
    .db 80
    .db 3C
    .db 43
    .db 14
    .db FE
    .db 38
    .db 43
    .db 07
    .db 39
    .db 43
    .db 07
    .db 3A
    .db 43
    .db 07
    .db 39
    .db 43
    .db 07
    .db FE
    .db 3D
    .db 25
    .db 03
    .db FE
    .db 38
    .db 43
    .db 03
    .db 3F
    .db 45
    .db 03
    .db 62
    .db 45
    .db 04
    .db 63
    .db 45
    .db 07
    .db FF
    .db 38
    .db 43
    .db 03
    .db 67
    .db C3
    .db 03
    .db 68
    .db C3
    .db 04
    .db 69
    .db C3
    .db 07
    .db FF
    .db 40
    .db 44
    .db 06
    .db 41
    .db 44
    .db 06
    .db 42
    .db 44
    .db 12
    .db 3D
    .db 44
    .db 06
    .db FF
    .db 49
    .db 38
    .db 06
    .db FE
    .db 4A
    .db 38
    .db 06
    .db FE
    .db 38
    .db 46
    .db 07
    .db 39
    .db 46
    .db 07
    .db 3A
    .db 46
    .db 07
    .db 39
    .db 46
    .db 07
    .db FE
    .db 38
    .db 46
    .db 03
    .db 3F
    .db 47
    .db 03
    .db 62
    .db 47
    .db 04
    .db 63
    .db 47
    .db 07
    .db FF
    .db 3B
    .db 46
    .db 80
    .db 3C
    .db 46
    .db 14
    .db FE
    .db A5
    .db BA
    .db 08
    .db A6
    .db BA
    .db 10
    .db A7
    .db BA
    .db 06
    .db A6
    .db BA
    .db E0
    .db FE
    .db 38
    .db 46
    .db 07
    .db B6
    .db C3
    .db 03
    .db B7
    .db C3
    .db 04
    .db B8
    .db C3
    .db 07
    .db FF
    .db C8
    .db 38
    .db 06
    .db FE
    .db C9
    .db 38
    .db 06
    .db FE
CUTSCENE_SCENE_1: ; 12:1416, 0x025416
    LDA CTRL_NEWLY_PRESSED_A[2] ; Get pressed.
    ORA CTRL_NEWLY_PRESSED_A+1 ; For both players.
    BPL A_NOT_PRESSED_EITHER ; If A not pressed.
    JSR SOUND_INIT_RTN? ; Init sound.
    JMP INTRO_CUTSCENE_RTN_G
A_NOT_PRESSED_EITHER: ; 12:1422, 0x025422
    LDA #$80
    STA 4C_UNK ; Set unk.
    LDA 63E_SWITCH_CUTSCENE_NOT_FINISHED_FLAG?
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(INTRO_CUTSCENE_RTN_A) ; Init screen.
    HIGH(INTRO_CUTSCENE_RTN_A)
    LOW(INTRO_CUTSCENE_RTN_B) ; Setup objs.
    HIGH(INTRO_CUTSCENE_RTN_B)
    LOW(INTRO_CUTSCENE_RTN_C) ; Intro jumping movement.
    HIGH(INTRO_CUTSCENE_RTN_C)
    LOW(INTRO_CUTSCENE_RTN_D) ; Init screen.
    HIGH(INTRO_CUTSCENE_RTN_D)
    LOW(INTRO_CUTSCENE_RTN_E) ; Setup objects.
    HIGH(INTRO_CUTSCENE_RTN_E)
    LOW(INTRO_CUTSCENE_RTN_F) ; Intro falling into line movement.
    HIGH(INTRO_CUTSCENE_RTN_F)
    LOW(INTRO_CUTSCENE_RTN_G) ; Leaves?
    HIGH(INTRO_CUTSCENE_RTN_G)
INTRO_CUTSCENE_RTN_A: ; 12:143A, 0x02543A
    JSR CLEAR_IRQ_FLAGS_UNK ; Irq
    JSR DISPATCH_CLEAR_SCREEN ; Clear screen.
    LDA #$04
    STA DISABLE_RENDERING_X_FRAMES ; Rendering disable.
63E_SWITCH_MOVE: ; 12:1444, 0x025444
    INC 63E_SWITCH_CUTSCENE_NOT_FINISHED_FLAG? ; Switch++
    RTS
INTRO_CUTSCENE_RTN_B: ; 12:1448, 0x025448
    LDA #$C6 ; Set banks R2-R4
    STA ZP_R2-R5_BANK_VALUES[4]
    LDA #$C7
    STA ZP_R2-R5_BANK_VALUES+1
    LDA #$E3
    STA ZP_R2-R5_BANK_VALUES+2
    LDA #$E8 ; Set banks R0-R1
    STA IRQ_GFX_DATA_BANK_R0
    LDA #$EA
    STA IRQ_GFX_DATA_BANK_R1
    LDX #$0C ; Upload screen.
    JSR BANK_PAIR_SAVE+PPU_FILE_BANK_14/15
    LDA #$04 ; BG mod.
    JSR RTN_PALETTE+BG_MOD
    LDX #$00
SPRITE_OBJECT_FILLOUT_LOOP: ; 12:1468, 0x025468
    JSR INIT_OBJECT[X]_DATA? ; Init object X.
    LDA #$01
    STA ARR_OBJECT_ENABLED+MORE?[18],X ; Enable GFX?
    LDA #$01
    STA OBJ_STATE/SWITCH[18],X
    LDA SPRITE_DATA_47E,X
    STA 47E_ARR_UNK[18],X
    LDA SPRITE_DATA_4A2,X
    STA 4A2_ARR_UNK[18],X
    STA 46C_ARR_UNK[18],X
    LDA SPRITE_DATA_400,X
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X
    LDA #$88
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA SPRITE_DATA_45A,X
    STA 45A_ARR_UNK[18],X
    LDA SPRITE_DATA_4FC
    STA 4FC_ARR_UNK[18],X
    LDA SPRITE_DATA_4EA
    STA 4EA_ARR_UNK[18],X
    LDA SPRITE_DATA_544
    STA 544_ARR_UNK[18],X
    LDA SPRITE_DATA_532
    STA 532_ARR_UNK[18],X
    INX ; X++
    CPX #$04 ; If X _ #$04
    BCC SPRITE_OBJECT_FILLOUT_LOOP ; <, goto.
    LDX #$06 ; X=
    LDA #$00 ; Clear
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear
    STA 45A_ARR_UNK[18],X ; Clear
    LDA #$03
    STA DISABLE_RENDERING_X_FRAMES ; Disable rendering for frames.
    JSR 63E_SWITCH_MOVE ; State++
    JMP WRITE_PPU_CTRL_COPY ; Abuse RTS.
SPRITE_DATA_4FC: ; 12:14C6, 0x0254C6
    .db 00
SPRITE_DATA_4EA: ; 12:14C7, 0x0254C7
    .db 01
SPRITE_DATA_544: ; 12:14C8, 0x0254C8
    .db 00
SPRITE_DATA_532: ; 12:14C9, 0x0254C9
    .db FD
SPRITE_DATA_45A: ; 12:14CA, 0x0254CA
    .db 68
    .db B0
    .db 80
    .db 98
SPRITE_DATA_47E: ; 12:14CE, 0x0254CE
    .db 60
    .db 18
    .db 50
    .db 30
SPRITE_DATA_4A2: ; 12:14D2, 0x0254D2
    .db B0
    .db 98
    .db B0
    .db A8
SPRITE_DATA_400: ; 12:14D6, 0x0254D6
    .db 90
    .db 8A
    .db 8E
    .db 8C
DATA_UNK: ; 12:14DA, 0x0254DA
    .db 91
    .db 8B
    .db 8F
    .db 8D
INTRO_CUTSCENE_RTN_C: ; 12:14DE, 0x0254DE
    LDY #$07 ; Y=
    LDA IRQ_COUNT? ; A=
    AND #$08 ; Time bit.
    BEQ BIT_NOT_SET
    LDY #$08 ; Y if bit set.
BIT_NOT_SET: ; 12:14E8, 0x0254E8
    TYA ; Y to A.
    JSR QUEUE_PPU_UPDATE_???
    LDX #$06 ; x=
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load object ???
    CMP #$FF ; If A _ #$FF
    BEQ VAL_MAXED? ; ==, goto.
    LDY #$00 ; Y=
LOOP_SMOL: ; 12:14F7, 0x0254F7
    LDA DATA_UNK,Y ; Load...
    CMP #$FF ; If _ #$FF
    BEQ EOF_MARKER ; ==, goto.
    INY ; Y+=2
    INY
    CMP OBJ_ANIM_HOLD_TIMER?[18],X ; If A _ Var
    BNE LOOP_SMOL ; !=, goto.
    LDA 12:1572,Y ; Load from.
    CMP #$10 ; If A _ #$10
    BNE QUEUE_PPU_UPDATE_JSR ; !=, goto.
    LDA #$76 ; Play sound.
    JSR SND_BANKED_DISPATCH
    JMP EOF_MARKER ; End point.
QUEUE_PPU_UPDATE_JSR: ; 12:1514, 0x025514
    JSR QUEUE_PPU_UPDATE_??? ; Make update.
EOF_MARKER: ; 12:1517, 0x025517
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; Inc ???
VAL_MAXED?: ; 12:151A, 0x02551A
    LDX #$00 ; X=
LOOP_ALL_OBJECTS: ; 12:151C, 0x02551C
    LDA OBJ_STATE/SWITCH[18],X ; Load
    BEQ LOADED_ZERO
    LDA 45A_ARR_UNK[18],X ; Load
    BNE LOADED_NZERO ; != 0, goto.
    JSR FUNKY_ADD/ROT_RTN ; Do sub.
    LDA #$18 ; Move val?
    JSR MOVE_RTN?
    JSR MOVE_FINALIZE?
    LDA 46C_ARR_UNK[18],X ; Load
    CMP #$B8 ; If A _ #$B8
    BCS CLEAR_OBJ_412/400? ; >=, goto.
    LDA DATA_UNK,X ; Load ???
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X ; Store to object.
LOADED_ZERO: ; 12:153E, 0x02553E
    INX ; Object++
    CPX #$04 ; All 4 objects?
    BCC LOOP_ALL_OBJECTS ; <, goto.
    LDA OBJ_STATE/SWITCH[18] ; Load
    ORA OBJ_STATE/SWITCH+1 ; Or
    ORA OBJ_STATE/SWITCH+2 ; Or
    ORA OBJ_STATE/SWITCH+3 ; Or
    BEQ ALL_VALUES_ZERO?
    RTS
LOADED_NZERO: ; 12:1552, 0x025552
    DEC 45A_ARR_UNK[18],X ; --
    JMP LOADED_ZERO ; JMP back in.
CLEAR_OBJ_412/400?: ; 12:1558, 0x025558
    LDA #$00
    STA OBJ_STATE/SWITCH[18],X ; Clear these.
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X
    JMP LOADED_ZERO
ALL_VALUES_ZERO?: ; 12:1563, 0x025563
    JSR PREP_OBJS_0-3 ; Prep objects.
    LDX #$06
    JSR INIT_OBJECT[X]_DATA? ; Init 7th object.
    LDA #$04
    STA DISABLE_RENDERING_X_FRAMES ; Disable rendering.
    JSR 63E_SWITCH_MOVE ; State++
    RTS
DATA_UNK: ; 12:1573, 0x025573
    .db 30
    .db 04
    .db 31
    .db 10
    .db 60
    .db 05
    .db 50
    .db 00
    .db 51
    .db 02
    .db FF
INTRO_CUTSCENE_RTN_D: ; 12:157E, 0x02557E
    JSR DISPATCH_CLEAR_SCREEN ; Clear screen.
    LDA #$04
    STA DISABLE_RENDERING_X_FRAMES ; Stop rendering.
    JMP 63E_SWITCH_MOVE ; Next state.
INTRO_CUTSCENE_RTN_E: ; 12:1588, 0x025588
    LDA #$C5
    STA ZP_R2-R5_BANK_VALUES[4] ; Set gfx R2-R3
    LDA #$C6
    STA ZP_R2-R5_BANK_VALUES+1
    LDA #$EC
    STA IRQ_GFX_DATA_BANK_R0 ; Set gfx R0-R1
    LDA #$EE
    STA IRQ_GFX_DATA_BANK_R1
    LDX #$0E
    JSR BANK_PAIR_SAVE+PPU_FILE_BANK_14/15 ; Upload screen.
    LDA #$05
    JSR RTN_PALETTE+BG_MOD ; Palette?
    LDX #$00 ; Object
LOOP: ; 12:15A4, 0x0255A4
    TXA ; Clear A
    TAY ; Clear Y
    CLC
    ADC #$01 ; A+=1
    STA ARR_OBJECT_ENABLED+MORE?[18],X ; Enable?
    LDA #$30 ; Val?
    STA 47E_ARR_UNK[18],X
    LDA #$98 ; Val?
    STA 4A2_ARR_UNK[18],X
    LDA #$81 ; Val?
    STA 4C6_ARR_UNK[18],X
    JSR MOVE_FINALIZE? ; Move?
    LDA #$01 ; Val?
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    LDA DATA_UNK_A ; Val?
    STA 4FC_ARR_UNK[18],X
    LDA DATA_UNK_B ; Val?
    STA 4EA_ARR_UNK[18],X
    LDA DATA_UNK_C ; Val?
    STA 544_ARR_UNK[18],X
    LDA DATA_UNK_D ; Val?
    STA 532_ARR_UNK[18],X
    LDA DATA_UNK_E,Y ; Val?
    STA 5D4_ARR_OBJ_TIMER?[18],X
    LDA DATA_UNK_F,Y ; Val?
    STA OBJ_DIRECTION_RELATED?[18],X
    INX ; Object++
    CPX #$04 ; If X _ #$04
    BCC LOOP ; <, goto. Do all 4 turtles.
    JSR 63E_SWITCH_MOVE ; Next state.
    JMP WRITE_PPU_CTRL_COPY ; Abuse RTS.
DATA_UNK_A: ; 12:15F2, 0x0255F2
    .db C0
DATA_UNK_B: ; 12:15F3, 0x0255F3
    .db 01
DATA_UNK_C: ; 12:15F4, 0x0255F4
    .db 00
DATA_UNK_D: ; 12:15F5, 0x0255F5
    .db 01
DATA_UNK_E: ; 12:15F6, 0x0255F6
    .db 10
    .db 30
    .db 50
    .db 70
DATA_UNK_F: ; 12:15FA, 0x0255FA
    .db 00
    .db 01
    .db 02
    .db 03
INTRO_CUTSCENE_RTN_F: ; 12:15FE, 0x0255FE
    LDX #$00 ; X=
LOOP_ALL_OBJS: ; 12:1600, 0x025600
    JSR SWITCH_OBJ[X]_412 ; Do obj.
    INX ; Object++
    CPX #$04 ; If X _ #$04
    BCC LOOP_ALL_OBJS ; <, goto. Do all 4.
    LDA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18] ; Load
    ORA 5C2_OBJ_DATA_PTR_STREAM_INDEX+1 ; Or
    ORA 5C2_OBJ_DATA_PTR_STREAM_INDEX+2 ; Or
    ORA 5C2_OBJ_DATA_PTR_STREAM_INDEX+3 ; Or
    BEQ INTRO_CUTSCENE_RTN_G ; All 0, goto.
    LDA CTRL_NEWLY_PRESSED_A+1 ; Load if A pressed.
    BPL RTS ; Not pressed, RTS.
    JMP 63E_SWITCH_MOVE ; Next state.
INTRO_CUTSCENE_RTN_G: ; 12:161D, 0x02561D
    LDA #$00 ; Clear...
    STA 4C_UNK
    STA 63E_SWITCH_CUTSCENE_NOT_FINISHED_FLAG?
    LDA #$04 ; Stop rendering.
    STA DISABLE_RENDERING_X_FRAMES
    LDX #$00 ; Objects 0-3
    JSR INIT_OBJECT[X]_DATA?
    INX
    JSR INIT_OBJECT[X]_DATA?
    INX
    JSR INIT_OBJECT[X]_DATA?
    INX
    JSR INIT_OBJECT[X]_DATA?
    LDX #$06 ; And 6.
    JSR INIT_OBJECT[X]_DATA?
RTS: ; 12:163E, 0x02563E
    RTS
SWITCH_OBJ[X]_412: ; 12:163F, 0x02563F
    LDA OBJ_STATE/SWITCH[18],X ; Load each object switch.
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(INTRO_FALLING_RTN_A) ; Wait to display.
    HIGH(INTRO_FALLING_RTN_A)
    LOW(INTRO_FALLING_RTN_B) ; Falling in.
    HIGH(INTRO_FALLING_RTN_B)
    LOW(INTRO_FALLING_RTN_C) ; Wait again.
    HIGH(INTRO_FALLING_RTN_C)
    LOW(INTRO_FALLING_RTN_D) ; Update more and misc.
    HIGH(INTRO_FALLING_RTN_D)
    LOW(INTRO_FALLING_RTN_E) ; Clean up sprites?
    HIGH(INTRO_FALLING_RTN_E)
INTRO_FALLING_RTN_A: ; 12:164F, 0x02564F
    DEC 5D4_ARR_OBJ_TIMER?[18],X ; --
    BNE RTS ; If not expired.
    INC OBJ_STATE/SWITCH[18],X ; Switch state++
RTS: ; 12:1657, 0x025657
    RTS
INTRO_FALLING_RTN_B: ; 12:1658, 0x025658
    LDA DATA_UNK_A,X ; Load
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X ; Store
    LDA DATA_GFX_BANK,X ; Load
    STA ZP_R2-R5_BANK_VALUES[4],X ; Store new bank in R2-R5.
    JSR FUNKY_ADD/ROT_RTN ; Do...
    LDA #$18 ; Move val?
    JSR MOVE_RTN?
    BCC CCLEARED ; If return has carry cleared, goto.
    LDA #$4C
    JSR SND_BANKED_DISPATCH ; Do sound. Landing?
    LDA DATA_UNK_C,X
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X ; Store...
    LDA DATA_UNK_D,X ; Load
    STA ZP_R2-R5_BANK_VALUES[4],X ; Store.
    CPX #$01 ; If X _ #$01
    BNE OBJ_NOT_1 ; !=, goto.
    LDA DATA_FELL_ANIM_VAL_A ; Load
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X ; Move
    LDA DATA_FELL_ANIM_VAL_B ; Load
    STA ZP_R2-R5_BANK_VALUES[4],X ; Store bank.
OBJ_NOT_1: ; 12:168C, 0x02568C
    LDA DATA_UNK_F,X ; Load
    STA 5D4_ARR_OBJ_TIMER?[18],X ; Store
    INC OBJ_STATE/SWITCH[18],X ; State++
    LDA #$00
    STA 4C6_ARR_UNK[18],X ; Clear.
CCLEARED: ; 12:169A, 0x02569A
    JMP MOVE_FINALIZE? ; Finalize changes.
DATA_UNK_A: ; 12:169D, 0x02569D
    .db 73
    .db 87
    .db 88
    .db 89
DATA_GFX_BANK: ; 12:16A1, 0x0256A1
    .db C4
    .db C4
    .db C4
    .db C4
DATA_UNK_C: ; 12:16A5, 0x0256A5
    .db 79
    .db 7D
    .db 81
    .db 85
DATA_UNK_D: ; 12:16A9, 0x0256A9
    .db 22
    .db 39
    .db 3E
    .db 43
DATA_UNK_F: ; 12:16AD, 0x0256AD
    .db 20
    .db 70
    .db 20
    .db 20
INTRO_FALLING_RTN_C: ; 12:16B1, 0x0256B1
    DEC 5D4_ARR_OBJ_TIMER?[18],X ; Timer
    BNE 12:16B9
    INC OBJ_STATE/SWITCH[18],X
    RTS
INTRO_FALLING_RTN_D: ; 12:16BA, 0x0256BA
    JSR FUNKY_ADD/ROT_RTN ; Move
    LDA 47E_ARR_UNK[18],X ; Load
    CMP #$D4 ; If _ #$D4
    BCS NEXT_OBJ_STATE ; >=, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL NOT_FINISHED ; Not underflowed.
    LDA #$07 ; Load
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store
    INC 45A_ARR_UNK[18],X ; ++
NOT_FINISHED: ; 12:16D1, 0x0256D1
    LDA 45A_ARR_UNK[18],X ; Load
    AND #$03 ; Get bottom 2 bits.
    STA TMP_00 ; To
    TXA ; Obj to A.
    ASL A ; << 2, *4
    ASL A
    ORA TMP_00 ; Put bottom 2 bits back?
    TAY ; To Y index.
    LDA DATA_WALK_ANIM_A?,Y ; Load data.
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X ; Store to.
    LDA DATA_WALK_ANIM_B?,X ; Load data.
    STA ZP_R2-R5_BANK_VALUES[4],X ; Switch in bank.
    RTS ; Leave.
NEXT_OBJ_STATE: ; 12:16EA, 0x0256EA
    INC OBJ_STATE/SWITCH[18],X
INTRO_FALLING_RTN_E: ; 12:16ED, 0x0256ED
    LDA #$00 ; Clear these.
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X
    RTS
DATA_FELL_ANIM_VAL_A: ; 12:16F6, 0x0256F6
    .db BF
DATA_FELL_ANIM_VAL_B: ; 12:16F7, 0x0256F7
    .db 20
DATA_WALK_ANIM_A?: ; 12:16F8, 0x0256F8
    .db 76
    .db 77
    .db 78
    .db 77
    .db 7A
    .db 7B
    .db 7C
    .db 7B
    .db 7E
    .db 7F
    .db 80
    .db 7F
    .db 82
    .db 83
    .db 84
    .db 83
DATA_WALK_ANIM_B?: ; 12:1708, 0x025708
    .db 22
    .db 39
    .db 3E
    .db 43
QUEUE_PPU_UPDATE_???: ; 12:170C, 0x02570C
    STX TMP_05 ; X to.
    ASL A ; A to index.
    TAY ; To Y index reg.
    LDA IDK_DATA_L,Y ; Move ptr to fp 6.
    STA TMP_06
    LDA IDK_DATA_H,Y
    STA TMP_07
    LDX PPU_UPDATE_BUF_INDEX ; Get buf index.
    LDY #$00 ; Stream init.
    LDA [TMP_06],Y ; Load file data.
    STA TMP_04 ; Loop count.
    INY ; Stream++
LOOP: ; 12:1723, 0x025723
    LDA [TMP_06],Y ; Load more data.
    STA PPU_UPDATE_BUFFER[20],X ; To update buffer.
    INX ; Update buffer++
    INY ; Stream++
    DEC TMP_04 ; Loop count.
    BNE LOOP ; Not done, loop.
    STX PPU_UPDATE_BUF_INDEX ; Store index.
    LDX TMP_05 ; X=
    RTS
IDK_DATA_L: ; 12:1733, 0x025733
    .db 47
IDK_DATA_H: ; 12:1734, 0x025734
    .db 97
    .db 62
    .db 97
    .db 7D
    .db 97
    .db A7
    .db 97
    .db D1
    .db 97
    .db E7
    .db 97
    .db FD
    .db 97
    .db 22
    .db 98
    .db 43
    .db 98
    .db 64
    .db 98
    .db 1A
    .db 04
    .db 45
    .db 22
    .db 01
    .db 04
    .db 04
    .db 63
    .db 22
    .db 03
    .db 10
    .db 11
    .db 14
    .db 04
    .db 83
    .db 22
    .db 03
    .db 20
    .db 24
    .db 25
    .db 04
    .db A3
    .db 22
    .db 03
    .db 30
    .db 34
    .db 35
    .db 1A
    .db 04
    .db 45
    .db 22
    .db 01
    .db B6
    .db 04
    .db 63
    .db 22
    .db 03
    .db 10
    .db 11
    .db 12
    .db 04
    .db 83
    .db 22
    .db 03
    .db 20
    .db 21
    .db 22
    .db 04
    .db A3
    .db 22
    .db 03
    .db 30
    .db 31
    .db 32
    .db 29
    .db 04
    .db 83
    .db 21
    .db 08
    .db 08
    .db 09
    .db 0A
    .db 0B
    .db 2C
    .db 2D
    .db 2E
    .db 2F
    .db 04
    .db A3
    .db 21
    .db 08
    .db 18
    .db 19
    .db 1A
    .db 1B
    .db 3C
    .db 3D
    .db 3E
    .db 3F
    .db 04
    .db C3
    .db 21
    .db 08
    .db 28
    .db 29
    .db 29
    .db 2B
    .db 4C
    .db 4D
    .db 4E
    .db 4F
    .db 04
    .db E7
    .db 21
    .db 01
    .db 2A
    .db 29
    .db 04
    .db 83
    .db 21
    .db 08
    .db 36
    .db 46
    .db B7
    .db B7
    .db 36
    .db F5
    .db F5
    .db F5
    .db 04
    .db A3
    .db 21
    .db 08
    .db 36
    .db 46
    .db B7
    .db B7
    .db 36
    .db 8A
    .db 8A
    .db 8A
    .db 04
    .db C3
    .db 21
    .db 08
    .db E7
    .db 46
    .db B7
    .db B7
    .db 36
    .db 8A
    .db 8A
    .db 8A
    .db 04
    .db E7
    .db 21
    .db 01
    .db 36
    .db 15
    .db 04
    .db EF
    .db 21
    .db 04
    .db 0C
    .db 0D
    .db 0E
    .db 0F
    .db 04
    .db 0F
    .db 22
    .db 04
    .db 1C
    .db 1D
    .db 1E
    .db 1F
    .db 04
    .db 31
    .db 22
    .db 01
    .db 2A
    .db 15
    .db 04
    .db EF
    .db 21
    .db 04
    .db 00
    .db 00
    .db 00
    .db 00
    .db 04
    .db 0F
    .db 22
    .db 04
    .db 00
    .db 00
    .db 00
    .db 00
    .db 04
    .db 31
    .db 22
    .db 01
    .db 00
    .db 24
    .db 04
    .db 95
    .db 21
    .db 02
    .db 23
    .db 8A
    .db 04
    .db B5
    .db 21
    .db 02
    .db 01
    .db 01
    .db 04
    .db D5
    .db 21
    .db 02
    .db 3C
    .db 3C
    .db 04
    .db F5
    .db 21
    .db 02
    .db 10
    .db 1F
    .db 04
    .db 15
    .db 22
    .db 02
    .db 00
    .db 00
    .db 04
    .db 35
    .db 22
    .db 02
    .db 00
    .db 00
    .db 20
    .db 04
    .db D7
    .db 21
    .db 04
    .db CC
    .db CD
    .db CE
    .db DE
    .db 04
    .db F7
    .db 21
    .db 04
    .db DC
    .db DD
    .db DE
    .db DF
    .db 04
    .db 17
    .db 22
    .db 04
    .db EC
    .db ED
    .db EE
    .db EF
    .db 04
    .db 37
    .db 22
    .db 04
    .db FC
    .db FD
    .db BF
    .db CF
    .db 20
    .db 04
    .db D7
    .db 21
    .db 04
    .db B8
    .db B9
    .db BA
    .db BB
    .db 04
    .db F7
    .db 21
    .db 04
    .db C8
    .db C9
    .db CA
    .db CB
    .db 04
    .db 17
    .db 22
    .db 04
    .db D8
    .db D9
    .db DA
    .db DB
    .db 04
    .db 37
    .db 22
    .db 04
    .db E8
    .db E9
    .db EA
    .db EB
    .db 3B
    .db 04
    .db 12
    .db 21
    .db 0B
    .db EF
    .db EF
    .db EF
    .db EF
    .db EF
    .db EF
    .db EF
    .db EF
    .db EF
    .db EF
    .db 02
    .db 04
    .db 32
    .db 21
    .db 0B
    .db 33
    .db 90
    .db AA
    .db 73
    .db 69
    .db BB
    .db CB
    .db 01
    .db 01
    .db 01
    .db FB
    .db 04
    .db 52
    .db 21
    .db 0B
    .db 01
    .db 01
    .db DA
    .db DB
    .db DC
    .db EA
    .db EB
    .db EC
    .db ED
    .db EE
    .db FB
    .db 04
    .db 72
    .db 21
    .db 0A
    .db FA
    .db FA
    .db FA
    .db FA
    .db FA
    .db FA
    .db FC
    .db FA
    .db FA
    .db FD
    .db A9
    .db 00
    .db 85
    .db 09
    .db 85
    .db 0B
    .db 85
    .db 0D
    .db 85
    .db 0F
    .db 9D
    .db 90
    .db 04
    .db 9D
    .db B4
    .db 04
    .db 9D
    .db 9E
    .db 05
    .db 9D
    .db B0
    .db 05
    .db 38
    .db A5
    .db 0C
    .db E5
    .db 08
    .db 9D
    .db FC
    .db 04
    .db A5
    .db 0D
    .db E5
    .db 09
    .db 9D
    .db EA
    .db 04
    .db 1D
    .db FC
    .db 04
    .db F0
    .db 1D
    .db A9
    .db 01
    .db BC
    .db EA
    .db 04
    .db 10
    .db 13
    .db 38
    .db A9
    .db 00
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
    .db A9
    .db FF
    .db 9D
    .db 90
    .db 04
    .db 38
    .db A5
    .db 0E
    .db E5
    .db 0A
    .db 9D
    .db 20
    .db 05
    .db A5
    .db 0F
    .db E5
    .db 0B
    .db 9D
    .db 0E
    .db 05
    .db 1D
    .db 20
    .db 05
    .db F0
    .db 1D
    .db A9
    .db 01
    .db BC
    .db 0E
    .db 05
    .db 10
    .db 13
    .db 38
    .db A9
    .db 00
    .db FD
    .db 20
    .db 05
    .db 9D
    .db 20
    .db 05
    .db A9
    .db 00
    .db FD
    .db 0E
    .db 05
    .db 9D
    .db 0E
    .db 05
    .db A9
    .db FF
    .db 9D
    .db B4
    .db 04
    .db BD
    .db FC
    .db 04
    .db DD
    .db 20
    .db 05
    .db B0
    .db 1F
    .db FE
    .db B0
    .db 05
    .db BD
    .db FC
    .db 04
    .db 48
    .db BD
    .db EA
    .db 04
    .db 48
    .db BD
    .db 20
    .db 05
    .db 9D
    .db FC
    .db 04
    .db BD
    .db 0E
    .db 05
    .db 9D
    .db EA
    .db 04
    .db 68
    .db 9D
    .db 0E
    .db 05
    .db 68
    .db 9D
    .db 20
    .db 05
    .db BD
    .db 20
    .db 05
    .db 0A
    .db 85
    .db 08
    .db BD
    .db 0E
    .db 05
    .db 2A
    .db 85
    .db 09
    .db 38
    .db A5
    .db 08
    .db FD
    .db FC
    .db 04
    .db 9D
    .db 44
    .db 05
    .db A5
    .db 09
    .db FD
    .db EA
    .db 04
    .db 9D
    .db 32
    .db 05
    .db BD
    .db FC
    .db 04
    .db 9D
    .db 9E
    .db 05
    .db 60
    .db BD
    .db 9E
    .db 05
    .db D0
    .db 03
    .db 4C
    .db F8
    .db 99
    .db BD
    .db FC
    .db 04
    .db 0A
    .db 85
    .db 08
    .db BD
    .db EA
    .db 04
    .db 2A
    .db 85
    .db 09
    .db BD
    .db 20
    .db 05
    .db 0A
    .db 85
    .db 0A
    .db BD
    .db 0E
    .db 05
    .db 2A
    .db 85
    .db 0B
    .db BD
    .db 32
    .db 05
    .db 30
    .db 30
    .db BD
    .db B0
    .db 05
    .db D0
    .db 0D
    .db 18
    .db BD
    .db A2
    .db 04
    .db 7D
    .db B4
    .db 04
    .db 9D
    .db A2
    .db 04
    .db 4C
    .db A4
    .db 99
    .db 18
    .db BD
    .db 7E
    .db 04
    .db 7D
    .db 90
    .db 04
    .db 9D
    .db 7E
    .db 04
    .db 38
    .db BD
    .db 44
    .db 05
    .db E5
    .db 08
    .db 9D
    .db 44
    .db 05
    .db BD
    .db 32
    .db 05
    .db E5
    .db 09
    .db 9D
    .db 32
    .db 05
    .db 4C
    .db 83
    .db 99
    .db BD
    .db B0
    .db 05
    .db D0
    .db 0D
    .db 18
    .db BD
    .db 7E
    .db 04
    .db 7D
    .db 90
    .db 04
    .db 9D
    .db 7E
    .db 04
    .db 4C
    .db D4
    .db 99
    .db 18
    .db BD
    .db A2
    .db 04
    .db 7D
    .db B4
    .db 04
    .db 9D
    .db A2
    .db 04
    .db 18
    .db BD
    .db 44
    .db 05
    .db 65
    .db 0A
    .db 9D
    .db 44
    .db 05
    .db BD
    .db 32
    .db 05
    .db 65
    .db 0B
    .db 9D
    .db 32
    .db 05
    .db 18
    .db BD
    .db A2
    .db 04
    .db 7D
    .db C6
    .db 04
    .db 9D
    .db 6C
    .db 04
    .db DE
    .db 9E
    .db 05
    .db F0
    .db 04
    .db 18
    .db 4C
    .db F9
    .db 99
    .db 38
    .db 60
RTN_TEXT_AFTER_CUTSCENE?: ; 12:19FA, 0x0259FA
    LDY LEVEL_SCREEN_ON ; Load index.
    LDA DATA_UNK,Y
    BEQ DLOAD_ZERO ; Load 0, goto.
    LDA CTRL_NEWLY_PRESSED_A[2] ; Load buttons P1+P2
    ORA CTRL_NEWLY_PRESSED_A+1
    BMI DLOAD_ZERO ; A pressed, goto.
    LDA 63B_TEXT_FADE_OUT_DONE? ; Load val.
    JSR SWITCH_CODE_PTRS_PAST_JSR ; Switch on it.
    LOW(63B_RTN_A) ; Screen setup?
    HIGH(63B_RTN_A)
    LOW(63B_RTN_B) ; Init text sprite objs.
    HIGH(63B_RTN_B)
    LOW(63B_RTN_C_TEXT?) ; Continue and wait for all to complete.
    HIGH(63B_RTN_C_TEXT?)
    LOW(63B_RTN_TEXT_FADE_OUT) ; Fade out of text.
    HIGH(63B_RTN_TEXT_FADE_OUT)
DATA_UNK: ; 12:1A15, 0x025A15
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 01
    .db 01
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
63B_RTN_A: ; 12:1A25, 0x025A25
    LDA #$03
    STA 3D5_UNK ; Store to.
    LDA #$05
    STA DISABLE_RENDERING_X_FRAMES ; Disable rendering.
    INC 63B_TEXT_FADE_OUT_DONE? ; Switch++
    LDA #$03
    JSR RTN_PALETTE+BG_MOD ; Do palette.
    JMP CLEAR_IRQ_FLAGS_UNK
63B_RTN_B: ; 12:1A39, 0x025A39
    JSR DISPATCH_CLEAR_SCREEN ; Clear screen.
    LDA LEVEL_SCREEN_ON ; Load index.
    JSR INIT_GFX_BANKS+OBJ_STREAMS_TEXT ; Do sub.
    INC 63B_TEXT_FADE_OUT_DONE? ; Next state.
    RTS
63B_RTN_C_TEXT?: ; 12:1A45, 0x025A45
    JSR OBJ_PROCESS_UNK_RET_CC_UNFINISHED
    BCC RTS ; Carry clear, not finished.
    LDA #$00
    STA DISABLE_RENDERING_X_FRAMES ; Stop disable.
    STA 3D6_PSWAP_RTN_INITD ; Clear
    INC 63B_TEXT_FADE_OUT_DONE? ; ++
RTS: ; 12:1A54, 0x025A54
    RTS
63B_RTN_TEXT_FADE_OUT: ; 12:1A55, 0x025A55
    JSR PSWAP_FADEOUT_TEXT ; Do.
    LDA 3D6_PSWAP_RTN_INITD ; Load.
    BNE RTS ; != 0, goto.
PREP_TEXT_FADE_RTN: ; 12:1A5D, 0x025A5D
    LDA #$03
    STA DISABLE_RENDERING_X_FRAMES ; Disable rendering 3 frames.
    LDA #$00
    STA 3D6_PSWAP_RTN_INITD ; Prep text.
    STA 63B_TEXT_FADE_OUT_DONE? ; Prep flag.
    JSR INIT_OBJS[7-18]_DRENDER_LSPRITES ; Do sub.
RTS: ; 12:1A6C, 0x025A6C
    RTS
DLOAD_ZERO: ; 12:1A6D, 0x025A6D
    JMP PREP_TEXT_FADE_RTN ; Abuse RTS.
RTN_BG_UPDATE_QUEUE: ; 12:1A70, 0x025A70
    PHA ; Save A.
    STY TMP_07 ; Y to.
    LDY #$04 ; Y=
    LDA #$00 ; A=
    STA TMP_03 ; Clear
    LDA TMP_01 ; Load
LOOP_STATE_MIXUP: ; 12:1A7B, 0x025A7B
    ASL A ; << 1.
    ROL TMP_03 ; Shift into.
    DEY ; Y--
    BPL LOOP_STATE_MIXUP
    CLC ; Prep add.
    ADC TMP_00 ; Add
    STA TMP_02 ; To.
    BCC SKIP_HIGH_INC
    INC TMP_03 ; Overflow inc.
SKIP_HIGH_INC: ; 12:1A8A, 0x025A8A
    CLC ; Prep add.
    LDA #$20 ; A=
    ADC TMP_03 ; Add
    STA TMP_03 ; To.
    LDY PPU_UPDATE_BUF_INDEX ; Get index.
    LDA #$04 ; Bytes.
    STA PPU_UPDATE_BUFFER[20],Y
    LDA #$01
    STA PPU_UPDATE_BUFFER+3,Y ; Store.
    LDA #$00
    STA PPU_UPDATE_BUFFER+5,Y ; Store.
    LDA TMP_02
    STA PPU_UPDATE_BUFFER+1,Y ; Store low.
    LDA TMP_03
    STA PPU_UPDATE_BUFFER+2,Y ; Store high.
    PLA ; Pull value.
    STA PPU_UPDATE_BUFFER+4,Y ; To buffer.
    TYA ; Index to Y.
    CLC
    ADC #$05 ; Mod size.
    STA PPU_UPDATE_BUF_INDEX ; Restore.
    LDY TMP_07 ; Restore Y.
    RTS
INIT_GFX_BANKS+OBJ_STREAMS_TEXT: ; 12:1AB9, 0x025AB9
    PHA ; Save A
    LDX #$06 ; Object 6 mod.
    JSR INIT_OBJECT[X]_DATA?
    LDA #$01
    STA ARR_OBJECT_ENABLED+MORE?[18],X ; Enable sprite?
    PLA ; Pull val.
    ASL A ; Turn to index.
    TAY ; To Y reg.
    LDA TEXT?_PTR_L,Y ; Load val.
    STA OBJECT_DATA_EXTRA_A?[18],X ; TO.
    LDA TEXT?_PTR_H,Y ; Load val.
    STA OBJECT_DATA_EXTRA_B?[18],X ; To.
    LDA #$68
    STA IRQ_GFX_DATA_BANK_R0 ; Set GFX banks R0-R1
    LDA #$6A
    STA IRQ_GFX_DATA_BANK_R1
    LDA #$68
    STA ZP_R2-R5_BANK_VALUES[4] ; Also set R2-R5.
    LDA #$69
    STA ZP_R2-R5_BANK_VALUES+1
    LDA #$6A
    STA ZP_R2-R5_BANK_VALUES+2
    LDA #$6B
    STA ZP_R2-R5_BANK_VALUES+3
    LDA PPU_CTRL_RAM_COPY ; Disable large sprites, since text is put in sprites.
    AND #$DF
    STA PPU_CTRL_RAM_COPY
    LDA #$80
    STA 4C_UNK ; Set negative.
    LDA #$00 ; A=
    TAX ; X=
LOOP_WRITE_OBJ_ATTR: ; 12:1AF8, 0x025AF8
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],X ; Zero anim ???
    INX ; Obj++
    CPX #$12 ; 18 done?
    BCC LOOP_WRITE_OBJ_ATTR ; <, goto.
    JMP INIT_OBJ_DATA_UNK ; Goto, abuse RTS.
OBJ_PROCESS_UNK_RET_CC_UNFINISHED: ; 12:1B03, 0x025B03
    LDX #$06 ; Object 7
    LDA OBJECT_DATA_EXTRA_A?[18],X ; Load val
    STA TMP_08 ; Store to.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load val.
    STA TMP_09 ; Store to.
    JSR RTN_FORWARD_OBJ+?_RET_CS_COMPLETED ; Spawn request.
    ROR A ; Rotate result into A.
    PHA ; Save...
    JSR CHECK_ALL_TEXT_COMPLETED?_RET_CC_UNFINISHED
    PLA ; Pull value.
    BPL RTN_UNFINISHED
    BCC RTN_UNFINISHED
INIT_OBJS[7-18]_DRENDER_LSPRITES: ; 12:1B1C, 0x025B1C
    LDX #$06 ; Init object 7-18.
ALL_OBJS: ; 12:1B1E, 0x025B1E
    JSR INIT_OBJECT[X]_DATA? ; Init
    INX ; Obj++
    CPX #$12 ; Obj _ #$12
    BCC ALL_OBJS ; <, goto.
    LDA #$03
    STA DISABLE_RENDERING_X_FRAMES ; Stop rendering.
    LDA #$00
    STA 4C_UNK ; Clear.
    LDA PPU_CTRL_RAM_COPY ; Enable large sprites.
    ORA #$20
    STA PPU_CTRL_RAM_COPY
    SEC ; Set carry.
    RTS ; Leave.
RTN_UNFINISHED: ; 12:1B36, 0x025B36
    CLC
    RTS
RTN_FORWARD_OBJ+?_RET_CS_COMPLETED: ; 12:1B38, 0x025B38
    LDY 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X ; Load from object. NOTE: Carry set means completed?
LOOP_KEEP_Y_ASIS: ; 12:1B3B, 0x025B3B
    LDA 5D4_ARR_OBJ_TIMER?[18],X ; Load timer?
    BNE TIMER_NONZERO ; != 0, goto.
    LDA [TMP_08],Y ; Load data from stream.
    BMI VAL_NEGATIVE ; Top bit set, goto.
    BEQ VAL_ZERO ; == 0, goto.
REENTER_RTN_??: ; 12:1B46, 0x025B46
    INC OBJ_ANIM_HOLD_TIMER?[18],X ; ++
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP 45A_ARR_UNK[18],X ; If A _ var
    BCC SUB_NOT_READY_FWD ; <, goto.
    LDA 47E_ARR_UNK[18],X ; Setup temp..?
    STA TMP_00
    LDA 4A2_ARR_UNK[18],X
    STA TMP_01
    LDA [TMP_08],Y ; Move next stream val.
    STA TMP_02
    JSR RTN_MAKE_OBJ_RET_CS_FAIL ; Do subroutine.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BCS SUB_NOT_READY_FWD ; If sub failed
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set.
    JSR FORWARD_XOBJ_STREAM_PTR ; Do...?
    INC 47E_ARR_UNK[18],X ; ++
    LDA 47E_ARR_UNK[18],X ; Load
    AND #$1F ; Isolate bits.
    STA 47E_ARR_UNK[18],X ; Store to.
SUB_NOT_READY_FWD: ; 12:1B7A, 0x025B7A
    CLC ; Clear.
    TYA ; Y to A.
    STA 5C2_OBJ_DATA_PTR_STREAM_INDEX[18],X ; Store index back to object.
    RTS ; Leave.
VAL_ZERO: ; 12:1B80, 0x025B80
    JSR FORWARD_XOBJ_STREAM_PTR ; Forward ???
    INC 47E_ARR_UNK[18],X ; ++
    JMP LOOP_KEEP_Y_ASIS ; Goto.
TIMER_NONZERO: ; 12:1B89, 0x025B89
    DEC 5D4_ARR_OBJ_TIMER?[18],X ; --
    JMP SUB_NOT_READY_FWD
VAL_NEGATIVE: ; 12:1B8F, 0x025B8F
    CMP #$50 ; A _ #$50
    BEQ REENTER_RTN_?? ; ==, goto. Impossible since BMI here? lol.
    EOR #$FF ; Invert val.
    BEQ CARRY_SET_RTS ; == 0, was FF, goto.
    JSR DO_SWITCH_IN_A ; Do rtn, rtsing to here.
    JMP LOOP_KEEP_Y_ASIS ; Do rtn.
DO_SWITCH_IN_A: ; 12:1B9D, 0x025B9D
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(CARRY_SET_RTS) ; Carry set and RTS.
    HIGH(CARRY_SET_RTS)
    LOW(STREAM_TO_OBJ_B) ; 3x forwards.
    HIGH(STREAM_TO_OBJ_B)
    LOW(SWITCH_TO_OBJ_C) ; Forward+Clear
    HIGH(SWITCH_TO_OBJ_C)
    LOW(SWITCH_TO_OBJ_D) ; 3x forwards.
    HIGH(SWITCH_TO_OBJ_D)
CARRY_SET_RTS: ; 12:1BA8, 0x025BA8
    .db 38 ; Set carry.
    .db 60
STREAM_TO_OBJ_B: ; 12:1BAA, 0x025BAA
    JSR FORWARD_XOBJ_STREAM_PTR ; Forward.
    LDA [TMP_08],Y ; Load from stream.
    STA 47E_ARR_UNK[18],X ; Store to obj.
    JSR FORWARD_XOBJ_STREAM_PTR ; Forward.
    LDA [TMP_08],Y ; Load from stream.
    STA 4A2_ARR_UNK[18],X ; Store to obj.
    JSR FORWARD_XOBJ_STREAM_PTR ; Forward.
    RTS
SWITCH_TO_OBJ_C: ; 12:1BBE, 0x025BBE
    JSR FORWARD_XOBJ_STREAM_PTR ; Forward.
    LDA [TMP_08],Y ; Load.
    STA 45A_ARR_UNK[18],X ; Store to obj.
    JSR FORWARD_XOBJ_STREAM_PTR ; Forward.
    LDA #$00 ; Clear in obj.
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Clear.
    RTS
SWITCH_TO_OBJ_D: ; 12:1BCF, 0x025BCF
    JSR FORWARD_XOBJ_STREAM_PTR ; Forward steam.
    LDA [TMP_08],Y ; Load val.
    STA 5D4_ARR_OBJ_TIMER?[18],X ; Store to obj.
    JSR FORWARD_XOBJ_STREAM_PTR ; Forward.
    RTS
FORWARD_XOBJ_STREAM_PTR: ; 12:1BDB, 0x025BDB
    INY ; Stream++
    BNE RTS ; No overflow, keep.
    INC TMP_09 ; Inc RAM high ptr.
    INC OBJECT_DATA_EXTRA_B?[18],X ; Obj copy, too.
RTS: ; 12:1BE3, 0x025BE3
    RTS
RTN_MODIFY_A_???: ; 12:1BE4, 0x025BE4
    STY TMP_0F? ; Y object val to.
    TAY ; A val to Y.
    BEQ RTS ; A == 0, goto.
    CMP #$25 ; If A _ #$25
    BCC VAL_LT_#$25 ; <, goto.
    LDY #$00 ; Index init.
SEARCH_MATCH_LOOP: ; 12:1BEF, 0x025BEF
    CMP DATA_MATCH_UNK,Y ; Compare to data.
    BEQ DATA_EQUAL ; Data equal, goto.
    INY ; Y++
    CPY #$05 ; If _ #$05
    BCC SEARCH_MATCH_LOOP ; <, goto.
    LDA #$00 ; A=
    JMP RTS
DATA_EQUAL: ; 12:1BFE, 0x025BFE
    LDA DATA_MATCH_LOADED,Y ; Load data translated?
    JMP RTS ; Reload Y.
VAL_LT_#$25: ; 12:1C04, 0x025C04
    CLC ; Prep add.
    ADC #$23 ; Modify with add.
RTS: ; 12:1C07, 0x025C07
    LDY TMP_0F? ; Reload object.
    RTS ; Leave
DATA_MATCH_UNK: ; 12:1C0A, 0x025C0A
    .db 3F
    .db 4C
    .db 50
    .db 4E
    .db 4F
DATA_MATCH_LOADED: ; 12:1C0F, 0x025C0F
    .db 48
    .db 49
    .db 4A
    .db 4B
    .db 4C
RTN_BG_UPDATES_TEXT_FADE_IN?: ; 12:1C14, 0x025C14
    STX TMP_0B ; X to.
    STY TMP_0C ; Y to.
    LDX PPU_UPDATE_BUF_INDEX ; Load index.
    LDA #$04
    STA PPU_UPDATE_BUFFER[20],X ; Config?
    LDA #$10
    STA PPU_UPDATE_BUFFER+1,X ; Val.
    LDA #$3F
    STA PPU_UPDATE_BUFFER+2,X ; Addr $3F10, sprites.
    LDA #$10
    STA PPU_UPDATE_BUFFER+3,X ; Length
    LDY #$10
LOOP_WHOLE_PALETTE: ; 12:1C30, 0x025C30
    STY TMP_0A ; Store to.
    TYA ; Y to A.
    LSR A ; >> 2, *4.
    LSR A
    AND #$03 ; Keep bits.
    TAY ; To Y index.
    LDA 45A_ARR_UNK+7,Y ; Load from obj 7-10
    ASL A ; << 4, *16.
    ASL A
    ASL A
    ASL A
    LDY TMP_0A ; Y from.
    STA TMP_0A ; A to.
    SEC ; Prep sub.
    LDA PPU_PALETTE_BUF?[32],Y ; Load color.
    SBC TMP_0A ; Subtract with.
    CMP #$40 ; If _ #$40
    BCC 12:1C4F ; <, goto.
    LDA #$0F ; Load, black?
    STA PPU_UPDATE_BUFFER+4,X ; Store to update buf.
    INX ; Next buf data.
    INY ; Next palette data.
    CPY #$20 ; If Y _ #$20
    BCC LOOP_WHOLE_PALETTE ; <, goto.
    CLC
    LDA PPU_UPDATE_BUF_INDEX ; Load
    ADC #$14 ; Add
    STA PPU_UPDATE_BUF_INDEX ; Store.
    LDX TMP_0B ; X from.
    LDY TMP_0C ; Y from.
    TXA
    PHA ; Save X.
    TYA
    PHA ; Save Y.
    LDA #$04
    JSR UNK_STREAM_0x300_SETUP_BANK_1C/1D ; Add file.
    PLA
    TAY ; Restore X and Y.
    PLA
    TAX
    RTS ; Leave.
INIT_OBJ_DATA_UNK: ; 12:1C71, 0x025C71
    LDX #$07 ; Object 8
    LDY #$00 ; Other value setting.
LOOP_TO_OBJ_18: ; 12:1C75, 0x025C75
    JSR INIT_OBJECT[X]_DATA? ; Init object.
    CPX #$0B ; Object 12?
    BCS OBJ_PAST_CHECK ; >=, goto. Don't set values.
    LDA #$04
    STA 45A_ARR_UNK[18],X ; Set to 4.
    TYA
    STA OBJ_DIRECTION_RELATED?[18],X ; Y val to here.
    INY ; Y++
OBJ_PAST_CHECK: ; 12:1C86, 0x025C86
    INX ; X++
    CPX #$12 ; To obj 18?
    BCC LOOP_TO_OBJ_18 ; >, no, goto.
    RTS
CHECK_ALL_TEXT_COMPLETED?_RET_CC_UNFINISHED: ; 12:1C8C, 0x025C8C
    LDA #$00 ; Load
    STA TMP_10 ; Init cleared.
    LDX #$07 ; Object start.
LOOP_ALL_OBJS: ; 12:1C92, 0x025C92
    LDA ARR_OBJECT_ENABLED+MORE?[18],X ; Load...
    BEQ OBJ_AVAILABLE ; Free.
    JSR RTN_UPDATES_BG? ; Update BG from object?
    LDA #$01
    STA TMP_10 ; Set flag, not all done.
OBJ_AVAILABLE: ; 12:1C9E, 0x025C9E
    INX ; Next obj.
    CPX #$0B ; Obj _ 11
    BCC LOOP_ALL_OBJS ; <, goto. Not done.
    LDA TMP_10 ; Load flag, not all done.
    PHA ; Save.
    JSR RTN_BG_UPDATES_TEXT_FADE_IN? ; Do...
    PLA ; Pull saved.
    EOR #$01 ; Invert.
    LSR A ; Shift off bit into carry.
    RTS ; Leave.
RTN_UPDATES_BG?: ; 12:1CAE, 0x025CAE
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; Not timed down, RTS.
    LDA 3D5_UNK ; Load.
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Store to.
    DEC 45A_ARR_UNK[18],X ; --
    BNE RTS ; Not timed down, rts.
    LDA 47E_ARR_UNK[18],X ; Load
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    STA TMP_00 ; To tmp.
    INC 4A2_ARR_UNK[18],X ; ++
    LDA 4A2_ARR_UNK[18],X ; Load val
    LSR A ; >> 3, /8.
    LSR A
    LSR A
    STA TMP_01 ; Store to.
    LDA 5D4_ARR_OBJ_TIMER?[18],X ; Load.
    JSR RTN_BG_UPDATE_QUEUE ; Do sub.
    LDA OBJ_DIRECTION_RELATED?[18],X ; Load
    PHA ; Save
    JSR INIT_OBJECT[X]_DATA? ; Init obj X.
    PLA ; Pull
    STA OBJ_DIRECTION_RELATED?[18],X ; Restore.
RTS: ; 12:1CE2, 0x025CE2
    RTS
RTN_MAKE_OBJ_RET_CS_FAIL: ; 12:1CE3, 0x025CE3
    TYA ; Save Y. NOTE: Carry set means failure.
    PHA
    JSR REQUEST_OBJECT_SLOT_IN_Y ; Get obj slot.
    BCS RESTORE+RTS ; Failure.
    LDA #$70
    STA ARR_OBJECT_ENABLED+MORE?[18],Y ; Enabled.
    LDA TMP_00 ; Load val.
    ASL A ; << 3, *8
    ASL A
    ASL A
    STA 47E_ARR_UNK[18],Y ; Store to object.
    LDA TMP_01 ; Load val.
    ASL A ; << 3, *8
    ASL A
    ASL A
    SEC ; Prep sub.
    SBC #$01 ; -=1
    STA 4A2_ARR_UNK[18],Y ; Store to.
    STA 46C_ARR_UNK[18],Y ; Also here.
    LDA TMP_02 ; Load val.
    STA 5D4_ARR_OBJ_TIMER?[18],Y ; Store.
    JSR RTN_MODIFY_A_???
    STA 400_ARR_SPR_ANIM_FRAME_WHICH?[18],Y ; Store to anim?
    LDA #$03
    STA 45A_ARR_UNK[18],Y ; Set val.
    LDA 3D5_UNK
    STA OBJ_ANIM_HOLD_TIMER?[18],Y ; Set val.
    CLC ; Clear carry.
RESTORE+RTS: ; 12:1D1C, 0x025D1C
    PLA ; Restore Y.
    TAY
    RTS ; Leave.
REQUEST_OBJECT_SLOT_IN_Y: ; 12:1D1F, 0x025D1F
    LDY #$07 ; Obj 8. NOTE: Carry set signals a failure.
    CLC ; Prep ?
LOOP_SEARCH: ; 12:1D22, 0x025D22
    LDA ARR_OBJECT_ENABLED+MORE?[18],Y ; Load val.
    BEQ RTS_CARRY_CLEAR ; == 0, goto.
    INY ; Obj++
    CPY #$0B ; Obj _ 11
    BCC LOOP_SEARCH ; <, goto.
RTS_CARRY_CLEAR: ; 12:1D2C, 0x025D2C
    RTS ; If naturally gets here, >=, carry set. Failure.
TEXT?_PTR_L: ; 12:1D2D, 0x025D2D
    LOW(TEXT_FILE_A)
TEXT?_PTR_H: ; 12:1D2E, 0x025D2E
    HIGH(TEXT_FILE_A)
    LOW(TEXT_FILE_B)
    HIGH(TEXT_FILE_B)
    LOW(TEXT_FILE_B)
    HIGH(TEXT_FILE_B)
    LOW(TEXT_FILE_C)
    HIGH(TEXT_FILE_C)
    LOW(TEXT_FILE_C)
    HIGH(TEXT_FILE_C)
    LOW(TEXT_FILE_D)
    HIGH(TEXT_FILE_D)
    LOW(TEXT_FILE_D)
    HIGH(TEXT_FILE_D)
    LOW(TEXT_FILE_E)
    HIGH(TEXT_FILE_E)
    LOW(TEXT_FILE_E)
    HIGH(TEXT_FILE_E)
    LOW(TEXT_FILE_F)
    HIGH(TEXT_FILE_F)
    LOW(TEXT_FILE_G)
    HIGH(TEXT_FILE_G)
    LOW(TEXT_FILE_H)
    HIGH(TEXT_FILE_H)
    LOW(TEXT_FILE_H)
    HIGH(TEXT_FILE_H)
    LOW(TEXT_FILE_H)
    HIGH(TEXT_FILE_H)
    LOW(TEXT_FILE_H)
    HIGH(TEXT_FILE_H)
TEXT_FILE_A: ; 12:1D4B, 0x025D4B
    .db FE
    .db 0C
    .db 0A
    .db FD
    .db 02
    .db FC
    .db 20
    .db 1D
    .db 0D
    .db 0F
    .db 18
    .db 0F
    .db 00
    .db 02
    .db FE
    .db 02
    .db 0D
    .db 10
    .db 13
    .db 1C
    .db 0F
    .db 50
    .db 00
    .db 21
    .db 0F
    .db 00
    .db 11
    .db 19
    .db 1E
    .db 1E
    .db 0B
    .db 00
    .db 11
    .db 0F
    .db 1E
    .db FE
    .db 10
    .db 10
    .db 0B
    .db 1A
    .db 1C
    .db 13
    .db 16
    .db 00
    .db 19
    .db 1F
    .db 1E
    .db 00
    .db 50
    .db 50
    .db FC
    .db 70
    .db FF
TEXT_FILE_B: ; 12:1D80, 0x025D80
    .db FE
    .db 0C
    .db 0A
    .db FD
    .db 02
    .db FC
    .db 20
    .db 1D
    .db 0D
    .db 0F
    .db 18
    .db 0F
    .db 00
    .db 03
    .db FE
    .db 02
    .db 0D
    .db 0D
    .db 4E
    .db 17
    .db 19
    .db 18
    .db 00
    .db 0B
    .db 10
    .db 1E
    .db 0F
    .db 1C
    .db 00
    .db 1E
    .db 12
    .db 0B
    .db 1E
    .db 00
    .db FE
    .db 0B
    .db 10
    .db 1D
    .db 12
    .db 1C
    .db 0F
    .db 0E
    .db 0E
    .db 0F
    .db 1C
    .db 00
    .db 0D
    .db 1C
    .db 0F
    .db 0F
    .db 1A
    .db 00
    .db 50
    .db 50
    .db FC
    .db 70
    .db FF
TEXT_FILE_C: ; 12:1DB9, 0x025DB9
    .db FE
    .db 0C
    .db 0A
    .db FD
    .db 02
    .db FC
    .db 20
    .db 1D
    .db 0D
    .db 0F
    .db 18
    .db 0F
    .db 00
    .db 04
    .db FE
    .db 02
    .db 0D
    .db 16
    .db 0F
    .db 1E
    .db 4E
    .db 1D
    .db 00
    .db 17
    .db 0F
    .db 16
    .db 1E
    .db 00
    .db 1D
    .db 18
    .db 19
    .db 21
    .db 00
    .db 0B
    .db 18
    .db 0E
    .db FE
    .db 0B
    .db 10
    .db 1C
    .db 0F
    .db 0C
    .db 1F
    .db 13
    .db 16
    .db 0E
    .db 00
    .db 18
    .db 3F
    .db 23
    .db 3F
    .db 00
    .db 0D
    .db 13
    .db 1E
    .db 23
    .db 3F
    .db FC
    .db 70
    .db FF
TEXT_FILE_D: ; 12:1DF5, 0x025DF5
    .db FE
    .db 0C
    .db 0A
    .db FD
    .db 02
    .db FC
    .db 20
    .db 1D
    .db 0D
    .db 0F
    .db 18
    .db 0F
    .db 00
    .db 05
    .db FE
    .db 02
    .db 0D
    .db 16
    .db 0F
    .db 1E
    .db 4E
    .db 1D
    .db 00
    .db 11
    .db 0F
    .db 1E
    .db 00
    .db 1E
    .db 19
    .db 00
    .db 1E
    .db 12
    .db 0B
    .db 1E
    .db FE
    .db 0C
    .db 10
    .db 1D
    .db 0F
    .db 0D
    .db 1C
    .db 0F
    .db 1E
    .db 00
    .db 10
    .db 0B
    .db 0D
    .db 1E
    .db 19
    .db 1C
    .db 23
    .db 00
    .db 50
    .db 50
    .db FC
    .db 70
    .db FF
TEXT_FILE_E: ; 12:1E2E, 0x025E2E
    .db FE
    .db 0C
    .db 0A
    .db FD
    .db 02
    .db FC
    .db 20
    .db 1D
    .db 0D
    .db 0F
    .db 18
    .db 0F
    .db 00
    .db 06
    .db FE
    .db 02
    .db 0D
    .db 0D
    .db 4E
    .db 17
    .db 19
    .db 18
    .db 00
    .db 16
    .db 0F
    .db 1E
    .db 4E
    .db 1D
    .db 00
    .db 0C
    .db 1F
    .db 1D
    .db 1E
    .db FE
    .db 0F
    .db 10
    .db 1E
    .db 12
    .db 13
    .db 1D
    .db 00
    .db 14
    .db 19
    .db 13
    .db 18
    .db 1E
    .db 00
    .db 50
    .db 50
    .db FC
    .db 70
    .db FF
TEXT_FILE_F: ; 12:1E62, 0x025E62
    .db FE
    .db 0C
    .db 0A
    .db FD
    .db 02
    .db FC
    .db 20
    .db 1D
    .db 0D
    .db 0F
    .db 18
    .db 0F
    .db 00
    .db 07
    .db FE
    .db 02
    .db 0D
    .db 16
    .db 0F
    .db 1E
    .db 4E
    .db 1D
    .db 00
    .db 0E
    .db 0F
    .db 10
    .db 0F
    .db 0B
    .db 1E
    .db 00
    .db 1E
    .db 12
    .db 0F
    .db 00
    .db 0F
    .db 18
    .db 0F
    .db 17
    .db 23
    .db 4E
    .db 1D
    .db FE
    .db 0F
    .db 10
    .db 18
    .db 13
    .db 18
    .db 14
    .db 0B
    .db 00
    .db 17
    .db 0B
    .db 11
    .db 13
    .db 0D
    .db 00
    .db 50
    .db 50
    .db FC
    .db 70
    .db FF
TEXT_FILE_G: ; 12:1E9F, 0x025E9F
    .db FE
    .db 0C
    .db 0A
    .db FD
    .db 02
    .db FC
    .db 20
    .db 1D
    .db 0D
    .db 0F
    .db 18
    .db 0F
    .db 00
    .db 08
    .db FE
    .db 02
    .db 0D
    .db 21
    .db 0F
    .db 00
    .db 11
    .db 19
    .db 1E
    .db 1E
    .db 0B
    .db 00
    .db 10
    .db 13
    .db 18
    .db 0E
    .db 00
    .db 1E
    .db 12
    .db 0F
    .db FE
    .db 0F
    .db 10
    .db 1E
    .db 0F
    .db 0D
    .db 12
    .db 18
    .db 19
    .db 0E
    .db 1C
    .db 19
    .db 17
    .db 0F
    .db 50
    .db 50
    .db FC
    .db 70
    .db FF
TEXT_FILE_H: ; 12:1ED4, 0x025ED4
    .db FD
    .db 03
    .db FC
    .db 20
    .db FE
    .db 0C
    .db 02
    .db 0F
    .db 1A
    .db 13
    .db 16
    .db 19
    .db 11
    .db 1F
    .db 0F
    .db FE
    .db 02
    .db 04
    .db 10
    .db 1C
    .db 0F
    .db 0B
    .db 15
    .db 0F
    .db 0E
    .db 00
    .db 1E
    .db 12
    .db 0F
    .db 00
    .db 10
    .db 19
    .db 19
    .db 1E
    .db 1D
    .db 4F
    .db 17
    .db 0B
    .db 18
    .db 11
    .db 16
    .db 0F
    .db 0E
    .db FE
    .db 02
    .db 06
    .db 1E
    .db 12
    .db 0F
    .db 00
    .db 17
    .db 19
    .db 1F
    .db 1D
    .db 0F
    .db 1C
    .db 1D
    .db 00
    .db 0B
    .db 18
    .db 0E
    .db 00
    .db 1E
    .db 19
    .db 1E
    .db 0B
    .db 16
    .db 16
    .db 0F
    .db 0E
    .db FE
    .db 02
    .db 08
    .db 1E
    .db 12
    .db 0F
    .db 00
    .db 1E
    .db 0F
    .db 0D
    .db 12
    .db 18
    .db 19
    .db 0E
    .db 1C
    .db 19
    .db 17
    .db 0F
    .db 3F
    .db FE
    .db 02
    .db 0A
    .db 1E
    .db 12
    .db 0B
    .db 1E
    .db 4E
    .db 1D
    .db 00
    .db 3F
    .db 3F
    .db 00
    .db 1E
    .db 1F
    .db 1C
    .db 1E
    .db 16
    .db 0F
    .db 00
    .db 1A
    .db 19
    .db 21
    .db 0F
    .db 1C
    .db 50
    .db 50
    .db FE
    .db 02
    .db 0C
    .db 0C
    .db 1F
    .db 1E
    .db 4F
    .db 21
    .db 12
    .db 0B
    .db 1E
    .db 00
    .db 0B
    .db 0C
    .db 19
    .db 1F
    .db 1E
    .db 00
    .db 1E
    .db 12
    .db 0F
    .db 00
    .db 1D
    .db 12
    .db 1C
    .db 0F
    .db 0E
    .db 0E
    .db 0F
    .db 1C
    .db FE
    .db 02
    .db 0E
    .db 0B
    .db 18
    .db 0E
    .db 00
    .db 15
    .db 1C
    .db 0B
    .db 18
    .db 11
    .db 00
    .db 3F
    .db 3F
    .db 3F
    .db 50
    .db 7F
    .db FE
    .db 02
    .db 10
    .db 0C
    .db 1F
    .db 1C
    .db 18
    .db 0F
    .db 0E
    .db 00
    .db 1E
    .db 19
    .db 00
    .db 1E
    .db 19
    .db 0B
    .db 1D
    .db 1E
    .db 00
    .db 7F
    .db FE
    .db 02
    .db 12
    .db 20
    .db 0B
    .db 1A
    .db 19
    .db 1C
    .db 13
    .db 24
    .db 0F
    .db 0E
    .db 00
    .db 1E
    .db 19
    .db 00
    .db 17
    .db 13
    .db 16
    .db 15
    .db 1D
    .db 12
    .db 0B
    .db 15
    .db 0F
    .db 00
    .db 7F
    .db 7F
    .db FE
    .db 02
    .db 14
    .db 19
    .db 1C
    .db 3F
    .db 3F
    .db 0F
    .db 1D
    .db 0D
    .db 0B
    .db 1A
    .db 0F
    .db 0E
    .db 00
    .db 1E
    .db 19
    .db 00
    .db 0E
    .db 13
    .db 17
    .db 0F
    .db 18
    .db 1D
    .db 13
    .db 19
    .db 18
    .db 00
    .db 22
    .db 00
    .db 7F
    .db FE
    .db 02
    .db 16
    .db 1F
    .db 18
    .db 1E
    .db 13
    .db 16
    .db 00
    .db 21
    .db 0F
    .db 00
    .db 15
    .db 18
    .db 19
    .db 21
    .db 4F
    .db 18
    .db 19
    .db 18
    .db 0F
    .db 00
    .db 19
    .db 10
    .db 00
    .db 1F
    .db 1D
    .db 00
    .db 0D
    .db 0B
    .db 18
    .db FE
    .db 02
    .db 18
    .db 1D
    .db 16
    .db 0F
    .db 0F
    .db 1A
    .db 00
    .db 1D
    .db 0B
    .db 10
    .db 0F
    .db 16
    .db 23
    .db 00
    .db 13
    .db 18
    .db 00
    .db 19
    .db 1F
    .db 1C
    .db 00
    .db 0C
    .db 0F
    .db 0E
