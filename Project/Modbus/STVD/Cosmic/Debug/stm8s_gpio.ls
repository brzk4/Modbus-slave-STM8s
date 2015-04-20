   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
 113                     ; 47 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
 113                     ; 48 {
 115                     	switch	.text
 116  0000               _GPIO_DeInit:
 120                     ; 49     GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 122  0000 7f            	clr	(x)
 123                     ; 50     GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 125  0001 6f02          	clr	(2,x)
 126                     ; 51     GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 128  0003 6f03          	clr	(3,x)
 129                     ; 52     GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 131  0005 6f04          	clr	(4,x)
 132                     ; 53 }
 135  0007 81            	ret	
 376                     ; 65 void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, GPIO_Mode_TypeDef GPIO_Mode)
 376                     ; 66 {
 377                     	switch	.text
 378  0008               _GPIO_Init:
 380  0008 89            	pushw	x
 381       00000000      OFST:	set	0
 384                     ; 71     assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 386  0009 7b06          	ld	a,(OFST+6,sp)
 387  000b 2731          	jreq	L41
 388  000d a140          	cp	a,#64
 389  000f 272d          	jreq	L41
 390  0011 a120          	cp	a,#32
 391  0013 2729          	jreq	L41
 392  0015 a160          	cp	a,#96
 393  0017 2725          	jreq	L41
 394  0019 a1a0          	cp	a,#160
 395  001b 2721          	jreq	L41
 396  001d a1e0          	cp	a,#224
 397  001f 271d          	jreq	L41
 398  0021 a180          	cp	a,#128
 399  0023 2719          	jreq	L41
 400  0025 a1c0          	cp	a,#192
 401  0027 2715          	jreq	L41
 402  0029 a1b0          	cp	a,#176
 403  002b 2711          	jreq	L41
 404  002d a1f0          	cp	a,#240
 405  002f 270d          	jreq	L41
 406  0031 a190          	cp	a,#144
 407  0033 2709          	jreq	L41
 408  0035 a1d0          	cp	a,#208
 409  0037 2705          	jreq	L41
 410  0039 ae0047        	ldw	x,#71
 411  003c ad5d          	call	LC001
 412  003e               L41:
 413                     ; 72     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 415  003e 7b05          	ld	a,(OFST+5,sp)
 416  0040 2607          	jrne	L22
 417  0042 ae0048        	ldw	x,#72
 418  0045 ad54          	call	LC001
 419  0047 7b05          	ld	a,(OFST+5,sp)
 420  0049               L22:
 421                     ; 75   GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 423  0049 1e01          	ldw	x,(OFST+1,sp)
 424  004b 43            	cpl	a
 425  004c e404          	and	a,(4,x)
 426  004e e704          	ld	(4,x),a
 427                     ; 81     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x80) != (uint8_t)0x00) /* Output mode */
 429  0050 7b06          	ld	a,(OFST+6,sp)
 430  0052 2a14          	jrpl	L102
 431                     ; 83         if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x10) != (uint8_t)0x00) /* High level */
 433  0054 a510          	bcp	a,#16
 434  0056 2705          	jreq	L302
 435                     ; 85             GPIOx->ODR |= (uint8_t)GPIO_Pin;
 437  0058 f6            	ld	a,(x)
 438  0059 1a05          	or	a,(OFST+5,sp)
 440  005b 2004          	jra	L502
 441  005d               L302:
 442                     ; 89             GPIOx->ODR &= (uint8_t)(~(GPIO_Pin));
 444  005d 7b05          	ld	a,(OFST+5,sp)
 445  005f 43            	cpl	a
 446  0060 f4            	and	a,(x)
 447  0061               L502:
 448  0061 f7            	ld	(x),a
 449                     ; 92         GPIOx->DDR |= (uint8_t)GPIO_Pin;
 451  0062 e602          	ld	a,(2,x)
 452  0064 1a05          	or	a,(OFST+5,sp)
 454  0066 2005          	jra	L702
 455  0068               L102:
 456                     ; 97         GPIOx->DDR &= (uint8_t)(~(GPIO_Pin));
 458  0068 7b05          	ld	a,(OFST+5,sp)
 459  006a 43            	cpl	a
 460  006b e402          	and	a,(2,x)
 461  006d               L702:
 462  006d e702          	ld	(2,x),a
 463                     ; 104     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x40) != (uint8_t)0x00) /* Pull-Up or Push-Pull */
 465  006f 7b06          	ld	a,(OFST+6,sp)
 466  0071 a540          	bcp	a,#64
 467  0073 2706          	jreq	L112
 468                     ; 106         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
 470  0075 e603          	ld	a,(3,x)
 471  0077 1a05          	or	a,(OFST+5,sp)
 473  0079 2005          	jra	L312
 474  007b               L112:
 475                     ; 110         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
 477  007b 7b05          	ld	a,(OFST+5,sp)
 478  007d 43            	cpl	a
 479  007e e403          	and	a,(3,x)
 480  0080               L312:
 481  0080 e703          	ld	(3,x),a
 482                     ; 117     if ((((uint8_t)(GPIO_Mode)) & (uint8_t)0x20) != (uint8_t)0x00) /* Interrupt or Slow slope */
 484  0082 7b06          	ld	a,(OFST+6,sp)
 485  0084 a520          	bcp	a,#32
 486  0086 2708          	jreq	L512
 487                     ; 119         GPIOx->CR2 |= (uint8_t)GPIO_Pin;
 489  0088 1e01          	ldw	x,(OFST+1,sp)
 490  008a e604          	ld	a,(4,x)
 491  008c 1a05          	or	a,(OFST+5,sp)
 493  008e 2007          	jra	L712
 494  0090               L512:
 495                     ; 123         GPIOx->CR2 &= (uint8_t)(~(GPIO_Pin));
 497  0090 1e01          	ldw	x,(OFST+1,sp)
 498  0092 7b05          	ld	a,(OFST+5,sp)
 499  0094 43            	cpl	a
 500  0095 e404          	and	a,(4,x)
 501  0097               L712:
 502  0097 e704          	ld	(4,x),a
 503                     ; 125 }
 506  0099 85            	popw	x
 507  009a 81            	ret	
 508  009b               LC001:
 509  009b 89            	pushw	x
 510  009c 5f            	clrw	x
 511  009d 89            	pushw	x
 512  009e ae0000        	ldw	x,#L771
 513  00a1 cd0000        	call	_assert_failed
 515  00a4 5b04          	addw	sp,#4
 516  00a6 81            	ret	
 562                     ; 135 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
 562                     ; 136 {
 563                     	switch	.text
 564  00a7               _GPIO_Write:
 566  00a7 89            	pushw	x
 567       00000000      OFST:	set	0
 570                     ; 137     GPIOx->ODR = PortVal;
 572  00a8 7b05          	ld	a,(OFST+5,sp)
 573  00aa 1e01          	ldw	x,(OFST+1,sp)
 574  00ac f7            	ld	(x),a
 575                     ; 138 }
 578  00ad 85            	popw	x
 579  00ae 81            	ret	
 626                     ; 148 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 626                     ; 149 {
 627                     	switch	.text
 628  00af               _GPIO_WriteHigh:
 630  00af 89            	pushw	x
 631       00000000      OFST:	set	0
 634                     ; 150     GPIOx->ODR |= (uint8_t)PortPins;
 636  00b0 f6            	ld	a,(x)
 637  00b1 1a05          	or	a,(OFST+5,sp)
 638  00b3 f7            	ld	(x),a
 639                     ; 151 }
 642  00b4 85            	popw	x
 643  00b5 81            	ret	
 690                     ; 161 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 690                     ; 162 {
 691                     	switch	.text
 692  00b6               _GPIO_WriteLow:
 694  00b6 89            	pushw	x
 695       00000000      OFST:	set	0
 698                     ; 163     GPIOx->ODR &= (uint8_t)(~PortPins);
 700  00b7 7b05          	ld	a,(OFST+5,sp)
 701  00b9 43            	cpl	a
 702  00ba f4            	and	a,(x)
 703  00bb f7            	ld	(x),a
 704                     ; 164 }
 707  00bc 85            	popw	x
 708  00bd 81            	ret	
 755                     ; 174 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 755                     ; 175 {
 756                     	switch	.text
 757  00be               _GPIO_WriteReverse:
 759  00be 89            	pushw	x
 760       00000000      OFST:	set	0
 763                     ; 176     GPIOx->ODR ^= (uint8_t)PortPins;
 765  00bf f6            	ld	a,(x)
 766  00c0 1805          	xor	a,(OFST+5,sp)
 767  00c2 f7            	ld	(x),a
 768                     ; 177 }
 771  00c3 85            	popw	x
 772  00c4 81            	ret	
 810                     ; 185 uint8_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 810                     ; 186 {
 811                     	switch	.text
 812  00c5               _GPIO_ReadOutputData:
 816                     ; 187     return ((uint8_t)GPIOx->ODR);
 818  00c5 f6            	ld	a,(x)
 821  00c6 81            	ret	
 858                     ; 196 uint8_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 858                     ; 197 {
 859                     	switch	.text
 860  00c7               _GPIO_ReadInputData:
 864                     ; 198     return ((uint8_t)GPIOx->IDR);
 866  00c7 e601          	ld	a,(1,x)
 869  00c9 81            	ret	
 937                     ; 207 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 937                     ; 208 {
 938                     	switch	.text
 939  00ca               _GPIO_ReadInputPin:
 941  00ca 89            	pushw	x
 942       00000000      OFST:	set	0
 945                     ; 209     return ((BitStatus)(GPIOx->IDR & (uint8_t)GPIO_Pin));
 947  00cb e601          	ld	a,(1,x)
 948  00cd 1405          	and	a,(OFST+5,sp)
 951  00cf 85            	popw	x
 952  00d0 81            	ret	
1031                     ; 219 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
1031                     ; 220 {
1032                     	switch	.text
1033  00d1               _GPIO_ExternalPullUpConfig:
1035  00d1 89            	pushw	x
1036       00000000      OFST:	set	0
1039                     ; 222     assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
1041  00d2 7b05          	ld	a,(OFST+5,sp)
1042  00d4 2605          	jrne	L05
1043  00d6 ae00de        	ldw	x,#222
1044  00d9 ad23          	call	LC002
1045  00db               L05:
1046                     ; 223     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1048  00db 7b06          	ld	a,(OFST+6,sp)
1049  00dd 2708          	jreq	L06
1050  00df 4a            	dec	a
1051  00e0 2705          	jreq	L06
1052  00e2 ae00df        	ldw	x,#223
1053  00e5 ad17          	call	LC002
1054  00e7               L06:
1055                     ; 225     if (NewState != DISABLE) /* External Pull-Up Set*/
1057  00e7 7b06          	ld	a,(OFST+6,sp)
1058  00e9 2708          	jreq	L574
1059                     ; 227         GPIOx->CR1 |= (uint8_t)GPIO_Pin;
1061  00eb 1e01          	ldw	x,(OFST+1,sp)
1062  00ed e603          	ld	a,(3,x)
1063  00ef 1a05          	or	a,(OFST+5,sp)
1065  00f1 2007          	jra	L774
1066  00f3               L574:
1067                     ; 230         GPIOx->CR1 &= (uint8_t)(~(GPIO_Pin));
1069  00f3 1e01          	ldw	x,(OFST+1,sp)
1070  00f5 7b05          	ld	a,(OFST+5,sp)
1071  00f7 43            	cpl	a
1072  00f8 e403          	and	a,(3,x)
1073  00fa               L774:
1074  00fa e703          	ld	(3,x),a
1075                     ; 232 }
1078  00fc 85            	popw	x
1079  00fd 81            	ret	
1080  00fe               LC002:
1081  00fe 89            	pushw	x
1082  00ff 5f            	clrw	x
1083  0100 89            	pushw	x
1084  0101 ae0000        	ldw	x,#L771
1085  0104 cd0000        	call	_assert_failed
1087  0107 5b04          	addw	sp,#4
1088  0109 81            	ret	
1101                     	xdef	_GPIO_ExternalPullUpConfig
1102                     	xdef	_GPIO_ReadInputPin
1103                     	xdef	_GPIO_ReadOutputData
1104                     	xdef	_GPIO_ReadInputData
1105                     	xdef	_GPIO_WriteReverse
1106                     	xdef	_GPIO_WriteLow
1107                     	xdef	_GPIO_WriteHigh
1108                     	xdef	_GPIO_Write
1109                     	xdef	_GPIO_Init
1110                     	xdef	_GPIO_DeInit
1111                     	xref	_assert_failed
1112                     .const:	section	.text
1113  0000               L771:
1114  0000 2e2e5c2e2e5c  	dc.b	"..\..\..\..\librar"
1115  0012 6965735c7374  	dc.b	"ies\stm8s_stdperip"
1116  0024 685f64726976  	dc.b	"h_driver\src\stm8s"
1117  0036 5f6770696f2e  	dc.b	"_gpio.c",0
1137                     	end
