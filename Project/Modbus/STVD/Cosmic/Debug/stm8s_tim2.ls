   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  47                     ; 46 void TIM2_DeInit(void)
  47                     ; 47 {
  49                     	switch	.text
  50  0000               _TIM2_DeInit:
  54                     ; 49     TIM2->CR1 = (uint8_t)TIM2_CR1_RESET_VALUE;
  56  0000 725f5300      	clr	21248
  57                     ; 50     TIM2->IER = (uint8_t)TIM2_IER_RESET_VALUE;
  59  0004 725f5301      	clr	21249
  60                     ; 51     TIM2->SR2 = (uint8_t)TIM2_SR2_RESET_VALUE;
  62  0008 725f5303      	clr	21251
  63                     ; 54     TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  65  000c 725f5308      	clr	21256
  66                     ; 55     TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  68  0010 725f5309      	clr	21257
  69                     ; 59     TIM2->CCER1 = (uint8_t)TIM2_CCER1_RESET_VALUE;
  71  0014 725f5308      	clr	21256
  72                     ; 60     TIM2->CCER2 = (uint8_t)TIM2_CCER2_RESET_VALUE;
  74  0018 725f5309      	clr	21257
  75                     ; 61     TIM2->CCMR1 = (uint8_t)TIM2_CCMR1_RESET_VALUE;
  77  001c 725f5305      	clr	21253
  78                     ; 62     TIM2->CCMR2 = (uint8_t)TIM2_CCMR2_RESET_VALUE;
  80  0020 725f5306      	clr	21254
  81                     ; 63     TIM2->CCMR3 = (uint8_t)TIM2_CCMR3_RESET_VALUE;
  83  0024 725f5307      	clr	21255
  84                     ; 64     TIM2->CNTRH = (uint8_t)TIM2_CNTRH_RESET_VALUE;
  86  0028 725f530a      	clr	21258
  87                     ; 65     TIM2->CNTRL = (uint8_t)TIM2_CNTRL_RESET_VALUE;
  89  002c 725f530b      	clr	21259
  90                     ; 66     TIM2->PSCR = (uint8_t)TIM2_PSCR_RESET_VALUE;
  92  0030 725f530c      	clr	21260
  93                     ; 67     TIM2->ARRH  = (uint8_t)TIM2_ARRH_RESET_VALUE;
  95  0034 35ff530d      	mov	21261,#255
  96                     ; 68     TIM2->ARRL  = (uint8_t)TIM2_ARRL_RESET_VALUE;
  98  0038 35ff530e      	mov	21262,#255
  99                     ; 69     TIM2->CCR1H = (uint8_t)TIM2_CCR1H_RESET_VALUE;
 101  003c 725f530f      	clr	21263
 102                     ; 70     TIM2->CCR1L = (uint8_t)TIM2_CCR1L_RESET_VALUE;
 104  0040 725f5310      	clr	21264
 105                     ; 71     TIM2->CCR2H = (uint8_t)TIM2_CCR2H_RESET_VALUE;
 107  0044 725f5311      	clr	21265
 108                     ; 72     TIM2->CCR2L = (uint8_t)TIM2_CCR2L_RESET_VALUE;
 110  0048 725f5312      	clr	21266
 111                     ; 73     TIM2->CCR3H = (uint8_t)TIM2_CCR3H_RESET_VALUE;
 113  004c 725f5313      	clr	21267
 114                     ; 74     TIM2->CCR3L = (uint8_t)TIM2_CCR3L_RESET_VALUE;
 116  0050 725f5314      	clr	21268
 117                     ; 75     TIM2->SR1 = (uint8_t)TIM2_SR1_RESET_VALUE;
 119  0054 725f5302      	clr	21250
 120                     ; 76 }
 123  0058 81            	ret	
 291                     ; 85 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 291                     ; 86                         uint16_t TIM2_Period)
 291                     ; 87 {
 292                     	switch	.text
 293  0059               _TIM2_TimeBaseInit:
 295  0059 88            	push	a
 296       00000000      OFST:	set	0
 299                     ; 89     TIM2->PSCR = (uint8_t)(TIM2_Prescaler);
 301  005a c7530c        	ld	21260,a
 302                     ; 91     TIM2->ARRH = (uint8_t)(TIM2_Period >> 8);
 304  005d 7b04          	ld	a,(OFST+4,sp)
 305  005f c7530d        	ld	21261,a
 306                     ; 92     TIM2->ARRL = (uint8_t)(TIM2_Period);
 308  0062 7b05          	ld	a,(OFST+5,sp)
 309  0064 c7530e        	ld	21262,a
 310                     ; 93 }
 313  0067 84            	pop	a
 314  0068 81            	ret	
 472                     ; 104 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 472                     ; 105                   TIM2_OutputState_TypeDef TIM2_OutputState,
 472                     ; 106                   uint16_t TIM2_Pulse,
 472                     ; 107                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 472                     ; 108 {
 473                     	switch	.text
 474  0069               _TIM2_OC1Init:
 476  0069 89            	pushw	x
 477  006a 88            	push	a
 478       00000001      OFST:	set	1
 481                     ; 110     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 483  006b 9e            	ld	a,xh
 484  006c 4d            	tnz	a
 485  006d 271e          	jreq	L61
 486  006f 9e            	ld	a,xh
 487  0070 a110          	cp	a,#16
 488  0072 2719          	jreq	L61
 489  0074 9e            	ld	a,xh
 490  0075 a120          	cp	a,#32
 491  0077 2714          	jreq	L61
 492  0079 9e            	ld	a,xh
 493  007a a130          	cp	a,#48
 494  007c 270f          	jreq	L61
 495  007e 9e            	ld	a,xh
 496  007f a160          	cp	a,#96
 497  0081 270a          	jreq	L61
 498  0083 9e            	ld	a,xh
 499  0084 a170          	cp	a,#112
 500  0086 2705          	jreq	L61
 501  0088 ae006e        	ldw	x,#110
 502  008b ad4b          	call	LC001
 503  008d               L61:
 504                     ; 111     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 506  008d 7b03          	ld	a,(OFST+2,sp)
 507  008f 2709          	jreq	L62
 508  0091 a111          	cp	a,#17
 509  0093 2705          	jreq	L62
 510  0095 ae006f        	ldw	x,#111
 511  0098 ad3e          	call	LC001
 512  009a               L62:
 513                     ; 112     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 515  009a 7b08          	ld	a,(OFST+7,sp)
 516  009c 2709          	jreq	L63
 517  009e a122          	cp	a,#34
 518  00a0 2705          	jreq	L63
 519  00a2 ae0070        	ldw	x,#112
 520  00a5 ad31          	call	LC001
 521  00a7               L63:
 522                     ; 115     TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
 524  00a7 c65308        	ld	a,21256
 525  00aa a4fc          	and	a,#252
 526  00ac c75308        	ld	21256,a
 527                     ; 117     TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER1_CC1E ) | 
 527                     ; 118                              (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC1P));
 529  00af 7b08          	ld	a,(OFST+7,sp)
 530  00b1 a402          	and	a,#2
 531  00b3 6b01          	ld	(OFST+0,sp),a
 532  00b5 7b03          	ld	a,(OFST+2,sp)
 533  00b7 a401          	and	a,#1
 534  00b9 1a01          	or	a,(OFST+0,sp)
 535  00bb ca5308        	or	a,21256
 536  00be c75308        	ld	21256,a
 537                     ; 121     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM)) |
 537                     ; 122                             (uint8_t)TIM2_OCMode);
 539  00c1 c65305        	ld	a,21253
 540  00c4 a48f          	and	a,#143
 541  00c6 1a02          	or	a,(OFST+1,sp)
 542  00c8 c75305        	ld	21253,a
 543                     ; 125     TIM2->CCR1H = (uint8_t)(TIM2_Pulse >> 8);
 545  00cb 7b06          	ld	a,(OFST+5,sp)
 546  00cd c7530f        	ld	21263,a
 547                     ; 126     TIM2->CCR1L = (uint8_t)(TIM2_Pulse);
 549  00d0 7b07          	ld	a,(OFST+6,sp)
 550  00d2 c75310        	ld	21264,a
 551                     ; 127 }
 554  00d5 5b03          	addw	sp,#3
 555  00d7 81            	ret	
 556  00d8               LC001:
 557  00d8 89            	pushw	x
 558  00d9 5f            	clrw	x
 559  00da 89            	pushw	x
 560  00db ae0000        	ldw	x,#L702
 561  00de cd0000        	call	_assert_failed
 563  00e1 5b04          	addw	sp,#4
 564  00e3 81            	ret	
 629                     ; 138 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 629                     ; 139                   TIM2_OutputState_TypeDef TIM2_OutputState,
 629                     ; 140                   uint16_t TIM2_Pulse,
 629                     ; 141                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 629                     ; 142 {
 630                     	switch	.text
 631  00e4               _TIM2_OC2Init:
 633  00e4 89            	pushw	x
 634  00e5 88            	push	a
 635       00000001      OFST:	set	1
 638                     ; 144     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 640  00e6 9e            	ld	a,xh
 641  00e7 4d            	tnz	a
 642  00e8 271e          	jreq	L05
 643  00ea 9e            	ld	a,xh
 644  00eb a110          	cp	a,#16
 645  00ed 2719          	jreq	L05
 646  00ef 9e            	ld	a,xh
 647  00f0 a120          	cp	a,#32
 648  00f2 2714          	jreq	L05
 649  00f4 9e            	ld	a,xh
 650  00f5 a130          	cp	a,#48
 651  00f7 270f          	jreq	L05
 652  00f9 9e            	ld	a,xh
 653  00fa a160          	cp	a,#96
 654  00fc 270a          	jreq	L05
 655  00fe 9e            	ld	a,xh
 656  00ff a170          	cp	a,#112
 657  0101 2705          	jreq	L05
 658  0103 ae0090        	ldw	x,#144
 659  0106 ad4b          	call	LC002
 660  0108               L05:
 661                     ; 145     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 663  0108 7b03          	ld	a,(OFST+2,sp)
 664  010a 2709          	jreq	L06
 665  010c a111          	cp	a,#17
 666  010e 2705          	jreq	L06
 667  0110 ae0091        	ldw	x,#145
 668  0113 ad3e          	call	LC002
 669  0115               L06:
 670                     ; 146     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 672  0115 7b08          	ld	a,(OFST+7,sp)
 673  0117 2709          	jreq	L07
 674  0119 a122          	cp	a,#34
 675  011b 2705          	jreq	L07
 676  011d ae0092        	ldw	x,#146
 677  0120 ad31          	call	LC002
 678  0122               L07:
 679                     ; 150     TIM2->CCER1 &= (uint8_t)(~( TIM2_CCER1_CC2E |  TIM2_CCER1_CC2P ));
 681  0122 c65308        	ld	a,21256
 682  0125 a4cf          	and	a,#207
 683  0127 c75308        	ld	21256,a
 684                     ; 152     TIM2->CCER1 |= (uint8_t)((uint8_t)(TIM2_OutputState  & TIM2_CCER1_CC2E ) |
 684                     ; 153                         (uint8_t)(TIM2_OCPolarity & TIM2_CCER1_CC2P));
 686  012a 7b08          	ld	a,(OFST+7,sp)
 687  012c a420          	and	a,#32
 688  012e 6b01          	ld	(OFST+0,sp),a
 689  0130 7b03          	ld	a,(OFST+2,sp)
 690  0132 a410          	and	a,#16
 691  0134 1a01          	or	a,(OFST+0,sp)
 692  0136 ca5308        	or	a,21256
 693  0139 c75308        	ld	21256,a
 694                     ; 157     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM)) | 
 694                     ; 158                             (uint8_t)TIM2_OCMode);
 696  013c c65306        	ld	a,21254
 697  013f a48f          	and	a,#143
 698  0141 1a02          	or	a,(OFST+1,sp)
 699  0143 c75306        	ld	21254,a
 700                     ; 162     TIM2->CCR2H = (uint8_t)(TIM2_Pulse >> 8);
 702  0146 7b06          	ld	a,(OFST+5,sp)
 703  0148 c75311        	ld	21265,a
 704                     ; 163     TIM2->CCR2L = (uint8_t)(TIM2_Pulse);
 706  014b 7b07          	ld	a,(OFST+6,sp)
 707  014d c75312        	ld	21266,a
 708                     ; 164 }
 711  0150 5b03          	addw	sp,#3
 712  0152 81            	ret	
 713  0153               LC002:
 714  0153 89            	pushw	x
 715  0154 5f            	clrw	x
 716  0155 89            	pushw	x
 717  0156 ae0000        	ldw	x,#L702
 718  0159 cd0000        	call	_assert_failed
 720  015c 5b04          	addw	sp,#4
 721  015e 81            	ret	
 786                     ; 175 void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 786                     ; 176                   TIM2_OutputState_TypeDef TIM2_OutputState,
 786                     ; 177                   uint16_t TIM2_Pulse,
 786                     ; 178                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 786                     ; 179 {
 787                     	switch	.text
 788  015f               _TIM2_OC3Init:
 790  015f 89            	pushw	x
 791  0160 88            	push	a
 792       00000001      OFST:	set	1
 795                     ; 181     assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 797  0161 9e            	ld	a,xh
 798  0162 4d            	tnz	a
 799  0163 271e          	jreq	L201
 800  0165 9e            	ld	a,xh
 801  0166 a110          	cp	a,#16
 802  0168 2719          	jreq	L201
 803  016a 9e            	ld	a,xh
 804  016b a120          	cp	a,#32
 805  016d 2714          	jreq	L201
 806  016f 9e            	ld	a,xh
 807  0170 a130          	cp	a,#48
 808  0172 270f          	jreq	L201
 809  0174 9e            	ld	a,xh
 810  0175 a160          	cp	a,#96
 811  0177 270a          	jreq	L201
 812  0179 9e            	ld	a,xh
 813  017a a170          	cp	a,#112
 814  017c 2705          	jreq	L201
 815  017e ae00b5        	ldw	x,#181
 816  0181 ad4b          	call	LC003
 817  0183               L201:
 818                     ; 182     assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 820  0183 7b03          	ld	a,(OFST+2,sp)
 821  0185 2709          	jreq	L211
 822  0187 a111          	cp	a,#17
 823  0189 2705          	jreq	L211
 824  018b ae00b6        	ldw	x,#182
 825  018e ad3e          	call	LC003
 826  0190               L211:
 827                     ; 183     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 829  0190 7b08          	ld	a,(OFST+7,sp)
 830  0192 2709          	jreq	L221
 831  0194 a122          	cp	a,#34
 832  0196 2705          	jreq	L221
 833  0198 ae00b7        	ldw	x,#183
 834  019b ad31          	call	LC003
 835  019d               L221:
 836                     ; 185     TIM2->CCER2 &= (uint8_t)(~( TIM2_CCER2_CC3E  | TIM2_CCER2_CC3P));
 838  019d c65309        	ld	a,21257
 839  01a0 a4fc          	and	a,#252
 840  01a2 c75309        	ld	21257,a
 841                     ; 187     TIM2->CCER2 |= (uint8_t)((uint8_t)(TIM2_OutputState & TIM2_CCER2_CC3E) |  
 841                     ; 188                              (uint8_t)(TIM2_OCPolarity & TIM2_CCER2_CC3P));
 843  01a5 7b08          	ld	a,(OFST+7,sp)
 844  01a7 a402          	and	a,#2
 845  01a9 6b01          	ld	(OFST+0,sp),a
 846  01ab 7b03          	ld	a,(OFST+2,sp)
 847  01ad a401          	and	a,#1
 848  01af 1a01          	or	a,(OFST+0,sp)
 849  01b1 ca5309        	or	a,21257
 850  01b4 c75309        	ld	21257,a
 851                     ; 191     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM)) |
 851                     ; 192                             (uint8_t)TIM2_OCMode);
 853  01b7 c65307        	ld	a,21255
 854  01ba a48f          	and	a,#143
 855  01bc 1a02          	or	a,(OFST+1,sp)
 856  01be c75307        	ld	21255,a
 857                     ; 195     TIM2->CCR3H = (uint8_t)(TIM2_Pulse >> 8);
 859  01c1 7b06          	ld	a,(OFST+5,sp)
 860  01c3 c75313        	ld	21267,a
 861                     ; 196     TIM2->CCR3L = (uint8_t)(TIM2_Pulse);
 863  01c6 7b07          	ld	a,(OFST+6,sp)
 864  01c8 c75314        	ld	21268,a
 865                     ; 198 }
 868  01cb 5b03          	addw	sp,#3
 869  01cd 81            	ret	
 870  01ce               LC003:
 871  01ce 89            	pushw	x
 872  01cf 5f            	clrw	x
 873  01d0 89            	pushw	x
 874  01d1 ae0000        	ldw	x,#L702
 875  01d4 cd0000        	call	_assert_failed
 877  01d7 5b04          	addw	sp,#4
 878  01d9 81            	ret	
1072                     ; 210 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
1072                     ; 211                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1072                     ; 212                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
1072                     ; 213                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1072                     ; 214                  uint8_t TIM2_ICFilter)
1072                     ; 215 {
1073                     	switch	.text
1074  01da               _TIM2_ICInit:
1076  01da 89            	pushw	x
1077       00000000      OFST:	set	0
1080                     ; 217     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
1082  01db 9e            	ld	a,xh
1083  01dc 4d            	tnz	a
1084  01dd 270f          	jreq	L431
1085  01df 9e            	ld	a,xh
1086  01e0 4a            	dec	a
1087  01e1 270b          	jreq	L431
1088  01e3 9e            	ld	a,xh
1089  01e4 a102          	cp	a,#2
1090  01e6 2706          	jreq	L431
1091  01e8 ae00d9        	ldw	x,#217
1092  01eb cd0271        	call	LC004
1093  01ee               L431:
1094                     ; 218     assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1096  01ee 7b02          	ld	a,(OFST+2,sp)
1097  01f0 2709          	jreq	L441
1098  01f2 a144          	cp	a,#68
1099  01f4 2705          	jreq	L441
1100  01f6 ae00da        	ldw	x,#218
1101  01f9 ad76          	call	LC004
1102  01fb               L441:
1103                     ; 219     assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1105  01fb 7b05          	ld	a,(OFST+5,sp)
1106  01fd a101          	cp	a,#1
1107  01ff 270d          	jreq	L451
1108  0201 a102          	cp	a,#2
1109  0203 2709          	jreq	L451
1110  0205 a103          	cp	a,#3
1111  0207 2705          	jreq	L451
1112  0209 ae00db        	ldw	x,#219
1113  020c ad63          	call	LC004
1114  020e               L451:
1115                     ; 220     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1117  020e 7b06          	ld	a,(OFST+6,sp)
1118  0210 2711          	jreq	L461
1119  0212 a104          	cp	a,#4
1120  0214 270d          	jreq	L461
1121  0216 a108          	cp	a,#8
1122  0218 2709          	jreq	L461
1123  021a a10c          	cp	a,#12
1124  021c 2705          	jreq	L461
1125  021e ae00dc        	ldw	x,#220
1126  0221 ad4e          	call	LC004
1127  0223               L461:
1128                     ; 221     assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));
1130  0223 7b07          	ld	a,(OFST+7,sp)
1131  0225 a110          	cp	a,#16
1132  0227 2505          	jrult	L271
1133  0229 ae00dd        	ldw	x,#221
1134  022c ad43          	call	LC004
1135  022e               L271:
1136                     ; 223     if (TIM2_Channel == TIM2_CHANNEL_1)
1138  022e 7b01          	ld	a,(OFST+1,sp)
1139  0230 2614          	jrne	L304
1140                     ; 226         TI1_Config((uint8_t)TIM2_ICPolarity,
1140                     ; 227                    (uint8_t)TIM2_ICSelection,
1140                     ; 228                    (uint8_t)TIM2_ICFilter);
1142  0232 7b07          	ld	a,(OFST+7,sp)
1143  0234 88            	push	a
1144  0235 7b06          	ld	a,(OFST+6,sp)
1145  0237 97            	ld	xl,a
1146  0238 7b03          	ld	a,(OFST+3,sp)
1147  023a 95            	ld	xh,a
1148  023b cd08cb        	call	L3_TI1_Config
1150  023e 84            	pop	a
1151                     ; 231         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1153  023f 7b06          	ld	a,(OFST+6,sp)
1154  0241 cd070b        	call	_TIM2_SetIC1Prescaler
1157  0244 2029          	jra	L504
1158  0246               L304:
1159                     ; 233     else if (TIM2_Channel == TIM2_CHANNEL_2)
1161  0246 4a            	dec	a
1162  0247 2614          	jrne	L704
1163                     ; 236         TI2_Config((uint8_t)TIM2_ICPolarity,
1163                     ; 237                    (uint8_t)TIM2_ICSelection,
1163                     ; 238                    (uint8_t)TIM2_ICFilter);
1165  0249 7b07          	ld	a,(OFST+7,sp)
1166  024b 88            	push	a
1167  024c 7b06          	ld	a,(OFST+6,sp)
1168  024e 97            	ld	xl,a
1169  024f 7b03          	ld	a,(OFST+3,sp)
1170  0251 95            	ld	xh,a
1171  0252 cd08fb        	call	L5_TI2_Config
1173  0255 84            	pop	a
1174                     ; 241         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1176  0256 7b06          	ld	a,(OFST+6,sp)
1177  0258 cd0735        	call	_TIM2_SetIC2Prescaler
1180  025b 2012          	jra	L504
1181  025d               L704:
1182                     ; 246         TI3_Config((uint8_t)TIM2_ICPolarity,
1182                     ; 247                    (uint8_t)TIM2_ICSelection,
1182                     ; 248                    (uint8_t)TIM2_ICFilter);
1184  025d 7b07          	ld	a,(OFST+7,sp)
1185  025f 88            	push	a
1186  0260 7b06          	ld	a,(OFST+6,sp)
1187  0262 97            	ld	xl,a
1188  0263 7b03          	ld	a,(OFST+3,sp)
1189  0265 95            	ld	xh,a
1190  0266 cd092b        	call	L7_TI3_Config
1192  0269 84            	pop	a
1193                     ; 251         TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
1195  026a 7b06          	ld	a,(OFST+6,sp)
1196  026c cd075f        	call	_TIM2_SetIC3Prescaler
1198  026f               L504:
1199                     ; 253 }
1202  026f 85            	popw	x
1203  0270 81            	ret	
1204  0271               LC004:
1205  0271 89            	pushw	x
1206  0272 5f            	clrw	x
1207  0273 89            	pushw	x
1208  0274 ae0000        	ldw	x,#L702
1209  0277 cd0000        	call	_assert_failed
1211  027a 5b04          	addw	sp,#4
1212  027c 81            	ret	
1309                     ; 265 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
1309                     ; 266                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1309                     ; 267                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
1309                     ; 268                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1309                     ; 269                      uint8_t TIM2_ICFilter)
1309                     ; 270 {
1310                     	switch	.text
1311  027d               _TIM2_PWMIConfig:
1313  027d 89            	pushw	x
1314  027e 89            	pushw	x
1315       00000002      OFST:	set	2
1318                     ; 271     uint8_t icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1320                     ; 272     uint8_t icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1322                     ; 275     assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_Channel));
1324  027f 9e            	ld	a,xh
1325  0280 4d            	tnz	a
1326  0281 270a          	jreq	L022
1327  0283 9e            	ld	a,xh
1328  0284 4a            	dec	a
1329  0285 2706          	jreq	L022
1330  0287 ae0113        	ldw	x,#275
1331  028a cd0330        	call	LC005
1332  028d               L022:
1333                     ; 276     assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1335  028d 7b04          	ld	a,(OFST+2,sp)
1336  028f 270a          	jreq	L032
1337  0291 a144          	cp	a,#68
1338  0293 2706          	jreq	L032
1339  0295 ae0114        	ldw	x,#276
1340  0298 cd0330        	call	LC005
1341  029b               L032:
1342                     ; 277     assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1344  029b 7b07          	ld	a,(OFST+5,sp)
1345  029d a101          	cp	a,#1
1346  029f 270e          	jreq	L042
1347  02a1 a102          	cp	a,#2
1348  02a3 270a          	jreq	L042
1349  02a5 a103          	cp	a,#3
1350  02a7 2706          	jreq	L042
1351  02a9 ae0115        	ldw	x,#277
1352  02ac cd0330        	call	LC005
1353  02af               L042:
1354                     ; 278     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1356  02af 7b08          	ld	a,(OFST+6,sp)
1357  02b1 2711          	jreq	L052
1358  02b3 a104          	cp	a,#4
1359  02b5 270d          	jreq	L052
1360  02b7 a108          	cp	a,#8
1361  02b9 2709          	jreq	L052
1362  02bb a10c          	cp	a,#12
1363  02bd 2705          	jreq	L052
1364  02bf ae0116        	ldw	x,#278
1365  02c2 ad6c          	call	LC005
1366  02c4               L052:
1367                     ; 281     if (TIM2_ICPolarity != TIM2_ICPOLARITY_FALLING)
1369  02c4 7b04          	ld	a,(OFST+2,sp)
1370  02c6 a144          	cp	a,#68
1371  02c8 2706          	jreq	L164
1372                     ; 283         icpolarity = (uint8_t)TIM2_ICPOLARITY_FALLING;
1374  02ca a644          	ld	a,#68
1375  02cc 6b01          	ld	(OFST-1,sp),a
1377  02ce 2002          	jra	L364
1378  02d0               L164:
1379                     ; 287         icpolarity = (uint8_t)TIM2_ICPOLARITY_RISING;
1381  02d0 0f01          	clr	(OFST-1,sp)
1382  02d2               L364:
1383                     ; 291     if (TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
1385  02d2 7b07          	ld	a,(OFST+5,sp)
1386  02d4 4a            	dec	a
1387  02d5 2604          	jrne	L564
1388                     ; 293         icselection = (uint8_t)TIM2_ICSELECTION_INDIRECTTI;
1390  02d7 a602          	ld	a,#2
1392  02d9 2002          	jra	L764
1393  02db               L564:
1394                     ; 297         icselection = (uint8_t)TIM2_ICSELECTION_DIRECTTI;
1396  02db a601          	ld	a,#1
1397  02dd               L764:
1398  02dd 6b02          	ld	(OFST+0,sp),a
1399                     ; 300     if (TIM2_Channel == TIM2_CHANNEL_1)
1401  02df 7b03          	ld	a,(OFST+1,sp)
1402  02e1 2626          	jrne	L174
1403                     ; 303         TI1_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1403                     ; 304                    (uint8_t)TIM2_ICFilter);
1405  02e3 7b09          	ld	a,(OFST+7,sp)
1406  02e5 88            	push	a
1407  02e6 7b08          	ld	a,(OFST+6,sp)
1408  02e8 97            	ld	xl,a
1409  02e9 7b05          	ld	a,(OFST+3,sp)
1410  02eb 95            	ld	xh,a
1411  02ec cd08cb        	call	L3_TI1_Config
1413  02ef 84            	pop	a
1414                     ; 307         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1416  02f0 7b08          	ld	a,(OFST+6,sp)
1417  02f2 cd070b        	call	_TIM2_SetIC1Prescaler
1419                     ; 310         TI2_Config(icpolarity, icselection, TIM2_ICFilter);
1421  02f5 7b09          	ld	a,(OFST+7,sp)
1422  02f7 88            	push	a
1423  02f8 7b03          	ld	a,(OFST+1,sp)
1424  02fa 97            	ld	xl,a
1425  02fb 7b02          	ld	a,(OFST+0,sp)
1426  02fd 95            	ld	xh,a
1427  02fe cd08fb        	call	L5_TI2_Config
1429  0301 84            	pop	a
1430                     ; 313         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1432  0302 7b08          	ld	a,(OFST+6,sp)
1433  0304 cd0735        	call	_TIM2_SetIC2Prescaler
1436  0307 2024          	jra	L374
1437  0309               L174:
1438                     ; 318         TI2_Config((uint8_t)TIM2_ICPolarity, (uint8_t)TIM2_ICSelection,
1438                     ; 319                    (uint8_t)TIM2_ICFilter);
1440  0309 7b09          	ld	a,(OFST+7,sp)
1441  030b 88            	push	a
1442  030c 7b08          	ld	a,(OFST+6,sp)
1443  030e 97            	ld	xl,a
1444  030f 7b05          	ld	a,(OFST+3,sp)
1445  0311 95            	ld	xh,a
1446  0312 cd08fb        	call	L5_TI2_Config
1448  0315 84            	pop	a
1449                     ; 322         TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1451  0316 7b08          	ld	a,(OFST+6,sp)
1452  0318 cd0735        	call	_TIM2_SetIC2Prescaler
1454                     ; 325         TI1_Config((uint8_t)icpolarity, icselection, (uint8_t)TIM2_ICFilter);
1456  031b 7b09          	ld	a,(OFST+7,sp)
1457  031d 88            	push	a
1458  031e 7b03          	ld	a,(OFST+1,sp)
1459  0320 97            	ld	xl,a
1460  0321 7b02          	ld	a,(OFST+0,sp)
1461  0323 95            	ld	xh,a
1462  0324 cd08cb        	call	L3_TI1_Config
1464  0327 84            	pop	a
1465                     ; 328         TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1467  0328 7b08          	ld	a,(OFST+6,sp)
1468  032a cd070b        	call	_TIM2_SetIC1Prescaler
1470  032d               L374:
1471                     ; 330 }
1474  032d 5b04          	addw	sp,#4
1475  032f 81            	ret	
1476  0330               LC005:
1477  0330 89            	pushw	x
1478  0331 5f            	clrw	x
1479  0332 89            	pushw	x
1480  0333 ae0000        	ldw	x,#L702
1481  0336 cd0000        	call	_assert_failed
1483  0339 5b04          	addw	sp,#4
1484  033b 81            	ret	
1540                     ; 339 void TIM2_Cmd(FunctionalState NewState)
1540                     ; 340 {
1541                     	switch	.text
1542  033c               _TIM2_Cmd:
1544  033c 88            	push	a
1545       00000000      OFST:	set	0
1548                     ; 342     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1550  033d 4d            	tnz	a
1551  033e 2711          	jreq	L203
1552  0340 4a            	dec	a
1553  0341 270e          	jreq	L203
1554  0343 ae0156        	ldw	x,#342
1555  0346 89            	pushw	x
1556  0347 5f            	clrw	x
1557  0348 89            	pushw	x
1558  0349 ae0000        	ldw	x,#L702
1559  034c cd0000        	call	_assert_failed
1561  034f 5b04          	addw	sp,#4
1562  0351               L203:
1563                     ; 345     if (NewState != DISABLE)
1565  0351 7b01          	ld	a,(OFST+1,sp)
1566  0353 2706          	jreq	L325
1567                     ; 347         TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
1569  0355 72105300      	bset	21248,#0
1571  0359 2004          	jra	L525
1572  035b               L325:
1573                     ; 351         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_CEN);
1575  035b 72115300      	bres	21248,#0
1576  035f               L525:
1577                     ; 353 }
1580  035f 84            	pop	a
1581  0360 81            	ret	
1661                     ; 369 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
1661                     ; 370 {
1662                     	switch	.text
1663  0361               _TIM2_ITConfig:
1665  0361 89            	pushw	x
1666       00000000      OFST:	set	0
1669                     ; 372     assert_param(IS_TIM2_IT_OK(TIM2_IT));
1671  0362 9e            	ld	a,xh
1672  0363 4d            	tnz	a
1673  0364 2705          	jreq	L013
1674  0366 9e            	ld	a,xh
1675  0367 a110          	cp	a,#16
1676  0369 2505          	jrult	L213
1677  036b               L013:
1678  036b ae0174        	ldw	x,#372
1679  036e ad22          	call	LC006
1680  0370               L213:
1681                     ; 373     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1683  0370 7b02          	ld	a,(OFST+2,sp)
1684  0372 2708          	jreq	L223
1685  0374 4a            	dec	a
1686  0375 2705          	jreq	L223
1687  0377 ae0175        	ldw	x,#373
1688  037a ad16          	call	LC006
1689  037c               L223:
1690                     ; 375     if (NewState != DISABLE)
1692  037c 7b02          	ld	a,(OFST+2,sp)
1693  037e 2707          	jreq	L565
1694                     ; 378         TIM2->IER |= (uint8_t)TIM2_IT;
1696  0380 c65301        	ld	a,21249
1697  0383 1a01          	or	a,(OFST+1,sp)
1699  0385 2006          	jra	L765
1700  0387               L565:
1701                     ; 383         TIM2->IER &= (uint8_t)(~TIM2_IT);
1703  0387 7b01          	ld	a,(OFST+1,sp)
1704  0389 43            	cpl	a
1705  038a c45301        	and	a,21249
1706  038d               L765:
1707  038d c75301        	ld	21249,a
1708                     ; 385 }
1711  0390 85            	popw	x
1712  0391 81            	ret	
1713  0392               LC006:
1714  0392 89            	pushw	x
1715  0393 5f            	clrw	x
1716  0394 89            	pushw	x
1717  0395 ae0000        	ldw	x,#L702
1718  0398 cd0000        	call	_assert_failed
1720  039b 5b04          	addw	sp,#4
1721  039d 81            	ret	
1758                     ; 394 void TIM2_UpdateDisableConfig(FunctionalState NewState)
1758                     ; 395 {
1759                     	switch	.text
1760  039e               _TIM2_UpdateDisableConfig:
1762  039e 88            	push	a
1763       00000000      OFST:	set	0
1766                     ; 397     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1768  039f 4d            	tnz	a
1769  03a0 2711          	jreq	L433
1770  03a2 4a            	dec	a
1771  03a3 270e          	jreq	L433
1772  03a5 ae018d        	ldw	x,#397
1773  03a8 89            	pushw	x
1774  03a9 5f            	clrw	x
1775  03aa 89            	pushw	x
1776  03ab ae0000        	ldw	x,#L702
1777  03ae cd0000        	call	_assert_failed
1779  03b1 5b04          	addw	sp,#4
1780  03b3               L433:
1781                     ; 400     if (NewState != DISABLE)
1783  03b3 7b01          	ld	a,(OFST+1,sp)
1784  03b5 2706          	jreq	L706
1785                     ; 402         TIM2->CR1 |= (uint8_t)TIM2_CR1_UDIS;
1787  03b7 72125300      	bset	21248,#1
1789  03bb 2004          	jra	L116
1790  03bd               L706:
1791                     ; 406         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_UDIS);
1793  03bd 72135300      	bres	21248,#1
1794  03c1               L116:
1795                     ; 408 }
1798  03c1 84            	pop	a
1799  03c2 81            	ret	
1858                     ; 418 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
1858                     ; 419 {
1859                     	switch	.text
1860  03c3               _TIM2_UpdateRequestConfig:
1862  03c3 88            	push	a
1863       00000000      OFST:	set	0
1866                     ; 421     assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));
1868  03c4 4d            	tnz	a
1869  03c5 2711          	jreq	L643
1870  03c7 4a            	dec	a
1871  03c8 270e          	jreq	L643
1872  03ca ae01a5        	ldw	x,#421
1873  03cd 89            	pushw	x
1874  03ce 5f            	clrw	x
1875  03cf 89            	pushw	x
1876  03d0 ae0000        	ldw	x,#L702
1877  03d3 cd0000        	call	_assert_failed
1879  03d6 5b04          	addw	sp,#4
1880  03d8               L643:
1881                     ; 424     if (TIM2_UpdateSource != TIM2_UPDATESOURCE_GLOBAL)
1883  03d8 7b01          	ld	a,(OFST+1,sp)
1884  03da 2706          	jreq	L146
1885                     ; 426         TIM2->CR1 |= (uint8_t)TIM2_CR1_URS;
1887  03dc 72145300      	bset	21248,#2
1889  03e0 2004          	jra	L346
1890  03e2               L146:
1891                     ; 430         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_URS);
1893  03e2 72155300      	bres	21248,#2
1894  03e6               L346:
1895                     ; 432 }
1898  03e6 84            	pop	a
1899  03e7 81            	ret	
1957                     ; 443 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
1957                     ; 444 {
1958                     	switch	.text
1959  03e8               _TIM2_SelectOnePulseMode:
1961  03e8 88            	push	a
1962       00000000      OFST:	set	0
1965                     ; 446     assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));
1967  03e9 a101          	cp	a,#1
1968  03eb 2711          	jreq	L063
1969  03ed 4d            	tnz	a
1970  03ee 270e          	jreq	L063
1971  03f0 ae01be        	ldw	x,#446
1972  03f3 89            	pushw	x
1973  03f4 5f            	clrw	x
1974  03f5 89            	pushw	x
1975  03f6 ae0000        	ldw	x,#L702
1976  03f9 cd0000        	call	_assert_failed
1978  03fc 5b04          	addw	sp,#4
1979  03fe               L063:
1980                     ; 449     if (TIM2_OPMode != TIM2_OPMODE_REPETITIVE)
1982  03fe 7b01          	ld	a,(OFST+1,sp)
1983  0400 2706          	jreq	L376
1984                     ; 451         TIM2->CR1 |= (uint8_t)TIM2_CR1_OPM;
1986  0402 72165300      	bset	21248,#3
1988  0406 2004          	jra	L576
1989  0408               L376:
1990                     ; 455         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_OPM);
1992  0408 72175300      	bres	21248,#3
1993  040c               L576:
1994                     ; 458 }
1997  040c 84            	pop	a
1998  040d 81            	ret	
2067                     ; 489 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
2067                     ; 490                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
2067                     ; 491 {
2068                     	switch	.text
2069  040e               _TIM2_PrescalerConfig:
2071  040e 89            	pushw	x
2072       00000000      OFST:	set	0
2075                     ; 493     assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
2077  040f 9f            	ld	a,xl
2078  0410 4d            	tnz	a
2079  0411 2709          	jreq	L273
2080  0413 9f            	ld	a,xl
2081  0414 4a            	dec	a
2082  0415 2705          	jreq	L273
2083  0417 ae01ed        	ldw	x,#493
2084  041a ad51          	call	LC007
2085  041c               L273:
2086                     ; 494     assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
2088  041c 7b01          	ld	a,(OFST+1,sp)
2089  041e 2743          	jreq	L204
2090  0420 a101          	cp	a,#1
2091  0422 273f          	jreq	L204
2092  0424 a102          	cp	a,#2
2093  0426 273b          	jreq	L204
2094  0428 a103          	cp	a,#3
2095  042a 2737          	jreq	L204
2096  042c a104          	cp	a,#4
2097  042e 2733          	jreq	L204
2098  0430 a105          	cp	a,#5
2099  0432 272f          	jreq	L204
2100  0434 a106          	cp	a,#6
2101  0436 272b          	jreq	L204
2102  0438 a107          	cp	a,#7
2103  043a 2727          	jreq	L204
2104  043c a108          	cp	a,#8
2105  043e 2723          	jreq	L204
2106  0440 a109          	cp	a,#9
2107  0442 271f          	jreq	L204
2108  0444 a10a          	cp	a,#10
2109  0446 271b          	jreq	L204
2110  0448 a10b          	cp	a,#11
2111  044a 2717          	jreq	L204
2112  044c a10c          	cp	a,#12
2113  044e 2713          	jreq	L204
2114  0450 a10d          	cp	a,#13
2115  0452 270f          	jreq	L204
2116  0454 a10e          	cp	a,#14
2117  0456 270b          	jreq	L204
2118  0458 a10f          	cp	a,#15
2119  045a 2707          	jreq	L204
2120  045c ae01ee        	ldw	x,#494
2121  045f ad0c          	call	LC007
2122  0461 7b01          	ld	a,(OFST+1,sp)
2123  0463               L204:
2124                     ; 497     TIM2->PSCR = (uint8_t)Prescaler;
2126  0463 c7530c        	ld	21260,a
2127                     ; 500     TIM2->EGR = (uint8_t)TIM2_PSCReloadMode;
2129  0466 7b02          	ld	a,(OFST+2,sp)
2130  0468 c75304        	ld	21252,a
2131                     ; 501 }
2134  046b 85            	popw	x
2135  046c 81            	ret	
2136  046d               LC007:
2137  046d 89            	pushw	x
2138  046e 5f            	clrw	x
2139  046f 89            	pushw	x
2140  0470 ae0000        	ldw	x,#L702
2141  0473 cd0000        	call	_assert_failed
2143  0476 5b04          	addw	sp,#4
2144  0478 81            	ret	
2203                     ; 512 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
2203                     ; 513 {
2204                     	switch	.text
2205  0479               _TIM2_ForcedOC1Config:
2207  0479 88            	push	a
2208       00000000      OFST:	set	0
2211                     ; 515     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
2213  047a a150          	cp	a,#80
2214  047c 2712          	jreq	L414
2215  047e a140          	cp	a,#64
2216  0480 270e          	jreq	L414
2217  0482 ae0203        	ldw	x,#515
2218  0485 89            	pushw	x
2219  0486 5f            	clrw	x
2220  0487 89            	pushw	x
2221  0488 ae0000        	ldw	x,#L702
2222  048b cd0000        	call	_assert_failed
2224  048e 5b04          	addw	sp,#4
2225  0490               L414:
2226                     ; 518     TIM2->CCMR1  =  (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))  
2226                     ; 519                               | (uint8_t)TIM2_ForcedAction);
2228  0490 c65305        	ld	a,21253
2229  0493 a48f          	and	a,#143
2230  0495 1a01          	or	a,(OFST+1,sp)
2231  0497 c75305        	ld	21253,a
2232                     ; 520 }
2235  049a 84            	pop	a
2236  049b 81            	ret	
2273                     ; 531 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
2273                     ; 532 {
2274                     	switch	.text
2275  049c               _TIM2_ForcedOC2Config:
2277  049c 88            	push	a
2278       00000000      OFST:	set	0
2281                     ; 534     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
2283  049d a150          	cp	a,#80
2284  049f 2712          	jreq	L624
2285  04a1 a140          	cp	a,#64
2286  04a3 270e          	jreq	L624
2287  04a5 ae0216        	ldw	x,#534
2288  04a8 89            	pushw	x
2289  04a9 5f            	clrw	x
2290  04aa 89            	pushw	x
2291  04ab ae0000        	ldw	x,#L702
2292  04ae cd0000        	call	_assert_failed
2294  04b1 5b04          	addw	sp,#4
2295  04b3               L624:
2296                     ; 537     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))  
2296                     ; 538                             | (uint8_t)TIM2_ForcedAction);
2298  04b3 c65306        	ld	a,21254
2299  04b6 a48f          	and	a,#143
2300  04b8 1a01          	or	a,(OFST+1,sp)
2301  04ba c75306        	ld	21254,a
2302                     ; 539 }
2305  04bd 84            	pop	a
2306  04be 81            	ret	
2343                     ; 550 void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
2343                     ; 551 {
2344                     	switch	.text
2345  04bf               _TIM2_ForcedOC3Config:
2347  04bf 88            	push	a
2348       00000000      OFST:	set	0
2351                     ; 553     assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
2353  04c0 a150          	cp	a,#80
2354  04c2 2712          	jreq	L044
2355  04c4 a140          	cp	a,#64
2356  04c6 270e          	jreq	L044
2357  04c8 ae0229        	ldw	x,#553
2358  04cb 89            	pushw	x
2359  04cc 5f            	clrw	x
2360  04cd 89            	pushw	x
2361  04ce ae0000        	ldw	x,#L702
2362  04d1 cd0000        	call	_assert_failed
2364  04d4 5b04          	addw	sp,#4
2365  04d6               L044:
2366                     ; 556     TIM2->CCMR3  =  (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
2366                     ; 557                               | (uint8_t)TIM2_ForcedAction);
2368  04d6 c65307        	ld	a,21255
2369  04d9 a48f          	and	a,#143
2370  04db 1a01          	or	a,(OFST+1,sp)
2371  04dd c75307        	ld	21255,a
2372                     ; 558 }
2375  04e0 84            	pop	a
2376  04e1 81            	ret	
2413                     ; 567 void TIM2_ARRPreloadConfig(FunctionalState NewState)
2413                     ; 568 {
2414                     	switch	.text
2415  04e2               _TIM2_ARRPreloadConfig:
2417  04e2 88            	push	a
2418       00000000      OFST:	set	0
2421                     ; 570     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2423  04e3 4d            	tnz	a
2424  04e4 2711          	jreq	L254
2425  04e6 4a            	dec	a
2426  04e7 270e          	jreq	L254
2427  04e9 ae023a        	ldw	x,#570
2428  04ec 89            	pushw	x
2429  04ed 5f            	clrw	x
2430  04ee 89            	pushw	x
2431  04ef ae0000        	ldw	x,#L702
2432  04f2 cd0000        	call	_assert_failed
2434  04f5 5b04          	addw	sp,#4
2435  04f7               L254:
2436                     ; 573     if (NewState != DISABLE)
2438  04f7 7b01          	ld	a,(OFST+1,sp)
2439  04f9 2706          	jreq	L1301
2440                     ; 575         TIM2->CR1 |= (uint8_t)TIM2_CR1_ARPE;
2442  04fb 721e5300      	bset	21248,#7
2444  04ff 2004          	jra	L3301
2445  0501               L1301:
2446                     ; 579         TIM2->CR1 &= (uint8_t)(~TIM2_CR1_ARPE);
2448  0501 721f5300      	bres	21248,#7
2449  0505               L3301:
2450                     ; 581 }
2453  0505 84            	pop	a
2454  0506 81            	ret	
2491                     ; 590 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2491                     ; 591 {
2492                     	switch	.text
2493  0507               _TIM2_OC1PreloadConfig:
2495  0507 88            	push	a
2496       00000000      OFST:	set	0
2499                     ; 593     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2501  0508 4d            	tnz	a
2502  0509 2711          	jreq	L464
2503  050b 4a            	dec	a
2504  050c 270e          	jreq	L464
2505  050e ae0251        	ldw	x,#593
2506  0511 89            	pushw	x
2507  0512 5f            	clrw	x
2508  0513 89            	pushw	x
2509  0514 ae0000        	ldw	x,#L702
2510  0517 cd0000        	call	_assert_failed
2512  051a 5b04          	addw	sp,#4
2513  051c               L464:
2514                     ; 596     if (NewState != DISABLE)
2516  051c 7b01          	ld	a,(OFST+1,sp)
2517  051e 2706          	jreq	L3501
2518                     ; 598         TIM2->CCMR1 |= (uint8_t)TIM2_CCMR_OCxPE;
2520  0520 72165305      	bset	21253,#3
2522  0524 2004          	jra	L5501
2523  0526               L3501:
2524                     ; 602         TIM2->CCMR1 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2526  0526 72175305      	bres	21253,#3
2527  052a               L5501:
2528                     ; 604 }
2531  052a 84            	pop	a
2532  052b 81            	ret	
2569                     ; 613 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2569                     ; 614 {
2570                     	switch	.text
2571  052c               _TIM2_OC2PreloadConfig:
2573  052c 88            	push	a
2574       00000000      OFST:	set	0
2577                     ; 616     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2579  052d 4d            	tnz	a
2580  052e 2711          	jreq	L674
2581  0530 4a            	dec	a
2582  0531 270e          	jreq	L674
2583  0533 ae0268        	ldw	x,#616
2584  0536 89            	pushw	x
2585  0537 5f            	clrw	x
2586  0538 89            	pushw	x
2587  0539 ae0000        	ldw	x,#L702
2588  053c cd0000        	call	_assert_failed
2590  053f 5b04          	addw	sp,#4
2591  0541               L674:
2592                     ; 619     if (NewState != DISABLE)
2594  0541 7b01          	ld	a,(OFST+1,sp)
2595  0543 2706          	jreq	L5701
2596                     ; 621         TIM2->CCMR2 |= (uint8_t)TIM2_CCMR_OCxPE;
2598  0545 72165306      	bset	21254,#3
2600  0549 2004          	jra	L7701
2601  054b               L5701:
2602                     ; 625         TIM2->CCMR2 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2604  054b 72175306      	bres	21254,#3
2605  054f               L7701:
2606                     ; 627 }
2609  054f 84            	pop	a
2610  0550 81            	ret	
2647                     ; 636 void TIM2_OC3PreloadConfig(FunctionalState NewState)
2647                     ; 637 {
2648                     	switch	.text
2649  0551               _TIM2_OC3PreloadConfig:
2651  0551 88            	push	a
2652       00000000      OFST:	set	0
2655                     ; 639     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2657  0552 4d            	tnz	a
2658  0553 2711          	jreq	L015
2659  0555 4a            	dec	a
2660  0556 270e          	jreq	L015
2661  0558 ae027f        	ldw	x,#639
2662  055b 89            	pushw	x
2663  055c 5f            	clrw	x
2664  055d 89            	pushw	x
2665  055e ae0000        	ldw	x,#L702
2666  0561 cd0000        	call	_assert_failed
2668  0564 5b04          	addw	sp,#4
2669  0566               L015:
2670                     ; 642     if (NewState != DISABLE)
2672  0566 7b01          	ld	a,(OFST+1,sp)
2673  0568 2706          	jreq	L7111
2674                     ; 644         TIM2->CCMR3 |= (uint8_t)TIM2_CCMR_OCxPE;
2676  056a 72165307      	bset	21255,#3
2678  056e 2004          	jra	L1211
2679  0570               L7111:
2680                     ; 648         TIM2->CCMR3 &= (uint8_t)(~TIM2_CCMR_OCxPE);
2682  0570 72175307      	bres	21255,#3
2683  0574               L1211:
2684                     ; 650 }
2687  0574 84            	pop	a
2688  0575 81            	ret	
2762                     ; 663 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
2762                     ; 664 {
2763                     	switch	.text
2764  0576               _TIM2_GenerateEvent:
2766  0576 88            	push	a
2767       00000000      OFST:	set	0
2770                     ; 666     assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
2772  0577 4d            	tnz	a
2773  0578 260e          	jrne	L025
2774  057a ae029a        	ldw	x,#666
2775  057d 89            	pushw	x
2776  057e 5f            	clrw	x
2777  057f 89            	pushw	x
2778  0580 ae0000        	ldw	x,#L702
2779  0583 cd0000        	call	_assert_failed
2781  0586 5b04          	addw	sp,#4
2782  0588               L025:
2783                     ; 669     TIM2->EGR = (uint8_t)TIM2_EventSource;
2785  0588 7b01          	ld	a,(OFST+1,sp)
2786  058a c75304        	ld	21252,a
2787                     ; 670 }
2790  058d 84            	pop	a
2791  058e 81            	ret	
2828                     ; 681 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2828                     ; 682 {
2829                     	switch	.text
2830  058f               _TIM2_OC1PolarityConfig:
2832  058f 88            	push	a
2833       00000000      OFST:	set	0
2836                     ; 684     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2838  0590 4d            	tnz	a
2839  0591 2712          	jreq	L235
2840  0593 a122          	cp	a,#34
2841  0595 270e          	jreq	L235
2842  0597 ae02ac        	ldw	x,#684
2843  059a 89            	pushw	x
2844  059b 5f            	clrw	x
2845  059c 89            	pushw	x
2846  059d ae0000        	ldw	x,#L702
2847  05a0 cd0000        	call	_assert_failed
2849  05a3 5b04          	addw	sp,#4
2850  05a5               L235:
2851                     ; 687     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2853  05a5 7b01          	ld	a,(OFST+1,sp)
2854  05a7 2706          	jreq	L3711
2855                     ; 689         TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1P;
2857  05a9 72125308      	bset	21256,#1
2859  05ad 2004          	jra	L5711
2860  05af               L3711:
2861                     ; 693         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
2863  05af 72135308      	bres	21256,#1
2864  05b3               L5711:
2865                     ; 695 }
2868  05b3 84            	pop	a
2869  05b4 81            	ret	
2906                     ; 706 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2906                     ; 707 {
2907                     	switch	.text
2908  05b5               _TIM2_OC2PolarityConfig:
2910  05b5 88            	push	a
2911       00000000      OFST:	set	0
2914                     ; 709     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2916  05b6 4d            	tnz	a
2917  05b7 2712          	jreq	L445
2918  05b9 a122          	cp	a,#34
2919  05bb 270e          	jreq	L445
2920  05bd ae02c5        	ldw	x,#709
2921  05c0 89            	pushw	x
2922  05c1 5f            	clrw	x
2923  05c2 89            	pushw	x
2924  05c3 ae0000        	ldw	x,#L702
2925  05c6 cd0000        	call	_assert_failed
2927  05c9 5b04          	addw	sp,#4
2928  05cb               L445:
2929                     ; 712     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2931  05cb 7b01          	ld	a,(OFST+1,sp)
2932  05cd 2706          	jreq	L5121
2933                     ; 714         TIM2->CCER1 |= TIM2_CCER1_CC2P;
2935  05cf 721a5308      	bset	21256,#5
2937  05d3 2004          	jra	L7121
2938  05d5               L5121:
2939                     ; 718         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
2941  05d5 721b5308      	bres	21256,#5
2942  05d9               L7121:
2943                     ; 720 }
2946  05d9 84            	pop	a
2947  05da 81            	ret	
2984                     ; 731 void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2984                     ; 732 {
2985                     	switch	.text
2986  05db               _TIM2_OC3PolarityConfig:
2988  05db 88            	push	a
2989       00000000      OFST:	set	0
2992                     ; 734     assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2994  05dc 4d            	tnz	a
2995  05dd 2712          	jreq	L655
2996  05df a122          	cp	a,#34
2997  05e1 270e          	jreq	L655
2998  05e3 ae02de        	ldw	x,#734
2999  05e6 89            	pushw	x
3000  05e7 5f            	clrw	x
3001  05e8 89            	pushw	x
3002  05e9 ae0000        	ldw	x,#L702
3003  05ec cd0000        	call	_assert_failed
3005  05ef 5b04          	addw	sp,#4
3006  05f1               L655:
3007                     ; 737     if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
3009  05f1 7b01          	ld	a,(OFST+1,sp)
3010  05f3 2706          	jreq	L7321
3011                     ; 739         TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3P;
3013  05f5 72125309      	bset	21257,#1
3015  05f9 2004          	jra	L1421
3016  05fb               L7321:
3017                     ; 743         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
3019  05fb 72135309      	bres	21257,#1
3020  05ff               L1421:
3021                     ; 745 }
3024  05ff 84            	pop	a
3025  0600 81            	ret	
3071                     ; 759 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState)
3071                     ; 760 {
3072                     	switch	.text
3073  0601               _TIM2_CCxCmd:
3075  0601 89            	pushw	x
3076       00000000      OFST:	set	0
3079                     ; 762     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
3081  0602 9e            	ld	a,xh
3082  0603 4d            	tnz	a
3083  0604 270e          	jreq	L075
3084  0606 9e            	ld	a,xh
3085  0607 4a            	dec	a
3086  0608 270a          	jreq	L075
3087  060a 9e            	ld	a,xh
3088  060b a102          	cp	a,#2
3089  060d 2705          	jreq	L075
3090  060f ae02fa        	ldw	x,#762
3091  0612 ad43          	call	LC008
3092  0614               L075:
3093                     ; 763     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3095  0614 7b02          	ld	a,(OFST+2,sp)
3096  0616 2708          	jreq	L006
3097  0618 4a            	dec	a
3098  0619 2705          	jreq	L006
3099  061b ae02fb        	ldw	x,#763
3100  061e ad37          	call	LC008
3101  0620               L006:
3102                     ; 765     if (TIM2_Channel == TIM2_CHANNEL_1)
3104  0620 7b01          	ld	a,(OFST+1,sp)
3105  0622 2610          	jrne	L5621
3106                     ; 768         if (NewState != DISABLE)
3108  0624 7b02          	ld	a,(OFST+2,sp)
3109  0626 2706          	jreq	L7621
3110                     ; 770             TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC1E;
3112  0628 72105308      	bset	21256,#0
3114  062c 2027          	jra	L3721
3115  062e               L7621:
3116                     ; 774             TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3118  062e 72115308      	bres	21256,#0
3119  0632 2021          	jra	L3721
3120  0634               L5621:
3121                     ; 778     else if (TIM2_Channel == TIM2_CHANNEL_2)
3123  0634 4a            	dec	a
3124  0635 2610          	jrne	L5721
3125                     ; 781         if (NewState != DISABLE)
3127  0637 7b02          	ld	a,(OFST+2,sp)
3128  0639 2706          	jreq	L7721
3129                     ; 783             TIM2->CCER1 |= (uint8_t)TIM2_CCER1_CC2E;
3131  063b 72185308      	bset	21256,#4
3133  063f 2014          	jra	L3721
3134  0641               L7721:
3135                     ; 787             TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
3137  0641 72195308      	bres	21256,#4
3138  0645 200e          	jra	L3721
3139  0647               L5721:
3140                     ; 793         if (NewState != DISABLE)
3142  0647 7b02          	ld	a,(OFST+2,sp)
3143  0649 2706          	jreq	L5031
3144                     ; 795             TIM2->CCER2 |= (uint8_t)TIM2_CCER2_CC3E;
3146  064b 72105309      	bset	21257,#0
3148  064f 2004          	jra	L3721
3149  0651               L5031:
3150                     ; 799             TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
3152  0651 72115309      	bres	21257,#0
3153  0655               L3721:
3154                     ; 802 }
3157  0655 85            	popw	x
3158  0656 81            	ret	
3159  0657               LC008:
3160  0657 89            	pushw	x
3161  0658 5f            	clrw	x
3162  0659 89            	pushw	x
3163  065a ae0000        	ldw	x,#L702
3164  065d cd0000        	call	_assert_failed
3166  0660 5b04          	addw	sp,#4
3167  0662 81            	ret	
3213                     ; 824 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode)
3213                     ; 825 {
3214                     	switch	.text
3215  0663               _TIM2_SelectOCxM:
3217  0663 89            	pushw	x
3218       00000000      OFST:	set	0
3221                     ; 827     assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
3223  0664 9e            	ld	a,xh
3224  0665 4d            	tnz	a
3225  0666 270e          	jreq	L216
3226  0668 9e            	ld	a,xh
3227  0669 4a            	dec	a
3228  066a 270a          	jreq	L216
3229  066c 9e            	ld	a,xh
3230  066d a102          	cp	a,#2
3231  066f 2705          	jreq	L216
3232  0671 ae033b        	ldw	x,#827
3233  0674 ad5c          	call	LC009
3234  0676               L216:
3235                     ; 828     assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));
3237  0676 7b02          	ld	a,(OFST+2,sp)
3238  0678 2721          	jreq	L226
3239  067a a110          	cp	a,#16
3240  067c 271d          	jreq	L226
3241  067e a120          	cp	a,#32
3242  0680 2719          	jreq	L226
3243  0682 a130          	cp	a,#48
3244  0684 2715          	jreq	L226
3245  0686 a160          	cp	a,#96
3246  0688 2711          	jreq	L226
3247  068a a170          	cp	a,#112
3248  068c 270d          	jreq	L226
3249  068e a150          	cp	a,#80
3250  0690 2709          	jreq	L226
3251  0692 a140          	cp	a,#64
3252  0694 2705          	jreq	L226
3253  0696 ae033c        	ldw	x,#828
3254  0699 ad37          	call	LC009
3255  069b               L226:
3256                     ; 830     if (TIM2_Channel == TIM2_CHANNEL_1)
3258  069b 7b01          	ld	a,(OFST+1,sp)
3259  069d 2610          	jrne	L3331
3260                     ; 833         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
3262  069f 72115308      	bres	21256,#0
3263                     ; 836         TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_OCM))
3263                     ; 837                                | (uint8_t)TIM2_OCMode);
3265  06a3 c65305        	ld	a,21253
3266  06a6 a48f          	and	a,#143
3267  06a8 1a02          	or	a,(OFST+2,sp)
3268  06aa c75305        	ld	21253,a
3270  06ad 2021          	jra	L5331
3271  06af               L3331:
3272                     ; 839     else if (TIM2_Channel == TIM2_CHANNEL_2)
3274  06af 4a            	dec	a
3275  06b0 2610          	jrne	L7331
3276                     ; 842         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
3278  06b2 72195308      	bres	21256,#4
3279                     ; 845         TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_OCM))
3279                     ; 846                                 | (uint8_t)TIM2_OCMode);
3281  06b6 c65306        	ld	a,21254
3282  06b9 a48f          	and	a,#143
3283  06bb 1a02          	or	a,(OFST+2,sp)
3284  06bd c75306        	ld	21254,a
3286  06c0 200e          	jra	L5331
3287  06c2               L7331:
3288                     ; 851         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3E);
3290  06c2 72115309      	bres	21257,#0
3291                     ; 854         TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_OCM))
3291                     ; 855                                 | (uint8_t)TIM2_OCMode);
3293  06c6 c65307        	ld	a,21255
3294  06c9 a48f          	and	a,#143
3295  06cb 1a02          	or	a,(OFST+2,sp)
3296  06cd c75307        	ld	21255,a
3297  06d0               L5331:
3298                     ; 857 }
3301  06d0 85            	popw	x
3302  06d1 81            	ret	
3303  06d2               LC009:
3304  06d2 89            	pushw	x
3305  06d3 5f            	clrw	x
3306  06d4 89            	pushw	x
3307  06d5 ae0000        	ldw	x,#L702
3308  06d8 cd0000        	call	_assert_failed
3310  06db 5b04          	addw	sp,#4
3311  06dd 81            	ret	
3345                     ; 866 void TIM2_SetCounter(uint16_t Counter)
3345                     ; 867 {
3346                     	switch	.text
3347  06de               _TIM2_SetCounter:
3351                     ; 869     TIM2->CNTRH = (uint8_t)(Counter >> 8);
3353  06de 9e            	ld	a,xh
3354  06df c7530a        	ld	21258,a
3355                     ; 870     TIM2->CNTRL = (uint8_t)(Counter);
3357  06e2 9f            	ld	a,xl
3358  06e3 c7530b        	ld	21259,a
3359                     ; 872 }
3362  06e6 81            	ret	
3396                     ; 881 void TIM2_SetAutoreload(uint16_t Autoreload)
3396                     ; 882 {
3397                     	switch	.text
3398  06e7               _TIM2_SetAutoreload:
3402                     ; 885     TIM2->ARRH = (uint8_t)(Autoreload >> 8);
3404  06e7 9e            	ld	a,xh
3405  06e8 c7530d        	ld	21261,a
3406                     ; 886     TIM2->ARRL = (uint8_t)(Autoreload);
3408  06eb 9f            	ld	a,xl
3409  06ec c7530e        	ld	21262,a
3410                     ; 888 }
3413  06ef 81            	ret	
3447                     ; 897 void TIM2_SetCompare1(uint16_t Compare1)
3447                     ; 898 {
3448                     	switch	.text
3449  06f0               _TIM2_SetCompare1:
3453                     ; 900     TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
3455  06f0 9e            	ld	a,xh
3456  06f1 c7530f        	ld	21263,a
3457                     ; 901     TIM2->CCR1L = (uint8_t)(Compare1);
3459  06f4 9f            	ld	a,xl
3460  06f5 c75310        	ld	21264,a
3461                     ; 903 }
3464  06f8 81            	ret	
3498                     ; 912 void TIM2_SetCompare2(uint16_t Compare2)
3498                     ; 913 {
3499                     	switch	.text
3500  06f9               _TIM2_SetCompare2:
3504                     ; 915     TIM2->CCR2H = (uint8_t)(Compare2 >> 8);
3506  06f9 9e            	ld	a,xh
3507  06fa c75311        	ld	21265,a
3508                     ; 916     TIM2->CCR2L = (uint8_t)(Compare2);
3510  06fd 9f            	ld	a,xl
3511  06fe c75312        	ld	21266,a
3512                     ; 918 }
3515  0701 81            	ret	
3549                     ; 927 void TIM2_SetCompare3(uint16_t Compare3)
3549                     ; 928 {
3550                     	switch	.text
3551  0702               _TIM2_SetCompare3:
3555                     ; 930     TIM2->CCR3H = (uint8_t)(Compare3 >> 8);
3557  0702 9e            	ld	a,xh
3558  0703 c75313        	ld	21267,a
3559                     ; 931     TIM2->CCR3L = (uint8_t)(Compare3);
3561  0706 9f            	ld	a,xl
3562  0707 c75314        	ld	21268,a
3563                     ; 933 }
3566  070a 81            	ret	
3603                     ; 946 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
3603                     ; 947 {
3604                     	switch	.text
3605  070b               _TIM2_SetIC1Prescaler:
3607  070b 88            	push	a
3608       00000000      OFST:	set	0
3611                     ; 949     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));
3613  070c 4d            	tnz	a
3614  070d 271a          	jreq	L646
3615  070f a104          	cp	a,#4
3616  0711 2716          	jreq	L646
3617  0713 a108          	cp	a,#8
3618  0715 2712          	jreq	L646
3619  0717 a10c          	cp	a,#12
3620  0719 270e          	jreq	L646
3621  071b ae03b5        	ldw	x,#949
3622  071e 89            	pushw	x
3623  071f 5f            	clrw	x
3624  0720 89            	pushw	x
3625  0721 ae0000        	ldw	x,#L702
3626  0724 cd0000        	call	_assert_failed
3628  0727 5b04          	addw	sp,#4
3629  0729               L646:
3630                     ; 952     TIM2->CCMR1 = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3630                     ; 953                             | (uint8_t)TIM2_IC1Prescaler);
3632  0729 c65305        	ld	a,21253
3633  072c a4f3          	and	a,#243
3634  072e 1a01          	or	a,(OFST+1,sp)
3635  0730 c75305        	ld	21253,a
3636                     ; 954 }
3639  0733 84            	pop	a
3640  0734 81            	ret	
3677                     ; 966 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
3677                     ; 967 {
3678                     	switch	.text
3679  0735               _TIM2_SetIC2Prescaler:
3681  0735 88            	push	a
3682       00000000      OFST:	set	0
3685                     ; 969     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));
3687  0736 4d            	tnz	a
3688  0737 271a          	jreq	L066
3689  0739 a104          	cp	a,#4
3690  073b 2716          	jreq	L066
3691  073d a108          	cp	a,#8
3692  073f 2712          	jreq	L066
3693  0741 a10c          	cp	a,#12
3694  0743 270e          	jreq	L066
3695  0745 ae03c9        	ldw	x,#969
3696  0748 89            	pushw	x
3697  0749 5f            	clrw	x
3698  074a 89            	pushw	x
3699  074b ae0000        	ldw	x,#L702
3700  074e cd0000        	call	_assert_failed
3702  0751 5b04          	addw	sp,#4
3703  0753               L066:
3704                     ; 972     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3704                     ; 973                             | (uint8_t)TIM2_IC2Prescaler);
3706  0753 c65306        	ld	a,21254
3707  0756 a4f3          	and	a,#243
3708  0758 1a01          	or	a,(OFST+1,sp)
3709  075a c75306        	ld	21254,a
3710                     ; 974 }
3713  075d 84            	pop	a
3714  075e 81            	ret	
3751                     ; 986 void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
3751                     ; 987 {
3752                     	switch	.text
3753  075f               _TIM2_SetIC3Prescaler:
3755  075f 88            	push	a
3756       00000000      OFST:	set	0
3759                     ; 990     assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
3761  0760 4d            	tnz	a
3762  0761 271a          	jreq	L276
3763  0763 a104          	cp	a,#4
3764  0765 2716          	jreq	L276
3765  0767 a108          	cp	a,#8
3766  0769 2712          	jreq	L276
3767  076b a10c          	cp	a,#12
3768  076d 270e          	jreq	L276
3769  076f ae03de        	ldw	x,#990
3770  0772 89            	pushw	x
3771  0773 5f            	clrw	x
3772  0774 89            	pushw	x
3773  0775 ae0000        	ldw	x,#L702
3774  0778 cd0000        	call	_assert_failed
3776  077b 5b04          	addw	sp,#4
3777  077d               L276:
3778                     ; 992     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~TIM2_CCMR_ICxPSC))
3778                     ; 993                             | (uint8_t)TIM2_IC3Prescaler);
3780  077d c65307        	ld	a,21255
3781  0780 a4f3          	and	a,#243
3782  0782 1a01          	or	a,(OFST+1,sp)
3783  0784 c75307        	ld	21255,a
3784                     ; 994 }
3787  0787 84            	pop	a
3788  0788 81            	ret	
3840                     ; 1001 uint16_t TIM2_GetCapture1(void)
3840                     ; 1002 {
3841                     	switch	.text
3842  0789               _TIM2_GetCapture1:
3844  0789 5204          	subw	sp,#4
3845       00000004      OFST:	set	4
3848                     ; 1004     uint16_t tmpccr1 = 0;
3850                     ; 1005     uint8_t tmpccr1l=0, tmpccr1h=0;
3854                     ; 1007     tmpccr1h = TIM2->CCR1H;
3856  078b c6530f        	ld	a,21263
3857  078e 6b02          	ld	(OFST-2,sp),a
3858                     ; 1008     tmpccr1l = TIM2->CCR1L;
3860  0790 c65310        	ld	a,21264
3861  0793 6b01          	ld	(OFST-3,sp),a
3862                     ; 1010     tmpccr1 = (uint16_t)(tmpccr1l);
3864  0795 5f            	clrw	x
3865  0796 97            	ld	xl,a
3866  0797 1f03          	ldw	(OFST-1,sp),x
3867                     ; 1011     tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
3869  0799 5f            	clrw	x
3870  079a 7b02          	ld	a,(OFST-2,sp)
3871  079c 97            	ld	xl,a
3872  079d 7b04          	ld	a,(OFST+0,sp)
3873  079f 01            	rrwa	x,a
3874  07a0 1a03          	or	a,(OFST-1,sp)
3875  07a2 01            	rrwa	x,a
3876                     ; 1013     return (uint16_t)tmpccr1;
3880  07a3 5b04          	addw	sp,#4
3881  07a5 81            	ret	
3933                     ; 1021 uint16_t TIM2_GetCapture2(void)
3933                     ; 1022 {
3934                     	switch	.text
3935  07a6               _TIM2_GetCapture2:
3937  07a6 5204          	subw	sp,#4
3938       00000004      OFST:	set	4
3941                     ; 1024     uint16_t tmpccr2 = 0;
3943                     ; 1025     uint8_t tmpccr2l=0, tmpccr2h=0;
3947                     ; 1027     tmpccr2h = TIM2->CCR2H;
3949  07a8 c65311        	ld	a,21265
3950  07ab 6b02          	ld	(OFST-2,sp),a
3951                     ; 1028     tmpccr2l = TIM2->CCR2L;
3953  07ad c65312        	ld	a,21266
3954  07b0 6b01          	ld	(OFST-3,sp),a
3955                     ; 1030     tmpccr2 = (uint16_t)(tmpccr2l);
3957  07b2 5f            	clrw	x
3958  07b3 97            	ld	xl,a
3959  07b4 1f03          	ldw	(OFST-1,sp),x
3960                     ; 1031     tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
3962  07b6 5f            	clrw	x
3963  07b7 7b02          	ld	a,(OFST-2,sp)
3964  07b9 97            	ld	xl,a
3965  07ba 7b04          	ld	a,(OFST+0,sp)
3966  07bc 01            	rrwa	x,a
3967  07bd 1a03          	or	a,(OFST-1,sp)
3968  07bf 01            	rrwa	x,a
3969                     ; 1033     return (uint16_t)tmpccr2;
3973  07c0 5b04          	addw	sp,#4
3974  07c2 81            	ret	
4026                     ; 1041 uint16_t TIM2_GetCapture3(void)
4026                     ; 1042 {
4027                     	switch	.text
4028  07c3               _TIM2_GetCapture3:
4030  07c3 5204          	subw	sp,#4
4031       00000004      OFST:	set	4
4034                     ; 1044     uint16_t tmpccr3 = 0;
4036                     ; 1045     uint8_t tmpccr3l=0, tmpccr3h=0;
4040                     ; 1047     tmpccr3h = TIM2->CCR3H;
4042  07c5 c65313        	ld	a,21267
4043  07c8 6b02          	ld	(OFST-2,sp),a
4044                     ; 1048     tmpccr3l = TIM2->CCR3L;
4046  07ca c65314        	ld	a,21268
4047  07cd 6b01          	ld	(OFST-3,sp),a
4048                     ; 1050     tmpccr3 = (uint16_t)(tmpccr3l);
4050  07cf 5f            	clrw	x
4051  07d0 97            	ld	xl,a
4052  07d1 1f03          	ldw	(OFST-1,sp),x
4053                     ; 1051     tmpccr3 |= (uint16_t)((uint16_t)tmpccr3h << 8);
4055  07d3 5f            	clrw	x
4056  07d4 7b02          	ld	a,(OFST-2,sp)
4057  07d6 97            	ld	xl,a
4058  07d7 7b04          	ld	a,(OFST+0,sp)
4059  07d9 01            	rrwa	x,a
4060  07da 1a03          	or	a,(OFST-1,sp)
4061  07dc 01            	rrwa	x,a
4062                     ; 1053     return (uint16_t)tmpccr3;
4066  07dd 5b04          	addw	sp,#4
4067  07df 81            	ret	
4101                     ; 1061 uint16_t TIM2_GetCounter(void)
4101                     ; 1062 {
4102                     	switch	.text
4103  07e0               _TIM2_GetCounter:
4105  07e0 89            	pushw	x
4106       00000002      OFST:	set	2
4109                     ; 1063      uint16_t tmpcntr = 0;
4111                     ; 1065     tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
4113  07e1 c6530a        	ld	a,21258
4114  07e4 97            	ld	xl,a
4115  07e5 4f            	clr	a
4116  07e6 02            	rlwa	x,a
4117  07e7 1f01          	ldw	(OFST-1,sp),x
4118                     ; 1067     return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
4120  07e9 c6530b        	ld	a,21259
4121  07ec 5f            	clrw	x
4122  07ed 97            	ld	xl,a
4123  07ee 01            	rrwa	x,a
4124  07ef 1a02          	or	a,(OFST+0,sp)
4125  07f1 01            	rrwa	x,a
4126  07f2 1a01          	or	a,(OFST-1,sp)
4127  07f4 01            	rrwa	x,a
4130  07f5 5b02          	addw	sp,#2
4131  07f7 81            	ret	
4155                     ; 1076 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
4155                     ; 1077 {
4156                     	switch	.text
4157  07f8               _TIM2_GetPrescaler:
4161                     ; 1079     return (TIM2_Prescaler_TypeDef)(TIM2->PSCR);
4163  07f8 c6530c        	ld	a,21260
4166  07fb 81            	ret	
4306                     ; 1096 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
4306                     ; 1097 {
4307                     	switch	.text
4308  07fc               _TIM2_GetFlagStatus:
4310  07fc 89            	pushw	x
4311  07fd 89            	pushw	x
4312       00000002      OFST:	set	2
4315                     ; 1098     FlagStatus bitstatus = RESET;
4317                     ; 1099     uint8_t tim2_flag_l = 0, tim2_flag_h = 0;
4321                     ; 1102     assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
4323  07fe a30001        	cpw	x,#1
4324  0801 272c          	jreq	L617
4325  0803 a30002        	cpw	x,#2
4326  0806 2727          	jreq	L617
4327  0808 a30004        	cpw	x,#4
4328  080b 2722          	jreq	L617
4329  080d a30008        	cpw	x,#8
4330  0810 271d          	jreq	L617
4331  0812 a30200        	cpw	x,#512
4332  0815 2718          	jreq	L617
4333  0817 a30400        	cpw	x,#1024
4334  081a 2713          	jreq	L617
4335  081c a30800        	cpw	x,#2048
4336  081f 270e          	jreq	L617
4337  0821 ae044e        	ldw	x,#1102
4338  0824 89            	pushw	x
4339  0825 5f            	clrw	x
4340  0826 89            	pushw	x
4341  0827 ae0000        	ldw	x,#L702
4342  082a cd0000        	call	_assert_failed
4344  082d 5b04          	addw	sp,#4
4345  082f               L617:
4346                     ; 1104     tim2_flag_l = (uint8_t)(TIM2->SR1 & (uint8_t)TIM2_FLAG);
4348  082f c65302        	ld	a,21250
4349  0832 1404          	and	a,(OFST+2,sp)
4350  0834 6b01          	ld	(OFST-1,sp),a
4351                     ; 1105     tim2_flag_h = (uint8_t)((uint16_t)TIM2_FLAG >> 8);
4353  0836 7b03          	ld	a,(OFST+1,sp)
4354  0838 6b02          	ld	(OFST+0,sp),a
4355                     ; 1107     if ((tim2_flag_l | (uint8_t)(TIM2->SR2 & tim2_flag_h)) != (uint8_t)RESET )
4357  083a c45303        	and	a,21251
4358  083d 1a01          	or	a,(OFST-1,sp)
4359  083f 2702          	jreq	L7371
4360                     ; 1109         bitstatus = SET;
4362  0841 a601          	ld	a,#1
4364  0843               L7371:
4365                     ; 1113         bitstatus = RESET;
4367                     ; 1115     return (FlagStatus)bitstatus;
4371  0843 5b04          	addw	sp,#4
4372  0845 81            	ret	
4408                     ; 1132 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
4408                     ; 1133 {
4409                     	switch	.text
4410  0846               _TIM2_ClearFlag:
4412  0846 89            	pushw	x
4413       00000000      OFST:	set	0
4416                     ; 1135     assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
4418  0847 01            	rrwa	x,a
4419  0848 a4f0          	and	a,#240
4420  084a 01            	rrwa	x,a
4421  084b a4f1          	and	a,#241
4422  084d 01            	rrwa	x,a
4423  084e 5d            	tnzw	x
4424  084f 2604          	jrne	L427
4425  0851 1e01          	ldw	x,(OFST+1,sp)
4426  0853 260e          	jrne	L627
4427  0855               L427:
4428  0855 ae046f        	ldw	x,#1135
4429  0858 89            	pushw	x
4430  0859 5f            	clrw	x
4431  085a 89            	pushw	x
4432  085b ae0000        	ldw	x,#L702
4433  085e cd0000        	call	_assert_failed
4435  0861 5b04          	addw	sp,#4
4436  0863               L627:
4437                     ; 1138     TIM2->SR1 = (uint8_t)(~((uint8_t)(TIM2_FLAG)));
4439  0863 7b02          	ld	a,(OFST+2,sp)
4440  0865 43            	cpl	a
4441  0866 c75302        	ld	21250,a
4442                     ; 1139     TIM2->SR2 = (uint8_t)(~((uint8_t)((uint8_t)TIM2_FLAG >> 8)));
4444  0869 35ff5303      	mov	21251,#255
4445                     ; 1140 }
4448  086d 85            	popw	x
4449  086e 81            	ret	
4514                     ; 1154 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
4514                     ; 1155 {
4515                     	switch	.text
4516  086f               _TIM2_GetITStatus:
4518  086f 88            	push	a
4519  0870 89            	pushw	x
4520       00000002      OFST:	set	2
4523                     ; 1156     ITStatus bitstatus = RESET;
4525                     ; 1157     uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
4529                     ; 1160     assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
4531  0871 a101          	cp	a,#1
4532  0873 271a          	jreq	L047
4533  0875 a102          	cp	a,#2
4534  0877 2716          	jreq	L047
4535  0879 a104          	cp	a,#4
4536  087b 2712          	jreq	L047
4537  087d a108          	cp	a,#8
4538  087f 270e          	jreq	L047
4539  0881 ae0488        	ldw	x,#1160
4540  0884 89            	pushw	x
4541  0885 5f            	clrw	x
4542  0886 89            	pushw	x
4543  0887 ae0000        	ldw	x,#L702
4544  088a cd0000        	call	_assert_failed
4546  088d 5b04          	addw	sp,#4
4547  088f               L047:
4548                     ; 1162     TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
4550  088f c65302        	ld	a,21250
4551  0892 1403          	and	a,(OFST+1,sp)
4552  0894 6b01          	ld	(OFST-1,sp),a
4553                     ; 1164     TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
4555  0896 c65301        	ld	a,21249
4556  0899 1403          	and	a,(OFST+1,sp)
4557  089b 6b02          	ld	(OFST+0,sp),a
4558                     ; 1166     if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
4560  089d 7b01          	ld	a,(OFST-1,sp)
4561  089f 2708          	jreq	L3102
4563  08a1 7b02          	ld	a,(OFST+0,sp)
4564  08a3 2704          	jreq	L3102
4565                     ; 1168         bitstatus = SET;
4567  08a5 a601          	ld	a,#1
4569  08a7 2001          	jra	L5102
4570  08a9               L3102:
4571                     ; 1172         bitstatus = RESET;
4573  08a9 4f            	clr	a
4574  08aa               L5102:
4575                     ; 1174     return (ITStatus)(bitstatus);
4579  08aa 5b03          	addw	sp,#3
4580  08ac 81            	ret	
4617                     ; 1188 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
4617                     ; 1189 {
4618                     	switch	.text
4619  08ad               _TIM2_ClearITPendingBit:
4621  08ad 88            	push	a
4622       00000000      OFST:	set	0
4625                     ; 1191     assert_param(IS_TIM2_IT_OK(TIM2_IT));
4627  08ae 4d            	tnz	a
4628  08af 2704          	jreq	L647
4629  08b1 a110          	cp	a,#16
4630  08b3 250e          	jrult	L057
4631  08b5               L647:
4632  08b5 ae04a7        	ldw	x,#1191
4633  08b8 89            	pushw	x
4634  08b9 5f            	clrw	x
4635  08ba 89            	pushw	x
4636  08bb ae0000        	ldw	x,#L702
4637  08be cd0000        	call	_assert_failed
4639  08c1 5b04          	addw	sp,#4
4640  08c3               L057:
4641                     ; 1194     TIM2->SR1 = (uint8_t)(~TIM2_IT);
4643  08c3 7b01          	ld	a,(OFST+1,sp)
4644  08c5 43            	cpl	a
4645  08c6 c75302        	ld	21250,a
4646                     ; 1195 }
4649  08c9 84            	pop	a
4650  08ca 81            	ret	
4702                     ; 1214 static void TI1_Config(uint8_t TIM2_ICPolarity,
4702                     ; 1215                        uint8_t TIM2_ICSelection,
4702                     ; 1216                        uint8_t TIM2_ICFilter)
4702                     ; 1217 {
4703                     	switch	.text
4704  08cb               L3_TI1_Config:
4706  08cb 89            	pushw	x
4707  08cc 88            	push	a
4708       00000001      OFST:	set	1
4711                     ; 1219     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1E);
4713  08cd 72115308      	bres	21256,#0
4714                     ; 1222     TIM2->CCMR1  = (uint8_t)((uint8_t)(TIM2->CCMR1 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF )))
4714                     ; 1223                              | (uint8_t)(((TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4716  08d1 7b06          	ld	a,(OFST+5,sp)
4717  08d3 97            	ld	xl,a
4718  08d4 a610          	ld	a,#16
4719  08d6 42            	mul	x,a
4720  08d7 9f            	ld	a,xl
4721  08d8 1a03          	or	a,(OFST+2,sp)
4722  08da 6b01          	ld	(OFST+0,sp),a
4723  08dc c65305        	ld	a,21253
4724  08df a40c          	and	a,#12
4725  08e1 1a01          	or	a,(OFST+0,sp)
4726  08e3 c75305        	ld	21253,a
4727                     ; 1226     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4729  08e6 7b02          	ld	a,(OFST+1,sp)
4730  08e8 2706          	jreq	L3602
4731                     ; 1228         TIM2->CCER1 |= TIM2_CCER1_CC1P;
4733  08ea 72125308      	bset	21256,#1
4735  08ee 2004          	jra	L5602
4736  08f0               L3602:
4737                     ; 1232         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC1P);
4739  08f0 72135308      	bres	21256,#1
4740  08f4               L5602:
4741                     ; 1235     TIM2->CCER1 |= TIM2_CCER1_CC1E;
4743  08f4 72105308      	bset	21256,#0
4744                     ; 1236 }
4747  08f8 5b03          	addw	sp,#3
4748  08fa 81            	ret	
4800                     ; 1255 static void TI2_Config(uint8_t TIM2_ICPolarity,
4800                     ; 1256                        uint8_t TIM2_ICSelection,
4800                     ; 1257                        uint8_t TIM2_ICFilter)
4800                     ; 1258 {
4801                     	switch	.text
4802  08fb               L5_TI2_Config:
4804  08fb 89            	pushw	x
4805  08fc 88            	push	a
4806       00000001      OFST:	set	1
4809                     ; 1260     TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2E);
4811  08fd 72195308      	bres	21256,#4
4812                     ; 1263     TIM2->CCMR2 = (uint8_t)((uint8_t)(TIM2->CCMR2 & (uint8_t)(~(uint8_t)( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF ))) 
4812                     ; 1264                             | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4814  0901 7b06          	ld	a,(OFST+5,sp)
4815  0903 97            	ld	xl,a
4816  0904 a610          	ld	a,#16
4817  0906 42            	mul	x,a
4818  0907 9f            	ld	a,xl
4819  0908 1a03          	or	a,(OFST+2,sp)
4820  090a 6b01          	ld	(OFST+0,sp),a
4821  090c c65306        	ld	a,21254
4822  090f a40c          	and	a,#12
4823  0911 1a01          	or	a,(OFST+0,sp)
4824  0913 c75306        	ld	21254,a
4825                     ; 1268     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4827  0916 7b02          	ld	a,(OFST+1,sp)
4828  0918 2706          	jreq	L5112
4829                     ; 1270         TIM2->CCER1 |= TIM2_CCER1_CC2P;
4831  091a 721a5308      	bset	21256,#5
4833  091e 2004          	jra	L7112
4834  0920               L5112:
4835                     ; 1274         TIM2->CCER1 &= (uint8_t)(~TIM2_CCER1_CC2P);
4837  0920 721b5308      	bres	21256,#5
4838  0924               L7112:
4839                     ; 1278     TIM2->CCER1 |= TIM2_CCER1_CC2E;
4841  0924 72185308      	bset	21256,#4
4842                     ; 1280 }
4845  0928 5b03          	addw	sp,#3
4846  092a 81            	ret	
4898                     ; 1296 static void TI3_Config(uint8_t TIM2_ICPolarity, uint8_t TIM2_ICSelection,
4898                     ; 1297                        uint8_t TIM2_ICFilter)
4898                     ; 1298 {
4899                     	switch	.text
4900  092b               L7_TI3_Config:
4902  092b 89            	pushw	x
4903  092c 88            	push	a
4904       00000001      OFST:	set	1
4907                     ; 1300     TIM2->CCER2 &=  (uint8_t)(~TIM2_CCER2_CC3E);
4909  092d 72115309      	bres	21257,#0
4910                     ; 1303     TIM2->CCMR3 = (uint8_t)((uint8_t)(TIM2->CCMR3 & (uint8_t)(~( TIM2_CCMR_CCxS | TIM2_CCMR_ICxF))) 
4910                     ; 1304                             | (uint8_t)(( (TIM2_ICSelection)) | ((uint8_t)( TIM2_ICFilter << 4))));
4912  0931 7b06          	ld	a,(OFST+5,sp)
4913  0933 97            	ld	xl,a
4914  0934 a610          	ld	a,#16
4915  0936 42            	mul	x,a
4916  0937 9f            	ld	a,xl
4917  0938 1a03          	or	a,(OFST+2,sp)
4918  093a 6b01          	ld	(OFST+0,sp),a
4919  093c c65307        	ld	a,21255
4920  093f a40c          	and	a,#12
4921  0941 1a01          	or	a,(OFST+0,sp)
4922  0943 c75307        	ld	21255,a
4923                     ; 1308     if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4925  0946 7b02          	ld	a,(OFST+1,sp)
4926  0948 2706          	jreq	L7412
4927                     ; 1310         TIM2->CCER2 |= TIM2_CCER2_CC3P;
4929  094a 72125309      	bset	21257,#1
4931  094e 2004          	jra	L1512
4932  0950               L7412:
4933                     ; 1314         TIM2->CCER2 &= (uint8_t)(~TIM2_CCER2_CC3P);
4935  0950 72135309      	bres	21257,#1
4936  0954               L1512:
4937                     ; 1317     TIM2->CCER2 |= TIM2_CCER2_CC3E;
4939  0954 72105309      	bset	21257,#0
4940                     ; 1318 }
4943  0958 5b03          	addw	sp,#3
4944  095a 81            	ret	
4957                     	xdef	_TIM2_ClearITPendingBit
4958                     	xdef	_TIM2_GetITStatus
4959                     	xdef	_TIM2_ClearFlag
4960                     	xdef	_TIM2_GetFlagStatus
4961                     	xdef	_TIM2_GetPrescaler
4962                     	xdef	_TIM2_GetCounter
4963                     	xdef	_TIM2_GetCapture3
4964                     	xdef	_TIM2_GetCapture2
4965                     	xdef	_TIM2_GetCapture1
4966                     	xdef	_TIM2_SetIC3Prescaler
4967                     	xdef	_TIM2_SetIC2Prescaler
4968                     	xdef	_TIM2_SetIC1Prescaler
4969                     	xdef	_TIM2_SetCompare3
4970                     	xdef	_TIM2_SetCompare2
4971                     	xdef	_TIM2_SetCompare1
4972                     	xdef	_TIM2_SetAutoreload
4973                     	xdef	_TIM2_SetCounter
4974                     	xdef	_TIM2_SelectOCxM
4975                     	xdef	_TIM2_CCxCmd
4976                     	xdef	_TIM2_OC3PolarityConfig
4977                     	xdef	_TIM2_OC2PolarityConfig
4978                     	xdef	_TIM2_OC1PolarityConfig
4979                     	xdef	_TIM2_GenerateEvent
4980                     	xdef	_TIM2_OC3PreloadConfig
4981                     	xdef	_TIM2_OC2PreloadConfig
4982                     	xdef	_TIM2_OC1PreloadConfig
4983                     	xdef	_TIM2_ARRPreloadConfig
4984                     	xdef	_TIM2_ForcedOC3Config
4985                     	xdef	_TIM2_ForcedOC2Config
4986                     	xdef	_TIM2_ForcedOC1Config
4987                     	xdef	_TIM2_PrescalerConfig
4988                     	xdef	_TIM2_SelectOnePulseMode
4989                     	xdef	_TIM2_UpdateRequestConfig
4990                     	xdef	_TIM2_UpdateDisableConfig
4991                     	xdef	_TIM2_ITConfig
4992                     	xdef	_TIM2_Cmd
4993                     	xdef	_TIM2_PWMIConfig
4994                     	xdef	_TIM2_ICInit
4995                     	xdef	_TIM2_OC3Init
4996                     	xdef	_TIM2_OC2Init
4997                     	xdef	_TIM2_OC1Init
4998                     	xdef	_TIM2_TimeBaseInit
4999                     	xdef	_TIM2_DeInit
5000                     	xref	_assert_failed
5001                     .const:	section	.text
5002  0000               L702:
5003  0000 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
5004  0012 6965735c7374  	dc.b	"ies\stm8s_stdperip"
5005  0024 685f64726976  	dc.b	"h_driver\src\stm8s"
5006  0036 5f74696d322e  	dc.b	"_tim2.c",0
5026                     	end
