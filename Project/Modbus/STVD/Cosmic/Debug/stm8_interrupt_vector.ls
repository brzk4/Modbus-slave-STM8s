   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.23 - 17 Sep 2014
   3                     ; Generator (Limited) V4.3.13 - 22 Oct 2014
   4                     ; Optimizer V4.3.11 - 22 Oct 2014
  19                     .const:	section	.text
  20  0000               __vectab:
  21  0000 82            	dc.b	130
  23  0001 00            	dc.b	page(__stext)
  24  0002 0000          	dc.w	__stext
  25  0004 82            	dc.b	130
  27  0005 00            	dc.b	page(f_TRAP_IRQHandler)
  28  0006 0000          	dc.w	f_TRAP_IRQHandler
  29  0008 82            	dc.b	130
  31  0009 00            	dc.b	page(f_TLI_IRQHandler)
  32  000a 0000          	dc.w	f_TLI_IRQHandler
  33  000c 82            	dc.b	130
  35  000d 00            	dc.b	page(f_AWU_IRQHandler)
  36  000e 0000          	dc.w	f_AWU_IRQHandler
  37  0010 82            	dc.b	130
  39  0011 00            	dc.b	page(f_CLK_IRQHandler)
  40  0012 0000          	dc.w	f_CLK_IRQHandler
  41  0014 82            	dc.b	130
  43  0015 00            	dc.b	page(f_EXTI_PORTA_IRQHandler)
  44  0016 0000          	dc.w	f_EXTI_PORTA_IRQHandler
  45  0018 82            	dc.b	130
  47  0019 00            	dc.b	page(f_EXTI_PORTB_IRQHandler)
  48  001a 0000          	dc.w	f_EXTI_PORTB_IRQHandler
  49  001c 82            	dc.b	130
  51  001d 00            	dc.b	page(f_EXTI_PORTC_IRQHandler)
  52  001e 0000          	dc.w	f_EXTI_PORTC_IRQHandler
  53  0020 82            	dc.b	130
  55  0021 00            	dc.b	page(f_EXTI_PORTD_IRQHandler)
  56  0022 0000          	dc.w	f_EXTI_PORTD_IRQHandler
  57  0024 82            	dc.b	130
  59  0025 00            	dc.b	page(f_EXTI_PORTE_IRQHandler)
  60  0026 0000          	dc.w	f_EXTI_PORTE_IRQHandler
  61  0028 82            	dc.b	130
  63  0029 00            	dc.b	page(f_NonHandledInterrupt)
  64  002a 0000          	dc.w	f_NonHandledInterrupt
  65  002c 82            	dc.b	130
  67  002d 00            	dc.b	page(f_NonHandledInterrupt)
  68  002e 0000          	dc.w	f_NonHandledInterrupt
  69  0030 82            	dc.b	130
  71  0031 00            	dc.b	page(f_SPI_IRQHandler)
  72  0032 0000          	dc.w	f_SPI_IRQHandler
  73  0034 82            	dc.b	130
  75  0035 00            	dc.b	page(f_TIM1_UPD_OVF_TRG_BRK_IRQHandler)
  76  0036 0000          	dc.w	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
  77  0038 82            	dc.b	130
  79  0039 00            	dc.b	page(f_TIM1_CAP_COM_IRQHandler)
  80  003a 0000          	dc.w	f_TIM1_CAP_COM_IRQHandler
  81  003c 82            	dc.b	130
  83  003d 00            	dc.b	page(f_TIM2_UPD_OVF_BRK_IRQHandler)
  84  003e 0000          	dc.w	f_TIM2_UPD_OVF_BRK_IRQHandler
  85  0040 82            	dc.b	130
  87  0041 00            	dc.b	page(f_TIM2_CAP_COM_IRQHandler)
  88  0042 0000          	dc.w	f_TIM2_CAP_COM_IRQHandler
  89  0044 82            	dc.b	130
  91  0045 00            	dc.b	page(f_TIM3_UPD_OVF_BRK_IRQHandler)
  92  0046 0000          	dc.w	f_TIM3_UPD_OVF_BRK_IRQHandler
  93  0048 82            	dc.b	130
  95  0049 00            	dc.b	page(f_TIM3_CAP_COM_IRQHandler)
  96  004a 0000          	dc.w	f_TIM3_CAP_COM_IRQHandler
  97  004c 82            	dc.b	130
  99  004d 00            	dc.b	page(f_NonHandledInterrupt)
 100  004e 0000          	dc.w	f_NonHandledInterrupt
 101  0050 82            	dc.b	130
 103  0051 00            	dc.b	page(f_NonHandledInterrupt)
 104  0052 0000          	dc.w	f_NonHandledInterrupt
 105  0054 82            	dc.b	130
 107  0055 00            	dc.b	page(f_I2C_IRQHandler)
 108  0056 0000          	dc.w	f_I2C_IRQHandler
 109  0058 82            	dc.b	130
 111  0059 00            	dc.b	page(f_UART2_TX_IRQHandler)
 112  005a 0000          	dc.w	f_UART2_TX_IRQHandler
 113  005c 82            	dc.b	130
 115  005d 00            	dc.b	page(f_UART2_RX_IRQHandler)
 116  005e 0000          	dc.w	f_UART2_RX_IRQHandler
 117  0060 82            	dc.b	130
 119  0061 00            	dc.b	page(f_ADC1_IRQHandler)
 120  0062 0000          	dc.w	f_ADC1_IRQHandler
 121  0064 82            	dc.b	130
 123  0065 00            	dc.b	page(f_TIM4_UPD_OVF_IRQHandler)
 124  0066 0000          	dc.w	f_TIM4_UPD_OVF_IRQHandler
 125  0068 82            	dc.b	130
 127  0069 00            	dc.b	page(f_EEPROM_EEC_IRQHandler)
 128  006a 0000          	dc.w	f_EEPROM_EEC_IRQHandler
 129  006c 82            	dc.b	130
 131  006d 00            	dc.b	page(f_NonHandledInterrupt)
 132  006e 0000          	dc.w	f_NonHandledInterrupt
 133  0070 82            	dc.b	130
 135  0071 00            	dc.b	page(f_NonHandledInterrupt)
 136  0072 0000          	dc.w	f_NonHandledInterrupt
 137  0074 82            	dc.b	130
 139  0075 00            	dc.b	page(f_NonHandledInterrupt)
 140  0076 0000          	dc.w	f_NonHandledInterrupt
 141  0078 82            	dc.b	130
 143  0079 00            	dc.b	page(f_NonHandledInterrupt)
 144  007a 0000          	dc.w	f_NonHandledInterrupt
 145  007c 82            	dc.b	130
 147  007d 00            	dc.b	page(f_NonHandledInterrupt)
 148  007e 0000          	dc.w	f_NonHandledInterrupt
 208                     	xdef	__vectab
 209                     	xref	f_EEPROM_EEC_IRQHandler
 210                     	xref	f_TIM4_UPD_OVF_IRQHandler
 211                     	xref	f_ADC1_IRQHandler
 212                     	xref	f_UART2_TX_IRQHandler
 213                     	xref	f_UART2_RX_IRQHandler
 214                     	xref	f_I2C_IRQHandler
 215                     	xref	f_TIM3_CAP_COM_IRQHandler
 216                     	xref	f_TIM3_UPD_OVF_BRK_IRQHandler
 217                     	xref	f_TIM2_CAP_COM_IRQHandler
 218                     	xref	f_TIM2_UPD_OVF_BRK_IRQHandler
 219                     	xref	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 220                     	xref	f_TIM1_CAP_COM_IRQHandler
 221                     	xref	f_SPI_IRQHandler
 222                     	xref	f_EXTI_PORTE_IRQHandler
 223                     	xref	f_EXTI_PORTD_IRQHandler
 224                     	xref	f_EXTI_PORTC_IRQHandler
 225                     	xref	f_EXTI_PORTB_IRQHandler
 226                     	xref	f_EXTI_PORTA_IRQHandler
 227                     	xref	f_CLK_IRQHandler
 228                     	xref	f_AWU_IRQHandler
 229                     	xref	f_TLI_IRQHandler
 230                     	xref	f_TRAP_IRQHandler
 231                     	xref	f_NonHandledInterrupt
 232                     	xref	__stext
 251                     	end
