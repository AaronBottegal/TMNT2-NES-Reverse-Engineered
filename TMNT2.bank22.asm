    .db 36
OBJ_STATE_0x6E_HANDLER: ; 16:0001, 0x02C001
    .db 60
    .db 60 ; Just make sure, lol.
OBJ_STATE_0x79_HANDLER: ; 16:0003, 0x02C003
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD
    LDA #$00
    CPX #$07
    BEQ L_16:000E
    LDA #$01
L_16:000E: ; 16:000E, 0x02C00E
    STA 710_UNK
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    BEQ L_16:0019
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
L_16:0019: ; 16:0019, 0x02C019
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    BEQ L_16:0021
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
L_16:0021: ; 16:0021, 0x02C021
    LDA #$0D
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR L_16:0093
    LDA OBJECT_DATA_EXTRA_B?[18],X
    BEQ RTS
    LDA OBJ_ANIM_HOLD_TIMER?+1,X
    BNE L_16:0076
    LDA OBJECT_DATA_HEALTH?[18],X
    PHA
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X
    BEQ L_16:0041
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X
L_16:0041: ; 16:0041, 0x02C041
    JSR OBJ_RTN_UNK_RET_VAL_UNK
    STA TMP_00
    PLA
    LDY OBJECT_DATA_HEALTH?[18],X
    CPY #$FF
    BNE L_16:0051
    STA OBJECT_DATA_HEALTH?[18],X
L_16:0051: ; 16:0051, 0x02C051
    LDA TMP_00
    AND #$02
    BEQ L_16:006A
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    ORA #$40
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    JSR RANDOMNESS?
    AND #$03
    BNE RTS
    JSR L_16:02EF
RTS: ; 16:0069, 0x02C069
    RTS
L_16:006A: ; 16:006A, 0x02C06A
    LSR TMP_00
    BCC RTS
    LDA #$2F
    JSR SND_BANKED_DISPATCH
    JMP L_16:09A9
L_16:0076: ; 16:0076, 0x02C076
    LDA OBJ_ANIM_HOLD_TIMER?+1,X
    BEQ RTS
    CLC
    DEC OBJ_ANIM_HOLD_TIMER?+1,X
    BMI L_16:0086
    LDA OBJ_ANIM_HOLD_TIMER?+1,X
    LSR A
    LSR A
L_16:0086: ; 16:0086, 0x02C086
    LDA OBJ_STATE_DIR_RELATED_C[18],X
    AND #$FC
    BCC L_16:008F
    ORA #$02
L_16:008F: ; 16:008F, 0x02C08F
    STA OBJ_STATE_DIR_RELATED_C[18],X
RTS: ; 16:0092, 0x02C092
    RTS
L_16:0093: ; 16:0093, 0x02C093
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ASL A
    TAY
    LDA L_16:00B3,Y
    STA TMP_00
    LDA L_16:00B4,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X
    ASL A
    TAY
    LDA [TMP_00],Y
    STA TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02]
L_16:00B3: ; 16:00B3, 0x02C0B3
    .db BF
L_16:00B4: ; 16:00B4, 0x02C0B4
    .db 80
    .db C1
    .db 80
    .db C9
    .db 80
    .db D7
    .db 80
    .db DB
    .db 80
    .db DD
    .db 80
    .db E5
    .db 80
    .db 54
    .db 81
    .db 86
    .db 81
    .db D2
    .db 81
    .db CA
    .db 82
    .db 35
    .db 83
    .db E1
    .db 85
    .db F3
    .db 84
    .db 1F
    .db 83
    .db 69
    .db 86
    .db 7F
    .db 86
    .db 15
    .db 85
    .db 35
    .db 85
    .db B6
    .db 86
    .db 36
    .db 8A
    .db 98
    .db 8A
    .db 3A
    .db 8B
    .db 59
    .db 8B
    .db 7C
    .db 8B
    .db A0
    .db 22
    .db 20
    .db 55
    .db F6
    .db A9
    .db 01
    .db 8D
    .db 08
    .db 07
    .db A9
    .db 00
    .db 8D
    .db 09
    .db 07
    .db A9
    .db 07
    .db 8D
    .db 11
    .db 07
    .db A9
    .db 6E
    .db 9D
    .db 25
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 57
    .db 05
    .db 9D
    .db 37
    .db 04
    .db 9D
    .db 01
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 56
    .db 05
    .db 9D
    .db 7A
    .db 05
    .db A9
    .db 80
    .db 9D
    .db 7E
    .db 04
    .db A9
    .db 8C
    .db 9D
    .db A2
    .db 04
    .db 9D
    .db 6C
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 9E
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 9D
    .db 36
    .db 04
    .db A9
    .db 02
    .db 9D
    .db 5A
    .db 04
    .db A9
    .db 0A
    .db 9D
    .db 48
    .db 04
    .db A9
    .db 80
    .db 9D
    .db 44
    .db 05
    .db FE
    .db 12
    .db 04
    .db A9
    .db B0
    .db 9D
    .db 68
    .db 05
    .db 60
    .db 98
    .db 48
    .db A9
    .db 10
    .db AC
    .db 11
    .db 07
    .db D0
    .db 02
    .db A9
    .db 20
    .db 9D
    .db 68
    .db 05
    .db 68
    .db A8
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db DE
    .db 44
    .db 05
    .db D0
    .db 27
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 9D
    .db 00
    .db 04
    .db 9D
    .db 32
    .db 05
    .db A8
    .db A9
    .db 01
    .db 9D
    .db 44
    .db 05
    .db 9D
    .db 48
    .db 04
    .db B9
    .db CC
    .db 81
    .db 9D
    .db 5A
    .db 04
    .db FE
    .db 8C
    .db 05
    .db A9
    .db 48
    .db 20
    .db 52
    .db DB
    .db A9
    .db 61
    .db 20
    .db 52
    .db DB
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 20
    .db 3E
    .db 86
    .db DE
    .db 48
    .db 04
    .db 10
    .db 21
    .db BD
    .db 44
    .db 05
    .db 9D
    .db 48
    .db 04
    .db DE
    .db 5A
    .db 04
    .db D0
    .db 16
    .db FE
    .db 32
    .db 05
    .db BC
    .db 32
    .db 05
    .db B9
    .db CC
    .db 81
    .db 9D
    .db 5A
    .db 04
    .db FE
    .db 44
    .db 05
    .db BD
    .db 44
    .db 05
    .db C9
    .db 06
    .db F0
    .db 0C
    .db BD
    .db 5A
    .db 04
    .db 4A
    .db 90
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 00
    .db 04
    .db 60
    .db A9
    .db 50
    .db 9D
    .db 44
    .db 05
    .db 20
    .db 48
    .db 89
    .db FE
    .db 8C
    .db 05
    .db 60
    .db 1E
    .db 0F
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db BD
    .db 44
    .db 05
    .db C9
    .db 30
    .db B0
    .db 1D
    .db AD
    .db 08
    .db 07
    .db F0
    .db 18
    .db A9
    .db C1
    .db 20
    .db D4
    .db EE
    .db A5
    .db 87
    .db D0
    .db 0F
    .db A9
    .db 00
    .db 8D
    .db 08
    .db 07
    .db A9
    .db 4B
    .db 20
    .db 52
    .db DB
    .db A9
    .db 00
    .db 8D
    .db DB
    .db 03
    .db DE
    .db 44
    .db 05
    .db F0
    .db 09
    .db 20
    .db 91
    .db 89
    .db 20
    .db 88
    .db F7
    .db 4C
    .db 0A
    .db 86
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db A9
    .db 0A
    .db E0
    .db 07
    .db F0
    .db 02
    .db A9
    .db 07
    .db AA
    .db BD
    .db 24
    .db 04
    .db F0
    .db 03
    .db 4C
    .db C2
    .db 82
    .db AC
    .db 00
    .db 07
    .db A9
    .db 6D
    .db 9D
    .db 24
    .db 04
    .db A9
    .db 6E
    .db 9D
    .db 25
    .db 04
    .db A9
    .db 01
    .db 9D
    .db 12
    .db 04
    .db 99
    .db 12
    .db 04
    .db A9
    .db 03
    .db 9D
    .db 8C
    .db 05
    .db 99
    .db 8C
    .db 05
    .db B9
    .db 9E
    .db 05
    .db 29
    .db BF
    .db 9D
    .db 9E
    .db 05
    .db 49
    .db 01
    .db 99
    .db 9E
    .db 05
    .db A9
    .db 20
    .db 9D
    .db 48
    .db 04
    .db 99
    .db 48
    .db 04
    .db B9
    .db 7E
    .db 04
    .db 9D
    .db 7E
    .db 04
    .db B9
    .db A2
    .db 04
    .db 9D
    .db A2
    .db 04
    .db B9
    .db 6C
    .db 04
    .db 9D
    .db 6C
    .db 04
    .db B9
    .db 36
    .db 04
    .db 29
    .db FC
    .db 9D
    .db 36
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 56
    .db 05
    .db 9D
    .db C6
    .db 04
    .db 9D
    .db 00
    .db 04
    .db 9D
    .db 7A
    .db 05
    .db 9D
    .db B0
    .db 05
    .db 20
    .db 43
    .db 81
    .db B9
    .db 9E
    .db 05
    .db 4A
    .db B0
    .db 1B
    .db AD
    .db C8
    .db 82
    .db 9D
    .db FC
    .db 04
    .db AD
    .db C9
    .db 82
    .db 9D
    .db EA
    .db 04
    .db AD
    .db C6
    .db 82
    .db 99
    .db FC
    .db 04
    .db AD
    .db C7
    .db 82
    .db 99
    .db EA
    .db 04
    .db 4C
    .db B8
    .db 82
    .db AD
    .db C6
    .db 82
    .db 9D
    .db FC
    .db 04
    .db AD
    .db C7
    .db 82
    .db 9D
    .db EA
    .db 04
    .db AD
    .db C8
    .db 82
    .db 99
    .db FC
    .db 04
    .db AD
    .db C9
    .db 82
    .db 99
    .db EA
    .db 04
    .db 98
    .db AA
    .db 20
    .db 3E
    .db 86
    .db A9
    .db 49
    .db 20
    .db 52
    .db DB
    .db AE
    .db 00
    .db 07
    .db 60
    .db 00
    .db FF
    .db 00
    .db 01
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 20
    .db 3E
    .db 86
    .db DE
    .db 48
    .db 04
    .db F0
    .db 12
    .db 20
    .db 79
    .db 89
    .db BD
    .db 48
    .db 04
    .db 5D
    .db 9E
    .db 05
    .db 4A
    .db B0
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 00
    .db 04
    .db 60
    .db 20
    .db FA
    .db F6
    .db 4C
    .db 2A
    .db 83
L_16:02EF: ; 16:02EF, 0x02C2EF
    .db 98
    .db 48
    .db A0
    .db 07
    .db B9
    .db 24
    .db 04
    .db F0
    .db 08
    .db B9
    .db 9E
    .db 05
    .db 49
    .db 01
    .db 99
    .db 9E
    .db 05
    .db A0
    .db 0A
    .db B9
    .db 24
    .db 04
    .db F0
    .db 08
    .db B9
    .db 9E
    .db 05
    .db 49
    .db 01
    .db 99
    .db 9E
    .db 05
    .db 68
    .db A8
    .db 60
    .db A9
    .db 02
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 03
    .db 9D
    .db 8C
    .db 05
    .db 4C
    .db 34
    .db 86
    .db BC
    .db D4
    .db 05
    .db B9
    .db 12
    .db 04
    .db 29
    .db 04
    .db F0
    .db 01
    .db 60
    .db A9
    .db 02
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db 60
    .db 20
    .db CE
    .db F6
    .db 90
    .db 03
    .db 4C
    .db 0A
    .db 86
    .db A9
    .db 0A
    .db E0
    .db 07
    .db F0
    .db 02
    .db A9
    .db 07
    .db A8
    .db B9
    .db 24
    .db 04
    .db D0
    .db 12
    .db AD
    .db 11
    .db 07
    .db F0
    .db 0D
    .db BD
    .db 9E
    .db 05
    .db 29
    .db 20
    .db D0
    .db 06
    .db CE
    .db 11
    .db 07
    .db 4C
    .db 09
    .db 82
    .db 20
    .db 95
    .db 88
    .db BC
    .db D4
    .db 05
    .db 38
    .db BD
    .db 7E
    .db 04
    .db F9
    .db 7E
    .db 04
    .db 85
    .db 17
    .db 10
    .db 05
    .db 49
    .db FF
    .db 18
    .db 69
    .db 01
    .db 85
    .db 16
    .db 38
    .db BD
    .db A2
    .db 04
    .db F9
    .db A2
    .db 04
    .db 10
    .db 05
    .db 49
    .db FF
    .db 18
    .db 69
    .db 01
    .db 85
    .db 0E
    .db A5
    .db 0E
    .db C9
    .db 08
    .db B0
    .db 57
    .db BD
    .db C2
    .db 05
    .db D0
    .db 24
    .db B9
    .db 12
    .db 04
    .db 29
    .db 03
    .db C9
    .db 03
    .db D0
    .db 1B
    .db B9
    .db C6
    .db 04
    .db C9
    .db D0
    .db 90
    .db 14
    .db A5
    .db 16
    .db C9
    .db 28
    .db B0
    .db 03
    .db 4C
    .db 23
    .db 85
    .db C9
    .db 40
    .db 90
    .db 07
    .db C9
    .db 44
    .db B0
    .db 03
    .db 4C
    .db 23
    .db 85
    .db BD
    .db C2
    .db 05
    .db D0
    .db 09
    .db A5
    .db 16
    .db C9
    .db 20
    .db B0
    .db 03
    .db 4C
    .db 23
    .db 85
    .db 20
    .db 34
    .db CC
    .db 29
    .db 07
    .db D0
    .db 19
    .db A5
    .db 10
    .db C9
    .db 20
    .db 90
    .db 13
    .db C9
    .db 30
    .db B0
    .db 0F
    .db BC
    .db D4
    .db 05
    .db B9
    .db 12
    .db 04
    .db 29
    .db 03
    .db C9
    .db 02
    .db D0
    .db 03
    .db 4C
    .db CC
    .db 85
    .db AD
    .db 10
    .db 07
    .db F0
    .db 7C
    .db BD
    .db 8D
    .db 05
    .db D0
    .db 28
    .db AD
    .db 11
    .db 07
    .db F0
    .db 72
    .db A5
    .db 1B
    .db 29
    .db 3F
    .db D0
    .db 6C
    .db FE
    .db 7B
    .db 05
    .db BD
    .db 7B
    .db 05
    .db 29
    .db 07
    .db D0
    .db 62
    .db BC
    .db D4
    .db 05
    .db B9
    .db 7E
    .db 04
    .db 0A
    .db A9
    .db 01
    .db 90
    .db 02
    .db A9
    .db 06
    .db 9D
    .db 8D
    .db 05
    .db 4C
    .db 63
    .db 84
    .db BC
    .db 8D
    .db 05
    .db B9
    .db 4D
    .db 84
    .db D0
    .db 19
    .db BD
    .db EA
    .db 04
    .db 1D
    .db FC
    .db 04
    .db 1D
    .db 0E
    .db 05
    .db 1D
    .db 20
    .db 05
    .db D0
    .db 3F
    .db FE
    .db 8D
    .db 05
    .db A9
    .db 40
    .db 9D
    .db 69
    .db 05
    .db 4C
    .db 69
    .db 84
    .db DE
    .db 69
    .db 05
    .db D0
    .db 2F
    .db FE
    .db 8D
    .db 05
    .db BC
    .db 8D
    .db 05
    .db B9
    .db 58
    .db 84
    .db F0
    .db 24
    .db A9
    .db 00
    .db 9D
    .db 8D
    .db 05
    .db 4C
    .db 69
    .db 84
    .db 00
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 00
    .db 01
    .db 00
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 00
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
    .db 01
    .db A5
    .db 1B
    .db 29
    .db 7F
    .db D0
    .db 3D
    .db A0
    .db 07
    .db E0
    .db 0A
    .db D0
    .db 0A
    .db B9
    .db 24
    .db 04
    .db F0
    .db 32
    .db B9
    .db 9E
    .db 05
    .db 30
    .db 2D
    .db A0
    .db 0A
    .db E0
    .db 07
    .db F0
    .db 02
    .db A0
    .db 07
    .db B9
    .db 9E
    .db 05
    .db 29
    .db 20
    .db D0
    .db 1E
    .db A5
    .db 47
    .db D0
    .db 07
    .db AD
    .db 12
    .db 04
    .db 29
    .db 04
    .db D0
    .db 13
    .db 20
    .db E2
    .db 86
    .db B0
    .db 0E
    .db 8D
    .db 09
    .db 07
    .db BD
    .db 9E
    .db 05
    .db 09
    .db 20
    .db 9D
    .db 9E
    .db 05
    .db 4C
    .db 47
    .db 86
    .db 20
    .db 79
    .db 89
    .db 20
    .db 91
    .db 89
    .db 20
    .db 72
    .db F7
    .db 20
    .db 88
    .db F7
    .db 4C
    .db 0A
    .db 86
    .db A9
    .db 02
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 02
    .db 9D
    .db 8C
    .db 05
    .db BC
    .db D4
    .db 05
    .db B9
    .db 36
    .db 04
    .db 0A
    .db 0A
    .db A0
    .db 02
    .db B0
    .db 02
    .db A0
    .db 04
    .db B9
    .db 61
    .db 89
    .db 9D
    .db FC
    .db 04
    .db B9
    .db 62
    .db 89
    .db 9D
    .db EA
    .db 04
    .db 1E
    .db FC
    .db 04
    .db 3E
    .db EA
    .db 04
    .db BD
    .db A2
    .db 04
    .db C9
    .db 90
    .db A0
    .db 02
    .db 90
    .db 02
    .db A0
    .db 04
    .db 20
    .db 4A
    .db 89
    .db A9
    .db 28
    .db 9D
    .db 44
    .db 05
    .db 60
    .db DE
    .db 44
    .db 05
    .db F0
    .db 0F
    .db 20
    .db 79
    .db 89
    .db 20
    .db 91
    .db 89
    .db 20
    .db 88
    .db F7
    .db 20
    .db 72
    .db F7
    .db 4C
    .db 0A
    .db 86
    .db 20
    .db FA
    .db F6
    .db A9
    .db 06
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 40
    .db 9D
    .db 44
    .db 05
    .db 60
    .db DE
    .db 44
    .db 05
    .db D0
    .db 03
    .db 20
    .db 2A
    .db 83
    .db 20
    .db 72
    .db F7
    .db 4C
    .db 0A
    .db 86
    .db A9
    .db 03
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 16
    .db 9D
    .db 48
    .db 04
    .db 20
    .db 72
    .db F7
    .db A5
    .db 1B
    .db 29
    .db 07
    .db D0
    .db 11
    .db BD
    .db 36
    .db 04
    .db 0A
    .db 0A
    .db A9
    .db FF
    .db 90
    .db 02
    .db A9
    .db 00
    .db 7D
    .db 7E
    .db 04
    .db 9D
    .db 7E
    .db 04
    .db DE
    .db 48
    .db 04
    .db F0
    .db 41
    .db BC
    .db 48
    .db 04
    .db C0
    .db 0E
    .db D0
    .db 07
    .db 08
    .db A9
    .db 17
    .db 20
    .db 52
    .db DB
    .db 28
    .db A9
    .db 00
    .db B0
    .db 0B
    .db C0
    .db 0A
    .db 90
    .db 05
    .db A9
    .db A7
    .db 9D
    .db 7A
    .db 05
    .db A9
    .db 01
    .db 85
    .db 00
    .db BD
    .db 9E
    .db 05
    .db 0A
    .db 26
    .db 00
    .db A4
    .db 00
    .db B9
    .db C8
    .db 85
    .db 9D
    .db 00
    .db 04
    .db A9
    .db BD
    .db AC
    .db 10
    .db 07
    .db 99
    .db 31
    .db 00
    .db BD
    .db 9E
    .db 05
    .db 0A
    .db 10
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 60
    .db 20
    .db 34
    .db CC
    .db 29
    .db 1F
    .db 69
    .db 10
    .db 9D
    .db C2
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db BD
    .db 9E
    .db 05
    .db 0A
    .db 0A
    .db BD
    .db 9E
    .db 05
    .db 29
    .db BF
    .db 9D
    .db 9E
    .db 05
    .db 90
    .db 0D
    .db 20
    .db 34
    .db CC
    .db 29
    .db 07
    .db D0
    .db 06
    .db 20
    .db B5
    .db 84
    .db 4C
    .db 34
    .db 86
    .db DE
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db 4C
    .db 34
    .db 86
    .db AD
    .db E5
    .db AE
    .db AF
    .db A9
    .db 02
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 01
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 14
    .db 9D
    .db 48
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 60
    .db DE
    .db 48
    .db 04
    .db F0
    .db 19
    .db BD
    .db 9E
    .db 05
    .db 0A
    .db A9
    .db B0
    .db 69
    .db 00
    .db 9D
    .db 00
    .db 04
    .db A9
    .db BE
    .db AC
    .db 10
    .db 07
    .db 99
    .db 31
    .db 00
    .db A9
    .db 0E
    .db 9D
    .db 7A
    .db 05
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 9D
    .db C2
    .db 05
    .db 4C
    .db 23
    .db 85
    .db DE
    .db 48
    .db 04
    .db 10
    .db 08
    .db A9
    .db 0A
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
    .db 43
    .db 86
    .db BC
    .db 9E
    .db 05
    .db 10
    .db 03
    .db 18
    .db 69
    .db 03
    .db 9D
    .db 00
    .db 04
    .db A9
    .db BC
    .db AC
    .db 10
    .db 07
    .db 99
    .db 31
    .db 00
    .db 60
    .db A9
    .db 02
    .db 9D
    .db 5A
    .db 04
    .db A9
    .db 0A
    .db 9D
    .db 48
    .db 04
    .db A9
    .db A5
    .db 4C
    .db 20
    .db 86
    .db A3
    .db A4
    .db A5
    .db A4
    .db AD
    .db 09
    .db 07
    .db 0A
    .db A8
    .db B9
    .db 2F
    .db 87
    .db 85
    .db 0C
    .db B9
    .db 30
    .db 87
    .db 85
    .db 0E
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
    .db 20
    .db 3B
    .db 87
    .db A9
    .db 04
    .db 9D
    .db 8C
    .db 05
    .db 60
    .db 20
    .db 0A
    .db 86
    .db 20
    .db FE
    .db 87
    .db B0
    .db 05
    .db 20
    .db FE
    .db 87
    .db 90
    .db 08
    .db FE
    .db 8C
    .db 05
    .db A9
    .db 18
    .db 9D
    .db 48
    .db 04
    .db 60
    .db A9
    .db BF
    .db AC
    .db 10
    .db 07
    .db 99
    .db 31
    .db 00
    .db A9
    .db AA
    .db 9D
    .db 00
    .db 04
    .db BD
    .db 7E
    .db 04
    .db 0A
    .db BD
    .db 36
    .db 04
    .db 29
    .db BF
    .db B0
    .db 02
    .db 09
    .db 40
    .db 9D
    .db 36
    .db 04
    .db DE
    .db 48
    .db 04
    .db F0
    .db 01
    .db 60
    .db A9
    .db 03
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 01
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 01
    .db 04
    .db A9
    .db 44
    .db 4C
    .db 52
    .db DB
    .db A9
    .db BF
    .db AC
    .db 10
    .db 07
    .db 99
    .db 31
    .db 00
    .db A9
    .db AA
    .db 9D
    .db 00
    .db 04
    .db AC
    .db 09
    .db 07
    .db B9
    .db DC
    .db 86
    .db 20
    .db D4
    .db EE
    .db A5
    .db 87
    .db D0
    .db 0B
    .db BD
    .db 9E
    .db 05
    .db 29
    .db DF
    .db 9D
    .db 9E
    .db 05
    .db 20
    .db 12
    .db 83
    .db 60
    .db C2
    .db C3
    .db C4
    .db C5
    .db C6
    .db C7
    .db BD
    .db 9E
    .db 05
    .db 30
    .db 46
    .db BC
    .db D4
    .db 05
    .db BD
    .db 7E
    .db 04
    .db 38
    .db F9
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
    .db 40
    .db 90
    .db 31
    .db 18
    .db BD
    .db A2
    .db 04
    .db 69
    .db 10
    .db 29
    .db E0
    .db 85
    .db 00
    .db 18
    .db B9
    .db A2
    .db 04
    .db 69
    .db 10
    .db 29
    .db E0
    .db C5
    .db 00
    .db D0
    .db 1B
    .db 4A
    .db 4A
    .db 4A
    .db 4A
    .db 4A
    .db 29
    .db 03
    .db 85
    .db 00
    .db C6
    .db 00
    .db BD
    .db 36
    .db 04
    .db 0A
    .db 0A
    .db A9
    .db 00
    .db 90
    .db 02
    .db A9
    .db 03
    .db 18
    .db 65
    .db 00
    .db 18
    .db 60
    .db 38
    .db 60
    .db E0
    .db A0
    .db B0
    .db C0
    .db E0
    .db D7
    .db 20
    .db A0
    .db 50
    .db C0
    .db 20
    .db D7
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
    .db 91
    .db 04
    .db 9D
    .db B5
    .db 04
    .db 9D
    .db 9F
    .db 05
    .db 9D
    .db B1
    .db 05
    .db 38
    .db A5
    .db 0C
    .db E5
    .db 08
    .db 9D
    .db FD
    .db 04
    .db A5
    .db 0D
    .db E5
    .db 09
    .db 9D
    .db EB
    .db 04
    .db 1D
    .db FD
    .db 04
    .db F0
    .db 1D
    .db A9
    .db 01
    .db BC
    .db EB
    .db 04
    .db 10
    .db 13
    .db 38
    .db A9
    .db 00
    .db FD
    .db FD
    .db 04
    .db 9D
    .db FD
    .db 04
    .db A9
    .db 00
    .db FD
    .db EB
    .db 04
    .db 9D
    .db EB
    .db 04
    .db A9
    .db FF
    .db 9D
    .db 91
    .db 04
    .db 38
    .db A5
    .db 0E
    .db E5
    .db 0A
    .db 9D
    .db 21
    .db 05
    .db A5
    .db 0F
    .db E5
    .db 0B
    .db 9D
    .db 0F
    .db 05
    .db 1D
    .db 21
    .db 05
    .db F0
    .db 1D
    .db A9
    .db 01
    .db BC
    .db 0F
    .db 05
    .db 10
    .db 13
    .db 38
    .db A9
    .db 00
    .db FD
    .db 21
    .db 05
    .db 9D
    .db 21
    .db 05
    .db A9
    .db 00
    .db FD
    .db 0F
    .db 05
    .db 9D
    .db 0F
    .db 05
    .db A9
    .db FF
    .db 9D
    .db B5
    .db 04
    .db BD
    .db FD
    .db 04
    .db DD
    .db 21
    .db 05
    .db B0
    .db 1F
    .db FE
    .db B1
    .db 05
    .db BD
    .db FD
    .db 04
    .db 48
    .db BD
    .db EB
    .db 04
    .db 48
    .db BD
    .db 21
    .db 05
    .db 9D
    .db FD
    .db 04
    .db BD
    .db 0F
    .db 05
    .db 9D
    .db EB
    .db 04
    .db 68
    .db 9D
    .db 0F
    .db 05
    .db 68
    .db 9D
    .db 21
    .db 05
    .db BD
    .db 21
    .db 05
    .db 0A
    .db 85
    .db 08
    .db BD
    .db 0F
    .db 05
    .db 2A
    .db 85
    .db 09
    .db 38
    .db A5
    .db 08
    .db FD
    .db FD
    .db 04
    .db 9D
    .db 45
    .db 05
    .db A5
    .db 09
    .db FD
    .db EB
    .db 04
    .db 9D
    .db 33
    .db 05
    .db BD
    .db FD
    .db 04
    .db 9D
    .db 9F
    .db 05
    .db 60
    .db BD
    .db 9F
    .db 05
    .db D0
    .db 03
    .db 4C
    .db 93
    .db 88
    .db BD
    .db FD
    .db 04
    .db 0A
    .db 85
    .db 08
    .db BD
    .db EB
    .db 04
    .db 2A
    .db 85
    .db 09
    .db BD
    .db 21
    .db 05
    .db 0A
    .db 85
    .db 0A
    .db BD
    .db 0F
    .db 05
    .db 2A
    .db 85
    .db 0B
    .db BD
    .db 33
    .db 05
    .db 30
    .db 30
    .db BD
    .db B1
    .db 05
    .db D0
    .db 0D
    .db 18
    .db BD
    .db A2
    .db 04
    .db 7D
    .db B5
    .db 04
    .db 9D
    .db A2
    .db 04
    .db 4C
    .db 3F
    .db 88
    .db 18
    .db BD
    .db 7E
    .db 04
    .db 7D
    .db 91
    .db 04
    .db 9D
    .db 7E
    .db 04
    .db 38
    .db BD
    .db 45
    .db 05
    .db E5
    .db 08
    .db 9D
    .db 45
    .db 05
    .db BD
    .db 33
    .db 05
    .db E5
    .db 09
    .db 9D
    .db 33
    .db 05
    .db 4C
    .db 1E
    .db 88
    .db BD
    .db B1
    .db 05
    .db D0
    .db 0D
    .db 18
    .db BD
    .db 7E
    .db 04
    .db 7D
    .db 91
    .db 04
    .db 9D
    .db 7E
    .db 04
    .db 4C
    .db 6F
    .db 88
    .db 18
    .db BD
    .db A2
    .db 04
    .db 7D
    .db B5
    .db 04
    .db 9D
    .db A2
    .db 04
    .db 18
    .db BD
    .db 45
    .db 05
    .db 65
    .db 0A
    .db 9D
    .db 45
    .db 05
    .db BD
    .db 33
    .db 05
    .db 65
    .db 0B
    .db 9D
    .db 33
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
    .db 9F
    .db 05
    .db F0
    .db 04
    .db 18
    .db 4C
    .db 94
    .db 88
    .db 38
    .db 60
    .db AD
    .db 10
    .db 07
    .db F0
    .db 2D
    .db BD
    .db 8D
    .db 05
    .db F0
    .db 28
    .db BD
    .db 8D
    .db 05
    .db 0A
    .db A8
    .db B9
    .db B1
    .db 88
    .db 85
    .db 14
    .db B9
    .db B2
    .db 88
    .db 85
    .db 15
    .db 4C
    .db 0E
    .db 89
    .db 00
    .db 00
    .db D8
    .db 90
    .db D8
    .db 90
    .db D8
    .db D8
    .db D8
    .db D8
    .db 00
    .db 00
    .db 28
    .db D8
    .db 28
    .db D8
    .db 28
    .db 90
    .db 28
    .db 90
    .db 00
    .db 00
    .db BD
    .db 9E
    .db 05
    .db 4A
    .db A9
    .db F0
    .db A0
    .db 1E
    .db 90
    .db 04
    .db A9
    .db 10
    .db A0
    .db E2
    .db 85
    .db 14
    .db 98
    .db BC
    .db D4
    .db 05
    .db 18
    .db 79
    .db 7E
    .db 04
    .db 48
    .db 2A
    .db 5D
    .db 9E
    .db 05
    .db 4A
    .db 68
    .db B0
    .db 02
    .db 85
    .db 14
    .db BC
    .db D4
    .db 05
    .db B9
    .db A2
    .db 04
    .db 85
    .db 15
    .db BD
    .db 36
    .db 04
    .db 0A
    .db 0A
    .db 2A
    .db 5D
    .db 9E
    .db 05
    .db 4A
    .db 90
    .db 10
    .db B9
    .db A2
    .db 04
    .db C9
    .db B0
    .db A9
    .db E1
    .db B0
    .db 02
    .db A9
    .db 20
    .db 79
    .db A2
    .db 04
    .db 85
    .db 15
    .db 20
    .db 4F
    .db F7
    .db A0
    .db 00
    .db A5
    .db 10
    .db C9
    .db 02
    .db 90
    .db 0B
    .db A0
    .db 02
    .db BD
    .db 7E
    .db 04
    .db C5
    .db 14
    .db B0
    .db 02
    .db A0
    .db 04
    .db AD
    .db 10
    .db 07
    .db F0
    .db 05
    .db 18
    .db 98
    .db 69
    .db 06
    .db A8
    .db B9
    .db 61
    .db 89
    .db 9D
    .db FC
    .db 04
    .db B9
    .db 62
    .db 89
    .db 9D
    .db EA
    .db 04
    .db A0
    .db 00
    .db A5
    .db 11
    .db C9
    .db 08
    .db 90
    .db 08
    .db A0
    .db 02
    .db A5
    .db 13
    .db 10
    .db 02
    .db A0
    .db 04
    .db AD
    .db 10
    .db 07
    .db F0
    .db 05
    .db 18
    .db 98
    .db 69
    .db 06
    .db A8
    .db B9
    .db 6D
    .db 89
    .db 9D
    .db 20
    .db 05
    .db B9
    .db 6E
    .db 89
    .db 9D
    .db 0E
    .db 05
    .db 60
    .db 00
    .db 00
    .db 00
    .db FF
    .db 00
    .db 01
    .db 00
    .db 00
    .db E0
    .db FE
    .db 20
    .db 01
    .db 00
    .db 00
    .db 40
    .db FF
    .db C0
    .db 00
    .db 00
    .db 00
    .db 20
    .db FF
    .db E0
    .db 00
    .db 20
    .db 7C
    .db F8
    .db BD
    .db 7E
    .db 04
    .db C9
    .db 10
    .db 90
    .db 08
    .db C9
    .db F0
    .db 90
    .db 09
    .db A9
    .db F0
    .db D0
    .db 02
    .db A9
    .db 10
    .db 9D
    .db 7E
    .db 04
    .db 60
    .db 20
    .db 95
    .db F8
    .db BD
    .db A2
    .db 04
    .db C9
    .db 78
    .db 90
    .db 08
    .db C9
    .db E4
    .db 90
    .db 09
    .db A9
    .db E4
    .db D0
    .db 02
    .db A9
    .db 78
    .db 9D
    .db A2
    .db 04
    .db 60
L_16:09A9: ; 16:09A9, 0x02C9A9
    .db FE
    .db B0
    .db 05
    .db BD
    .db 68
    .db 05
    .db D0
    .db 1C
    .db A0
    .db 0A
    .db E0
    .db 07
    .db F0
    .db 02
    .db A0
    .db 07
    .db B9
    .db 12
    .db 04
    .db C9
    .db 05
    .db A9
    .db 06
    .db 9D
    .db 68
    .db 05
    .db B0
    .db 08
    .db A9
    .db 00
    .db 9D
    .db 68
    .db 05
    .db 4C
    .db 77
    .db 8A
    .db 20
    .db 41
    .db F8
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db BD
    .db 9E
    .db 05
    .db 29
    .db 20
    .db F0
    .db 12
    .db A9
    .db 18
    .db 9D
    .db 49
    .db 04
    .db BD
    .db 68
    .db 05
    .db C9
    .db 06
    .db B0
    .db 05
    .db A9
    .db 06
    .db 9D
    .db 68
    .db 05
    .db 60
    .db A9
    .db 04
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 18
    .db 9D
    .db 48
    .db 04
    .db BD
    .db 9E
    .db 05
    .db 30
    .db 20
    .db BC
    .db 68
    .db 05
    .db C0
    .db 06
    .db B0
    .db 19
    .db BD
    .db 9E
    .db 05
    .db 09
    .db 80
    .db 9D
    .db 9E
    .db 05
    .db 20
    .db CF
    .db 8B
    .db E0
    .db 07
    .db D0
    .db 0A
    .db A9
    .db 00
    .db 8D
    .db 11
    .db 07
    .db A9
    .db 14
    .db 9D
    .db 68
    .db 05
    .db BD
    .db 9E
    .db 05
    .db 0A
    .db A9
    .db B2
    .db 69
    .db 00
    .db 9D
    .db 00
    .db 04
    .db A9
    .db BF
    .db AC
    .db 10
    .db 07
    .db 99
    .db 31
    .db 00
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db DE
    .db 48
    .db 04
    .db 30
    .db 13
    .db BD
    .db 48
    .db 04
    .db 4A
    .db 4A
    .db EA
    .db BD
    .db 36
    .db 04
    .db 29
    .db FC
    .db 90
    .db 02
    .db 09
    .db 02
    .db 9D
    .db 36
    .db 04
    .db 60
    .db A9
    .db 20
    .db 9D
    .db C3
    .db 05
    .db BD
    .db C2
    .db 05
    .db C9
    .db 10
    .db 90
    .db 05
    .db A9
    .db 10
    .db 9D
    .db C2
    .db 05
    .db 20
    .db 72
    .db F7
    .db 20
    .db 34
    .db CC
    .db 29
    .db 07
    .db D0
    .db 03
    .db 4C
    .db CC
    .db 85
    .db 20
    .db 34
    .db 86
    .db 4C
    .db 2A
    .db 83
    .db E0
    .db 07
    .db F0
    .db 41
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db A9
    .db 05
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db 20
    .db 22
    .db 8A
    .db A9
    .db 80
    .db 9D
    .db 48
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db DE
    .db 48
    .db 04
    .db D0
    .db 03
    .db 4C
    .db 96
    .db 8B
    .db 20
    .db 22
    .db 8A
    .db BD
    .db 48
    .db 04
    .db 29
    .db 08
    .db D0
    .db 0C
    .db A5
    .db 1B
    .db 4A
    .db EA
    .db EA
    .db 90
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 00
    .db 04
    .db 60
    .db A2
    .db 0A
    .db BD
    .db 24
    .db 04
    .db F0
    .db 1E
    .db BD
    .db 12
    .db 04
    .db C9
    .db 05
    .db B0
    .db 17
    .db A9
    .db 05
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db 20
    .db 22
    .db 8A
    .db A9
    .db 80
    .db 9D
    .db 48
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db A2
    .db 07
    .db A9
    .db 05
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 01
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db BC
    .db D4
    .db 05
    .db B9
    .db 36
    .db 04
    .db 29
    .db 40
    .db 9D
    .db 36
    .db 04
    .db A0
    .db 00
    .db 0A
    .db 30
    .db 02
    .db A0
    .db 02
    .db B9
    .db 34
    .db 8B
    .db 9D
    .db FC
    .db 04
    .db B9
    .db 35
    .db 8B
    .db 9D
    .db EA
    .db 04
    .db AD
    .db 38
    .db 8B
    .db 9D
    .db 44
    .db 05
    .db AD
    .db 39
    .db 8B
    .db 9D
    .db 32
    .db 05
    .db 20
    .db 02
    .db 80
    .db A9
    .db B5
    .db 9D
    .db 00
    .db 04
    .db A9
    .db BF
    .db AC
    .db 10
    .db 07
    .db 99
    .db 31
    .db 00
    .db A9
    .db E0
    .db 9D
    .db C6
    .db 04
    .db 4C
    .db 88
    .db F7
    .db 00
    .db FE
    .db 00
    .db 02
    .db 00
    .db FF
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 20
    .db 79
    .db 89
    .db A9
    .db 18
    .db 20
    .db 57
    .db F8
    .db 90
    .db 0D
    .db FE
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db C6
    .db 04
    .db A9
    .db 10
    .db 9D
    .db 44
    .db 05
    .db 4C
    .db 88
    .db F7
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db DE
    .db 44
    .db 05
    .db D0
    .db 03
    .db 4C
    .db 79
    .db 89
    .db A9
    .db 01
    .db 8D
    .db DB
    .db 03
    .db 20
    .db 28
    .db DB
    .db A9
    .db 7E
    .db 20
    .db 52
    .db DB
    .db FE
    .db 8C
    .db 05
    .db A9
    .db 96
    .db 9D
    .db 44
    .db 05
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db DE
    .db 44
    .db 05
    .db D0
    .db F5
    .db A9
    .db 00
    .db 8D
    .db 08
    .db 07
    .db 8D
    .db 09
    .db 07
    .db A9
    .db FF
    .db 8D
    .db F8
    .db 05
    .db 4C
    .db 99
    .db 8B
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
    .db CA
    .db CA
    .db 60
OBJ_STATE_0x6F_HANDLER: ; 16:0BA4, 0x02CBA4
    LDA #$B4
    STA OBJ_ANIMATION_DISPLAY[18],X
    JSR XPOS_RTN_RET_??
    BCS L_16:0BCC
    LDA #$40
    JSR MOVE_UNK_RET_??
    BCC L_16:0BC9
    LDA #$00
    STA 4C6_OBJ_UNK[18],X
    STA 4D8_OBJ_UNK[18],X
    LDA L_16:0C35
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA L_16:0C36
    STA 532_OBJ_UNK_POS_DELTA?[18],X
L_16:0BC9: ; 16:0BC9, 0x02CBC9
    JMP MOVE_Y_FINALIZE
L_16:0BCC: ; 16:0BCC, 0x02CBCC
    JMP INIT_OBJECT[X]_DATA_FULL
    INX
    INX
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD
    LDA #$6F
    STA OBJ_ENABLED_STATE+MORE?[18],X
    LDA OBJ_STATE_DIR_RELATED_C[18],Y
    AND #$FC
    STA OBJ_STATE_DIR_RELATED_C[18],X
    LDA OBJ_POS_Y?[18],Y
    STA OBJ_POS_Y?[18],X
    LDA OBJ_POS_X?[18],Y
    STA TMP_00
    LDA OBJ_STATE_DIR_RELATED_C[18],X
    AND #$40
    LSR A
    LSR A
    LSR A
    LSR A
    TAY
    LDA L_16:0C37,Y
    CLC
    ADC TMP_00
    STA OBJ_POS_X?[18],X
    LDA L_16:0C38,Y
    CLC
    ADC 4C6_OBJ_UNK[18],X
    STA 4C6_OBJ_UNK[18],X
    LDA L_16:0C39,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA L_16:0C3A,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA L_16:0C33
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA L_16:0C34
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    STA OBJ_ANIMATION_DISPLAY[18],X
    STA OBJ_SECONDARY_SWITCH?[18],X
    JSR MOVE_Y_FINALIZE
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD
    RTS
L_16:0C33: ; 16:0C33, 0x02CC33
    .db 00
L_16:0C34: ; 16:0C34, 0x02CC34
    .db FC
L_16:0C35: ; 16:0C35, 0x02CC35
    .db 00
L_16:0C36: ; 16:0C36, 0x02CC36
    .db FD
L_16:0C37: ; 16:0C37, 0x02CC37
    .db 08
L_16:0C38: ; 16:0C38, 0x02CC38
    .db D0
L_16:0C39: ; 16:0C39, 0x02CC39
    .db 00
L_16:0C3A: ; 16:0C3A, 0x02CC3A
    .db 02
    .db F8
    .db D0
    .db 00
    .db FE
OBJ_STATE_0x4D_HANDLER: ; 16:0C3F, 0x02CC3F
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save to scratch.
    LDA 59E_OBJ_UNK/EXTRA_TIMER+1,X ; Load pair.
    BEQ PAIR_EQ_ZERO ; == 0, goto.
    DEC 59E_OBJ_UNK/EXTRA_TIMER+1,X ; --
PAIR_EQ_ZERO: ; 16:0C4A, 0x02CC4A
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load
    BEQ PAIR_EQ_ZERO_B ; == 0, goto.
    DEC STATUS_FLAGS_B/OBJ_FOCUS+1,X ; --
PAIR_EQ_ZERO_B: ; 16:0C52, 0x02CC52
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load pair.
    BEQ PAIR_EQ_ZERO_C ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; --, goto.
PAIR_EQ_ZERO_C: ; 16:0C5A, 0x02CC5A
    LDA #$12
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR ODD_MULTISWITCH ; Switch.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ RTS ; == 0, leave.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load health.
    PHA ; Save.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load pair.
    BEQ PAIR_VAL_ZERO ; == 0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
PAIR_VAL_ZERO: ; 16:0C75, 0x02CC75
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    STA TMP_00 ; Store result.
    PLA ; Pull health.
    LDY OBJECT_DATA_HEALTH?[18],X ; Load new.
    CPY #$FF ; If _ #$FF
    BNE HEALTH_NE_0xFF ; !=, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store prev.
HEALTH_NE_0xFF: ; 16:0C85, 0x02CC85
    LDA TMP_00 ; Load TMP.
    LSR A ; >> 1, /2.
    BCS DONT_LEAVE_YET ; Shifted off val, goto.
RTS: ; 16:0C8A, 0x02CC8A
    RTS ; Leave.
DONT_LEAVE_YET: ; 16:0C8B, 0x02CC8B
    JMP L_16:11FA ; Goto.
STATE/ANIM_HELPER: ; 16:0C8E, 0x02CC8E
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$40
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set anim stuff.
    LDA #$7A
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS ; Leave.
GRP_F_RTN_A: ; 16:0CA3, 0x02CCA3
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BNE RTS ; != 0, leave.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set disp.
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$2A
    JSR SND_BANKED_DISPATCH ; Play sound.
RTS: ; 16:0CBF, 0x02CCBF
    RTS ; Leave.
GRP_F_RTN_B: ; 16:0CC0, 0x02CCC0
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, leave.
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Next anim.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCS GTE_0x04 ; >=, goto.
RTS: ; 16:0CD9, 0x02CCD9
    RTS ; Leave.
GTE_0x04: ; 16:0CDA, 0x02CCDA
    JSR INIT_OBJECT[X]_DATA_FULL ; Clear obj.
    INX ; Pair.
    JSR INIT_OBJECT[X]_DATA_FULL ; Clear.
    DEX ; Back to base obj.
EXIT: ; 16:0CE2, 0x02CCE2
    JMP OBJ_REMOVE_FROM_GROUP_ARRAY ; Goto.
ODD_MULTISWITCH: ; 16:0CE5, 0x02CCE5
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    ASL A ; << 1, *2.
    TAY ; To index.
    LDA PTR_GRP_L,Y ; Move ptr.
    STA TMP_00
    LDA PTR_GRP_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA [TMP_00],Y ; Load from ptr.
    STA TMP_02 ; Move to ZP.
    INY ; Stream++
    LDA [TMP_00],Y ; Load from ptr.
    STA TMP_03 ; Move to ZP.
    JMP [TMP_02] ; Goto rtn.
PTR_GRP_L: ; 16:0D05, 0x02CD05
    LOW(PTR_GRP_A) ; PTR table.
PTR_GRP_H: ; 16:0D06, 0x02CD06
    HIGH(PTR_GRP_A)
    LOW(PTR_GRP_B)
    HIGH(PTR_GRP_B)
    LOW(PTR_GRP_C)
    HIGH(PTR_GRP_C)
    LOW(PTR_GRP_D)
    HIGH(PTR_GRP_D)
    LOW(PTR_GRP_E)
    HIGH(PTR_GRP_E)
    LOW(PTR_GRP_F)
    HIGH(PTR_GRP_F)
PTR_GRP_A: ; 16:0D11, 0x02CD11
    LOW(GRP_A_RTN_A)
    HIGH(GRP_A_RTN_A)
PTR_GRP_B: ; 16:0D13, 0x02CD13
    LOW(GRP_B_RTN_A)
    HIGH(GRP_B_RTN_A)
    LOW(GRP_B_RTN_B) ; Sus code, lol.
    HIGH(GRP_B_RTN_B)
    LOW(GRP_B_RTN_C)
    HIGH(GRP_B_RTN_C)
PTR_GRP_C: ; 16:0D19, 0x02CD19
    LOW(GRP_C_RTN_A)
    HIGH(GRP_C_RTN_A)
    LOW(GRP_C_RTN_B)
    HIGH(GRP_C_RTN_B)
    LOW(GRP_C_RTN_C)
    HIGH(GRP_C_RTN_C)
PTR_GRP_D: ; 16:0D1F, 0x02CD1F
    LOW(GRP_D_RTN_A)
    HIGH(GRP_D_RTN_A)
PTR_GRP_E: ; 16:0D21, 0x02CD21
    LOW(GRP_E_RTN_A)
    HIGH(GRP_E_RTN_A)
PTR_GRP_F: ; 16:0D23, 0x02CD23
    LOW(GRP_F_RTN_A)
    HIGH(GRP_F_RTN_A)
    LOW(GRP_F_RTN_B)
    HIGH(GRP_F_RTN_B)
GRP_A_RTN_A: ; 16:0D27, 0x02CD27
    LDA #$CE
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$CF
    STA ZP_R2-R5_BANK_VALUES+3
    LDY #$1D
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Set palette.
    LDA #$4E
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair state.
    LDA #$08
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA #$09
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set anim hold.
    JSR ANIM_SOLVER_HELPER ; Anim.
    JSR MOVE_Y_FINALIZE ; Goto Yobj.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load count.
    AND #$02 ; Keep bit.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to.
    JSR XOBJ_MANIP_BASED_ON_LIVES_UNK ; Manip.
    INC 716_UNK ; ++
    LDA 716_UNK ; Load
    AND #$01 ; Keep bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr with.
    JSR ADD_OBJ_TO_717-719_ARRS ; Do.
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If handling _ 719
    BNE NOT_SLOT_719 ; !=, goto.
    LDA #$02
    STA OBJECT_DATA_EXTRA_B?+1,X ; Set pair val.
NOT_SLOT_719: ; 16:0D6B, 0x02CD6B
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    RTS ; Leave.
GRP_B_RTN_A: ; 16:0D6F, 0x02CD6F
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    RTS ; Leave.
GRP_B_RTN_B: ; 16:0D78, 0x02CD78
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load.
    BNE VAL_NONZERO ; != 0, goto.
    LDA #$01
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Set attr.
VAL_NONZERO: ; 16:0D87, 0x02CD87
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y ; Move attrs.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    .db FE ; INC XOBJ.tert. Not marked because of label in middle of inst.
    .db 8C
OBJ_DATA_A: ; 16:0D97, 0x02CD97
    .db 05
OBJ_DATA_B: ; 16:0D98, 0x02CD98
    .db 60 ; Leave.
    .db 00 ; Data used from data labels. Wtf is this lol.
    .db FF
    .db 00
    .db 01
GRP_B_RTN_C: ; 16:0D9D, 0x02CD9D
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    JSR ANIM_SOLVER_HELPER ; Solve anim.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Do.
    JSR XPOS_RTN_RET_?? ; Do.
    BCS EXIT_CLEAR_FLAG ; CS, goto.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE RTS ; != 0, leave.
    LDA OBJ_POS_X?[18],X ; Load
    CMP #$28 ; If _ #$28
    BCC RTS ; <, leave.
    CMP #$D8 ; If _ #$28
    BCS RTS ; >=, leave.
    JSR STATE_MOVE_HELPER_S0x02_T0x01 ; Do.
EXIT_CLEAR_FLAG: ; 16:0DC0, 0x02CDC0
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear.
RTS: ; 16:0DC5, 0x02CDC5
    RTS ; Leave.
ANIM_SOLVER_HELPER: ; 16:0DC6, 0x02CDC6
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; Hold--
    BPL HOLD_POSITIVE
    LDA #$09
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Step++
HOLD_POSITIVE: ; 16:0DD3, 0x02CDD3
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Get step.
    AND #$01 ; Keep bit.
    TAY ; To Y index.
    LDA ANIM_DATA_ARR,Y ; Load anim.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set.
    RTS ; Leave.
ANIM_DATA_ARR: ; 16:0DE0, 0x02CDE0
    .db 72
    .db 73
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$20
    STA OBJECT_DATA_HEALTH?+1,X
RTS: ; 16:0DF1, 0x02CDF1
    RTS
GRP_C_RTN_A: ; 16:0DF2, 0x02CDF2
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    DEC OBJECT_DATA_HEALTH?+1,X ; Pair health?
    BNE RTS ; != 0, leave. Move state if so.
STATE_MOVE_HELPER_S0x02_T0x01: ; 16:0DFC, 0x02CDFC
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
GRP_C_RTN_B: ; 16:0E07, 0x02CE07
    JSR XOBJ_MANIP_BASED_ON_LIVES_UNK ; Do.
    JSR XOBJ_TO_717_SLOTS_CC_FAIL_CS_OKAY ; To slot.
    JSR FIND_GROUP_SLOT_XOBJ_IN
    JSR SLOT_MATTERS_HIT_DETECT/ATTRS? ; Do.
    JSR RTN_BOX_DETECT? ; Do.
    LDA TMP_11 ; Load
    CMP #$08 ; If _ #$08
    BCC LT_0x08 ; <, goto.
    JMP 16:0E81 ; Goto.
LT_0x08: ; 16:0E1F, 0x02CE1F
    LDA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Load pair.
    BNE PAIR_NONZERO ; != 0, goto.
    LDA TMP_10 ; Load
    CMP #$20 ; If _ #$20
    BCS PAIR_NONZERO ; >=, goto.
    JMP 16:0EB2 ; Goto.
PAIR_NONZERO: ; 16:0E2D, 0x02CE2D
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load
    ASL A ; << 1, *2.
    BNE VAL_NONZERO ; != 0, goto. Very rare to run this code.
    ROL A ; << 1.
    EOR 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Eor val.
    LSR A ; >> 1.
    BCS VAL_NONZERO ; Carry set, still do nothing. Half odds of chance.
    JSR COUNTER_RANDOMNESS_BAD ; Random.
    AND #$01 ; Keep bit.
    BNE VAL_NONZERO ; If set, still skip.
    LDA TMP_10 ; Load val.
    CMP #$30 ; If _ #$30
    BCS GTE_0x30 ; >=, goto.
    BCC LT_0x30 ; <, goto.
VAL_NONZERO: ; 16:0E48, 0x02CE48
    LDA OBJ_POS_X?[18],X ; Load
    CMP #$DC ; If _ #$DC
    BCC LT_0xDC ; <, goto.
    JMP ENTRY_Y_0x02 ; Goto.
LT_0xDC: ; 16:0E52, 0x02CE52
    LDA OBJ_POS_X?[18],X ; Load
    CMP #$24 ; If _ #$24
    BCS GTE_0x24 ; >=, goto.
    JMP ENTRY_Y_0x04 ; Goto.
GTE_0x24: ; 16:0E5C, 0x02CE5C
    JMP 16:0E81 ; Goto.
GTE_0x30: ; 16:0E5F, 0x02CE5F
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Yobj from.
    LDA OBJ_POS_X?[18],X ; Load
    CMP OBJ_POS_X?[18],Y ; If _ other OBJ.
    BCC LT_OTHER_OBJECT ; <, goto.
    JMP ENTRY_Y_0x02 ; Entry.
LT_OTHER_OBJECT: ; 16:0E6D, 0x02CE6D
    JMP ENTRY_Y_0x04 ; Entry.
LT_0x30: ; 16:0E70, 0x02CE70
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from.
    LDA OBJ_POS_X?[18],X ; Load from.
    CMP OBJ_POS_X?[18],Y ; If _ Other obj.
    BCS ALT_ENTRY ; >=, goto.
    JMP ENTRY_Y_0x02 ; Goto.
ALT_ENTRY: ; 16:0E7E, 0x02CE7E
    JMP ENTRY_Y_0x04 ; Goto.
    CPX OBJ_INDEXES_GROUP_UNK+2
    BNE 16:0EA3
    LDA OBJ_POS_X_DELTA?[18],X
    ORA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    ORA 503_OBJ_POS_X_LARGEST?[18],X
    ORA 520_OBJ_POS_X_LARGE?[18],X
    BNE 16:0EA3
    INC OBJECT_DATA_EXTRA_B?+1,X
    LDA OBJECT_DATA_EXTRA_B?+1,X
    CMP #$08
    BCC 16:0EA3
    LDA #$02
    STA OBJECT_DATA_EXTRA_B?+1,X
    JSR MOVE?_AND_RANGE_OBJ
    JSR RTN_MOVE/POS_UNK
    JSR ANIM_SOLVER_HELPER
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK
    JMP MOVE_Y_FINALIZE
    LDA #$03
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$00
    STA OBJECT_DATA_HEALTH?+1,X
    RTS
GRP_D_RTN_A: ; 16:0EC2, 0x02CEC2
    INC OBJECT_DATA_HEALTH?+1,X ; Pair++
    LDY OBJECT_DATA_HEALTH?+1,X ; Load from pair.
    CPY #$14 ; If _ #$14
    BCS GTE_0x14
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load val.
    AND #$07 ; Keep 0000.0111
    BNE SKIP_MOVE ; 1 in 8 chance to not take.
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load
    ASL A ; << 2, 84.
    ASL A
    LDA #$FF ; Seed val.
    BCC USE_VAL
    LDA #$00 ; Seed other.
USE_VAL: ; 16:0EDD, 0x02CEDD
    ADC OBJ_POS_X?[18],X ; Add to.
    STA OBJ_POS_X?[18],X ; Store.
SKIP_MOVE: ; 16:0EE3, 0x02CEE3
    LDA #$77 ; Val.
    CPY #$09 ; If Y _ #$09
    BCC USE_AS_ANIM ; <, goto.
    LDA #$78 ; Val.
    CPY #$0E ; If _ #$0E
    BCS USE_AS_ANIM ; >=, goto.
    LDA #$B8
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$78 ; Val.
USE_AS_ANIM: ; 16:0EF6, 0x02CEF6
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
GTE_0x14: ; 16:0EFA, 0x02CEFA
    LDA #$28
    STA STATUS_FLAGS_B/OBJ_FOCUS+1,X ; Set pair attr.
    JMP STATE_MOVE_HELPER_S0x02_T0x01 ; Move state.
ADD_OBJ_TO_717-719_ARRS: ; 16:0F02, 0x02CF02
    LDA OBJ_INDEXES_GROUP_UNK[3] ; Load
    BNE OCCUPADO_A ; Occupied.
    STX OBJ_INDEXES_GROUP_UNK[3] ; Save to slot.
    RTS ; Leave.
OCCUPADO_A: ; 16:0F0B, 0x02CF0B
    LDA OBJ_INDEXES_GROUP_UNK+1 ; Load
    BNE OCCUPADO_B ; Occupied.
    STX OBJ_INDEXES_GROUP_UNK+1 ; Save to slot.
    RTS ; Lave.
OCCUPADO_B: ; 16:0F14, 0x02CF14
    STX OBJ_INDEXES_GROUP_UNK+2 ; Save to.
    RTS ; Leave.
FIND_GROUP_SLOT_XOBJ_IN: ; 16:0F18, 0x02CF18
    LDY #$00 ; Obj start?
    CPX OBJ_INDEXES_GROUP_UNK[3] ; If _ Slot[0]
    BEQ Y_TO_VAR ; ==, goto.
    INY ; Obj++
    CPX OBJ_INDEXES_GROUP_UNK+1 ; Compare to other slot.
    BEQ Y_TO_VAR ; ==, goto.
    INY ; Obj++
Y_TO_VAR: ; 16:0F26, 0x02CF26
    STY A/B_WHICH_RESULT ; Which slot matched to here.
    RTS ; Leave.
OBJ_REMOVE_FROM_GROUP_ARRAY: ; 16:0F2A, 0x02CF2A
    LDA #$00 ; Clear val.
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ Slot
    BNE CHECK_XOBJ_SLOT[1] ; !=, goto.
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear slot.
    RTS ; Leave.
CHECK_XOBJ_SLOT[1]: ; 16:0F35, 0x02CF35
    CPX OBJ_INDEXES_GROUP_UNK+1 ; If Xobj _ Slot
    BNE CHECK_XOBJ_SLOT[0] ; !=, goto.
    LDY OBJ_INDEXES_GROUP_UNK+2 ; Load other.
    BNE CLEAR_SLOT[2]_STORE_SLOT[1] ; != 0, goto. Move down.
    LDY OBJ_INDEXES_GROUP_UNK[3] ; Load from Slot[0]
    BEQ CLEAR_SLOT_0x01 ; == 0, goto.
    STY OBJ_INDEXES_GROUP_UNK+1 ; Store to slot[1]
    STA OBJ_INDEXES_GROUP_UNK[3] ; Clear slot[0]
    JMP RTS ; Leave. Bad code, just RTS here.
CLEAR_SLOT_0x01: ; 16:0F4D, 0x02CF4D
    STA OBJ_INDEXES_GROUP_UNK+1 ; Clear
    RTS
CLEAR_SLOT[2]_STORE_SLOT[1]: ; 16:0F51, 0x02CF51
    STY OBJ_INDEXES_GROUP_UNK+1 ; Store to slot[1]
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear slot[2]
    JMP RTS ; Leave. Bad code, just RTS here.
CHECK_XOBJ_SLOT[0]: ; 16:0F5A, 0x02CF5A
    CPX OBJ_INDEXES_GROUP_UNK[3] ; If  Xobj _ Slot[0]
    BNE RTS ; !=, leave.
    LDY OBJ_INDEXES_GROUP_UNK+2 ; Load from slot.
    BNE CLEAR_SLOT[2]_STORE_SLOT[0] ; Has val, goto. Move down.
    STA OBJ_INDEXES_GROUP_UNK[3] ; Clear slot no move.
    RTS
CLEAR_SLOT[2]_STORE_SLOT[0]: ; 16:0F68, 0x02CF68
    STY OBJ_INDEXES_GROUP_UNK[3] ; Obj move down.
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear slot.
RTS: ; 16:0F6E, 0x02CF6E
    RTS ; Leave.
XOBJ_TO_717_SLOTS_CC_FAIL_CS_OKAY: ; 16:0F6F, 0x02CF6F
    CPX OBJ_INDEXES_GROUP_UNK+2 ; If Xobj _ Slot
    BNE RET _CC ; !=, goto.
    LDA OBJ_INDEXES_GROUP_UNK[3] ; Load slot.
    BEQ XOBJ_TO_717 ; == 0, goto.
    LDA OBJ_INDEXES_GROUP_UNK+1 ; Load slot.
    BNE RET _CC ; Slot nonzero, goto.
    STX OBJ_INDEXES_GROUP_UNK+1 ; Xobj to slot.
    JMP CLEAR_719_RTS_CS
XOBJ_TO_717: ; 16:0F84, 0x02CF84
    STX OBJ_INDEXES_GROUP_UNK[3] ; X to slot.
CLEAR_719_RTS_CS: ; 16:0F87, 0x02CF87
    LDA #$00
    STA OBJ_INDEXES_GROUP_UNK+2 ; Clear slot.
    SEC ; CS RTS.
    RTS
RET _CC: ; 16:0F8E, 0x02CF8E
    CLC ; CC RTS.
    RTS
OBJ_STATE_0x4E_HANDLER: ; 16:0F90, 0x02CF90
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; From Obj[17]
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; To handling.
    LDA OBJ_POS_Y+17,X
    STA OBJ_POS_X?[18],X ; To handling.
    LDA OBJ_POS_X_SUBPIXEL?+17,X
    STA OBJ_POS_Y?[18],X ; To handling.
    STA OBJ_POS_Y[18],X ; To this also.
    LDA #$00 ; Prep val.
    LDY 4B4_OBJ_SPEED?+17,X ; Load
    BPL ANIM_SEEDED ; If positive, skip reseed.
    LDA #$04 ; Reseed value.
ANIM_SEEDED: ; 16:0FAE, 0x02CFAE
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set animation.
    RTS
OBJ_STATE_0x4F_HANDLER: ; 16:0FB2, 0x02CFB2
    JSR XPOS_RTN_RET_?? ; Do.
    BCS EXIT_OBJ_DESTROY ; CS, goto.
    JSR MOVE?_RTN_IDK ; Do.
    BCS EXIT_OBJ_DESTROY ; CS, goto.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA #$B9
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    LSR A ; >> 2, /4.
    LSR A
    BCS EXIT_OBJ_DESTROY ; CS, goto.
    RTS ; Leave.
EXIT_OBJ_DESTROY: ; 16:0FD1, 0x02CFD1
    JMP INIT_OBJECT[X]_DATA_FULL ; Init.
ENTRY_Y_0x00: ; 16:0FD4, 0x02CFD4
    LDY #$00
    JMP INDEX_SEEDED
ENTRY_Y_0x02: ; 16:0FD9, 0x02CFD9
    LDY #$02
    JMP INDEX_SEEDED
ENTRY_Y_0x04: ; 16:0FDE, 0x02CFDE
    LDY #$04
INDEX_SEEDED: ; 16:0FE0, 0x02CFE0
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set attrs.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_DATA_C
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_D
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    CLC ; Prep add.
    LDA #$FB ; -= 5 signed.
    ADC 4C6_OBJ_UNK[18],X ; Add to.
    STA 4C6_OBJ_UNK[18],X ; Store to.
    LDA #$00
    STA OBJ_ANIM_HOLD_TIMER?+1,X ; Clear pair hold.
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Clear pair step.
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X
    RTS ; Leave.
OBJ_DATA_C: ; 16:1014, 0x02D014
    .db 00
OBJ_DATA_D: ; 16:1015, 0x02D015
    .db FC
OBJ_DATA_A: ; 16:1016, 0x02D016
    .db 00
OBJ_DATA_B: ; 16:1017, 0x02D017
    .db 00
    .db 00
    .db FE
    .db 00
    .db 02
GRP_C_RTN_C: ; 16:101C, 0x02D01C
    JSR MOVE?_AND_RANGE_OBJ
    LDA #$18
    JSR MOVE_UNK_RET_?? ; Move.
    BCS RET_CS ; CS, goto.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    INC OBJ_ANIM_HOLD_TIMER?+1,X ; Hold pair.
    JSR PAIR_HOLD_TIMEOUT_RTN ; Do.
    LDA #$74 ; Anim val.
    LDY 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; Y from pair.
    BEQ PAIR_STEP_0x00 ; == 0, goto.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,X ; --
    LDA #$75 ; Alt anim.
PAIR_STEP_0x00: ; 16:103B, 0x02D03B
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
RET_CS: ; 16:1041, 0x02D041
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; Clear attr.
    JSR MOVE_Y_FINALIZE ; Do.
    JMP STATE_MOVE_HELPER_S0x02_T0x01 ; Move state.
PAIR_HOLD_TIMEOUT_RTN: ; 16:104C, 0x02D04C
    LDA OBJ_ANIM_HOLD_TIMER?+1,X ; Load hold.
    CMP #$23 ; If _ #$23
    BEQ PAIR_HOLD_TIMEOUT ; ==, goto.
    RTS ; Leave if not.
PAIR_HOLD_TIMEOUT: ; 16:1054, 0x02D054
    JSR QUERY_OBJ_UNUSED_CS_TRUE_CC_FALSE ; Do.
    BCS OBJ_RECEIVED ; Received, goto.
    JMP EXIT_XOBJ_RESTORE ; Leave, none available.
OBJ_RECEIVED: ; 16:105C, 0x02D05C
    LDA #$0D
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Obj from scratch. Bad code/mistake, not used and destroyed.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Load from new obj. TODO: Mistake?
    TAY ; To Yobj.
    LDA OBJ_POS_X?[18],Y ; Load from Yobj.
    STA TMP_0C ; Store to.
    LDA OBJ_POS_Y[18],Y ; Load from Yobj.
    STA TMP_0D ; Store to.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Y from.
    LDA #$07
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?+1,Y ; Set pair step.
    LDA OBJ_POS_X?[18],Y ; Load from handling.
    STA TMP_00 ; Save.
    LDA OBJ_POS_Y?[18],Y ; Move from handling to new.
    STA OBJ_POS_Y?[18],X
    INC OBJ_POS_Y?[18],X ; Inc new.
    LDA 4C6_OBJ_UNK[18],Y ; Load handling.
    STA TMP_02 ; Save.
    LDA OBJ_STATE_DIR_RELATED_C[18],Y ; Load handling.
    ASL A ; << 2, *4.
    ASL A
    LDA #$00 ; Seed vals.
    LDY #$00
    BCC SHIFT_CC ; CC, goto.
    LDY #$02 ; Alt vals.
    ORA #$40
SHIFT_CC: ; 16:109C, 0x02D09C
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store to new.
    CLC ; Prep add.
    LDA OBJ_MOD_A,Y ; Load val.
    ADC TMP_00 ; Add with saved.
    STA OBJ_POS_X?[18],X ; Store to new.
    CLC ; Prep add.
    LDA OBJ_MOD_B,Y ; Load val.
    ADC TMP_02 ; Add with saved.
    STA 4C6_OBJ_UNK[18],X ; Store to new.
    JSR MOVE_Y_FINALIZE ; Move new.
    LDA OBJ_POS_X?[18],X ; Load new.
    STA TMP_0E ; Store to.
    LDA OBJ_POS_Y[18],X ; Load new.
    STA TMP_0F ; Store to.
    LDY #$03 ; Val?
    JSR 16:129B ; Do ??
    CLC ; Prep add.
    ADC #$02 ; Add with.
    LSR A ; >> 2, /4.
    LSR A
    AND #$03 ; Keep bits.
    TAY ; To Y index.
    LDA OBJ_DATA_A,Y ; Load from index.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set new attrs.
    LDA TMP_08
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Move from TMP to new.
    LDA TMP_09
    STA OBJ_POS_X_DELTA?[18],X
    LDA TMP_0A
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA TMP_0B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA TMP_09
    LSR A ; >> 1, /2.
    EOR OBJ_STATE_DIR_RELATED_C[18],X ; Eor with.
    ASL A ; << 1, *2.
    BMI DONT_INVERT ; Negative, goto.
    SEC ; Prep sub.
    LDA #$00 ; Invert seed.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Invert.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Save.
    LDA #$00 ; Invert seed.
    SBC OBJ_POS_X_DELTA?[18],X ; Invert.
    STA OBJ_POS_X_DELTA?[18],X ; Save.
DONT_INVERT: ; 16:10FF, 0x02D0FF
    LDA 532_OBJ_UNK_POS_DELTA?[18],X ; Load from new.
    BPL SKIP_INVERT ; If positive, goto.
    SEC ; Prep sub.
    LDA #$00 ; Seed invert.
    SBC 544_OBJ_UNK_POS_DELTA?[18],X ; Invert.
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Save.
    LDA #$00 ; Seed invert.
    SBC 532_OBJ_UNK_POS_DELTA?[18],X ; Invert.
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Save.
SKIP_INVERT: ; 16:1115, 0x02D115
    LDA #$4F
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Enable state.
EXIT_XOBJ_RESTORE: ; 16:111A, 0x02D11A
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Restore from scratch.
    RTS ; Leave.
OBJ_MOD_A: ; 16:111E, 0x02D11E
    .db EC
OBJ_MOD_B: ; 16:111F, 0x02D11F
    .db EA
    .db 14
    .db EA
OBJ_DATA_A: ; 16:1122, 0x02D122
    .db AB
    .db 76
    .db AA
    .db 76
SLOT_MATTERS_HIT_DETECT/ATTRS?: ; 16:1126, 0x02D126
    LDA A/B_WHICH_RESULT ; Get slot caring for.
    CMP #$02 ; If _ #$02
    BNE NE_TWO ; !=, goto.
    LDA OBJECT_DATA_EXTRA_B?+1,X ; Load pair data.
NE_TWO: ; 16:1130, 0x02D130
    ASL A ; << 2, *4.
    ASL A
    TAY ; To Y index.
    LDA TMP_DATA_A,Y ; Set up TMP.
    STA TMP_14
    LDA TMP_DATA_B,Y
    STA TMP_15
    LDA UNK_DATA,Y ; Load val.
    BNE VAL_NONZERO ; != 0, goto.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    CLC ; Pre padd.
    LDA OBJ_POS_X?[18],Y ; Load from Yobj.
    ADC TMP_14 ; Add with.
    PHA ; Save.
    ROR A ; >> val.
    EOR TMP_14 ; Eor with.
    ASL A ; << val.
    PLA ; Pull added val.
    BCC SHIFT_CC ; CC, goto.
    ASL TMP_14 ; << 1, *2.
    LDA #$10 ; Load val.
    BCS SHIFT_CC ; Use if CS.
    LDA #$F0 ; Otherwise, this.
SHIFT_CC: ; 16:115B, 0x02D15B
    STA TMP_14 ; Store to.
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    LDA OBJ_POS_Y?[18],Y ; Load from Yobj.
    STA TMP_15 ; Store to.
VAL_NONZERO: ; 16:1165, 0x02D165
    JSR HIT_DETECT_HELPER_UNK ; Help.
    LDY #$00 ; Index.
    LDA TMP_10 ; Load
    CMP #$02 ; If _ #$02
    BCC INDEX_USE ; <, goto.
    LDY #$02 ; Index.
    LDA OBJ_POS_X?[18],X ; Load
    CMP TMP_14 ; If _ TMP.
    BCS INDEX_USE ; >=, goto.
    LDY #$04 ; Last index.
INDEX_USE: ; 16:117B, 0x02D17B
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Move attrs from index data.
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDY #$00 ; Index.
    LDA TMP_11 ; Load.
    CMP #$06 ; If _ #$06
    BCC INDEX_USE_B
    LDY #$02 ; Index.
    LDA TMP_13 ; Load val.
    BPL INDEX_USE_B ; Positive, goto.
    LDY #$04 ; Index.
INDEX_USE_B: ; 16:1197, 0x02D197
    LDA OBJ_DATA_A,Y
    STA 520_OBJ_POS_X_LARGE?[18],X ; Move attrs.
    LDA OBJ_DATA_B,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS ; Leave.
OBJ_DATA_A: ; 16:11A4, 0x02D1A4
    .db 00
OBJ_DATA_B: ; 16:11A5, 0x02D1A5
    .db 00
    .db 40
    .db FF
    .db C0
    .db 00
OBJ_DATA_A: ; 16:11AA, 0x02D1AA
    .db 00
OBJ_DATA_B: ; 16:11AB, 0x02D1AB
    .db 00
    .db 60
    .db FF
    .db A0
    .db 00
UNK_DATA: ; 16:11B0, 0x02D1B0
    .db 00
    .db 00
TMP_DATA_A: ; 16:11B2, 0x02D1B2
    .db E2
TMP_DATA_B: ; 16:11B3, 0x02D1B3
    .db 00
    .db 00
    .db 00
    .db 1E
    .db 00
    .db 01
    .db 00
    .db 16
    .db A0
    .db 01
    .db 00
    .db 60
    .db E0
    .db 01
    .db 00
    .db C0
    .db B0
    .db 01
    .db 00
    .db E8
    .db B0
    .db 01
    .db 00
    .db 16
    .db E0
    .db 01
    .db 00
    .db 80
    .db B0
MOVE?_AND_RANGE_OBJ: ; 16:11D0, 0x02D1D0
    JSR XPOS_RTN_RET_?? ; Do.
    LDA #$10 ; Load
    CMP OBJ_POS_X?[18],X ; If _ attr
    BCS VAL_SEEDED ; >=, goto.
    LDA #$F0 ; Load
    CMP OBJ_POS_X?[18],X ; If _ #$F0
    BCS RTS ; >=, goto.
VAL_SEEDED: ; 16:11E1, 0x02D1E1
    STA OBJ_POS_X?[18],X ; Range.
RTS: ; 16:11E4, 0x02D1E4
    RTS ; Leave.
RTN_MOVE/POS_UNK: ; 16:11E5, 0x02D1E5
    JSR MOVE_UNK_RET_?? ; dO.
    LDA #$78 ; Seed val.
    CMP OBJ_POS_Y?[18],X ; If seed _ attr
    BCS WRITE_SEED ; >, write val.
    LDA #$E4 ; Alt seed.
    CMP OBJ_POS_Y?[18],X ; If seed _ attr.
    BCS RTS ; >=, leave.
WRITE_SEED: ; 16:11F6, 0x02D1F6
    STA OBJ_POS_Y?[18],X ; Store val.
RTS: ; 16:11F9, 0x02D1F9
    RTS ; Leave.
L_16:11FA: ; 16:11FA, 0x02D1FA
    JSR XOBJ_WRITE_UNK
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDA OBJ_STATE_DIR_RELATED_C[18],Y
    ASL A
    ASL A
    LDY #$00
    BCS 16:1215
    LDY #$02
    LDA OBJ_STATE_DIR_RELATED_C[18],X
    AND #$BF
    BCC 16:121E
    ORA #$40
    STA OBJ_STATE_DIR_RELATED_C[18],X
    LDA OBJ_DATA_A,Y
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA OBJ_DATA_C
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA OBJ_DATA_D
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    CLC
    LDA 4C6_OBJ_UNK[18],X
    ADC #$FB
    CMP #$81
    BCS 16:1245
    LDA #$81
    STA 4C6_OBJ_UNK[18],X
    LDA #$79
    STA OBJ_ANIMATION_DISPLAY[18],X
    LDA #$2B
    JMP SND_BANKED_DISPATCH
OBJ_DATA_A: ; 16:1252, 0x02D252
    .db 00
OBJ_DATA_B: ; 16:1253, 0x02D253
    .db FE
    .db 00
    .db 02
OBJ_DATA_C: ; 16:1256, 0x02D256
    .db 00
OBJ_DATA_D: ; 16:1257, 0x02D257
    .db FD
GRP_E_RTN_A: ; 16:1258, 0x02D258
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear extra.
    JSR MOVE?_AND_RANGE_OBJ ; Range.
    LDA #$20
    JSR MOVE_UNK_RET_?? ; Do.
    BCS CS_RET ; Ret CS, goto.
    LDA 4C6_OBJ_UNK[18],X ; Load attr.
    CMP #$81 ; If _ #$81
    BCS GTE_0x81 ; >=, goto.
    LDA #$81 ; Load val. Minimum.
    STA 4C6_OBJ_UNK[18],X ; Set.
GTE_0x81: ; 16:1273, 0x02D273
    JSR MOVE_Y_FINALIZE ; Do.
    LDA OBJ_POS_Y[18],X ; Load
    CMP #$40 ; If _ #$40
    BCS RTS ; >=, goto.
    LDA #$40 ; Minimum.
    STA OBJ_POS_Y[18],X ; Set.
RTS: ; 16:1282, 0x02D282
    RTS ; Leave.
CS_RET: ; 16:1283, 0x02D283
    LDA #$00
    STA 4C6_OBJ_UNK[18],X ; CAlear.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load health.
    BNE HEALTH_NONZERO ; != 0, goto.
    JMP STATE/ANIM_HELPER ; Goto.
HEALTH_NONZERO: ; 16:1293, 0x02D293
    LDA #$10
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Set pair.
    JMP STATE_MOVE_HELPER_S0x02_T0x01 ; Goto.
    TYA
    PHA
    JSR L_16:12AA
    PLA
    TAY
    LDA TMP_00
    PHA
    JSR L_16:134D
    PLA
    RTS
L_16:12AA: ; 16:12AA, 0x02D2AA
    LDY #$00
    LDA TMP_0C
    SEC
    SBC TMP_0E
    BCS 16:12B8
    EOR #$FF
    ADC #$01
    INY
    STA TMP_00
    LDA TMP_0D
    SEC
    SBC TMP_0F
    BCS 16:12C7
    EOR #$FF
    ADC #$01
    INY
    INY
    STA TMP_01
    STY TMP_04
    LDY TMP_01
    LDA TMP_00
    CMP TMP_01
    BCS 16:12D4
    TYA
    CMP #$08
    BCC 16:12E0
    LSR A
    LSR TMP_00
    LSR TMP_01
    JMP 16:12D4
    LDA TMP_01
    ASL A
    ASL A
    ASL A
    ADC TMP_00
    TAY
    LDA 16:1309,Y
    STA TMP_00
    LDY TMP_04
    INC TMP_04
    LDA TMP_04
    AND #$02
    BEQ 16:12FE
    SEC
    LDA #$08
    SBC TMP_00
    STA TMP_00
    CLC
    LDA 16:1349,Y
    ADC TMP_00
    AND #$1F
    STA TMP_00
    RTS
    .db 04
    .db 02
    .db 01
    .db 01
    .db 01
    .db 00
    .db 00
    .db 00
    .db 06
    .db 04
    .db 03
    .db 02
    .db 02
    .db 01
    .db 01
    .db 01
    .db 07
    .db 05
    .db 04
    .db 03
    .db 03
    .db 02
    .db 02
    .db 02
    .db 07
    .db 06
    .db 05
    .db 04
    .db 03
    .db 03
    .db 03
    .db 02
    .db 07
    .db 06
    .db 05
    .db 05
    .db 04
    .db 03
    .db 03
    .db 03
    .db 08
    .db 07
    .db 06
    .db 05
    .db 05
    .db 04
    .db 04
    .db 03
    .db 08
    .db 07
    .db 06
    .db 05
    .db 05
    .db 06
    .db 04
    .db 04
    .db 08
    .db 07
    .db 06
    .db 06
    .db 05
    .db 05
    .db 04
    .db 04
    .db 00
    .db 08
    .db 18
    .db 10
L_16:134D: ; 16:134D, 0x02D34D
    PHA
    STY TMP_07
    JSR 16:13BF
    LDA TMP_00
    STA TMP_08
    LDA TMP_01
    STA TMP_09
    LDY TMP_07
    PLA
    PHA
    JSR 16:136C
    LDA TMP_00
    STA TMP_0A
    LDA TMP_01
    STA TMP_0B
    PLA
    RTS
    STY TMP_03
    LDY #$00
    STY TMP_00
    STY TMP_01
    PHA
    AND #$0F
    CMP #$08
    BNE 16:1382
    LDY TMP_03
    STY TMP_01
    JMP 16:139C
    TAY
    LDA 16:13AF,Y
    LDY #$07
    ASL TMP_00
    ROL TMP_01
    ASL TMP_03
    BCC 16:1399
    CLC
    ADC TMP_00
    STA TMP_00
    BCC 16:1399
    INC TMP_01
    DEY
    BPL 16:1388
    PLA
    AND #$10
    BEQ 16:13AE
    SEC
    LDA #$00
    SBC TMP_00
    STA TMP_00
    LDA #$00
    SBC TMP_01
    STA TMP_01
    RTS
    .db 00
    .db 32
    .db 62
    .db 8E
    .db B5
    .db D5
    .db ED
    .db FB
    .db 00
    .db FB
    .db ED
    .db D5
    .db B5
    .db 8E
    .db 62
    .db 32
    CLC
    ADC #$08
    AND #$1F
    JMP 16:136C
OBJ_STATE_0x4A_HANDLER: ; 16:13C7, 0x02D3C7
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; Move attrs from Obj[17]
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store as diff?
    LDA OBJ_POS_Y+17,X
    STA OBJ_POS_X?[18],X ; Store to.
    LDA OBJ_POS_X_SUBPIXEL?+17,X
    STA OBJ_POS_Y?[18],X ; Store to.
    STA OBJ_POS_Y[18],X ; Also store here.
    LDA #$00 ; Anim seed.
    LDY 4B4_OBJ_SPEED?+17,X ; Load from Obj[17]
    BPL ANIMATION_SEEDED_IN_A ; Positive, no change.
    CPY #$FB ; If _ #$FB
    BCS ANIMATION_SEEDED_IN_A ; >=, goto. No change.
    LDA #$04 ; Mod seed.
ANIMATION_SEEDED_IN_A: ; 16:13E9, 0x02D3E9
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set display.
    RTS ; Leave.
OBJ_STATE_0x49_HANDLER: ; 16:13ED, 0x02D3ED
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Save Xobj.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load attr.
    BEQ ATTR_EQ_ZERO ; == 0, goto.
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; --
ATTR_EQ_ZERO: ; 16:13F8, 0x02D3F8
    LDA #$C2 ; Attr seed.
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Val test.
    BPL USE_A_SEED ; Positive, goto.
    LDA #$16 ; Alt attr.
USE_A_SEED: ; 16:1401, 0x02D401
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR ODD_SECONDARY_TERT_RUNNER_MULTISWITCH ; Do.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE GOTO_ATTR_THING ; != 0, goto.
    LDA OBJECT_DATA_EXTRA_B?[18],X ; Load
    BEQ GOTO_ATTR_THING ; == 0, goto.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    PHA ; Save.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Load Xobj.
    BEQ VAL_EQ_ZERO_B ; == 0, goto.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
VAL_EQ_ZERO_B: ; 16:141F, 0x02D41F
    JSR OBJ_RTN_UNK_RET_VAL_UNK ; Do.
    STA TMP_00 ; Store result.
    PLA ; Pull health.
    LDY OBJECT_DATA_HEALTH?[18],X ; Load attr.
    CPY #$FF ; If val _ #$FF
    BNE VAL_NE_0xFF ; !=, goto.
    STA OBJECT_DATA_HEALTH?[18],X ; Store if not.
VAL_NE_0xFF: ; 16:142F, 0x02D42F
    LSR TMP_00 ; >> 1, /2.
    BCS SHIFTED_RESULT_CS ; CS, goto.
GOTO_ATTR_THING: ; 16:1433, 0x02D433
    JMP PAIR_ATTRS_AND_HANDLING_STUFF ; Do.
SHIFTED_RESULT_CS: ; 16:1436, 0x02D436
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ASL A ; << 1, *2.
    LDA #$2B ; Val.
    BCC USE_A_VAL_SOUND ; CC, goto.
    LDA #$2C ; Alt val.
USE_A_VAL_SOUND: ; 16:1440, 0x02D440
    JSR SND_BANKED_DISPATCH ; Play sound.
    JMP LINE_BELOW ; Make sure we get there, lol.
LINE_BELOW: ; 16:1446, 0x02D446
    JSR XOBJ_WRITE_UNK ; Do.
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA ROM_VAL_A ; Move attrs from ROM.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA ROM_VAL_B
    STA OBJ_POS_X_DELTA?[18],X
    LDA ROM_VAL_C
    STA 544_OBJ_UNK_POS_DELTA?[18],X
    LDA ROM_VAL_D
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
    LDA OBJ_STATE_DIR_RELATED_C[18],Y ; Load from Yobj.
    AND #$40 ; Keep bit.
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store to handled object.
    ASL A ; << 1, *2.
    BPL VAL_POSITIVE ; Positive, goto.
    SEC ; Prep sub.
    LDA #$00 ; Invert seed.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Subtract, inverting.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store back.
    LDA #$00 ; Invert seed.
    SBC OBJ_POS_X_DELTA?[18],X ; Subtract, inverting.
    STA OBJ_POS_X_DELTA?[18],X ; Store back.
VAL_POSITIVE: ; 16:148A, 0x02D48A
    CLC ; Prep add.
    LDA #$FB ; Seed Invert +5?
    ADC 4C6_OBJ_UNK[18],X ; Add with.
    STA 4C6_OBJ_UNK[18],X ; Store back.
    LDA #$1E
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    JMP PAIR_MANIP_STUFF ; Goto.
ROM_VAL_A: ; 16:149B, 0x02D49B
    .db 00
ROM_VAL_B: ; 16:149C, 0x02D49C
    .db 01
ROM_VAL_C: ; 16:149D, 0x02D49D
    .db 00
ROM_VAL_D: ; 16:149E, 0x02D49E
    .db FF
GRP_D_RTN_A: ; 16:149F, 0x02D49F
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RET_CC ; Ret CC, goto.
    ASL OBJ_POS_X?[18],X ; << Val.
    LDA #$00 ; Val.
    BCS VAL_SEEDED ; CS shifted, goto.
    LDA #$FF ; Alt val.
VAL_SEEDED: ; 16:14B2, 0x02D4B2
    STA OBJ_POS_X?[18],X ; Store val.
RET_CC: ; 16:14B5, 0x02D4B5
    LDA #$10 ; Mod.
    JSR MOVE_UNK_RET_?? ; Mod.
    BCC SKIP_STATE_MOVE ; Ret CC, goto.
    JSR CLEAR_ATTRS_HELPER_1708 ; Clear attrs.
    LDA #$00
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Pair attrs clear.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store back.
    LDA OBJECT_DATA_HEALTH?[18],X ; Load
    BNE HEALTH_NONZERO ; Has health, skip.
    JMP NO_HEALTH_STATE_MOVE ; State swap.
HEALTH_NONZERO: ; 16:14D7, 0x02D4D7
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    BMI STATE_MOVE_PORTION ; Negative, goto.
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X ; --
    BEQ VAL_NOW_ZERO ; == 0, goto.
STATE_MOVE_PORTION: ; 16:14E1, 0x02D4E1
    JSR STATE_MOVE+ATTR_HELPER_B
SKIP_STATE_MOVE: ; 16:14E4, 0x02D4E4
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Y from Xobj.
    BPL EXIT_MOVE ; If positive, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    LSR A ; >> 1, /2.
    LDA #$8D ; Val A.
    BCC WRITE_ANIM_VAL ; CC, goto.
    LDA #$A6 ; Alt anim.
WRITE_ANIM_VAL: ; 16:14F3, 0x02D4F3
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim
EXIT_MOVE: ; 16:14F6, 0x02D4F6
    JSR MOVE_Y_FINALIZE ; Move. Funny, as is first time this is done without a JMP to the RTN.
    RTS ; Leave.
VAL_NOW_ZERO: ; 16:14FA, 0x02D4FA
    INC OBJ_TERTIARY_SWITCH?[18],X ; Move tert.
    LDA #$1B
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA #$8C
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim disp.
    LDA #$32
    JMP SND_BANKED_DISPATCH ; Play sound. Abuse RTS.
GRP_D_RTN_B: ; 16:150C, 0x02D50C
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
    LDY #$00 ; Index val.
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load
    CMP #$12 ; If _ #$12
    BCS INDEX_SOLVED ; >=, goto.
    INY ; Index++
    CMP #$09 ; If _ #$09
    BCS INDEX_SOLVED ; >=, goto.
    INY ; Next index.
INDEX_SOLVED: ; 16:1520, 0x02D520
    LDA OBJ_ANIM_DATA,Y ; Get anim.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set attr.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; != 0, goto.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ORA #$80 ; Set bit.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    JSR STATE_MOVE+ATTR_HELPER_B ; State move.
RTS: ; 16:1536, 0x02D536
    RTS ; Leave.
OBJ_ANIM_DATA: ; 16:1537, 0x02D537
    .db 8C
    .db A0
    .db A1
NO_HEALTH_STATE_MOVE: ; 16:153A, 0x02D53A
    LDA #$05
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X ; Clear tert.
    LDA #$8E
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$20
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Entry set.
    RTS
GRP_E_RTN_A: ; 16:154F, 0x02D54F
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; Load
    BEQ VAL_EQ_ZERO ; == 0, goto.
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X ; --
    BNE RTS ; != 0, goto.
    LDA #$2A
    JSR SND_BANKED_DISPATCH ; Play sound.
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Get attr.
    ASL A
    ASL A ; << 2, *4.
    LDA #$ED ; Val A.
    BCS CS_SHIFT ; Shifted CS, goto.
    LDA #$12 ; Alt val.
CS_SHIFT: ; 16:156E, 0x02D56E
    STA TMP_00 ; Store to.
    ADC OBJ_POS_X?[18],X ; Add with. Carry sometimes fucked?? TODO: Wtf.
    PHA ; Save.
    ROR A ; >> 1, /2.
    EOR TMP_00 ; Eor with.
    ASL A ; << 1, *2.
    PLA ; Pull val.
    BCC CC_CLEAR ; CC, goto.
    LDA #$00 ; Load
    ASL TMP_00 ; << 1.
    BCS CC_CLEAR ; Carry set shift, goto.
    LDA #$FF ; Val.
CC_CLEAR: ; 16:1583, 0x02D583
    STA OBJ_POS_X?[18],X ; Store 0x00/0xFF.
    LDA #$F6
    STA 4C6_OBJ_UNK[18],X ; Set attr.
    JSR MOVE_Y_FINALIZE ; Do.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold it.
RTS: ; 16:1598, 0x02D598
    RTS ; Leave.
VAL_EQ_ZERO: ; 16:1599, 0x02D599
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; Positive still, leave.
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Next anim.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC RTS ; <, leave.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init obj.
    INX ; Pair obj.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init too.
    DEX ; Fix back to base.
RTS: ; 16:15BA, 0x02D5BA
    RTS
ODD_SECONDARY_TERT_RUNNER_MULTISWITCH: ; 16:15BB, 0x02D5BB
    LDA OBJ_SECONDARY_SWITCH?[18],X ; Load secondary.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA PTR_GROUPS_L,Y ; Move ptr to ZP.
    STA TMP_00
    LDA PTR_GROUPS_H,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load tert.
    ASL A ; << 1, *2.
    TAY ; To Y index.
    LDA [TMP_00],Y ; Load from ptr.
    STA TMP_02 ; Store to.
    INY ; Stream++
    LDA [TMP_00],Y ; Load from ptr.
    STA TMP_03 ; Store to.
    JMP [TMP_02] ; Goto code.
PTR_GROUPS_L: ; 16:15DB, 0x02D5DB
    LOW(PTR_GRP_A) ; Secondary for this data selection.
PTR_GROUPS_H: ; 16:15DC, 0x02D5DC
    HIGH(PTR_GRP_A)
    LOW(PTR_GRP_B)
    HIGH(PTR_GRP_B)
    LOW(PTR_GRP_C)
    HIGH(PTR_GRP_C)
    LOW(PTR_GRP_D)
    HIGH(PTR_GRP_D)
    LOW(PTR_GRP_D)
    HIGH(PTR_GRP_D)
    LOW(PTR_GRP_E)
    HIGH(PTR_GRP_E)
PTR_GRP_A: ; 16:15E7, 0x02D5E7
    LOW(GRP_A_RTN_A) ; Tert for these data selection.
    HIGH(GRP_A_RTN_A)
PTR_GRP_B: ; 16:15E9, 0x02D5E9
    LOW(GRP_B_RTN_A)
    HIGH(GRP_B_RTN_A)
    LOW(GRP_B_RTN_B)
    HIGH(GRP_B_RTN_B)
PTR_GRP_C: ; 16:15ED, 0x02D5ED
    LOW(GRP_C_RTN_A)
    HIGH(GRP_C_RTN_A)
    LOW(GRP_C_RTN_B)
    HIGH(GRP_C_RTN_B)
    LOW(GRP_C_RTN_C)
    HIGH(GRP_C_RTN_C)
    LOW(GRP_C_RTN_D)
    HIGH(GRP_C_RTN_D)
PTR_GRP_D: ; 16:15F5, 0x02D5F5
    LOW(GRP_D_RTN_A)
    HIGH(GRP_D_RTN_A)
    LOW(GRP_D_RTN_B)
    HIGH(GRP_D_RTN_B)
PTR_GRP_E: ; 16:15F9, 0x02D5F9
    LOW(GRP_E_RTN_A)
    HIGH(GRP_E_RTN_A)
GRP_A_RTN_A: ; 16:15FB, 0x02D5FB
    LDA #$DA
    STA ZP_R2-R5_BANK_VALUES+2 ; Set GFX.
    LDA #$DB
    STA ZP_R2-R5_BANK_VALUES+3
    LDY #$1F
    JSR UPDATE_PALETTE[0x1C]_WITH_Y_SAVING_XOBJ ; Set palette.
    LDA #$4A
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair.
    LDA #$0A
    STA OBJECT_DATA_HEALTH?[18],X ; Set health.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Get val.
    AND #$02 ; Keep bit.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Store to obj.
    JSR XOBJ_MANIP_BASED_ON_LIVES_UNK ; Manip.
    LDA #$02
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set attr.
    INC OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    RTS ; Leave.
GRP_B_RTN_A: ; 16:1625, 0x02D625
    INC OBJ_TERTIARY_SWITCH?[18],X ; Next tert.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load
    BNE VAL_NONZERO ; != 0, goto. Bad code, could have branched around store.
    LDA #$01 ; Set if zero.
VAL_NONZERO: ; 16:162F, 0x02D62F
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Store val.
    LSR A ; >> 1, /2. Carry important.
    LDA #$20 ; Seed val.
    BCS SHIFTED_SET_OFF_A ; Carry was set, goto.
    LDA #$E0 ; Seed other val.
SHIFTED_SET_OFF_A: ; 16:1639, 0x02D639
    STA OBJ_POS_X?[18],X ; Store attr.
    LDA #$00 ; Other vals.
    BCS SHIFTED_SET_OFF_B ; Same shift check.
    LDA #$40 ; Alt val.
SHIFTED_SET_OFF_B: ; 16:1642, 0x02D642
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store attr.
    LDA 556_OBJ_STATUS_FLAGS_A[18],X ; Load attr.
    EOR #$01 ; Invert bit.
    LSR A ; >> 1, /2. To carry.
    JSR ATTR_SET_CARRY_SELECTION ; Attr set based on carry.
    JMP ATTR_SET_HELPER ; Goto, abuse RTS.
GRP_B_RTN_B: ; 16:1651, 0x02D651
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RET_CC ; Ret CC, goto.
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X ; Clear flag if CS.
RET_CC: ; 16:165B, 0x02D65B
    LDA #$20 ; Mod val.
    JSR MOVE_UNK_RET_?? ; Mod.
    BCC RET_CC_B ; Ret CC, goto.
    JSR STATE_MOVE+ATTR_HELPER_A ; Set attrs.
RET_CC_B: ; 16:1665, 0x02D665
    LDA OBJ_POS_X?[18],X ; Load
    CMP TMP_10 ; If attr _ TMP
    BCC CLEAR_ATTR ; <, goto.
    CMP #$E0 ; If attr _ #$E0
    BCC SKIP_CLEAR ; <, goto.
CLEAR_ATTR: ; 16:1670, 0x02D670
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear attr.
SKIP_CLEAR: ; 16:1675, 0x02D675
    JSR ANIM_DISP_SOLVER ; Solve anim.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
ANIM_DISP_SOLVER: ; 16:167B, 0x02D67B
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    AND #$01 ; Keep bit.
    ASL A ; << 2, *4.
    ASL A
    LDY 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    BPL ATTR_POSITIVE ; Positive, goto.
    ORA #$02 ; Set bit.
ATTR_POSITIVE: ; 16:1689, 0x02D689
    LDY 4C6_OBJ_UNK[18],X ; Load attr.
    BPL OR_BIT ; Of positive, set bit and use.
    CPY #$FC ; If attr _ #$FC
    BCC ANIM_VAL_SOLVED ; <, goto.
OR_BIT: ; 16:1692, 0x02D692
    ORA #$01 ; Set bit.
ANIM_VAL_SOLVED: ; 16:1694, 0x02D694
    TAY ; A to index.
    LDA ANIM_DISP,Y ; Load data.
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
ANIM_DISP: ; 16:169C, 0x02D69C
    .db 84 ; Anims.
    .db 85
    .db 88
    .db 89
    .db 86
    .db 87
    .db 8A
    .db 8B
GRP_C_RTN_A: ; 16:16A4, 0x02D6A4
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    BEQ HOLD_EQ_ZERO ; == 0, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE HOLD_NONZERO ; != 0, goto.
    LDA #$24
    JSR SND_BANKED_DISPATCH ; Play sound.
HOLD_NONZERO: ; 16:16B3, 0x02D6B3
    JMP EXIT_ANIM ; Goto.
HOLD_EQ_ZERO: ; 16:16B6, 0x02D6B6
    JSR ATTR_HELPER_YOBJ_CONSIDERED ; Do.
    JSR RTN_MOVE/POS_UNK ; Do.
    JSR INVERT_RTN_UNK ; Do.
    LDA #$20
    JSR MOVE_UNK_RET_?? ; Do.
    BCC EXIT_ANIM ; Ret CC, goto.
    JSR CLEAR_ATTRS_HELPER_1708 ; Clear.
    JSR FOCUS_FIND_SEED_0x80 ; Focus on something.
    JSR RTN_POSSIBLY_SHIFT_STATE_CS_TRUE ; Shift maybe.
    BCS EXIT_ANIM ; True, goto.
    JSR COUNTER_RANDOMNESS_BAD ; Do.
    AND #$03 ; Test bits. Random.
    BNE BITS_SET ; !=, either set, goto.
    JSR STATE_MOVE+ATTR_HELPER_B ; Do rtn.
    JMP EXIT_ANIM ; Exit.
BITS_SET: ; 16:16DE, 0x02D6DE
    JSR STATE_MOVE+ATTR_SET[/FROM_STATE] ; Do.
EXIT_ANIM: ; 16:16E1, 0x02D6E1
    JSR ANIM_DISP_SOLVER ; Solve anim disp.
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod.
    JMP MOVE_Y_FINALIZE ; Goto, abuse RTS.
STATE_MOVE+ATTR_HELPER_B: ; 16:16EA, 0x02D6EA
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$00
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$0C
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
ATTR_SET_HELPER: ; 16:16F9, 0x02D6F9
    LDA ATTR_ROM_A ; Load from ROM.
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; To obj.
    LDA ATTR_ROM_B ; Load from ROM.
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; To obj.
    RTS ; Leave.
ATTR_ROM_A: ; 16:1706, 0x02D706
    .db 00
ATTR_ROM_B: ; 16:1707, 0x02D707
    .db FB
CLEAR_ATTRS_HELPER_1708: ; 16:1708, 0x02D708
    LDA #$00
    STA 4C6_OBJ_UNK[18],X
    STA 4D8_OBJ_UNK[18],X
    RTS
STATE_MOVE+ATTR_SET[/FROM_STATE]: ; 16:1711, 0x02D711
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; State move.
    LDA #$01
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$0C
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    LDA ROM_VAL_A
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attrs.
    LDA ROM_VAL_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    JMP ATTR_FROM_STATE_HELPER ; Goto.
ROM_VAL_A: ; 16:172F, 0x02D72F
    .db 00
ROM_VAL_B: ; 16:1730, 0x02D730
    .db FC
GRP_C_RTN_B: ; 16:1731, 0x02D731
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load attr
    BEQ ATTR_ZERO ; == 0, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE VAL_NONZERO ; != 0, goto.
    LDA #$24
    JSR SND_BANKED_DISPATCH ; Play sound.
VAL_NONZERO: ; 16:1740, 0x02D740
    JMP JMP_EXIT_ANIM ; Goto.
ATTR_ZERO: ; 16:1743, 0x02D743
    JSR ATTR_HELPER_YOBJ_CONSIDERED ; Attr set.
    JSR RTN_MOVE/POS_UNK ; Do.
    JSR INVERT_RTN_UNK ; Do.
    LDA #$20
    JSR MOVE_UNK_RET_?? ; Do.
    BCC JMP_EXIT_ANIM ; Ret CC, exit.
    JSR CLEAR_ATTRS_HELPER_1708 ; Clear attrs.
    JSR FOCUS_FIND_SEED_0x80 ; Focus
    JSR RTN_POSSIBLY_SHIFT_STATE_CS_TRUE ; Maybe switch.
    BCS JMP_EXIT_ANIM ; Switched, goto.
    JSR COUNTER_RANDOMNESS_BAD ; Random.
    AND #$03 ; Keep bits.
    BEQ EXIT_STATE_MOVE ; == 0, neither set, goto.
    JSR STATE_MOVE+ATTR_SET[/FROM_STATE] ; Do sub.
    JMP JMP_EXIT_ANIM ; Goto.
EXIT_STATE_MOVE: ; 16:176B, 0x02D76B
    JSR STATE_MOVE+ATTR_HELPER_A ; Do.
JMP_EXIT_ANIM: ; 16:176E, 0x02D76E
    JMP EXIT_ANIM ; Goto.
STATE_MOVE+ATTR_HELPER_A: ; 16:1771, 0x02D771
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$02
    STA OBJ_TERTIARY_SWITCH?[18],X ; Set tert.
    LDA ROM_DATA_A
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set attrs.
    LDA ROM_DATA_B
    STA 532_OBJ_UNK_POS_DELTA?[18],X
    LDA #$0C
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold anim.
    RTS ; Leave.
ROM_DATA_A: ; 16:178D, 0x02D78D
    .db 00
ROM_DATA_B: ; 16:178E, 0x02D78E
    .db FB
GRP_C_RTN_C: ; 16:178F, 0x02D78F
    LDA OBJ_ANIM_HOLD_TIMER?[18],X ; Load hold.
    BEQ HOLD_EQ_ZERO ; == 0, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE ATTR_SET_UNK ; != 0, goto.
    LDA #$24
    JSR SND_BANKED_DISPATCH ; Play sound.
ATTR_SET_UNK: ; 16:179E, 0x02D79E
    LDA #$FD
    STA 4C6_OBJ_UNK[18],X ; Set ??
    RTS ; Leave.
HOLD_EQ_ZERO: ; 16:17A4, 0x02D7A4
    JSR ATTR_HELPER_YOBJ_CONSIDERED ; Attr set.
    JSR RTN_MOVE/POS_UNK ; Do.
    LDA #$20 ; Load.
    JSR MOVE_UNK_RET_?? ; Move with val.
    BCC EXIT_ANIM ; Ret CC, goto.
    JSR CLEAR_ATTRS_HELPER_1708 ; Clear attrs.
    JSR FOCUS_FIND_SEED_0x80 ; Focus.
    JSR RTN_POSSIBLY_SHIFT_STATE_CS_TRUE ; Shift maybe.
    BCS EXIT_ANIM ; Shifted, leave.
    JSR COUNTER_RANDOMNESS_BAD ; Randomness.
    AND #$01 ; On bit.
    BEQ BIT_UNSET
    JSR STATE_MOVE+ATTR_HELPER_A ; Move state.
    JMP EXIT_ANIM ; Exit.
BIT_UNSET: ; 16:17C9, 0x02D7C9
    JSR STATE_MOVE+ATTR_HELPER_B ; Move state.
EXIT_ANIM: ; 16:17CC, 0x02D7CC
    JMP EXIT_ANIM ; Goto.
GRP_C_RTN_D: ; 16:17CF, 0x02D7CF
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BNE RTS ; Hold != 0, leave.
    JSR RTN_NEW_OBJ_AND_MANY_ATTRS ; New obj thingy.
    JSR STATE_MOVE+ATTR_HELPER_B ; Attr set.
RTS: ; 16:17DA, 0x02D7DA
    RTS ; Leave.
RTN_POSSIBLY_SHIFT_STATE_CS_TRUE: ; 16:17DB, 0x02D7DB
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load attr.
    LSR A ; >> 1, /2.
    BCS SHIFTED_CS ; Carry set, goto.
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move state.
    LDA #$03
    STA OBJ_TERTIARY_SWITCH?[18],X
    LDA #$28
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    SEC ; Ret CS.
    RTS
SHIFTED_CS: ; 16:17F2, 0x02D7F2
    CLC ; Ret CC.
    RTS
INVERT_RTN_UNK: ; 16:17F4, 0x02D7F4
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RTS ; Ret CC, goto.
    LDA OBJ_POS_X?[18],X ; Load attr.
    CMP #$20 ; If _ #$20
    BCC INVERT_PORTION ; <, goto.
    CMP #$E0 ; If _ #$E0
    BCC RTS ; <, leave.
INVERT_PORTION: ; 16:1804, 0x02D804
    SEC ; Prep sub.
    LDA #$00 ; Seed invert.
    SBC OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Subtract. INverting.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Store back.
    LDA #$00 ; Seed invert.
    SBC OBJ_POS_X_DELTA?[18],X ; Subtract.
    STA OBJ_POS_X_DELTA?[18],X ; Store inverted.
    JSR XPOS_RTN_RET_?? ; Do.
RTS: ; 16:1818, 0x02D818
    RTS ; Leave.
ATTR_FROM_STATE_HELPER: ; 16:1819, 0x02D819
    JSR SUB_OBJ_DIR_MOD_FROM_POS_AND_UNK ; Mod dir.
    LDA OBJ_TERTIARY_SWITCH?[18],X ; Load
    ASL A ; << 2, *4.
    ASL A
    PHA ; Save. Tert is base val, shifted.
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load
    ASL A ; << 2, *4.
    ASL A
    PLA ; Pull other val.
    BCC VAL_TO_INDEX ; Shift above was CC, goto.
    ORA #$02 ; Add to index.
VAL_TO_INDEX: ; 16:182C, 0x02D82C
    TAY ; To index.
ATTR_FROM_YINDEX: ; 16:182D, 0x02D82D
    LDA OBJ_DATA_A,Y ; Move attrs.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA OBJ_DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    RTS
ATTR_SET_CARRY_SELECTION: ; 16:183A, 0x02D83A
    LDY #$00 ; P1 index.
    BCC CARRY_CLEAR
    LDY #$02 ; P2 index.
CARRY_CLEAR: ; 16:1840, 0x02D840
    JMP ATTR_FROM_YINDEX
OBJ_DATA_A: ; 16:1843, 0x02D843
    .db 00
OBJ_DATA_B: ; 16:1844, 0x02D844
    .db FF
    .db 00
    .db 01
    .db 00
    .db FF
    .db 00
    .db 01
    .db 00
    .db 00
    .db 00
    .db 00
ATTR_HELPER_YOBJ_CONSIDERED: ; 16:184F, 0x02D84F
    LDY 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Y from Xobj.
L_16:1852: ; 16:1852, 0x02D852
    LDA OBJ_POS_Y?[18],Y ; A from Yobj.
    LDY #$00 ; Index seed.
    CMP OBJ_POS_Y?[18],X ; If Yobj pos _ Xobj pos
    BEQ POS_MATCH ; ==, goto.
    LDY #$02 ; Alt seed.
    BCC POS_MATCH ; <, goto.
    LDY #$04 ; Alt seed.
POS_MATCH: ; 16:1862, 0x02D862
    LDA DATA_A,Y ; Move attrs.
    STA 520_OBJ_POS_X_LARGE?[18],X
    LDA DATA_B,Y
    STA 503_OBJ_POS_X_LARGEST?[18],X
    RTS
DATA_A: ; 16:186F, 0x02D86F
    .db 00
DATA_B: ; 16:1870, 0x02D870
    .db 00
    .db C0
    .db FF
    .db 40
    .db 00
PAIR_MANIP_STUFF: ; 16:1875, 0x02D875
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Pair load.
    ORA #$01 ; Set bit.
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Store back.
    LDA #$40
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; Set pair val.
PAIR_ATTRS_AND_HANDLING_STUFF: ; 16:1882, 0x02D882
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load from pair.
    BEQ RTS ; == 0, goto.
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS+1,X ; pair--
    BEQ PAIR_NOW_ZERO_EXTENSION ; == 0, goto.
NEGATIVE_SET: ; 16:188C, 0x02D88C
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA TMP_00 ; Store to.
    LDA IRQ/SCRIPT_RUN_COUNT? ; Load count.
    LSR A ; >> 2, /4.
    LSR A
    AND #$03 ; Keep bits.
    TAY ; To Y index.
    LDA OBJ_DATA,Y ; Get data.
    ORA TMP_00 ; Set bottom randomly.
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store.
RTS: ; 16:18A2, 0x02D8A2
    RTS ; Leave.
PAIR_NOW_ZERO_EXTENSION: ; 16:18A3, 0x02D8A3
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Load pair.
    AND #$80 ; Keep 1000.0000
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX+1,X ; Store back.
    BMI NEGATIVE_SET ; If negative, go back into.
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load
    AND #$FC ; Keep 1111.1100
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store back.
    RTS ; Leave.
OBJ_DATA: ; 16:18B6, 0x02D8B6
    .db 03
    .db 01
    .db 03
    .db 02
OBJ_STATE_0x4C_HANDLER: ; 16:18BA, 0x02D8BA
    LDA 544_OBJ_UNK_POS_DELTA?+17,X ; Move from Obj[17]
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    LDA OBJ_POS_Y+17,X
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_X_SUBPIXEL?+17,X
    STA OBJ_POS_Y?[18],X
    STA OBJ_POS_Y[18],X
    LDA #$04
    STA OBJ_ANIMATION_DISPLAY[18],X ; Set anim.
    RTS ; Leave.
OBJ_STATE_0x4B_HANDLER: ; 16:18D5, 0x02D8D5
    LDY OBJ_SECONDARY_SWITCH?[18],X ; Load
    BEQ DANGLED_RTS ; == 0, goto.
    DEY ; Mod Yobj.
    BEQ YOBJ_DEC_ZERO ; == 0 now, goto.
    DEC OBJ_ANIM_HOLD_TIMER?[18],X ; --
    BPL RTS ; If positive, leave.
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Set hold.
    INC OBJ_ANIMATION_DISPLAY[18],X ; Next anim disp.
    LDA OBJ_ANIMATION_DISPLAY[18],X ; Load
    CMP #$04 ; If _ #$04
    BCC RTS ; <, leave.
    JSR FOCUS_OBJ_MANIP_STUFF ; Manip.
RTS: ; 16:18F4, 0x02D8F4
    RTS ; Leave.
NOT_ENABLED: ; 16:18F5, 0x02D8F5
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X ; Move secondary.
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X ; Anim disp.
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X ; Hold.
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X ; Clear.
    RTS ; Leave.
DANGLED_RTS: ; 16:190A, 0x02D90A
    RTS ; RTS again, just to be sure, lol.
YOBJ_DEC_ZERO: ; 16:190B, 0x02D90B
    LDA #$C1
    STA OBJECT_DATA_EXTRA_B?[18],X ; Set attr.
    JSR L_16:1932 ; Do.
    LDA 4C6_OBJ_UNK[18],X ; Load from Xobj.
    BPL RTS ; If positive, leave.
    LDA #$80
    STA OBJECT_DATA_HEALTH?[18],X
    JSR OBJ_RTN_UNK_RET_VAL_UNK
    AND #$03
    BEQ RTS
    LSR A
    LDA #$2A
    BCS L_16:192B
    LDA #$2A
L_16:192B: ; 16:192B, 0x02D92B
    JSR SND_BANKED_DISPATCH
    JSR NOT_ENABLED
RTS: ; 16:1931, 0x02D931
    RTS
L_16:1932: ; 16:1932, 0x02D932
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Yobj from Xobj.
    LDA OBJ_ENABLED_STATE+MORE?[18],Y ; Load from Yobj.
    BNE YOBJ_ENABLED ; != 0, state enabled.
    JMP NOT_ENABLED ; Goto, not enabled.
YOBJ_ENABLED: ; 16:193D, 0x02D93D
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; --
    BMI TIMER_NEGATIVE ; If negative, goto.
    JMP TIMER_NOT_NEGATIVE ; Goto, not negative.
TIMER_NEGATIVE: ; 16:1945, 0x02D945
    LDA #$04 ; Obj to focus.
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set timer.
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Y from Xobj.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Set on Yobj also.
    TAY ; Obj to index.
    LDA OBJ_POS_X?[18],Y ; Load from obj.
    STA TMP_0C ; Save.
    LDA OBJ_POS_X?[18],X ; Load from Xobj.
    STA TMP_0E ; Save.
    SEC ; Prep sub.
    LDA 4C6_OBJ_UNK[18],Y ; Load from obj.
    SBC #$18 ; Subtract.
    BMI VAL_NEGATIVE ; Result negative.
    LDA #$80 ; Seed val. Highest.
VAL_NEGATIVE: ; 16:1965, 0x02D965
    STA TMP_0D ; Store result.
    LDA 4C6_OBJ_UNK[18],X ; Load
    STA TMP_0F ; Store to.
    JSR L_16:12AA ; Do..
    SEC ; Prep sub.
    SBC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Subtract with.
    BPL VAL_POSITIVE ; If positive, goto.
    CLC ; Prep add.
    ADC #$20 ; Add with.
    AND #$1F ; Keep 0001.1111
VAL_POSITIVE: ; 16:197A, 0x02D97A
    TAY ; To Y index.
    BEQ VAL_ZERO ; == 0, goto.
    CMP #$10 ; If _ #$10
    LDA #$FE ; Val seed.
    BCS L_16:1985 ; >=, goto.
    LDA #$01 ; Alt seed.
L_16:1985: ; 16:1985, 0x02D985
    ADC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Add with Xobj.
    AND #$1F ; Keep 0001.1111
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Store back.
VAL_ZERO: ; 16:198D, 0x02D98D
    LDY #$02 ; Seed val.
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    JSR L_16:134D ; Do.
    LDA TMP_08 ; Load
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X ; Set.
    LDA TMP_09 ; Load
    STA OBJ_POS_X_DELTA?[18],X ; Set.
    LDA TMP_0A ; Load
    STA 544_OBJ_UNK_POS_DELTA?[18],X ; Set.
    LDA TMP_0B ; Load
    STA 532_OBJ_UNK_POS_DELTA?[18],X ; Set.
TIMER_NOT_NEGATIVE: ; 16:19A9, 0x02D9A9
    JSR XPOS_RTN_RET_?? ; Do.
    BCC RET_CC ; Returned CC, goto.
    JMP FOCUS_OBJ_MANIP_STUFF ; Do.
RET_CC: ; 16:19B1, 0x02D9B1
    JSR MOVE?_RTN_IDK ; Do.
    LDY 4C6_OBJ_UNK[18],X ; Y from Xobj.
    LDA #$08 ; Val seed.
    CPY #$08 ; If Y _ #$08
    BCC RANGE_VAL ; <, goto.
    LDA #$F8 ; Other val.
    CPY #$F8 ; If Y _ #$F8
    BCC DONT_RANGE_VAL ; <, goto.
RANGE_VAL: ; 16:19C3, 0x02D9C3
    STA 4C6_OBJ_UNK[18],X
DONT_RANGE_VAL: ; 16:19C6, 0x02D9C6
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Y from Xobj.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; A from Yobj.
    TAY ; Val to index.
    JSR L_16:1852 ; Todo.
    JSR MOVE_UNK_RET_??
    LDA 4C6_OBJ_UNK[18],X
    BMI L_16:19F8
    SEC
    LDA OBJ_POS_Y?[18],X
    SBC #$80
    BCC L_16:1A15
    STA TMP_00
    SEC
    LDA #$80
    SBC 4C6_OBJ_UNK[18],X
    EOR #$FF
    CLC
    ADC #$01
    CLC
    ADC TMP_00
    BCC L_16:1A15
    STA OBJ_POS_Y[18],X
    JMP L_16:1A01
L_16:19F8: ; 16:19F8, 0x02D9F8
    CLC
    ADC OBJ_POS_Y?[18],X
    BCC L_16:1A15
    STA OBJ_POS_Y[18],X
L_16:1A01: ; 16:1A01, 0x02DA01
    JSR L_16:1A1B
    LDA OBJ_POS_X_DELTA?[18],X
    ASL A
    LDA OBJ_STATE_DIR_RELATED_C[18],X
    AND #$BF
    BCS L_16:1A11
    ORA #$40
L_16:1A11: ; 16:1A11, 0x02DA11
    STA OBJ_STATE_DIR_RELATED_C[18],X
    RTS
L_16:1A15: ; 16:1A15, 0x02DA15
    LDA #$00
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
L_16:1A1B: ; 16:1A1B, 0x02DA1B
    DEC OBJ_ANIM_HOLD_TIMER?[18],X
    BPL L_16:1A28
    LDA #$04
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
L_16:1A28: ; 16:1A28, 0x02DA28
    CLC
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    ADC #$02
    LSR A
    LSR A
    AND #$07
    TAY
    LDA DATA_A,Y
    STA OBJ_STATE_DIR_RELATED_C[18],X
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LSR A
    LDA DATA_B,Y
    ADC #$00
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
DATA_B: ; 16:1A46, 0x02DA46
    .db 8F
    .db A2
    .db A4
    .db A2
    .db 8F
    .db A2
    .db A4
    .db A2
DATA_A: ; 16:1A4E, 0x02DA4E
    .db 40
    .db C0
    .db 80
    .db 80
    .db 00
    .db 00
    .db 00
    .db 40
FOCUS_OBJ_MANIP_STUFF: ; 16:1A56, 0x02DA56
    LDY STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Y from Xobj. TODO: Solve more.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Load from Yobj.
    AND #$FE ; Keep 1111.1110
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; Store back.
    LDA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Load
    EOR #$02 ; Invert 0000.0010
    AND #$02 ; Keep 0000.0010
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],Y ; Store back.
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Xobj to scratch.
    TYA ; Yobj to A...
    TAX ; ...A to Xobj. Y->X
    JSR XOBJ_MANIP_BASED_ON_LIVES_UNK ; Manip.
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Reload X.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    INX ; Pair.
    JSR INIT_OBJECT[X]_DATA_FULL ; Init.
    DEX ; Back to base obj.
    RTS ; Leave.
RTN_NEW_OBJ_AND_MANY_ATTRS: ; 16:1A7F, 0x02DA7F
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Load
    ORA #$01 ; Set.
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Store back.
    JSR OBJ_SEARCH_UNUSED_PAIR_RET_CS_FAIL ; Get obj pair.
    BCS EXIT_RESTORE_XOBJ_SCRATCHPAD ; Fail, goto.
    LDY OBJ_HANDLER_FOCUS_SCRATCHPAD ; Get focus obj in Y.
    TYA ; Yobj to A.
    STA STATUS_FLAGS_B/OBJ_FOCUS[18],X ; Set focus of new obj to handled.
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],Y ; A from handled.
    STA TMP_00 ; To TMP.
    LDA #$4B
    STA OBJ_ENABLED_STATE+MORE?[18],X ; Set new state.
    LDA #$4C
    STA OBJ_ENABLED_STATE+MORE?+1,X ; Set pair state.
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X ; Set new health.
    LDA OBJ_STATE_DIR_RELATED_C[18],Y ; Load handled attr.
    AND #$40 ; Keep bit.
    STA OBJ_STATE_DIR_RELATED_C[18],X ; Store to new.
    ASL A ; << 2, *4.
    ASL A
    LDA #$FA ; Load val.
    BCC SHITED_CLEAR
    LDA #$06 ; Alt val.
SHITED_CLEAR: ; 16:1AB7, 0x02DAB7
    CLC ; Prep add.
    ADC OBJ_POS_X?[18],Y ; Add to handled.
    STA OBJ_POS_X?[18],X ; Store to new.
    LDA OBJ_POS_Y?[18],Y ; Load handled.
    STA OBJ_POS_Y?[18],X ; Store to new.
    CLC ; Prep add.
    LDA #$E4 ; Load
    LDY TMP_00 ; Load saved.
    BMI SAVED_NEGATIVE ; Negative, use val.
    LDA #$E5 ; Alt val.
SAVED_NEGATIVE: ; 16:1ACD, 0x02DACD
    ADC 4C6_OBJ_UNK[18],Y ; Add to handled.
    STA 4C6_OBJ_UNK[18],X ; Store to new.
    LDA OBJ_STATE_DIR_RELATED_C[18],X ; Load from new.
    ASL A ; << 2, *4.
    ASL A
    LDA #$00 ; Val.
    BCS SHIFTED_CS
    LDA #$10 ; Alt val.
SHIFTED_CS: ; 16:1ADE, 0x02DADE
    STA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X ; Set attr.
    LDY #$00 ; Index.
    BCC SHIFTED_CC ; CC, goto.
    LDY #$02 ; Index alt.
SHIFTED_CC: ; 16:1AE7, 0x02DAE7
    LDA DATA_A,Y ; Move attrs from index data.
    STA OBJ_POS_X_SUBPIXEL_DELTA?[18],X
    LDA DATA_B,Y
    STA OBJ_POS_X_DELTA?[18],X
    LDA #$04
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X ; Set attr.
    LDA #$14
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X ; Set attr.
    LDA #$01
    STA OBJ_SECONDARY_SWITCH?[18],X ; Set secondary.
    LDA #$25
    JSR SND_BANKED_DISPATCH ; Play sound.
EXIT_RESTORE_XOBJ_SCRATCHPAD: ; 16:1B07, 0x02DB07
    LDX OBJ_HANDLER_FOCUS_SCRATCHPAD ; Get obj from scratchpad.
    RTS ; Leave.
    .db FC
    .db 04
    .db FC
    .db 04
DATA_A: ; 16:1B0F, 0x02DB0F
    .db C0
DATA_B: ; 16:1B10, 0x02DB10
    .db FF
    .db 40
    .db 00
OBJ_STATE_0x70_HANDLER: ; 16:1B13, 0x02DB13
    STX OBJ_HANDLER_FOCUS_SCRATCHPAD
    LDA OBJ_SECONDARY_SWITCH?[18],X
    CMP #$05
    BEQ L_16:1B48
    LDA OBJ_SECONDARY_SWITCH?+1,X
    BNE L_16:1B2A
    LDA #$32
    STA 59E_OBJ_UNK/EXTRA_TIMER+2,X
    JMP L_16:1B38
L_16:1B2A: ; 16:1B2A, 0x02DB2A
    LDA 59E_OBJ_UNK/EXTRA_TIMER+2,X
    BEQ L_16:1B38
    LDA IRQ/SCRIPT_RUN_COUNT?
    AND #$03
    BNE L_16:1B38
    DEC 59E_OBJ_UNK/EXTRA_TIMER+2,X
L_16:1B38: ; 16:1B38, 0x02DB38
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    BEQ L_16:1B40
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X
L_16:1B40: ; 16:1B40, 0x02DB40
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    BEQ L_16:1B48
    DEC 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
L_16:1B48: ; 16:1B48, 0x02DB48
    LDA #$13
    STA OBJECT_DATA_EXTRA_B?[18],X
    JSR L_16:1B83
    LDA OBJECT_DATA_EXTRA_B?[18],X
    BEQ L_16:1B78
    LDA OBJECT_DATA_HEALTH?[18],X
    PHA
    LDA 5C2_OBJ_DATA_PTR/MISC_INDEX[18],X
    BEQ L_16:1B63
    LDA #$FF
    STA OBJECT_DATA_HEALTH?[18],X
L_16:1B63: ; 16:1B63, 0x02DB63
    JSR OBJ_RTN_UNK_RET_VAL_UNK
    STA TMP_00
    PLA
    LDY OBJECT_DATA_HEALTH?[18],X
    CPY #$FF
    BNE L_16:1B73
    STA OBJECT_DATA_HEALTH?[18],X
L_16:1B73: ; 16:1B73, 0x02DB73
    LDA TMP_00
    LSR A
    BCS L_16:1B7B
L_16:1B78: ; 16:1B78, 0x02DB78
    JMP L_16:1DBC
L_16:1B7B: ; 16:1B7B, 0x02DB7B
    LDA #$2F
    JSR SND_BANKED_DISPATCH
    JMP L_16:1DF4
L_16:1B83: ; 16:1B83, 0x02DB83
    LDA OBJ_SECONDARY_SWITCH?[18],X
    ASL A
    TAY
    LDA L_16:1BA3,Y
    STA TMP_00
    LDA L_16:1BA4,Y
    STA TMP_01
    LDA OBJ_TERTIARY_SWITCH?[18],X
    ASL A
    TAY
    LDA [TMP_00],Y
    STA TMP_02
    INY
    LDA [TMP_00],Y
    STA TMP_03
    JMP [TMP_02]
L_16:1BA3: ; 16:1BA3, 0x02DBA3
    .db AF
L_16:1BA4: ; 16:1BA4, 0x02DBA4
    .db 9B
    .db B1
    .db 9B
    .db B5
    .db 9B
    .db B9
    .db 9B
    .db BB
    .db 9B
    .db BD
    .db 9B
    .db C9
    .db 9B
    .db 0B
    .db 9C
    .db 38
    .db 9C
    .db DF
    .db 9C
    .db F4
    .db 9C
    .db 47
    .db 9D
    .db 4E
    .db 9E
    .db AD
    .db A2
    .db 02
    .db A3
    .db 0B
    .db A4
    .db C5
    .db A4
    .db DB
    .db A4
    .db F1
    .db A4
    .db A0
    .db 1E
    .db 20
    .db 55
    .db F6
    .db A9
    .db 00
    .db 8D
    .db 03
    .db 07
    .db 8D
    .db 04
    .db 07
    .db 8D
    .db 06
    .db 07
    .db A9
    .db 71
    .db 9D
    .db 25
    .db 04
    .db A9
    .db 72
    .db 9D
    .db 26
    .db 04
    .db A9
    .db 50
    .db 9D
    .db 68
    .db 05
    .db A5
    .db 1B
    .db 29
    .db 02
    .db 9D
    .db D4
    .db 05
    .db 20
    .db CE
    .db F6
    .db A9
    .db 40
    .db 9D
    .db 44
    .db 05
    .db A9
    .db B0
    .db 9D
    .db 7E
    .db 04
    .db A9
    .db C1
    .db 9D
    .db A2
    .db 04
    .db 20
    .db 88
    .db F7
    .db FE
    .db 12
    .db 04
    .db AE
    .db 00
    .db 07
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db DE
    .db 44
    .db 05
    .db D0
    .db 22
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 9D
    .db 00
    .db 04
    .db 9D
    .db 32
    .db 05
    .db A8
    .db A9
    .db 01
    .db 9D
    .db 44
    .db 05
    .db 9D
    .db 48
    .db 04
    .db B9
    .db 89
    .db 9C
    .db 9D
    .db 5A
    .db 04
    .db FE
    .db 8C
    .db 05
    .db A9
    .db 60
    .db 20
    .db 52
    .db DB
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db 20
    .db B9
    .db 9C
    .db DE
    .db 48
    .db 04
    .db 10
    .db 21
    .db BD
    .db 44
    .db 05
    .db 9D
    .db 48
    .db 04
    .db DE
    .db 5A
    .db 04
    .db D0
    .db 16
    .db FE
    .db 32
    .db 05
    .db BC
    .db 32
    .db 05
    .db B9
    .db 89
    .db 9C
    .db 9D
    .db 5A
    .db 04
    .db FE
    .db 44
    .db 05
    .db BD
    .db 44
    .db 05
    .db C9
    .db 06
    .db F0
    .db 0C
    .db BD
    .db 5A
    .db 04
    .db 4A
    .db 90
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 00
    .db 04
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 32
    .db 05
    .db 9D
    .db 44
    .db 05
    .db 9D
    .db 5A
    .db 04
    .db A9
    .db 09
    .db 9D
    .db 48
    .db 04
    .db 20
    .db E9
    .db 9C
    .db FE
    .db 8C
    .db 05
    .db 60
    .db 1E
    .db 0F
    .db 0A
    .db 0A
    .db 0A
    .db 0A
    .db A9
    .db D0
    .db 85
    .db 31
    .db A9
    .db D1
    .db 85
    .db 32
    .db BD
    .db 9E
    .db 05
    .db 4A
    .db DE
    .db 48
    .db 04
    .db 10
    .db 08
    .db A9
    .db 09
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
    .db 90
    .db 02
    .db 09
    .db 04
    .db A8
    .db B9
    .db C7
    .db 9C
    .db 9D
    .db 00
    .db 04
    .db 60
    .db A9
    .db D0
    .db 85
    .db 31
    .db A9
    .db D1
    .db 85
    .db 32
    .db A9
    .db C2
    .db 9D
    .db 00
    .db 04
    .db 60
    .db C2
    .db C3
    .db C4
    .db C3
    .db C5
    .db C6
    .db C7
    .db C6
    .db A9
    .db 02
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
    .db 6A
    .db 05
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db DE
    .db 6A
    .db 05
    .db D0
    .db F5
    .db A9
    .db 02
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 01
    .db 9D
    .db 8C
    .db 05
    .db 60
    .db 20
    .db CE
    .db F6
    .db A9
    .db 00
    .db 8D
    .db 15
    .db 07
    .db 20
    .db 26
    .db 91
    .db 20
    .db 42
    .db F7
    .db A5
    .db 11
    .db C9
    .db 10
    .db 90
    .db 03
    .db 4C
    .db 26
    .db 9D
    .db BD
    .db B0
    .db 05
    .db D0
    .db 09
    .db A5
    .db 10
    .db C9
    .db 40
    .db B0
    .db 03
    .db 4C
    .db 35
    .db 9D
    .db BD
    .db 9E
    .db 05
    .db 4A
    .db B0
    .db 07
    .db A5
    .db 1B
    .db D0
    .db 03
    .db 20
    .db FB
    .db A1
    .db 20
    .db D0
    .db 91
    .db 20
    .db E5
    .db 91
    .db 20
    .db 8F
    .db 9C
    .db 20
    .db 72
    .db F7
    .db 4C
    .db 88
    .db F7
    .db A9
    .db 03
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 00
    .db 9D
    .db 6A
    .db 05
    .db 4C
    .db 72
    .db F7
    .db A9
    .db D2
    .db 85
    .db 31
    .db A9
    .db D1
    .db 85
    .db 32
    .db FE
    .db 6A
    .db 05
    .db BC
    .db 6A
    .db 05
    .db C0
    .db 14
    .db B0
    .db 47
    .db A5
    .db 1B
    .db 29
    .db 07
    .db D0
    .db 11
    .db BD
    .db 36
    .db 04
    .db 0A
    .db 0A
    .db A9
    .db FF
    .db 90
    .db 02
    .db A9
    .db 00
    .db 7D
    .db 7E
    .db 04
    .db 9D
    .db 7E
    .db 04
    .db A9
    .db 00
    .db C0
    .db 06
    .db 90
    .db 18
    .db D0
    .db 05
    .db A9
    .db 17
    .db 20
    .db 52
    .db DB
    .db A9
    .db 01
    .db C0
    .db 09
    .db 90
    .db 0B
    .db C0
    .db 0E
    .db B0
    .db 07
    .db A9
    .db BC
    .db 9D
    .db 7A
    .db 05
    .db A9
    .db 01
    .db 85
    .db 00
    .db BD
    .db 9E
    .db 05
    .db 29
    .db 01
    .db 0A
    .db 05
    .db 00
    .db A8
    .db B9
    .db AB
    .db 9D
    .db 9D
    .db 00
    .db 04
    .db 60
    .db A9
    .db 32
    .db 9D
    .db B0
    .db 05
    .db 20
    .db FE
    .db F6
    .db 4C
    .db E9
    .db 9C
    .db CC
    .db CD
    .db CE
    .db CF
    .db AD
    .db 03
    .db 07
    .db 09
    .db 01
    .db 8D
    .db 03
    .db 07
    .db A9
    .db 1C
    .db 8D
    .db 04
    .db 07
L_16:1DBC: ; 16:1DBC, 0x02DDBC
    .db AD
    .db 03
    .db 07
    .db F0
    .db 1B
    .db CE
    .db 04
    .db 07
    .db F0
    .db 17
    .db BD
    .db 36
    .db 04
    .db 29
    .db FC
    .db 85
    .db 00
    .db A5
    .db 1B
    .db 4A
    .db 4A
    .db 29
    .db 03
    .db A8
    .db B9
    .db F0
    .db 9D
    .db 05
    .db 00
    .db 9D
    .db 36
    .db 04
    .db 60
    .db AD
    .db 03
    .db 07
    .db 29
    .db 80
    .db 8D
    .db 03
    .db 07
    .db 30
    .db DF
    .db BD
    .db 36
    .db 04
    .db 29
    .db FC
    .db 9D
    .db 36
    .db 04
    .db 60
    .db 03
    .db 01
    .db 03
    .db 02
L_16:1DF4: ; 16:1DF4, 0x02DDF4
    .db 20
    .db 41
    .db F8
    .db A9
    .db 00
    .db 9D
    .db EA
    .db 04
    .db 9D
    .db FC
    .db 04
    .db 9D
    .db 0E
    .db 05
    .db 9D
    .db 20
    .db 05
    .db BD
    .db 68
    .db 05
    .db D0
    .db 03
    .db 4C
    .db 76
    .db A2
    .db C9
    .db 18
    .db B0
    .db 0C
    .db AD
    .db 03
    .db 07
    .db 30
    .db 07
    .db 09
    .db 80
    .db 8D
    .db 03
    .db 07
    .db D0
    .db 03
    .db 20
    .db AF
    .db 9D
    .db A9
    .db 04
    .db 9D
    .db 12
    .db 04
    .db A9
    .db 00
    .db 9D
    .db 8C
    .db 05
    .db A9
    .db 14
    .db 9D
    .db 48
    .db 04
    .db A9
    .db D2
    .db 85
    .db 31
    .db A9
    .db D1
    .db BC
    .db 12
    .db 04
    .db C0
    .db 05
    .db D0
    .db 02
    .db A9
    .db D3
    .db 85
    .db 32
    .db BD
    .db 9E
    .db 05
    .db 4A
    .db A9
    .db D0
    .db 90
    .db 02
    .db A9
    .db D1
    .db 9D
    .db 00
    .db 04
    .db 60
    .db A9
    .db 00
    .db 9D
    .db 7A
    .db 05
    .db DE
    .db 48
    .db 04
    .db D0
    .db 0D
    .db A9
    .db 07
    .db 9D
    .db 48
    .db 04
    .db A9
    .db 10
    .db 9D
    .db C2
    .db 05
    .db 20
    .db E9
    .db 9C
    .db 60
OBJ_STATE_0x72_HANDLER: ; 16:1E66, 0x02DE66
    LDA OBJ_ANIMATION_DISPLAY+17,X
    BEQ ANIM_SEEDED
    LDA 544_OBJ_UNK_POS_DELTA?+17,X
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    LDA OBJ_POS_Y+17,X
    STA OBJ_POS_X?[18],X
    LDA OBJ_POS_X_SUBPIXEL?+17,X
    STA OBJ_POS_Y?[18],X
    DEC OBJ_POS_Y?[18],X
    STA OBJ_POS_Y[18],X
    LDA #$04
ANIM_SEEDED: ; 16:1E85, 0x02DE85
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
OBJ_STATE_0x71_HANDLER: ; 16:1E89, 0x02DE89
    LDY OBJ_SECONDARY_SWITCH?[18],X
    BEQ RTS
    JSR L_16:1EBE
    LDA OBJ_ANIMATION_DISPLAY+17,X
    CMP #$05
    BNE L_16:1E9F
    LDA OBJ_SECONDARY_SWITCH?[18],X
    CMP #$04
    BCC L_16:1ED0
L_16:1E9F: ; 16:1E9F, 0x02DE9F
    LDA OBJ_SECONDARY_SWITCH?[18],X
    CMP #$03
    BCS RTS
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    BNE RTS
    LDA OBJ_ANIMATION_DISPLAY[18],X
    BEQ RTS
    LDA 4C6_OBJ_UNK[18],X
    BPL RTS
    LDA OBJECT_DATA_EXTRA_B?[18],X
    BEQ RTS
    JSR OBJ_RTN_UNK_RET_VAL_UNK
RTS: ; 16:1EBD, 0x02DEBD
    RTS
L_16:1EBE: ; 16:1EBE, 0x02DEBE
    LDA OBJ_SECONDARY_SWITCH?[18],X
    JSR SWITCH_CODE_PTRS_PAST_JSR
    LOW(RTS) ; STATE_0x71_SUBSWITCH_A, an RTS.
    HIGH(RTS)
    LOW(STATE_0x71_SUBSWITCH_B)
    HIGH(STATE_0x71_SUBSWITCH_B)
    LOW(STATE_0x71_SUBSWITCH_B)
    HIGH(STATE_0x71_SUBSWITCH_B)
    LOW(STATE_0x71_SUBSWITCH_C)
    HIGH(STATE_0x71_SUBSWITCH_C)
    LOW(STATE_0x71_SUBSWITCH_D)
    HIGH(STATE_0x71_SUBSWITCH_D)
    LOW(STATE_0x71_SUBSWITCH_E)
    HIGH(STATE_0x71_SUBSWITCH_E)
L_16:1ED0: ; 16:1ED0, 0x02DED0
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    LDA #$04
    STA OBJ_SECONDARY_SWITCH?[18],X
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$00
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA OBJ_STATE_DIR_RELATED_C[18],X
    AND #$FC
    STA OBJ_STATE_DIR_RELATED_C[18],X
    RTS
STATE_0x71_SUBSWITCH_D: ; 16:1EED, 0x02DEED
    LDA #$00
    STA OBJECT_DATA_EXTRA_B?[18],X
    INC 4C6_OBJ_UNK[18],X
    BEQ L_16:1F15
    JSR MOVE_Y_FINALIZE
    DEC OBJ_ANIM_HOLD_TIMER?[18],X
    BPL L_16:1F07
    LDA #$06
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    INC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
L_16:1F07: ; 16:1F07, 0x02DF07
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LSR A
    LDA #$D2
    BCC L_16:1F11
    LDA #$D3
L_16:1F11: ; 16:1F11, 0x02DF11
    STA OBJ_ANIMATION_DISPLAY[18],X
    RTS
L_16:1F15: ; 16:1F15, 0x02DF15
    JSR MOVE_Y_FINALIZE
    LDA #$30
    STA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    LDA #$D4
    STA OBJ_ANIMATION_DISPLAY[18],X
    INC OBJ_SECONDARY_SWITCH?[18],X
    RTS
STATE_0x71_SUBSWITCH_E: ; 16:1F26, 0x02DF26
    LDA 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    BEQ L_16:1F3D
    DEC 45A_OBJ_DATA_ENTRY?STATE_STEP?[18],X
    BNE L_16:1F54
    LDA #$07
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    LDA #$01
    STA OBJ_ANIMATION_DISPLAY[18],X
    JMP L_16:1F54
L_16:1F3D: ; 16:1F3D, 0x02DF3D
    DEC OBJ_ANIM_HOLD_TIMER?[18],X
    BPL L_16:1F54
    LDA #$08
    STA OBJ_ANIM_HOLD_TIMER?[18],X
    INC OBJ_ANIMATION_DISPLAY[18],X
    LDA OBJ_ANIMATION_DISPLAY[18],X
    CMP #$04
    BCC L_16:1F54
    JSR INIT_OBJECT[X]_DATA_FULL
L_16:1F54: ; 16:1F54, 0x02DF54
    RTS
STATE_0x71_SUBSWITCH_B: ; 16:1F55, 0x02DF55
    LDA OBJ_SECONDARY_SWITCH?[18],X
    CMP #$02
    BEQ L_16:1F74
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    BNE L_16:1F74
    LDA IRQ/SCRIPT_RUN_COUNT?
    BNE L_16:1F74
    LDA STATUS_FLAGS_B/OBJ_FOCUS[18],X
    BEQ L_16:1F6F
    DEC STATUS_FLAGS_B/OBJ_FOCUS[18],X
    BNE L_16:1F74
L_16:1F6F: ; 16:1F6F, 0x02DF6F
    LDA #$02
    STA OBJ_SECONDARY_SWITCH?[18],X
L_16:1F74: ; 16:1F74, 0x02DF74
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    BEQ L_16:1F8D
    INC 59E_OBJ_UNK/EXTRA_TIMER[18],X
    LDA 59E_OBJ_UNK/EXTRA_TIMER[18],X
    CMP #$FA
    BCC L_16:1F92
    LDA #$00
    STA 556_OBJ_STATUS_FLAGS_A[18],X
    LDA #$FA
    STA OBJ_POS_X?[18],X
L_16:1F8D: ; 16:1F8D, 0x02DF8D
    LDA #$00
    STA 59E_OBJ_UNK/EXTRA_TIMER[18],X
L_16:1F92: ; 16:1F92, 0x02DF92
    DEC 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    BMI L_16:1F9A
    JMP L_17:004F
L_16:1F9A: ; 16:1F9A, 0x02DF9A
    LDA #$04
    STA 5D4_EXTRA_TIMER/OBJ/FOCUS[18],X
    LDY OBJ_SECONDARY_SWITCH?[18],X
    CPY #$02
    BNE L_16:1FC1
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    BNE L_16:1FC1
    LDA OBJ_POS_Y+17,X
    STA TMP_0C
    LDA #$AB
    STA TMP_0D
    LDA OBJ_POS_X?[18],X
    STA TMP_0E
    LDA 4C6_OBJ_UNK[18],X
    STA TMP_0F
    JMP L_17:0012
L_16:1FC1: ; 16:1FC1, 0x02DFC1
    LDY 5C2_OBJ_DATA_PTR/MISC_INDEX+17,X
    LDA 556_OBJ_STATUS_FLAGS_A[18],X
    BEQ L_16:1FCF
    CMP #$01
    BEQ L_16:1FDC
    BNE L_16:1FF0
L_16:1FCF: ; 16:1FCF, 0x02DFCF
    LDA OBJ_POS_X?[18],Y
    STA TMP_0C
    LDA OBJ_POS_X?[18],X
    STA TMP_0E
    JMP L_17:0001
L_16:1FDC: ; 16:1FDC, 0x02DFDC
    SEC
    LDA OBJ_POS_X?[18],X
    SBC OBJ_POS_X?[18],Y
    BCC L_16:1FE7
    LDA #$F0
L_16:1FE7: ; 16:1FE7, 0x02DFE7
    STA TMP_0E
    LDA #$00
    STA TMP_0C
    JMP L_17:0001
L_16:1FF0: ; 16:1FF0, 0x02DFF0
    SEC
    LDA OBJ_POS_X?[18],Y
    SBC OBJ_POS_X?[18],X
    BCC L_16:1FFB
    LDA #$F0
L_16:1FFB: ; 16:1FFB, 0x02DFFB
    STA TMP_0C
    LDA #$00
    STA TMP_0E
