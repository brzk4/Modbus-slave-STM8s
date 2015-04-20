/**
  ******************************************************************************
  * @file    stm8l15x_tsl_ct_acquisition.h
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file contains all functions
  *          prototype and macros handling the Charge-Transfer acquisition for
  *          STM8L15x devices.
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __STM8L15X_TSL_CT_ACQUISITION_H
#define __STM8L15X_TSL_CT_ACQUISITION_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_tsl_conf.h"

#if defined(CHARGE_TRANSFER) && defined(STM8L15X)

/* Exported types ------------------------------------------------------------*/
typedef enum
{
  SCKEY_TYPE = 0,
  MCKEY_TYPE = 1
} IOTYPE_T;

/** Contains all informations of the touched I/O */
typedef struct
{
  GPIO_TypeDef *PORT_ADDR;  /**< Base adress of the GPIO (DR address) */
  u8 AcqMask;               /**< Mask used to acquire the pin value */
  u8 DriveMask;             /**< Mask used to drive the pin */
  u16 *Measurement;         /**< Contains the last measurement value */
  u8 *RejectedNb;           /**< Contains the number of rejected values in the last measurement */
  IOTYPE_T Type;            /**< Contains the type of the key touched */
}
TOUCH_PORT_Info_T;

/* Exported constants --------------------------------------------------------*/
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----               __CONSTANTS DEFINITIONS                              -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// IO acquisition sampling loop
// !!! CHANGE WITH CARE !!!
#define SAMPLING_SHIFTER_LOOP_START (1)
#define SAMPLING_SHIFTER_NB_LOOPS   (8)

// Number of cycles taken by the loop in TSL_IO_SW_Burst_Wait_Vil and TSL_IO_SW_Burst_Wait_Vih routines
// !!! CHANGE WITH CARE !!!
#define NB_CYCLES_VIHVIL_LOOP (8)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----               GLOBALS DEFINITIONS                                -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extern TOUCH_PORT_Info_T TINY sTouchIO;

#define Group1 0x01
#define Group2 0x02
#define Group3 0x04
#define Group4 0x08
#define Group5 0x10
#define Group6 0x20
#define Group7 0x40
#define Group8 0x80

typedef union
{
  u8 whole;
  struct
  {
  u8 Grp1  :
    1;
  u8 Grp2  :
    1;
  u8 Grp3  :
    1;
  u8 Grp4  :
    1;
  u8 Grp5  :
    1;
  u8 Grp6  :
    1;
  u8 Grp7  :
    1;
  u8 Grp8  :
    1;
  }
  b;
}
Channel_State;

typedef struct
{
  u16 Measure[8];
  Channel_State State;
  u8 EnabledChannels;
}
Info_Channel;

extern Info_Channel Channel_P1;
#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 0
extern CONST u8 Table_SCKEY_P1[SCKEY_P1_KEY_COUNT];
#endif
#if NUMBER_OF_ACQUISITION_PORTS > 1
extern Info_Channel Channel_P2;
#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 1
extern CONST u8 Table_SCKEY_P2[SCKEY_P2_KEY_COUNT];
#endif
#endif

#if NUMBER_OF_ACQUISITION_PORTS > 2
extern Info_Channel Channel_P3;
#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 2
extern CONST u8 Table_SCKEY_P3[SCKEY_P3_KEY_COUNT];
#endif
#endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----             __CONSTANT TABLE FOR I/O ADDRESSING                    -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extern CONST u8 Table_SCKEY_BITS[];
extern CONST u8 Table_MCKEY_BITS[];
extern CONST u16 Table_MCKEY_PORTS[];

/* Exported macros -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/* Exported variables --------------------------------------------------------*/
/* Exported functions --------------------------------------------------------*/
void TSL_IO_Init(void);
void TSL_IO_Clamp(void);
void TSL_IO_Acquisition(u8 AcqNumber, u8 AdjustmentEnable);
#ifdef CHARGE_TRANSFER
void TSL_IO_Acquisition_P1(u16 MaxAcqNumber);
void TSL_IO_Acquisition_P2(u16 MaxAcqNumber);
#endif
//void TSL_IO_SW_Burst_TestSyncShift(void);
//void TSL_IO_SW_Burst_Wait_Vil(void);
//void TSL_IO_SW_Burst_Wait_Vih(void);
//void TSL_IO_SW_Burst_Start_Timer(void);
//void TSL_IO_SW_Burst_Stop_Timer(void);

#endif

#endif /* __STM8L15X_TSL_CT_ACQUISITION_H */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
