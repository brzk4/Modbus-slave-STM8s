/**
  ******************************************************************************
  * @file    stm8_tsl_checkconfig.h
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file checks the configuration
 *          file options.
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
#ifndef __TSL_CHECKCONFIG_H
#define __TSL_CHECKCONFIG_H

/* Includes ------------------------------------------------------------------*/
/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macros -----------------------------------------------------------*/
/* Private macros ------------------------------------------------------------*/
/* Exported variables --------------------------------------------------------*/
/* Exported functions --------------------------------------------------------*/


//------------------------------------------------------------------------------
// MCU check and Firmware Library selection
//------------------------------------------------------------------------------

#if defined(CHARGE_TRANSFER)

#if defined(STM8L10X) && defined(STM8L15X)
#error "Wrong MCU selection for Charge-Transfer technology (select only one)"
#elif defined(STM8L10X)
#include "stm8l10x.h"
#elif defined(STM8L15X)
#include "stm8l15x.h"
#else
#error "Wrong MCU selection for Charge-Transfer technology (select one)."
#endif

#else // RC technology

#if defined(STM8L10X) && defined(STM8L15X) && defined(STM8S)
#error "Wrong MCU selection for RC technology (select only one)"
#elif defined(STM8L10X) && defined(STM8L15X)
#error "Wrong MCU selection for RC technology (select only one)"
#elif defined(STM8L10X) && defined(STM8S)
#error "Wrong MCU selection for RC technology (select only one)"
#elif defined(STM8L15X) && defined(STM8S)
#error "Wrong MCU selection for RC technology (select only one)"
#elif defined(STM8L10X)
#include "stm8l10x.h"
#elif defined(STM8L15X)
#include "stm8l15x.h"
#elif defined(STM8S)
#include "stm8s.h"
#else
#error "Wrong MCU selected for RC technology (select one)."
#endif

#endif


//------------------------------------------------------------------------------
// Single channel keys check
//------------------------------------------------------------------------------

#if (SCKEY_P1_KEY_COUNT < 0) || (SCKEY_P1_KEY_COUNT > 8)
#error "Wrong number of single channel keys on port1. Must be in the [0..8] range."
#endif

#if (SCKEY_P2_KEY_COUNT < 0) || (SCKEY_P2_KEY_COUNT > 8)
#error "Wrong number of single channel keys on port2. Must be in the [0..8] range."
#endif

#if (SCKEY_P3_KEY_COUNT < 0) || (SCKEY_P3_KEY_COUNT > 8)
#error "Wrong number of single channel keys on port3. Must be in the [0..8] range."
#endif

// Calculates the total number of single-channel keys
#if defined(CHARGE_TRANSFER) && defined(STM8L15X)
#define NUMBER_OF_SINGLE_CHANNEL_KEYS (SCKEY_P1_KEY_COUNT + SCKEY_P2_KEY_COUNT)
#else
#define NUMBER_OF_SINGLE_CHANNEL_KEYS (SCKEY_P1_KEY_COUNT + SCKEY_P2_KEY_COUNT + SCKEY_P3_KEY_COUNT)
#endif

#if (SCKEY_P1_KEY_COUNT == 0) && ( (SCKEY_P2_KEY_COUNT > 0) || (SCKEY_P3_KEY_COUNT > 0) )
#error "Key(s) defined on PORT2 or PORT3 while no key seems defined on PORT1. PORT1 must be used before using PORT2 or PORT3"
#endif

#if (SCKEY_P2_KEY_COUNT == 0) && (SCKEY_P3_KEY_COUNT > 0)
#error "Key(s) defined on PORT3 while no key seems defined on PORT2. PORT2 must be used before using PORT3"
#endif

#if (SCKEY_P1_KEY_COUNT == 0)
#define NUMBER_OF_SINGLE_CHANNEL_PORTS (0)
#else

#if (SCKEY_P2_KEY_COUNT == 0) && (SCKEY_P3_KEY_COUNT == 0)
#define NUMBER_OF_SINGLE_CHANNEL_PORTS (1)
#endif

#if (SCKEY_P2_KEY_COUNT > 0) && (SCKEY_P3_KEY_COUNT == 0)
#define NUMBER_OF_SINGLE_CHANNEL_PORTS (2)
#endif

#if (SCKEY_P2_KEY_COUNT > 0) && (SCKEY_P3_KEY_COUNT > 0)
#define NUMBER_OF_SINGLE_CHANNEL_PORTS (3)
#endif

#endif
//==============================================================================
//
// PORT MASK definition for multi-channel keys
//
//
//==============================================================================

#if NUMBER_OF_MULTI_CHANNEL_KEYS == 0
#define MKEY_CH1_MASK (0)
#define MKEY_CH2_MASK (0)
#define MKEY_CH3_MASK (0)
#if defined(STM8L10X)
#define MKEY_CH4_MASK (0)
#endif

#elif NUMBER_OF_MULTI_CHANNEL_KEYS == 1
#define MKEY_CH1_MASK \
  ( ((MCKEY1_A_CH == CH1)? MCKEY1_A:0)|((MCKEY1_B_CH == CH1)? MCKEY1_B:0)|\
    ((MCKEY1_C_CH == CH1)? MCKEY1_C:0)|((MCKEY1_D_CH == CH1)? MCKEY1_D:0)|\
    ((MCKEY1_E_CH == CH1)? MCKEY1_E:0)|((MCKEY1_F_CH == CH1)? MCKEY1_F:0)|\
    ((MCKEY1_G_CH == CH1)? MCKEY1_G:0)|((MCKEY1_H_CH == CH1)? MCKEY1_H:0)\
  )
#define MKEY_CH2_MASK \
  ( ((MCKEY1_A_CH == CH2)? MCKEY1_A:0)|((MCKEY1_B_CH == CH2)? MCKEY1_B:0)|\
    ((MCKEY1_C_CH == CH2)? MCKEY1_C:0)|((MCKEY1_D_CH == CH2)? MCKEY1_D:0)|\
    ((MCKEY1_E_CH == CH2)? MCKEY1_E:0)|((MCKEY1_F_CH == CH2)? MCKEY1_F:0)|\
    ((MCKEY1_G_CH == CH2)? MCKEY1_G:0)|((MCKEY1_H_CH == CH2)? MCKEY1_H:0)\
  )
#define MKEY_CH3_MASK \
  ( ((MCKEY1_A_CH == CH3)? MCKEY1_A:0)|((MCKEY1_B_CH == CH3)? MCKEY1_B:0)|\
    ((MCKEY1_C_CH == CH3)? MCKEY1_C:0)|((MCKEY1_D_CH == CH3)? MCKEY1_D:0)|\
    ((MCKEY1_E_CH == CH3)? MCKEY1_E:0)|((MCKEY1_F_CH == CH3)? MCKEY1_F:0)|\
    ((MCKEY1_G_CH == CH3)? MCKEY1_G:0)|((MCKEY1_H_CH == CH3)? MCKEY1_H:0)\
  )

#if defined(STM8L10X)
#define MKEY_CH4_MASK \
  ( ((MCKEY1_A_CH == CH4)? MCKEY1_A:0)|((MCKEY1_B_CH == CH4)? MCKEY1_B:0)|\
    ((MCKEY1_C_CH == CH4)? MCKEY1_C:0)|((MCKEY1_D_CH == CH4)? MCKEY1_D:0)|\
    ((MCKEY1_E_CH == CH4)? MCKEY1_E:0)|((MCKEY1_F_CH == CH4)? MCKEY1_F:0)|\
    ((MCKEY1_G_CH == CH4)? MCKEY1_G:0)|((MCKEY1_H_CH == CH4)? MCKEY1_H:0)\
  )
#endif

#elif NUMBER_OF_MULTI_CHANNEL_KEYS == 2

#define MKEY_CH1_MASK \
  ( ((MCKEY1_A_CH == CH1)? MCKEY1_A:0)|((MCKEY1_B_CH == CH1)? MCKEY1_B:0)|\
    ((MCKEY1_C_CH == CH1)? MCKEY1_C:0)|((MCKEY1_D_CH == CH1)? MCKEY1_D:0)|\
    ((MCKEY1_E_CH == CH1)? MCKEY1_E:0)|((MCKEY1_F_CH == CH1)? MCKEY1_F:0)|\
    ((MCKEY1_G_CH == CH1)? MCKEY1_G:0)|((MCKEY1_H_CH == CH1)? MCKEY1_H:0)|\
    ((MCKEY2_A_CH == CH1)? MCKEY2_A:0)|((MCKEY2_B_CH == CH1)? MCKEY2_B:0)|\
    ((MCKEY2_C_CH == CH1)? MCKEY2_C:0)|((MCKEY2_D_CH == CH1)? MCKEY2_D:0)|\
    ((MCKEY2_E_CH == CH1)? MCKEY2_E:0)|((MCKEY2_F_CH == CH1)? MCKEY2_F:0)|\
    ((MCKEY2_G_CH == CH1)? MCKEY2_G:0)|((MCKEY2_H_CH == CH1)? MCKEY2_H:0)\
  )
#define MKEY_CH2_MASK \
  ( ((MCKEY1_A_CH == CH2)? MCKEY1_A:0)|((MCKEY1_B_CH == CH2)? MCKEY1_B:0)|\
    ((MCKEY1_C_CH == CH2)? MCKEY1_C:0)|((MCKEY1_D_CH == CH2)? MCKEY1_D:0)|\
    ((MCKEY1_E_CH == CH2)? MCKEY1_E:0)|((MCKEY1_F_CH == CH2)? MCKEY1_F:0)|\
    ((MCKEY1_G_CH == CH2)? MCKEY1_G:0)|((MCKEY1_H_CH == CH2)? MCKEY1_H:0)|\
    ((MCKEY2_A_CH == CH2)? MCKEY2_A:0)|((MCKEY2_B_CH == CH2)? MCKEY2_B:0)|\
    ((MCKEY2_C_CH == CH2)? MCKEY2_C:0)|((MCKEY2_D_CH == CH2)? MCKEY2_D:0)|\
    ((MCKEY2_E_CH == CH2)? MCKEY2_E:0)|((MCKEY2_F_CH == CH2)? MCKEY2_F:0)|\
    ((MCKEY2_G_CH == CH2)? MCKEY2_G:0)|((MCKEY2_H_CH == CH2)? MCKEY2_H:0)\
  )
#define MKEY_CH3_MASK \
  ( ((MCKEY1_A_CH == CH3)? MCKEY1_A:0)|((MCKEY1_B_CH == CH3)? MCKEY1_B:0)|\
    ((MCKEY1_C_CH == CH3)? MCKEY1_C:0)|((MCKEY1_D_CH == CH3)? MCKEY1_D:0)|\
    ((MCKEY1_E_CH == CH3)? MCKEY1_E:0)|((MCKEY1_F_CH == CH3)? MCKEY1_F:0)|\
    ((MCKEY1_G_CH == CH3)? MCKEY1_G:0)|((MCKEY1_H_CH == CH3)? MCKEY1_H:0)|\
    ((MCKEY2_A_CH == CH3)? MCKEY2_A:0)|((MCKEY2_B_CH == CH3)? MCKEY2_B:0)|\
    ((MCKEY2_C_CH == CH3)? MCKEY2_C:0)|((MCKEY2_D_CH == CH3)? MCKEY2_D:0)|\
    ((MCKEY2_E_CH == CH3)? MCKEY2_E:0)|((MCKEY2_F_CH == CH3)? MCKEY2_F:0)|\
    ((MCKEY2_G_CH == CH3)? MCKEY2_G:0)|((MCKEY2_H_CH == CH3)? MCKEY2_H:0)\
  )

#if defined(STM8L10X)
#define MKEY_CH4_MASK \
  ( ((MCKEY1_A_CH == CH4)? MCKEY1_A:0)|((MCKEY1_B_CH == CH4)? MCKEY1_B:0)|\
    ((MCKEY1_C_CH == CH4)? MCKEY1_C:0)|((MCKEY1_D_CH == CH4)? MCKEY1_D:0)|\
    ((MCKEY1_E_CH == CH4)? MCKEY1_E:0)|((MCKEY1_F_CH == CH4)? MCKEY1_F:0)|\
    ((MCKEY1_G_CH == CH4)? MCKEY1_G:0)|((MCKEY1_H_CH == CH4)? MCKEY1_H:0)|\
    ((MCKEY2_A_CH == CH4)? MCKEY2_A:0)|((MCKEY2_B_CH == CH4)? MCKEY2_B:0)|\
    ((MCKEY2_C_CH == CH4)? MCKEY2_C:0)|((MCKEY2_D_CH == CH4)? MCKEY2_D:0)|\
    ((MCKEY2_E_CH == CH4)? MCKEY2_E:0)|((MCKEY2_F_CH == CH4)? MCKEY2_F:0)|\
    ((MCKEY2_G_CH == CH4)? MCKEY2_G:0)|((MCKEY2_H_CH == CH4)? MCKEY2_H:0)\
  )
#endif

#endif

//------------------------------------------------------------------------------
// Multi channel keys check
//------------------------------------------------------------------------------

#if (NUMBER_OF_MULTI_CHANNEL_KEYS < 0) || (NUMBER_OF_MULTI_CHANNEL_KEYS > 2)
#error "Wrong number of multi channel keys. Must be in the [0..2] range."
#endif

#if (NUMBER_OF_MULTI_CHANNEL_KEYS > 0)

#if defined(CHARGE_TRANSFER)
#if (CHANNEL_PER_MCKEY != 3) && (CHANNEL_PER_MCKEY != 5) && (CHANNEL_PER_MCKEY != 8)
#error "Wrong number of channel for multi channel keys. Must be equal to 3, 5 or 8."
#endif
#else // RC technology
#if (CHANNEL_PER_MCKEY != 5) && (CHANNEL_PER_MCKEY != 8)
#error "Wrong number of channel for multi channel keys. Must be equal to 5 or 8."
#endif
#endif

#ifndef MCKEY1_TYPE
#error "MCKEY1_TYPE is not defined."
#endif

#if (MCKEY1_TYPE != 0) && (MCKEY1_TYPE != 1)
#error "Wrong MCKEY1 type. Must be equal to 0 (wheel) or 1 (slider)."
#endif

#ifndef MCKEY1_LAYOUT_TYPE
#error "MCKEY1_LAYOUT_TYPE is not defined."
#endif

#if (MCKEY1_LAYOUT_TYPE != 0) && (MCKEY1_LAYOUT_TYPE != 1)
#error "Wrong MCKEY1 layout type. Must be equal to 0 (Interlaced) or 1 (Normal)."
#endif

#endif

#if (NUMBER_OF_MULTI_CHANNEL_KEYS > 1)

#ifndef MCKEY2_TYPE
#error "MCKEY2_TYPE is not defined."
#endif

#if (MCKEY2_TYPE != 0) && (MCKEY2_TYPE != 1)
#error "Wrong MCKEY2 type. Must be equal to 0 (wheel) or 1 (slider)."
#endif

#ifndef MCKEY2_LAYOUT_TYPE
#error "MCKEY2_LAYOUT_TYPE is not defined."
#endif

#if (MCKEY2_LAYOUT_TYPE != 0) && (MCKEY2_LAYOUT_TYPE != 1)
#error "Wrong MCKEY2 layout type. Must be equal to 0 (Interlaced) or 1 (Normal)."
#endif

#endif


//------------------------------------------------------------------------------
// Assign Comparators (for CHARGE_TRANSFER and STM8L10X only)
//------------------------------------------------------------------------------

#if defined(CHARGE_TRANSFER) && defined(STM8L10X)

#ifdef COMP1
#undef COMP1
#endif

#ifdef COMP2
#undef COMP2
#endif

#if (SCKEY_P1_A == GROUP1) || (SCKEY_P1_B == GROUP1) ||\
    (SCKEY_P2_A == GROUP1) || (SCKEY_P2_B == GROUP1) ||\
    (SCKEY_P3_A == GROUP1) || (SCKEY_P3_B == GROUP1)
#define COMP1 (1)
#endif

#if (SCKEY_P1_A == GROUP2) || (SCKEY_P1_B == GROUP2) ||\
    (SCKEY_P2_A == GROUP2) || (SCKEY_P2_B == GROUP2) ||\
    (SCKEY_P3_A == GROUP2) || (SCKEY_P3_B == GROUP2)
#define COMP2 (1)
#endif

#endif


//------------------------------------------------------------------------------
// Check SCKEY_Px_y settings (for CHARGE_TRANSFER and STM8L10X only)
//------------------------------------------------------------------------------

#if defined(CHARGE_TRANSFER) && defined(STM8L10X)

#if (SCKEY_P1_A != GROUP1) && (SCKEY_P1_A != GROUP2) && (SCKEY_P1_A != 0)
#error "SCKEY_P1_A must be equal to 0 or GROUP1 or GROUP2 only"
#endif

#if (SCKEY_P1_B != GROUP1) && (SCKEY_P1_B != GROUP2) && (SCKEY_P1_B != 0)
#error "SCKEY_P1_B must be equal to 0 or GROUP1 or GROUP2 only"
#endif

#if (SCKEY_P2_A != GROUP1) && (SCKEY_P2_A != GROUP2) && (SCKEY_P2_A != 0)
#error "SCKEY_P2_A must be equal to 0 or GROUP1 or GROUP2 only"
#endif

#if (SCKEY_P2_B != GROUP1) && (SCKEY_P2_B != GROUP2) && (SCKEY_P2_B != 0)
#error "SCKEY_P2_B must be equal to 0 or GROUP1 or GROUP2 only"
#endif

#if (SCKEY_P3_A != GROUP1) && (SCKEY_P3_A != GROUP2) && (SCKEY_P3_A != 0)
#error "SCKEY_P3_A must be equal to 0 or GROUP1 or GROUP2 only"
#endif

#if (SCKEY_P3_B != GROUP1) && (SCKEY_P3_B != GROUP2) && (SCKEY_P3_B != 0)
#error "SCKEY_P3_B must be equal to 0 or GROUP1 or GROUP2 only"
#endif

#if (SCKEY_P1_C != 0) || (SCKEY_P1_D != 0) || (SCKEY_P1_E != 0) ||\
    (SCKEY_P1_F != 0) || (SCKEY_P1_G != 0) || (SCKEY_P1_H != 0)
#error "SCKEY_P1_C to SCKEY_P1_H must be equal to 0"
#endif

#if (SCKEY_P2_C != 0) || (SCKEY_P2_D != 0) || (SCKEY_P2_E != 0) ||\
    (SCKEY_P2_F != 0) || (SCKEY_P2_G != 0) || (SCKEY_P2_H != 0)
#error "SCKEY_P2_C to SCKEY_P2_H must be equal to 0"
#endif

#endif


//------------------------------------------------------------------------------
// Check channels settings (for CHARGE_TRANSFER only)
//------------------------------------------------------------------------------

#if defined(CHARGE_TRANSFER)

#if (SCKEY_P1_CH == SAMP_CAP_CH)
#error "Wrong channel assigment: SCKEY_P1_CH and SAMP_CAP_CH must be different"
#endif

#if (SCKEY_P2_CH == SAMP_CAP_CH)
#error "Wrong channel assigment: SCKEY_P2_CH and SAMP_CAP_CH must be different"
#endif

#if defined(STM8L10X)

#if (SCKEY_P3_CH == SAMP_CAP_CH)
#error "Wrong channel assigment: SCKEY_P3_CH and SAMP_CAP_CH must be different"
#endif

#if (SCKEY_P4_CH == SAMP_CAP_CH)
#error "Wrong channel assigment: SCKEY_P4_CH and SAMP_CAP_CH must be different"
#endif

#endif

#if ((MCKEY1_A_CH == SAMP_CAP_CH) || (MCKEY1_B_CH == SAMP_CAP_CH) || (MCKEY1_C_CH == SAMP_CAP_CH) || (MCKEY1_D_CH == SAMP_CAP_CH) ||\
     (MCKEY1_E_CH == SAMP_CAP_CH) || (MCKEY1_F_CH == SAMP_CAP_CH) || (MCKEY1_G_CH == SAMP_CAP_CH) || (MCKEY1_H_CH == SAMP_CAP_CH))
#error "Wrong channel assigment: MCKEY1_x_CH and SAMP_CAP_CH must be different"
#endif

#if ((MCKEY2_A_CH == SAMP_CAP_CH) || (MCKEY2_B_CH == SAMP_CAP_CH) || (MCKEY2_C_CH == SAMP_CAP_CH) || (MCKEY2_D_CH == SAMP_CAP_CH) ||\
     (MCKEY2_E_CH == SAMP_CAP_CH) || (MCKEY2_F_CH == SAMP_CAP_CH) || (MCKEY2_G_CH == SAMP_CAP_CH) || (MCKEY2_H_CH == SAMP_CAP_CH))
#error "Wrong channel assigment: MCKEY2_x_CH and SAMP_CAP_CH must be different"
#endif

#endif

//----------------------------------------------------------------------------
//                       Acquisition slot selection
//----------------------------------------------------------------------------

#if defined(CHARGE_TRANSFER)

#if (NUMBER_OF_MULTI_CHANNEL_KEYS > 0)

#if (CHANNEL_PER_MCKEY == 3)

#define MCKEY1_USE_P1 (MCKEY1_A_CH == SCKEY_P1_CH)||(MCKEY1_B_CH == SCKEY_P1_CH)||(MCKEY1_C_CH == SCKEY_P1_CH)
#define MCKEY1_USE_P2 (MCKEY1_A_CH == SCKEY_P2_CH)||(MCKEY1_B_CH == SCKEY_P2_CH)||(MCKEY1_C_CH == SCKEY_P2_CH)
#if defined(SCKEY_P3_KEY_COUNT)
#define MCKEY1_USE_P3 (MCKEY1_A_CH == SCKEY_P3_CH)||(MCKEY1_B_CH == SCKEY_P3_CH)||(MCKEY1_C_CH == SCKEY_P3_CH)
#endif

#endif  // (CHANNEL_PER_MCKEY == 3)
#if (CHANNEL_PER_MCKEY == 5)

#define MCKEY1_USE_P1 (MCKEY1_A_CH == SCKEY_P1_CH)||(MCKEY1_B_CH == SCKEY_P1_CH)||(MCKEY1_C_CH == SCKEY_P1_CH)||\
  (MCKEY1_D_CH == SCKEY_P1_CH)||(MCKEY1_E_CH == SCKEY_P1_CH)
#define MCKEY1_USE_P2 (MCKEY1_A_CH == SCKEY_P2_CH)||(MCKEY1_B_CH == SCKEY_P2_CH)||(MCKEY1_C_CH == SCKEY_P2_CH)||\
  (MCKEY1_D_CH == SCKEY_P2_CH)||(MCKEY1_E_CH == SCKEY_P2_CH)
#if defined(SCKEY_P3_KEY_COUNT)
#define MCKEY1_USE_P3 (MCKEY1_A_CH == SCKEY_P3_CH)||(MCKEY1_B_CH == SCKEY_P3_CH)||(MCKEY1_C_CH == SCKEY_P3_CH)||\
  (MCKEY1_D_CH == SCKEY_P3_CH)||(MCKEY1_E_CH == SCKEY_P3_CH)
#endif

#endif  // (CHANNEL_PER_MCKEY == 5)
#if (CHANNEL_PER_MCKEY == 8)

#define MCKEY1_USE_P1 (MCKEY1_A_CH == SCKEY_P1_CH)||(MCKEY1_B_CH == SCKEY_P1_CH)||(MCKEY1_B_CH == SCKEY_P1_CH)||\
  (MCKEY1_D_CH == SCKEY_P1_CH)||(MCKEY1_E_CH == SCKEY_P1_CH)||\
  (MCKEY1_F_CH == SCKEY_P1_CH)||(MCKEY1_G_CH == SCKEY_P1_CH)||(MCKEY1_H_CH == SCKEY_P1_CH)
#define MCKEY1_USE_P2 (MCKEY1_A_CH == SCKEY_P2_CH)||(MCKEY1_B_CH == SCKEY_P2_CH)||(MCKEY1_B_CH == SCKEY_P2_CH)||\
  (MCKEY1_D_CH == SCKEY_P2_CH)||(MCKEY1_E_CH == SCKEY_P2_CH)||\
  (MCKEY1_F_CH == SCKEY_P2_CH)||(MCKEY1_G_CH == SCKEY_P2_CH)||(MCKEY1_H_CH == SCKEY_P2_CH)
#if defined(SCKEY_P3_KEY_COUNT)
#define MCKEY1_USE_P3 (MCKEY1_A_CH == SCKEY_P3_CH)||(MCKEY1_B_CH == SCKEY_P3_CH)||(MCKEY1_B_CH == SCKEY_P3_CH)||\
  (MCKEY1_D_CH == SCKEY_P3_CH)||(MCKEY1_E_CH == SCKEY_P3_CH)||\
  (MCKEY1_F_CH == SCKEY_P3_CH)||(MCKEY1_G_CH == SCKEY_P3_CH)||(MCKEY1_H_CH == SCKEY_P3_CH)
#endif

#endif  // (CHANNEL_PER_MCKEY == 8)

#endif // (NUMBER_OF_MULTI_CHANNEL_KEYS > 0)

#if (NUMBER_OF_MULTI_CHANNEL_KEYS > 1)

#if (CHANNEL_PER_MCKEY == 3)

#define MCKEY2_USE_P1 (MCKEY2_A_CH == SCKEY_P1_CH)||(MCKEY2_B_CH == SCKEY_P1_CH)||(MCKEY2_C_CH == SCKEY_P1_CH)
#define MCKEY2_USE_P2 (MCKEY2_A_CH == SCKEY_P2_CH)||(MCKEY2_B_CH == SCKEY_P2_CH)||(MCKEY2_C_CH == SCKEY_P2_CH)
#if defined(SCKEY_P3_KEY_COUNT)
#define MCKEY2_USE_P3 (MCKEY2_A_CH == SCKEY_P3_CH)||(MCKEY2_B_CH == SCKEY_P3_CH)||(MCKEY2_C_CH == SCKEY_P3_CH)
#endif

#endif  // (CHANNEL_PER_MCKEY == 3)
#if (CHANNEL_PER_MCKEY == 5)

#define MCKEY2_USE_P1 (MCKEY2_A_CH == SCKEY_P1_CH)||(MCKEY2_B_CH == SCKEY_P1_CH)||(MCKEY2_C_CH == SCKEY_P1_CH)||\
  (MCKEY2_D_CH == SCKEY_P1_CH)||(MCKEY2_E_CH == SCKEY_P1_CH)
#define MCKEY2_USE_P2 (MCKEY2_A_CH == SCKEY_P2_CH)||(MCKEY2_B_CH == SCKEY_P2_CH)||(MCKEY2_C_CH == SCKEY_P2_CH)||\
  (MCKEY2_D_CH == SCKEY_P2_CH)||(MCKEY2_E_CH == SCKEY_P2_CH)
#if defined(SCKEY_P3_KEY_COUNT)
#define MCKEY2_USE_P3 (MCKEY2_A_CH == SCKEY_P3_CH)||(MCKEY2_B_CH == SCKEY_P3_CH)||(MCKEY2_C_CH == SCKEY_P3_CH)||\
  (MCKEY2_D_CH == SCKEY_P3_CH)||(MCKEY2_E_CH == SCKEY_P3_CH)
#endif

#endif  // (CHANNEL_PER_MCKEY == 5)
#if (CHANNEL_PER_MCKEY == 8)

#define MCKEY2_USE_P1 (MCKEY2_A_CH == SCKEY_P1_CH)||(MCKEY2_B_CH == SCKEY_P1_CH)||(MCKEY2_B_CH == SCKEY_P1_CH)||\
  (MCKEY2_D_CH == SCKEY_P1_CH)||(MCKEY2_E_CH == SCKEY_P1_CH)||\
  (MCKEY2_F_CH == SCKEY_P1_CH)||(MCKEY2_G_CH == SCKEY_P1_CH)||(MCKEY2_H_CH == SCKEY_P1_CH)
#define MCKEY2_USE_P2 (MCKEY2_A_CH == SCKEY_P2_CH)||(MCKEY2_B_CH == SCKEY_P2_CH)||(MCKEY2_B_CH == SCKEY_P2_CH)||\
  (MCKEY2_D_CH == SCKEY_P2_CH)||(MCKEY2_E_CH == SCKEY_P2_CH)||\
  (MCKEY2_F_CH == SCKEY_P2_CH)||(MCKEY2_G_CH == SCKEY_P2_CH)||(MCKEY2_H_CH == SCKEY_P2_CH)
#if defined(SCKEY_P3_KEY_COUNT)
#define MCKEY2_USE_P3 (MCKEY2_A_CH == SCKEY_P3_CH)||(MCKEY2_B_CH == SCKEY_P3_CH)||(MCKEY2_B_CH == SCKEY_P3_CH)||\
  (MCKEY2_D_CH == SCKEY_P3_CH)||(MCKEY2_E_CH == SCKEY_P3_CH)||\
  (MCKEY2_F_CH == SCKEY_P3_CH)||(MCKEY2_G_CH == SCKEY_P3_CH)||(MCKEY2_H_CH == SCKEY_P3_CH)
#endif

#endif  // (CHANNEL_PER_MCKEY == 8)
#else
#define MCKEY2_USE_P1 0
#define MCKEY2_USE_P2 0
#define MCKEY2_USE_P3 0

#endif // (NUMBER_OF_MULTI_CHANNEL_KEYS > 1)

#if (SCKEY_P2_KEY_COUNT > 0)||(MCKEY1_USE_P2)||(MCKEY2_USE_P2)
#if (SCKEY_P3_KEY_COUNT > 0)||(MCKEY1_USE_P3)||(MCKEY2_USE_P3)
#define NUMBER_OF_ACQUISITION_PORTS (3)
#else
#define NUMBER_OF_ACQUISITION_PORTS (2)
#endif
#else
#define NUMBER_OF_ACQUISITION_PORTS (1)  // always used
#endif

#else //RC
#define NUMBER_OF_ACQUISITION_PORTS  NUMBER_OF_SINGLE_CHANNEL_PORTS
#endif // CT or RC

#if (NUMBER_OF_SINGLE_CHANNEL_KEYS == 0) && (NUMBER_OF_MULTI_CHANNEL_KEYS == 0)
#error "At least one key must be defined !"
#endif


//============================================================================
// TSL PARAMETERS CONFIGURATION
//============================================================================

#if !defined(NEGDETECT_AUTOCAL)
#error "Please define NEGDETECT_AUTOCAL (with value at 0 or 1)"
#endif

#if !defined(SPREAD_SPECTRUM)
#error "Please define SPREAD_SPECTRUM (with value at 0 or 1)"
#endif

#ifdef SW_SPREAD_SPECTRUM
#if !SPREAD_SPECTRUM && SW_SPREAD_SPECTRUM
#error "SW_SPREAD_SPECTRUM can only be enabled if SPREAD_SPECTRUM is enabled !"
#endif
#endif

#if (SPREAD_SPECTRUM && defined(STM8L10X)) || (SW_SPREAD_SPECTRUM &&defined(STM8L15X))
#if !SPREAD_COUNTER_MIN
#error " The SPREAD_COUNTER_MIN value must not be null !"
#endif
#endif

#if SPREAD_SPECTRUM
#if (SPREAD_COUNTER_MAX > 255) || (SPREAD_COUNTER_MAX <= SPREAD_COUNTER_MIN)
#error " The SPREAD_COUNTER_MAX value must be a 8-bit value in the range of [2 - 255] !"
#endif
#endif

#if defined(CHARGE_TRANSFER)
#ifndef ACTIVE_SHIELD_GROUP
#error "The ACTIVE_SHIELD_GROUP must be defined (set it to 0 to disable the Active Shield feature)!"
#else //ACTIVE_SHIELD_GROUP is defined
#if ACTIVE_SHIELD_GROUP
#if defined(STM8L15X)
#if (ACTIVE_SHIELD_GROUP == GROUP1)
#if (SCKEY_P1_CH == CH1)
//PA6 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOA)
#define ACTIVE_SHIELD_P1_BIT (1<<6)
#elif SCKEY_P1_CH == CH2
//PA5 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOA)
#define ACTIVE_SHIELD_P1_BIT (1<<5)
#elif SCKEY_P1_CH == CH3
//PA4 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOA)
#define ACTIVE_SHIELD_P1_BIT (1<<4)
#endif
#if (SCKEY_P2_CH == CH1)
//PA6 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOA)
#define ACTIVE_SHIELD_P2_BIT (1<<6)
#elif SCKEY_P2_CH == CH2
//PA5 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOA)
#define ACTIVE_SHIELD_P2_BIT (1<<5)
#elif SCKEY_P2_CH == CH3
//PA4 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOA)
#define ACTIVE_SHIELD_P2_BIT (1<<4)
#endif
#elif (ACTIVE_SHIELD_GROUP == GROUP2)
#if (SCKEY_P1_CH == CH1)
//PC7 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOC)
#define ACTIVE_SHIELD_P1_BIT (1<<7)
#elif SCKEY_P1_CH == CH2
//PC4 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOC)
#define ACTIVE_SHIELD_P1_BIT (1<<4)
#elif SCKEY_P1_CH == CH3
//PC3 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOC)
#define ACTIVE_SHIELD_P1_BIT (1<<3)
#endif
#if (SCKEY_P2_CH == CH1)
//PC7 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOC)
#define ACTIVE_SHIELD_P2_BIT (1<<7)
#elif SCKEY_P2_CH == CH2
//PC4 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOC)
#define ACTIVE_SHIELD_P2_BIT (1<<4)
#elif SCKEY_P2_CH == CH3
//PC3 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOC)
#define ACTIVE_SHIELD_P2_BIT (1<<3)
#endif
#elif (ACTIVE_SHIELD_GROUP == GROUP3)
#if (SCKEY_P1_CH == CH1)
//PC2 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOC)
#define ACTIVE_SHIELD_P1_BIT (1<<2)
#elif SCKEY_P1_CH == CH2
//PD7 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOD)
#define ACTIVE_SHIELD_P1_BIT (1<<7)
#elif SCKEY_P1_CH == CH3
//PD6 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOD)
#define ACTIVE_SHIELD_P1_BIT (1<<6)
#endif
#if (SCKEY_P2_CH == CH1)
//PC2 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOC)
#define ACTIVE_SHIELD_P2_BIT (1<<2)
#elif SCKEY_P2_CH == CH2
//PD7 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOD)
#define ACTIVE_SHIELD_P2_BIT (1<<7)
#elif SCKEY_P2_CH == CH3
//PD6 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOD)
#define ACTIVE_SHIELD_P2_BIT (1<<6)
#endif
#elif (ACTIVE_SHIELD_GROUP == GROUP4)
#if (SCKEY_P1_CH == CH1)
//PD5 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOD)
#define ACTIVE_SHIELD_P1_BIT (1<<5)
#elif SCKEY_P1_CH == CH2
//PD4 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOD)
#define ACTIVE_SHIELD_P1_BIT (1<<4)
#elif SCKEY_P1_CH == CH3
//PB7 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOB)
#define ACTIVE_SHIELD_P1_BIT (1<<7)
#endif
#if (SCKEY_P2_CH == CH1)
//PD5 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOD)
#define ACTIVE_SHIELD_P2_BIT (1<<5)
#elif SCKEY_P2_CH == CH2
//PD4 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOD)
#define ACTIVE_SHIELD_P2_BIT (1<<4)
#elif SCKEY_P2_CH == CH3
//PB7 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOB)
#define ACTIVE_SHIELD_P2_BIT (1<<7)
#endif
#elif (ACTIVE_SHIELD_GROUP == GROUP5)
#if (SCKEY_P1_CH == CH1)
//PB6 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOB)
#define ACTIVE_SHIELD_P1_BIT (1<<6)
#elif SCKEY_P1_CH == CH2
//PB5 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOB)
#define ACTIVE_SHIELD_P1_BIT (1<<5)
#elif SCKEY_P1_CH == CH3
//PB4 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOB)
#define ACTIVE_SHIELD_P1_BIT (1<<4)
#endif
#if (SCKEY_P2_CH == CH1)
//PB6 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOB)
#define ACTIVE_SHIELD_P2_BIT (1<<6)
#elif SCKEY_P2_CH == CH2
//PB5 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOB)
#define ACTIVE_SHIELD_P2_BIT (1<<5)
#elif SCKEY_P2_CH == CH3
//PB4 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOB)
#define ACTIVE_SHIELD_P2_BIT (1<<4)
#endif
#elif (ACTIVE_SHIELD_GROUP == GROUP6)
#if (SCKEY_P1_CH == CH1)
//PB3 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOB)
#define ACTIVE_SHIELD_P1_BIT (1<<3)
#elif SCKEY_P1_CH == CH2
//PB2 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOB)
#define ACTIVE_SHIELD_P1_BIT (1<<2)
#elif SCKEY_P1_CH == CH3
//PB1 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOB)
#define ACTIVE_SHIELD_P1_BIT (1<<1)
#endif
#if (SCKEY_P2_CH == CH1)
//PB3 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOB)
#define ACTIVE_SHIELD_P2_BIT (1<<3)
#elif SCKEY_P2_CH == CH2
//PB2 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOB)
#define ACTIVE_SHIELD_P2_BIT (1<<2)
#elif SCKEY_P2_CH == CH3
//PB1 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOB)
#define ACTIVE_SHIELD_P2_BIT (1<<1)
#endif
#elif (ACTIVE_SHIELD_GROUP == GROUP7)
#if (SCKEY_P1_CH == CH1)
//PB0 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOB)
#define ACTIVE_SHIELD_P1_BIT (1<<0)
#elif SCKEY_P1_CH == CH2
//PD3 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOD)
#define ACTIVE_SHIELD_P1_BIT (1<<3)
#elif SCKEY_P1_CH == CH3
//PD2 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOD)
#define ACTIVE_SHIELD_P1_BIT (1<<2)
#endif
#if (SCKEY_P2_CH == CH1)
//PB0 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOB)
#define ACTIVE_SHIELD_P2_BIT (1<<0)
#elif SCKEY_P2_CH == CH2
//PD3 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOD)
#define ACTIVE_SHIELD_P2_BIT (1<<3)
#elif SCKEY_P2_CH == CH3
//PD2 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOD)
#define ACTIVE_SHIELD_P2_BIT (1<<2)
#endif
#elif (ACTIVE_SHIELD_GROUP == GROUP8)
#if (SCKEY_P1_CH == CH1)
//PD1 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOD)
#define ACTIVE_SHIELD_P1_BIT (1<<1)
#elif SCKEY_P1_CH == CH2
//PD0 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOD)
#define ACTIVE_SHIELD_P1_BIT (1<<0)
#elif SCKEY_P1_CH == CH3
//PE5 define as active shield for port1
#define ACTIVE_SHIELD_P1_PORT (GPIOE)
#define ACTIVE_SHIELD_P1_BIT (1<<5)
#endif
#if (SCKEY_P2_CH == CH1)
//PD1 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOD)
#define ACTIVE_SHIELD_P2_BIT (1<<1)
#elif SCKEY_P2_CH == CH2
//PD0 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOD)
#define ACTIVE_SHIELD_P2_BIT (1<<0)
#elif SCKEY_P2_CH == CH3
//PE5 define as active shield for port2
#define ACTIVE_SHIELD_P2_PORT (GPIOE)
#define ACTIVE_SHIELD_P2_BIT (1<<5)
#endif
#else
#error "ACTIVE_SHIELD_GROUP must be a GROUP number i.e. a 8-bit value with only one bit set !"
#endif // end of #if (ACTIVE.... != GROUPx)

#else // (STM8L10X)
#if (!(ACTIVE_SHIELD_GROUP == GROUP1) || (ACTIVE_SHIELD_GROUP == GROUP2) || (ACTIVE_SHIELD_GROUP == GROUP3))
#error " ACTIVE_SHIELD_GROUP must be a GROUP number i.e. GROUP1, GROUP2 or  GROUP3 for STM8L10X!"
#endif // end of #if (ACTIVE.... != GROUPx)

#endif //end of #ifdef (STM8L15X) #else
#if (ACTIVE_SHIELD_GROUP == SCKEY_P1_A) || (ACTIVE_SHIELD_GROUP == SCKEY_P2_A) || (ACTIVE_SHIELD_GROUP == SCKEY_P3_A) || \
    (ACTIVE_SHIELD_GROUP == SCKEY_P1_B) || (ACTIVE_SHIELD_GROUP == SCKEY_P2_B) || (ACTIVE_SHIELD_GROUP == SCKEY_P3_B) || \
    (ACTIVE_SHIELD_GROUP == SCKEY_P1_C) || (ACTIVE_SHIELD_GROUP == SCKEY_P2_C) || \
    (ACTIVE_SHIELD_GROUP == SCKEY_P1_D) || (ACTIVE_SHIELD_GROUP == SCKEY_P2_D) || \
    (ACTIVE_SHIELD_GROUP == SCKEY_P1_E) || (ACTIVE_SHIELD_GROUP == SCKEY_P2_E) || \
    (ACTIVE_SHIELD_GROUP == SCKEY_P1_F) || (ACTIVE_SHIELD_GROUP == SCKEY_P2_F) || \
    (ACTIVE_SHIELD_GROUP == SCKEY_P1_G) || (ACTIVE_SHIELD_GROUP == SCKEY_P2_G) || \
    (ACTIVE_SHIELD_GROUP == SCKEY_P1_H) || (ACTIVE_SHIELD_GROUP == SCKEY_P2_H) || \
 (ACTIVE_SHIELD_GROUP == MCKEY1_A)   || (ACTIVE_SHIELD_GROUP == MCKEY2_A)   || \
 (ACTIVE_SHIELD_GROUP == MCKEY1_B)   || (ACTIVE_SHIELD_GROUP == MCKEY2_B)   || \
 (ACTIVE_SHIELD_GROUP == MCKEY1_C)   || (ACTIVE_SHIELD_GROUP == MCKEY2_C)   || \
 (ACTIVE_SHIELD_GROUP == MCKEY1_D)   || (ACTIVE_SHIELD_GROUP == MCKEY2_D)   || \
 (ACTIVE_SHIELD_GROUP == MCKEY1_E)   || (ACTIVE_SHIELD_GROUP == MCKEY2_E)   || \
 (ACTIVE_SHIELD_GROUP == MCKEY1_F)   || (ACTIVE_SHIELD_GROUP == MCKEY2_F)   || \
 (ACTIVE_SHIELD_GROUP == MCKEY1_G)   || (ACTIVE_SHIELD_GROUP == MCKEY2_G)   || \
 (ACTIVE_SHIELD_GROUP == MCKEY1_H)   || (ACTIVE_SHIELD_GROUP == MCKEY2_H)
#error "ACTIVE_SHIELD_GROUP cannot be a group used for a key !"
#endif // end of #if (ACTIVE....== SCKEY_Pn_X)
#endif //end of #if ACTIVE_SHIELD_GROUP
#endif //end of #ifndef ACTIVE_SHIELD_GROUP #else
#endif //end of #if defined(STM8L10X) || defined(STM8L15X)

//------------------------------------------------------------------------------
// Define the INLINE macro
//------------------------------------------------------------------------------
#if USE_INLINED_FUNCTIONS
#if defined(_COSMIC_)
#define INLINE @inline
#elif defined(_RAISONANCE_) // || defined(_IAR_)
#define INLINE inline
#elif defined(_IAR_)
/*<< IAR doesn't managed the global variables in inlined functions, so inlining is not supported in this released for IAR */
#define INLINE
#else
#error "Compiler not Supported"
#endif
#else
#define INLINE
#endif

#endif /* __TSL_CHECKCONFIG_H */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
