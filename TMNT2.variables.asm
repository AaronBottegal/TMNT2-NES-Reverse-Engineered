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
TMP_06?:                                      .rs 1
ZP_07_UNK:                                    .rs 1
TMP_08_INDIRECT:                              .rs 2


          .rsset 0x000B
R_**:$000B:                                   .rs 1
ZP_0C_UNK:                                    .rs 1
ZP_0D_UNK:                                    .rs 1
ZP_0E_UNK:                                    .rs 1
TMP_0F?:                                      .rs 1


          .rsset 0x0011
ZP_11_UNK:                                    .rs 1
ZP_12_UNK:                                    .rs 1
ZP_13_UNK:                                    .rs 1
R_**:$0014:                                   .rs 1
R_**:$0015:                                   .rs 1
R_**:$0016:                                   .rs 1
R_**:$0017:                                   .rs 1
STATE_SWITCH_18:                              .rs 1
19_SUBSTATE_18?:                              .rs 1


          .rsset 0x001B
IRQ_COUNT?:                                   .rs 1
FLAG_NMI_ALT_UNK:                             .rs 1
DISABLE_RENDERING_X_FRAMES:                   .rs 1
INDEX_300_UPDATE_BUF:                         .rs 1


          .rsset 0x0022
INF_LOOP_COUNTER_UNK:                         .rs 1


          .rsset 0x0028
28_BANK_CFG_INDEX_UNK:                        .rs 1
LOWER_BANK_SAVE_PAIRED?:                      .rs 1
IRQ_BANK_VALUES:                              .rs 2


          .rsset 0x002D
IRQ_GFX_DATA_BANK_R0:                         .rs 1
IRQ_GFX_DATA_BANK_R1:                         .rs 1
ZP_R2-R5_BANK_VALUES:                         .rs 4
R_**:$0033:                                   .rs 1
R_**:$0034:                                   .rs 1


          .rsset 0x0038
CTRL_NEWLY_PRESSED_A:                         .rs 2
CTRL_PREV_A:                                  .rs 2
3C_SWITCH_UNK:                                .rs 1


          .rsset 0x0040
40_TIMER?:                                    .rs 2
PPU_INDEX_UNK_42:                             .rs 1


          .rsset 0x0047
R_**:$0047:                                   .rs 1
PPU_ADDR_IRQ:                                 .rs 2


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


          .rsset 0x00A6
IRQ_FLAG_R2-R5_EQ_7E:                         .rs 1


          .rsset 0x00AD
R_**:$00AD:                                   .rs 1
R_**:$00AE:                                   .rs 1


          .rsset 0x00B1
R_**:$00B1:                                   .rs 1


          .rsset 0x00B4
R_**:$00B4:                                   .rs 1


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
PPU_UPDATE_BUF:                               .rs 1


          .rsset 0x03E3
LOW_BANK_DATA:                                .rs 1
UPPER_BANK_DATA:                              .rs 1


          .rsset 0x0400
ARR_400_ANIM_UPDATE?:                         .rs 1


          .rsset 0x0424
ARR_424_UNK:                                  .rs 1


          .rsset 0x0436
436_ARR_UNK:                                  .rs 1


          .rsset 0x046C
ARR_46C_UNK:                                  .rs 1


          .rsset 0x047E
ARR_47E_UNK:                                  .rs 1


          .rsset 0x04A2
R_**:$04A2:                                   .rs 1


          .rsset 0x0556
ARR_556_UNK:                                  .rs 1


          .rsset 0x0601
601_IRQ_INC_Y_FLAG:                           .rs 1


          .rsset 0x0606
606_NMI_SWITCH_STATE_UNK:                     .rs 1


          .rsset 0x060D
R2_TO_R5_BANK_DATA:                           .rs 4


          .rsset 0x0612
612_UNK:                                      .rs 1


          .rsset 0x0616
PPU_FLAG_UNK:                                 .rs 1


          .rsset 0x061B
61B_FLAG_UNK:                                 .rs 1


          .rsset 0x0636
R_**:$0636:                                   .rs 1
R_**:$0637:                                   .rs 1
R_**:$0638:                                   .rs 1


          .rsset 0x0640
FLAG_UPDATE_P1_HEALTH?:                       .rs 1
PPU_ADDR_UNK_A:                               .rs 2
PPU_ADDR_UNK_B:                               .rs 2


          .rsset 0x0647
FLAG_UPDATE_P2_HEALTH?:                       .rs 1


          .rsset 0x064E
UPDATE_PPU_UNK:                               .rs 1


          .rsset 0x0656
R_**:$0656:                                   .rs 1


          .rsset 0x0659
PPU_SCROLL_X_COPY_IRQ:                        .rs 1


          .rsset 0x065C
NAMETABLE_VAR_UNK:                            .rs 1


          .rsset 0x065F
FLAG_IRQ_65F:                                 .rs 1
FLAG_IRQ_660:                                 .rs 1


          .rsset 0x06D7
ARR_6D7_UNK:                                  .rs 40


          .rsset 0x06D9
BUF_UNK:                                      .rs 8


          .rsset 0x06DA
R_**:$06DA:                                   .rs 1
R_**:$06DB:                                   .rs 1


          .rsset 0x071C
R_**:$071C:                                   .rs 1


          .rsset 0x072E
R_**:$072E:                                   .rs 1
