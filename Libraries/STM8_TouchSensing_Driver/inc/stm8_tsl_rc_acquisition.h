/**
  ******************************************************************************
  * @file    stm8_tsl_rc_acquisition.h
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file contains all functions
  *          prototype and macros handling the RC acquisition for STM8 devices.
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
#ifndef __TSL_RC_ACQUISITION_H
#define __TSL_RC_ACQUISITION_H

/* Includes ------------------------------------------------------------------*/
#include "stm8_tsl_conf.h"

#if !defined(CHARGE_TRANSFER)

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
//-----               CONSTANTS DEFINITIONS                              -----
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

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----             CPU RELATED SPECIFIC ADDRESSES                       -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#if defined(_COSMIC_)
volatile u16 TIMACQ_CNTR @ TIMACQ_CNTR_ADD;
#elif defined(_RAISONANCE_)
at TIMACQ_CNTR_ADD hreg16 TIMACQ_CNTR;
#else
__no_init volatile u16 TIMACQ_CNTR @ TIMACQ_CNTR_ADD;
#endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----             CONSTANT TABLE FOR I/O ADDRESSING                    -----
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
void TSL_IO_SW_Burst_TestSyncShift(void);
void TSL_IO_SW_Burst_Wait_Vil(void);
void TSL_IO_SW_Burst_Wait_Vih(void);
void TSL_IO_SW_Burst_Start_Timer(void);
void TSL_IO_SW_Burst_Stop_Timer(void);
#if SPREAD_SPECTRUM
void TSL_IO_SW_Spread_Spectrum(void);
#endif

#endif

#endif /* __TSL_RC_ACQUISITION_H */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
