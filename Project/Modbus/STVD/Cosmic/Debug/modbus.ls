   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  62                     ; 5 void UART_SendStr(const char *s)
  62                     ; 6 {
  64                     	switch	.text
  65  0000               _UART_SendStr:
  67  0000 89            	pushw	x
  68       00000000      OFST:	set	0
  71                     ; 8 	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
  73  0001 4b08          	push	#8
  74  0003 ae5000        	ldw	x,#20480
  75  0006 cd0000        	call	_GPIO_WriteHigh
  77  0009 84            	pop	a
  79  000a 1e01          	ldw	x,(OFST+1,sp)
  80  000c 200d          	jra	L13
  81  000e               L72:
  82                     ; 11 	UART2_SendData8((uint8_t)(*s));
  84  000e cd0000        	call	_UART2_SendData8
  87  0011               L73:
  88                     ; 12 	while ((UART2->SR & UART2_SR_TXE ) != UART2_SR_TXE );
  90  0011 720f5240fb    	btjf	21056,#7,L73
  91                     ; 13 	s++;
  93  0016 1e01          	ldw	x,(OFST+1,sp)
  94  0018 5c            	incw	x
  95  0019 1f01          	ldw	(OFST+1,sp),x
  96  001b               L13:
  97                     ; 9 	while(*s)
  99  001b f6            	ld	a,(x)
 100  001c 26f0          	jrne	L72
 101                     ; 16 	GPIO_WriteLow(GPIOA, GPIO_PIN_3);
 103  001e 4b08          	push	#8
 104  0020 ae5000        	ldw	x,#20480
 105  0023 cd0000        	call	_GPIO_WriteLow
 107  0026 84            	pop	a
 108                     ; 17 }
 111  0027 85            	popw	x
 112  0028 81            	ret	
 147                     ; 20 void Modbus_Init(void)
 147                     ; 21 {
 148                     	switch	.text
 149  0029               _Modbus_Init:
 153                     ; 23 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 155  0029 4f            	clr	a
 156  002a cd0000        	call	_CLK_HSIPrescalerConfig
 158                     ; 25 	TIM2_DeInit();
 160  002d cd0000        	call	_TIM2_DeInit
 162                     ; 26 	GPIO_DeInit(GPIOA);
 164  0030 ae5000        	ldw	x,#20480
 165  0033 cd0000        	call	_GPIO_DeInit
 167                     ; 27 	UART2_DeInit();
 169  0036 cd0000        	call	_UART2_DeInit
 171                     ; 29 	TIM2_TimeBaseInit(TIM2_PRESCALER_2048, 78);
 173  0039 ae004e        	ldw	x,#78
 174  003c 89            	pushw	x
 175  003d a60b          	ld	a,#11
 176  003f cd0000        	call	_TIM2_TimeBaseInit
 178  0042 85            	popw	x
 179                     ; 30 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
 181  0043 4be0          	push	#224
 182  0045 4b08          	push	#8
 183  0047 ae5000        	ldw	x,#20480
 184  004a cd0000        	call	_GPIO_Init
 186  004d 85            	popw	x
 187                     ; 31 	UART2_Init(BAUDRATE, UART2_WORDLENGTH_8D, UART2_STOPBITS_2,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,UART2_MODE_TXRX_ENABLE );  
 189  004e 4b0c          	push	#12
 190  0050 4b80          	push	#128
 191  0052 4b00          	push	#0
 192  0054 4b20          	push	#32
 193  0056 4b00          	push	#0
 194  0058 ae4b00        	ldw	x,#19200
 195  005b 89            	pushw	x
 196  005c 5f            	clrw	x
 197  005d 89            	pushw	x
 198  005e cd0000        	call	_UART2_Init
 200  0061 5b09          	addw	sp,#9
 201                     ; 33 	TIM2_Cmd(ENABLE);
 203  0063 a601          	ld	a,#1
 204  0065 cd0000        	call	_TIM2_Cmd
 206                     ; 34 	UART2_Cmd(ENABLE);
 208  0068 a601          	ld	a,#1
 209  006a cd0000        	call	_UART2_Cmd
 211                     ; 36 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 213  006d ae0101        	ldw	x,#257
 214  0070 cd0000        	call	_TIM2_ITConfig
 216                     ; 37 	UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
 218  0073 4b01          	push	#1
 219  0075 ae0205        	ldw	x,#517
 220  0078 cd0000        	call	_UART2_ITConfig
 222  007b 9a            	rim	
 223  007c 84            	pop	a
 224                     ; 40 	enableInterrupts();
 228                     ; 42 }
 232  007d 81            	ret	
 259                     ; 45 void Delay_Init(void)
 259                     ; 46 {
 260                     	switch	.text
 261  007e               _Delay_Init:
 265                     ; 48 	TIM3_DeInit();
 267  007e cd0000        	call	_TIM3_DeInit
 269                     ; 50 	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
 271  0081 ae03e7        	ldw	x,#999
 272  0084 89            	pushw	x
 273  0085 a604          	ld	a,#4
 274  0087 cd0000        	call	_TIM3_TimeBaseInit
 276  008a a601          	ld	a,#1
 277  008c 85            	popw	x
 278                     ; 52 	TIM3_Cmd(ENABLE);
 280  008d cd0000        	call	_TIM3_Cmd
 282                     ; 54 	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
 284  0090 ae0101        	ldw	x,#257
 286                     ; 59 }
 289  0093 cc0000        	jp	_TIM3_ITConfig
 324                     ; 62 void Delay(uint32_t time)
 324                     ; 63 {
 325                     	switch	.text
 326  0096               _Delay:
 328       00000000      OFST:	set	0
 331                     ; 64 	TimmingDelay = time;
 333  0096 1e05          	ldw	x,(OFST+5,sp)
 334  0098 bf02          	ldw	_TimmingDelay+2,x
 335  009a 1e03          	ldw	x,(OFST+3,sp)
 336  009c bf00          	ldw	_TimmingDelay,x
 338  009e ae0000        	ldw	x,#_TimmingDelay
 339  00a1               L501:
 340                     ; 65 	while(TimmingDelay != 0 );
 342  00a1 cd0000        	call	c_lzmp
 344  00a4 26fb          	jrne	L501
 345                     ; 66 }
 348  00a6 81            	ret	
 428                     ; 69 void ByteToHex(char *hexstring, uint8_t byte)
 428                     ; 70 {
 429                     	switch	.text
 430  00a7               _ByteToHex:
 432  00a7 89            	pushw	x
 433  00a8 5203          	subw	sp,#3
 434       00000003      OFST:	set	3
 437                     ; 73 	uint8_t fchar = (byte & 0b11110000) >> 4 ;
 439  00aa 7b08          	ld	a,(OFST+5,sp)
 440  00ac 4e            	swap	a
 441  00ad a40f          	and	a,#15
 442  00af 6b03          	ld	(OFST+0,sp),a
 443                     ; 74 	uint8_t lchar = (byte & 0b00001111) ; 
 445  00b1 7b08          	ld	a,(OFST+5,sp)
 446  00b3 a40f          	and	a,#15
 447  00b5 6b02          	ld	(OFST-1,sp),a
 448                     ; 76 	if( fchar >= 0 && fchar <= 9 )
 450  00b7 7b03          	ld	a,(OFST+0,sp)
 451  00b9 a10a          	cp	a,#10
 452  00bb 2404          	jruge	L351
 453                     ; 78 		fhex = (char)(fchar+48);
 455  00bd ab30          	add	a,#48
 457  00bf 2002          	jra	L551
 458  00c1               L351:
 459                     ; 82 		fhex = (char)(fchar+55);
 461  00c1 ab37          	add	a,#55
 462  00c3               L551:
 463  00c3 6b01          	ld	(OFST-2,sp),a
 464                     ; 84 		if( lchar >= 0 && lchar <= 9 )
 466  00c5 7b02          	ld	a,(OFST-1,sp)
 467  00c7 a10a          	cp	a,#10
 468  00c9 2404          	jruge	L751
 469                     ; 86 		lhex = (char)(lchar+48);
 471  00cb ab30          	add	a,#48
 473  00cd 2002          	jra	L161
 474  00cf               L751:
 475                     ; 90 		lhex = (char)(lchar+55);
 477  00cf ab37          	add	a,#55
 478  00d1               L161:
 479  00d1 6b03          	ld	(OFST+0,sp),a
 480                     ; 92 	hexstring[0] = fhex;
 482  00d3 1e04          	ldw	x,(OFST+1,sp)
 483  00d5 7b01          	ld	a,(OFST-2,sp)
 484  00d7 f7            	ld	(x),a
 485                     ; 93 	hexstring[1] = lhex;
 487  00d8 7b03          	ld	a,(OFST+0,sp)
 488  00da e701          	ld	(1,x),a
 489                     ; 94 }
 492  00dc 5b05          	addw	sp,#5
 493  00de 81            	ret	
 583                     ; 96 void HexToByte(char *hexstring, uint8_t *byte)
 583                     ; 97 {
 584                     	switch	.text
 585  00df               _HexToByte:
 587  00df 89            	pushw	x
 588  00e0 5205          	subw	sp,#5
 589       00000005      OFST:	set	5
 592                     ; 103 	fhex	= hexstring[0];
 594  00e2 f6            	ld	a,(x)
 595  00e3 6b05          	ld	(OFST+0,sp),a
 596                     ; 104 	lhex = hexstring[1];
 598  00e5 e601          	ld	a,(1,x)
 599  00e7 6b04          	ld	(OFST-1,sp),a
 600                     ; 105 	if( ((int)fhex) >= 48 && ((int)fhex) <= 57 )
 602  00e9 5f            	clrw	x
 603  00ea 7b05          	ld	a,(OFST+0,sp)
 604  00ec 97            	ld	xl,a
 605  00ed a30030        	cpw	x,#48
 606  00f0 2f0b          	jrslt	L132
 608  00f2 5f            	clrw	x
 609  00f3 97            	ld	xl,a
 610  00f4 a3003a        	cpw	x,#58
 611  00f7 2e04          	jrsge	L132
 612                     ; 107 		fchar = ((int)fhex) - 48; 
 614  00f9 a030          	sub	a,#48
 616  00fb 2002          	jra	L332
 617  00fd               L132:
 618                     ; 111 		fchar = ((int)fhex) - 55;
 620  00fd a037          	sub	a,#55
 621  00ff               L332:
 622  00ff 6b03          	ld	(OFST-2,sp),a
 623                     ; 113 		if( ((int)lhex) >= 48 && ((int)lhex) <= 57 )
 625  0101 5f            	clrw	x
 626  0102 7b04          	ld	a,(OFST-1,sp)
 627  0104 97            	ld	xl,a
 628  0105 a30030        	cpw	x,#48
 629  0108 2f0b          	jrslt	L532
 631  010a 5f            	clrw	x
 632  010b 97            	ld	xl,a
 633  010c a3003a        	cpw	x,#58
 634  010f 2e04          	jrsge	L532
 635                     ; 115 		lchar = ((int)lhex) - 48; 
 637  0111 a030          	sub	a,#48
 639  0113 2002          	jra	L732
 640  0115               L532:
 641                     ; 119 		lchar = ((int)lhex) - 55;
 643  0115 a037          	sub	a,#55
 644  0117               L732:
 645  0117 6b05          	ld	(OFST+0,sp),a
 646                     ; 121 	tmpb = ((fchar<<4) | lchar);
 648  0119 7b03          	ld	a,(OFST-2,sp)
 649  011b 97            	ld	xl,a
 650  011c a610          	ld	a,#16
 651  011e 42            	mul	x,a
 652  011f 01            	rrwa	x,a
 653  0120 1a05          	or	a,(OFST+0,sp)
 654  0122 02            	rlwa	x,a
 655  0123 1f01          	ldw	(OFST-4,sp),x
 656                     ; 122 	*byte =  (uint8_t)tmpb; 
 658  0125 1e0a          	ldw	x,(OFST+5,sp)
 659  0127 7b02          	ld	a,(OFST-3,sp)
 660  0129 f7            	ld	(x),a
 661                     ; 124 }
 664  012a 5b07          	addw	sp,#7
 665  012c 81            	ret	
 699                     ; 127 uint8_t __checkAddr(uint8_t address)
 699                     ; 128 {
 700                     	switch	.text
 701  012d               ___checkAddr:
 705                     ; 131 		return 1;
 707  012d a601          	ld	a,#1
 710  012f 81            	ret	
 746                     ; 140 void SetDevAddr(uint8_t Addr)
 746                     ; 141 {
 747                     	switch	.text
 748  0130               _SetDevAddr:
 750  0130 88            	push	a
 751       00000000      OFST:	set	0
 754                     ; 142 	if(__checkAddr(Addr))
 756  0131 adfa          	call	___checkAddr
 758  0133 4d            	tnz	a
 759  0134 2704          	jreq	L572
 760                     ; 144 	Address = Addr;
 762  0136 7b01          	ld	a,(OFST+1,sp)
 763  0138 b700          	ld	_Address,a
 764  013a               L572:
 765                     ; 146 }
 768  013a 84            	pop	a
 769  013b 81            	ret	
 823                     ; 148 void RewritingChars(char *destination, uint8_t from, uint8_t to)
 823                     ; 149 {
 824                     	switch	.text
 825  013c               _RewritingChars:
 827  013c 89            	pushw	x
 828       00000000      OFST:	set	0
 831                     ; 150 for(from; from<=to; ++from)
 834  013d 2017          	jra	L133
 835  013f               L523:
 836                     ; 152 	destination[from] = word[from];	
 838  013f 7b01          	ld	a,(OFST+1,sp)
 839  0141 97            	ld	xl,a
 840  0142 7b02          	ld	a,(OFST+2,sp)
 841  0144 1b05          	add	a,(OFST+5,sp)
 842  0146 2401          	jrnc	L47
 843  0148 5c            	incw	x
 844  0149               L47:
 845  0149 02            	rlwa	x,a
 846  014a 7b05          	ld	a,(OFST+5,sp)
 847  014c 905f          	clrw	y
 848  014e 9097          	ld	yl,a
 849  0150 90e600        	ld	a,(_word,y)
 850  0153 f7            	ld	(x),a
 851                     ; 150 for(from; from<=to; ++from)
 853  0154 0c05          	inc	(OFST+5,sp)
 854  0156               L133:
 857  0156 7b05          	ld	a,(OFST+5,sp)
 858  0158 1106          	cp	a,(OFST+6,sp)
 859  015a 23e3          	jrule	L523
 860                     ; 155 }
 863  015c 85            	popw	x
 864  015d 81            	ret	
 920                     ; 159 void SetSingleCoil(uint16_t *Coil, uint16_t *StatusToWrite, uint16_t *registers)
 920                     ; 160 { 
 921                     	switch	.text
 922  015e               _SetSingleCoil:
 924  015e 89            	pushw	x
 925       00000000      OFST:	set	0
 928                     ; 163 if(*StatusToWrite == 0xFF00)
 930  015f 1605          	ldw	y,(OFST+5,sp)
 931  0161 90fe          	ldw	y,(y)
 932  0163 90a3ff00      	cpw	y,#65280
 933  0167 262a          	jrne	L363
 934                     ; 165 		registers[*Coil/16 ] |= (1<<(*Coil%16));		
 936  0169 1e01          	ldw	x,(OFST+1,sp)
 937  016b fe            	ldw	x,(x)
 938  016c 54            	srlw	x
 939  016d 54            	srlw	x
 940  016e 54            	srlw	x
 941  016f 54            	srlw	x
 942  0170 58            	sllw	x
 943  0171 1601          	ldw	y,(OFST+1,sp)
 944  0173 72fb07        	addw	x,(OFST+7,sp)
 945  0176 90e601        	ld	a,(1,y)
 946  0179 a40f          	and	a,#15
 947  017b 90ae0001      	ldw	y,#1
 948  017f 4d            	tnz	a
 949  0180 2705          	jreq	L001
 950  0182               L201:
 951  0182 9058          	sllw	y
 952  0184 4a            	dec	a
 953  0185 26fb          	jrne	L201
 954  0187               L001:
 955  0187 9001          	rrwa	y,a
 956  0189 ea01          	or	a,(1,x)
 957  018b 9001          	rrwa	y,a
 958  018d fa            	or	a,(x)
 959  018e 9001          	rrwa	y,a
 960  0190 ff            	ldw	(x),y
 962  0191 2040          	jra	L563
 963  0193               L363:
 964                     ; 169 else if(*StatusToWrite == 0x0000)
 966  0193 1e05          	ldw	x,(OFST+5,sp)
 967  0195 e601          	ld	a,(1,x)
 968  0197 fa            	or	a,(x)
 969  0198 2634          	jrne	L763
 970                     ; 171 		registers[*Coil/16 ] &= (!(1<<(*Coil%16)));
 972  019a 1601          	ldw	y,(OFST+1,sp)
 973  019c ae0001        	ldw	x,#1
 974  019f 90e601        	ld	a,(1,y)
 975  01a2 a40f          	and	a,#15
 976  01a4 2704          	jreq	L601
 977  01a6               L011:
 978  01a6 58            	sllw	x
 979  01a7 4a            	dec	a
 980  01a8 26fc          	jrne	L011
 981  01aa               L601:
 982  01aa a30000        	cpw	x,#0
 983  01ad 2603          	jrne	L401
 984  01af 5c            	incw	x
 985  01b0 2001          	jra	L211
 986  01b2               L401:
 987  01b2 5f            	clrw	x
 988  01b3               L211:
 989  01b3 90fe          	ldw	y,(y)
 990  01b5 9054          	srlw	y
 991  01b7 9054          	srlw	y
 992  01b9 9054          	srlw	y
 993  01bb 9054          	srlw	y
 994  01bd 9058          	sllw	y
 995  01bf 72f907        	addw	y,(OFST+7,sp)
 996  01c2 01            	rrwa	x,a
 997  01c3 90e401        	and	a,(1,y)
 998  01c6 01            	rrwa	x,a
 999  01c7 90f4          	and	a,(y)
1000  01c9 01            	rrwa	x,a
1001  01ca 90ff          	ldw	(y),x
1003  01cc 2005          	jra	L563
1004  01ce               L763:
1005                     ; 175 		ErrorMessage(ILLEGAL_DATA_VAL);
1007  01ce a603          	ld	a,#3
1008  01d0 cd098c        	call	_ErrorMessage
1010  01d3               L563:
1011                     ; 177 }
1014  01d3 85            	popw	x
1015  01d4 81            	ret	
1098                     ; 180 bool StateOfCoil(uint8_t NumberOfCoil, uint16_t registers[])
1098                     ; 181 {
1099                     	switch	.text
1100  01d5               _StateOfCoil:
1102  01d5 88            	push	a
1103  01d6 5204          	subw	sp,#4
1104       00000004      OFST:	set	4
1107                     ; 183 	uint16_t Value = registers[NumberOfCoil/16];   
1109  01d8 5f            	clrw	x
1110  01d9 97            	ld	xl,a
1111  01da 57            	sraw	x
1112  01db 57            	sraw	x
1113  01dc 57            	sraw	x
1114  01dd 57            	sraw	x
1115  01de 58            	sllw	x
1116  01df 72fb08        	addw	x,(OFST+4,sp)
1117  01e2 fe            	ldw	x,(x)
1118  01e3 1f01          	ldw	(OFST-3,sp),x
1119                     ; 186 	uint16_t Compare = 1<<(NumberOfCoil%16);			
1121  01e5 ae0001        	ldw	x,#1
1122  01e8 a40f          	and	a,#15
1123  01ea 2704          	jreq	L021
1124  01ec               L221:
1125  01ec 58            	sllw	x
1126  01ed 4a            	dec	a
1127  01ee 26fc          	jrne	L221
1128  01f0               L021:
1129  01f0 1f03          	ldw	(OFST-1,sp),x
1130                     ; 188 	if ((Value & Compare) == Compare )
1132  01f2 1e01          	ldw	x,(OFST-3,sp)
1133  01f4 01            	rrwa	x,a
1134  01f5 1404          	and	a,(OFST+0,sp)
1135  01f7 01            	rrwa	x,a
1136  01f8 1403          	and	a,(OFST-1,sp)
1137  01fa 01            	rrwa	x,a
1138  01fb 1303          	cpw	x,(OFST-1,sp)
1139  01fd 2604          	jrne	L534
1140                     ; 190 				return 1;
1142  01ff a601          	ld	a,#1
1144  0201 2001          	jra	L421
1145  0203               L534:
1146                     ; 195 				return 0;
1148  0203 4f            	clr	a
1150  0204               L421:
1152  0204 5b05          	addw	sp,#5
1153  0206 81            	ret	
1238                     ; 201 bool CheckLRC(char *frame)
1238                     ; 202 {
1239                     	switch	.text
1240  0207               _CheckLRC:
1242  0207 89            	pushw	x
1243  0208 5207          	subw	sp,#7
1244       00000007      OFST:	set	7
1247                     ; 203 	uint8_t a = 0;
1249  020a 0f07          	clr	(OFST+0,sp)
1250                     ; 206 	uint8_t tempSum = 0;
1252  020c 0f01          	clr	(OFST-6,sp)
1253                     ; 208 	uint8_t LRC_calculated = 0;
1255                     ; 210 	uint8_t LRC_dec_from_frame = 0;	
1257  020e 0f02          	clr	(OFST-5,sp)
1259  0210 2002          	jra	L705
1260  0212               L305:
1261                     ; 215 				a++;
1263  0212 0c07          	inc	(OFST+0,sp)
1264  0214               L705:
1265                     ; 213 	while(word[a] != '\r')
1267  0214 7b07          	ld	a,(OFST+0,sp)
1268  0216 5f            	clrw	x
1269  0217 97            	ld	xl,a
1270  0218 e600          	ld	a,(_word,x)
1271  021a a10d          	cp	a,#13
1272  021c 26f4          	jrne	L305
1273                     ; 218 temp[1] = frame[a-1];
1275  021e 7b07          	ld	a,(OFST+0,sp)
1276  0220 5f            	clrw	x
1277  0221 97            	ld	xl,a
1278  0222 5a            	decw	x
1279  0223 72fb08        	addw	x,(OFST+1,sp)
1280  0226 f6            	ld	a,(x)
1281  0227 6b04          	ld	(OFST-3,sp),a
1282                     ; 219 temp[0] = frame[a-2];
1284  0229 5f            	clrw	x
1285  022a 7b07          	ld	a,(OFST+0,sp)
1286  022c 97            	ld	xl,a
1287  022d 1d0002        	subw	x,#2
1288  0230 72fb08        	addw	x,(OFST+1,sp)
1289  0233 f6            	ld	a,(x)
1290  0234 6b03          	ld	(OFST-4,sp),a
1291                     ; 221 HexToByte(temp,&LRC_dec_from_frame);
1293  0236 96            	ldw	x,sp
1294  0237 1c0002        	addw	x,#OFST-5
1295  023a 89            	pushw	x
1296  023b 5c            	incw	x
1297  023c cd00df        	call	_HexToByte
1299  023f 85            	popw	x
1300                     ; 223 frame[a-1] = '\0';
1302  0240 7b07          	ld	a,(OFST+0,sp)
1303  0242 5f            	clrw	x
1304  0243 97            	ld	xl,a
1305  0244 5a            	decw	x
1306  0245 72fb08        	addw	x,(OFST+1,sp)
1307  0248 7f            	clr	(x)
1308                     ; 224 frame[a-2] = '\0';
1310  0249 5f            	clrw	x
1311  024a 97            	ld	xl,a
1312  024b 1d0002        	subw	x,#2
1313  024e 72fb08        	addw	x,(OFST+1,sp)
1314  0251 7f            	clr	(x)
1315                     ; 227 LRC_calculated = GetLRC(frame);
1317  0252 1e08          	ldw	x,(OFST+1,sp)
1318  0254 ad0e          	call	_GetLRC
1320  0256 6b07          	ld	(OFST+0,sp),a
1321                     ; 229 if (LRC_calculated == LRC_dec_from_frame)
1323  0258 1102          	cp	a,(OFST-5,sp)
1324  025a 2604          	jrne	L315
1325                     ; 231 	return 1;
1327  025c a601          	ld	a,#1
1329  025e 2001          	jra	L431
1330  0260               L315:
1331                     ; 235 	return 0;
1333  0260 4f            	clr	a
1335  0261               L431:
1337  0261 5b09          	addw	sp,#9
1338  0263 81            	ret	
1402                     ; 239 uint8_t GetLRC(char *frame)
1402                     ; 240 {
1403                     	switch	.text
1404  0264               _GetLRC:
1406  0264 89            	pushw	x
1407  0265 5204          	subw	sp,#4
1408       00000004      OFST:	set	4
1411                     ; 241 uint8_t LRCsum = 0;
1413  0267 0f01          	clr	(OFST-3,sp)
1414                     ; 244 frame++;
1416  0269 1e05          	ldw	x,(OFST+1,sp)
1417  026b 5c            	incw	x
1418  026c 1f05          	ldw	(OFST+1,sp),x
1420  026e 201b          	jra	L355
1421  0270               L155:
1422                     ; 248 temp[0] = *frame++;
1424  0270 6b03          	ld	(OFST-1,sp),a
1425  0272 5c            	incw	x
1426                     ; 249 temp[1] = *frame++;
1428  0273 f6            	ld	a,(x)
1429  0274 5c            	incw	x
1430  0275 1f05          	ldw	(OFST+1,sp),x
1431  0277 6b04          	ld	(OFST+0,sp),a
1432                     ; 250 HexToByte(temp, &TempSum);
1434  0279 96            	ldw	x,sp
1435  027a 1c0002        	addw	x,#OFST-2
1436  027d 89            	pushw	x
1437  027e 5c            	incw	x
1438  027f cd00df        	call	_HexToByte
1440  0282 85            	popw	x
1441                     ; 251 LRCsum += TempSum;
1443  0283 7b01          	ld	a,(OFST-3,sp)
1444  0285 1b02          	add	a,(OFST-2,sp)
1445  0287 6b01          	ld	(OFST-3,sp),a
1446  0289 1e05          	ldw	x,(OFST+1,sp)
1447  028b               L355:
1448                     ; 246 while(*frame)
1450  028b f6            	ld	a,(x)
1451  028c 26e2          	jrne	L155
1452                     ; 253 LRCsum = (~(LRCsum)+1);
1454  028e 7b01          	ld	a,(OFST-3,sp)
1455  0290 43            	cpl	a
1456  0291 4c            	inc	a
1457                     ; 254 return LRCsum;
1461  0292 5b06          	addw	sp,#6
1462  0294 81            	ret	
1554                     ; 258 void HexToByte_4(char *hexstring_4, uint16_t *byte)
1554                     ; 259 {
1555                     	switch	.text
1556  0295               _HexToByte_4:
1558  0295 89            	pushw	x
1559  0296 5208          	subw	sp,#8
1560       00000008      OFST:	set	8
1563                     ; 261 uint8_t right_dec = 0;
1565  0298 0f01          	clr	(OFST-7,sp)
1566                     ; 262 uint8_t left_dec = 0;
1568  029a 0f02          	clr	(OFST-6,sp)
1569                     ; 263 uint16_t right_dec16 = 0;
1571  029c 5f            	clrw	x
1572  029d 1f03          	ldw	(OFST-5,sp),x
1573                     ; 264 uint16_t left_dec16 = 0;
1575  029f 1f05          	ldw	(OFST-3,sp),x
1576                     ; 266 tempp[0] = hexstring_4[0];
1578  02a1 1e09          	ldw	x,(OFST+1,sp)
1579  02a3 f6            	ld	a,(x)
1580  02a4 6b07          	ld	(OFST-1,sp),a
1581                     ; 267 tempp[1] = hexstring_4[1];
1583  02a6 e601          	ld	a,(1,x)
1584  02a8 6b08          	ld	(OFST+0,sp),a
1585                     ; 268 HexToByte(tempp,&left_dec);
1587  02aa 96            	ldw	x,sp
1588  02ab 1c0002        	addw	x,#OFST-6
1589  02ae 89            	pushw	x
1590  02af 1c0005        	addw	x,#5
1591  02b2 cd00df        	call	_HexToByte
1593  02b5 85            	popw	x
1594                     ; 270 tempp[0] = hexstring_4[2];
1596  02b6 1e09          	ldw	x,(OFST+1,sp)
1597  02b8 e602          	ld	a,(2,x)
1598  02ba 6b07          	ld	(OFST-1,sp),a
1599                     ; 271 tempp[1] = hexstring_4[3];
1601  02bc e603          	ld	a,(3,x)
1602  02be 6b08          	ld	(OFST+0,sp),a
1603                     ; 272 HexToByte(tempp,&right_dec);
1605  02c0 96            	ldw	x,sp
1606  02c1 5c            	incw	x
1607  02c2 89            	pushw	x
1608  02c3 1c0006        	addw	x,#6
1609  02c6 cd00df        	call	_HexToByte
1611  02c9 85            	popw	x
1612                     ; 274 left_dec16 = left_dec16 | left_dec;
1614  02ca 7b02          	ld	a,(OFST-6,sp)
1615  02cc 5f            	clrw	x
1616  02cd 97            	ld	xl,a
1617  02ce 01            	rrwa	x,a
1618  02cf 1a06          	or	a,(OFST-2,sp)
1619  02d1 01            	rrwa	x,a
1620  02d2 1a05          	or	a,(OFST-3,sp)
1621  02d4 01            	rrwa	x,a
1622  02d5 1f05          	ldw	(OFST-3,sp),x
1623                     ; 275 right_dec16 = right_dec16 | right_dec;
1625  02d7 5f            	clrw	x
1626  02d8 7b01          	ld	a,(OFST-7,sp)
1627  02da 97            	ld	xl,a
1628  02db 01            	rrwa	x,a
1629  02dc 1a04          	or	a,(OFST-4,sp)
1630  02de 01            	rrwa	x,a
1631  02df 1a03          	or	a,(OFST-5,sp)
1632  02e1 01            	rrwa	x,a
1633  02e2 1f03          	ldw	(OFST-5,sp),x
1634                     ; 277 *byte = (left_dec16 << 8) | right_dec16;
1636  02e4 7b04          	ld	a,(OFST-4,sp)
1637  02e6 1e05          	ldw	x,(OFST-3,sp)
1638  02e8 01            	rrwa	x,a
1639  02e9 1a03          	or	a,(OFST-5,sp)
1640  02eb 160d          	ldw	y,(OFST+5,sp)
1641  02ed 01            	rrwa	x,a
1642  02ee 90ff          	ldw	(y),x
1643                     ; 278 }
1646  02f0 5b0a          	addw	sp,#10
1647  02f2 81            	ret	
1757                     ; 282 void ByteToHex_4(char *hexstring, uint16_t byte)
1757                     ; 283 {
1758                     	switch	.text
1759  02f3               _ByteToHex_4:
1761  02f3 89            	pushw	x
1762  02f4 520b          	subw	sp,#11
1763       0000000b      OFST:	set	11
1766                     ; 286 	uint16_t D1 = byte >> 8;
1768  02f6 1e10          	ldw	x,(OFST+5,sp)
1769  02f8 4f            	clr	a
1770  02f9 01            	rrwa	x,a
1771  02fa 1f02          	ldw	(OFST-9,sp),x
1772                     ; 287   uint16_t D2 = byte & 255;
1774  02fc 5f            	clrw	x
1775  02fd 7b11          	ld	a,(OFST+6,sp)
1776  02ff 02            	rlwa	x,a
1777  0300 1f04          	ldw	(OFST-7,sp),x
1778                     ; 288 	uint8_t D1_8 = 0;
1780  0302 0f06          	clr	(OFST-5,sp)
1781                     ; 289 	uint8_t D2_8 = 0;
1783  0304 0f07          	clr	(OFST-4,sp)
1784                     ; 290 	uint8_t ct = 0;
1786  0306 0f01          	clr	(OFST-10,sp)
1787                     ; 292 	D1_8 |= D1;
1789  0308 7b06          	ld	a,(OFST-5,sp)
1790  030a 1a03          	or	a,(OFST-8,sp)
1791  030c 6b06          	ld	(OFST-5,sp),a
1792                     ; 293 	D2_8 |= D2;
1794  030e 7b07          	ld	a,(OFST-4,sp)
1795  0310 1a05          	or	a,(OFST-6,sp)
1796  0312 6b07          	ld	(OFST-4,sp),a
1797                     ; 295 	ByteToHex(temp1, D1_8);
1799  0314 7b06          	ld	a,(OFST-5,sp)
1800  0316 88            	push	a
1801  0317 96            	ldw	x,sp
1802  0318 1c0009        	addw	x,#OFST-2
1803  031b cd00a7        	call	_ByteToHex
1805  031e 84            	pop	a
1806                     ; 296 	ByteToHex(temp2, D2_8);
1808  031f 7b07          	ld	a,(OFST-4,sp)
1809  0321 88            	push	a
1810  0322 96            	ldw	x,sp
1811  0323 1c000b        	addw	x,#OFST+0
1812  0326 cd00a7        	call	_ByteToHex
1814  0329 84            	pop	a
1815                     ; 298 	hexstring[0] = temp1[0];
1817  032a 1e0c          	ldw	x,(OFST+1,sp)
1818  032c 7b08          	ld	a,(OFST-3,sp)
1819  032e f7            	ld	(x),a
1820                     ; 299 	hexstring[1] = temp1[1];
1822  032f 7b09          	ld	a,(OFST-2,sp)
1823  0331 e701          	ld	(1,x),a
1824                     ; 300 	hexstring[2] = temp2[0];
1826  0333 7b0a          	ld	a,(OFST-1,sp)
1827  0335 e702          	ld	(2,x),a
1828                     ; 301 	hexstring[3] = temp2[1];
1830  0337 7b0b          	ld	a,(OFST+0,sp)
1831  0339 e703          	ld	(3,x),a
1832                     ; 303 }
1835  033b 5b0d          	addw	sp,#13
1836  033d 81            	ret	
2000                     ; 313 void ReadCoilStatus(uint16_t *registers)
2000                     ; 314 {
2001                     	switch	.text
2002  033e               _ReadCoilStatus:
2004  033e 89            	pushw	x
2005  033f 522c          	subw	sp,#44
2006       0000002c      OFST:	set	44
2009                     ; 316 uint8_t counter = 0;
2011                     ; 317 uint8_t TempSum=0;
2013  0341 0f0e          	clr	(OFST-30,sp)
2014                     ; 324 uint16_t n = 0;
2016                     ; 327 for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}
2018  0343 5f            	clrw	x
2019  0344 1f2a          	ldw	(OFST-2,sp),x
2020  0346               L5001:
2023  0346 96            	ldw	x,sp
2024  0347 1c0011        	addw	x,#OFST-27
2025  034a 72fb2a        	addw	x,(OFST-2,sp)
2026  034d 7f            	clr	(x)
2029  034e 1e2a          	ldw	x,(OFST-2,sp)
2030  0350 5c            	incw	x
2031  0351 1f2a          	ldw	(OFST-2,sp),x
2034  0353 a30019        	cpw	x,#25
2035  0356 25ee          	jrult	L5001
2036                     ; 330 RewritingChars(OutputFrame,0,4);
2038  0358 4b04          	push	#4
2039  035a 4b00          	push	#0
2040  035c 96            	ldw	x,sp
2041  035d 1c0013        	addw	x,#OFST-25
2042  0360 cd013c        	call	_RewritingChars
2044  0363 b605          	ld	a,_word+5
2045  0365 85            	popw	x
2046                     ; 333 temp4[0] = word[5];
2048  0366 6b08          	ld	(OFST-36,sp),a
2049                     ; 334 temp4[1] = word[6];
2051  0368 b606          	ld	a,_word+6
2052  036a 6b09          	ld	(OFST-35,sp),a
2053                     ; 335 temp4[2] = word[7];
2055  036c b607          	ld	a,_word+7
2056  036e 6b0a          	ld	(OFST-34,sp),a
2057                     ; 336 temp4[3] = word[8];
2059  0370 b608          	ld	a,_word+8
2060  0372 6b0b          	ld	(OFST-33,sp),a
2061                     ; 337 HexToByte_4(temp4, &FirstCoil);
2063  0374 96            	ldw	x,sp
2064  0375 1c0003        	addw	x,#OFST-41
2065  0378 89            	pushw	x
2066  0379 1c0005        	addw	x,#5
2067  037c cd0295        	call	_HexToByte_4
2069  037f b609          	ld	a,_word+9
2070  0381 85            	popw	x
2071                     ; 340 temp4[0] = word[9];
2073  0382 6b08          	ld	(OFST-36,sp),a
2074                     ; 341 temp4[1] = word[10];
2076  0384 b60a          	ld	a,_word+10
2077  0386 6b09          	ld	(OFST-35,sp),a
2078                     ; 342 temp4[2] = word[11];
2080  0388 b60b          	ld	a,_word+11
2081  038a 6b0a          	ld	(OFST-34,sp),a
2082                     ; 343 temp4[3] = word[12];
2084  038c b60c          	ld	a,_word+12
2085  038e 6b0b          	ld	(OFST-33,sp),a
2086                     ; 344 HexToByte_4(temp4, &NumberOfCoils);
2088  0390 96            	ldw	x,sp
2089  0391 1c0005        	addw	x,#OFST-39
2090  0394 89            	pushw	x
2091  0395 1c0003        	addw	x,#3
2092  0398 cd0295        	call	_HexToByte_4
2094  039b 85            	popw	x
2095                     ; 345 if(Check_DataAddr_F01_F02(FirstCoil, NumberOfCoils) & Check_DataVal())
2097  039c cd0a43        	call	_Check_DataVal
2099  039f 6b01          	ld	(OFST-43,sp),a
2100  03a1 1e05          	ldw	x,(OFST-39,sp)
2101  03a3 89            	pushw	x
2102  03a4 1e05          	ldw	x,(OFST-39,sp)
2103  03a6 cd0a18        	call	_Check_DataAddr_F01_F02
2105  03a9 85            	popw	x
2106  03aa 1401          	and	a,(OFST-43,sp)
2107  03ac 2603cc0511    	jreq	L3101
2108                     ; 348 	if((NumberOfCoils%8)!=0)
2110  03b1 7b06          	ld	a,(OFST-38,sp)
2111  03b3 a507          	bcp	a,#7
2112  03b5 2709          	jreq	L5101
2113                     ; 350 		NumberOfDataBytes = ( NumberOfCoils/8)+1;
2115  03b7 1e05          	ldw	x,(OFST-39,sp)
2116  03b9 54            	srlw	x
2117  03ba 54            	srlw	x
2118  03bb 54            	srlw	x
2119  03bc 01            	rrwa	x,a
2120  03bd 4c            	inc	a
2122  03be 2006          	jra	L7101
2123  03c0               L5101:
2124                     ; 354 		NumberOfDataBytes = NumberOfCoils/8;
2126  03c0 1e05          	ldw	x,(OFST-39,sp)
2127  03c2 54            	srlw	x
2128  03c3 54            	srlw	x
2129  03c4 54            	srlw	x
2130  03c5 01            	rrwa	x,a
2131  03c6               L7101:
2132  03c6 6b07          	ld	(OFST-37,sp),a
2133                     ; 358 	ByteToHex(temp,NumberOfDataBytes);
2135  03c8 88            	push	a
2136  03c9 96            	ldw	x,sp
2137  03ca 1c0010        	addw	x,#OFST-28
2138  03cd cd00a7        	call	_ByteToHex
2140  03d0 84            	pop	a
2141                     ; 359 	OutputFrame[5] = temp[0];
2143  03d1 7b0f          	ld	a,(OFST-29,sp)
2144  03d3 6b16          	ld	(OFST-22,sp),a
2145                     ; 360 	OutputFrame[6] = temp[1];
2147  03d5 7b10          	ld	a,(OFST-28,sp)
2148  03d7 6b17          	ld	(OFST-21,sp),a
2149                     ; 363 	counter = 7; 
2151  03d9 a607          	ld	a,#7
2152  03db 6b2c          	ld	(OFST+0,sp),a
2153                     ; 364 	Coil = FirstCoil;
2155  03dd 1e03          	ldw	x,(OFST-41,sp)
2156  03df 1f0c          	ldw	(OFST-32,sp),x
2157                     ; 365 	n = NumberOfCoils;
2159  03e1 1e05          	ldw	x,(OFST-39,sp)
2160  03e3 1f2a          	ldw	(OFST-2,sp),x
2162  03e5 cc04ad        	jra	L5201
2163  03e8               L1201:
2164                     ; 368 					if(n>=8)                   //    changes 8bits to hex
2166  03e8 a30008        	cpw	x,#8
2167  03eb 255b          	jrult	L1301
2168                     ; 370 						uint8_t pwr = 0;
2170                     ; 371 						for(pwr =0; pwr<8; pwr++,Coil++)
2172  03ed 0f02          	clr	(OFST-42,sp)
2173  03ef               L3301:
2174                     ; 373 							TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
2176  03ef 1e2d          	ldw	x,(OFST+1,sp)
2177  03f1 89            	pushw	x
2178  03f2 7b0f          	ld	a,(OFST-29,sp)
2179  03f4 cd01d5        	call	_StateOfCoil
2181  03f7 85            	popw	x
2182  03f8 6b01          	ld	(OFST-43,sp),a
2183  03fa 5f            	clrw	x
2184  03fb 7b02          	ld	a,(OFST-42,sp)
2185  03fd 97            	ld	xl,a
2186  03fe a601          	ld	a,#1
2187  0400 5d            	tnzw	x
2188  0401 2704          	jreq	L671
2189  0403               L002:
2190  0403 48            	sll	a
2191  0404 5a            	decw	x
2192  0405 26fc          	jrne	L002
2193  0407               L671:
2194  0407 97            	ld	xl,a
2195  0408 7b01          	ld	a,(OFST-43,sp)
2196  040a 42            	mul	x,a
2197  040b 9f            	ld	a,xl
2198  040c 1b0e          	add	a,(OFST-30,sp)
2199  040e 6b0e          	ld	(OFST-30,sp),a
2200                     ; 374 							n--;
2202  0410 1e2a          	ldw	x,(OFST-2,sp)
2203  0412 5a            	decw	x
2204  0413 1f2a          	ldw	(OFST-2,sp),x
2205                     ; 371 						for(pwr =0; pwr<8; pwr++,Coil++)
2207  0415 0c02          	inc	(OFST-42,sp)
2208  0417 1e0c          	ldw	x,(OFST-32,sp)
2209  0419 5c            	incw	x
2210  041a 1f0c          	ldw	(OFST-32,sp),x
2213  041c 7b02          	ld	a,(OFST-42,sp)
2214  041e a108          	cp	a,#8
2215  0420 25cd          	jrult	L3301
2216                     ; 377 						ByteToHex(temp,TempSum);
2218  0422 7b0e          	ld	a,(OFST-30,sp)
2219  0424 88            	push	a
2220  0425 96            	ldw	x,sp
2221  0426 1c0010        	addw	x,#OFST-28
2222  0429 cd00a7        	call	_ByteToHex
2224  042c 84            	pop	a
2225                     ; 378 						TempSum = 0;
2227  042d 0f0e          	clr	(OFST-30,sp)
2228                     ; 379 						OutputFrame[counter] = temp[0];
2230  042f 96            	ldw	x,sp
2231  0430 cd0514        	call	LC003
2232  0433 1b2c          	add	a,(OFST+0,sp)
2233  0435 2401          	jrnc	L402
2234  0437 5c            	incw	x
2235  0438               L402:
2236  0438 02            	rlwa	x,a
2237  0439 7b0f          	ld	a,(OFST-29,sp)
2238  043b f7            	ld	(x),a
2239                     ; 380 						counter++;
2241                     ; 381 						OutputFrame[counter] = temp[1];
2243  043c 96            	ldw	x,sp
2244  043d 0c2c          	inc	(OFST+0,sp)
2245  043f cd0514        	call	LC003
2246  0442 1b2c          	add	a,(OFST+0,sp)
2247  0444 2461          	jrnc	L222
2248                     ; 382 						counter++;
2250  0446 205e          	jp	LC002
2251  0448               L1301:
2252                     ; 387 							uint8_t pwr = 0;
2254                     ; 388 							uint8_t zm = n;
2256  0448 7b2b          	ld	a,(OFST-1,sp)
2257  044a 6b07          	ld	(OFST-37,sp),a
2258                     ; 389 							for(pwr =0; pwr<zm; pwr++,Coil++)
2260  044c 0f02          	clr	(OFST-42,sp)
2262  044e 202d          	jra	L7401
2263  0450               L3401:
2264                     ; 391 									TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
2266  0450 1e2d          	ldw	x,(OFST+1,sp)
2267  0452 89            	pushw	x
2268  0453 7b0f          	ld	a,(OFST-29,sp)
2269  0455 cd01d5        	call	_StateOfCoil
2271  0458 85            	popw	x
2272  0459 6b01          	ld	(OFST-43,sp),a
2273  045b 5f            	clrw	x
2274  045c 7b02          	ld	a,(OFST-42,sp)
2275  045e 97            	ld	xl,a
2276  045f a601          	ld	a,#1
2277  0461 5d            	tnzw	x
2278  0462 2704          	jreq	L212
2279  0464               L412:
2280  0464 48            	sll	a
2281  0465 5a            	decw	x
2282  0466 26fc          	jrne	L412
2283  0468               L212:
2284  0468 97            	ld	xl,a
2285  0469 7b01          	ld	a,(OFST-43,sp)
2286  046b 42            	mul	x,a
2287  046c 9f            	ld	a,xl
2288  046d 1b0e          	add	a,(OFST-30,sp)
2289  046f 6b0e          	ld	(OFST-30,sp),a
2290                     ; 392 									n--;
2292  0471 1e2a          	ldw	x,(OFST-2,sp)
2293  0473 5a            	decw	x
2294  0474 1f2a          	ldw	(OFST-2,sp),x
2295                     ; 389 							for(pwr =0; pwr<zm; pwr++,Coil++)
2297  0476 0c02          	inc	(OFST-42,sp)
2298  0478 1e0c          	ldw	x,(OFST-32,sp)
2299  047a 5c            	incw	x
2300  047b 1f0c          	ldw	(OFST-32,sp),x
2301  047d               L7401:
2304  047d 7b02          	ld	a,(OFST-42,sp)
2305  047f 1107          	cp	a,(OFST-37,sp)
2306  0481 25cd          	jrult	L3401
2307                     ; 394 							ByteToHex(temp,TempSum);
2309  0483 7b0e          	ld	a,(OFST-30,sp)
2310  0485 88            	push	a
2311  0486 96            	ldw	x,sp
2312  0487 1c0010        	addw	x,#OFST-28
2313  048a cd00a7        	call	_ByteToHex
2315  048d 84            	pop	a
2316                     ; 395 							TempSum = 0;
2318  048e 0f0e          	clr	(OFST-30,sp)
2319                     ; 396 							OutputFrame[counter] = temp[0];
2321  0490 96            	ldw	x,sp
2322  0491 cd0514        	call	LC003
2323  0494 1b2c          	add	a,(OFST+0,sp)
2324  0496 2401          	jrnc	L022
2325  0498 5c            	incw	x
2326  0499               L022:
2327  0499 02            	rlwa	x,a
2328  049a 7b0f          	ld	a,(OFST-29,sp)
2329  049c f7            	ld	(x),a
2330                     ; 397 							counter++;
2332                     ; 398 							OutputFrame[counter] = temp[1];
2334  049d 96            	ldw	x,sp
2335  049e 0c2c          	inc	(OFST+0,sp)
2336  04a0 ad72          	call	LC003
2337  04a2 1b2c          	add	a,(OFST+0,sp)
2338  04a4 2401          	jrnc	L222
2339  04a6               LC002:
2340  04a6 5c            	incw	x
2341  04a7               L222:
2342                     ; 399 							counter++;
2344  04a7 02            	rlwa	x,a
2345  04a8 7b10          	ld	a,(OFST-28,sp)
2346  04aa f7            	ld	(x),a
2348  04ab 0c2c          	inc	(OFST+0,sp)
2349  04ad               L5201:
2350                     ; 366 	while(n>0)
2352  04ad 1e2a          	ldw	x,(OFST-2,sp)
2353  04af 2703cc03e8    	jrne	L1201
2354                     ; 404 	ByteToHex(temp,GetLRC(OutputFrame));
2356  04b4 96            	ldw	x,sp
2357  04b5 1c0011        	addw	x,#OFST-27
2358  04b8 cd0264        	call	_GetLRC
2360  04bb 88            	push	a
2361  04bc 96            	ldw	x,sp
2362  04bd 1c0010        	addw	x,#OFST-28
2363  04c0 cd00a7        	call	_ByteToHex
2365  04c3 84            	pop	a
2366                     ; 405 	OutputFrame[counter] = temp[0];
2368  04c4 96            	ldw	x,sp
2369  04c5 ad4d          	call	LC003
2370  04c7 1b2c          	add	a,(OFST+0,sp)
2371  04c9 2401          	jrnc	L032
2372  04cb 5c            	incw	x
2373  04cc               L032:
2374  04cc 02            	rlwa	x,a
2375  04cd 7b0f          	ld	a,(OFST-29,sp)
2376  04cf f7            	ld	(x),a
2377                     ; 406 	counter++;
2379                     ; 407 	OutputFrame[counter] = temp[1];
2381  04d0 96            	ldw	x,sp
2382  04d1 0c2c          	inc	(OFST+0,sp)
2383  04d3 ad3f          	call	LC003
2384  04d5 1b2c          	add	a,(OFST+0,sp)
2385  04d7 2401          	jrnc	L232
2386  04d9 5c            	incw	x
2387  04da               L232:
2388  04da 02            	rlwa	x,a
2389  04db 7b10          	ld	a,(OFST-28,sp)
2390  04dd f7            	ld	(x),a
2391                     ; 408 	counter++;
2393                     ; 409 	OutputFrame[counter] = 0x0D;
2395  04de 96            	ldw	x,sp
2396  04df 0c2c          	inc	(OFST+0,sp)
2397  04e1 ad31          	call	LC003
2398  04e3 1b2c          	add	a,(OFST+0,sp)
2399  04e5 2401          	jrnc	L432
2400  04e7 5c            	incw	x
2401  04e8               L432:
2402  04e8 02            	rlwa	x,a
2403  04e9 a60d          	ld	a,#13
2404  04eb f7            	ld	(x),a
2405                     ; 410 	counter++;
2407                     ; 411 	OutputFrame[counter] = 0x0A;
2409  04ec 96            	ldw	x,sp
2410  04ed 0c2c          	inc	(OFST+0,sp)
2411  04ef ad23          	call	LC003
2412  04f1 1b2c          	add	a,(OFST+0,sp)
2413  04f3 2401          	jrnc	L632
2414  04f5 5c            	incw	x
2415  04f6               L632:
2416  04f6 02            	rlwa	x,a
2417  04f7 a60a          	ld	a,#10
2418  04f9 f7            	ld	(x),a
2419                     ; 412 	counter++;
2421                     ; 413 	OutputFrame[counter] = 0x0A;
2423  04fa 96            	ldw	x,sp
2424  04fb 0c2c          	inc	(OFST+0,sp)
2425  04fd ad15          	call	LC003
2426  04ff 1b2c          	add	a,(OFST+0,sp)
2427  0501 2401          	jrnc	L042
2428  0503 5c            	incw	x
2429  0504               L042:
2430  0504 02            	rlwa	x,a
2431  0505 a60a          	ld	a,#10
2432  0507 f7            	ld	(x),a
2433                     ; 414 	counter++;
2435                     ; 417 		UART_SendStr(OutputFrame); 
2437  0508 96            	ldw	x,sp
2438  0509 0c2c          	inc	(OFST+0,sp)
2439  050b 1c0011        	addw	x,#OFST-27
2440  050e cd0000        	call	_UART_SendStr
2442  0511               L3101:
2443                     ; 419 }
2446  0511 5b2e          	addw	sp,#46
2447  0513 81            	ret	
2448  0514               LC003:
2449  0514 1c0011        	addw	x,#OFST-27
2450  0517 9f            	ld	a,xl
2451  0518 5e            	swapw	x
2452  0519 81            	ret	
2477                     ; 423 void ReadInputStatus(void)
2477                     ; 424 {
2478                     	switch	.text
2479  051a               _ReadInputStatus:
2483                     ; 425 ReadCoilStatus(Input_Registers);
2485  051a ae0000        	ldw	x,#_Input_Registers
2487                     ; 426 }
2490  051d cc033e        	jp	_ReadCoilStatus
2628                     ; 430 void ReadHoldingRegisters(uint16_t *registers)
2628                     ; 431 {
2629                     	switch	.text
2630  0520               _ReadHoldingRegisters:
2632  0520 89            	pushw	x
2633  0521 5229          	subw	sp,#41
2634       00000029      OFST:	set	41
2637                     ; 436 uint16_t FirstReg = 0;
2639  0523 5f            	clrw	x
2640  0524 1f04          	ldw	(OFST-37,sp),x
2641                     ; 437 uint16_t NumberOfRegs = 0;
2643  0526 1f06          	ldw	(OFST-35,sp),x
2644                     ; 438 uint8_t NumberOfBytes = 0 ;
2646                     ; 439 uint8_t ct = 0;
2648                     ; 440 uint8_t k = 0;
2650                     ; 441 uint8_t counter = 0;
2652                     ; 442 uint16_t Content_dec = 0;
2654                     ; 446 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
2656  0528 0f0b          	clr	(OFST-30,sp)
2657  052a               L1511:
2660  052a 96            	ldw	x,sp
2661  052b cd0673        	call	LC004
2662  052e 1b0b          	add	a,(OFST-30,sp)
2663  0530 2401          	jrnc	L252
2664  0532 5c            	incw	x
2665  0533               L252:
2666  0533 02            	rlwa	x,a
2667  0534 7f            	clr	(x)
2670  0535 0c0b          	inc	(OFST-30,sp)
2673  0537 7b0b          	ld	a,(OFST-30,sp)
2674  0539 a119          	cp	a,#25
2675  053b 25ed          	jrult	L1511
2676                     ; 449 RewritingChars(OutputFrame,0,4);
2678  053d 4b04          	push	#4
2679  053f 4b00          	push	#0
2680  0541 96            	ldw	x,sp
2681  0542 1c000e        	addw	x,#OFST-27
2682  0545 cd013c        	call	_RewritingChars
2684  0548 b605          	ld	a,_word+5
2685  054a 85            	popw	x
2686                     ; 452 temp[0] = word[5];
2688  054b 6b25          	ld	(OFST-4,sp),a
2689                     ; 453 temp[1] = word[6];
2691  054d b606          	ld	a,_word+6
2692  054f 6b26          	ld	(OFST-3,sp),a
2693                     ; 454 temp[2] = word[7];
2695  0551 b607          	ld	a,_word+7
2696  0553 6b27          	ld	(OFST-2,sp),a
2697                     ; 455 temp[3] = word[8];
2699  0555 b608          	ld	a,_word+8
2700  0557 6b28          	ld	(OFST-1,sp),a
2701                     ; 456 HexToByte_4(temp, &FirstReg);
2703  0559 96            	ldw	x,sp
2704  055a 1c0004        	addw	x,#OFST-37
2705  055d 89            	pushw	x
2706  055e 1c0021        	addw	x,#33
2707  0561 cd0295        	call	_HexToByte_4
2709  0564 b609          	ld	a,_word+9
2710  0566 85            	popw	x
2711                     ; 459 temp[0] = word[9];
2713  0567 6b25          	ld	(OFST-4,sp),a
2714                     ; 460 temp[1] = word[10];
2716  0569 b60a          	ld	a,_word+10
2717  056b 6b26          	ld	(OFST-3,sp),a
2718                     ; 461 temp[2] = word[11];
2720  056d b60b          	ld	a,_word+11
2721  056f 6b27          	ld	(OFST-2,sp),a
2722                     ; 462 temp[3] = word[12];
2724  0571 b60c          	ld	a,_word+12
2725  0573 6b28          	ld	(OFST-1,sp),a
2726                     ; 463 HexToByte_4(temp, &NumberOfRegs);
2728  0575 96            	ldw	x,sp
2729  0576 1c0006        	addw	x,#OFST-35
2730  0579 89            	pushw	x
2731  057a 1c001f        	addw	x,#31
2732  057d cd0295        	call	_HexToByte_4
2734  0580 85            	popw	x
2735                     ; 464 if(Check_DataAddr_F03_F04(FirstReg, NumberOfRegs) & Check_DataVal())
2737  0581 cd0a43        	call	_Check_DataVal
2739  0584 6b01          	ld	(OFST-40,sp),a
2740  0586 1e06          	ldw	x,(OFST-35,sp)
2741  0588 89            	pushw	x
2742  0589 1e06          	ldw	x,(OFST-35,sp)
2743  058b cd0a51        	call	_Check_DataAddr_F03_F04
2745  058e 85            	popw	x
2746  058f 1401          	and	a,(OFST-40,sp)
2747  0591 2603cc0670    	jreq	L7511
2748                     ; 467 	NumberOfBytes = NumberOfRegs*2;
2750  0596 7b07          	ld	a,(OFST-34,sp)
2751  0598 48            	sll	a
2752  0599 6b0a          	ld	(OFST-31,sp),a
2753                     ; 470 	ByteToHex(temp,NumberOfBytes);
2755  059b 88            	push	a
2756  059c 96            	ldw	x,sp
2757  059d 1c0026        	addw	x,#OFST-3
2758  05a0 cd00a7        	call	_ByteToHex
2760  05a3 84            	pop	a
2761                     ; 471 	OutputFrame[5] = temp[0];
2763  05a4 7b25          	ld	a,(OFST-4,sp)
2764  05a6 6b11          	ld	(OFST-24,sp),a
2765                     ; 472 	OutputFrame[6] = temp[1];
2767  05a8 7b26          	ld	a,(OFST-3,sp)
2768  05aa 6b12          	ld	(OFST-23,sp),a
2769                     ; 474 	counter = 7;
2771  05ac a607          	ld	a,#7
2772  05ae 6b29          	ld	(OFST+0,sp),a
2773                     ; 475 	k = FirstReg;
2775  05b0 7b05          	ld	a,(OFST-36,sp)
2776  05b2 6b0b          	ld	(OFST-30,sp),a
2777                     ; 479 	for(ct=0;ct<NumberOfRegs;ct++)
2779  05b4 0f0a          	clr	(OFST-31,sp)
2781  05b6 2053          	jra	L5611
2782  05b8               L1611:
2783                     ; 481 		Content_dec = registers[k];
2785  05b8 7b0b          	ld	a,(OFST-30,sp)
2786  05ba 5f            	clrw	x
2787  05bb 97            	ld	xl,a
2788  05bc 58            	sllw	x
2789  05bd 72fb2a        	addw	x,(OFST+1,sp)
2790  05c0 fe            	ldw	x,(x)
2791  05c1 1f08          	ldw	(OFST-33,sp),x
2792                     ; 482 		ByteToHex_4(temp,Content_dec);
2794  05c3 89            	pushw	x
2795  05c4 96            	ldw	x,sp
2796  05c5 1c0027        	addw	x,#OFST-2
2797  05c8 cd02f3        	call	_ByteToHex_4
2799  05cb 85            	popw	x
2800                     ; 483 		OutputFrame[counter] = temp[0];
2802  05cc 96            	ldw	x,sp
2803  05cd cd0673        	call	LC004
2804  05d0 1b29          	add	a,(OFST+0,sp)
2805  05d2 2401          	jrnc	L272
2806  05d4 5c            	incw	x
2807  05d5               L272:
2808  05d5 02            	rlwa	x,a
2809  05d6 7b25          	ld	a,(OFST-4,sp)
2810  05d8 f7            	ld	(x),a
2811                     ; 484 		counter++;
2813                     ; 485 		OutputFrame[counter] = temp[1];
2815  05d9 96            	ldw	x,sp
2816  05da 0c29          	inc	(OFST+0,sp)
2817  05dc cd0673        	call	LC004
2818  05df 1b29          	add	a,(OFST+0,sp)
2819  05e1 2401          	jrnc	L472
2820  05e3 5c            	incw	x
2821  05e4               L472:
2822  05e4 02            	rlwa	x,a
2823  05e5 7b26          	ld	a,(OFST-3,sp)
2824  05e7 f7            	ld	(x),a
2825                     ; 486 		counter++;
2827                     ; 487 		OutputFrame[counter] = temp[2];
2829  05e8 96            	ldw	x,sp
2830  05e9 0c29          	inc	(OFST+0,sp)
2831  05eb cd0673        	call	LC004
2832  05ee 1b29          	add	a,(OFST+0,sp)
2833  05f0 2401          	jrnc	L672
2834  05f2 5c            	incw	x
2835  05f3               L672:
2836  05f3 02            	rlwa	x,a
2837  05f4 7b27          	ld	a,(OFST-2,sp)
2838  05f6 f7            	ld	(x),a
2839                     ; 488 		counter++;
2841                     ; 489 		OutputFrame[counter] = temp[3];
2843  05f7 96            	ldw	x,sp
2844  05f8 0c29          	inc	(OFST+0,sp)
2845  05fa ad77          	call	LC004
2846  05fc 1b29          	add	a,(OFST+0,sp)
2847  05fe 2401          	jrnc	L003
2848  0600 5c            	incw	x
2849  0601               L003:
2850  0601 02            	rlwa	x,a
2851  0602 7b28          	ld	a,(OFST-1,sp)
2852  0604 f7            	ld	(x),a
2853                     ; 490 		counter++;
2855  0605 0c29          	inc	(OFST+0,sp)
2856                     ; 491 		k++;
2858  0607 0c0b          	inc	(OFST-30,sp)
2859                     ; 479 	for(ct=0;ct<NumberOfRegs;ct++)
2861  0609 0c0a          	inc	(OFST-31,sp)
2862  060b               L5611:
2865  060b 7b0a          	ld	a,(OFST-31,sp)
2866  060d 5f            	clrw	x
2867  060e 97            	ld	xl,a
2868  060f 1306          	cpw	x,(OFST-35,sp)
2869  0611 25a5          	jrult	L1611
2870                     ; 496 	ByteToHex(temp2,GetLRC(OutputFrame));
2872  0613 96            	ldw	x,sp
2873  0614 1c000c        	addw	x,#OFST-29
2874  0617 cd0264        	call	_GetLRC
2876  061a 88            	push	a
2877  061b 96            	ldw	x,sp
2878  061c 1c0003        	addw	x,#OFST-38
2879  061f cd00a7        	call	_ByteToHex
2881  0622 84            	pop	a
2882                     ; 497 	OutputFrame[counter] = temp2[0];
2884  0623 96            	ldw	x,sp
2885  0624 ad4d          	call	LC004
2886  0626 1b29          	add	a,(OFST+0,sp)
2887  0628 2401          	jrnc	L603
2888  062a 5c            	incw	x
2889  062b               L603:
2890  062b 02            	rlwa	x,a
2891  062c 7b02          	ld	a,(OFST-39,sp)
2892  062e f7            	ld	(x),a
2893                     ; 498 	counter++;
2895                     ; 499 	OutputFrame[counter] = temp2[1];
2897  062f 96            	ldw	x,sp
2898  0630 0c29          	inc	(OFST+0,sp)
2899  0632 ad3f          	call	LC004
2900  0634 1b29          	add	a,(OFST+0,sp)
2901  0636 2401          	jrnc	L013
2902  0638 5c            	incw	x
2903  0639               L013:
2904  0639 02            	rlwa	x,a
2905  063a 7b03          	ld	a,(OFST-38,sp)
2906  063c f7            	ld	(x),a
2907                     ; 500 	counter++;
2909                     ; 501 	OutputFrame[counter] = 0x0D;
2911  063d 96            	ldw	x,sp
2912  063e 0c29          	inc	(OFST+0,sp)
2913  0640 ad31          	call	LC004
2914  0642 1b29          	add	a,(OFST+0,sp)
2915  0644 2401          	jrnc	L213
2916  0646 5c            	incw	x
2917  0647               L213:
2918  0647 02            	rlwa	x,a
2919  0648 a60d          	ld	a,#13
2920  064a f7            	ld	(x),a
2921                     ; 502 	counter++;
2923                     ; 503 	OutputFrame[counter] = 0x0A;
2925  064b 96            	ldw	x,sp
2926  064c 0c29          	inc	(OFST+0,sp)
2927  064e ad23          	call	LC004
2928  0650 1b29          	add	a,(OFST+0,sp)
2929  0652 2401          	jrnc	L413
2930  0654 5c            	incw	x
2931  0655               L413:
2932  0655 02            	rlwa	x,a
2933  0656 a60a          	ld	a,#10
2934  0658 f7            	ld	(x),a
2935                     ; 504 	counter++;
2937                     ; 505 	OutputFrame[counter] = 0x0A;
2939  0659 96            	ldw	x,sp
2940  065a 0c29          	inc	(OFST+0,sp)
2941  065c ad15          	call	LC004
2942  065e 1b29          	add	a,(OFST+0,sp)
2943  0660 2401          	jrnc	L613
2944  0662 5c            	incw	x
2945  0663               L613:
2946  0663 02            	rlwa	x,a
2947  0664 a60a          	ld	a,#10
2948  0666 f7            	ld	(x),a
2949                     ; 506 	counter++;
2951                     ; 510 	UART_SendStr(OutputFrame); 
2953  0667 96            	ldw	x,sp
2954  0668 0c29          	inc	(OFST+0,sp)
2955  066a 1c000c        	addw	x,#OFST-29
2956  066d cd0000        	call	_UART_SendStr
2958  0670               L7511:
2959                     ; 512 }
2962  0670 5b2b          	addw	sp,#43
2963  0672 81            	ret	
2964  0673               LC004:
2965  0673 1c000c        	addw	x,#OFST-29
2966  0676 9f            	ld	a,xl
2967  0677 5e            	swapw	x
2968  0678 81            	ret	
2993                     ; 515 void ReadInputRegisters(void)
2993                     ; 516 {
2994                     	switch	.text
2995  0679               _ReadInputRegisters:
2999                     ; 518 ReadHoldingRegisters(Input_Registers);
3001  0679 ae0000        	ldw	x,#_Input_Registers
3003                     ; 519 }
3006  067c cc0520        	jp	_ReadHoldingRegisters
3097                     ; 523 void ForceSingleCoil(void)
3097                     ; 524 {
3098                     	switch	.text
3099  067f               _ForceSingleCoil:
3101  067f 5224          	subw	sp,#36
3102       00000024      OFST:	set	36
3105                     ; 529 uint16_t Coil = 0;
3107  0681 5f            	clrw	x
3108  0682 1f05          	ldw	(OFST-31,sp),x
3109                     ; 530 uint16_t StatusToWrite = 0;
3111  0684 1f01          	ldw	(OFST-35,sp),x
3112                     ; 531 uint8_t k = 0;
3114                     ; 534 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
3116  0686 0f24          	clr	(OFST+0,sp)
3117  0688               L3421:
3120  0688 96            	ldw	x,sp
3121  0689 cd075d        	call	LC005
3122  068c 1b24          	add	a,(OFST+0,sp)
3123  068e 2401          	jrnc	L033
3124  0690 5c            	incw	x
3125  0691               L033:
3126  0691 02            	rlwa	x,a
3127  0692 7f            	clr	(x)
3130  0693 0c24          	inc	(OFST+0,sp)
3133  0695 7b24          	ld	a,(OFST+0,sp)
3134  0697 a119          	cp	a,#25
3135  0699 25ed          	jrult	L3421
3136                     ; 537 RewritingChars(OutputFrame,0,12);
3138  069b 4b0c          	push	#12
3139  069d 4b00          	push	#0
3140  069f 96            	ldw	x,sp
3141  06a0 1c000d        	addw	x,#OFST-23
3142  06a3 cd013c        	call	_RewritingChars
3144  06a6 b605          	ld	a,_word+5
3145  06a8 85            	popw	x
3146                     ; 541 temp4[0] = word[5];
3148  06a9 6b07          	ld	(OFST-29,sp),a
3149                     ; 542 temp4[1] = word[6];
3151  06ab b606          	ld	a,_word+6
3152  06ad 6b08          	ld	(OFST-28,sp),a
3153                     ; 543 temp4[2] = word[7];
3155  06af b607          	ld	a,_word+7
3156  06b1 6b09          	ld	(OFST-27,sp),a
3157                     ; 544 temp4[3] = word[8];
3159  06b3 b608          	ld	a,_word+8
3160  06b5 6b0a          	ld	(OFST-26,sp),a
3161                     ; 545 HexToByte_4(temp4, &Coil);
3163  06b7 96            	ldw	x,sp
3164  06b8 1c0005        	addw	x,#OFST-31
3165  06bb 89            	pushw	x
3166  06bc 1c0002        	addw	x,#2
3167  06bf cd0295        	call	_HexToByte_4
3169  06c2 85            	popw	x
3170                     ; 546 if(Check_DataAddr_F05(Coil))
3172  06c3 1e05          	ldw	x,(OFST-31,sp)
3173  06c5 cd0a78        	call	_Check_DataAddr_F05
3175  06c8 4d            	tnz	a
3176  06c9 2603cc075a    	jreq	L1521
3177                     ; 549 	temp4[0] = word[9];
3179  06ce b609          	ld	a,_word+9
3180  06d0 6b07          	ld	(OFST-29,sp),a
3181                     ; 550 	temp4[1] = word[10];
3183  06d2 b60a          	ld	a,_word+10
3184  06d4 6b08          	ld	(OFST-28,sp),a
3185                     ; 551 	temp4[2] = word[11];
3187  06d6 b60b          	ld	a,_word+11
3188  06d8 6b09          	ld	(OFST-27,sp),a
3189                     ; 552 	temp4[3] = word[12];
3191  06da b60c          	ld	a,_word+12
3192  06dc 6b0a          	ld	(OFST-26,sp),a
3193                     ; 553 	HexToByte_4(temp4, &StatusToWrite);
3195  06de 96            	ldw	x,sp
3196  06df 5c            	incw	x
3197  06e0 89            	pushw	x
3198  06e1 1c0006        	addw	x,#6
3199  06e4 cd0295        	call	_HexToByte_4
3201  06e7 85            	popw	x
3202                     ; 556 	SetSingleCoil( &Coil,  &StatusToWrite, Output_Registers);
3204  06e8 ae0000        	ldw	x,#_Output_Registers
3205  06eb 89            	pushw	x
3206  06ec 96            	ldw	x,sp
3207  06ed 1c0003        	addw	x,#OFST-33
3208  06f0 89            	pushw	x
3209  06f1 1c0004        	addw	x,#4
3210  06f4 cd015e        	call	_SetSingleCoil
3212  06f7 5b04          	addw	sp,#4
3213                     ; 559 	k = 13;
3215  06f9 a60d          	ld	a,#13
3216  06fb 6b24          	ld	(OFST+0,sp),a
3217                     ; 560 	ByteToHex(temp2,GetLRC(OutputFrame));
3219  06fd 96            	ldw	x,sp
3220  06fe 1c000b        	addw	x,#OFST-25
3221  0701 cd0264        	call	_GetLRC
3223  0704 88            	push	a
3224  0705 96            	ldw	x,sp
3225  0706 1c0004        	addw	x,#OFST-32
3226  0709 cd00a7        	call	_ByteToHex
3228  070c 84            	pop	a
3229                     ; 561 	OutputFrame[k] = temp2[0];
3231  070d 96            	ldw	x,sp
3232  070e ad4d          	call	LC005
3233  0710 1b24          	add	a,(OFST+0,sp)
3234  0712 2401          	jrnc	L053
3235  0714 5c            	incw	x
3236  0715               L053:
3237  0715 02            	rlwa	x,a
3238  0716 7b03          	ld	a,(OFST-33,sp)
3239  0718 f7            	ld	(x),a
3240                     ; 562 	k++;
3242                     ; 563 	OutputFrame[k] = temp2[1];
3244  0719 96            	ldw	x,sp
3245  071a 0c24          	inc	(OFST+0,sp)
3246  071c ad3f          	call	LC005
3247  071e 1b24          	add	a,(OFST+0,sp)
3248  0720 2401          	jrnc	L253
3249  0722 5c            	incw	x
3250  0723               L253:
3251  0723 02            	rlwa	x,a
3252  0724 7b04          	ld	a,(OFST-32,sp)
3253  0726 f7            	ld	(x),a
3254                     ; 564 	k++;
3256                     ; 565 	OutputFrame[k] = 0x0D;
3258  0727 96            	ldw	x,sp
3259  0728 0c24          	inc	(OFST+0,sp)
3260  072a ad31          	call	LC005
3261  072c 1b24          	add	a,(OFST+0,sp)
3262  072e 2401          	jrnc	L453
3263  0730 5c            	incw	x
3264  0731               L453:
3265  0731 02            	rlwa	x,a
3266  0732 a60d          	ld	a,#13
3267  0734 f7            	ld	(x),a
3268                     ; 566 	k++;
3270                     ; 567 	OutputFrame[k] = 0x0A;
3272  0735 96            	ldw	x,sp
3273  0736 0c24          	inc	(OFST+0,sp)
3274  0738 ad23          	call	LC005
3275  073a 1b24          	add	a,(OFST+0,sp)
3276  073c 2401          	jrnc	L653
3277  073e 5c            	incw	x
3278  073f               L653:
3279  073f 02            	rlwa	x,a
3280  0740 a60a          	ld	a,#10
3281  0742 f7            	ld	(x),a
3282                     ; 568 	k++;
3284                     ; 569 	OutputFrame[k] = 0x0A;
3286  0743 96            	ldw	x,sp
3287  0744 0c24          	inc	(OFST+0,sp)
3288  0746 ad15          	call	LC005
3289  0748 1b24          	add	a,(OFST+0,sp)
3290  074a 2401          	jrnc	L063
3291  074c 5c            	incw	x
3292  074d               L063:
3293  074d 02            	rlwa	x,a
3294  074e a60a          	ld	a,#10
3295  0750 f7            	ld	(x),a
3296                     ; 570 	k++;
3298                     ; 573 	UART_SendStr(OutputFrame); 
3300  0751 96            	ldw	x,sp
3301  0752 0c24          	inc	(OFST+0,sp)
3302  0754 1c000b        	addw	x,#OFST-25
3303  0757 cd0000        	call	_UART_SendStr
3305  075a               L1521:
3306                     ; 575 }
3309  075a 5b24          	addw	sp,#36
3310  075c 81            	ret	
3311  075d               LC005:
3312  075d 1c000b        	addw	x,#OFST-25
3313  0760 9f            	ld	a,xl
3314  0761 5e            	swapw	x
3315  0762 81            	ret	
3407                     ; 579 void PresetSingleRegister(void)
3407                     ; 580 {
3408                     	switch	.text
3409  0763               _PresetSingleRegister:
3411  0763 5225          	subw	sp,#37
3412       00000025      OFST:	set	37
3415                     ; 585 uint16_t Register = 0;
3417  0765 5f            	clrw	x
3418  0766 1f06          	ldw	(OFST-31,sp),x
3419                     ; 586 uint16_t ValueToWrite = 0;
3421  0768 1f02          	ldw	(OFST-35,sp),x
3422                     ; 587 uint8_t k = 0;
3424                     ; 590 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
3426  076a 0f25          	clr	(OFST+0,sp)
3427  076c               L5131:
3430  076c 96            	ldw	x,sp
3431  076d cd083f        	call	LC006
3432  0770 1b25          	add	a,(OFST+0,sp)
3433  0772 2401          	jrnc	L663
3434  0774 5c            	incw	x
3435  0775               L663:
3436  0775 02            	rlwa	x,a
3437  0776 7f            	clr	(x)
3440  0777 0c25          	inc	(OFST+0,sp)
3443  0779 7b25          	ld	a,(OFST+0,sp)
3444  077b a119          	cp	a,#25
3445  077d 25ed          	jrult	L5131
3446                     ; 593 RewritingChars(OutputFrame,0,12);
3448  077f 4b0c          	push	#12
3449  0781 4b00          	push	#0
3450  0783 96            	ldw	x,sp
3451  0784 1c000e        	addw	x,#OFST-23
3452  0787 cd013c        	call	_RewritingChars
3454  078a b605          	ld	a,_word+5
3455  078c 85            	popw	x
3456                     ; 597 temp4[0] = word[5];
3458  078d 6b08          	ld	(OFST-29,sp),a
3459                     ; 598 temp4[1] = word[6];
3461  078f b606          	ld	a,_word+6
3462  0791 6b09          	ld	(OFST-28,sp),a
3463                     ; 599 temp4[2] = word[7];
3465  0793 b607          	ld	a,_word+7
3466  0795 6b0a          	ld	(OFST-27,sp),a
3467                     ; 600 temp4[3] = word[8];
3469  0797 b608          	ld	a,_word+8
3470  0799 6b0b          	ld	(OFST-26,sp),a
3471                     ; 601 HexToByte_4(temp4, &Register);
3473  079b 96            	ldw	x,sp
3474  079c 1c0006        	addw	x,#OFST-31
3475  079f 89            	pushw	x
3476  07a0 1c0002        	addw	x,#2
3477  07a3 cd0295        	call	_HexToByte_4
3479  07a6 85            	popw	x
3480                     ; 602 if(Check_DataAddr_F06(Register) & Check_DataVal())
3482  07a7 cd0a43        	call	_Check_DataVal
3484  07aa 6b01          	ld	(OFST-36,sp),a
3485  07ac 1e06          	ldw	x,(OFST-31,sp)
3486  07ae cd0a89        	call	_Check_DataAddr_F06
3488  07b1 1401          	and	a,(OFST-36,sp)
3489  07b3 2603cc083c    	jreq	L3231
3490                     ; 605 	temp4[0] = word[9];
3492  07b8 b609          	ld	a,_word+9
3493  07ba 6b08          	ld	(OFST-29,sp),a
3494                     ; 606 	temp4[1] = word[10];
3496  07bc b60a          	ld	a,_word+10
3497  07be 6b09          	ld	(OFST-28,sp),a
3498                     ; 607 	temp4[2] = word[11];
3500  07c0 b60b          	ld	a,_word+11
3501  07c2 6b0a          	ld	(OFST-27,sp),a
3502                     ; 608 	temp4[3] = word[12];
3504  07c4 b60c          	ld	a,_word+12
3505  07c6 6b0b          	ld	(OFST-26,sp),a
3506                     ; 609 	HexToByte_4(temp4, &ValueToWrite);
3508  07c8 96            	ldw	x,sp
3509  07c9 1c0002        	addw	x,#OFST-35
3510  07cc 89            	pushw	x
3511  07cd 1c0006        	addw	x,#6
3512  07d0 cd0295        	call	_HexToByte_4
3514  07d3 85            	popw	x
3515                     ; 612 	Output_Registers[Register] = ValueToWrite;
3517  07d4 1e06          	ldw	x,(OFST-31,sp)
3518  07d6 58            	sllw	x
3519  07d7 1602          	ldw	y,(OFST-35,sp)
3520  07d9 ef00          	ldw	(_Output_Registers,x),y
3521                     ; 615 	k = 13;
3523  07db a60d          	ld	a,#13
3524  07dd 6b25          	ld	(OFST+0,sp),a
3525                     ; 616 	ByteToHex(temp2,GetLRC(OutputFrame));
3527  07df 96            	ldw	x,sp
3528  07e0 1c000c        	addw	x,#OFST-25
3529  07e3 cd0264        	call	_GetLRC
3531  07e6 88            	push	a
3532  07e7 96            	ldw	x,sp
3533  07e8 1c0005        	addw	x,#OFST-32
3534  07eb cd00a7        	call	_ByteToHex
3536  07ee 84            	pop	a
3537                     ; 617 	OutputFrame[k] = temp2[0];
3539  07ef 96            	ldw	x,sp
3540  07f0 ad4d          	call	LC006
3541  07f2 1b25          	add	a,(OFST+0,sp)
3542  07f4 2401          	jrnc	L604
3543  07f6 5c            	incw	x
3544  07f7               L604:
3545  07f7 02            	rlwa	x,a
3546  07f8 7b04          	ld	a,(OFST-33,sp)
3547  07fa f7            	ld	(x),a
3548                     ; 618 	k++;
3550                     ; 619 	OutputFrame[k] = temp2[1];
3552  07fb 96            	ldw	x,sp
3553  07fc 0c25          	inc	(OFST+0,sp)
3554  07fe ad3f          	call	LC006
3555  0800 1b25          	add	a,(OFST+0,sp)
3556  0802 2401          	jrnc	L014
3557  0804 5c            	incw	x
3558  0805               L014:
3559  0805 02            	rlwa	x,a
3560  0806 7b05          	ld	a,(OFST-32,sp)
3561  0808 f7            	ld	(x),a
3562                     ; 620 	k++;
3564                     ; 621 	OutputFrame[k] = 0x0D;
3566  0809 96            	ldw	x,sp
3567  080a 0c25          	inc	(OFST+0,sp)
3568  080c ad31          	call	LC006
3569  080e 1b25          	add	a,(OFST+0,sp)
3570  0810 2401          	jrnc	L214
3571  0812 5c            	incw	x
3572  0813               L214:
3573  0813 02            	rlwa	x,a
3574  0814 a60d          	ld	a,#13
3575  0816 f7            	ld	(x),a
3576                     ; 622 	k++;
3578                     ; 623 	OutputFrame[k] = 0x0A;
3580  0817 96            	ldw	x,sp
3581  0818 0c25          	inc	(OFST+0,sp)
3582  081a ad23          	call	LC006
3583  081c 1b25          	add	a,(OFST+0,sp)
3584  081e 2401          	jrnc	L414
3585  0820 5c            	incw	x
3586  0821               L414:
3587  0821 02            	rlwa	x,a
3588  0822 a60a          	ld	a,#10
3589  0824 f7            	ld	(x),a
3590                     ; 624 	k++;
3592                     ; 625 	OutputFrame[k] = 0x0A;
3594  0825 96            	ldw	x,sp
3595  0826 0c25          	inc	(OFST+0,sp)
3596  0828 ad15          	call	LC006
3597  082a 1b25          	add	a,(OFST+0,sp)
3598  082c 2401          	jrnc	L614
3599  082e 5c            	incw	x
3600  082f               L614:
3601  082f 02            	rlwa	x,a
3602  0830 a60a          	ld	a,#10
3603  0832 f7            	ld	(x),a
3604                     ; 626 	k++;
3606                     ; 629 	UART_SendStr(OutputFrame); 
3608  0833 96            	ldw	x,sp
3609  0834 0c25          	inc	(OFST+0,sp)
3610  0836 1c000c        	addw	x,#OFST-25
3611  0839 cd0000        	call	_UART_SendStr
3613  083c               L3231:
3614                     ; 631 }
3617  083c 5b25          	addw	sp,#37
3618  083e 81            	ret	
3619  083f               LC006:
3620  083f 1c000c        	addw	x,#OFST-25
3621  0842 9f            	ld	a,xl
3622  0843 5e            	swapw	x
3623  0844 81            	ret	
3743                     ; 635 void ForceMultipleRegisters()
3743                     ; 636 {
3744                     	switch	.text
3745  0845               _ForceMultipleRegisters:
3747  0845 522a          	subw	sp,#42
3748       0000002a      OFST:	set	42
3751                     ; 638 uint8_t counter = 0;
3753                     ; 639 uint16_t Value=0;
3755  0847 5f            	clrw	x
3756  0848 1f07          	ldw	(OFST-35,sp),x
3757                     ; 646 uint16_t n = 0;
3759                     ; 649 for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}
3761  084a 1f24          	ldw	(OFST-6,sp),x
3762  084c               L3041:
3765  084c 96            	ldw	x,sp
3766  084d 1c000b        	addw	x,#OFST-31
3767  0850 72fb24        	addw	x,(OFST-6,sp)
3768  0853 7f            	clr	(x)
3771  0854 1e24          	ldw	x,(OFST-6,sp)
3772  0856 5c            	incw	x
3773  0857 1f24          	ldw	(OFST-6,sp),x
3776  0859 a30019        	cpw	x,#25
3777  085c 25ee          	jrult	L3041
3778                     ; 652 RewritingChars(OutputFrame,0,12);
3780  085e 4b0c          	push	#12
3781  0860 4b00          	push	#0
3782  0862 96            	ldw	x,sp
3783  0863 1c000d        	addw	x,#OFST-29
3784  0866 cd013c        	call	_RewritingChars
3786  0869 b605          	ld	a,_word+5
3787  086b 85            	popw	x
3788                     ; 655 temp4[0] = word[5];
3790  086c 6b26          	ld	(OFST-4,sp),a
3791                     ; 656 temp4[1] = word[6];
3793  086e b606          	ld	a,_word+6
3794  0870 6b27          	ld	(OFST-3,sp),a
3795                     ; 657 temp4[2] = word[7];
3797  0872 b607          	ld	a,_word+7
3798  0874 6b28          	ld	(OFST-2,sp),a
3799                     ; 658 temp4[3] = word[8];
3801  0876 b608          	ld	a,_word+8
3802  0878 6b29          	ld	(OFST-1,sp),a
3803                     ; 659 HexToByte_4(temp4, &FirstRegister);
3805  087a 96            	ldw	x,sp
3806  087b 1c0004        	addw	x,#OFST-38
3807  087e 89            	pushw	x
3808  087f 1c0022        	addw	x,#34
3809  0882 cd0295        	call	_HexToByte_4
3811  0885 b609          	ld	a,_word+9
3812  0887 85            	popw	x
3813                     ; 662 temp4[0] = word[9];
3815  0888 6b26          	ld	(OFST-4,sp),a
3816                     ; 663 temp4[1] = word[10];
3818  088a b60a          	ld	a,_word+10
3819  088c 6b27          	ld	(OFST-3,sp),a
3820                     ; 664 temp4[2] = word[11];
3822  088e b60b          	ld	a,_word+11
3823  0890 6b28          	ld	(OFST-2,sp),a
3824                     ; 665 temp4[3] = word[12];
3826  0892 b60c          	ld	a,_word+12
3827  0894 6b29          	ld	(OFST-1,sp),a
3828                     ; 666 HexToByte_4(temp4, &NumberOfRegs);
3830  0896 96            	ldw	x,sp
3831  0897 1c0002        	addw	x,#OFST-40
3832  089a 89            	pushw	x
3833  089b 1c0024        	addw	x,#36
3834  089e cd0295        	call	_HexToByte_4
3836  08a1 b60d          	ld	a,_word+13
3837  08a3 85            	popw	x
3838                     ; 669 temp[0] = word[13];
3840  08a4 6b09          	ld	(OFST-33,sp),a
3841                     ; 670 temp[1] = word[14];
3843  08a6 b60e          	ld	a,_word+14
3844  08a8 6b0a          	ld	(OFST-32,sp),a
3845                     ; 671 HexToByte(temp, &NumberOfDataBytes);
3847  08aa 96            	ldw	x,sp
3848  08ab 1c0006        	addw	x,#OFST-36
3849  08ae 89            	pushw	x
3850  08af 1c0003        	addw	x,#3
3851  08b2 cd00df        	call	_HexToByte
3853  08b5 85            	popw	x
3854                     ; 672 if(Check_DataAddr_F03_F04(FirstRegister, NumberOfRegs) & Check_DataVal_F16(NumberOfDataBytes))
3856  08b6 7b06          	ld	a,(OFST-36,sp)
3857  08b8 5f            	clrw	x
3858  08b9 97            	ld	xl,a
3859  08ba cd0a96        	call	_Check_DataVal_F16
3861  08bd 6b01          	ld	(OFST-41,sp),a
3862  08bf 1e02          	ldw	x,(OFST-40,sp)
3863  08c1 89            	pushw	x
3864  08c2 1e06          	ldw	x,(OFST-36,sp)
3865  08c4 cd0a51        	call	_Check_DataAddr_F03_F04
3867  08c7 85            	popw	x
3868  08c8 1401          	and	a,(OFST-41,sp)
3869  08ca 2603cc0983    	jreq	L1141
3870                     ; 675 	counter=15;
3872  08cf a60f          	ld	a,#15
3873  08d1 6b2a          	ld	(OFST+0,sp),a
3874                     ; 676 	for(n=0; n<(NumberOfDataBytes/2); n++)
3876  08d3 5f            	clrw	x
3878  08d4 2041          	jra	L7141
3879  08d6               L3141:
3880                     ; 678 		temp4[0] = word[counter];
3882  08d6 7b2a          	ld	a,(OFST+0,sp)
3883  08d8 5f            	clrw	x
3884  08d9 97            	ld	xl,a
3885  08da e600          	ld	a,(_word,x)
3886  08dc 6b26          	ld	(OFST-4,sp),a
3887                     ; 679 		counter++;
3889  08de 0c2a          	inc	(OFST+0,sp)
3890                     ; 680 		temp4[1] = word[counter];
3892  08e0 5f            	clrw	x
3893  08e1 7b2a          	ld	a,(OFST+0,sp)
3894  08e3 97            	ld	xl,a
3895  08e4 e600          	ld	a,(_word,x)
3896  08e6 6b27          	ld	(OFST-3,sp),a
3897                     ; 681 		counter++;
3899  08e8 0c2a          	inc	(OFST+0,sp)
3900                     ; 682 		temp4[2] = word[counter];
3902  08ea 5f            	clrw	x
3903  08eb 7b2a          	ld	a,(OFST+0,sp)
3904  08ed 97            	ld	xl,a
3905  08ee e600          	ld	a,(_word,x)
3906  08f0 6b28          	ld	(OFST-2,sp),a
3907                     ; 683 		counter++;
3909  08f2 0c2a          	inc	(OFST+0,sp)
3910                     ; 684 		temp4[3] = word[counter];		
3912  08f4 5f            	clrw	x
3913  08f5 7b2a          	ld	a,(OFST+0,sp)
3914  08f7 97            	ld	xl,a
3915  08f8 e600          	ld	a,(_word,x)
3916  08fa 6b29          	ld	(OFST-1,sp),a
3917                     ; 685 		counter++;
3919                     ; 687 		HexToByte_4(temp4, &Value);
3921  08fc 96            	ldw	x,sp
3922  08fd 0c2a          	inc	(OFST+0,sp)
3923  08ff 1c0007        	addw	x,#OFST-35
3924  0902 89            	pushw	x
3925  0903 1c001f        	addw	x,#31
3926  0906 cd0295        	call	_HexToByte_4
3928  0909 85            	popw	x
3929                     ; 688 		Output_Registers[FirstRegister+n] = Value;
3931  090a 1e04          	ldw	x,(OFST-38,sp)
3932  090c 72fb24        	addw	x,(OFST-6,sp)
3933  090f 58            	sllw	x
3934  0910 1607          	ldw	y,(OFST-35,sp)
3935  0912 ef00          	ldw	(_Output_Registers,x),y
3936                     ; 676 	for(n=0; n<(NumberOfDataBytes/2); n++)
3938  0914 1e24          	ldw	x,(OFST-6,sp)
3939  0916 5c            	incw	x
3940  0917               L7141:
3941  0917 1f24          	ldw	(OFST-6,sp),x
3944  0919 5f            	clrw	x
3945  091a 7b06          	ld	a,(OFST-36,sp)
3946  091c 97            	ld	xl,a
3947  091d 57            	sraw	x
3948  091e 1324          	cpw	x,(OFST-6,sp)
3949  0920 22b4          	jrugt	L3141
3950                     ; 692 	counter = 13;
3952  0922 a60d          	ld	a,#13
3953  0924 6b2a          	ld	(OFST+0,sp),a
3954                     ; 693 	ByteToHex(temp,GetLRC(OutputFrame));
3956  0926 96            	ldw	x,sp
3957  0927 1c000b        	addw	x,#OFST-31
3958  092a cd0264        	call	_GetLRC
3960  092d 88            	push	a
3961  092e 96            	ldw	x,sp
3962  092f 1c000a        	addw	x,#OFST-32
3963  0932 cd00a7        	call	_ByteToHex
3965  0935 84            	pop	a
3966                     ; 694 	OutputFrame[counter] = temp[0];
3968  0936 96            	ldw	x,sp
3969  0937 ad4d          	call	LC007
3970  0939 1b2a          	add	a,(OFST+0,sp)
3971  093b 2401          	jrnc	L644
3972  093d 5c            	incw	x
3973  093e               L644:
3974  093e 02            	rlwa	x,a
3975  093f 7b09          	ld	a,(OFST-33,sp)
3976  0941 f7            	ld	(x),a
3977                     ; 695 	counter++;
3979                     ; 696 	OutputFrame[counter] = temp[1];
3981  0942 96            	ldw	x,sp
3982  0943 0c2a          	inc	(OFST+0,sp)
3983  0945 ad3f          	call	LC007
3984  0947 1b2a          	add	a,(OFST+0,sp)
3985  0949 2401          	jrnc	L054
3986  094b 5c            	incw	x
3987  094c               L054:
3988  094c 02            	rlwa	x,a
3989  094d 7b0a          	ld	a,(OFST-32,sp)
3990  094f f7            	ld	(x),a
3991                     ; 697 	counter++;
3993                     ; 698 	OutputFrame[counter] = 0x0D;
3995  0950 96            	ldw	x,sp
3996  0951 0c2a          	inc	(OFST+0,sp)
3997  0953 ad31          	call	LC007
3998  0955 1b2a          	add	a,(OFST+0,sp)
3999  0957 2401          	jrnc	L254
4000  0959 5c            	incw	x
4001  095a               L254:
4002  095a 02            	rlwa	x,a
4003  095b a60d          	ld	a,#13
4004  095d f7            	ld	(x),a
4005                     ; 699 	counter++;
4007                     ; 700 	OutputFrame[counter] = 0x0A;
4009  095e 96            	ldw	x,sp
4010  095f 0c2a          	inc	(OFST+0,sp)
4011  0961 ad23          	call	LC007
4012  0963 1b2a          	add	a,(OFST+0,sp)
4013  0965 2401          	jrnc	L454
4014  0967 5c            	incw	x
4015  0968               L454:
4016  0968 02            	rlwa	x,a
4017  0969 a60a          	ld	a,#10
4018  096b f7            	ld	(x),a
4019                     ; 701 	counter++;
4021                     ; 702 	OutputFrame[counter] = 0x0A;
4023  096c 96            	ldw	x,sp
4024  096d 0c2a          	inc	(OFST+0,sp)
4025  096f ad15          	call	LC007
4026  0971 1b2a          	add	a,(OFST+0,sp)
4027  0973 2401          	jrnc	L654
4028  0975 5c            	incw	x
4029  0976               L654:
4030  0976 02            	rlwa	x,a
4031  0977 a60a          	ld	a,#10
4032  0979 f7            	ld	(x),a
4033                     ; 703 	counter++;
4035                     ; 706 	UART_SendStr(OutputFrame); 
4037  097a 96            	ldw	x,sp
4038  097b 0c2a          	inc	(OFST+0,sp)
4039  097d 1c000b        	addw	x,#OFST-31
4040  0980 cd0000        	call	_UART_SendStr
4042  0983               L1141:
4043                     ; 708 }
4046  0983 5b2a          	addw	sp,#42
4047  0985 81            	ret	
4048  0986               LC007:
4049  0986 1c000b        	addw	x,#OFST-31
4050  0989 9f            	ld	a,xl
4051  098a 5e            	swapw	x
4052  098b 81            	ret	
4139                     ; 718 void ErrorMessage(uint8_t ErrorCode)
4139                     ; 719 {
4140                     	switch	.text
4141  098c               _ErrorMessage:
4143  098c 88            	push	a
4144  098d 521d          	subw	sp,#29
4145       0000001d      OFST:	set	29
4148                     ; 727 for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}
4150  098f 0f04          	clr	(OFST-25,sp)
4151  0991               L5641:
4154  0991 96            	ldw	x,sp
4155  0992 1c0005        	addw	x,#OFST-24
4156  0995 9f            	ld	a,xl
4157  0996 5e            	swapw	x
4158  0997 1b04          	add	a,(OFST-25,sp)
4159  0999 2401          	jrnc	L464
4160  099b 5c            	incw	x
4161  099c               L464:
4162  099c 02            	rlwa	x,a
4163  099d 7f            	clr	(x)
4166  099e 0c04          	inc	(OFST-25,sp)
4169  09a0 7b04          	ld	a,(OFST-25,sp)
4170  09a2 a119          	cp	a,#25
4171  09a4 25eb          	jrult	L5641
4172                     ; 730 RewritingChars(OutputFrame,0,2);
4174  09a6 4b02          	push	#2
4175  09a8 4b00          	push	#0
4176  09aa 96            	ldw	x,sp
4177  09ab 1c0007        	addw	x,#OFST-22
4178  09ae cd013c        	call	_RewritingChars
4180  09b1 b603          	ld	a,_word+3
4181  09b3 85            	popw	x
4182                     ; 733 temp[0] = word[3];
4184  09b4 6b02          	ld	(OFST-27,sp),a
4185                     ; 734 temp[1] = word[4];
4187  09b6 b604          	ld	a,_word+4
4188  09b8 6b03          	ld	(OFST-26,sp),a
4189                     ; 735 HexToByte(temp, &FunC);
4191  09ba 96            	ldw	x,sp
4192  09bb 5c            	incw	x
4193  09bc 89            	pushw	x
4194  09bd 5c            	incw	x
4195  09be cd00df        	call	_HexToByte
4197  09c1 85            	popw	x
4198                     ; 738 ErrFuncCode = FunC + 80;
4200  09c2 7b01          	ld	a,(OFST-28,sp)
4201  09c4 ab50          	add	a,#80
4202  09c6 6b04          	ld	(OFST-25,sp),a
4203                     ; 739 ByteToHex(temp,ErrFuncCode);
4205  09c8 88            	push	a
4206  09c9 96            	ldw	x,sp
4207  09ca 1c0003        	addw	x,#OFST-26
4208  09cd cd00a7        	call	_ByteToHex
4210  09d0 84            	pop	a
4211                     ; 740 OutputFrame[3] = temp[0];
4213  09d1 7b02          	ld	a,(OFST-27,sp)
4214  09d3 6b08          	ld	(OFST-21,sp),a
4215                     ; 741 OutputFrame[4] = temp[1];
4217  09d5 7b03          	ld	a,(OFST-26,sp)
4218  09d7 6b09          	ld	(OFST-20,sp),a
4219                     ; 744 ByteToHex(temp,ErrorCode);
4221  09d9 7b1e          	ld	a,(OFST+1,sp)
4222  09db 88            	push	a
4223  09dc 96            	ldw	x,sp
4224  09dd 1c0003        	addw	x,#OFST-26
4225  09e0 cd00a7        	call	_ByteToHex
4227  09e3 84            	pop	a
4228                     ; 745 OutputFrame[5] = temp[0];
4230  09e4 7b02          	ld	a,(OFST-27,sp)
4231  09e6 6b0a          	ld	(OFST-19,sp),a
4232                     ; 746 OutputFrame[6] = temp[1];
4234  09e8 7b03          	ld	a,(OFST-26,sp)
4235  09ea 6b0b          	ld	(OFST-18,sp),a
4236                     ; 749 ByteToHex(temp,GetLRC(OutputFrame));
4238  09ec 96            	ldw	x,sp
4239  09ed 1c0005        	addw	x,#OFST-24
4240  09f0 cd0264        	call	_GetLRC
4242  09f3 88            	push	a
4243  09f4 96            	ldw	x,sp
4244  09f5 1c0003        	addw	x,#OFST-26
4245  09f8 cd00a7        	call	_ByteToHex
4247  09fb 84            	pop	a
4248                     ; 750 OutputFrame[7] = temp[0];
4250  09fc 7b02          	ld	a,(OFST-27,sp)
4251  09fe 6b0c          	ld	(OFST-17,sp),a
4252                     ; 751 OutputFrame[8] = temp[1];
4254  0a00 7b03          	ld	a,(OFST-26,sp)
4255  0a02 6b0d          	ld	(OFST-16,sp),a
4256                     ; 752 OutputFrame[9] = 0x0D;
4258  0a04 a60d          	ld	a,#13
4259  0a06 6b0e          	ld	(OFST-15,sp),a
4260                     ; 753 OutputFrame[10] = 0x0A;
4262  0a08 a60a          	ld	a,#10
4263  0a0a 6b0f          	ld	(OFST-14,sp),a
4264                     ; 754 OutputFrame[11] = 0x0A;
4266  0a0c 6b10          	ld	(OFST-13,sp),a
4267                     ; 757 UART_SendStr(OutputFrame); 
4269  0a0e 96            	ldw	x,sp
4270  0a0f 1c0005        	addw	x,#OFST-24
4271  0a12 cd0000        	call	_UART_SendStr
4273                     ; 758 }
4276  0a15 5b1e          	addw	sp,#30
4277  0a17 81            	ret	
4340                     .const:	section	.text
4341  0000               L605:
4342  0000 000000a1      	dc.l	161
4343                     ; 762 uint8_t Check_DataAddr_F01_F02(uint16_t FirstCoil, uint16_t NumOfCoils)
4343                     ; 763 {
4344                     	switch	.text
4345  0a18               _Check_DataAddr_F01_F02:
4347  0a18 89            	pushw	x
4348  0a19 5208          	subw	sp,#8
4349       00000008      OFST:	set	8
4352                     ; 768 	MaxCoils = REGSIZE*16;
4354                     ; 770 	LastCoil = FirstCoil + NumOfCoils;
4356  0a1b 72fb0d        	addw	x,(OFST+5,sp)
4357  0a1e cd0000        	call	c_uitolx
4359  0a21 96            	ldw	x,sp
4360  0a22 1c0005        	addw	x,#OFST-3
4361  0a25 cd0000        	call	c_rtol
4363                     ; 772 	if(LastCoil <= MaxCoils)
4365  0a28 96            	ldw	x,sp
4366  0a29 1c0005        	addw	x,#OFST-3
4367  0a2c cd0000        	call	c_ltor
4369  0a2f ae0000        	ldw	x,#L605
4370  0a32 cd0000        	call	c_lcmp
4372  0a35 2404          	jruge	L5251
4373                     ; 774 		return 1;
4375  0a37 a601          	ld	a,#1
4377  0a39 2005          	jra	L215
4378  0a3b               L5251:
4379                     ; 778 	ErrorMessage(ILLEGAL_DATA_ADDR);
4381  0a3b a602          	ld	a,#2
4382  0a3d cd098c        	call	_ErrorMessage
4384                     ; 780 }
4385  0a40               L215:
4388  0a40 5b0a          	addw	sp,#10
4389  0a42 81            	ret	
4414                     ; 783 uint8_t Check_DataVal()
4414                     ; 784 {
4415                     	switch	.text
4416  0a43               _Check_DataVal:
4420                     ; 786 	if(BYTES == 16)
4422  0a43 b600          	ld	a,_BYTES
4423  0a45 a110          	cp	a,#16
4424  0a47 2603          	jrne	L1451
4425                     ; 788 		return 1;
4427  0a49 a601          	ld	a,#1
4430  0a4b 81            	ret	
4431  0a4c               L1451:
4432                     ; 792 	ErrorMessage(ILLEGAL_DATA_VAL);	
4434  0a4c a603          	ld	a,#3
4436                     ; 794 }
4439  0a4e cc098c        	jp	_ErrorMessage
4493                     	switch	.const
4494  0004               L225:
4495  0004 0000000b      	dc.l	11
4496                     ; 797 uint8_t Check_DataAddr_F03_F04(uint16_t FirstReg, uint16_t NumofRegs)
4496                     ; 798 {
4497                     	switch	.text
4498  0a51               _Check_DataAddr_F03_F04:
4500  0a51 89            	pushw	x
4501  0a52 5204          	subw	sp,#4
4502       00000004      OFST:	set	4
4505                     ; 799 	uint32_t LastRegister = FirstReg + NumofRegs;
4507  0a54 72fb09        	addw	x,(OFST+5,sp)
4508  0a57 cd0000        	call	c_uitolx
4510  0a5a 96            	ldw	x,sp
4511  0a5b 5c            	incw	x
4512  0a5c cd0000        	call	c_rtol
4514                     ; 800 	if(LastRegister <= REGSIZE)
4516  0a5f 96            	ldw	x,sp
4517  0a60 5c            	incw	x
4518  0a61 cd0000        	call	c_ltor
4520  0a64 ae0004        	ldw	x,#L225
4521  0a67 cd0000        	call	c_lcmp
4523  0a6a 2404          	jruge	L3751
4524                     ; 802 		return 1;
4526  0a6c a601          	ld	a,#1
4528  0a6e 2005          	jra	L625
4529  0a70               L3751:
4530                     ; 806 		ErrorMessage(ILLEGAL_DATA_ADDR);
4532  0a70 a602          	ld	a,#2
4533  0a72 cd098c        	call	_ErrorMessage
4535                     ; 808 }
4536  0a75               L625:
4539  0a75 5b06          	addw	sp,#6
4540  0a77 81            	ret	
4584                     ; 811 uint8_t Check_DataAddr_F05(uint16_t Coil)
4584                     ; 812 {
4585                     	switch	.text
4586  0a78               _Check_DataAddr_F05:
4588  0a78 89            	pushw	x
4589       00000002      OFST:	set	2
4592                     ; 814 	uint16_t MaxCoil = REGSIZE*16;
4594                     ; 815 	if(Coil <= MaxCoil)
4596  0a79 a300a1        	cpw	x,#161
4597  0a7c 2404          	jruge	L1261
4598                     ; 817 		return 1;
4600  0a7e a601          	ld	a,#1
4602  0a80 2005          	jra	L435
4603  0a82               L1261:
4604                     ; 821 		ErrorMessage(ILLEGAL_DATA_ADDR);
4606  0a82 a602          	ld	a,#2
4607  0a84 cd098c        	call	_ErrorMessage
4609                     ; 824 }
4610  0a87               L435:
4613  0a87 85            	popw	x
4614  0a88 81            	ret	
4649                     ; 827 uint8_t Check_DataAddr_F06(uint16_t Register)
4649                     ; 828 {
4650                     	switch	.text
4651  0a89               _Check_DataAddr_F06:
4655                     ; 829 	if(Register <= REGSIZE)
4657  0a89 a3000b        	cpw	x,#11
4658  0a8c 2403          	jruge	L3461
4659                     ; 831 		return 1;
4661  0a8e a601          	ld	a,#1
4664  0a90 81            	ret	
4665  0a91               L3461:
4666                     ; 835 		ErrorMessage(ILLEGAL_DATA_ADDR);
4668  0a91 a602          	ld	a,#2
4670                     ; 837 }
4673  0a93 cc098c        	jp	_ErrorMessage
4718                     ; 840 uint8_t Check_DataVal_F16(uint16_t Databytes)
4718                     ; 841 {
4719                     	switch	.text
4720  0a96               _Check_DataVal_F16:
4722  0a96 89            	pushw	x
4723       00000002      OFST:	set	2
4726                     ; 843 	BytesInQuerry = 18+2*Databytes;
4728  0a97 58            	sllw	x
4729  0a98 1c0012        	addw	x,#18
4730  0a9b 1f01          	ldw	(OFST-1,sp),x
4731                     ; 845 	if(BYTES == BytesInQuerry)
4733  0a9d 5f            	clrw	x
4734  0a9e b600          	ld	a,_BYTES
4735  0aa0 97            	ld	xl,a
4736  0aa1 1301          	cpw	x,(OFST-1,sp)
4737  0aa3 2604          	jrne	L1761
4738                     ; 847 		return 1;
4740  0aa5 a601          	ld	a,#1
4742  0aa7 2005          	jra	L645
4743  0aa9               L1761:
4744                     ; 851 	ErrorMessage(ILLEGAL_DATA_VAL);	
4746  0aa9 a603          	ld	a,#3
4747  0aab cd098c        	call	_ErrorMessage
4749                     ; 853 }
4750  0aae               L645:
4753  0aae 85            	popw	x
4754  0aaf 81            	ret	
4789                     ; 857 uint8_t __checkFunc(uint8_t Function_Number)
4789                     ; 858 {
4790                     	switch	.text
4791  0ab0               ___checkFunc:
4795                     ; 859 	if(Function_Number == 1 || Function_Number == 2 || Function_Number == 3 || Function_Number == 4 || Function_Number == 5 || Function_Number == 6 || Function_Number == 16)
4797  0ab0 a101          	cp	a,#1
4798  0ab2 2718          	jreq	L5171
4800  0ab4 a102          	cp	a,#2
4801  0ab6 2714          	jreq	L5171
4803  0ab8 a103          	cp	a,#3
4804  0aba 2710          	jreq	L5171
4806  0abc a104          	cp	a,#4
4807  0abe 270c          	jreq	L5171
4809  0ac0 a105          	cp	a,#5
4810  0ac2 2708          	jreq	L5171
4812  0ac4 a106          	cp	a,#6
4813  0ac6 2704          	jreq	L5171
4815  0ac8 a110          	cp	a,#16
4816  0aca 2603          	jrne	L3171
4817  0acc               L5171:
4818                     ; 861 		return 1;
4820  0acc a601          	ld	a,#1
4823  0ace 81            	ret	
4824  0acf               L3171:
4825                     ; 865 		ErrorMessage(ILLEGAL_FUNCTION);
4827  0acf a601          	ld	a,#1
4828  0ad1 cd098c        	call	_ErrorMessage
4830                     ; 866 		return 0;
4832  0ad4 4f            	clr	a
4835  0ad5 81            	ret	
4848                     	xref.b	_Output_Registers
4849                     	xref.b	_Input_Registers
4850                     	xref.b	_BYTES
4851                     	xref.b	_word
4852                     	xref.b	_Address
4853                     	xref.b	_TimmingDelay
4854                     	xdef	___checkFunc
4855                     	xdef	___checkAddr
4856                     	xdef	_Check_DataVal_F16
4857                     	xdef	_Check_DataVal
4858                     	xdef	_Check_DataAddr_F06
4859                     	xdef	_Check_DataAddr_F05
4860                     	xdef	_Check_DataAddr_F03_F04
4861                     	xdef	_Check_DataAddr_F01_F02
4862                     	xdef	_ErrorMessage
4863                     	xdef	_SetSingleCoil
4864                     	xdef	_StateOfCoil
4865                     	xdef	_RewritingChars
4866                     	xdef	_ForceMultipleRegisters
4867                     	xdef	_PresetSingleRegister
4868                     	xdef	_ForceSingleCoil
4869                     	xdef	_ReadInputRegisters
4870                     	xdef	_ReadHoldingRegisters
4871                     	xdef	_ReadInputStatus
4872                     	xdef	_ReadCoilStatus
4873                     	xdef	_ByteToHex_4
4874                     	xdef	_GetLRC
4875                     	xdef	_CheckLRC
4876                     	xdef	_SetDevAddr
4877                     	xdef	_HexToByte_4
4878                     	xdef	_HexToByte
4879                     	xdef	_ByteToHex
4880                     	xdef	_UART_SendStr
4881                     	xdef	_Modbus_Init
4882                     	xdef	_Delay
4883                     	xdef	_Delay_Init
4884                     	xref	_UART2_SendData8
4885                     	xref	_UART2_ITConfig
4886                     	xref	_UART2_Cmd
4887                     	xref	_UART2_Init
4888                     	xref	_UART2_DeInit
4889                     	xref	_TIM3_ITConfig
4890                     	xref	_TIM3_Cmd
4891                     	xref	_TIM3_TimeBaseInit
4892                     	xref	_TIM3_DeInit
4893                     	xref	_TIM2_ITConfig
4894                     	xref	_TIM2_Cmd
4895                     	xref	_TIM2_TimeBaseInit
4896                     	xref	_TIM2_DeInit
4897                     	xref	_GPIO_WriteLow
4898                     	xref	_GPIO_WriteHigh
4899                     	xref	_GPIO_Init
4900                     	xref	_GPIO_DeInit
4901                     	xref	_CLK_HSIPrescalerConfig
4920                     	xref	c_lcmp
4921                     	xref	c_ltor
4922                     	xref	c_rtol
4923                     	xref	c_uitolx
4924                     	xref	c_lzmp
4925                     	end
