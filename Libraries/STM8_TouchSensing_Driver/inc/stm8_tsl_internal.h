/**
  ******************************************************************************
  * @file    stm8_tsl_internal.h
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file contains all functions
  *          prototype and macros internal to the touch sensing library.
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
#ifndef __TSL_INTERNAL_H
#define __TSL_INTERNAL_H

/* Includes ------------------------------------------------------------------*/

#if defined(CHARGE_TRANSFER)
#if defined(STM8L15X)
#include "stm8l15x_tsl_ct_acquisition.h"
#elif defined(STM8L10X)
#include "stm8l10x_tsl_ct_acquisition.h"
#else
#error "MCU selected is not supported for Charge Transfer !"
#endif
#else
#include "stm8_tsl_rc_acquisition.h"
#endif

#include "stm8_tsl_api.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/* Exported variables --------------------------------------------------------*/
extern u8 TINY KeyIndex, ChannelIndex;
extern s16 TINY Delta;
extern s16 TINY Delta1;
extern s16 TINY Delta2;
extern s16 TINY Delta3;
extern KeyFlag_T TINY TSL_TempGlobalSetting;
extern KeyState_T TINY TSL_TempGlobalState;
extern u8 TINY Local_TickECS10ms;
extern TimerFlag_T TINY Local_TickFlag;
extern u8 TINY ECSTimeStepCounter;
extern u8 ECSTempoCounter;
extern u8 ECSTempoPrescaler;

/* Exported functions --------------------------------------------------------*/

#endif /* __TSL_INTERNAL_H */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
