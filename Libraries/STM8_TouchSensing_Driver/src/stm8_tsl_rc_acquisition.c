/**
  ******************************************************************************
  * @file    stm8_tsl_rc_acquisition.c
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file manages the RC acquisition
  *          for all STM8 devices.
  ******************************************************************************
  * @attention
  *
  * THE PRESENT FIRMWARE WHICH IS FOR GUIDANCE ONLY AIMS AT PROVIDING CUSTOMERS
  * WITH CODING INFORMATION REGARDING THEIR PRODUCTS IN ORDER FOR THEM TO SAVE
  * TIME. AS A RESULT, STMICROELECTRONICS SHALL NOT BE HELD LIABLE FOR ANY
  * DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES WITH RESPECT TO ANY CLAIMS ARISING
  * FROM THE CONTENT OF SUCH FIRMWARE AND/OR THE USE MADE BY CUSTOMERS OF THE
  * CODING INFORMATION CONTAINED HEREIN IN CONNECTION WITH THEIR PRODUCTS.
  *
  * <h2><center>&copy; COPYRIGHT 2011 STMicroelectronics</center></h2>
  */

/* ASM Inclusion Directive --------------------------------------------------*/

/*< For Raisonance, the SRC pragma must be the first command of the file.
    No header files can be included so _RAISONANCE_ compilation variable
  cannot be used */
#ifdef __RCSTM8__
#pragma SRC("stm8_tsl_rc_acquisition.asm")
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm8_tsl_rc_acquisition.h"
#include "stm8_tsl_services.h"

#if !defined(CHARGE_TRANSFER)

/* Memory section ------------------------------------------------------------*/
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/
#if defined(_COSMIC_) && defined(USE_PRAGMA_SECTION)
#pragma section [TSL_IO_RAM]
#pragma section @tiny [TSL_IO_RAM0]
#pragma section const {TSL_IO_CONST}
#pragma section (TSL_IO_CODE)
#endif


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
u32 TINY FinalMeasurementValue;
TOUCH_PORT_Info_T TINY sTouchIO;
u16 TINY CounterStop;
u8 TINY SamplingShifter;
u8 TINY AcquisitionBitMask;
static u8 SpreadCounter;

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/

/* This table is always defined */
CONST u8 Table_SCKEY_BITS[
  SCKEY_P1_KEY_COUNT
#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 1
  + SCKEY_P2_KEY_COUNT
#endif
#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 2
  + SCKEY_P3_KEY_COUNT
#endif
] =
  {
    SCKEY_P1_A /* Always defined */
#if SCKEY_P1_KEY_COUNT > 1
    , SCKEY_P1_B
#endif
#if SCKEY_P1_KEY_COUNT > 2
    , SCKEY_P1_C
#endif
#if SCKEY_P1_KEY_COUNT > 3
    , SCKEY_P1_D
#endif
#if SCKEY_P1_KEY_COUNT > 4
    , SCKEY_P1_E
#endif
#if SCKEY_P1_KEY_COUNT > 5
    , SCKEY_P1_F
#endif
#if SCKEY_P1_KEY_COUNT > 6
    , SCKEY_P1_G
#endif
#if SCKEY_P1_KEY_COUNT > 7
    , SCKEY_P1_H
#endif

#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 1
    , SCKEY_P2_A
#if SCKEY_P2_KEY_COUNT > 1
    , SCKEY_P2_B
#endif
#if SCKEY_P2_KEY_COUNT > 2
    , SCKEY_P2_C
#endif
#if SCKEY_P2_KEY_COUNT > 3
    , SCKEY_P2_D
#endif
#if SCKEY_P2_KEY_COUNT > 4
    , SCKEY_P2_E
#endif
#if SCKEY_P2_KEY_COUNT > 5
    , SCKEY_P2_F
#endif
#if SCKEY_P2_KEY_COUNT > 6
    , SCKEY_P2_G
#endif
#if SCKEY_P2_KEY_COUNT > 7
    , SCKEY_P2_H
#endif
#endif

#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 2
    , SCKEY_P3_A
#if SCKEY_P3_KEY_COUNT > 1
    , SCKEY_P3_B
#endif
#if SCKEY_P3_KEY_COUNT > 2
    , SCKEY_P3_C
#endif
#if SCKEY_P3_KEY_COUNT > 3
    , SCKEY_P3_D
#endif
#if SCKEY_P3_KEY_COUNT > 4
    , SCKEY_P3_E
#endif
#if SCKEY_P3_KEY_COUNT > 5
    , SCKEY_P3_F
#endif
#if SCKEY_P3_KEY_COUNT > 6
    , SCKEY_P3_G
#endif
#if SCKEY_P3_KEY_COUNT > 7
    , SCKEY_P3_H
#endif
#endif
  };

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
__CONST u16 Table_MCKEY_PORTS[
#if NUMBER_OF_MULTI_CHANNEL_KEYS == 1
  CHANNEL_PER_MCKEY
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS == 2
  CHANNEL_PER_MCKEY + CHANNEL_PER_MCKEY
#endif
] =
  {
    MCKEY1_A_PORT_ADDR
    , MCKEY1_B_PORT_ADDR
    , MCKEY1_C_PORT_ADDR
    , MCKEY1_D_PORT_ADDR
    , MCKEY1_E_PORT_ADDR
#if CHANNEL_PER_MCKEY == 8
    , MCKEY1_F_PORT_ADDR
    , MCKEY1_G_PORT_ADDR
    , MCKEY1_H_PORT_ADDR
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
    , MCKEY2_A_PORT_ADDR
    , MCKEY2_B_PORT_ADDR
    , MCKEY2_C_PORT_ADDR
    , MCKEY2_D_PORT_ADDR
    , MCKEY2_E_PORT_ADDR
#if CHANNEL_PER_MCKEY == 8
    , MCKEY2_F_PORT_ADDR
    , MCKEY2_G_PORT_ADDR
    , MCKEY2_H_PORT_ADDR
#endif
#endif
  };
#endif

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
__CONST u8 Table_MCKEY_BITS[
#if NUMBER_OF_MULTI_CHANNEL_KEYS == 1
  CHANNEL_PER_MCKEY
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS == 2
  CHANNEL_PER_MCKEY + CHANNEL_PER_MCKEY
#endif
] =
  {
    MCKEY1_A
    , MCKEY1_B
    , MCKEY1_C
    , MCKEY1_D
    , MCKEY1_E
#if CHANNEL_PER_MCKEY == 8
    , MCKEY1_F
    , MCKEY1_G
    , MCKEY1_H
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
    , MCKEY2_A
    , MCKEY2_B
    , MCKEY2_C
    , MCKEY2_D
    , MCKEY2_E
#if CHANNEL_PER_MCKEY == 8
    , MCKEY2_F
    , MCKEY2_G
    , MCKEY2_H
#endif
#endif
  };
#endif




/**
  ******************************************************************************
  * @brief Execute a loop for calibrated number of cycles to allow over sampling
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************/
void TSL_IO_SW_Burst_TestSyncShift(void)
{

#if defined(_COSMIC_)
#asm
  ld a, _SamplingShifter
  // 3 cycles loop if jump executed; 2 cycles loop if not.
ShiftLoopVih:
  dec a       // 1 cycle
  jrne ShiftLoopVih
#endasm
#elif defined(_IAR_)
  __asm("ld a, S:SamplingShifter"); //s: to use a zero page addressing mode
  // 3 cycles loop if jump executed; 2 cycles loop if not.
  __asm("ShiftLoopVih:");
  __asm("dec a");        // 1 cycle
  __asm("jrne ShiftLoopVih");
#else //_RAISONANCE_
#pragma ASM
  ld a, SamplingShifter;// 3 cycles loop if jump executed; 2 cycles loop if not.
ShiftLoopVih:
  dec a;// 1 cycle
  jrne ShiftLoopVih
#pragma ENDASM
#endif

}

/**
  ******************************************************************************
  * @brief Local sub function to wait for vil on RC structure.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************/
void TSL_IO_SW_Burst_Wait_Vil(void)
{

#if defined(_COSMIC_)
#asm
  ld a, _AcquisitionBitMask
  ldw x, _sTouchIO   // Input data register ...
  incw x
  // Loop = 1 + 1 + 2 + 2 + 2 cycles = 8 cycles
WaitForVil:
// To be sure that the loop last 8 cycles the first instruction must be a 1-byte instruction
// This is to be sure it is fully fetched in 1 cycle. The second instruction must be shorter than 4 bytes.
// If this not the case, the code must be aligned.
  bcp a, (x)  // 1 cycles
  jreq EndWaitForVil
  ldw y, _TIMACQ_CNTR // 2 cycles; hw counter also used for timeout ...
  cpw y, #0x0E00    // 2 cycles; Timeout compare
  jrult WaitForVil
EndWaitForVil:
#endasm
#elif defined(_IAR_)
  __asm("ld a, S:AcquisitionBitMask"); //s: to use a zero page addressing mode
  __asm("ldw x, S:sTouchIO");   // Input data register ...  //s: to use a zero page addressing mode
  __asm("incw x");
  // Loop = 1 + 1 + 2 + 2 + 2 cycles = 8 cycles
  __asm("WaitForVil:");
// To be sure that the loop last 8 cycles the first instruction must be a 1-byte instruction
// This is to be sure it is fully fetched in 1 cycle. The second instruction must be shorter than 4 bytes.
// If this not the case, the code must be aligned.	
  __asm("bcp a, (x)");  // 1 cycles
  __asm("jreq EndWaitForVil");
  __asm("ldw y, TIMACQ_CNTR"); // 2 cycles; hw counter also used for timeout ...
  __asm("cpw y, #0x0E00");    // 2 cycles; Timeout compare
  __asm("jrult WaitForVil");
  __asm("EndWaitForVil:");
#else //_RAISONANCE_
#pragma ASM
  ld a, AcquisitionBitMask
  ldw x, sTouchIO   ;// Input data register ...
  incw x
  ;// Loop = 1 + 1 + 2 + 2 + 2 cycles = 8 cycles
WaitForVil:
// To be sure that the loop last 8 cycles the first instruction must be a 1-byte instruction
// This is to be sure it is fully fetched in 1 cycle. The second instruction must be shorter than 4 bytes.
// If this not the case, the code must be aligned.
  bcp a, (x)  ;// 1 cycles
  jreq EndWaitForVil
  ldw y, TIMACQ_CNTR ;// 2 cycles; hw counter also used for timeout ...
  cpw y, #0E00h    ;// 2 cycles; Timeout compare
  jrult WaitForVil
EndWaitForVil:
#pragma ENDASM

#endif
}

/**
  ******************************************************************************
  * @brief Local sub function to wait for vih on RC structure.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  *******************************************************************************/
void TSL_IO_SW_Burst_Wait_Vih(void)
{
#if defined(_COSMIC_)
#asm
  ld a, _AcquisitionBitMask
  ldw x, _sTouchIO   // Input data register ...
  incw x
  // Loop = 1 + 1 + 2 + 2 + 2 cycles = 8 cycles
WaitForVih:
// To be sure that the loop last 8 cycles the first instruction must be a 1-byte instruction
// This is to be sure it is fully fetched in 1 cycle. The second instruction must be shorter than 4 bytes.
// If this not the case, the code must be aligned.
  bcp a, (x)  // 1 cycles
  jrne EndWaitForVih
  ldw y, _TIMACQ_CNTR // 2 cycles; hw counter also used for timeout ...
  cpw y, #0x0E00    // 2 cycles; Timeout compare
  jrult WaitForVih
EndWaitForVih:
#endasm
#elif defined(_IAR_)
  __asm("ld a, S:AcquisitionBitMask"); //s: to use a zero page addressing mode
  __asm("ldw x, S:sTouchIO");   // Input data register ...  //s: to use a zero page addressing mode
  __asm("incw x");
  // Loop = 1 + 1 + 2 + 2 + 2 cycles = 8 cycles
  __asm("WaitForVih:");
// To be sure that the loop last 8 cycles the first instruction must be a 1-byte instruction
// This is to be sure it is fully fetched in 1 cycle. The second instruction must be shorter than 4 bytes.
// If this not the case, the code must be aligned.	
  __asm("bcp a, (x)");  // 1 cycles
  __asm("jrne EndWaitForVih");
  __asm("ldw y, TIMACQ_CNTR"); // 2 cycles; hw counter also used for timeout ...
  __asm("cpw y, #0x0E00");    // 2 cycles; Timeout compare
  __asm("jrult WaitForVih");
  __asm("EndWaitForVih:");
#else  //_RAISONANCE_
#pragma ASM
  ld a, AcquisitionBitMask
  ldw x, sTouchIO   ;// Input data register ...
  incw x
  ;// Loop = 1 + 1 + 2 + 2 + 2 cycles = 8 cycles
WaitForVih:
// To be sure that the loop last 8 cycles the first instruction must be a 1-byte instruction
// This is to be sure it is fully fetched in 1 cycle. The second instruction must be shorter than 4 bytes.
// If this not the case, the code must be aligned.
  bcp a, (x)  ;// 1 cycles
  jrne EndWaitForVih
  ldw y, TIMACQ_CNTR ;// 2 cycles; hw counter also used for timeout ...
  cpw y, #0E00h    ;// 2 cycles; Timeout compare
  jrult WaitForVih
EndWaitForVih:

#pragma ENDASM

#endif
}


#if defined(_COSMIC_) && defined(USE_PRAGMA_SECTION)
#pragma section (TSL_IO_CODE)
#endif

#if SPREAD_SPECTRUM
/**
  ******************************************************************************
  * @brief Spread Spectrum waiting routine. A variable delay is
  * inserted between each set of 8 measures.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * SPREAD_SPECTRUM must be defined in the configuration file
  ******************************************************************************
  */

void TSL_IO_SW_Spread_Spectrum(void)
{
  u8 i;

  SpreadCounter++;

  if (SpreadCounter == SPREAD_COUNTER_MAX)
  {
    SpreadCounter = SPREAD_COUNTER_MIN;
  }

  for (i = SpreadCounter; i; i--) {}}
#endif /* SPREAD_SPECTRUM */


/**
  ******************************************************************************
  * @brief Init for I/Os used in the application. Used for SW I/O toggling.
  * If the hardware cell is used, the responsability of the I/O configuration is
  * given to the user layer.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_IO_Init(void)
{

  // LOADREF pin
  ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->CR1 |= LOADREF_BIT;
  ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->DDR |= LOADREF_BIT;
  ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->ODR &= (u8)(~LOADREF_BIT);

  // Single-Channel and Multi-channels pins
#if GPIOA_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOA_BaseAddress))->CR1 |= GPIOA_ELECTRODES_MASK;
#endif
#if GPIOB_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOB_BaseAddress))->CR1 |= GPIOB_ELECTRODES_MASK;
#endif
#if GPIOC_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOC_BaseAddress))->CR1 |= GPIOC_ELECTRODES_MASK;
#endif
#if GPIOD_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOD_BaseAddress))->CR1 |= GPIOD_ELECTRODES_MASK;
#endif
#if GPIOE_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOE_BaseAddress))->CR1 |= GPIOE_ELECTRODES_MASK;
#endif
#if GPIOF_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOF_BaseAddress))->CR1 |= GPIOF_ELECTRODES_MASK;
#endif
#if GPIOG_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOG_BaseAddress))->CR1 |= GPIOG_ELECTRODES_MASK;
#endif
#if GPIOH_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOH_BaseAddress))->CR1 |= GPIOH_ELECTRODES_MASK;
#endif
#if GPIOI_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOI_BaseAddress))->CR1 |= GPIOI_ELECTRODES_MASK;
#endif

  TSL_IO_Clamp();

  /* Init Timer used to measure VIH/VIL */
  TIMACQ->PSCR = 0;
  TIMACQ->CR1 = 0x01;

}


/**
  ******************************************************************************
  * @brief Put All Sensing I/Os in ouput mode at 0.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_IO_Clamp(void)
{

  // LOADREF pin
  ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->ODR &= (u8)(~LOADREF_BIT);

  // Single-Channel and Multi-channels pins
#if GPIOA_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOA_BaseAddress))->ODR &= (u8)(~GPIOA_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOA_BaseAddress))->DDR |= GPIOA_ELECTRODES_MASK;
#endif
#if GPIOB_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOB_BaseAddress))->ODR &= (u8)(~GPIOB_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOB_BaseAddress))->DDR |= GPIOB_ELECTRODES_MASK;
#endif
#if GPIOC_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOC_BaseAddress))->ODR &= (u8)(~GPIOC_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOC_BaseAddress))->DDR |= GPIOC_ELECTRODES_MASK;
#endif
#if GPIOD_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOD_BaseAddress))->ODR &= (u8)(~GPIOD_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOD_BaseAddress))->DDR |= GPIOD_ELECTRODES_MASK;
#endif
#if GPIOE_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOE_BaseAddress))->ODR &= (u8)(~GPIOE_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOE_BaseAddress))->DDR |= GPIOE_ELECTRODES_MASK;
#endif
#if GPIOF_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOF_BaseAddress))->ODR &= (u8)(~GPIOF_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOF_BaseAddress))->DDR |= GPIOF_ELECTRODES_MASK;
#endif
#if GPIOG_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOG_BaseAddress))->ODR &= (u8)(~GPIOG_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOG_BaseAddress))->DDR |= GPIOG_ELECTRODES_MASK;
#endif
#if GPIOH_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOH_BaseAddress))->ODR &= (u8)(~GPIOH_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOH_BaseAddress))->DDR |= GPIOH_ELECTRODES_MASK;
#endif
#if GPIOI_ELECTRODES_MASK > 0
  ((GPIO_TypeDef *)(GPIOI_BaseAddress))->ODR &= (u8)(~GPIOI_ELECTRODES_MASK);
  ((GPIO_TypeDef *)(GPIOI_BaseAddress))->DDR |= GPIOI_ELECTRODES_MASK;
#endif

}


/**
  ******************************************************************************
  * @brief Local sub function to restart timer for acquisition.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_IO_SW_Burst_Start_Timer(void)
{

  TIMACQ->EGR |= 0x01;

}


/**
  ******************************************************************************
  * @brief Local sub function to get timer count for acquisition.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_IO_SW_Burst_Stop_Timer(void)
{
#if defined(_COSMIC_)
#asm
  ld a, _TIMACQ_CNTR
  ld _CounterStop, a
  ld a, _TIMACQ_CNTR + 1
  ld _CounterStop + 1, a
#endasm
#elif defined(_IAR_)
  TIMACQ_CNTR; // Dummy access

  __asm("ld a, TIMACQ_CNTR");
  __asm("ld CounterStop, a");
  __asm("ld a, TIMACQ_CNTR + 1");
  __asm("ld CounterStop + 1, a");
#else
#pragma ASM
  ld a, TIMACQ_CNTR
  ld CounterStop, a
  ld a, TIMACQ_CNTR + 1
  ld CounterStop + 1, a
#pragma ENDASM

#endif
}


/**
  ******************************************************************************
  * @brief Handles RC charge / discharge timing measurement.
  * @param[in] AcqNumber Number of times the acquisition is done.
  * @param[in] AdjustmentLevel Used to adjust the measured level.
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_IO_Acquisition(u8 AcqNumber, u8 AdjustmentLevel)
{

  u16 MaxMeasurement, MinMeasurement, CumulatedMeasurement, Measurement;
  u8 MeasRejected, RejectionCounter;
  u8 AcqLoopIndex;
  u32 tmpval;

  AcquisitionBitMask = sTouchIO.AcqMask;

  MinMeasurement = 0;
  MaxMeasurement = 0;
  FinalMeasurementValue = 0;
  RejectionCounter = 0;

  /* Whole acquisition synchronisation */
  /* The IT_Sync_Flag.start must be set to 1 inside an IT or it will loop forever */
#if IT_SYNC
  if (IT_Sync_Flags.one_acquisition_sync_enable)
  {
    IT_Sync_Flags.start = 0;
    while (IT_Sync_Flags.start == 0);
  }
#endif


  for (AcqLoopIndex = 0; AcqLoopIndex < AcqNumber; AcqLoopIndex++)
  {
    /* single measurement synchronisation */
    /* The IT_Sync_Flag.start must be set to 1 inside an IT or it will loop forever */
#if IT_SYNC
    if (IT_Sync_Flags.one_measure_sync_enable)
    {
      IT_Sync_Flags.start = 0;
      while (IT_Sync_Flags.start == 0);
    }
#endif

    do
    {

      MeasRejected = 0;
      CumulatedMeasurement = 0;

      for (SamplingShifter = SAMPLING_SHIFTER_LOOP_START;
           SamplingShifter < (SAMPLING_SHIFTER_NB_LOOPS + SAMPLING_SHIFTER_LOOP_START);
           SamplingShifter++)
      {
        /* VIH measurement */
        disableInterrupts();
        sTouchIO.PORT_ADDR->ODR &= (u8)(~sTouchIO.DriveMask);
        sTouchIO.PORT_ADDR->DDR |= sTouchIO.DriveMask;
        sTouchIO.PORT_ADDR->CR1 &= (u8)(~sTouchIO.DriveMask);
        ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->ODR |= LOADREF_BIT;
        enableInterrupts();

        /* Single charge Aquisition synchronisation */
        /* The IT_Sync_Flag.start must be set to 1 inside an IT or it will loop forever */
#if IT_SYNC
        if (IT_Sync_Flags.one_charge_sync_enable)
        {
          IT_Sync_Flags.start = 0;
          while (IT_Sync_Flags.start == 0);
        }
#endif

#if SPREAD_SPECTRUM
        TSL_IO_SW_Spread_Spectrum();
#endif

        disableInterrupts();
        TSL_IO_SW_Burst_Start_Timer();
        sTouchIO.PORT_ADDR->DDR &= (u8)(~sTouchIO.DriveMask);
        TSL_IO_SW_Burst_TestSyncShift();
        TSL_IO_SW_Burst_Wait_Vih();
        TSL_IO_SW_Burst_Stop_Timer();

        Measurement = CounterStop;

        /* VIL measurement */
        sTouchIO.PORT_ADDR->ODR |= sTouchIO.DriveMask;
        sTouchIO.PORT_ADDR->DDR |= sTouchIO.DriveMask;
        sTouchIO.PORT_ADDR->CR1 |= sTouchIO.DriveMask;
        ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->ODR &= (u8)(~LOADREF_BIT);
        enableInterrupts();

        /* Single charge Aquisition synchronization */
        /* The IT_Sync_Flag.start must be set to 1 inside an IT or it will loop forever */
#if IT_SYNC
        if (IT_Sync_Flags.one_charge_sync_enable)
        {
          IT_Sync_Flags.start = 0;
          while (IT_Sync_Flags.start == 0);
        }
#endif

#if SPREAD_SPECTRUM
        TSL_IO_SW_Spread_Spectrum();
#endif

        disableInterrupts();
        TSL_IO_SW_Burst_Start_Timer();
        sTouchIO.PORT_ADDR->CR1 &= (u8)(~sTouchIO.DriveMask);
        sTouchIO.PORT_ADDR->DDR &= (u8)(~sTouchIO.DriveMask);
        TSL_IO_SW_Burst_TestSyncShift();
        TSL_IO_SW_Burst_Wait_Vil();
        TSL_IO_SW_Burst_Stop_Timer();

        Measurement += CounterStop;

        CumulatedMeasurement += Measurement;

        /* Calculation of the min/max limits */
        if (SamplingShifter == SAMPLING_SHIFTER_LOOP_START)
        {
          tmpval = (u32)((u32)Measurement * MAX_MEAS_COEFF);
          MaxMeasurement = (u16)((u16)(tmpval >> 8) + NB_CYCLES_VIHVIL_LOOP);
          tmpval = (u32)((u32)Measurement * MIN_MEAS_COEFF);
          MinMeasurement = (u16)((u16)(tmpval >> 8) - NB_CYCLES_VIHVIL_LOOP);
        }
        else /* Compare measurement with min/max limit */
        {
          if ((Measurement < MinMeasurement) || (Measurement > MaxMeasurement))
          {
            MeasRejected++;
            RejectionCounter++;
            break; // Out from 'for SamplingShifter' loop !!!
          }
        }

      } /* for SamplingShifter... */

    }
    while (MeasRejected && (RejectionCounter <= MAX_REJECTED_MEASUREMENTS));

    if (MeasRejected == 0)
    {
      FinalMeasurementValue += CumulatedMeasurement;
    }
    else // RejectionCounter > MAX_REJECTED_MEASUREMENTS
    {
      break; // Out from 'for AcqLoopIndex' loop !!!
    }

  } /* for AcqLoopIndex... */

  TSL_IO_Clamp(); // To avoid consumption
  enableInterrupts();

  *sTouchIO.RejectedNb = RejectionCounter;

  if (RejectionCounter <= MAX_REJECTED_MEASUREMENTS)
  {
    FinalMeasurementValue = (u32)(FinalMeasurementValue >> 3); /* Division by SAMPLING_SHIFTER_NB_LOOPS */
    while (AdjustmentLevel--)
    {
      FinalMeasurementValue = (u32)(FinalMeasurementValue >> 1);
    }
    *sTouchIO.Measurement = (u16)FinalMeasurementValue;
  }
  else // Too many rejected measures...
  {
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
    if (sTouchIO.Type == SCKEY_TYPE)
    {
#endif
      pKeyStruct->Setting.b.NOISE = 1; /* Warning: Application layer must reset this flag */
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
    }
    else // MCKEY_TYPE
    {
      pMCKeyStruct->Setting.b.NOISE = 1; /* Warning: Application layer must reset this flag */
    }
#endif
  }

}

#endif

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
