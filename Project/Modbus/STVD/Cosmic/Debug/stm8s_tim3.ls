   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  47                     ; 45 void TIM3_DeInit(void)
  47                     ; 46 {
  49                     	switch	.text
  50  0000               _TIM3_DeInit:
  54                     ; 48     TIM3->CR1 = (uint8_t)TIM3_CR1_RESET_VALUE;
  56  0000 725f5320      	clr	21280
  57                     ; 49     TIM3->IER = (uint8_t)TIM3_IER_RESET_VALUE;
  59  0004 725f5321      	clr	21281
  60                     ; 50     TIM3->SR2 = (uint8_t)TIM3_SR2_RESET_VALUE;
  62  0008 725f5323      	clr	21283
  63                     ; 53     TIM3->CCER1 = (uint8_t)TIM3_CCER1_RESET_VALUE;
  65  000c 725f5327      	clr	21287
  66                     ; 56     TIM3->CCER1 = (uint8_t)TIM3_CCER1_RESET_VALUE;
  68  0010 725f5327      	clr	21287
  69                     ; 57     TIM3->CCMR1 = (uint8_t)TIM3_CCMR1_RESET_VALUE;
  71  0014 725f5325      	clr	21285
  72                     ; 58     TIM3->CCMR2 = (uint8_t)TIM3_CCMR2_RESET_VALUE;
  74  0018 725f5326      	clr	21286
  75                     ; 59     TIM3->CNTRH = (uint8_t)TIM3_CNTRH_RESET_VALUE;
  77  001c 725f5328      	clr	21288
  78                     ; 60     TIM3->CNTRL = (uint8_t)TIM3_CNTRL_RESET_VALUE;
  80  0020 725f5329      	clr	21289
  81                     ; 61     TIM3->PSCR = (uint8_t)TIM3_PSCR_RESET_VALUE;
  83  0024 725f532a      	clr	21290
  84                     ; 62     TIM3->ARRH  = (uint8_t)TIM3_ARRH_RESET_VALUE;
  86  0028 35ff532b      	mov	21291,#255
  87                     ; 63     TIM3->ARRL  = (uint8_t)TIM3_ARRL_RESET_VALUE;
  89  002c 35ff532c      	mov	21292,#255
  90                     ; 64     TIM3->CCR1H = (uint8_t)TIM3_CCR1H_RESET_VALUE;
  92  0030 725f532d      	clr	21293
  93                     ; 65     TIM3->CCR1L = (uint8_t)TIM3_CCR1L_RESET_VALUE;
  95  0034 725f532e      	clr	21294
  96                     ; 66     TIM3->CCR2H = (uint8_t)TIM3_CCR2H_RESET_VALUE;
  98  0038 725f532f      	clr	21295
  99                     ; 67     TIM3->CCR2L = (uint8_t)TIM3_CCR2L_RESET_VALUE;
 101  003c 725f5330      	clr	21296
 102                     ; 68     TIM3->SR1 = (uint8_t)TIM3_SR1_RESET_VALUE;
 104  0040 725f5322      	clr	21282
 105                     ; 69 }
 108  0044 81            	ret	
 276                     ; 78 void TIM3_TimeBaseInit( TIM3_Prescaler_TypeDef TIM3_Prescaler,
 276                     ; 79                         uint16_t TIM3_Period)
 276                     ; 80 {
 277                     	switch	.text
 278  0045               _TIM3_TimeBaseInit:
 280  0045 88            	push	a
 281       00000000      OFST:	set	0
 284                     ; 82     TIM3->PSCR = (uint8_t)(TIM3_Prescaler);
 286  0046 c7532a        	ld	21290,a
 287                     ; 84     TIM3->ARRH = (uint8_t)(TIM3_Period >> 8);
 289  0049 7b04          	ld	a,(OFST+4,sp)
 290  004b c7532b        	ld	21291,a
 291                     ; 85     TIM3->ARRL = (uint8_t)(TIM3_Period);
 293  004e 7b05          	ld	a,(OFST+5,sp)
 294  0050 c7532c        	ld	21292,a
 295                     ; 86 }
 298  0053 84            	pop	a
 299  0054 81            	ret	
 457                     ; 96 void TIM3_OC1Init(TIM3_OCMode_TypeDef TIM3_OCMode,
 457                     ; 97                   TIM3_OutputState_TypeDef TIM3_OutputState,
 457                     ; 98                   uint16_t TIM3_Pulse,
 457                     ; 99                   TIM3_OCPolarity_TypeDef TIM3_OCPolarity)
 457                     ; 100 {
 458                     	switch	.text
 459  0055               _TIM3_OC1Init:
 461  0055 89            	pushw	x
 462  0056 88            	push	a
 463       00000001      OFST:	set	1
 466                     ; 102     assert_param(IS_TIM3_OC_MODE_OK(TIM3_OCMode));
 468  0057 9e            	ld	a,xh
 469  0058 4d            	tnz	a
 470  0059 271e          	jreq	L61
 471  005b 9e            	ld	a,xh
 472  005c a110          	cp	a,#16
 473  005e 2719          	jreq	L61
 474  0060 9e            	ld	a,xh
 475  0061 a120          	cp	a,#32
 476  0063 2714          	jreq	L61
 477  0065 9e            	ld	a,xh
 478  0066 a130          	cp	a,#48
 479  0068 270f          	jreq	L61
 480  006a 9e            	ld	a,xh
 481  006b a160          	cp	a,#96
 482  006d 270a          	jreq	L61
 483  006f 9e            	ld	a,xh
 484  0070 a170          	cp	a,#112
 485  0072 2705          	jreq	L61
 486  0074 ae0066        	ldw	x,#102
 487  0077 ad4b          	call	LC001
 488  0079               L61:
 489                     ; 103     assert_param(IS_TIM3_OUTPUT_STATE_OK(TIM3_OutputState));
 491  0079 7b03          	ld	a,(OFST+2,sp)
 492  007b 2709          	jreq	L62
 493  007d a111          	cp	a,#17
 494  007f 2705          	jreq	L62
 495  0081 ae0067        	ldw	x,#103
 496  0084 ad3e          	call	LC001
 497  0086               L62:
 498                     ; 104     assert_param(IS_TIM3_OC_POLARITY_OK(TIM3_OCPolarity));
 500  0086 7b08          	ld	a,(OFST+7,sp)
 501  0088 2709          	jreq	L63
 502  008a a122          	cp	a,#34
 503  008c 2705          	jreq	L63
 504  008e ae0068        	ldw	x,#104
 505  0091 ad31          	call	LC001
 506  0093               L63:
 507                     ; 107     TIM3->CCER1 &= (uint8_t)(~( TIM3_CCER1_CC1E | TIM3_CCER1_CC1P));
 509  0093 c65327        	ld	a,21287
 510  0096 a4fc          	and	a,#252
 511  0098 c75327        	ld	21287,a
 512                     ; 109     TIM3->CCER1 |= (uint8_t)((uint8_t)(TIM3_OutputState  & TIM3_CCER1_CC1E   ) | (uint8_t)(TIM3_OCPolarity   & TIM3_CCER1_CC1P   ));
 514  009b 7b08          	ld	a,(OFST+7,sp)
 515  009d a402          	and	a,#2
 516  009f 6b01          	ld	(OFST+0,sp),a
 517  00a1 7b03          	ld	a,(OFST+2,sp)
 518  00a3 a401          	and	a,#1
 519  00a5 1a01          	or	a,(OFST+0,sp)
 520  00a7 ca5327        	or	a,21287
 521  00aa c75327        	ld	21287,a
 522                     ; 112     TIM3->CCMR1 = (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_OCMode);
 524  00ad c65325        	ld	a,21285
 525  00b0 a48f          	and	a,#143
 526  00b2 1a02          	or	a,(OFST+1,sp)
 527  00b4 c75325        	ld	21285,a
 528                     ; 115     TIM3->CCR1H = (uint8_t)(TIM3_Pulse >> 8);
 530  00b7 7b06          	ld	a,(OFST+5,sp)
 531  00b9 c7532d        	ld	21293,a
 532                     ; 116     TIM3->CCR1L = (uint8_t)(TIM3_Pulse);
 534  00bc 7b07          	ld	a,(OFST+6,sp)
 535  00be c7532e        	ld	21294,a
 536                     ; 117 }
 539  00c1 5b03          	addw	sp,#3
 540  00c3 81            	ret	
 541  00c4               LC001:
 542  00c4 89            	pushw	x
 543  00c5 5f            	clrw	x
 544  00c6 89            	pushw	x
 545  00c7 ae0000        	ldw	x,#L502
 546  00ca cd0000        	call	_assert_failed
 548  00cd 5b04          	addw	sp,#4
 549  00cf 81            	ret	
 614                     ; 128 void TIM3_OC2Init(TIM3_OCMode_TypeDef TIM3_OCMode,
 614                     ; 129                   TIM3_OutputState_TypeDef TIM3_OutputState,
 614                     ; 130                   uint16_t TIM3_Pulse,
 614                     ; 131                   TIM3_OCPolarity_TypeDef TIM3_OCPolarity)
 614                     ; 132 {
 615                     	switch	.text
 616  00d0               _TIM3_OC2Init:
 618  00d0 89            	pushw	x
 619  00d1 88            	push	a
 620       00000001      OFST:	set	1
 623                     ; 134     assert_param(IS_TIM3_OC_MODE_OK(TIM3_OCMode));
 625  00d2 9e            	ld	a,xh
 626  00d3 4d            	tnz	a
 627  00d4 271e          	jreq	L05
 628  00d6 9e            	ld	a,xh
 629  00d7 a110          	cp	a,#16
 630  00d9 2719          	jreq	L05
 631  00db 9e            	ld	a,xh
 632  00dc a120          	cp	a,#32
 633  00de 2714          	jreq	L05
 634  00e0 9e            	ld	a,xh
 635  00e1 a130          	cp	a,#48
 636  00e3 270f          	jreq	L05
 637  00e5 9e            	ld	a,xh
 638  00e6 a160          	cp	a,#96
 639  00e8 270a          	jreq	L05
 640  00ea 9e            	ld	a,xh
 641  00eb a170          	cp	a,#112
 642  00ed 2705          	jreq	L05
 643  00ef ae0086        	ldw	x,#134
 644  00f2 ad4b          	call	LC002
 645  00f4               L05:
 646                     ; 135     assert_param(IS_TIM3_OUTPUT_STATE_OK(TIM3_OutputState));
 648  00f4 7b03          	ld	a,(OFST+2,sp)
 649  00f6 2709          	jreq	L06
 650  00f8 a111          	cp	a,#17
 651  00fa 2705          	jreq	L06
 652  00fc ae0087        	ldw	x,#135
 653  00ff ad3e          	call	LC002
 654  0101               L06:
 655                     ; 136     assert_param(IS_TIM3_OC_POLARITY_OK(TIM3_OCPolarity));
 657  0101 7b08          	ld	a,(OFST+7,sp)
 658  0103 2709          	jreq	L07
 659  0105 a122          	cp	a,#34
 660  0107 2705          	jreq	L07
 661  0109 ae0088        	ldw	x,#136
 662  010c ad31          	call	LC002
 663  010e               L07:
 664                     ; 140     TIM3->CCER1 &= (uint8_t)(~( TIM3_CCER1_CC2E |  TIM3_CCER1_CC2P ));
 666  010e c65327        	ld	a,21287
 667  0111 a4cf          	and	a,#207
 668  0113 c75327        	ld	21287,a
 669                     ; 142     TIM3->CCER1 |= (uint8_t)((uint8_t)(TIM3_OutputState  & TIM3_CCER1_CC2E   ) | (uint8_t)(TIM3_OCPolarity   & TIM3_CCER1_CC2P ));
 671  0116 7b08          	ld	a,(OFST+7,sp)
 672  0118 a420          	and	a,#32
 673  011a 6b01          	ld	(OFST+0,sp),a
 674  011c 7b03          	ld	a,(OFST+2,sp)
 675  011e a410          	and	a,#16
 676  0120 1a01          	or	a,(OFST+0,sp)
 677  0122 ca5327        	or	a,21287
 678  0125 c75327        	ld	21287,a
 679                     ; 146     TIM3->CCMR2 = (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_OCMode);
 681  0128 c65326        	ld	a,21286
 682  012b a48f          	and	a,#143
 683  012d 1a02          	or	a,(OFST+1,sp)
 684  012f c75326        	ld	21286,a
 685                     ; 150     TIM3->CCR2H = (uint8_t)(TIM3_Pulse >> 8);
 687  0132 7b06          	ld	a,(OFST+5,sp)
 688  0134 c7532f        	ld	21295,a
 689                     ; 151     TIM3->CCR2L = (uint8_t)(TIM3_Pulse);
 691  0137 7b07          	ld	a,(OFST+6,sp)
 692  0139 c75330        	ld	21296,a
 693                     ; 152 }
 696  013c 5b03          	addw	sp,#3
 697  013e 81            	ret	
 698  013f               LC002:
 699  013f 89            	pushw	x
 700  0140 5f            	clrw	x
 701  0141 89            	pushw	x
 702  0142 ae0000        	ldw	x,#L502
 703  0145 cd0000        	call	_assert_failed
 705  0148 5b04          	addw	sp,#4
 706  014a 81            	ret	
 891                     ; 163 void TIM3_ICInit(TIM3_Channel_TypeDef TIM3_Channel,
 891                     ; 164                  TIM3_ICPolarity_TypeDef TIM3_ICPolarity,
 891                     ; 165                  TIM3_ICSelection_TypeDef TIM3_ICSelection,
 891                     ; 166                  TIM3_ICPSC_TypeDef TIM3_ICPrescaler,
 891                     ; 167                  uint8_t TIM3_ICFilter)
 891                     ; 168 {
 892                     	switch	.text
 893  014b               _TIM3_ICInit:
 895  014b 89            	pushw	x
 896       00000000      OFST:	set	0
 899                     ; 170     assert_param(IS_TIM3_CHANNEL_OK(TIM3_Channel));
 901  014c 9e            	ld	a,xh
 902  014d 4d            	tnz	a
 903  014e 2709          	jreq	L201
 904  0150 9e            	ld	a,xh
 905  0151 4a            	dec	a
 906  0152 2705          	jreq	L201
 907  0154 ae00aa        	ldw	x,#170
 908  0157 ad6d          	call	LC003
 909  0159               L201:
 910                     ; 171     assert_param(IS_TIM3_IC_POLARITY_OK(TIM3_ICPolarity));
 912  0159 7b02          	ld	a,(OFST+2,sp)
 913  015b 2709          	jreq	L211
 914  015d a144          	cp	a,#68
 915  015f 2705          	jreq	L211
 916  0161 ae00ab        	ldw	x,#171
 917  0164 ad60          	call	LC003
 918  0166               L211:
 919                     ; 172     assert_param(IS_TIM3_IC_SELECTION_OK(TIM3_ICSelection));
 921  0166 7b05          	ld	a,(OFST+5,sp)
 922  0168 a101          	cp	a,#1
 923  016a 270d          	jreq	L221
 924  016c a102          	cp	a,#2
 925  016e 2709          	jreq	L221
 926  0170 a103          	cp	a,#3
 927  0172 2705          	jreq	L221
 928  0174 ae00ac        	ldw	x,#172
 929  0177 ad4d          	call	LC003
 930  0179               L221:
 931                     ; 173     assert_param(IS_TIM3_IC_PRESCALER_OK(TIM3_ICPrescaler));
 933  0179 7b06          	ld	a,(OFST+6,sp)
 934  017b 2711          	jreq	L231
 935  017d a104          	cp	a,#4
 936  017f 270d          	jreq	L231
 937  0181 a108          	cp	a,#8
 938  0183 2709          	jreq	L231
 939  0185 a10c          	cp	a,#12
 940  0187 2705          	jreq	L231
 941  0189 ae00ad        	ldw	x,#173
 942  018c ad38          	call	LC003
 943  018e               L231:
 944                     ; 174     assert_param(IS_TIM3_IC_FILTER_OK(TIM3_ICFilter));
 946  018e 7b07          	ld	a,(OFST+7,sp)
 947  0190 a110          	cp	a,#16
 948  0192 2505          	jrult	L041
 949  0194 ae00ae        	ldw	x,#174
 950  0197 ad2d          	call	LC003
 951  0199               L041:
 952                     ; 176     if (TIM3_Channel != TIM3_CHANNEL_2)
 954  0199 7b01          	ld	a,(OFST+1,sp)
 955  019b 4a            	dec	a
 956  019c 2714          	jreq	L543
 957                     ; 179         TI1_Config((uint8_t)TIM3_ICPolarity,
 957                     ; 180                    (uint8_t)TIM3_ICSelection,
 957                     ; 181                    (uint8_t)TIM3_ICFilter);
 959  019e 7b07          	ld	a,(OFST+7,sp)
 960  01a0 88            	push	a
 961  01a1 7b06          	ld	a,(OFST+6,sp)
 962  01a3 97            	ld	xl,a
 963  01a4 7b03          	ld	a,(OFST+3,sp)
 964  01a6 95            	ld	xh,a
 965  01a7 cd0727        	call	L3_TI1_Config
 967  01aa 84            	pop	a
 968                     ; 184         TIM3_SetIC1Prescaler(TIM3_ICPrescaler);
 970  01ab 7b06          	ld	a,(OFST+6,sp)
 971  01ad cd05ba        	call	_TIM3_SetIC1Prescaler
 974  01b0 2012          	jra	L743
 975  01b2               L543:
 976                     ; 189         TI2_Config((uint8_t)TIM3_ICPolarity,
 976                     ; 190                    (uint8_t)TIM3_ICSelection,
 976                     ; 191                    (uint8_t)TIM3_ICFilter);
 978  01b2 7b07          	ld	a,(OFST+7,sp)
 979  01b4 88            	push	a
 980  01b5 7b06          	ld	a,(OFST+6,sp)
 981  01b7 97            	ld	xl,a
 982  01b8 7b03          	ld	a,(OFST+3,sp)
 983  01ba 95            	ld	xh,a
 984  01bb cd0757        	call	L5_TI2_Config
 986  01be 84            	pop	a
 987                     ; 194         TIM3_SetIC2Prescaler(TIM3_ICPrescaler);
 989  01bf 7b06          	ld	a,(OFST+6,sp)
 990  01c1 cd05e4        	call	_TIM3_SetIC2Prescaler
 992  01c4               L743:
 993                     ; 196 }
 996  01c4 85            	popw	x
 997  01c5 81            	ret	
 998  01c6               LC003:
 999  01c6 89            	pushw	x
1000  01c7 5f            	clrw	x
1001  01c8 89            	pushw	x
1002  01c9 ae0000        	ldw	x,#L502
1003  01cc cd0000        	call	_assert_failed
1005  01cf 5b04          	addw	sp,#4
1006  01d1 81            	ret	
1103                     ; 206 void TIM3_PWMIConfig(TIM3_Channel_TypeDef TIM3_Channel,
1103                     ; 207                      TIM3_ICPolarity_TypeDef TIM3_ICPolarity,
1103                     ; 208                      TIM3_ICSelection_TypeDef TIM3_ICSelection,
1103                     ; 209                      TIM3_ICPSC_TypeDef TIM3_ICPrescaler,
1103                     ; 210                      uint8_t TIM3_ICFilter)
1103                     ; 211 {
1104                     	switch	.text
1105  01d2               _TIM3_PWMIConfig:
1107  01d2 89            	pushw	x
1108  01d3 89            	pushw	x
1109       00000002      OFST:	set	2
1112                     ; 212     uint8_t icpolarity = (uint8_t)TIM3_ICPOLARITY_RISING;
1114                     ; 213     uint8_t icselection = (uint8_t)TIM3_ICSELECTION_DIRECTTI;
1116                     ; 216     assert_param(IS_TIM3_PWMI_CHANNEL_OK(TIM3_Channel));
1118  01d4 9e            	ld	a,xh
1119  01d5 4d            	tnz	a
1120  01d6 270a          	jreq	L261
1121  01d8 9e            	ld	a,xh
1122  01d9 4a            	dec	a
1123  01da 2706          	jreq	L261
1124  01dc ae00d8        	ldw	x,#216
1125  01df cd0286        	call	LC004
1126  01e2               L261:
1127                     ; 217     assert_param(IS_TIM3_IC_POLARITY_OK(TIM3_ICPolarity));
1129  01e2 7b04          	ld	a,(OFST+2,sp)
1130  01e4 270a          	jreq	L271
1131  01e6 a144          	cp	a,#68
1132  01e8 2706          	jreq	L271
1133  01ea ae00d9        	ldw	x,#217
1134  01ed cd0286        	call	LC004
1135  01f0               L271:
1136                     ; 218     assert_param(IS_TIM3_IC_SELECTION_OK(TIM3_ICSelection));
1138  01f0 7b07          	ld	a,(OFST+5,sp)
1139  01f2 a101          	cp	a,#1
1140  01f4 270e          	jreq	L202
1141  01f6 a102          	cp	a,#2
1142  01f8 270a          	jreq	L202
1143  01fa a103          	cp	a,#3
1144  01fc 2706          	jreq	L202
1145  01fe ae00da        	ldw	x,#218
1146  0201 cd0286        	call	LC004
1147  0204               L202:
1148                     ; 219     assert_param(IS_TIM3_IC_PRESCALER_OK(TIM3_ICPrescaler));
1150  0204 7b08          	ld	a,(OFST+6,sp)
1151  0206 2711          	jreq	L212
1152  0208 a104          	cp	a,#4
1153  020a 270d          	jreq	L212
1154  020c a108          	cp	a,#8
1155  020e 2709          	jreq	L212
1156  0210 a10c          	cp	a,#12
1157  0212 2705          	jreq	L212
1158  0214 ae00db        	ldw	x,#219
1159  0217 ad6d          	call	LC004
1160  0219               L212:
1161                     ; 222     if (TIM3_ICPolarity != TIM3_ICPOLARITY_FALLING)
1163  0219 7b04          	ld	a,(OFST+2,sp)
1164  021b a144          	cp	a,#68
1165  021d 2706          	jreq	L714
1166                     ; 224         icpolarity = (uint8_t)TIM3_ICPOLARITY_FALLING;
1168  021f a644          	ld	a,#68
1169  0221 6b01          	ld	(OFST-1,sp),a
1171  0223 2002          	jra	L124
1172  0225               L714:
1173                     ; 228         icpolarity = (uint8_t)TIM3_ICPOLARITY_RISING;
1175  0225 0f01          	clr	(OFST-1,sp)
1176  0227               L124:
1177                     ; 232     if (TIM3_ICSelection == TIM3_ICSELECTION_DIRECTTI)
1179  0227 7b07          	ld	a,(OFST+5,sp)
1180  0229 4a            	dec	a
1181  022a 2604          	jrne	L324
1182                     ; 234         icselection = (uint8_t)TIM3_ICSELECTION_INDIRECTTI;
1184  022c a602          	ld	a,#2
1186  022e 2002          	jra	L524
1187  0230               L324:
1188                     ; 238         icselection = (uint8_t)TIM3_ICSELECTION_DIRECTTI;
1190  0230 a601          	ld	a,#1
1191  0232               L524:
1192  0232 6b02          	ld	(OFST+0,sp),a
1193                     ; 241     if (TIM3_Channel != TIM3_CHANNEL_2)
1195  0234 7b03          	ld	a,(OFST+1,sp)
1196  0236 4a            	dec	a
1197  0237 2726          	jreq	L724
1198                     ; 244         TI1_Config((uint8_t)TIM3_ICPolarity, (uint8_t)TIM3_ICSelection,
1198                     ; 245                    (uint8_t)TIM3_ICFilter);
1200  0239 7b09          	ld	a,(OFST+7,sp)
1201  023b 88            	push	a
1202  023c 7b08          	ld	a,(OFST+6,sp)
1203  023e 97            	ld	xl,a
1204  023f 7b05          	ld	a,(OFST+3,sp)
1205  0241 95            	ld	xh,a
1206  0242 cd0727        	call	L3_TI1_Config
1208  0245 84            	pop	a
1209                     ; 248         TIM3_SetIC1Prescaler(TIM3_ICPrescaler);
1211  0246 7b08          	ld	a,(OFST+6,sp)
1212  0248 cd05ba        	call	_TIM3_SetIC1Prescaler
1214                     ; 251         TI2_Config(icpolarity, icselection, TIM3_ICFilter);
1216  024b 7b09          	ld	a,(OFST+7,sp)
1217  024d 88            	push	a
1218  024e 7b03          	ld	a,(OFST+1,sp)
1219  0250 97            	ld	xl,a
1220  0251 7b02          	ld	a,(OFST+0,sp)
1221  0253 95            	ld	xh,a
1222  0254 cd0757        	call	L5_TI2_Config
1224  0257 84            	pop	a
1225                     ; 254         TIM3_SetIC2Prescaler(TIM3_ICPrescaler);
1227  0258 7b08          	ld	a,(OFST+6,sp)
1228  025a cd05e4        	call	_TIM3_SetIC2Prescaler
1231  025d 2024          	jra	L134
1232  025f               L724:
1233                     ; 259         TI2_Config((uint8_t)TIM3_ICPolarity, (uint8_t)TIM3_ICSelection,
1233                     ; 260                    (uint8_t)TIM3_ICFilter);
1235  025f 7b09          	ld	a,(OFST+7,sp)
1236  0261 88            	push	a
1237  0262 7b08          	ld	a,(OFST+6,sp)
1238  0264 97            	ld	xl,a
1239  0265 7b05          	ld	a,(OFST+3,sp)
1240  0267 95            	ld	xh,a
1241  0268 cd0757        	call	L5_TI2_Config
1243  026b 84            	pop	a
1244                     ; 263         TIM3_SetIC2Prescaler(TIM3_ICPrescaler);
1246  026c 7b08          	ld	a,(OFST+6,sp)
1247  026e cd05e4        	call	_TIM3_SetIC2Prescaler
1249                     ; 266         TI1_Config(icpolarity, icselection, TIM3_ICFilter);
1251  0271 7b09          	ld	a,(OFST+7,sp)
1252  0273 88            	push	a
1253  0274 7b03          	ld	a,(OFST+1,sp)
1254  0276 97            	ld	xl,a
1255  0277 7b02          	ld	a,(OFST+0,sp)
1256  0279 95            	ld	xh,a
1257  027a cd0727        	call	L3_TI1_Config
1259  027d 84            	pop	a
1260                     ; 269         TIM3_SetIC1Prescaler(TIM3_ICPrescaler);
1262  027e 7b08          	ld	a,(OFST+6,sp)
1263  0280 cd05ba        	call	_TIM3_SetIC1Prescaler
1265  0283               L134:
1266                     ; 271 }
1269  0283 5b04          	addw	sp,#4
1270  0285 81            	ret	
1271  0286               LC004:
1272  0286 89            	pushw	x
1273  0287 5f            	clrw	x
1274  0288 89            	pushw	x
1275  0289 ae0000        	ldw	x,#L502
1276  028c cd0000        	call	_assert_failed
1278  028f 5b04          	addw	sp,#4
1279  0291 81            	ret	
1335                     ; 280 void TIM3_Cmd(FunctionalState NewState)
1335                     ; 281 {
1336                     	switch	.text
1337  0292               _TIM3_Cmd:
1339  0292 88            	push	a
1340       00000000      OFST:	set	0
1343                     ; 283     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1345  0293 4d            	tnz	a
1346  0294 2711          	jreq	L442
1347  0296 4a            	dec	a
1348  0297 270e          	jreq	L442
1349  0299 ae011b        	ldw	x,#283
1350  029c 89            	pushw	x
1351  029d 5f            	clrw	x
1352  029e 89            	pushw	x
1353  029f ae0000        	ldw	x,#L502
1354  02a2 cd0000        	call	_assert_failed
1356  02a5 5b04          	addw	sp,#4
1357  02a7               L442:
1358                     ; 286     if (NewState != DISABLE)
1360  02a7 7b01          	ld	a,(OFST+1,sp)
1361  02a9 2706          	jreq	L164
1362                     ; 288         TIM3->CR1 |= (uint8_t)TIM3_CR1_CEN;
1364  02ab 72105320      	bset	21280,#0
1366  02af 2004          	jra	L364
1367  02b1               L164:
1368                     ; 292         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_CEN);
1370  02b1 72115320      	bres	21280,#0
1371  02b5               L364:
1372                     ; 294 }
1375  02b5 84            	pop	a
1376  02b6 81            	ret	
1449                     ; 309 void TIM3_ITConfig(TIM3_IT_TypeDef TIM3_IT, FunctionalState NewState)
1449                     ; 310 {
1450                     	switch	.text
1451  02b7               _TIM3_ITConfig:
1453  02b7 89            	pushw	x
1454       00000000      OFST:	set	0
1457                     ; 312     assert_param(IS_TIM3_IT_OK(TIM3_IT));
1459  02b8 9e            	ld	a,xh
1460  02b9 4d            	tnz	a
1461  02ba 2705          	jreq	L252
1462  02bc 9e            	ld	a,xh
1463  02bd a108          	cp	a,#8
1464  02bf 2505          	jrult	L452
1465  02c1               L252:
1466  02c1 ae0138        	ldw	x,#312
1467  02c4 ad22          	call	LC005
1468  02c6               L452:
1469                     ; 313     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1471  02c6 7b02          	ld	a,(OFST+2,sp)
1472  02c8 2708          	jreq	L462
1473  02ca 4a            	dec	a
1474  02cb 2705          	jreq	L462
1475  02cd ae0139        	ldw	x,#313
1476  02d0 ad16          	call	LC005
1477  02d2               L462:
1478                     ; 315     if (NewState != DISABLE)
1480  02d2 7b02          	ld	a,(OFST+2,sp)
1481  02d4 2707          	jreq	L125
1482                     ; 318         TIM3->IER |= (uint8_t)TIM3_IT;
1484  02d6 c65321        	ld	a,21281
1485  02d9 1a01          	or	a,(OFST+1,sp)
1487  02db 2006          	jra	L325
1488  02dd               L125:
1489                     ; 323         TIM3->IER &= (uint8_t)(~TIM3_IT);
1491  02dd 7b01          	ld	a,(OFST+1,sp)
1492  02df 43            	cpl	a
1493  02e0 c45321        	and	a,21281
1494  02e3               L325:
1495  02e3 c75321        	ld	21281,a
1496                     ; 325 }
1499  02e6 85            	popw	x
1500  02e7 81            	ret	
1501  02e8               LC005:
1502  02e8 89            	pushw	x
1503  02e9 5f            	clrw	x
1504  02ea 89            	pushw	x
1505  02eb ae0000        	ldw	x,#L502
1506  02ee cd0000        	call	_assert_failed
1508  02f1 5b04          	addw	sp,#4
1509  02f3 81            	ret	
1546                     ; 334 void TIM3_UpdateDisableConfig(FunctionalState NewState)
1546                     ; 335 {
1547                     	switch	.text
1548  02f4               _TIM3_UpdateDisableConfig:
1550  02f4 88            	push	a
1551       00000000      OFST:	set	0
1554                     ; 337     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1556  02f5 4d            	tnz	a
1557  02f6 2711          	jreq	L672
1558  02f8 4a            	dec	a
1559  02f9 270e          	jreq	L672
1560  02fb ae0151        	ldw	x,#337
1561  02fe 89            	pushw	x
1562  02ff 5f            	clrw	x
1563  0300 89            	pushw	x
1564  0301 ae0000        	ldw	x,#L502
1565  0304 cd0000        	call	_assert_failed
1567  0307 5b04          	addw	sp,#4
1568  0309               L672:
1569                     ; 340     if (NewState != DISABLE)
1571  0309 7b01          	ld	a,(OFST+1,sp)
1572  030b 2706          	jreq	L345
1573                     ; 342         TIM3->CR1 |= TIM3_CR1_UDIS;
1575  030d 72125320      	bset	21280,#1
1577  0311 2004          	jra	L545
1578  0313               L345:
1579                     ; 346         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_UDIS);
1581  0313 72135320      	bres	21280,#1
1582  0317               L545:
1583                     ; 348 }
1586  0317 84            	pop	a
1587  0318 81            	ret	
1646                     ; 358 void TIM3_UpdateRequestConfig(TIM3_UpdateSource_TypeDef TIM3_UpdateSource)
1646                     ; 359 {
1647                     	switch	.text
1648  0319               _TIM3_UpdateRequestConfig:
1650  0319 88            	push	a
1651       00000000      OFST:	set	0
1654                     ; 361     assert_param(IS_TIM3_UPDATE_SOURCE_OK(TIM3_UpdateSource));
1656  031a 4d            	tnz	a
1657  031b 2711          	jreq	L013
1658  031d 4a            	dec	a
1659  031e 270e          	jreq	L013
1660  0320 ae0169        	ldw	x,#361
1661  0323 89            	pushw	x
1662  0324 5f            	clrw	x
1663  0325 89            	pushw	x
1664  0326 ae0000        	ldw	x,#L502
1665  0329 cd0000        	call	_assert_failed
1667  032c 5b04          	addw	sp,#4
1668  032e               L013:
1669                     ; 364     if (TIM3_UpdateSource != TIM3_UPDATESOURCE_GLOBAL)
1671  032e 7b01          	ld	a,(OFST+1,sp)
1672  0330 2706          	jreq	L575
1673                     ; 366         TIM3->CR1 |= TIM3_CR1_URS;
1675  0332 72145320      	bset	21280,#2
1677  0336 2004          	jra	L775
1678  0338               L575:
1679                     ; 370         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_URS);
1681  0338 72155320      	bres	21280,#2
1682  033c               L775:
1683                     ; 372 }
1686  033c 84            	pop	a
1687  033d 81            	ret	
1745                     ; 383 void TIM3_SelectOnePulseMode(TIM3_OPMode_TypeDef TIM3_OPMode)
1745                     ; 384 {
1746                     	switch	.text
1747  033e               _TIM3_SelectOnePulseMode:
1749  033e 88            	push	a
1750       00000000      OFST:	set	0
1753                     ; 386     assert_param(IS_TIM3_OPM_MODE_OK(TIM3_OPMode));
1755  033f a101          	cp	a,#1
1756  0341 2711          	jreq	L223
1757  0343 4d            	tnz	a
1758  0344 270e          	jreq	L223
1759  0346 ae0182        	ldw	x,#386
1760  0349 89            	pushw	x
1761  034a 5f            	clrw	x
1762  034b 89            	pushw	x
1763  034c ae0000        	ldw	x,#L502
1764  034f cd0000        	call	_assert_failed
1766  0352 5b04          	addw	sp,#4
1767  0354               L223:
1768                     ; 389     if (TIM3_OPMode != TIM3_OPMODE_REPETITIVE)
1770  0354 7b01          	ld	a,(OFST+1,sp)
1771  0356 2706          	jreq	L726
1772                     ; 391         TIM3->CR1 |= TIM3_CR1_OPM;
1774  0358 72165320      	bset	21280,#3
1776  035c 2004          	jra	L136
1777  035e               L726:
1778                     ; 395         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_OPM);
1780  035e 72175320      	bres	21280,#3
1781  0362               L136:
1782                     ; 398 }
1785  0362 84            	pop	a
1786  0363 81            	ret	
1855                     ; 429 void TIM3_PrescalerConfig(TIM3_Prescaler_TypeDef Prescaler,
1855                     ; 430                           TIM3_PSCReloadMode_TypeDef TIM3_PSCReloadMode)
1855                     ; 431 {
1856                     	switch	.text
1857  0364               _TIM3_PrescalerConfig:
1859  0364 89            	pushw	x
1860       00000000      OFST:	set	0
1863                     ; 433     assert_param(IS_TIM3_PRESCALER_RELOAD_OK(TIM3_PSCReloadMode));
1865  0365 9f            	ld	a,xl
1866  0366 4d            	tnz	a
1867  0367 2709          	jreq	L433
1868  0369 9f            	ld	a,xl
1869  036a 4a            	dec	a
1870  036b 2705          	jreq	L433
1871  036d ae01b1        	ldw	x,#433
1872  0370 ad51          	call	LC006
1873  0372               L433:
1874                     ; 434     assert_param(IS_TIM3_PRESCALER_OK(Prescaler));
1876  0372 7b01          	ld	a,(OFST+1,sp)
1877  0374 2743          	jreq	L443
1878  0376 a101          	cp	a,#1
1879  0378 273f          	jreq	L443
1880  037a a102          	cp	a,#2
1881  037c 273b          	jreq	L443
1882  037e a103          	cp	a,#3
1883  0380 2737          	jreq	L443
1884  0382 a104          	cp	a,#4
1885  0384 2733          	jreq	L443
1886  0386 a105          	cp	a,#5
1887  0388 272f          	jreq	L443
1888  038a a106          	cp	a,#6
1889  038c 272b          	jreq	L443
1890  038e a107          	cp	a,#7
1891  0390 2727          	jreq	L443
1892  0392 a108          	cp	a,#8
1893  0394 2723          	jreq	L443
1894  0396 a109          	cp	a,#9
1895  0398 271f          	jreq	L443
1896  039a a10a          	cp	a,#10
1897  039c 271b          	jreq	L443
1898  039e a10b          	cp	a,#11
1899  03a0 2717          	jreq	L443
1900  03a2 a10c          	cp	a,#12
1901  03a4 2713          	jreq	L443
1902  03a6 a10d          	cp	a,#13
1903  03a8 270f          	jreq	L443
1904  03aa a10e          	cp	a,#14
1905  03ac 270b          	jreq	L443
1906  03ae a10f          	cp	a,#15
1907  03b0 2707          	jreq	L443
1908  03b2 ae01b2        	ldw	x,#434
1909  03b5 ad0c          	call	LC006
1910  03b7 7b01          	ld	a,(OFST+1,sp)
1911  03b9               L443:
1912                     ; 437     TIM3->PSCR = (uint8_t)Prescaler;
1914  03b9 c7532a        	ld	21290,a
1915                     ; 440     TIM3->EGR = (uint8_t)TIM3_PSCReloadMode;
1917  03bc 7b02          	ld	a,(OFST+2,sp)
1918  03be c75324        	ld	21284,a
1919                     ; 441 }
1922  03c1 85            	popw	x
1923  03c2 81            	ret	
1924  03c3               LC006:
1925  03c3 89            	pushw	x
1926  03c4 5f            	clrw	x
1927  03c5 89            	pushw	x
1928  03c6 ae0000        	ldw	x,#L502
1929  03c9 cd0000        	call	_assert_failed
1931  03cc 5b04          	addw	sp,#4
1932  03ce 81            	ret	
1991                     ; 452 void TIM3_ForcedOC1Config(TIM3_ForcedAction_TypeDef TIM3_ForcedAction)
1991                     ; 453 {
1992                     	switch	.text
1993  03cf               _TIM3_ForcedOC1Config:
1995  03cf 88            	push	a
1996       00000000      OFST:	set	0
1999                     ; 455     assert_param(IS_TIM3_FORCED_ACTION_OK(TIM3_ForcedAction));
2001  03d0 a150          	cp	a,#80
2002  03d2 2712          	jreq	L653
2003  03d4 a140          	cp	a,#64
2004  03d6 270e          	jreq	L653
2005  03d8 ae01c7        	ldw	x,#455
2006  03db 89            	pushw	x
2007  03dc 5f            	clrw	x
2008  03dd 89            	pushw	x
2009  03de ae0000        	ldw	x,#L502
2010  03e1 cd0000        	call	_assert_failed
2012  03e4 5b04          	addw	sp,#4
2013  03e6               L653:
2014                     ; 458     TIM3->CCMR1 =  (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~TIM3_CCMR_OCM))  | (uint8_t)TIM3_ForcedAction);
2016  03e6 c65325        	ld	a,21285
2017  03e9 a48f          	and	a,#143
2018  03eb 1a01          	or	a,(OFST+1,sp)
2019  03ed c75325        	ld	21285,a
2020                     ; 459 }
2023  03f0 84            	pop	a
2024  03f1 81            	ret	
2061                     ; 470 void TIM3_ForcedOC2Config(TIM3_ForcedAction_TypeDef TIM3_ForcedAction)
2061                     ; 471 {
2062                     	switch	.text
2063  03f2               _TIM3_ForcedOC2Config:
2065  03f2 88            	push	a
2066       00000000      OFST:	set	0
2069                     ; 473     assert_param(IS_TIM3_FORCED_ACTION_OK(TIM3_ForcedAction));
2071  03f3 a150          	cp	a,#80
2072  03f5 2712          	jreq	L073
2073  03f7 a140          	cp	a,#64
2074  03f9 270e          	jreq	L073
2075  03fb ae01d9        	ldw	x,#473
2076  03fe 89            	pushw	x
2077  03ff 5f            	clrw	x
2078  0400 89            	pushw	x
2079  0401 ae0000        	ldw	x,#L502
2080  0404 cd0000        	call	_assert_failed
2082  0407 5b04          	addw	sp,#4
2083  0409               L073:
2084                     ; 476     TIM3->CCMR2 =  (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_ForcedAction);
2086  0409 c65326        	ld	a,21286
2087  040c a48f          	and	a,#143
2088  040e 1a01          	or	a,(OFST+1,sp)
2089  0410 c75326        	ld	21286,a
2090                     ; 477 }
2093  0413 84            	pop	a
2094  0414 81            	ret	
2131                     ; 486 void TIM3_ARRPreloadConfig(FunctionalState NewState)
2131                     ; 487 {
2132                     	switch	.text
2133  0415               _TIM3_ARRPreloadConfig:
2135  0415 88            	push	a
2136       00000000      OFST:	set	0
2139                     ; 489     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2141  0416 4d            	tnz	a
2142  0417 2711          	jreq	L204
2143  0419 4a            	dec	a
2144  041a 270e          	jreq	L204
2145  041c ae01e9        	ldw	x,#489
2146  041f 89            	pushw	x
2147  0420 5f            	clrw	x
2148  0421 89            	pushw	x
2149  0422 ae0000        	ldw	x,#L502
2150  0425 cd0000        	call	_assert_failed
2152  0428 5b04          	addw	sp,#4
2153  042a               L204:
2154                     ; 492     if (NewState != DISABLE)
2156  042a 7b01          	ld	a,(OFST+1,sp)
2157  042c 2706          	jreq	L747
2158                     ; 494         TIM3->CR1 |= TIM3_CR1_ARPE;
2160  042e 721e5320      	bset	21280,#7
2162  0432 2004          	jra	L157
2163  0434               L747:
2164                     ; 498         TIM3->CR1 &= (uint8_t)(~TIM3_CR1_ARPE);
2166  0434 721f5320      	bres	21280,#7
2167  0438               L157:
2168                     ; 500 }
2171  0438 84            	pop	a
2172  0439 81            	ret	
2209                     ; 509 void TIM3_OC1PreloadConfig(FunctionalState NewState)
2209                     ; 510 {
2210                     	switch	.text
2211  043a               _TIM3_OC1PreloadConfig:
2213  043a 88            	push	a
2214       00000000      OFST:	set	0
2217                     ; 512     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2219  043b 4d            	tnz	a
2220  043c 2711          	jreq	L414
2221  043e 4a            	dec	a
2222  043f 270e          	jreq	L414
2223  0441 ae0200        	ldw	x,#512
2224  0444 89            	pushw	x
2225  0445 5f            	clrw	x
2226  0446 89            	pushw	x
2227  0447 ae0000        	ldw	x,#L502
2228  044a cd0000        	call	_assert_failed
2230  044d 5b04          	addw	sp,#4
2231  044f               L414:
2232                     ; 515     if (NewState != DISABLE)
2234  044f 7b01          	ld	a,(OFST+1,sp)
2235  0451 2706          	jreq	L177
2236                     ; 517         TIM3->CCMR1 |= TIM3_CCMR_OCxPE;
2238  0453 72165325      	bset	21285,#3
2240  0457 2004          	jra	L377
2241  0459               L177:
2242                     ; 521         TIM3->CCMR1 &= (uint8_t)(~TIM3_CCMR_OCxPE);
2244  0459 72175325      	bres	21285,#3
2245  045d               L377:
2246                     ; 523 }
2249  045d 84            	pop	a
2250  045e 81            	ret	
2287                     ; 532 void TIM3_OC2PreloadConfig(FunctionalState NewState)
2287                     ; 533 {
2288                     	switch	.text
2289  045f               _TIM3_OC2PreloadConfig:
2291  045f 88            	push	a
2292       00000000      OFST:	set	0
2295                     ; 535     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2297  0460 4d            	tnz	a
2298  0461 2711          	jreq	L624
2299  0463 4a            	dec	a
2300  0464 270e          	jreq	L624
2301  0466 ae0217        	ldw	x,#535
2302  0469 89            	pushw	x
2303  046a 5f            	clrw	x
2304  046b 89            	pushw	x
2305  046c ae0000        	ldw	x,#L502
2306  046f cd0000        	call	_assert_failed
2308  0472 5b04          	addw	sp,#4
2309  0474               L624:
2310                     ; 538     if (NewState != DISABLE)
2312  0474 7b01          	ld	a,(OFST+1,sp)
2313  0476 2706          	jreq	L3101
2314                     ; 540         TIM3->CCMR2 |= TIM3_CCMR_OCxPE;
2316  0478 72165326      	bset	21286,#3
2318  047c 2004          	jra	L5101
2319  047e               L3101:
2320                     ; 544         TIM3->CCMR2 &= (uint8_t)(~TIM3_CCMR_OCxPE);
2322  047e 72175326      	bres	21286,#3
2323  0482               L5101:
2324                     ; 546 }
2327  0482 84            	pop	a
2328  0483 81            	ret	
2394                     ; 557 void TIM3_GenerateEvent(TIM3_EventSource_TypeDef TIM3_EventSource)
2394                     ; 558 {
2395                     	switch	.text
2396  0484               _TIM3_GenerateEvent:
2398  0484 88            	push	a
2399       00000000      OFST:	set	0
2402                     ; 560     assert_param(IS_TIM3_EVENT_SOURCE_OK(TIM3_EventSource));
2404  0485 4d            	tnz	a
2405  0486 260e          	jrne	L634
2406  0488 ae0230        	ldw	x,#560
2407  048b 89            	pushw	x
2408  048c 5f            	clrw	x
2409  048d 89            	pushw	x
2410  048e ae0000        	ldw	x,#L502
2411  0491 cd0000        	call	_assert_failed
2413  0494 5b04          	addw	sp,#4
2414  0496               L634:
2415                     ; 563     TIM3->EGR = (uint8_t)TIM3_EventSource;
2417  0496 7b01          	ld	a,(OFST+1,sp)
2418  0498 c75324        	ld	21284,a
2419                     ; 564 }
2422  049b 84            	pop	a
2423  049c 81            	ret	
2460                     ; 575 void TIM3_OC1PolarityConfig(TIM3_OCPolarity_TypeDef TIM3_OCPolarity)
2460                     ; 576 {
2461                     	switch	.text
2462  049d               _TIM3_OC1PolarityConfig:
2464  049d 88            	push	a
2465       00000000      OFST:	set	0
2468                     ; 578     assert_param(IS_TIM3_OC_POLARITY_OK(TIM3_OCPolarity));
2470  049e 4d            	tnz	a
2471  049f 2712          	jreq	L054
2472  04a1 a122          	cp	a,#34
2473  04a3 270e          	jreq	L054
2474  04a5 ae0242        	ldw	x,#578
2475  04a8 89            	pushw	x
2476  04a9 5f            	clrw	x
2477  04aa 89            	pushw	x
2478  04ab ae0000        	ldw	x,#L502
2479  04ae cd0000        	call	_assert_failed
2481  04b1 5b04          	addw	sp,#4
2482  04b3               L054:
2483                     ; 581     if (TIM3_OCPolarity != TIM3_OCPOLARITY_HIGH)
2485  04b3 7b01          	ld	a,(OFST+1,sp)
2486  04b5 2706          	jreq	L5601
2487                     ; 583         TIM3->CCER1 |= TIM3_CCER1_CC1P;
2489  04b7 72125327      	bset	21287,#1
2491  04bb 2004          	jra	L7601
2492  04bd               L5601:
2493                     ; 587         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1P);
2495  04bd 72135327      	bres	21287,#1
2496  04c1               L7601:
2497                     ; 589 }
2500  04c1 84            	pop	a
2501  04c2 81            	ret	
2538                     ; 600 void TIM3_OC2PolarityConfig(TIM3_OCPolarity_TypeDef TIM3_OCPolarity)
2538                     ; 601 {
2539                     	switch	.text
2540  04c3               _TIM3_OC2PolarityConfig:
2542  04c3 88            	push	a
2543       00000000      OFST:	set	0
2546                     ; 603     assert_param(IS_TIM3_OC_POLARITY_OK(TIM3_OCPolarity));
2548  04c4 4d            	tnz	a
2549  04c5 2712          	jreq	L264
2550  04c7 a122          	cp	a,#34
2551  04c9 270e          	jreq	L264
2552  04cb ae025b        	ldw	x,#603
2553  04ce 89            	pushw	x
2554  04cf 5f            	clrw	x
2555  04d0 89            	pushw	x
2556  04d1 ae0000        	ldw	x,#L502
2557  04d4 cd0000        	call	_assert_failed
2559  04d7 5b04          	addw	sp,#4
2560  04d9               L264:
2561                     ; 606     if (TIM3_OCPolarity != TIM3_OCPOLARITY_HIGH)
2563  04d9 7b01          	ld	a,(OFST+1,sp)
2564  04db 2706          	jreq	L7011
2565                     ; 608         TIM3->CCER1 |= TIM3_CCER1_CC2P;
2567  04dd 721a5327      	bset	21287,#5
2569  04e1 2004          	jra	L1111
2570  04e3               L7011:
2571                     ; 612         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC2P);
2573  04e3 721b5327      	bres	21287,#5
2574  04e7               L1111:
2575                     ; 614 }
2578  04e7 84            	pop	a
2579  04e8 81            	ret	
2625                     ; 627 void TIM3_CCxCmd(TIM3_Channel_TypeDef TIM3_Channel, FunctionalState NewState)
2625                     ; 628 {
2626                     	switch	.text
2627  04e9               _TIM3_CCxCmd:
2629  04e9 89            	pushw	x
2630       00000000      OFST:	set	0
2633                     ; 630     assert_param(IS_TIM3_CHANNEL_OK(TIM3_Channel));
2635  04ea 9e            	ld	a,xh
2636  04eb 4d            	tnz	a
2637  04ec 2709          	jreq	L474
2638  04ee 9e            	ld	a,xh
2639  04ef 4a            	dec	a
2640  04f0 2705          	jreq	L474
2641  04f2 ae0276        	ldw	x,#630
2642  04f5 ad30          	call	LC007
2643  04f7               L474:
2644                     ; 631     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2646  04f7 7b02          	ld	a,(OFST+2,sp)
2647  04f9 2708          	jreq	L405
2648  04fb 4a            	dec	a
2649  04fc 2705          	jreq	L405
2650  04fe ae0277        	ldw	x,#631
2651  0501 ad24          	call	LC007
2652  0503               L405:
2653                     ; 633     if (TIM3_Channel == TIM3_CHANNEL_1)
2655  0503 7b01          	ld	a,(OFST+1,sp)
2656  0505 2610          	jrne	L5311
2657                     ; 636         if (NewState != DISABLE)
2659  0507 7b02          	ld	a,(OFST+2,sp)
2660  0509 2706          	jreq	L7311
2661                     ; 638             TIM3->CCER1 |= TIM3_CCER1_CC1E;
2663  050b 72105327      	bset	21287,#0
2665  050f 2014          	jra	L3411
2666  0511               L7311:
2667                     ; 642             TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
2669  0511 72115327      	bres	21287,#0
2670  0515 200e          	jra	L3411
2671  0517               L5311:
2672                     ; 649         if (NewState != DISABLE)
2674  0517 7b02          	ld	a,(OFST+2,sp)
2675  0519 2706          	jreq	L5411
2676                     ; 651             TIM3->CCER1 |= TIM3_CCER1_CC2E;
2678  051b 72185327      	bset	21287,#4
2680  051f 2004          	jra	L3411
2681  0521               L5411:
2682                     ; 655             TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC2E);
2684  0521 72195327      	bres	21287,#4
2685  0525               L3411:
2686                     ; 659 }
2689  0525 85            	popw	x
2690  0526 81            	ret	
2691  0527               LC007:
2692  0527 89            	pushw	x
2693  0528 5f            	clrw	x
2694  0529 89            	pushw	x
2695  052a ae0000        	ldw	x,#L502
2696  052d cd0000        	call	_assert_failed
2698  0530 5b04          	addw	sp,#4
2699  0532 81            	ret	
2745                     ; 680 void TIM3_SelectOCxM(TIM3_Channel_TypeDef TIM3_Channel, TIM3_OCMode_TypeDef TIM3_OCMode)
2745                     ; 681 {
2746                     	switch	.text
2747  0533               _TIM3_SelectOCxM:
2749  0533 89            	pushw	x
2750       00000000      OFST:	set	0
2753                     ; 683     assert_param(IS_TIM3_CHANNEL_OK(TIM3_Channel));
2755  0534 9e            	ld	a,xh
2756  0535 4d            	tnz	a
2757  0536 2709          	jreq	L615
2758  0538 9e            	ld	a,xh
2759  0539 4a            	dec	a
2760  053a 2705          	jreq	L615
2761  053c ae02ab        	ldw	x,#683
2762  053f ad49          	call	LC008
2763  0541               L615:
2764                     ; 684     assert_param(IS_TIM3_OCM_OK(TIM3_OCMode));
2766  0541 7b02          	ld	a,(OFST+2,sp)
2767  0543 2721          	jreq	L625
2768  0545 a110          	cp	a,#16
2769  0547 271d          	jreq	L625
2770  0549 a120          	cp	a,#32
2771  054b 2719          	jreq	L625
2772  054d a130          	cp	a,#48
2773  054f 2715          	jreq	L625
2774  0551 a160          	cp	a,#96
2775  0553 2711          	jreq	L625
2776  0555 a170          	cp	a,#112
2777  0557 270d          	jreq	L625
2778  0559 a150          	cp	a,#80
2779  055b 2709          	jreq	L625
2780  055d a140          	cp	a,#64
2781  055f 2705          	jreq	L625
2782  0561 ae02ac        	ldw	x,#684
2783  0564 ad24          	call	LC008
2784  0566               L625:
2785                     ; 686     if (TIM3_Channel == TIM3_CHANNEL_1)
2787  0566 7b01          	ld	a,(OFST+1,sp)
2788  0568 2610          	jrne	L3711
2789                     ; 689         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
2791  056a 72115327      	bres	21287,#0
2792                     ; 692         TIM3->CCMR1 = (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_OCMode);
2794  056e c65325        	ld	a,21285
2795  0571 a48f          	and	a,#143
2796  0573 1a02          	or	a,(OFST+2,sp)
2797  0575 c75325        	ld	21285,a
2799  0578 200e          	jra	L5711
2800  057a               L3711:
2801                     ; 697         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC2E);
2803  057a 72195327      	bres	21287,#4
2804                     ; 700         TIM3->CCMR2 = (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~TIM3_CCMR_OCM)) | (uint8_t)TIM3_OCMode);
2806  057e c65326        	ld	a,21286
2807  0581 a48f          	and	a,#143
2808  0583 1a02          	or	a,(OFST+2,sp)
2809  0585 c75326        	ld	21286,a
2810  0588               L5711:
2811                     ; 702 }
2814  0588 85            	popw	x
2815  0589 81            	ret	
2816  058a               LC008:
2817  058a 89            	pushw	x
2818  058b 5f            	clrw	x
2819  058c 89            	pushw	x
2820  058d ae0000        	ldw	x,#L502
2821  0590 cd0000        	call	_assert_failed
2823  0593 5b04          	addw	sp,#4
2824  0595 81            	ret	
2858                     ; 711 void TIM3_SetCounter(uint16_t Counter)
2858                     ; 712 {
2859                     	switch	.text
2860  0596               _TIM3_SetCounter:
2864                     ; 714     TIM3->CNTRH = (uint8_t)(Counter >> 8);
2866  0596 9e            	ld	a,xh
2867  0597 c75328        	ld	21288,a
2868                     ; 715     TIM3->CNTRL = (uint8_t)(Counter);
2870  059a 9f            	ld	a,xl
2871  059b c75329        	ld	21289,a
2872                     ; 717 }
2875  059e 81            	ret	
2909                     ; 726 void TIM3_SetAutoreload(uint16_t Autoreload)
2909                     ; 727 {
2910                     	switch	.text
2911  059f               _TIM3_SetAutoreload:
2915                     ; 729     TIM3->ARRH = (uint8_t)(Autoreload >> 8);
2917  059f 9e            	ld	a,xh
2918  05a0 c7532b        	ld	21291,a
2919                     ; 730     TIM3->ARRL = (uint8_t)(Autoreload);
2921  05a3 9f            	ld	a,xl
2922  05a4 c7532c        	ld	21292,a
2923                     ; 731 }
2926  05a7 81            	ret	
2960                     ; 740 void TIM3_SetCompare1(uint16_t Compare1)
2960                     ; 741 {
2961                     	switch	.text
2962  05a8               _TIM3_SetCompare1:
2966                     ; 743     TIM3->CCR1H = (uint8_t)(Compare1 >> 8);
2968  05a8 9e            	ld	a,xh
2969  05a9 c7532d        	ld	21293,a
2970                     ; 744     TIM3->CCR1L = (uint8_t)(Compare1);
2972  05ac 9f            	ld	a,xl
2973  05ad c7532e        	ld	21294,a
2974                     ; 745 }
2977  05b0 81            	ret	
3011                     ; 754 void TIM3_SetCompare2(uint16_t Compare2)
3011                     ; 755 {
3012                     	switch	.text
3013  05b1               _TIM3_SetCompare2:
3017                     ; 757     TIM3->CCR2H = (uint8_t)(Compare2 >> 8);
3019  05b1 9e            	ld	a,xh
3020  05b2 c7532f        	ld	21295,a
3021                     ; 758     TIM3->CCR2L = (uint8_t)(Compare2);
3023  05b5 9f            	ld	a,xl
3024  05b6 c75330        	ld	21296,a
3025                     ; 759 }
3028  05b9 81            	ret	
3065                     ; 772 void TIM3_SetIC1Prescaler(TIM3_ICPSC_TypeDef TIM3_IC1Prescaler)
3065                     ; 773 {
3066                     	switch	.text
3067  05ba               _TIM3_SetIC1Prescaler:
3069  05ba 88            	push	a
3070       00000000      OFST:	set	0
3073                     ; 775     assert_param(IS_TIM3_IC_PRESCALER_OK(TIM3_IC1Prescaler));
3075  05bb 4d            	tnz	a
3076  05bc 271a          	jreq	L055
3077  05be a104          	cp	a,#4
3078  05c0 2716          	jreq	L055
3079  05c2 a108          	cp	a,#8
3080  05c4 2712          	jreq	L055
3081  05c6 a10c          	cp	a,#12
3082  05c8 270e          	jreq	L055
3083  05ca ae0307        	ldw	x,#775
3084  05cd 89            	pushw	x
3085  05ce 5f            	clrw	x
3086  05cf 89            	pushw	x
3087  05d0 ae0000        	ldw	x,#L502
3088  05d3 cd0000        	call	_assert_failed
3090  05d6 5b04          	addw	sp,#4
3091  05d8               L055:
3092                     ; 778     TIM3->CCMR1 = (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~TIM3_CCMR_ICxPSC)) | (uint8_t)TIM3_IC1Prescaler);
3094  05d8 c65325        	ld	a,21285
3095  05db a4f3          	and	a,#243
3096  05dd 1a01          	or	a,(OFST+1,sp)
3097  05df c75325        	ld	21285,a
3098                     ; 779 }
3101  05e2 84            	pop	a
3102  05e3 81            	ret	
3139                     ; 791 void TIM3_SetIC2Prescaler(TIM3_ICPSC_TypeDef TIM3_IC2Prescaler)
3139                     ; 792 {
3140                     	switch	.text
3141  05e4               _TIM3_SetIC2Prescaler:
3143  05e4 88            	push	a
3144       00000000      OFST:	set	0
3147                     ; 794     assert_param(IS_TIM3_IC_PRESCALER_OK(TIM3_IC2Prescaler));
3149  05e5 4d            	tnz	a
3150  05e6 271a          	jreq	L265
3151  05e8 a104          	cp	a,#4
3152  05ea 2716          	jreq	L265
3153  05ec a108          	cp	a,#8
3154  05ee 2712          	jreq	L265
3155  05f0 a10c          	cp	a,#12
3156  05f2 270e          	jreq	L265
3157  05f4 ae031a        	ldw	x,#794
3158  05f7 89            	pushw	x
3159  05f8 5f            	clrw	x
3160  05f9 89            	pushw	x
3161  05fa ae0000        	ldw	x,#L502
3162  05fd cd0000        	call	_assert_failed
3164  0600 5b04          	addw	sp,#4
3165  0602               L265:
3166                     ; 797     TIM3->CCMR2 = (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~TIM3_CCMR_ICxPSC)) | (uint8_t)TIM3_IC2Prescaler);
3168  0602 c65326        	ld	a,21286
3169  0605 a4f3          	and	a,#243
3170  0607 1a01          	or	a,(OFST+1,sp)
3171  0609 c75326        	ld	21286,a
3172                     ; 798 }
3175  060c 84            	pop	a
3176  060d 81            	ret	
3228                     ; 804 uint16_t TIM3_GetCapture1(void)
3228                     ; 805 {
3229                     	switch	.text
3230  060e               _TIM3_GetCapture1:
3232  060e 5204          	subw	sp,#4
3233       00000004      OFST:	set	4
3236                     ; 807     uint16_t tmpccr1 = 0;
3238                     ; 808     uint8_t tmpccr1l=0, tmpccr1h=0;
3242                     ; 810     tmpccr1h = TIM3->CCR1H;
3244  0610 c6532d        	ld	a,21293
3245  0613 6b02          	ld	(OFST-2,sp),a
3246                     ; 811     tmpccr1l = TIM3->CCR1L;
3248  0615 c6532e        	ld	a,21294
3249  0618 6b01          	ld	(OFST-3,sp),a
3250                     ; 813     tmpccr1 = (uint16_t)(tmpccr1l);
3252  061a 5f            	clrw	x
3253  061b 97            	ld	xl,a
3254  061c 1f03          	ldw	(OFST-1,sp),x
3255                     ; 814     tmpccr1 |= (uint16_t)((uint16_t)tmpccr1h << 8);
3257  061e 5f            	clrw	x
3258  061f 7b02          	ld	a,(OFST-2,sp)
3259  0621 97            	ld	xl,a
3260  0622 7b04          	ld	a,(OFST+0,sp)
3261  0624 01            	rrwa	x,a
3262  0625 1a03          	or	a,(OFST-1,sp)
3263  0627 01            	rrwa	x,a
3264                     ; 816     return (uint16_t)tmpccr1;
3268  0628 5b04          	addw	sp,#4
3269  062a 81            	ret	
3321                     ; 824 uint16_t TIM3_GetCapture2(void)
3321                     ; 825 {
3322                     	switch	.text
3323  062b               _TIM3_GetCapture2:
3325  062b 5204          	subw	sp,#4
3326       00000004      OFST:	set	4
3329                     ; 827     uint16_t tmpccr2 = 0;
3331                     ; 828     uint8_t tmpccr2l=0, tmpccr2h=0;
3335                     ; 830     tmpccr2h = TIM3->CCR2H;
3337  062d c6532f        	ld	a,21295
3338  0630 6b02          	ld	(OFST-2,sp),a
3339                     ; 831     tmpccr2l = TIM3->CCR2L;
3341  0632 c65330        	ld	a,21296
3342  0635 6b01          	ld	(OFST-3,sp),a
3343                     ; 833     tmpccr2 = (uint16_t)(tmpccr2l);
3345  0637 5f            	clrw	x
3346  0638 97            	ld	xl,a
3347  0639 1f03          	ldw	(OFST-1,sp),x
3348                     ; 834     tmpccr2 |= (uint16_t)((uint16_t)tmpccr2h << 8);
3350  063b 5f            	clrw	x
3351  063c 7b02          	ld	a,(OFST-2,sp)
3352  063e 97            	ld	xl,a
3353  063f 7b04          	ld	a,(OFST+0,sp)
3354  0641 01            	rrwa	x,a
3355  0642 1a03          	or	a,(OFST-1,sp)
3356  0644 01            	rrwa	x,a
3357                     ; 836     return (uint16_t)tmpccr2;
3361  0645 5b04          	addw	sp,#4
3362  0647 81            	ret	
3396                     ; 844 uint16_t TIM3_GetCounter(void)
3396                     ; 845 {
3397                     	switch	.text
3398  0648               _TIM3_GetCounter:
3400  0648 89            	pushw	x
3401       00000002      OFST:	set	2
3404                     ; 846    uint16_t tmpcntr = 0;
3406                     ; 848    tmpcntr = ((uint16_t)TIM3->CNTRH << 8);
3408  0649 c65328        	ld	a,21288
3409  064c 97            	ld	xl,a
3410  064d 4f            	clr	a
3411  064e 02            	rlwa	x,a
3412  064f 1f01          	ldw	(OFST-1,sp),x
3413                     ; 850     return (uint16_t)( tmpcntr| (uint16_t)(TIM3->CNTRL));
3415  0651 c65329        	ld	a,21289
3416  0654 5f            	clrw	x
3417  0655 97            	ld	xl,a
3418  0656 01            	rrwa	x,a
3419  0657 1a02          	or	a,(OFST+0,sp)
3420  0659 01            	rrwa	x,a
3421  065a 1a01          	or	a,(OFST-1,sp)
3422  065c 01            	rrwa	x,a
3425  065d 5b02          	addw	sp,#2
3426  065f 81            	ret	
3450                     ; 859 TIM3_Prescaler_TypeDef TIM3_GetPrescaler(void)
3450                     ; 860 {
3451                     	switch	.text
3452  0660               _TIM3_GetPrescaler:
3456                     ; 862     return (TIM3_Prescaler_TypeDef)(TIM3->PSCR);
3458  0660 c6532a        	ld	a,21290
3461  0663 81            	ret	
3587                     ; 877 FlagStatus TIM3_GetFlagStatus(TIM3_FLAG_TypeDef TIM3_FLAG)
3587                     ; 878 {
3588                     	switch	.text
3589  0664               _TIM3_GetFlagStatus:
3591  0664 89            	pushw	x
3592  0665 89            	pushw	x
3593       00000002      OFST:	set	2
3596                     ; 879    FlagStatus bitstatus = RESET;
3598                     ; 880    uint8_t tim3_flag_l = 0, tim3_flag_h = 0;
3602                     ; 883     assert_param(IS_TIM3_GET_FLAG_OK(TIM3_FLAG));
3604  0666 a30001        	cpw	x,#1
3605  0669 2722          	jreq	L406
3606  066b a30002        	cpw	x,#2
3607  066e 271d          	jreq	L406
3608  0670 a30004        	cpw	x,#4
3609  0673 2718          	jreq	L406
3610  0675 a30200        	cpw	x,#512
3611  0678 2713          	jreq	L406
3612  067a a30400        	cpw	x,#1024
3613  067d 270e          	jreq	L406
3614  067f ae0373        	ldw	x,#883
3615  0682 89            	pushw	x
3616  0683 5f            	clrw	x
3617  0684 89            	pushw	x
3618  0685 ae0000        	ldw	x,#L502
3619  0688 cd0000        	call	_assert_failed
3621  068b 5b04          	addw	sp,#4
3622  068d               L406:
3623                     ; 885     tim3_flag_l = (uint8_t)(TIM3->SR1 & (uint8_t)TIM3_FLAG);
3625  068d c65322        	ld	a,21282
3626  0690 1404          	and	a,(OFST+2,sp)
3627  0692 6b01          	ld	(OFST-1,sp),a
3628                     ; 886     tim3_flag_h = (uint8_t)((uint16_t)TIM3_FLAG >> 8);
3630  0694 7b03          	ld	a,(OFST+1,sp)
3631  0696 6b02          	ld	(OFST+0,sp),a
3632                     ; 888     if (((tim3_flag_l) | (uint8_t)(TIM3->SR2 & tim3_flag_h)) != (uint8_t)RESET )
3634  0698 c45323        	and	a,21283
3635  069b 1a01          	or	a,(OFST-1,sp)
3636  069d 2702          	jreq	L5051
3637                     ; 890         bitstatus = SET;
3639  069f a601          	ld	a,#1
3641  06a1               L5051:
3642                     ; 894         bitstatus = RESET;
3644                     ; 896     return (FlagStatus)bitstatus;
3648  06a1 5b04          	addw	sp,#4
3649  06a3 81            	ret	
3685                     ; 911 void TIM3_ClearFlag(TIM3_FLAG_TypeDef TIM3_FLAG)
3685                     ; 912 {
3686                     	switch	.text
3687  06a4               _TIM3_ClearFlag:
3689  06a4 89            	pushw	x
3690       00000000      OFST:	set	0
3693                     ; 914     assert_param(IS_TIM3_CLEAR_FLAG_OK(TIM3_FLAG));
3695  06a5 01            	rrwa	x,a
3696  06a6 a4f8          	and	a,#248
3697  06a8 01            	rrwa	x,a
3698  06a9 a4f9          	and	a,#249
3699  06ab 01            	rrwa	x,a
3700  06ac 5d            	tnzw	x
3701  06ad 2604          	jrne	L216
3702  06af 1e01          	ldw	x,(OFST+1,sp)
3703  06b1 260e          	jrne	L416
3704  06b3               L216:
3705  06b3 ae0392        	ldw	x,#914
3706  06b6 89            	pushw	x
3707  06b7 5f            	clrw	x
3708  06b8 89            	pushw	x
3709  06b9 ae0000        	ldw	x,#L502
3710  06bc cd0000        	call	_assert_failed
3712  06bf 5b04          	addw	sp,#4
3713  06c1               L416:
3714                     ; 917     TIM3->SR1 = (uint8_t)(~((uint8_t)(TIM3_FLAG)));
3716  06c1 7b02          	ld	a,(OFST+2,sp)
3717  06c3 43            	cpl	a
3718  06c4 c75322        	ld	21282,a
3719                     ; 918     TIM3->SR2 = (uint8_t)(~((uint8_t)((uint16_t)TIM3_FLAG >> 8)));
3721  06c7 7b01          	ld	a,(OFST+1,sp)
3722  06c9 43            	cpl	a
3723  06ca c75323        	ld	21283,a
3724                     ; 919 }
3727  06cd 85            	popw	x
3728  06ce 81            	ret	
3793                     ; 932 ITStatus TIM3_GetITStatus(TIM3_IT_TypeDef TIM3_IT)
3793                     ; 933 {
3794                     	switch	.text
3795  06cf               _TIM3_GetITStatus:
3797  06cf 88            	push	a
3798  06d0 89            	pushw	x
3799       00000002      OFST:	set	2
3802                     ; 934     ITStatus bitstatus = RESET;
3804                     ; 935     uint8_t TIM3_itStatus = 0, TIM3_itEnable = 0;
3808                     ; 938     assert_param(IS_TIM3_GET_IT_OK(TIM3_IT));
3810  06d1 a101          	cp	a,#1
3811  06d3 2716          	jreq	L626
3812  06d5 a102          	cp	a,#2
3813  06d7 2712          	jreq	L626
3814  06d9 a104          	cp	a,#4
3815  06db 270e          	jreq	L626
3816  06dd ae03aa        	ldw	x,#938
3817  06e0 89            	pushw	x
3818  06e1 5f            	clrw	x
3819  06e2 89            	pushw	x
3820  06e3 ae0000        	ldw	x,#L502
3821  06e6 cd0000        	call	_assert_failed
3823  06e9 5b04          	addw	sp,#4
3824  06eb               L626:
3825                     ; 940     TIM3_itStatus = (uint8_t)(TIM3->SR1 & TIM3_IT);
3827  06eb c65322        	ld	a,21282
3828  06ee 1403          	and	a,(OFST+1,sp)
3829  06f0 6b01          	ld	(OFST-1,sp),a
3830                     ; 942     TIM3_itEnable = (uint8_t)(TIM3->IER & TIM3_IT);
3832  06f2 c65321        	ld	a,21281
3833  06f5 1403          	and	a,(OFST+1,sp)
3834  06f7 6b02          	ld	(OFST+0,sp),a
3835                     ; 944     if ((TIM3_itStatus != (uint8_t)RESET ) && (TIM3_itEnable != (uint8_t)RESET ))
3837  06f9 7b01          	ld	a,(OFST-1,sp)
3838  06fb 2708          	jreq	L1651
3840  06fd 7b02          	ld	a,(OFST+0,sp)
3841  06ff 2704          	jreq	L1651
3842                     ; 946         bitstatus = SET;
3844  0701 a601          	ld	a,#1
3846  0703 2001          	jra	L3651
3847  0705               L1651:
3848                     ; 950         bitstatus = RESET;
3850  0705 4f            	clr	a
3851  0706               L3651:
3852                     ; 952     return (ITStatus)(bitstatus);
3856  0706 5b03          	addw	sp,#3
3857  0708 81            	ret	
3894                     ; 965 void TIM3_ClearITPendingBit(TIM3_IT_TypeDef TIM3_IT)
3894                     ; 966 {
3895                     	switch	.text
3896  0709               _TIM3_ClearITPendingBit:
3898  0709 88            	push	a
3899       00000000      OFST:	set	0
3902                     ; 968     assert_param(IS_TIM3_IT_OK(TIM3_IT));
3904  070a 4d            	tnz	a
3905  070b 2704          	jreq	L436
3906  070d a108          	cp	a,#8
3907  070f 250e          	jrult	L636
3908  0711               L436:
3909  0711 ae03c8        	ldw	x,#968
3910  0714 89            	pushw	x
3911  0715 5f            	clrw	x
3912  0716 89            	pushw	x
3913  0717 ae0000        	ldw	x,#L502
3914  071a cd0000        	call	_assert_failed
3916  071d 5b04          	addw	sp,#4
3917  071f               L636:
3918                     ; 971     TIM3->SR1 = (uint8_t)(~TIM3_IT);
3920  071f 7b01          	ld	a,(OFST+1,sp)
3921  0721 43            	cpl	a
3922  0722 c75322        	ld	21282,a
3923                     ; 972 }
3926  0725 84            	pop	a
3927  0726 81            	ret	
3979                     ; 991 static void TI1_Config(uint8_t TIM3_ICPolarity,
3979                     ; 992                        uint8_t TIM3_ICSelection,
3979                     ; 993                        uint8_t TIM3_ICFilter)
3979                     ; 994 {
3980                     	switch	.text
3981  0727               L3_TI1_Config:
3983  0727 89            	pushw	x
3984  0728 88            	push	a
3985       00000001      OFST:	set	1
3988                     ; 996     TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
3990  0729 72115327      	bres	21287,#0
3991                     ; 999     TIM3->CCMR1 = (uint8_t)((uint8_t)(TIM3->CCMR1 & (uint8_t)(~( TIM3_CCMR_CCxS | TIM3_CCMR_ICxF))) | (uint8_t)(( (TIM3_ICSelection)) | ((uint8_t)( TIM3_ICFilter << 4))));
3993  072d 7b06          	ld	a,(OFST+5,sp)
3994  072f 97            	ld	xl,a
3995  0730 a610          	ld	a,#16
3996  0732 42            	mul	x,a
3997  0733 9f            	ld	a,xl
3998  0734 1a03          	or	a,(OFST+2,sp)
3999  0736 6b01          	ld	(OFST+0,sp),a
4000  0738 c65325        	ld	a,21285
4001  073b a40c          	and	a,#12
4002  073d 1a01          	or	a,(OFST+0,sp)
4003  073f c75325        	ld	21285,a
4004                     ; 1002     if (TIM3_ICPolarity != TIM3_ICPOLARITY_RISING)
4006  0742 7b02          	ld	a,(OFST+1,sp)
4007  0744 2706          	jreq	L1361
4008                     ; 1004         TIM3->CCER1 |= TIM3_CCER1_CC1P;
4010  0746 72125327      	bset	21287,#1
4012  074a 2004          	jra	L3361
4013  074c               L1361:
4014                     ; 1008         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1P);
4016  074c 72135327      	bres	21287,#1
4017  0750               L3361:
4018                     ; 1011     TIM3->CCER1 |= TIM3_CCER1_CC1E;
4020  0750 72105327      	bset	21287,#0
4021                     ; 1012 }
4024  0754 5b03          	addw	sp,#3
4025  0756 81            	ret	
4077                     ; 1031 static void TI2_Config(uint8_t TIM3_ICPolarity,
4077                     ; 1032                        uint8_t TIM3_ICSelection,
4077                     ; 1033                        uint8_t TIM3_ICFilter)
4077                     ; 1034 {
4078                     	switch	.text
4079  0757               L5_TI2_Config:
4081  0757 89            	pushw	x
4082  0758 88            	push	a
4083       00000001      OFST:	set	1
4086                     ; 1036     TIM3->CCER1 &=  (uint8_t)(~TIM3_CCER1_CC2E);
4088  0759 72195327      	bres	21287,#4
4089                     ; 1039     TIM3->CCMR2 = (uint8_t)((uint8_t)(TIM3->CCMR2 & (uint8_t)(~( TIM3_CCMR_CCxS |
4089                     ; 1040                   TIM3_CCMR_ICxF    ))) | (uint8_t)(( (TIM3_ICSelection)) | 
4089                     ; 1041                   ((uint8_t)( TIM3_ICFilter << 4))));
4091  075d 7b06          	ld	a,(OFST+5,sp)
4092  075f 97            	ld	xl,a
4093  0760 a610          	ld	a,#16
4094  0762 42            	mul	x,a
4095  0763 9f            	ld	a,xl
4096  0764 1a03          	or	a,(OFST+2,sp)
4097  0766 6b01          	ld	(OFST+0,sp),a
4098  0768 c65326        	ld	a,21286
4099  076b a40c          	and	a,#12
4100  076d 1a01          	or	a,(OFST+0,sp)
4101  076f c75326        	ld	21286,a
4102                     ; 1044     if (TIM3_ICPolarity != TIM3_ICPOLARITY_RISING)
4104  0772 7b02          	ld	a,(OFST+1,sp)
4105  0774 2706          	jreq	L3661
4106                     ; 1046         TIM3->CCER1 |= TIM3_CCER1_CC2P;
4108  0776 721a5327      	bset	21287,#5
4110  077a 2004          	jra	L5661
4111  077c               L3661:
4112                     ; 1050         TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC2P);
4114  077c 721b5327      	bres	21287,#5
4115  0780               L5661:
4116                     ; 1054     TIM3->CCER1 |= TIM3_CCER1_CC2E;
4118  0780 72185327      	bset	21287,#4
4119                     ; 1056 }
4122  0784 5b03          	addw	sp,#3
4123  0786 81            	ret	
4136                     	xdef	_TIM3_ClearITPendingBit
4137                     	xdef	_TIM3_GetITStatus
4138                     	xdef	_TIM3_ClearFlag
4139                     	xdef	_TIM3_GetFlagStatus
4140                     	xdef	_TIM3_GetPrescaler
4141                     	xdef	_TIM3_GetCounter
4142                     	xdef	_TIM3_GetCapture2
4143                     	xdef	_TIM3_GetCapture1
4144                     	xdef	_TIM3_SetIC2Prescaler
4145                     	xdef	_TIM3_SetIC1Prescaler
4146                     	xdef	_TIM3_SetCompare2
4147                     	xdef	_TIM3_SetCompare1
4148                     	xdef	_TIM3_SetAutoreload
4149                     	xdef	_TIM3_SetCounter
4150                     	xdef	_TIM3_SelectOCxM
4151                     	xdef	_TIM3_CCxCmd
4152                     	xdef	_TIM3_OC2PolarityConfig
4153                     	xdef	_TIM3_OC1PolarityConfig
4154                     	xdef	_TIM3_GenerateEvent
4155                     	xdef	_TIM3_OC2PreloadConfig
4156                     	xdef	_TIM3_OC1PreloadConfig
4157                     	xdef	_TIM3_ARRPreloadConfig
4158                     	xdef	_TIM3_ForcedOC2Config
4159                     	xdef	_TIM3_ForcedOC1Config
4160                     	xdef	_TIM3_PrescalerConfig
4161                     	xdef	_TIM3_SelectOnePulseMode
4162                     	xdef	_TIM3_UpdateRequestConfig
4163                     	xdef	_TIM3_UpdateDisableConfig
4164                     	xdef	_TIM3_ITConfig
4165                     	xdef	_TIM3_Cmd
4166                     	xdef	_TIM3_PWMIConfig
4167                     	xdef	_TIM3_ICInit
4168                     	xdef	_TIM3_OC2Init
4169                     	xdef	_TIM3_OC1Init
4170                     	xdef	_TIM3_TimeBaseInit
4171                     	xdef	_TIM3_DeInit
4172                     	xref	_assert_failed
4173                     .const:	section	.text
4174  0000               L502:
4175  0000 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
4176  0012 6965735c7374  	dc.b	"ies\stm8s_stdperip"
4177  0024 685f64726976  	dc.b	"h_driver\src\stm8s"
4178  0036 5f74696d332e  	dc.b	"_tim3.c",0
4198                     	end
