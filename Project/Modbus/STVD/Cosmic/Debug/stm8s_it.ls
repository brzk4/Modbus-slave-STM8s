   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     	bsct
  20  0000               _STATUS_BIT:
  21  0000 00            	dc.b	0
  51                     ; 76 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 77 {
  52                     	switch	.text
  53  0000               f_NonHandledInterrupt:
  57                     ; 81 }
  60  0000 80            	iret	
  82                     ; 89 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 90 {
  83                     	switch	.text
  84  0001               f_TRAP_IRQHandler:
  88                     ; 94 }
  91  0001 80            	iret	
 113                     ; 100 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 101 {
 114                     	switch	.text
 115  0002               f_TLI_IRQHandler:
 119                     ; 105 }
 122  0002 80            	iret	
 144                     ; 112 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 113 {
 145                     	switch	.text
 146  0003               f_AWU_IRQHandler:
 150                     ; 117 }
 153  0003 80            	iret	
 175                     ; 124 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 125 {
 176                     	switch	.text
 177  0004               f_CLK_IRQHandler:
 181                     ; 129 }
 184  0004 80            	iret	
 207                     ; 136 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 137 {
 208                     	switch	.text
 209  0005               f_EXTI_PORTA_IRQHandler:
 213                     ; 141 }
 216  0005 80            	iret	
 239                     ; 148 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 149 {
 240                     	switch	.text
 241  0006               f_EXTI_PORTB_IRQHandler:
 245                     ; 153 }
 248  0006 80            	iret	
 271                     ; 160 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 161 {
 272                     	switch	.text
 273  0007               f_EXTI_PORTC_IRQHandler:
 277                     ; 165 }
 280  0007 80            	iret	
 303                     ; 172 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 173 {
 304                     	switch	.text
 305  0008               f_EXTI_PORTD_IRQHandler:
 309                     ; 177 }
 312  0008 80            	iret	
 335                     ; 184 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 185 {
 336                     	switch	.text
 337  0009               f_EXTI_PORTE_IRQHandler:
 341                     ; 189 }
 344  0009 80            	iret	
 366                     ; 235 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 366                     ; 236 {
 367                     	switch	.text
 368  000a               f_SPI_IRQHandler:
 372                     ; 240 }
 375  000a 80            	iret	
 398                     ; 247 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 248 {
 399                     	switch	.text
 400  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 404                     ; 252 }
 407  000b 80            	iret	
 430                     ; 259 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 430                     ; 260 {
 431                     	switch	.text
 432  000c               f_TIM1_CAP_COM_IRQHandler:
 436                     ; 264 }
 439  000c 80            	iret	
 505                     ; 298  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 505                     ; 299 {
 506                     	switch	.text
 507  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 509  000d 8a            	push	cc
 510  000e 84            	pop	a
 511  000f a4bf          	and	a,#191
 512  0011 88            	push	a
 513  0012 86            	pop	cc
 514       00000004      OFST:	set	4
 515  0013 3b0002        	push	c_x+2
 516  0016 be00          	ldw	x,c_x
 517  0018 89            	pushw	x
 518  0019 3b0002        	push	c_y+2
 519  001c be00          	ldw	x,c_y
 520  001e 89            	pushw	x
 521  001f 5204          	subw	sp,#4
 524                     ; 304 	if(word[0] != '\0')
 526  0021 b62f          	ld	a,_word
 527  0023 2775          	jreq	L722
 528                     ; 306 		if (CheckLRC(word))
 530  0025 ae002f        	ldw	x,#_word
 531  0028 cd0000        	call	_CheckLRC
 533  002b 4d            	tnz	a
 534  002c 275d          	jreq	L132
 535                     ; 309 		tmp[0] = word[3];
 537  002e b632          	ld	a,_word+3
 538  0030 6b01          	ld	(OFST-3,sp),a
 539                     ; 310 		tmp[1] = word[4];
 541  0032 b633          	ld	a,_word+4
 542  0034 6b02          	ld	(OFST-2,sp),a
 543                     ; 311 		HexToByte(tmp, &FunC);
 545  0036 96            	ldw	x,sp
 546  0037 1c0003        	addw	x,#OFST-1
 547  003a 89            	pushw	x
 548  003b 1d0002        	subw	x,#2
 549  003e cd0000        	call	_HexToByte
 551  0041 85            	popw	x
 552                     ; 313 		if(__checkFunc(FunC))
 554  0042 7b03          	ld	a,(OFST-1,sp)
 555  0044 cd0000        	call	___checkFunc
 557  0047 4d            	tnz	a
 558  0048 2741          	jreq	L132
 559                     ; 316 			switch (FunC) 
 561  004a 7b03          	ld	a,(OFST-1,sp)
 563                     ; 354 			default: 
 563                     ; 355 				break;
 564  004c 4a            	dec	a
 565  004d 2715          	jreq	L161
 566  004f 4a            	dec	a
 567  0050 271a          	jreq	L361
 568  0052 4a            	dec	a
 569  0053 271c          	jreq	L561
 570  0055 4a            	dec	a
 571  0056 2721          	jreq	L761
 572  0058 4a            	dec	a
 573  0059 2723          	jreq	L171
 574  005b 4a            	dec	a
 575  005c 2725          	jreq	L371
 576  005e a00a          	sub	a,#10
 577  0060 2726          	jreq	L571
 578  0062 2027          	jra	L132
 579  0064               L161:
 580                     ; 318 			case 1:
 580                     ; 319 				//Function 1
 580                     ; 320 				ReadCoilStatus(Output_Registers);
 582  0064 ae0004        	ldw	x,#_Output_Registers
 583  0067 cd0000        	call	_ReadCoilStatus
 585                     ; 321 				break;
 587  006a 201f          	jra	L132
 588  006c               L361:
 589                     ; 323 			case 2:
 589                     ; 324 				//Function 2
 589                     ; 325 				ReadInputStatus();
 591  006c cd0000        	call	_ReadInputStatus
 593                     ; 326 				break;
 595  006f 201a          	jra	L132
 596  0071               L561:
 597                     ; 328 			case 3: 
 597                     ; 329 				//Function 3
 597                     ; 330 				ReadHoldingRegisters(Output_Registers);
 599  0071 ae0004        	ldw	x,#_Output_Registers
 600  0074 cd0000        	call	_ReadHoldingRegisters
 602                     ; 331 				break;
 604  0077 2012          	jra	L132
 605  0079               L761:
 606                     ; 333 			case 4: 
 606                     ; 334 				//Function 4
 606                     ; 335 				ReadInputRegisters();				
 608  0079 cd0000        	call	_ReadInputRegisters
 610                     ; 336 				break;
 612  007c 200d          	jra	L132
 613  007e               L171:
 614                     ; 338 			case 5: 
 614                     ; 339 				//Function 5
 614                     ; 340 				ForceSingleCoil();
 616  007e cd0000        	call	_ForceSingleCoil
 618                     ; 341 				break;
 620  0081 2008          	jra	L132
 621  0083               L371:
 622                     ; 343 			case 6:
 622                     ; 344 				//Function 6
 622                     ; 345 				PresetSingleRegister();
 624  0083 cd0000        	call	_PresetSingleRegister
 626                     ; 346 				break;
 628  0086 2003          	jra	L132
 629  0088               L571:
 630                     ; 348 			case 16:
 630                     ; 349 				//Function 16
 630                     ; 350 				ForceMultipleRegisters();
 632  0088 cd0000        	call	_ForceMultipleRegisters
 634                     ; 351 				break;
 636                     ; 354 			default: 
 636                     ; 355 				break;
 638  008b               L132:
 639                     ; 359 		for(i = 0; i<BufforsSize; i++){word[i] = '\0';}
 641  008b 4f            	clr	a
 642  008c 6b04          	ld	(OFST+0,sp),a
 643  008e               L142:
 646  008e 5f            	clrw	x
 647  008f 97            	ld	xl,a
 648  0090 6f2f          	clr	(_word,x)
 651  0092 0c04          	inc	(OFST+0,sp)
 654  0094 7b04          	ld	a,(OFST+0,sp)
 655  0096 a12d          	cp	a,#45
 656  0098 25f4          	jrult	L142
 657  009a               L722:
 658                     ; 361   TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 660  009a a601          	ld	a,#1
 661  009c cd0000        	call	_TIM2_ClearITPendingBit
 663                     ; 362 }
 666  009f 5b04          	addw	sp,#4
 667  00a1 85            	popw	x
 668  00a2 bf00          	ldw	c_y,x
 669  00a4 320002        	pop	c_y+2
 670  00a7 85            	popw	x
 671  00a8 bf00          	ldw	c_x,x
 672  00aa 320002        	pop	c_x+2
 673  00ad 80            	iret	
 696                     ; 369  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 696                     ; 370 {
 697                     	switch	.text
 698  00ae               f_TIM2_CAP_COM_IRQHandler:
 702                     ; 374 }
 705  00ae 80            	iret	
 730                     ; 384  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 730                     ; 385 {
 731                     	switch	.text
 732  00af               f_TIM3_UPD_OVF_BRK_IRQHandler:
 734  00af 8a            	push	cc
 735  00b0 84            	pop	a
 736  00b1 a4bf          	and	a,#191
 737  00b3 88            	push	a
 738  00b4 86            	pop	cc
 739  00b5 3b0002        	push	c_x+2
 740  00b8 be00          	ldw	x,c_x
 741  00ba 89            	pushw	x
 742  00bb 3b0002        	push	c_y+2
 743  00be be00          	ldw	x,c_y
 744  00c0 89            	pushw	x
 747                     ; 387 	if(TimmingDelay !=0)
 749  00c1 ae0000        	ldw	x,#_TimmingDelay
 750  00c4 cd0000        	call	c_lzmp
 752  00c7 2705          	jreq	L762
 753                     ; 389 		TimmingDelay--;
 755  00c9 a601          	ld	a,#1
 756  00cb cd0000        	call	c_lgsbc
 758  00ce               L762:
 759                     ; 391 	TIM3_ClearITPendingBit(TIM3_IT_UPDATE);
 761  00ce a601          	ld	a,#1
 762  00d0 cd0000        	call	_TIM3_ClearITPendingBit
 764                     ; 392 }
 767  00d3 85            	popw	x
 768  00d4 bf00          	ldw	c_y,x
 769  00d6 320002        	pop	c_y+2
 770  00d9 85            	popw	x
 771  00da bf00          	ldw	c_x,x
 772  00dc 320002        	pop	c_x+2
 773  00df 80            	iret	
 796                     ; 399  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 796                     ; 400 {
 797                     	switch	.text
 798  00e0               f_TIM3_CAP_COM_IRQHandler:
 802                     ; 404 }
 805  00e0 80            	iret	
 827                     ; 439 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 827                     ; 440 {
 828                     	switch	.text
 829  00e1               f_I2C_IRQHandler:
 833                     ; 444 }
 836  00e1 80            	iret	
 859                     ; 452  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 859                     ; 453 {
 860                     	switch	.text
 861  00e2               f_UART2_TX_IRQHandler:
 865                     ; 457   }
 868  00e2 80            	iret	
 930                     ; 465  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 930                     ; 466 {
 931                     	switch	.text
 932  00e3               f_UART2_RX_IRQHandler:
 934  00e3 8a            	push	cc
 935  00e4 84            	pop	a
 936  00e5 a4bf          	and	a,#191
 937  00e7 88            	push	a
 938  00e8 86            	pop	cc
 939       00000004      OFST:	set	4
 940  00e9 3b0002        	push	c_x+2
 941  00ec be00          	ldw	x,c_x
 942  00ee 89            	pushw	x
 943  00ef 3b0002        	push	c_y+2
 944  00f2 be00          	ldw	x,c_y
 945  00f4 89            	pushw	x
 946  00f5 5204          	subw	sp,#4
 949                     ; 468 	buffer[counter] = UART2_ReceiveData8();
 951  00f7 b62d          	ld	a,_counter
 952  00f9 5f            	clrw	x
 953  00fa 97            	ld	xl,a
 954  00fb 89            	pushw	x
 955  00fc cd0000        	call	_UART2_ReceiveData8
 957  00ff 85            	popw	x
 958  0100 e75c          	ld	(_buffer,x),a
 959                     ; 470 	if (buffer[counter] == 0x0D){ STATUS_BIT = 1; }  
 961  0102 5f            	clrw	x
 962  0103 b62d          	ld	a,_counter
 963  0105 97            	ld	xl,a
 964  0106 e65c          	ld	a,(_buffer,x)
 965  0108 a10d          	cp	a,#13
 966  010a 2604          	jrne	L743
 969  010c 35010000      	mov	_STATUS_BIT,#1
 970  0110               L743:
 971                     ; 471 	if (buffer[counter] == 0x0A && STATUS_BIT == 1)
 973  0110 b62d          	ld	a,_counter
 974  0112 5f            	clrw	x
 975  0113 97            	ld	xl,a
 976  0114 e65c          	ld	a,(_buffer,x)
 977  0116 a10a          	cp	a,#10
 978  0118 264e          	jrne	L153
 980  011a b600          	ld	a,_STATUS_BIT
 981  011c 4a            	dec	a
 982  011d 2649          	jrne	L153
 983                     ; 477 	temp[0] = buffer[1];
 985  011f b65d          	ld	a,_buffer+1
 986  0121 6b02          	ld	(OFST-2,sp),a
 987                     ; 478 	temp[1] = buffer[2];
 989  0123 b65e          	ld	a,_buffer+2
 990  0125 6b03          	ld	(OFST-1,sp),a
 991                     ; 479 	HexToByte(temp, &Addr);
 993  0127 96            	ldw	x,sp
 994  0128 5c            	incw	x
 995  0129 89            	pushw	x
 996  012a 5c            	incw	x
 997  012b cd0000        	call	_HexToByte
 999  012e 85            	popw	x
1000                     ; 481 		if(Addr == Address || Addr == 0)
1002  012f 7b01          	ld	a,(OFST-3,sp)
1003  0131 b12c          	cp	a,_Address
1004  0133 2704          	jreq	L553
1006  0135 7b01          	ld	a,(OFST-3,sp)
1007  0137 261c          	jrne	L353
1008  0139               L553:
1009                     ; 484 			for(i = 0; i<BufforsSize; i++)
1011  0139 4f            	clr	a
1012  013a 6b04          	ld	(OFST+0,sp),a
1013  013c               L753:
1014                     ; 486 			word[i] = buffer[i];
1016  013c 5f            	clrw	x
1017  013d 97            	ld	xl,a
1018  013e e65c          	ld	a,(_buffer,x)
1019  0140 e72f          	ld	(_word,x),a
1020                     ; 487 			buffer[i] = '\0';	
1022  0142 5f            	clrw	x
1023  0143 7b04          	ld	a,(OFST+0,sp)
1024  0145 97            	ld	xl,a
1025  0146 6f5c          	clr	(_buffer,x)
1026                     ; 484 			for(i = 0; i<BufforsSize; i++)
1028  0148 0c04          	inc	(OFST+0,sp)
1031  014a 7b04          	ld	a,(OFST+0,sp)
1032  014c a12d          	cp	a,#45
1033  014e 25ec          	jrult	L753
1034                     ; 489 			BYTES = counter;
1036  0150 452d2e        	mov	_BYTES,_counter
1037                     ; 490 			counter = 0;
1039  0153 200f          	jpf	LC001
1040  0155               L353:
1041                     ; 495 			for(i = 0; i<BufforsSize; i++)
1043  0155 4f            	clr	a
1044  0156 6b04          	ld	(OFST+0,sp),a
1045  0158               L763:
1046                     ; 497 			buffer[i] = '\0';	
1048  0158 5f            	clrw	x
1049  0159 97            	ld	xl,a
1050  015a 6f5c          	clr	(_buffer,x)
1051                     ; 495 			for(i = 0; i<BufforsSize; i++)
1053  015c 0c04          	inc	(OFST+0,sp)
1056  015e 7b04          	ld	a,(OFST+0,sp)
1057  0160 a12d          	cp	a,#45
1058  0162 25f4          	jrult	L763
1059                     ; 499 			counter = 0;
1061  0164               LC001:
1063  0164 3f2d          	clr	_counter
1064  0166 2002          	jra	L573
1065  0168               L153:
1066                     ; 505 	counter++;
1068  0168 3c2d          	inc	_counter
1069  016a               L573:
1070                     ; 508 	UART2_ClearITPendingBit(UART2_IT_RXNE);
1072  016a ae0255        	ldw	x,#597
1073  016d cd0000        	call	_UART2_ClearITPendingBit
1075                     ; 509 }
1078  0170 5b04          	addw	sp,#4
1079  0172 85            	popw	x
1080  0173 bf00          	ldw	c_y,x
1081  0175 320002        	pop	c_y+2
1082  0178 85            	popw	x
1083  0179 bf00          	ldw	c_x,x
1084  017b 320002        	pop	c_x+2
1085  017e 80            	iret	
1107                     ; 557  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1107                     ; 558 {
1108                     	switch	.text
1109  017f               f_ADC1_IRQHandler:
1113                     ; 563 }
1116  017f 80            	iret	
1139                     ; 584  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1139                     ; 585 {
1140                     	switch	.text
1141  0180               f_TIM4_UPD_OVF_IRQHandler:
1145                     ; 589 }
1148  0180 80            	iret	
1171                     ; 597 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1171                     ; 598 {
1172                     	switch	.text
1173  0181               f_EEPROM_EEC_IRQHandler:
1177                     ; 602 }
1180  0181 80            	iret	
1279                     	switch	.ubsct
1280  0000               _TimmingDelay:
1281  0000 00000000      	ds.b	4
1282                     	xdef	_TimmingDelay
1283  0004               _Output_Registers:
1284  0004 000000000000  	ds.b	20
1285                     	xdef	_Output_Registers
1286  0018               _Input_Registers:
1287  0018 000000000000  	ds.b	20
1288                     	xdef	_Input_Registers
1289  002c               _Address:
1290  002c 00            	ds.b	1
1291                     	xdef	_Address
1292                     	xdef	_STATUS_BIT
1293  002d               _counter:
1294  002d 00            	ds.b	1
1295                     	xdef	_counter
1296  002e               _BYTES:
1297  002e 00            	ds.b	1
1298                     	xdef	_BYTES
1299  002f               _word:
1300  002f 000000000000  	ds.b	45
1301                     	xdef	_word
1302  005c               _buffer:
1303  005c 000000000000  	ds.b	45
1304                     	xdef	_buffer
1305                     	xref	_ForceMultipleRegisters
1306                     	xref	_PresetSingleRegister
1307                     	xref	_ForceSingleCoil
1308                     	xref	_ReadInputRegisters
1309                     	xref	_ReadHoldingRegisters
1310                     	xref	_ReadInputStatus
1311                     	xref	_ReadCoilStatus
1312                     	xref	___checkFunc
1313                     	xref	_CheckLRC
1314                     	xref	_HexToByte
1315                     	xdef	f_EEPROM_EEC_IRQHandler
1316                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1317                     	xdef	f_ADC1_IRQHandler
1318                     	xdef	f_UART2_TX_IRQHandler
1319                     	xdef	f_UART2_RX_IRQHandler
1320                     	xdef	f_I2C_IRQHandler
1321                     	xdef	f_TIM3_CAP_COM_IRQHandler
1322                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1323                     	xdef	f_TIM2_CAP_COM_IRQHandler
1324                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1325                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1326                     	xdef	f_TIM1_CAP_COM_IRQHandler
1327                     	xdef	f_SPI_IRQHandler
1328                     	xdef	f_EXTI_PORTE_IRQHandler
1329                     	xdef	f_EXTI_PORTD_IRQHandler
1330                     	xdef	f_EXTI_PORTC_IRQHandler
1331                     	xdef	f_EXTI_PORTB_IRQHandler
1332                     	xdef	f_EXTI_PORTA_IRQHandler
1333                     	xdef	f_CLK_IRQHandler
1334                     	xdef	f_AWU_IRQHandler
1335                     	xdef	f_TLI_IRQHandler
1336                     	xdef	f_TRAP_IRQHandler
1337                     	xdef	f_NonHandledInterrupt
1338                     	xref	_UART2_ClearITPendingBit
1339                     	xref	_UART2_ReceiveData8
1340                     	xref	_TIM3_ClearITPendingBit
1341                     	xref	_TIM2_ClearITPendingBit
1342                     	xref.b	c_x
1343                     	xref.b	c_y
1363                     	xref	c_lgsbc
1364                     	xref	c_lzmp
1365                     	end
