; Work in progress disassembly of TMNT2 for the Nintendo Entertainment System.
; Created by Aaron Bottegal.


; NES PPU Registers

PPU_CTRL:                                     .equ $2000
PPU_MASK:                                     .equ $2001
PPU_STATUS:                                   .equ $2002
PPU_OAM_ADDR:                                 .equ $2003
PPU_OAM_DATA:                                 .equ $2004
PPU_SCROLL:                                   .equ $2005
PPU_ADDR:                                     .equ $2006
PPU_DATA:                                     .equ $2007


; NES APU Registers

APU_SQ1_CTRL:                                 .equ $4000
APU_SQ1_SWEEP:                                .equ $4001
APU_SQ1_LTIMER:                               .equ $4002
APU_SQ1_LENGTH:                               .equ $4003
APU_SQ2_CTRL:                                 .equ $4004
APU_SQ2_SWEEP:                                .equ $4005
APU_SQ2_LTIMER:                               .equ $4006
APU_SQ2_LENGTH:                               .equ $4007
APU_TRI_CTRL:                                 .equ $4008
APU_TRI_UNUSED:                               .equ $4009
APU_TRI_LTIMER:                               .equ $400A
APU_TRI_LENGTH:                               .equ $400B
APU_NSE_CTRL:                                 .equ $400C
APU_NSE_UNUSED:                               .equ $400D
APU_NSE_LOOP:                                 .equ $400E
APU_NSE_LENGTH:                               .equ $400F
APU_DMC_CTRL:                                 .equ $4010
APU_DMC_LOAD:                                 .equ $4011
APU_DMC_ADDR:                                 .equ $4012
APU_DMC_LENGTH:                               .equ $4013
OAM_DMA:                                      .equ $4014
APU_STATUS:                                   .equ $4015
NES_CTRL1:                                    .equ $4016
APU_FSEQUENCE:                                .equ $4017
NES_CTRL2:                                    .equ $4017


; NES RAM/WRAM Variables.


          .rsset 0x0000
TMP_00:                                       .rs 1
TMP_01:                                       .rs 1
TMP_02:                                       .rs 1
TMP_03:                                       .rs 1
TMP_04:                                       .rs 1
TMP_05:                                       .rs 1
TMP_06:                                       .rs 1
TMP_07:                                       .rs 1
TMP_08:                                       .rs 1
TMP_09:                                       .rs 1
TMP_0A:                                       .rs 1
TMP_0B:                                       .rs 1
TMP_0C:                                       .rs 1
ZP_0D_UNK:                                    .rs 1
ZP_0E_UNK:                                    .rs 1
TMP_0F?:                                      .rs 1
TMP_10:                                       .rs 1
ZP_11_UNK:                                    .rs 1
ZP_12_UNK:                                    .rs 1
ZP_13_UNK:                                    .rs 1
R_**:$0014:                                   .rs 1
R_**:$0015:                                   .rs 1
BCD_VAL_XY:                                   .rs 2
STATE_SWITCH_MENU:                            .rs 1
SUBSTATE_MENU:                                .rs 1


          .rsset 0x001B
IRQ_COUNT?:                                   .rs 1
FLAG_NMI_ALT_UNK:                             .rs 1
DISABLE_RENDERING_X_FRAMES:                   .rs 1
PPU_UPDATE_BUF_INDEX:                         .rs 1
1F_TITLE_UNK:                                 .rs 1
TWO_PLAYERS_FLAG:                             .rs 1
TITLE_PLAYERS_COUNT_CURSOR_0/1:               .rs 1
INF_LOOP_COUNTER_UNK:                         .rs 1


          .rsset 0x0025
KONAMI_CODE_TRIGGERED_FLAG?:                  .rs 1


          .rsset 0x0027
27_ATTRACT_WHICH?:                            .rs 1
28_BANK_CFG_INDEX?:                           .rs 1
LOWER_BANK_SAVE_PAIRED?:                      .rs 1
IRQ_BANK_VALUES:                              .rs 2


          .rsset 0x002D
IRQ_GFX_DATA_BANK_R0:                         .rs 1
IRQ_GFX_DATA_BANK_R1:                         .rs 1
ZP_R2-R5_BANK_VALUES:                         .rs 4
TURTLE_SELECT_POSITIONS:                      .rs 2


          .rsset 0x0038
CTRL_NEWLY_PRESSED_A:                         .rs 2
CTRL_PREV_A:                                  .rs 2
3C_SWITCH_CUTSCENE?:                          .rs 1
3D_UNK:                                       .rs 1
3E_UNK:                                       .rs 1
3F_ATTRACT_EXIT_FLAG:                         .rs 1
40_TIMER?:                                    .rs 2
PPU_INDEX_UNK_42:                             .rs 1


          .rsset 0x0047
47_TWO_PLAYERS_FLAG?:                         .rs 1
PPU_ADDR_IRQ:                                 .rs 2


          .rsset 0x004B
4B_SWITCH_UNK:                                .rs 1
4C_UNK:                                       .rs 1
NUM_PLAYER_LIVES:                             .rs 2


          .rsset 0x0050
IRQ_HANDLER_JMP:                              .rs 3


          .rsset 0x0056
IRQ_56_OR'D:                                  .rs 1
IRQ_LATCH_VALUE:                              .rs 1
58_IRQ_UNK:                                   .rs 1


          .rsset 0x005A
IRQ_LATCH_VALUE:                              .rs 1


          .rsset 0x005C
IRQ_EXTENDED/HANDLER:                         .rs 1
5D_IRQ_BANK?:                                 .rs 1
IRQ_UNK_5E:                                   .rs 1


          .rsset 0x0072
72_STREAM_PTR_UNK:                            .rs 2
74_STREAM_UNK:                                .rs 1
75_UNK:                                       .rs 1
76_UNK:                                       .rs 1
77_UNK:                                       .rs 1


          .rsset 0x007B
7B_UNK:                                       .rs 1
7C_UNK:                                       .rs 1


          .rsset 0x0083
83_UNK:                                       .rs 1
84_UNK:                                       .rs 1


          .rsset 0x0097
97_COPY_607:                                  .rs 1
98_UNK:                                       .rs 1
99_UNK:                                       .rs 1
9A_UNK:                                       .rs 1
9B_UNK:                                       .rs 1
9C_UNK:                                       .rs 1
9D_UNK:                                       .rs 1
9E_UNK:                                       .rs 1
9F_UNK:                                       .rs 1


          .rsset 0x00A6
IRQ_FLAG_R2-R5_EQ_7E:                         .rs 1


          .rsset 0x00AD
R_**:$00AD:                                   .rs 1
AE_ARR_UNK:                                   .rs 2


          .rsset 0x00B1
B1_SCROLL_X_COPY_IRQ_ZP:                      .rs 2


          .rsset 0x00B4
B4_ARR_UNK_NAMETABLE?:                        .rs 2


          .rsset 0x00B7
B7_UNK_SPRITES?:                              .rs 1


          .rsset 0x00BA
BA_UNK_SPRITES?:                              .rs 1


          .rsset 0x00C6
ARR_C6_UNK:                                   .rs 1
R_**:$00C7:                                   .rs 1


          .rsset 0x00D8
IRQ_D8_UNK:                                   .rs 1
IRQ_D9_UNK:                                   .rs 1


          .rsset 0x00E2
ZL_E2_SOUND_UNK:                              .rs 1


          .rsset 0x00F5
COPY_BANK_CFG_F5:                             .rs 1
COPY_BANK_CFG:                                .rs 1
MMC3_MIRRORING_COPY:                          .rs 1
CTRL_NEWLY_PRESSED_B:                         .rs 2
CTRL_PREV_B:                                  .rs 2
PPU_SCROLL_Y_COPY_IRQ:                        .rs 1
PPU_SCROLL_X_COPY_IRQ:                        .rs 1
PPU_MASK_RAM_COPY?:                           .rs 1
PPU_CTRL_RAM_COPY:                            .rs 1


          .rsset 0x010A
10A_ARR_UNK:                                  .rs 1


          .rsset 0x015B
15B_SND?_UNK:                                 .rs 1


          .rsset 0x0161
161_SND?_UNK:                                 .rs 1


          .rsset 0x0166
166_SND?_UNK:                                 .rs 1


          .rsset 0x01B4
1B4_SOUND_TRI_ZERO_FLAG:                      .rs 1


          .rsset 0x0200
SPRITE_PAGE:                                  .rs 256
PPU_UPDATE_BUFFER:                            .rs 20


          .rsset 0x03D3
3D3_UNK:                                      .rs 1
PSWAP_INDEX?:                                 .rs 1
3D5_UNK:                                      .rs 1
3D6_PSWAP_RTN_INITD:                          .rs 1
3D7_PSWAP_COUNTDOWN:                          .rs 1


          .rsset 0x03DA
3DA_PSWAP_COUNTDOWN_VAL:                      .rs 1
3DB_UNKNOWN:                                  .rs 1


          .rsset 0x03E3
LOW_BANK_DATA:                                .rs 1
UPPER_BANK_DATA:                              .rs 1
TMP_CHOOSE_BANKS_RTN_UNK:                     .rs 1


          .rsset 0x03EC
KONAMI_CODE_TRACKERS?:                        .rs 3


          .rsset 0x0400
400_ARR_SPR_ANIM_FRAME_WHICH?:                .rs 18
412_ARR_OSTATE?:                              .rs 18
ARR_OBJECT_ENABLED?:                          .rs 18
436_ARR_UNK:                                  .rs 18
448_ARR_UNK:                                  .rs 18
45A_ARR_UNK:                                  .rs 18
46C_ARR_UNK:                                  .rs 18
47E_ARR_UNK:                                  .rs 18
490_ARR_UNK:                                  .rs 18
4A2_ARR_UNK:                                  .rs 18
4B4_ARR_UNK:                                  .rs 18
4C6_ARR_UNK:                                  .rs 18
4D8_ARR_UNK:                                  .rs 18
4EA_ARR_UNK:                                  .rs 18
4FC_ARR_UNK:                                  .rs 18
50E_ARR_UNK:                                  .rs 18
520_ARR_UNK:                                  .rs 18
532_ARR_UNK:                                  .rs 18
544_ARR_UNK:                                  .rs 18
556_ARR_UNK:                                  .rs 18
568_OBJ_DATA_PTR_UNK_L:                       .rs 18
57A_OBJ_DATA_PTR_UNK_H:                       .rs 18
58C_ARR_UNK:                                  .rs 18
59E_ARR_UNK:                                  .rs 18
5B0_ARR_UNK:                                  .rs 18
5C2_OBJ_DATA_PTR_STREAM_INDEX:                .rs 18
5D4_ARR_OBJ_TIMER?:                           .rs 18


          .rsset 0x0601
601_IRQ_INC_Y_FLAG:                           .rs 1


          .rsset 0x0606
606_NMI_SWITCH_STATE_UNK:                     .rs 1
607_UNK:                                      .rs 1


          .rsset 0x060D
R2_TO_R5_BANK_DATA:                           .rs 4


          .rsset 0x0612
612_UNK:                                      .rs 1


          .rsset 0x0615
STATE_TURTLE_SELECT:                          .rs 1
PPU_FLAG_UNK:                                 .rs 1


          .rsset 0x061B
61B_FLAG_UNK:                                 .rs 1
61C_UNK:                                      .rs 1


          .rsset 0x0628
628_UNK:                                      .rs 1


          .rsset 0x0636
636_UNK:                                      .rs 1
R_**:$0637:                                   .rs 1
R_**:$0638:                                   .rs 1


          .rsset 0x063B
63B_TEXT_FADE_OUT_DONE?:                      .rs 1


          .rsset 0x063E
63E_SWITCH_CUTSCENE_NOT_FINISHED_FLAG?:       .rs 1


          .rsset 0x0640
FLAG_UPDATE_P1_HEALTH?:                       .rs 1
PPU_ADDR_UNK_A:                               .rs 2
PPU_ADDR_UNK_B:                               .rs 2


          .rsset 0x0647
FLAG_UPDATE_P2_HEALTH?:                       .rs 1


          .rsset 0x064E
UPDATE_PPU_UNK:                               .rs 1


          .rsset 0x0656
656_ARR_AE_COPY_UNK:                          .rs 2


          .rsset 0x0659
PPU_SCROLL_X_COPY_IRQ:                        .rs 1


          .rsset 0x065C
NAMETABLE_VAR_UNK:                            .rs 1


          .rsset 0x065F
FLAG_IRQ_65F:                                 .rs 1
FLAG_IRQ_660:                                 .rs 1


          .rsset 0x066D
66D_LEVEL_SELECT_WHICH:                       .rs 1


          .rsset 0x06D7
ARR_6D7_UNK:                                  .rs 40


          .rsset 0x06D9
PPU_PALETTE_BUF?:                             .rs 32


          .rsset 0x0701
701_TSELECT_CONFIRMED/TIMER:                  .rs 1
ARR_SPRITE_OBJ_TIMER?:                        .rs 2


          .rsset 0x071C
R_**:$071C:                                   .rs 1


          .rsset 0x072E
R_**:$072E:                                   .rs 1


          .rsset 0x0740
740_UNK:                                      .rs 1
