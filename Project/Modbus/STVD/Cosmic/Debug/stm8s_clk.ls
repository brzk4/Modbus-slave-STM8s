   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     .const:	section	.text
  20  0000               _HSIDivFactor:
  21  0000 01            	dc.b	1
  22  0001 02            	dc.b	2
  23  0002 04            	dc.b	4
  24  0003 08            	dc.b	8
  25  0004               _CLKPrescTable:
  26  0004 01            	dc.b	1
  27  0005 02            	dc.b	2
  28  0006 04            	dc.b	4
  29  0007 08            	dc.b	8
  30  0008 0a            	dc.b	10
  31  0009 10            	dc.b	16
  32  000a 14            	dc.b	20
  33  000b 28            	dc.b	40
  62                     ; 66 void CLK_DeInit(void)
  62                     ; 67 {
  64                     	switch	.text
  65  0000               _CLK_DeInit:
  69                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  71  0000 350150c0      	mov	20672,#1
  72                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  74  0004 725f50c1      	clr	20673
  75                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  77  0008 35e150c4      	mov	20676,#225
  78                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  80  000c 725f50c5      	clr	20677
  81                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  83  0010 351850c6      	mov	20678,#24
  84                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  86  0014 35ff50c7      	mov	20679,#255
  87                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  89  0018 35ff50ca      	mov	20682,#255
  90                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  92  001c 725f50c8      	clr	20680
  93                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  95  0020 725f50c9      	clr	20681
  97  0024               L52:
  98                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
 100  0024 720050c9fb    	btjt	20681,#0,L52
 101                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 103  0029 725f50c9      	clr	20681
 104                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 106  002d 725f50cc      	clr	20684
 107                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 109  0031 725f50cd      	clr	20685
 110                     ; 84 }
 113  0035 81            	ret	
 170                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 170                     ; 96 {
 171                     	switch	.text
 172  0036               _CLK_FastHaltWakeUpCmd:
 174  0036 88            	push	a
 175       00000000      OFST:	set	0
 178                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 180  0037 4d            	tnz	a
 181  0038 2711          	jreq	L41
 182  003a 4a            	dec	a
 183  003b 270e          	jreq	L41
 184  003d ae0063        	ldw	x,#99
 185  0040 89            	pushw	x
 186  0041 5f            	clrw	x
 187  0042 89            	pushw	x
 188  0043 ae000c        	ldw	x,#L75
 189  0046 cd0000        	call	_assert_failed
 191  0049 5b04          	addw	sp,#4
 192  004b               L41:
 193                     ; 101     if (NewState != DISABLE)
 195  004b 7b01          	ld	a,(OFST+1,sp)
 196  004d 2706          	jreq	L16
 197                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 199  004f 721450c0      	bset	20672,#2
 201  0053 2004          	jra	L36
 202  0055               L16:
 203                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 205  0055 721550c0      	bres	20672,#2
 206  0059               L36:
 207                     ; 112 }
 210  0059 84            	pop	a
 211  005a 81            	ret	
 247                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 247                     ; 120 {
 248                     	switch	.text
 249  005b               _CLK_HSECmd:
 251  005b 88            	push	a
 252       00000000      OFST:	set	0
 255                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 257  005c 4d            	tnz	a
 258  005d 2711          	jreq	L62
 259  005f 4a            	dec	a
 260  0060 270e          	jreq	L62
 261  0062 ae007b        	ldw	x,#123
 262  0065 89            	pushw	x
 263  0066 5f            	clrw	x
 264  0067 89            	pushw	x
 265  0068 ae000c        	ldw	x,#L75
 266  006b cd0000        	call	_assert_failed
 268  006e 5b04          	addw	sp,#4
 269  0070               L62:
 270                     ; 125     if (NewState != DISABLE)
 272  0070 7b01          	ld	a,(OFST+1,sp)
 273  0072 2706          	jreq	L301
 274                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 276  0074 721050c1      	bset	20673,#0
 278  0078 2004          	jra	L501
 279  007a               L301:
 280                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 282  007a 721150c1      	bres	20673,#0
 283  007e               L501:
 284                     ; 136 }
 287  007e 84            	pop	a
 288  007f 81            	ret	
 324                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 324                     ; 144 {
 325                     	switch	.text
 326  0080               _CLK_HSICmd:
 328  0080 88            	push	a
 329       00000000      OFST:	set	0
 332                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 334  0081 4d            	tnz	a
 335  0082 2711          	jreq	L04
 336  0084 4a            	dec	a
 337  0085 270e          	jreq	L04
 338  0087 ae0093        	ldw	x,#147
 339  008a 89            	pushw	x
 340  008b 5f            	clrw	x
 341  008c 89            	pushw	x
 342  008d ae000c        	ldw	x,#L75
 343  0090 cd0000        	call	_assert_failed
 345  0093 5b04          	addw	sp,#4
 346  0095               L04:
 347                     ; 149     if (NewState != DISABLE)
 349  0095 7b01          	ld	a,(OFST+1,sp)
 350  0097 2706          	jreq	L521
 351                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 353  0099 721050c0      	bset	20672,#0
 355  009d 2004          	jra	L721
 356  009f               L521:
 357                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 359  009f 721150c0      	bres	20672,#0
 360  00a3               L721:
 361                     ; 160 }
 364  00a3 84            	pop	a
 365  00a4 81            	ret	
 401                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 401                     ; 168 {
 402                     	switch	.text
 403  00a5               _CLK_LSICmd:
 405  00a5 88            	push	a
 406       00000000      OFST:	set	0
 409                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 411  00a6 4d            	tnz	a
 412  00a7 2711          	jreq	L25
 413  00a9 4a            	dec	a
 414  00aa 270e          	jreq	L25
 415  00ac ae00ab        	ldw	x,#171
 416  00af 89            	pushw	x
 417  00b0 5f            	clrw	x
 418  00b1 89            	pushw	x
 419  00b2 ae000c        	ldw	x,#L75
 420  00b5 cd0000        	call	_assert_failed
 422  00b8 5b04          	addw	sp,#4
 423  00ba               L25:
 424                     ; 173     if (NewState != DISABLE)
 426  00ba 7b01          	ld	a,(OFST+1,sp)
 427  00bc 2706          	jreq	L741
 428                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 430  00be 721650c0      	bset	20672,#3
 432  00c2 2004          	jra	L151
 433  00c4               L741:
 434                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 436  00c4 721750c0      	bres	20672,#3
 437  00c8               L151:
 438                     ; 184 }
 441  00c8 84            	pop	a
 442  00c9 81            	ret	
 478                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 478                     ; 193 {
 479                     	switch	.text
 480  00ca               _CLK_CCOCmd:
 482  00ca 88            	push	a
 483       00000000      OFST:	set	0
 486                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 488  00cb 4d            	tnz	a
 489  00cc 2711          	jreq	L46
 490  00ce 4a            	dec	a
 491  00cf 270e          	jreq	L46
 492  00d1 ae00c4        	ldw	x,#196
 493  00d4 89            	pushw	x
 494  00d5 5f            	clrw	x
 495  00d6 89            	pushw	x
 496  00d7 ae000c        	ldw	x,#L75
 497  00da cd0000        	call	_assert_failed
 499  00dd 5b04          	addw	sp,#4
 500  00df               L46:
 501                     ; 198     if (NewState != DISABLE)
 503  00df 7b01          	ld	a,(OFST+1,sp)
 504  00e1 2706          	jreq	L171
 505                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 507  00e3 721050c9      	bset	20681,#0
 509  00e7 2004          	jra	L371
 510  00e9               L171:
 511                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 513  00e9 721150c9      	bres	20681,#0
 514  00ed               L371:
 515                     ; 209 }
 518  00ed 84            	pop	a
 519  00ee 81            	ret	
 555                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 555                     ; 219 {
 556                     	switch	.text
 557  00ef               _CLK_ClockSwitchCmd:
 559  00ef 88            	push	a
 560       00000000      OFST:	set	0
 563                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 565  00f0 4d            	tnz	a
 566  00f1 2711          	jreq	L67
 567  00f3 4a            	dec	a
 568  00f4 270e          	jreq	L67
 569  00f6 ae00de        	ldw	x,#222
 570  00f9 89            	pushw	x
 571  00fa 5f            	clrw	x
 572  00fb 89            	pushw	x
 573  00fc ae000c        	ldw	x,#L75
 574  00ff cd0000        	call	_assert_failed
 576  0102 5b04          	addw	sp,#4
 577  0104               L67:
 578                     ; 224     if (NewState != DISABLE )
 580  0104 7b01          	ld	a,(OFST+1,sp)
 581  0106 2706          	jreq	L312
 582                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 584  0108 721250c5      	bset	20677,#1
 586  010c 2004          	jra	L512
 587  010e               L312:
 588                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 590  010e 721350c5      	bres	20677,#1
 591  0112               L512:
 592                     ; 235 }
 595  0112 84            	pop	a
 596  0113 81            	ret	
 633                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 633                     ; 246 {
 634                     	switch	.text
 635  0114               _CLK_SlowActiveHaltWakeUpCmd:
 637  0114 88            	push	a
 638       00000000      OFST:	set	0
 641                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 643  0115 4d            	tnz	a
 644  0116 2711          	jreq	L011
 645  0118 4a            	dec	a
 646  0119 270e          	jreq	L011
 647  011b ae00f9        	ldw	x,#249
 648  011e 89            	pushw	x
 649  011f 5f            	clrw	x
 650  0120 89            	pushw	x
 651  0121 ae000c        	ldw	x,#L75
 652  0124 cd0000        	call	_assert_failed
 654  0127 5b04          	addw	sp,#4
 655  0129               L011:
 656                     ; 251     if (NewState != DISABLE)
 658  0129 7b01          	ld	a,(OFST+1,sp)
 659  012b 2706          	jreq	L532
 660                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 662  012d 721a50c0      	bset	20672,#5
 664  0131 2004          	jra	L732
 665  0133               L532:
 666                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 668  0133 721b50c0      	bres	20672,#5
 669  0137               L732:
 670                     ; 262 }
 673  0137 84            	pop	a
 674  0138 81            	ret	
 834                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 834                     ; 273 {
 835                     	switch	.text
 836  0139               _CLK_PeripheralClockConfig:
 838  0139 89            	pushw	x
 839       00000000      OFST:	set	0
 842                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 844  013a 9f            	ld	a,xl
 845  013b 4d            	tnz	a
 846  013c 270a          	jreq	L221
 847  013e 9f            	ld	a,xl
 848  013f 4a            	dec	a
 849  0140 2706          	jreq	L221
 850  0142 ae0114        	ldw	x,#276
 851  0145 cd01cb        	call	LC004
 852  0148               L221:
 853                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 855  0148 7b01          	ld	a,(OFST+1,sp)
 856  014a 272f          	jreq	L231
 857  014c a101          	cp	a,#1
 858  014e 272b          	jreq	L231
 859  0150 a103          	cp	a,#3
 860  0152 2727          	jreq	L231
 861  0154 a104          	cp	a,#4
 862  0156 2723          	jreq	L231
 863  0158 a105          	cp	a,#5
 864  015a 271f          	jreq	L231
 865  015c a104          	cp	a,#4
 866  015e 271b          	jreq	L231
 867  0160 a106          	cp	a,#6
 868  0162 2717          	jreq	L231
 869  0164 a107          	cp	a,#7
 870  0166 2713          	jreq	L231
 871  0168 a117          	cp	a,#23
 872  016a 270f          	jreq	L231
 873  016c a113          	cp	a,#19
 874  016e 270b          	jreq	L231
 875  0170 a112          	cp	a,#18
 876  0172 2707          	jreq	L231
 877  0174 ae0115        	ldw	x,#277
 878  0177 ad52          	call	LC004
 879  0179 7b01          	ld	a,(OFST+1,sp)
 880  017b               L231:
 881                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 883  017b a510          	bcp	a,#16
 884  017d 2622          	jrne	L323
 885                     ; 281         if (NewState != DISABLE)
 887  017f 0d02          	tnz	(OFST+2,sp)
 888  0181 270d          	jreq	L523
 889                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 891  0183 ad3e          	call	LC003
 892  0185 2704          	jreq	L631
 893  0187               L041:
 894  0187 48            	sll	a
 895  0188 5a            	decw	x
 896  0189 26fc          	jrne	L041
 897  018b               L631:
 898  018b ca50c7        	or	a,20679
 900  018e 200c          	jp	LC002
 901  0190               L523:
 902                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 904  0190 ad31          	call	LC003
 905  0192 2704          	jreq	L241
 906  0194               L441:
 907  0194 48            	sll	a
 908  0195 5a            	decw	x
 909  0196 26fc          	jrne	L441
 910  0198               L241:
 911  0198 43            	cpl	a
 912  0199 c450c7        	and	a,20679
 913  019c               LC002:
 914  019c c750c7        	ld	20679,a
 915  019f 2020          	jra	L133
 916  01a1               L323:
 917                     ; 294         if (NewState != DISABLE)
 919  01a1 0d02          	tnz	(OFST+2,sp)
 920  01a3 270d          	jreq	L333
 921                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 923  01a5 ad1c          	call	LC003
 924  01a7 2704          	jreq	L641
 925  01a9               L051:
 926  01a9 48            	sll	a
 927  01aa 5a            	decw	x
 928  01ab 26fc          	jrne	L051
 929  01ad               L641:
 930  01ad ca50ca        	or	a,20682
 932  01b0 200c          	jp	LC001
 933  01b2               L333:
 934                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 936  01b2 ad0f          	call	LC003
 937  01b4 2704          	jreq	L251
 938  01b6               L451:
 939  01b6 48            	sll	a
 940  01b7 5a            	decw	x
 941  01b8 26fc          	jrne	L451
 942  01ba               L251:
 943  01ba 43            	cpl	a
 944  01bb c450ca        	and	a,20682
 945  01be               LC001:
 946  01be c750ca        	ld	20682,a
 947  01c1               L133:
 948                     ; 306 }
 951  01c1 85            	popw	x
 952  01c2 81            	ret	
 953  01c3               LC003:
 954  01c3 a40f          	and	a,#15
 955  01c5 5f            	clrw	x
 956  01c6 97            	ld	xl,a
 957  01c7 a601          	ld	a,#1
 958  01c9 5d            	tnzw	x
 959  01ca 81            	ret	
 960  01cb               LC004:
 961  01cb 89            	pushw	x
 962  01cc 5f            	clrw	x
 963  01cd 89            	pushw	x
 964  01ce ae000c        	ldw	x,#L75
 965  01d1 cd0000        	call	_assert_failed
 967  01d4 5b04          	addw	sp,#4
 968  01d6 81            	ret	
1157                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1157                     ; 320 {
1158                     	switch	.text
1159  01d7               _CLK_ClockSwitchConfig:
1161  01d7 89            	pushw	x
1162  01d8 5204          	subw	sp,#4
1163       00000004      OFST:	set	4
1166                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1168  01da ae0491        	ldw	x,#1169
1169  01dd 1f03          	ldw	(OFST-1,sp),x
1170                     ; 324     ErrorStatus Swif = ERROR;
1172                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1174  01df 7b06          	ld	a,(OFST+2,sp)
1175  01e1 a1e1          	cp	a,#225
1176  01e3 270e          	jreq	L461
1177  01e5 a1d2          	cp	a,#210
1178  01e7 270a          	jreq	L461
1179  01e9 a1b4          	cp	a,#180
1180  01eb 2706          	jreq	L461
1181  01ed ae0147        	ldw	x,#327
1182  01f0 cd029b        	call	LC006
1183  01f3               L461:
1184                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1186  01f3 7b05          	ld	a,(OFST+1,sp)
1187  01f5 2709          	jreq	L471
1188  01f7 4a            	dec	a
1189  01f8 2706          	jreq	L471
1190  01fa ae0148        	ldw	x,#328
1191  01fd cd029b        	call	LC006
1192  0200               L471:
1193                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1195  0200 7b09          	ld	a,(OFST+5,sp)
1196  0202 2709          	jreq	L402
1197  0204 4a            	dec	a
1198  0205 2706          	jreq	L402
1199  0207 ae0149        	ldw	x,#329
1200  020a cd029b        	call	LC006
1201  020d               L402:
1202                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1204  020d 7b0a          	ld	a,(OFST+6,sp)
1205  020f 2709          	jreq	L412
1206  0211 4a            	dec	a
1207  0212 2706          	jreq	L412
1208  0214 ae014a        	ldw	x,#330
1209  0217 cd029b        	call	LC006
1210  021a               L412:
1211                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1213  021a c650c3        	ld	a,20675
1214  021d 6b01          	ld	(OFST-3,sp),a
1215                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1217  021f 7b05          	ld	a,(OFST+1,sp)
1218  0221 4a            	dec	a
1219  0222 262d          	jrne	L744
1220                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1222  0224 721250c5      	bset	20677,#1
1223                     ; 343         if (ITState != DISABLE)
1225  0228 7b09          	ld	a,(OFST+5,sp)
1226  022a 2706          	jreq	L154
1227                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1229  022c 721450c5      	bset	20677,#2
1231  0230 2004          	jra	L354
1232  0232               L154:
1233                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1235  0232 721550c5      	bres	20677,#2
1236  0236               L354:
1237                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1239  0236 7b06          	ld	a,(OFST+2,sp)
1240  0238 c750c4        	ld	20676,a
1242  023b 2003          	jra	L164
1243  023d               L554:
1244                     ; 357             DownCounter--;
1246  023d 5a            	decw	x
1247  023e 1f03          	ldw	(OFST-1,sp),x
1248  0240               L164:
1249                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1251  0240 720150c504    	btjf	20677,#0,L564
1253  0245 1e03          	ldw	x,(OFST-1,sp)
1254  0247 26f4          	jrne	L554
1255  0249               L564:
1256                     ; 360         if (DownCounter != 0)
1258  0249 1e03          	ldw	x,(OFST-1,sp)
1259                     ; 362             Swif = SUCCESS;
1261  024b 2617          	jrne	LC005
1262                     ; 366             Swif = ERROR;
1264  024d 0f02          	clr	(OFST-2,sp)
1265  024f 2017          	jra	L374
1266  0251               L744:
1267                     ; 374         if (ITState != DISABLE)
1269  0251 7b09          	ld	a,(OFST+5,sp)
1270  0253 2706          	jreq	L574
1271                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1273  0255 721450c5      	bset	20677,#2
1275  0259 2004          	jra	L774
1276  025b               L574:
1277                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1279  025b 721550c5      	bres	20677,#2
1280  025f               L774:
1281                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1283  025f 7b06          	ld	a,(OFST+2,sp)
1284  0261 c750c4        	ld	20676,a
1285                     ; 388         Swif = SUCCESS;
1287  0264               LC005:
1289  0264 a601          	ld	a,#1
1290  0266 6b02          	ld	(OFST-2,sp),a
1291  0268               L374:
1292                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1294  0268 7b0a          	ld	a,(OFST+6,sp)
1295  026a 260c          	jrne	L105
1297  026c 7b01          	ld	a,(OFST-3,sp)
1298  026e a1e1          	cp	a,#225
1299  0270 2606          	jrne	L105
1300                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1302  0272 721150c0      	bres	20672,#0
1304  0276 201e          	jra	L305
1305  0278               L105:
1306                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1308  0278 7b0a          	ld	a,(OFST+6,sp)
1309  027a 260c          	jrne	L505
1311  027c 7b01          	ld	a,(OFST-3,sp)
1312  027e a1d2          	cp	a,#210
1313  0280 2606          	jrne	L505
1314                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1316  0282 721750c0      	bres	20672,#3
1318  0286 200e          	jra	L305
1319  0288               L505:
1320                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1322  0288 7b0a          	ld	a,(OFST+6,sp)
1323  028a 260a          	jrne	L305
1325  028c 7b01          	ld	a,(OFST-3,sp)
1326  028e a1b4          	cp	a,#180
1327  0290 2604          	jrne	L305
1328                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1330  0292 721150c1      	bres	20673,#0
1331  0296               L305:
1332                     ; 406     return(Swif);
1334  0296 7b02          	ld	a,(OFST-2,sp)
1337  0298 5b06          	addw	sp,#6
1338  029a 81            	ret	
1339  029b               LC006:
1340  029b 89            	pushw	x
1341  029c 5f            	clrw	x
1342  029d 89            	pushw	x
1343  029e ae000c        	ldw	x,#L75
1344  02a1 cd0000        	call	_assert_failed
1346  02a4 5b04          	addw	sp,#4
1347  02a6 81            	ret	
1486                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1486                     ; 417 {
1487                     	switch	.text
1488  02a7               _CLK_HSIPrescalerConfig:
1490  02a7 88            	push	a
1491       00000000      OFST:	set	0
1494                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1496  02a8 4d            	tnz	a
1497  02a9 271a          	jreq	L622
1498  02ab a108          	cp	a,#8
1499  02ad 2716          	jreq	L622
1500  02af a110          	cp	a,#16
1501  02b1 2712          	jreq	L622
1502  02b3 a118          	cp	a,#24
1503  02b5 270e          	jreq	L622
1504  02b7 ae01a4        	ldw	x,#420
1505  02ba 89            	pushw	x
1506  02bb 5f            	clrw	x
1507  02bc 89            	pushw	x
1508  02bd ae000c        	ldw	x,#L75
1509  02c0 cd0000        	call	_assert_failed
1511  02c3 5b04          	addw	sp,#4
1512  02c5               L622:
1513                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1515  02c5 c650c6        	ld	a,20678
1516  02c8 a4e7          	and	a,#231
1517  02ca c750c6        	ld	20678,a
1518                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1520  02cd c650c6        	ld	a,20678
1521  02d0 1a01          	or	a,(OFST+1,sp)
1522  02d2 c750c6        	ld	20678,a
1523                     ; 428 }
1526  02d5 84            	pop	a
1527  02d6 81            	ret	
1663                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1663                     ; 440 {
1664                     	switch	.text
1665  02d7               _CLK_CCOConfig:
1667  02d7 88            	push	a
1668       00000000      OFST:	set	0
1671                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1673  02d8 4d            	tnz	a
1674  02d9 273e          	jreq	L042
1675  02db a104          	cp	a,#4
1676  02dd 273a          	jreq	L042
1677  02df a102          	cp	a,#2
1678  02e1 2736          	jreq	L042
1679  02e3 a108          	cp	a,#8
1680  02e5 2732          	jreq	L042
1681  02e7 a10a          	cp	a,#10
1682  02e9 272e          	jreq	L042
1683  02eb a10c          	cp	a,#12
1684  02ed 272a          	jreq	L042
1685  02ef a10e          	cp	a,#14
1686  02f1 2726          	jreq	L042
1687  02f3 a110          	cp	a,#16
1688  02f5 2722          	jreq	L042
1689  02f7 a112          	cp	a,#18
1690  02f9 271e          	jreq	L042
1691  02fb a114          	cp	a,#20
1692  02fd 271a          	jreq	L042
1693  02ff a116          	cp	a,#22
1694  0301 2716          	jreq	L042
1695  0303 a118          	cp	a,#24
1696  0305 2712          	jreq	L042
1697  0307 a11a          	cp	a,#26
1698  0309 270e          	jreq	L042
1699  030b ae01bb        	ldw	x,#443
1700  030e 89            	pushw	x
1701  030f 5f            	clrw	x
1702  0310 89            	pushw	x
1703  0311 ae000c        	ldw	x,#L75
1704  0314 cd0000        	call	_assert_failed
1706  0317 5b04          	addw	sp,#4
1707  0319               L042:
1708                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1710  0319 c650c9        	ld	a,20681
1711  031c a4e1          	and	a,#225
1712  031e c750c9        	ld	20681,a
1713                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1715  0321 c650c9        	ld	a,20681
1716  0324 1a01          	or	a,(OFST+1,sp)
1717  0326 c750c9        	ld	20681,a
1718                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1720  0329 721050c9      	bset	20681,#0
1721                     ; 454 }
1724  032d 84            	pop	a
1725  032e 81            	ret	
1791                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1791                     ; 465 {
1792                     	switch	.text
1793  032f               _CLK_ITConfig:
1795  032f 89            	pushw	x
1796       00000000      OFST:	set	0
1799                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1801  0330 9f            	ld	a,xl
1802  0331 4d            	tnz	a
1803  0332 2709          	jreq	L252
1804  0334 9f            	ld	a,xl
1805  0335 4a            	dec	a
1806  0336 2705          	jreq	L252
1807  0338 ae01d4        	ldw	x,#468
1808  033b ad3f          	call	LC007
1809  033d               L252:
1810                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1812  033d 7b01          	ld	a,(OFST+1,sp)
1813  033f a10c          	cp	a,#12
1814  0341 2709          	jreq	L262
1815  0343 a11c          	cp	a,#28
1816  0345 2705          	jreq	L262
1817  0347 ae01d5        	ldw	x,#469
1818  034a ad30          	call	LC007
1819  034c               L262:
1820                     ; 471     if (NewState != DISABLE)
1822  034c 7b02          	ld	a,(OFST+2,sp)
1823  034e 2716          	jreq	L707
1824                     ; 473         switch (CLK_IT)
1826  0350 7b01          	ld	a,(OFST+1,sp)
1828                     ; 481         default:
1828                     ; 482             break;
1829  0352 a00c          	sub	a,#12
1830  0354 270a          	jreq	L346
1831  0356 a010          	sub	a,#16
1832  0358 2620          	jrne	L517
1833                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1833                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1835  035a 721450c5      	bset	20677,#2
1836                     ; 477             break;
1838  035e 201a          	jra	L517
1839  0360               L346:
1840                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1840                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1842  0360 721450c8      	bset	20680,#2
1843                     ; 480             break;
1845  0364 2014          	jra	L517
1846                     ; 481         default:
1846                     ; 482             break;
1849  0366               L707:
1850                     ; 487         switch (CLK_IT)
1852  0366 7b01          	ld	a,(OFST+1,sp)
1854                     ; 495         default:
1854                     ; 496             break;
1855  0368 a00c          	sub	a,#12
1856  036a 270a          	jreq	L156
1857  036c a010          	sub	a,#16
1858  036e 260a          	jrne	L517
1859                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1859                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
1861  0370 721550c5      	bres	20677,#2
1862                     ; 491             break;
1864  0374 2004          	jra	L517
1865  0376               L156:
1866                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1866                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
1868  0376 721550c8      	bres	20680,#2
1869                     ; 494             break;
1870  037a               L517:
1871                     ; 500 }
1874  037a 85            	popw	x
1875  037b 81            	ret	
1876                     ; 495         default:
1876                     ; 496             break;
1878  037c               LC007:
1879  037c 89            	pushw	x
1880  037d 5f            	clrw	x
1881  037e 89            	pushw	x
1882  037f ae000c        	ldw	x,#L75
1883  0382 cd0000        	call	_assert_failed
1885  0385 5b04          	addw	sp,#4
1886  0387 81            	ret	
1922                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
1922                     ; 508 {
1923                     	switch	.text
1924  0388               _CLK_SYSCLKConfig:
1926  0388 88            	push	a
1927       00000000      OFST:	set	0
1930                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
1932  0389 4d            	tnz	a
1933  038a 273a          	jreq	L472
1934  038c a108          	cp	a,#8
1935  038e 2736          	jreq	L472
1936  0390 a110          	cp	a,#16
1937  0392 2732          	jreq	L472
1938  0394 a118          	cp	a,#24
1939  0396 272e          	jreq	L472
1940  0398 a180          	cp	a,#128
1941  039a 272a          	jreq	L472
1942  039c a181          	cp	a,#129
1943  039e 2726          	jreq	L472
1944  03a0 a182          	cp	a,#130
1945  03a2 2722          	jreq	L472
1946  03a4 a183          	cp	a,#131
1947  03a6 271e          	jreq	L472
1948  03a8 a184          	cp	a,#132
1949  03aa 271a          	jreq	L472
1950  03ac a185          	cp	a,#133
1951  03ae 2716          	jreq	L472
1952  03b0 a186          	cp	a,#134
1953  03b2 2712          	jreq	L472
1954  03b4 a187          	cp	a,#135
1955  03b6 270e          	jreq	L472
1956  03b8 ae01ff        	ldw	x,#511
1957  03bb 89            	pushw	x
1958  03bc 5f            	clrw	x
1959  03bd 89            	pushw	x
1960  03be ae000c        	ldw	x,#L75
1961  03c1 cd0000        	call	_assert_failed
1963  03c4 5b04          	addw	sp,#4
1964  03c6               L472:
1965                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1967  03c6 7b01          	ld	a,(OFST+1,sp)
1968  03c8 2b0e          	jrmi	L147
1969                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1971  03ca c650c6        	ld	a,20678
1972  03cd a4e7          	and	a,#231
1973  03cf c750c6        	ld	20678,a
1974                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
1976  03d2 7b01          	ld	a,(OFST+1,sp)
1977  03d4 a418          	and	a,#24
1979  03d6 200c          	jra	L347
1980  03d8               L147:
1981                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
1983  03d8 c650c6        	ld	a,20678
1984  03db a4f8          	and	a,#248
1985  03dd c750c6        	ld	20678,a
1986                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
1988  03e0 7b01          	ld	a,(OFST+1,sp)
1989  03e2 a407          	and	a,#7
1990  03e4               L347:
1991  03e4 ca50c6        	or	a,20678
1992  03e7 c750c6        	ld	20678,a
1993                     ; 524 }
1996  03ea 84            	pop	a
1997  03eb 81            	ret	
2054                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
2054                     ; 532 {
2055                     	switch	.text
2056  03ec               _CLK_SWIMConfig:
2058  03ec 88            	push	a
2059       00000000      OFST:	set	0
2062                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
2064  03ed 4d            	tnz	a
2065  03ee 2711          	jreq	L603
2066  03f0 4a            	dec	a
2067  03f1 270e          	jreq	L603
2068  03f3 ae0217        	ldw	x,#535
2069  03f6 89            	pushw	x
2070  03f7 5f            	clrw	x
2071  03f8 89            	pushw	x
2072  03f9 ae000c        	ldw	x,#L75
2073  03fc cd0000        	call	_assert_failed
2075  03ff 5b04          	addw	sp,#4
2076  0401               L603:
2077                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
2079  0401 7b01          	ld	a,(OFST+1,sp)
2080  0403 2706          	jreq	L377
2081                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
2083  0405 721050cd      	bset	20685,#0
2085  0409 2004          	jra	L577
2086  040b               L377:
2087                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
2089  040b 721150cd      	bres	20685,#0
2090  040f               L577:
2091                     ; 548 }
2094  040f 84            	pop	a
2095  0410 81            	ret	
2119                     ; 557 void CLK_ClockSecuritySystemEnable(void)
2119                     ; 558 {
2120                     	switch	.text
2121  0411               _CLK_ClockSecuritySystemEnable:
2125                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
2127  0411 721050c8      	bset	20680,#0
2128                     ; 561 }
2131  0415 81            	ret	
2156                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
2156                     ; 570 {
2157                     	switch	.text
2158  0416               _CLK_GetSYSCLKSource:
2162                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
2164  0416 c650c3        	ld	a,20675
2167  0419 81            	ret	
2230                     ; 579 uint32_t CLK_GetClockFreq(void)
2230                     ; 580 {
2231                     	switch	.text
2232  041a               _CLK_GetClockFreq:
2234  041a 5209          	subw	sp,#9
2235       00000009      OFST:	set	9
2238                     ; 582     uint32_t clockfrequency = 0;
2240                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
2242                     ; 584     uint8_t tmp = 0, presc = 0;
2246                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
2248  041c c650c3        	ld	a,20675
2249  041f 6b09          	ld	(OFST+0,sp),a
2250                     ; 589     if (clocksource == CLK_SOURCE_HSI)
2252  0421 a1e1          	cp	a,#225
2253  0423 2634          	jrne	L1501
2254                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
2256  0425 c650c6        	ld	a,20678
2257  0428 a418          	and	a,#24
2258  042a 44            	srl	a
2259  042b 44            	srl	a
2260  042c 44            	srl	a
2261                     ; 592         tmp = (uint8_t)(tmp >> 3);
2263                     ; 593         presc = HSIDivFactor[tmp];
2265  042d 5f            	clrw	x
2266  042e 97            	ld	xl,a
2267  042f d60000        	ld	a,(_HSIDivFactor,x)
2268  0432 6b09          	ld	(OFST+0,sp),a
2269                     ; 594         clockfrequency = HSI_VALUE / presc;
2271  0434 b703          	ld	c_lreg+3,a
2272  0436 3f02          	clr	c_lreg+2
2273  0438 3f01          	clr	c_lreg+1
2274  043a 3f00          	clr	c_lreg
2275  043c 96            	ldw	x,sp
2276  043d 5c            	incw	x
2277  043e cd0000        	call	c_rtol
2279  0441 ae2400        	ldw	x,#9216
2280  0444 bf02          	ldw	c_lreg+2,x
2281  0446 ae00f4        	ldw	x,#244
2282  0449 bf00          	ldw	c_lreg,x
2283  044b 96            	ldw	x,sp
2284  044c 5c            	incw	x
2285  044d cd0000        	call	c_ludv
2287  0450 96            	ldw	x,sp
2288  0451 1c0005        	addw	x,#OFST-4
2289  0454 cd0000        	call	c_rtol
2292  0457 2018          	jra	L3501
2293  0459               L1501:
2294                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
2296  0459 a1d2          	cp	a,#210
2297  045b 260a          	jrne	L5501
2298                     ; 598         clockfrequency = LSI_VALUE;
2300  045d aef400        	ldw	x,#62464
2301  0460 1f07          	ldw	(OFST-2,sp),x
2302  0462 ae0001        	ldw	x,#1
2304  0465 2008          	jp	LC008
2305  0467               L5501:
2306                     ; 602         clockfrequency = HSE_VALUE;
2308  0467 ae2400        	ldw	x,#9216
2309  046a 1f07          	ldw	(OFST-2,sp),x
2310  046c ae00f4        	ldw	x,#244
2311  046f               LC008:
2312  046f 1f05          	ldw	(OFST-4,sp),x
2313  0471               L3501:
2314                     ; 605     return((uint32_t)clockfrequency);
2316  0471 96            	ldw	x,sp
2317  0472 1c0005        	addw	x,#OFST-4
2318  0475 cd0000        	call	c_ltor
2322  0478 5b09          	addw	sp,#9
2323  047a 81            	ret	
2423                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2423                     ; 617 {
2424                     	switch	.text
2425  047b               _CLK_AdjustHSICalibrationValue:
2427  047b 88            	push	a
2428       00000000      OFST:	set	0
2431                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2433  047c 4d            	tnz	a
2434  047d 272a          	jreq	L623
2435  047f a101          	cp	a,#1
2436  0481 2726          	jreq	L623
2437  0483 a102          	cp	a,#2
2438  0485 2722          	jreq	L623
2439  0487 a103          	cp	a,#3
2440  0489 271e          	jreq	L623
2441  048b a104          	cp	a,#4
2442  048d 271a          	jreq	L623
2443  048f a105          	cp	a,#5
2444  0491 2716          	jreq	L623
2445  0493 a106          	cp	a,#6
2446  0495 2712          	jreq	L623
2447  0497 a107          	cp	a,#7
2448  0499 270e          	jreq	L623
2449  049b ae026c        	ldw	x,#620
2450  049e 89            	pushw	x
2451  049f 5f            	clrw	x
2452  04a0 89            	pushw	x
2453  04a1 ae000c        	ldw	x,#L75
2454  04a4 cd0000        	call	_assert_failed
2456  04a7 5b04          	addw	sp,#4
2457  04a9               L623:
2458                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2460  04a9 c650cc        	ld	a,20684
2461  04ac a4f8          	and	a,#248
2462  04ae 1a01          	or	a,(OFST+1,sp)
2463  04b0 c750cc        	ld	20684,a
2464                     ; 625 }
2467  04b3 84            	pop	a
2468  04b4 81            	ret	
2492                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2492                     ; 637 {
2493                     	switch	.text
2494  04b5               _CLK_SYSCLKEmergencyClear:
2498                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2500  04b5 721150c5      	bres	20677,#0
2501                     ; 639 }
2504  04b9 81            	ret	
2658                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2658                     ; 649 {
2659                     	switch	.text
2660  04ba               _CLK_GetFlagStatus:
2662  04ba 89            	pushw	x
2663  04bb 5203          	subw	sp,#3
2664       00000003      OFST:	set	3
2667                     ; 651     uint16_t statusreg = 0;
2669                     ; 652     uint8_t tmpreg = 0;
2671                     ; 653     FlagStatus bitstatus = RESET;
2673                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2675  04bd a30110        	cpw	x,#272
2676  04c0 2736          	jreq	L243
2677  04c2 a30102        	cpw	x,#258
2678  04c5 2731          	jreq	L243
2679  04c7 a30202        	cpw	x,#514
2680  04ca 272c          	jreq	L243
2681  04cc a30308        	cpw	x,#776
2682  04cf 2727          	jreq	L243
2683  04d1 a30301        	cpw	x,#769
2684  04d4 2722          	jreq	L243
2685  04d6 a30408        	cpw	x,#1032
2686  04d9 271d          	jreq	L243
2687  04db a30402        	cpw	x,#1026
2688  04de 2718          	jreq	L243
2689  04e0 a30504        	cpw	x,#1284
2690  04e3 2713          	jreq	L243
2691  04e5 a30502        	cpw	x,#1282
2692  04e8 270e          	jreq	L243
2693  04ea ae0290        	ldw	x,#656
2694  04ed 89            	pushw	x
2695  04ee 5f            	clrw	x
2696  04ef 89            	pushw	x
2697  04f0 ae000c        	ldw	x,#L75
2698  04f3 cd0000        	call	_assert_failed
2700  04f6 5b04          	addw	sp,#4
2701  04f8               L243:
2702                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2704  04f8 7b04          	ld	a,(OFST+1,sp)
2705  04fa 97            	ld	xl,a
2706  04fb 4f            	clr	a
2707  04fc 02            	rlwa	x,a
2708  04fd 1f01          	ldw	(OFST-2,sp),x
2709                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2711  04ff a30100        	cpw	x,#256
2712  0502 2605          	jrne	L3221
2713                     ; 664         tmpreg = CLK->ICKR;
2715  0504 c650c0        	ld	a,20672
2717  0507 2021          	jra	L5221
2718  0509               L3221:
2719                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2721  0509 a30200        	cpw	x,#512
2722  050c 2605          	jrne	L7221
2723                     ; 668         tmpreg = CLK->ECKR;
2725  050e c650c1        	ld	a,20673
2727  0511 2017          	jra	L5221
2728  0513               L7221:
2729                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2731  0513 a30300        	cpw	x,#768
2732  0516 2605          	jrne	L3321
2733                     ; 672         tmpreg = CLK->SWCR;
2735  0518 c650c5        	ld	a,20677
2737  051b 200d          	jra	L5221
2738  051d               L3321:
2739                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2741  051d a30400        	cpw	x,#1024
2742  0520 2605          	jrne	L7321
2743                     ; 676         tmpreg = CLK->CSSR;
2745  0522 c650c8        	ld	a,20680
2747  0525 2003          	jra	L5221
2748  0527               L7321:
2749                     ; 680         tmpreg = CLK->CCOR;
2751  0527 c650c9        	ld	a,20681
2752  052a               L5221:
2753  052a 6b03          	ld	(OFST+0,sp),a
2754                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2756  052c 7b05          	ld	a,(OFST+2,sp)
2757  052e 1503          	bcp	a,(OFST+0,sp)
2758  0530 2704          	jreq	L3421
2759                     ; 685         bitstatus = SET;
2761  0532 a601          	ld	a,#1
2763  0534 2001          	jra	L5421
2764  0536               L3421:
2765                     ; 689         bitstatus = RESET;
2767  0536 4f            	clr	a
2768  0537               L5421:
2769                     ; 693     return((FlagStatus)bitstatus);
2773  0537 5b05          	addw	sp,#5
2774  0539 81            	ret	
2821                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2821                     ; 704 {
2822                     	switch	.text
2823  053a               _CLK_GetITStatus:
2825  053a 88            	push	a
2826  053b 88            	push	a
2827       00000001      OFST:	set	1
2830                     ; 706     ITStatus bitstatus = RESET;
2832                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
2834  053c a10c          	cp	a,#12
2835  053e 2712          	jreq	L453
2836  0540 a11c          	cp	a,#28
2837  0542 270e          	jreq	L453
2838  0544 ae02c5        	ldw	x,#709
2839  0547 89            	pushw	x
2840  0548 5f            	clrw	x
2841  0549 89            	pushw	x
2842  054a ae000c        	ldw	x,#L75
2843  054d cd0000        	call	_assert_failed
2845  0550 5b04          	addw	sp,#4
2846  0552               L453:
2847                     ; 711     if (CLK_IT == CLK_IT_SWIF)
2849  0552 7b02          	ld	a,(OFST+1,sp)
2850  0554 a11c          	cp	a,#28
2851  0556 260b          	jrne	L1721
2852                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2854  0558 c650c5        	ld	a,20677
2855  055b 1402          	and	a,(OFST+1,sp)
2856  055d a10c          	cp	a,#12
2857  055f 260f          	jrne	L1031
2858                     ; 716             bitstatus = SET;
2860  0561 2009          	jp	LC010
2861                     ; 720             bitstatus = RESET;
2862  0563               L1721:
2863                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
2865  0563 c650c8        	ld	a,20680
2866  0566 1402          	and	a,(OFST+1,sp)
2867  0568 a10c          	cp	a,#12
2868  056a 2604          	jrne	L1031
2869                     ; 728             bitstatus = SET;
2871  056c               LC010:
2873  056c a601          	ld	a,#1
2875  056e 2001          	jra	L7721
2876  0570               L1031:
2877                     ; 732             bitstatus = RESET;
2880  0570 4f            	clr	a
2881  0571               L7721:
2882                     ; 737     return bitstatus;
2886  0571 85            	popw	x
2887  0572 81            	ret	
2924                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2924                     ; 748 {
2925                     	switch	.text
2926  0573               _CLK_ClearITPendingBit:
2928  0573 88            	push	a
2929       00000000      OFST:	set	0
2932                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
2934  0574 a10c          	cp	a,#12
2935  0576 2712          	jreq	L663
2936  0578 a11c          	cp	a,#28
2937  057a 270e          	jreq	L663
2938  057c ae02ef        	ldw	x,#751
2939  057f 89            	pushw	x
2940  0580 5f            	clrw	x
2941  0581 89            	pushw	x
2942  0582 ae000c        	ldw	x,#L75
2943  0585 cd0000        	call	_assert_failed
2945  0588 5b04          	addw	sp,#4
2946  058a               L663:
2947                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
2949  058a 7b01          	ld	a,(OFST+1,sp)
2950  058c a10c          	cp	a,#12
2951  058e 2606          	jrne	L3231
2952                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
2954  0590 721750c8      	bres	20680,#3
2956  0594 2004          	jra	L5231
2957  0596               L3231:
2958                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
2960  0596 721750c5      	bres	20677,#3
2961  059a               L5231:
2962                     ; 764 }
2965  059a 84            	pop	a
2966  059b 81            	ret	
3001                     	xdef	_CLKPrescTable
3002                     	xdef	_HSIDivFactor
3003                     	xdef	_CLK_ClearITPendingBit
3004                     	xdef	_CLK_GetITStatus
3005                     	xdef	_CLK_GetFlagStatus
3006                     	xdef	_CLK_GetSYSCLKSource
3007                     	xdef	_CLK_GetClockFreq
3008                     	xdef	_CLK_AdjustHSICalibrationValue
3009                     	xdef	_CLK_SYSCLKEmergencyClear
3010                     	xdef	_CLK_ClockSecuritySystemEnable
3011                     	xdef	_CLK_SWIMConfig
3012                     	xdef	_CLK_SYSCLKConfig
3013                     	xdef	_CLK_ITConfig
3014                     	xdef	_CLK_CCOConfig
3015                     	xdef	_CLK_HSIPrescalerConfig
3016                     	xdef	_CLK_ClockSwitchConfig
3017                     	xdef	_CLK_PeripheralClockConfig
3018                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
3019                     	xdef	_CLK_FastHaltWakeUpCmd
3020                     	xdef	_CLK_ClockSwitchCmd
3021                     	xdef	_CLK_CCOCmd
3022                     	xdef	_CLK_LSICmd
3023                     	xdef	_CLK_HSICmd
3024                     	xdef	_CLK_HSECmd
3025                     	xdef	_CLK_DeInit
3026                     	xref	_assert_failed
3027                     	switch	.const
3028  000c               L75:
3029  000c 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
3030  001e 6965735c7374  	dc.b	"ies\stm8s_stdperip"
3031  0030 685f64726976  	dc.b	"h_driver\src\stm8s"
3032  0042 5f636c6b2e63  	dc.b	"_clk.c",0
3033                     	xref.b	c_lreg
3034                     	xref.b	c_x
3054                     	xref	c_ltor
3055                     	xref	c_ludv
3056                     	xref	c_rtol
3057                     	end
