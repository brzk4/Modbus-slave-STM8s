   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  47                     ; 47 void UART2_DeInit(void)
  47                     ; 48 {
  49                     	switch	.text
  50  0000               _UART2_DeInit:
  54                     ; 51     (void) UART2->SR;
  56  0000 c65240        	ld	a,21056
  57                     ; 52     (void)UART2->DR;
  59  0003 c65241        	ld	a,21057
  60                     ; 54     UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  62  0006 725f5243      	clr	21059
  63                     ; 55     UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  65  000a 725f5242      	clr	21058
  66                     ; 57     UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  68  000e 725f5244      	clr	21060
  69                     ; 58     UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  71  0012 725f5245      	clr	21061
  72                     ; 59     UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  74  0016 725f5246      	clr	21062
  75                     ; 60     UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  77  001a 725f5247      	clr	21063
  78                     ; 61     UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  80  001e 725f5248      	clr	21064
  81                     ; 62     UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  83  0022 725f5249      	clr	21065
  84                     ; 64 }
  87  0026 81            	ret	
 409                     .const:	section	.text
 410  0000               L21:
 411  0000 00098969      	dc.l	625001
 412  0004               L27:
 413  0004 00000064      	dc.l	100
 414                     ; 80 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 414                     ; 81 {
 415                     	switch	.text
 416  0027               _UART2_Init:
 418  0027 520e          	subw	sp,#14
 419       0000000e      OFST:	set	14
 422                     ; 82     uint8_t BRR2_1 = 0, BRR2_2 = 0;
 426                     ; 83     uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 430                     ; 86     assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 432  0029 96            	ldw	x,sp
 433  002a 1c0011        	addw	x,#OFST+3
 434  002d cd0000        	call	c_ltor
 436  0030 ae0000        	ldw	x,#L21
 437  0033 cd0000        	call	c_lcmp
 439  0036 2506          	jrult	L41
 440  0038 ae0056        	ldw	x,#86
 441  003b cd01d6        	call	LC001
 442  003e               L41:
 443                     ; 87     assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 445  003e 7b15          	ld	a,(OFST+7,sp)
 446  0040 270a          	jreq	L42
 447  0042 a110          	cp	a,#16
 448  0044 2706          	jreq	L42
 449  0046 ae0057        	ldw	x,#87
 450  0049 cd01d6        	call	LC001
 451  004c               L42:
 452                     ; 88     assert_param(IS_UART2_STOPBITS_OK(StopBits));
 454  004c 7b16          	ld	a,(OFST+8,sp)
 455  004e 2712          	jreq	L43
 456  0050 a110          	cp	a,#16
 457  0052 270e          	jreq	L43
 458  0054 a120          	cp	a,#32
 459  0056 270a          	jreq	L43
 460  0058 a130          	cp	a,#48
 461  005a 2706          	jreq	L43
 462  005c ae0058        	ldw	x,#88
 463  005f cd01d6        	call	LC001
 464  0062               L43:
 465                     ; 89     assert_param(IS_UART2_PARITY_OK(Parity));
 467  0062 7b17          	ld	a,(OFST+9,sp)
 468  0064 270e          	jreq	L44
 469  0066 a104          	cp	a,#4
 470  0068 270a          	jreq	L44
 471  006a a106          	cp	a,#6
 472  006c 2706          	jreq	L44
 473  006e ae0059        	ldw	x,#89
 474  0071 cd01d6        	call	LC001
 475  0074               L44:
 476                     ; 90     assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 478  0074 7b19          	ld	a,(OFST+11,sp)
 479  0076 a108          	cp	a,#8
 480  0078 2722          	jreq	L45
 481  007a a140          	cp	a,#64
 482  007c 271e          	jreq	L45
 483  007e a104          	cp	a,#4
 484  0080 271a          	jreq	L45
 485  0082 a180          	cp	a,#128
 486  0084 2716          	jreq	L45
 487  0086 a10c          	cp	a,#12
 488  0088 2712          	jreq	L45
 489  008a a144          	cp	a,#68
 490  008c 270e          	jreq	L45
 491  008e a1c0          	cp	a,#192
 492  0090 270a          	jreq	L45
 493  0092 a188          	cp	a,#136
 494  0094 2706          	jreq	L45
 495  0096 ae005a        	ldw	x,#90
 496  0099 cd01d6        	call	LC001
 497  009c               L45:
 498                     ; 91     assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 500  009c 7b18          	ld	a,(OFST+10,sp)
 501  009e a488          	and	a,#136
 502  00a0 a188          	cp	a,#136
 503  00a2 2718          	jreq	L06
 504  00a4 7b18          	ld	a,(OFST+10,sp)
 505  00a6 a444          	and	a,#68
 506  00a8 a144          	cp	a,#68
 507  00aa 2710          	jreq	L06
 508  00ac 7b18          	ld	a,(OFST+10,sp)
 509  00ae a422          	and	a,#34
 510  00b0 a122          	cp	a,#34
 511  00b2 2708          	jreq	L06
 512  00b4 7b18          	ld	a,(OFST+10,sp)
 513  00b6 a411          	and	a,#17
 514  00b8 a111          	cp	a,#17
 515  00ba 2606          	jrne	L26
 516  00bc               L06:
 517  00bc ae005b        	ldw	x,#91
 518  00bf cd01d6        	call	LC001
 519  00c2               L26:
 520                     ; 94     UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 522  00c2 72195244      	bres	21060,#4
 523                     ; 96     UART2->CR1 |= (uint8_t)WordLength; 
 525  00c6 c65244        	ld	a,21060
 526  00c9 1a15          	or	a,(OFST+7,sp)
 527  00cb c75244        	ld	21060,a
 528                     ; 99     UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 530  00ce c65246        	ld	a,21062
 531  00d1 a4cf          	and	a,#207
 532  00d3 c75246        	ld	21062,a
 533                     ; 101     UART2->CR3 |= (uint8_t)StopBits; 
 535  00d6 c65246        	ld	a,21062
 536  00d9 1a16          	or	a,(OFST+8,sp)
 537  00db c75246        	ld	21062,a
 538                     ; 104     UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 540  00de c65244        	ld	a,21060
 541  00e1 a4f9          	and	a,#249
 542  00e3 c75244        	ld	21060,a
 543                     ; 106     UART2->CR1 |= (uint8_t)Parity;
 545  00e6 c65244        	ld	a,21060
 546  00e9 1a17          	or	a,(OFST+9,sp)
 547  00eb c75244        	ld	21060,a
 548                     ; 109     UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 550  00ee 725f5242      	clr	21058
 551                     ; 111     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 553  00f2 c65243        	ld	a,21059
 554  00f5 a40f          	and	a,#15
 555  00f7 c75243        	ld	21059,a
 556                     ; 113     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 558  00fa c65243        	ld	a,21059
 559  00fd a4f0          	and	a,#240
 560  00ff c75243        	ld	21059,a
 561                     ; 116     BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 563  0102 96            	ldw	x,sp
 564  0103 cd01e2        	call	LC002
 566  0106 96            	ldw	x,sp
 567  0107 5c            	incw	x
 568  0108 cd0000        	call	c_rtol
 570  010b cd0000        	call	_CLK_GetClockFreq
 572  010e 96            	ldw	x,sp
 573  010f 5c            	incw	x
 574  0110 cd0000        	call	c_ludv
 576  0113 96            	ldw	x,sp
 577  0114 1c000b        	addw	x,#OFST-3
 578  0117 cd0000        	call	c_rtol
 580                     ; 117     BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 582  011a 96            	ldw	x,sp
 583  011b cd01e2        	call	LC002
 585  011e 96            	ldw	x,sp
 586  011f 5c            	incw	x
 587  0120 cd0000        	call	c_rtol
 589  0123 cd0000        	call	_CLK_GetClockFreq
 591  0126 a664          	ld	a,#100
 592  0128 cd0000        	call	c_smul
 594  012b 96            	ldw	x,sp
 595  012c 5c            	incw	x
 596  012d cd0000        	call	c_ludv
 598  0130 96            	ldw	x,sp
 599  0131 1c0007        	addw	x,#OFST-7
 600  0134 cd0000        	call	c_rtol
 602                     ; 121     BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 602                     ; 122                         << 4) / 100) & (uint8_t)0x0F); 
 604  0137 96            	ldw	x,sp
 605  0138 1c000b        	addw	x,#OFST-3
 606  013b cd0000        	call	c_ltor
 608  013e a664          	ld	a,#100
 609  0140 cd0000        	call	c_smul
 611  0143 96            	ldw	x,sp
 612  0144 5c            	incw	x
 613  0145 cd0000        	call	c_rtol
 615  0148 96            	ldw	x,sp
 616  0149 1c0007        	addw	x,#OFST-7
 617  014c cd0000        	call	c_ltor
 619  014f 96            	ldw	x,sp
 620  0150 5c            	incw	x
 621  0151 cd0000        	call	c_lsub
 623  0154 a604          	ld	a,#4
 624  0156 cd0000        	call	c_llsh
 626  0159 ae0004        	ldw	x,#L27
 627  015c cd0000        	call	c_ludv
 629  015f b603          	ld	a,c_lreg+3
 630  0161 a40f          	and	a,#15
 631  0163 6b05          	ld	(OFST-9,sp),a
 632                     ; 123     BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 634  0165 96            	ldw	x,sp
 635  0166 1c000b        	addw	x,#OFST-3
 636  0169 cd0000        	call	c_ltor
 638  016c a604          	ld	a,#4
 639  016e cd0000        	call	c_lursh
 641  0171 b603          	ld	a,c_lreg+3
 642  0173 a4f0          	and	a,#240
 643  0175 b703          	ld	c_lreg+3,a
 644  0177 3f02          	clr	c_lreg+2
 645  0179 3f01          	clr	c_lreg+1
 646  017b 3f00          	clr	c_lreg
 647  017d 6b06          	ld	(OFST-8,sp),a
 648                     ; 125     UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 650  017f 1a05          	or	a,(OFST-9,sp)
 651  0181 c75243        	ld	21059,a
 652                     ; 127     UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 654  0184 7b0e          	ld	a,(OFST+0,sp)
 655  0186 c75242        	ld	21058,a
 656                     ; 130     UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 658  0189 c65245        	ld	a,21061
 659  018c a4f3          	and	a,#243
 660  018e c75245        	ld	21061,a
 661                     ; 132     UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 663  0191 c65246        	ld	a,21062
 664  0194 a4f8          	and	a,#248
 665  0196 c75246        	ld	21062,a
 666                     ; 134     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 666                     ; 135                                               UART2_CR3_CPHA | UART2_CR3_LBCL));
 668  0199 7b18          	ld	a,(OFST+10,sp)
 669  019b a407          	and	a,#7
 670  019d ca5246        	or	a,21062
 671  01a0 c75246        	ld	21062,a
 672                     ; 137     if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 674  01a3 7b19          	ld	a,(OFST+11,sp)
 675  01a5 a504          	bcp	a,#4
 676  01a7 2706          	jreq	L502
 677                     ; 140         UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 679  01a9 72165245      	bset	21061,#3
 681  01ad 2004          	jra	L702
 682  01af               L502:
 683                     ; 145         UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 685  01af 72175245      	bres	21061,#3
 686  01b3               L702:
 687                     ; 147     if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 689  01b3 a508          	bcp	a,#8
 690  01b5 2706          	jreq	L112
 691                     ; 150         UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 693  01b7 72145245      	bset	21061,#2
 695  01bb 2004          	jra	L312
 696  01bd               L112:
 697                     ; 155         UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 699  01bd 72155245      	bres	21061,#2
 700  01c1               L312:
 701                     ; 159     if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 703  01c1 7b18          	ld	a,(OFST+10,sp)
 704  01c3 2a06          	jrpl	L512
 705                     ; 162         UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 707  01c5 72175246      	bres	21062,#3
 709  01c9 2008          	jra	L712
 710  01cb               L512:
 711                     ; 166         UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 713  01cb a408          	and	a,#8
 714  01cd ca5246        	or	a,21062
 715  01d0 c75246        	ld	21062,a
 716  01d3               L712:
 717                     ; 168 }
 720  01d3 5b0e          	addw	sp,#14
 721  01d5 81            	ret	
 722  01d6               LC001:
 723  01d6 89            	pushw	x
 724  01d7 5f            	clrw	x
 725  01d8 89            	pushw	x
 726  01d9 ae0008        	ldw	x,#L302
 727  01dc cd0000        	call	_assert_failed
 729  01df 5b04          	addw	sp,#4
 730  01e1 81            	ret	
 731  01e2               LC002:
 732  01e2 1c0011        	addw	x,#OFST+3
 733  01e5 cd0000        	call	c_ltor
 735  01e8 a604          	ld	a,#4
 736  01ea cc0000        	jp	c_llsh
 791                     ; 176 void UART2_Cmd(FunctionalState NewState)
 791                     ; 177 {
 792                     	switch	.text
 793  01ed               _UART2_Cmd:
 797                     ; 179     if (NewState != DISABLE)
 799  01ed 4d            	tnz	a
 800  01ee 2705          	jreq	L742
 801                     ; 182         UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 803  01f0 721b5244      	bres	21060,#5
 806  01f4 81            	ret	
 807  01f5               L742:
 808                     ; 187         UART2->CR1 |= UART2_CR1_UARTD; 
 810  01f5 721a5244      	bset	21060,#5
 811                     ; 189 }
 814  01f9 81            	ret	
 947                     ; 206 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 947                     ; 207 {
 948                     	switch	.text
 949  01fa               _UART2_ITConfig:
 951  01fa 89            	pushw	x
 952  01fb 89            	pushw	x
 953       00000002      OFST:	set	2
 956                     ; 208     uint8_t uartreg = 0, itpos = 0x00;
 960                     ; 211     assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 962  01fc a30100        	cpw	x,#256
 963  01ff 2724          	jreq	L401
 964  0201 a30277        	cpw	x,#631
 965  0204 271f          	jreq	L401
 966  0206 a30266        	cpw	x,#614
 967  0209 271a          	jreq	L401
 968  020b a30205        	cpw	x,#517
 969  020e 2715          	jreq	L401
 970  0210 a30244        	cpw	x,#580
 971  0213 2710          	jreq	L401
 972  0215 a30412        	cpw	x,#1042
 973  0218 270b          	jreq	L401
 974  021a a30346        	cpw	x,#838
 975  021d 2706          	jreq	L401
 976  021f ae00d3        	ldw	x,#211
 977  0222 cd02af        	call	LC007
 978  0225               L401:
 979                     ; 212     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 981  0225 7b07          	ld	a,(OFST+5,sp)
 982  0227 2708          	jreq	L411
 983  0229 4a            	dec	a
 984  022a 2705          	jreq	L411
 985  022c ae00d4        	ldw	x,#212
 986  022f ad7e          	call	LC007
 987  0231               L411:
 988                     ; 215     uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
 990  0231 7b03          	ld	a,(OFST+1,sp)
 991  0233 6b01          	ld	(OFST-1,sp),a
 992                     ; 218     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
 994  0235 7b04          	ld	a,(OFST+2,sp)
 995  0237 a40f          	and	a,#15
 996  0239 5f            	clrw	x
 997  023a 97            	ld	xl,a
 998  023b a601          	ld	a,#1
 999  023d 5d            	tnzw	x
1000  023e 2704          	jreq	L021
1001  0240               L221:
1002  0240 48            	sll	a
1003  0241 5a            	decw	x
1004  0242 26fc          	jrne	L221
1005  0244               L021:
1006  0244 6b02          	ld	(OFST+0,sp),a
1007                     ; 220     if (NewState != DISABLE)
1009  0246 7b07          	ld	a,(OFST+5,sp)
1010  0248 272a          	jreq	L333
1011                     ; 223         if (uartreg == 0x01)
1013  024a 7b01          	ld	a,(OFST-1,sp)
1014  024c a101          	cp	a,#1
1015  024e 2607          	jrne	L533
1016                     ; 225             UART2->CR1 |= itpos;
1018  0250 c65244        	ld	a,21060
1019  0253 1a02          	or	a,(OFST+0,sp)
1021  0255 2029          	jp	LC005
1022  0257               L533:
1023                     ; 227         else if (uartreg == 0x02)
1025  0257 a102          	cp	a,#2
1026  0259 2607          	jrne	L143
1027                     ; 229             UART2->CR2 |= itpos;
1029  025b c65245        	ld	a,21061
1030  025e 1a02          	or	a,(OFST+0,sp)
1032  0260 202d          	jp	LC004
1033  0262               L143:
1034                     ; 231         else if (uartreg == 0x03)
1036  0262 a103          	cp	a,#3
1037  0264 2607          	jrne	L543
1038                     ; 233             UART2->CR4 |= itpos;
1040  0266 c65247        	ld	a,21063
1041  0269 1a02          	or	a,(OFST+0,sp)
1043  026b 2031          	jp	LC006
1044  026d               L543:
1045                     ; 237             UART2->CR6 |= itpos;
1047  026d c65249        	ld	a,21065
1048  0270 1a02          	or	a,(OFST+0,sp)
1049  0272 2035          	jp	LC003
1050  0274               L333:
1051                     ; 243         if (uartreg == 0x01)
1053  0274 7b01          	ld	a,(OFST-1,sp)
1054  0276 a101          	cp	a,#1
1055  0278 260b          	jrne	L353
1056                     ; 245             UART2->CR1 &= (uint8_t)(~itpos);
1058  027a 7b02          	ld	a,(OFST+0,sp)
1059  027c 43            	cpl	a
1060  027d c45244        	and	a,21060
1061  0280               LC005:
1062  0280 c75244        	ld	21060,a
1064  0283 2027          	jra	L153
1065  0285               L353:
1066                     ; 247         else if (uartreg == 0x02)
1068  0285 a102          	cp	a,#2
1069  0287 260b          	jrne	L753
1070                     ; 249             UART2->CR2 &= (uint8_t)(~itpos);
1072  0289 7b02          	ld	a,(OFST+0,sp)
1073  028b 43            	cpl	a
1074  028c c45245        	and	a,21061
1075  028f               LC004:
1076  028f c75245        	ld	21061,a
1078  0292 2018          	jra	L153
1079  0294               L753:
1080                     ; 251         else if (uartreg == 0x03)
1082  0294 a103          	cp	a,#3
1083  0296 260b          	jrne	L363
1084                     ; 253             UART2->CR4 &= (uint8_t)(~itpos);
1086  0298 7b02          	ld	a,(OFST+0,sp)
1087  029a 43            	cpl	a
1088  029b c45247        	and	a,21063
1089  029e               LC006:
1090  029e c75247        	ld	21063,a
1092  02a1 2009          	jra	L153
1093  02a3               L363:
1094                     ; 257             UART2->CR6 &= (uint8_t)(~itpos);
1096  02a3 7b02          	ld	a,(OFST+0,sp)
1097  02a5 43            	cpl	a
1098  02a6 c45249        	and	a,21065
1099  02a9               LC003:
1100  02a9 c75249        	ld	21065,a
1101  02ac               L153:
1102                     ; 260 }
1105  02ac 5b04          	addw	sp,#4
1106  02ae 81            	ret	
1107  02af               LC007:
1108  02af 89            	pushw	x
1109  02b0 5f            	clrw	x
1110  02b1 89            	pushw	x
1111  02b2 ae0008        	ldw	x,#L302
1112  02b5 cd0000        	call	_assert_failed
1114  02b8 5b04          	addw	sp,#4
1115  02ba 81            	ret	
1173                     ; 267 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1173                     ; 268 {
1174                     	switch	.text
1175  02bb               _UART2_IrDAConfig:
1177  02bb 88            	push	a
1178       00000000      OFST:	set	0
1181                     ; 269     assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1183  02bc a101          	cp	a,#1
1184  02be 2711          	jreq	L231
1185  02c0 4d            	tnz	a
1186  02c1 270e          	jreq	L231
1187  02c3 ae010d        	ldw	x,#269
1188  02c6 89            	pushw	x
1189  02c7 5f            	clrw	x
1190  02c8 89            	pushw	x
1191  02c9 ae0008        	ldw	x,#L302
1192  02cc cd0000        	call	_assert_failed
1194  02cf 5b04          	addw	sp,#4
1195  02d1               L231:
1196                     ; 271     if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1198  02d1 7b01          	ld	a,(OFST+1,sp)
1199  02d3 2706          	jreq	L514
1200                     ; 273         UART2->CR5 |= UART2_CR5_IRLP;
1202  02d5 72145248      	bset	21064,#2
1204  02d9 2004          	jra	L714
1205  02db               L514:
1206                     ; 277         UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1208  02db 72155248      	bres	21064,#2
1209  02df               L714:
1210                     ; 279 }
1213  02df 84            	pop	a
1214  02e0 81            	ret	
1250                     ; 287 void UART2_IrDACmd(FunctionalState NewState)
1250                     ; 288 {
1251                     	switch	.text
1252  02e1               _UART2_IrDACmd:
1254  02e1 88            	push	a
1255       00000000      OFST:	set	0
1258                     ; 290     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1260  02e2 4d            	tnz	a
1261  02e3 2711          	jreq	L441
1262  02e5 4a            	dec	a
1263  02e6 270e          	jreq	L441
1264  02e8 ae0122        	ldw	x,#290
1265  02eb 89            	pushw	x
1266  02ec 5f            	clrw	x
1267  02ed 89            	pushw	x
1268  02ee ae0008        	ldw	x,#L302
1269  02f1 cd0000        	call	_assert_failed
1271  02f4 5b04          	addw	sp,#4
1272  02f6               L441:
1273                     ; 292     if (NewState != DISABLE)
1275  02f6 7b01          	ld	a,(OFST+1,sp)
1276  02f8 2706          	jreq	L734
1277                     ; 295         UART2->CR5 |= UART2_CR5_IREN;
1279  02fa 72125248      	bset	21064,#1
1281  02fe 2004          	jra	L144
1282  0300               L734:
1283                     ; 300         UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1285  0300 72135248      	bres	21064,#1
1286  0304               L144:
1287                     ; 302 }
1290  0304 84            	pop	a
1291  0305 81            	ret	
1351                     ; 311 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1351                     ; 312 {
1352                     	switch	.text
1353  0306               _UART2_LINBreakDetectionConfig:
1355  0306 88            	push	a
1356       00000000      OFST:	set	0
1359                     ; 314     assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1361  0307 4d            	tnz	a
1362  0308 2711          	jreq	L651
1363  030a 4a            	dec	a
1364  030b 270e          	jreq	L651
1365  030d ae013a        	ldw	x,#314
1366  0310 89            	pushw	x
1367  0311 5f            	clrw	x
1368  0312 89            	pushw	x
1369  0313 ae0008        	ldw	x,#L302
1370  0316 cd0000        	call	_assert_failed
1372  0319 5b04          	addw	sp,#4
1373  031b               L651:
1374                     ; 316     if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1376  031b 7b01          	ld	a,(OFST+1,sp)
1377  031d 2706          	jreq	L174
1378                     ; 318         UART2->CR4 |= UART2_CR4_LBDL;
1380  031f 721a5247      	bset	21063,#5
1382  0323 2004          	jra	L374
1383  0325               L174:
1384                     ; 322         UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1386  0325 721b5247      	bres	21063,#5
1387  0329               L374:
1388                     ; 324 }
1391  0329 84            	pop	a
1392  032a 81            	ret	
1514                     ; 336 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1514                     ; 337                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1514                     ; 338                      UART2_LinDivUp_TypeDef UART2_DivUp)
1514                     ; 339 {
1515                     	switch	.text
1516  032b               _UART2_LINConfig:
1518  032b 89            	pushw	x
1519       00000000      OFST:	set	0
1522                     ; 341     assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1524  032c 9e            	ld	a,xh
1525  032d 4d            	tnz	a
1526  032e 2709          	jreq	L071
1527  0330 9e            	ld	a,xh
1528  0331 4a            	dec	a
1529  0332 2705          	jreq	L071
1530  0334 ae0155        	ldw	x,#341
1531  0337 ad46          	call	LC008
1532  0339               L071:
1533                     ; 342     assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1535  0339 7b02          	ld	a,(OFST+2,sp)
1536  033b 4a            	dec	a
1537  033c 2709          	jreq	L002
1538  033e 7b02          	ld	a,(OFST+2,sp)
1539  0340 2705          	jreq	L002
1540  0342 ae0156        	ldw	x,#342
1541  0345 ad38          	call	LC008
1542  0347               L002:
1543                     ; 343     assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1545  0347 7b05          	ld	a,(OFST+5,sp)
1546  0349 2708          	jreq	L012
1547  034b 4a            	dec	a
1548  034c 2705          	jreq	L012
1549  034e ae0157        	ldw	x,#343
1550  0351 ad2c          	call	LC008
1551  0353               L012:
1552                     ; 345     if (UART2_Mode != UART2_LIN_MODE_MASTER)
1554  0353 7b01          	ld	a,(OFST+1,sp)
1555  0355 2706          	jreq	L355
1556                     ; 347         UART2->CR6 |=  UART2_CR6_LSLV;
1558  0357 721a5249      	bset	21065,#5
1560  035b 2004          	jra	L555
1561  035d               L355:
1562                     ; 351         UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1564  035d 721b5249      	bres	21065,#5
1565  0361               L555:
1566                     ; 354     if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1568  0361 7b02          	ld	a,(OFST+2,sp)
1569  0363 2706          	jreq	L755
1570                     ; 356         UART2->CR6 |=  UART2_CR6_LASE ;
1572  0365 72185249      	bset	21065,#4
1574  0369 2004          	jra	L165
1575  036b               L755:
1576                     ; 360         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1578  036b 72195249      	bres	21065,#4
1579  036f               L165:
1580                     ; 363     if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1582  036f 7b05          	ld	a,(OFST+5,sp)
1583  0371 2706          	jreq	L365
1584                     ; 365         UART2->CR6 |=  UART2_CR6_LDUM;
1586  0373 721e5249      	bset	21065,#7
1588  0377 2004          	jra	L565
1589  0379               L365:
1590                     ; 369         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1592  0379 721f5249      	bres	21065,#7
1593  037d               L565:
1594                     ; 371 }
1597  037d 85            	popw	x
1598  037e 81            	ret	
1599  037f               LC008:
1600  037f 89            	pushw	x
1601  0380 5f            	clrw	x
1602  0381 89            	pushw	x
1603  0382 ae0008        	ldw	x,#L302
1604  0385 cd0000        	call	_assert_failed
1606  0388 5b04          	addw	sp,#4
1607  038a 81            	ret	
1643                     ; 379 void UART2_LINCmd(FunctionalState NewState)
1643                     ; 380 {
1644                     	switch	.text
1645  038b               _UART2_LINCmd:
1647  038b 88            	push	a
1648       00000000      OFST:	set	0
1651                     ; 381     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1653  038c 4d            	tnz	a
1654  038d 2711          	jreq	L222
1655  038f 4a            	dec	a
1656  0390 270e          	jreq	L222
1657  0392 ae017d        	ldw	x,#381
1658  0395 89            	pushw	x
1659  0396 5f            	clrw	x
1660  0397 89            	pushw	x
1661  0398 ae0008        	ldw	x,#L302
1662  039b cd0000        	call	_assert_failed
1664  039e 5b04          	addw	sp,#4
1665  03a0               L222:
1666                     ; 383     if (NewState != DISABLE)
1668  03a0 7b01          	ld	a,(OFST+1,sp)
1669  03a2 2706          	jreq	L506
1670                     ; 386         UART2->CR3 |= UART2_CR3_LINEN;
1672  03a4 721c5246      	bset	21062,#6
1674  03a8 2004          	jra	L706
1675  03aa               L506:
1676                     ; 391         UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1678  03aa 721d5246      	bres	21062,#6
1679  03ae               L706:
1680                     ; 393 }
1683  03ae 84            	pop	a
1684  03af 81            	ret	
1720                     ; 400 void UART2_SmartCardCmd(FunctionalState NewState)
1720                     ; 401 {
1721                     	switch	.text
1722  03b0               _UART2_SmartCardCmd:
1724  03b0 88            	push	a
1725       00000000      OFST:	set	0
1728                     ; 403     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1730  03b1 4d            	tnz	a
1731  03b2 2711          	jreq	L432
1732  03b4 4a            	dec	a
1733  03b5 270e          	jreq	L432
1734  03b7 ae0193        	ldw	x,#403
1735  03ba 89            	pushw	x
1736  03bb 5f            	clrw	x
1737  03bc 89            	pushw	x
1738  03bd ae0008        	ldw	x,#L302
1739  03c0 cd0000        	call	_assert_failed
1741  03c3 5b04          	addw	sp,#4
1742  03c5               L432:
1743                     ; 405     if (NewState != DISABLE)
1745  03c5 7b01          	ld	a,(OFST+1,sp)
1746  03c7 2706          	jreq	L726
1747                     ; 408         UART2->CR5 |= UART2_CR5_SCEN;
1749  03c9 721a5248      	bset	21064,#5
1751  03cd 2004          	jra	L136
1752  03cf               L726:
1753                     ; 413         UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1755  03cf 721b5248      	bres	21064,#5
1756  03d3               L136:
1757                     ; 415 }
1760  03d3 84            	pop	a
1761  03d4 81            	ret	
1798                     ; 423 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1798                     ; 424 {
1799                     	switch	.text
1800  03d5               _UART2_SmartCardNACKCmd:
1802  03d5 88            	push	a
1803       00000000      OFST:	set	0
1806                     ; 426     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1808  03d6 4d            	tnz	a
1809  03d7 2711          	jreq	L642
1810  03d9 4a            	dec	a
1811  03da 270e          	jreq	L642
1812  03dc ae01aa        	ldw	x,#426
1813  03df 89            	pushw	x
1814  03e0 5f            	clrw	x
1815  03e1 89            	pushw	x
1816  03e2 ae0008        	ldw	x,#L302
1817  03e5 cd0000        	call	_assert_failed
1819  03e8 5b04          	addw	sp,#4
1820  03ea               L642:
1821                     ; 428     if (NewState != DISABLE)
1823  03ea 7b01          	ld	a,(OFST+1,sp)
1824  03ec 2706          	jreq	L156
1825                     ; 431         UART2->CR5 |= UART2_CR5_NACK;
1827  03ee 72185248      	bset	21064,#4
1829  03f2 2004          	jra	L356
1830  03f4               L156:
1831                     ; 436         UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1833  03f4 72195248      	bres	21064,#4
1834  03f8               L356:
1835                     ; 438 }
1838  03f8 84            	pop	a
1839  03f9 81            	ret	
1897                     ; 446 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1897                     ; 447 {
1898                     	switch	.text
1899  03fa               _UART2_WakeUpConfig:
1901  03fa 88            	push	a
1902       00000000      OFST:	set	0
1905                     ; 448     assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1907  03fb 4d            	tnz	a
1908  03fc 2712          	jreq	L062
1909  03fe a108          	cp	a,#8
1910  0400 270e          	jreq	L062
1911  0402 ae01c0        	ldw	x,#448
1912  0405 89            	pushw	x
1913  0406 5f            	clrw	x
1914  0407 89            	pushw	x
1915  0408 ae0008        	ldw	x,#L302
1916  040b cd0000        	call	_assert_failed
1918  040e 5b04          	addw	sp,#4
1919  0410               L062:
1920                     ; 450     UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
1922  0410 72175244      	bres	21060,#3
1923                     ; 451     UART2->CR1 |= (uint8_t)UART2_WakeUp;
1925  0414 c65244        	ld	a,21060
1926  0417 1a01          	or	a,(OFST+1,sp)
1927  0419 c75244        	ld	21060,a
1928                     ; 452 }
1931  041c 84            	pop	a
1932  041d 81            	ret	
1969                     ; 460 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1969                     ; 461 {
1970                     	switch	.text
1971  041e               _UART2_ReceiverWakeUpCmd:
1973  041e 88            	push	a
1974       00000000      OFST:	set	0
1977                     ; 462     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1979  041f 4d            	tnz	a
1980  0420 2711          	jreq	L272
1981  0422 4a            	dec	a
1982  0423 270e          	jreq	L272
1983  0425 ae01ce        	ldw	x,#462
1984  0428 89            	pushw	x
1985  0429 5f            	clrw	x
1986  042a 89            	pushw	x
1987  042b ae0008        	ldw	x,#L302
1988  042e cd0000        	call	_assert_failed
1990  0431 5b04          	addw	sp,#4
1991  0433               L272:
1992                     ; 464     if (NewState != DISABLE)
1994  0433 7b01          	ld	a,(OFST+1,sp)
1995  0435 2706          	jreq	L127
1996                     ; 467         UART2->CR2 |= UART2_CR2_RWU;
1998  0437 72125245      	bset	21061,#1
2000  043b 2004          	jra	L327
2001  043d               L127:
2002                     ; 472         UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
2004  043d 72135245      	bres	21061,#1
2005  0441               L327:
2006                     ; 474 }
2009  0441 84            	pop	a
2010  0442 81            	ret	
2033                     ; 481 uint8_t UART2_ReceiveData8(void)
2033                     ; 482 {
2034                     	switch	.text
2035  0443               _UART2_ReceiveData8:
2039                     ; 483     return ((uint8_t)UART2->DR);
2041  0443 c65241        	ld	a,21057
2044  0446 81            	ret	
2078                     ; 491 uint16_t UART2_ReceiveData9(void)
2078                     ; 492 {
2079                     	switch	.text
2080  0447               _UART2_ReceiveData9:
2082  0447 89            	pushw	x
2083       00000002      OFST:	set	2
2086                     ; 493   uint16_t temp = 0;
2088                     ; 495   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
2090  0448 c65244        	ld	a,21060
2091  044b a480          	and	a,#128
2092  044d 5f            	clrw	x
2093  044e 02            	rlwa	x,a
2094  044f 58            	sllw	x
2095  0450 1f01          	ldw	(OFST-1,sp),x
2096                     ; 497   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
2098  0452 c65241        	ld	a,21057
2099  0455 5f            	clrw	x
2100  0456 97            	ld	xl,a
2101  0457 01            	rrwa	x,a
2102  0458 1a02          	or	a,(OFST+0,sp)
2103  045a 01            	rrwa	x,a
2104  045b 1a01          	or	a,(OFST-1,sp)
2105  045d a401          	and	a,#1
2106  045f 01            	rrwa	x,a
2109  0460 5b02          	addw	sp,#2
2110  0462 81            	ret	
2144                     ; 505 void UART2_SendData8(uint8_t Data)
2144                     ; 506 {
2145                     	switch	.text
2146  0463               _UART2_SendData8:
2150                     ; 508     UART2->DR = Data;
2152  0463 c75241        	ld	21057,a
2153                     ; 509 }
2156  0466 81            	ret	
2190                     ; 516 void UART2_SendData9(uint16_t Data)
2190                     ; 517 {
2191                     	switch	.text
2192  0467               _UART2_SendData9:
2194  0467 89            	pushw	x
2195       00000000      OFST:	set	0
2198                     ; 519     UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
2200  0468 721d5244      	bres	21060,#6
2201                     ; 522     UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
2203  046c 54            	srlw	x
2204  046d 54            	srlw	x
2205  046e 9f            	ld	a,xl
2206  046f a440          	and	a,#64
2207  0471 ca5244        	or	a,21060
2208  0474 c75244        	ld	21060,a
2209                     ; 525     UART2->DR   = (uint8_t)(Data);                    
2211  0477 7b02          	ld	a,(OFST+2,sp)
2212  0479 c75241        	ld	21057,a
2213                     ; 527 }
2216  047c 85            	popw	x
2217  047d 81            	ret	
2240                     ; 534 void UART2_SendBreak(void)
2240                     ; 535 {
2241                     	switch	.text
2242  047e               _UART2_SendBreak:
2246                     ; 536     UART2->CR2 |= UART2_CR2_SBK;
2248  047e 72105245      	bset	21061,#0
2249                     ; 537 }
2252  0482 81            	ret	
2287                     ; 544 void UART2_SetAddress(uint8_t UART2_Address)
2287                     ; 545 {
2288                     	switch	.text
2289  0483               _UART2_SetAddress:
2291  0483 88            	push	a
2292       00000000      OFST:	set	0
2295                     ; 547     assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2297  0484 a110          	cp	a,#16
2298  0486 250e          	jrult	L413
2299  0488 ae0223        	ldw	x,#547
2300  048b 89            	pushw	x
2301  048c 5f            	clrw	x
2302  048d 89            	pushw	x
2303  048e ae0008        	ldw	x,#L302
2304  0491 cd0000        	call	_assert_failed
2306  0494 5b04          	addw	sp,#4
2307  0496               L413:
2308                     ; 550     UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2310  0496 c65247        	ld	a,21063
2311  0499 a4f0          	and	a,#240
2312  049b c75247        	ld	21063,a
2313                     ; 552     UART2->CR4 |= UART2_Address;
2315  049e c65247        	ld	a,21063
2316  04a1 1a01          	or	a,(OFST+1,sp)
2317  04a3 c75247        	ld	21063,a
2318                     ; 553 }
2321  04a6 84            	pop	a
2322  04a7 81            	ret	
2356                     ; 561 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2356                     ; 562 {
2357                     	switch	.text
2358  04a8               _UART2_SetGuardTime:
2362                     ; 564     UART2->GTR = UART2_GuardTime;
2364  04a8 c7524a        	ld	21066,a
2365                     ; 565 }
2368  04ab 81            	ret	
2402                     ; 589 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2402                     ; 590 {
2403                     	switch	.text
2404  04ac               _UART2_SetPrescaler:
2408                     ; 592     UART2->PSCR = UART2_Prescaler;
2410  04ac c7524b        	ld	21067,a
2411                     ; 593 }
2414  04af 81            	ret	
2572                     ; 601 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2572                     ; 602 {
2573                     	switch	.text
2574  04b0               _UART2_GetFlagStatus:
2576  04b0 89            	pushw	x
2577  04b1 88            	push	a
2578       00000001      OFST:	set	1
2581                     ; 603     FlagStatus status = RESET;
2583                     ; 606     assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2585  04b2 a30080        	cpw	x,#128
2586  04b5 2745          	jreq	L233
2587  04b7 a30040        	cpw	x,#64
2588  04ba 2740          	jreq	L233
2589  04bc a30020        	cpw	x,#32
2590  04bf 273b          	jreq	L233
2591  04c1 a30010        	cpw	x,#16
2592  04c4 2736          	jreq	L233
2593  04c6 a30008        	cpw	x,#8
2594  04c9 2731          	jreq	L233
2595  04cb a30004        	cpw	x,#4
2596  04ce 272c          	jreq	L233
2597  04d0 a30002        	cpw	x,#2
2598  04d3 2727          	jreq	L233
2599  04d5 a30001        	cpw	x,#1
2600  04d8 2722          	jreq	L233
2601  04da a30101        	cpw	x,#257
2602  04dd 271d          	jreq	L233
2603  04df a30301        	cpw	x,#769
2604  04e2 2718          	jreq	L233
2605  04e4 a30302        	cpw	x,#770
2606  04e7 2713          	jreq	L233
2607  04e9 a30210        	cpw	x,#528
2608  04ec 270e          	jreq	L233
2609  04ee ae025e        	ldw	x,#606
2610  04f1 89            	pushw	x
2611  04f2 5f            	clrw	x
2612  04f3 89            	pushw	x
2613  04f4 ae0008        	ldw	x,#L302
2614  04f7 cd0000        	call	_assert_failed
2616  04fa 5b04          	addw	sp,#4
2617  04fc               L233:
2618                     ; 609     if (UART2_FLAG == UART2_FLAG_LBDF)
2620  04fc 1e02          	ldw	x,(OFST+1,sp)
2621  04fe a30210        	cpw	x,#528
2622  0501 2609          	jrne	L7511
2623                     ; 611         if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2625  0503 c65247        	ld	a,21063
2626  0506 1503          	bcp	a,(OFST+2,sp)
2627  0508 2725          	jreq	L3021
2628                     ; 614             status = SET;
2630  050a 201f          	jp	LC010
2631                     ; 619             status = RESET;
2632  050c               L7511:
2633                     ; 622     else if (UART2_FLAG == UART2_FLAG_SBK)
2635  050c a30101        	cpw	x,#257
2636  050f 2609          	jrne	L7611
2637                     ; 624         if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2639  0511 c65245        	ld	a,21061
2640  0514 1503          	bcp	a,(OFST+2,sp)
2641  0516 2717          	jreq	L3021
2642                     ; 627             status = SET;
2644  0518 2011          	jp	LC010
2645                     ; 632             status = RESET;
2646  051a               L7611:
2647                     ; 635     else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2649  051a a30302        	cpw	x,#770
2650  051d 2705          	jreq	L1021
2652  051f a30301        	cpw	x,#769
2653  0522 260f          	jrne	L7711
2654  0524               L1021:
2655                     ; 637         if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2657  0524 c65249        	ld	a,21065
2658  0527 1503          	bcp	a,(OFST+2,sp)
2659  0529 2704          	jreq	L3021
2660                     ; 640             status = SET;
2662  052b               LC010:
2666  052b a601          	ld	a,#1
2668  052d 2001          	jra	L5611
2669  052f               L3021:
2670                     ; 645             status = RESET;
2675  052f 4f            	clr	a
2676  0530               L5611:
2677                     ; 663     return  status;
2681  0530 5b03          	addw	sp,#3
2682  0532 81            	ret	
2683  0533               L7711:
2684                     ; 650         if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2686  0533 c65240        	ld	a,21056
2687  0536 1503          	bcp	a,(OFST+2,sp)
2688  0538 27f5          	jreq	L3021
2689                     ; 653             status = SET;
2691  053a 20ef          	jp	LC010
2692                     ; 658             status = RESET;
2728                     ; 693 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2728                     ; 694 {
2729                     	switch	.text
2730  053c               _UART2_ClearFlag:
2732  053c 89            	pushw	x
2733       00000000      OFST:	set	0
2736                     ; 695     assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2738  053d a30020        	cpw	x,#32
2739  0540 271d          	jreq	L443
2740  0542 a30302        	cpw	x,#770
2741  0545 2718          	jreq	L443
2742  0547 a30301        	cpw	x,#769
2743  054a 2713          	jreq	L443
2744  054c a30210        	cpw	x,#528
2745  054f 270e          	jreq	L443
2746  0551 ae02b7        	ldw	x,#695
2747  0554 89            	pushw	x
2748  0555 5f            	clrw	x
2749  0556 89            	pushw	x
2750  0557 ae0008        	ldw	x,#L302
2751  055a cd0000        	call	_assert_failed
2753  055d 5b04          	addw	sp,#4
2754  055f               L443:
2755                     ; 698     if (UART2_FLAG == UART2_FLAG_RXNE)
2757  055f 1e01          	ldw	x,(OFST+1,sp)
2758  0561 a30020        	cpw	x,#32
2759  0564 2606          	jrne	L3321
2760                     ; 700         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2762  0566 35df5240      	mov	21056,#223
2764  056a 201a          	jra	L5321
2765  056c               L3321:
2766                     ; 703     else if (UART2_FLAG == UART2_FLAG_LBDF)
2768  056c a30210        	cpw	x,#528
2769  056f 2606          	jrne	L7321
2770                     ; 705         UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2772  0571 72195247      	bres	21063,#4
2774  0575 200f          	jra	L5321
2775  0577               L7321:
2776                     ; 708     else if (UART2_FLAG == UART2_FLAG_LHDF)
2778  0577 a30302        	cpw	x,#770
2779  057a 2606          	jrne	L3421
2780                     ; 710         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2782  057c 72135249      	bres	21065,#1
2784  0580 2004          	jra	L5321
2785  0582               L3421:
2786                     ; 715         UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2788  0582 72115249      	bres	21065,#0
2789  0586               L5321:
2790                     ; 717 }
2793  0586 85            	popw	x
2794  0587 81            	ret	
2877                     ; 732 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2877                     ; 733 {
2878                     	switch	.text
2879  0588               _UART2_GetITStatus:
2881  0588 89            	pushw	x
2882  0589 89            	pushw	x
2883       00000002      OFST:	set	2
2886                     ; 734     ITStatus pendingbitstatus = RESET;
2888                     ; 735     uint8_t itpos = 0;
2890                     ; 736     uint8_t itmask1 = 0;
2892                     ; 737     uint8_t itmask2 = 0;
2894                     ; 738     uint8_t enablestatus = 0;
2896                     ; 741     assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2898  058a a30277        	cpw	x,#631
2899  058d 2731          	jreq	L653
2900  058f a30266        	cpw	x,#614
2901  0592 272c          	jreq	L653
2902  0594 a30255        	cpw	x,#597
2903  0597 2727          	jreq	L653
2904  0599 a30244        	cpw	x,#580
2905  059c 2722          	jreq	L653
2906  059e a30235        	cpw	x,#565
2907  05a1 271d          	jreq	L653
2908  05a3 a30346        	cpw	x,#838
2909  05a6 2718          	jreq	L653
2910  05a8 a30412        	cpw	x,#1042
2911  05ab 2713          	jreq	L653
2912  05ad a30100        	cpw	x,#256
2913  05b0 270e          	jreq	L653
2914  05b2 ae02e5        	ldw	x,#741
2915  05b5 89            	pushw	x
2916  05b6 5f            	clrw	x
2917  05b7 89            	pushw	x
2918  05b8 ae0008        	ldw	x,#L302
2919  05bb cd0000        	call	_assert_failed
2921  05be 5b04          	addw	sp,#4
2922  05c0               L653:
2923                     ; 744     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
2925  05c0 7b04          	ld	a,(OFST+2,sp)
2926  05c2 a40f          	and	a,#15
2927  05c4 5f            	clrw	x
2928  05c5 97            	ld	xl,a
2929  05c6 a601          	ld	a,#1
2930  05c8 5d            	tnzw	x
2931  05c9 2704          	jreq	L263
2932  05cb               L463:
2933  05cb 48            	sll	a
2934  05cc 5a            	decw	x
2935  05cd 26fc          	jrne	L463
2936  05cf               L263:
2937  05cf 6b01          	ld	(OFST-1,sp),a
2938                     ; 746     itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
2940  05d1 7b04          	ld	a,(OFST+2,sp)
2941  05d3 4e            	swap	a
2942  05d4 a40f          	and	a,#15
2943  05d6 6b02          	ld	(OFST+0,sp),a
2944                     ; 748     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2946  05d8 5f            	clrw	x
2947  05d9 97            	ld	xl,a
2948  05da a601          	ld	a,#1
2949  05dc 5d            	tnzw	x
2950  05dd 2704          	jreq	L663
2951  05df               L073:
2952  05df 48            	sll	a
2953  05e0 5a            	decw	x
2954  05e1 26fc          	jrne	L073
2955  05e3               L663:
2956  05e3 6b02          	ld	(OFST+0,sp),a
2957                     ; 751     if (UART2_IT == UART2_IT_PE)
2959  05e5 1e03          	ldw	x,(OFST+1,sp)
2960  05e7 a30100        	cpw	x,#256
2961  05ea 260c          	jrne	L1131
2962                     ; 754         enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
2964  05ec c65244        	ld	a,21060
2965  05ef 1402          	and	a,(OFST+0,sp)
2966  05f1 6b02          	ld	(OFST+0,sp),a
2967                     ; 757         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2969  05f3 c65240        	ld	a,21056
2971                     ; 760             pendingbitstatus = SET;
2973  05f6 2020          	jp	LC013
2974                     ; 765             pendingbitstatus = RESET;
2975  05f8               L1131:
2976                     ; 768     else if (UART2_IT == UART2_IT_LBDF)
2978  05f8 a30346        	cpw	x,#838
2979  05fb 260c          	jrne	L1231
2980                     ; 771         enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
2982  05fd c65247        	ld	a,21063
2983  0600 1402          	and	a,(OFST+0,sp)
2984  0602 6b02          	ld	(OFST+0,sp),a
2985                     ; 773         if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2987  0604 c65247        	ld	a,21063
2989                     ; 776             pendingbitstatus = SET;
2991  0607 200f          	jp	LC013
2992                     ; 781             pendingbitstatus = RESET;
2993  0609               L1231:
2994                     ; 784     else if (UART2_IT == UART2_IT_LHDF)
2996  0609 a30412        	cpw	x,#1042
2997  060c 2616          	jrne	L1331
2998                     ; 787         enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
3000  060e c65249        	ld	a,21065
3001  0611 1402          	and	a,(OFST+0,sp)
3002  0613 6b02          	ld	(OFST+0,sp),a
3003                     ; 789         if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
3005  0615 c65249        	ld	a,21065
3007  0618               LC013:
3008  0618 1501          	bcp	a,(OFST-1,sp)
3009  061a 271a          	jreq	L1431
3010  061c 7b02          	ld	a,(OFST+0,sp)
3011  061e 2716          	jreq	L1431
3012                     ; 792             pendingbitstatus = SET;
3014  0620               LC012:
3018  0620 a601          	ld	a,#1
3020  0622 2013          	jra	L7131
3021                     ; 797             pendingbitstatus = RESET;
3022  0624               L1331:
3023                     ; 803         enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
3025  0624 c65245        	ld	a,21061
3026  0627 1402          	and	a,(OFST+0,sp)
3027  0629 6b02          	ld	(OFST+0,sp),a
3028                     ; 805         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
3030  062b c65240        	ld	a,21056
3031  062e 1501          	bcp	a,(OFST-1,sp)
3032  0630 2704          	jreq	L1431
3034  0632 7b02          	ld	a,(OFST+0,sp)
3035                     ; 808             pendingbitstatus = SET;
3037  0634 26ea          	jrne	LC012
3038  0636               L1431:
3039                     ; 813             pendingbitstatus = RESET;
3044  0636 4f            	clr	a
3045  0637               L7131:
3046                     ; 817     return  pendingbitstatus;
3050  0637 5b04          	addw	sp,#4
3051  0639 81            	ret	
3088                     ; 846 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
3088                     ; 847 {
3089                     	switch	.text
3090  063a               _UART2_ClearITPendingBit:
3092  063a 89            	pushw	x
3093       00000000      OFST:	set	0
3096                     ; 848     assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
3098  063b a30255        	cpw	x,#597
3099  063e 2718          	jreq	L004
3100  0640 a30412        	cpw	x,#1042
3101  0643 2713          	jreq	L004
3102  0645 a30346        	cpw	x,#838
3103  0648 270e          	jreq	L004
3104  064a ae0350        	ldw	x,#848
3105  064d 89            	pushw	x
3106  064e 5f            	clrw	x
3107  064f 89            	pushw	x
3108  0650 ae0008        	ldw	x,#L302
3109  0653 cd0000        	call	_assert_failed
3111  0656 5b04          	addw	sp,#4
3112  0658               L004:
3113                     ; 851     if (UART2_IT == UART2_IT_RXNE)
3115  0658 1e01          	ldw	x,(OFST+1,sp)
3116  065a a30255        	cpw	x,#597
3117  065d 2606          	jrne	L3631
3118                     ; 853         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
3120  065f 35df5240      	mov	21056,#223
3122  0663 200f          	jra	L5631
3123  0665               L3631:
3124                     ; 856     else if (UART2_IT == UART2_IT_LBDF)
3126  0665 a30346        	cpw	x,#838
3127  0668 2606          	jrne	L7631
3128                     ; 858         UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
3130  066a 72195247      	bres	21063,#4
3132  066e 2004          	jra	L5631
3133  0670               L7631:
3134                     ; 863         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
3136  0670 72135249      	bres	21065,#1
3137  0674               L5631:
3138                     ; 865 }
3141  0674 85            	popw	x
3142  0675 81            	ret	
3155                     	xdef	_UART2_ClearITPendingBit
3156                     	xdef	_UART2_GetITStatus
3157                     	xdef	_UART2_ClearFlag
3158                     	xdef	_UART2_GetFlagStatus
3159                     	xdef	_UART2_SetPrescaler
3160                     	xdef	_UART2_SetGuardTime
3161                     	xdef	_UART2_SetAddress
3162                     	xdef	_UART2_SendBreak
3163                     	xdef	_UART2_SendData9
3164                     	xdef	_UART2_SendData8
3165                     	xdef	_UART2_ReceiveData9
3166                     	xdef	_UART2_ReceiveData8
3167                     	xdef	_UART2_ReceiverWakeUpCmd
3168                     	xdef	_UART2_WakeUpConfig
3169                     	xdef	_UART2_SmartCardNACKCmd
3170                     	xdef	_UART2_SmartCardCmd
3171                     	xdef	_UART2_LINCmd
3172                     	xdef	_UART2_LINConfig
3173                     	xdef	_UART2_LINBreakDetectionConfig
3174                     	xdef	_UART2_IrDACmd
3175                     	xdef	_UART2_IrDAConfig
3176                     	xdef	_UART2_ITConfig
3177                     	xdef	_UART2_Cmd
3178                     	xdef	_UART2_Init
3179                     	xdef	_UART2_DeInit
3180                     	xref	_assert_failed
3181                     	xref	_CLK_GetClockFreq
3182                     	switch	.const
3183  0008               L302:
3184  0008 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
3185  001a 6965735c7374  	dc.b	"ies\stm8s_stdperip"
3186  002c 685f64726976  	dc.b	"h_driver\src\stm8s"
3187  003e 5f7561727432  	dc.b	"_uart2.c",0
3188                     	xref.b	c_lreg
3189                     	xref.b	c_x
3209                     	xref	c_lursh
3210                     	xref	c_lsub
3211                     	xref	c_smul
3212                     	xref	c_ludv
3213                     	xref	c_rtol
3214                     	xref	c_llsh
3215                     	xref	c_lcmp
3216                     	xref	c_ltor
3217                     	end
