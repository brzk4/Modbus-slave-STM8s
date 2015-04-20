/**
  ******************************************************************************
  * @file    stm8l10x_tsl_ct_acquisition.c
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file provides all the functions
  *          to manage the Charge-Transfer acquisition based on STM8L10x devices.
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

/* Includes ------------------------------------------------------------------*/
#include "stm8l10x_tsl_ct_acquisition.h"
#include "stm8_tsl_services.h"

#if defined(CHARGE_TRANSFER) && defined(STM8L10X)
/* This file is use only with the STM8L10x product */

/* ---------------    SECTION DEFINITION FOR THIS FILE   ---------------------*/
#if defined(_COSMIC_) && defined(USE_PRAGMA_SECTION)
#pragma section [TSL_IO_RAM]
#pragma section @tiny [TSL_IO_RAM0]
#pragma section const {TSL_IO_CONST}
#pragma section (TSL_IO_CODE)
#endif

#if SPREAD_SPECTRUM
static u8 SpreadCounter;

u8 Previous_calibration_value;
#endif


/*define the SAMPLING capacitor comparator channel mask*/
#if   (SAMP_CAP_CH == CH1)
/*define the sampling capacitor port*/
#define SAMP_CAP_PORT       (GPIOB)
#define SAMP_CAP_IO_MASK_1  (0x01) /*PB0*/
#define SAMP_CAP_IO_MASK_2  (0x04) /*PB2*/
/*both comparators are used*/
#if defined(COMP1) && defined(COMP2)
#define SAMP_CAP_COMP_MASK (0x11)
#define SAMP_CAP_IO_MASK   (0x05) /*PB2 and PB0*/
#elif defined(COMP1)
/*only the comparator 1 is used*/
#define SAMP_CAP_COMP_MASK (0x01)
#define SAMP_CAP_IO_MASK   (0x01) /*PB0*/
#elif defined(COMP2)
/*only the comparator 2 is used*/
#define SAMP_CAP_COMP_MASK (0x10)
#define SAMP_CAP_IO_MASK   (0x04) /*PB2*/
#else
#error "COMPARATOR definition wrong"
#endif

#elif (SAMP_CAP_CH == CH2)
#define SAMP_CAP_PORT       (GPIOB)
#define SAMP_CAP_IO_MASK_1  (0x02) /*PB1*/
#define SAMP_CAP_IO_MASK_2  (0x08) /*PB3*/
/*both comparators are used*/
#if defined(COMP1) && defined(COMP2)
#define SAMP_CAP_COMP_MASK (0x22)
#define SAMP_CAP_IO_MASK   (0x0A) /*PB3 and PB1*/
#elif defined(COMP1)
/*only the comparator 1 is used*/
#define SAMP_CAP_COMP_MASK (0x02)
#define SAMP_CAP_IO_MASK   (0x02) /*PB1*/
#elif defined(COMP2)
/*only the comparator 2 is used*/
#define SAMP_CAP_COMP_MASK (0x20)
#define SAMP_CAP_IO_MASK   (0x08) /*PB3*/
#else
#error "COMPARATOR definition wrong"
#endif

#elif (SAMP_CAP_CH == CH3)
#define SAMP_CAP_PORT       (GPIOD)
#define SAMP_CAP_IO_MASK_1  (0x01) /*PD0*/
#define SAMP_CAP_IO_MASK_2  (0x04) /*PD2*/
/*both comparators are used*/
#if defined(COMP1) && defined(COMP2)
#define SAMP_CAP_COMP_MASK (0x44)
#define SAMP_CAP_IO_MASK   (0x05) /*PD2 and PD0*/
#elif defined(COMP1)
/*only the comparator 1 is used*/
#define SAMP_CAP_COMP_MASK (0x04)
#define SAMP_CAP_IO_MASK   (0x01) /*PD0*/
#elif defined(COMP2)
/*only the comparator 2 is used*/
#define SAMP_CAP_COMP_MASK (0x40)
#define SAMP_CAP_IO_MASK   (0x04) /*PD2*/
#else
#error "COMPARATOR definition wrong"
#endif

#elif (SAMP_CAP_CH == CH4)
#define SAMP_CAP_PORT       (GPIOD)
#define SAMP_CAP_IO_MASK_1  (0x02) /*PD1*/
#define SAMP_CAP_IO_MASK_2  (0x08) /*PD3*/
/*both comparators are used*/
#if defined(COMP1) && defined(COMP2)
#define SAMP_CAP_COMP_MASK (0x88)
#define SAMP_CAP_IO_MASK   (0x0A) /*PD3 and PD1*/
#elif defined(COMP1)
/*only the comparator 1 is used*/
#define SAMP_CAP_COMP_MASK (0x08)
#define SAMP_CAP_IO_MASK   (0x02) /*PD1*/
#elif defined(COMP2)
/*only the comparator 2 is used*/
#define SAMP_CAP_COMP_MASK (0x80)
#define SAMP_CAP_IO_MASK   (0x08) /*PD3*/
#else
#error "COMPARATOR definition wrong"
#endif

#endif

/*define the PORT1 comparator channel mask*/
#if   ((SCKEY_P1_CH == CH1) || MKEY_CH1_MASK)
#define P1_PORT        (GPIOB)
#define P1_IO_MASK_1   (0x01) /*PB0*/
#define P1_IO_MASK_2   (0x04) /*PB2*/
#if (SCKEY_P1_CH == CH1)
#if ((SCKEY_P1_A == GROUP1) && (SCKEY_P1_B == GROUP2)) || ((SCKEY_P1_A == GROUP2) && (SCKEY_P1_B == GROUP1))
#define SCKEY_P1_COMP_MASK  (0x11)
#define SCKEY_P1_IO_MASK    (0x05) /*PB2 and PB0*/
#define SCKEY_P1_STATE_MASK (0x03)
#elif (SCKEY_P1_A == GROUP1) || (SCKEY_P1_B == GROUP1)
#define SCKEY_P1_COMP_MASK  (0x01)
#define SCKEY_P1_IO_MASK    (0x01) /*PB0*/
#define SCKEY_P1_STATE_MASK (0x01)
#elif (SCKEY_P1_A == GROUP2) || (SCKEY_P1_B == GROUP2)
#define SCKEY_P1_COMP_MASK  (0x10)
#define SCKEY_P1_IO_MASK    (0x04) /*PB2*/
#define SCKEY_P1_STATE_MASK (0x02)
#else
#define SCKEY_P1_COMP_MASK  (0x00)
#define SCKEY_P1_IO_MASK    (0x00)
#define SCKEY_P1_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P1_COMP_MASK  (0x00)
#define SCKEY_P1_IO_MASK    (0x00)
#define SCKEY_P1_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P1_CH == CH1)
/*Multi channel key*/
#if (MKEY_CH1_MASK == (GROUP1|GROUP2))
#define MCKEY_P1_COMP_MASK  (0x11)
#define MCKEY_P1_IO_MASK    (0x05) /*PB0 and PB2*/
#define MCKEY_P1_STATE_MASK (0x03)
#elif MKEY_CH1_MASK == GROUP1
#define MCKEY_P1_COMP_MASK  (0x01)
#define MCKEY_P1_IO_MASK    (0x01) /*PB0*/
#define MCKEY_P1_STATE_MASK (0x01)
#elif MKEY_CH1_MASK == GROUP2
#define MCKEY_P1_COMP_MASK  (0x10)
#define MCKEY_P1_IO_MASK    (0x04)/*PB2*/
#define MCKEY_P1_STATE_MASK (0x02)
#else
#define MCKEY_P1_COMP_MASK  (0x00)
#define MCKEY_P1_IO_MASK    (0x00)
#define MCKEY_P1_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P1_COMP_MASK  (0x01)
#define ASHLD_P1_IO_MASK    (0x01) /*PB0*/
#define ASHLD_P1_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P1_COMP_MASK  (0x10)
#define ASHLD_P1_IO_MASK    (0x04) /*PB2*/
#define ASHLD_P1_STATE_MASK (0x02)
#else
#define ASHLD_P1_COMP_MASK  (0x00)
#define ASHLD_P1_IO_MASK    (0x00)
#define ASHLD_P1_STATE_MASK (0x00)
#endif

#define P1_COMP_MASK  (SCKEY_P1_COMP_MASK | MCKEY_P1_COMP_MASK | ASHLD_P1_COMP_MASK)
#define P1_IO_MASK    (SCKEY_P1_IO_MASK | MCKEY_P1_IO_MASK | ASHLD_P1_IO_MASK)
#define P1_STATE_MASK (SCKEY_P1_STATE_MASK | MCKEY_P1_STATE_MASK | ASHLD_P1_STATE_MASK)

#elif ((SCKEY_P1_CH == CH2) || MKEY_CH2_MASK)
#define P1_PORT        (GPIOB)
#define P1_IO_MASK_1   (0x02) /*PB1*/
#define P1_IO_MASK_2   (0x08) /*PB3*/
#if (SCKEY_P1_CH == CH2)
#if ((SCKEY_P1_A == GROUP1) && (SCKEY_P1_B == GROUP2)) || ((SCKEY_P1_A == GROUP2) && (SCKEY_P1_B == GROUP1))
#define SCKEY_P1_COMP_MASK  (0x22)
#define SCKEY_P1_IO_MASK    (0x0A) /*PB3 and PB1*/
#define SCKEY_P1_STATE_MASK (0x03)
#elif (SCKEY_P1_A == GROUP1) || (SCKEY_P1_B == GROUP1)
#define SCKEY_P1_COMP_MASK  (0x02)
#define SCKEY_P1_IO_MASK    (0x02) /*PB1*/
#define SCKEY_P1_STATE_MASK (0x01)
#elif (SCKEY_P1_A == GROUP2) || (SCKEY_P1_B == GROUP2)
#define SCKEY_P1_COMP_MASK  (0x20)
#define SCKEY_P1_IO_MASK    (0x08) /*PB3*/
#define SCKEY_P1_STATE_MASK (0x02)
#else
#define SCKEY_P1_COMP_MASK  (0x00)
#define SCKEY_P1_IO_MASK    (0x00)
#define SCKEY_P1_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P1_COMP_MASK  (0x00)
#define SCKEY_P1_IO_MASK    (0x00)
#define SCKEY_P1_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P1_CH == CH2)
/*Multi channel key*/
#if MKEY_CH2_MASK == (GROUP1|GROUP2)
#define MCKEY_P1_COMP_MASK  (0x22)
#define MCKEY_P1_IO_MASK    (0x0A) /*PB1 and PB3*/
#define MCKEY_P1_STATE_MASK (0x03)
#elif MKEY_CH2_MASK == GROUP1
#define MCKEY_P1_COMP_MASK  (0x02)
#define MCKEY_P1_IO_MASK    (0x02) /*PB1*/
#define MCKEY_P1_STATE_MASK (0x01)
#elif MKEY_CH2_MASK == GROUP2
#define MCKEY_P1_COMP_MASK  (0x20)
#define MCKEY_P1_IO_MASK    (0x08) /*PB3*/
#define MCKEY_P1_STATE_MASK (0x02)
#else
#define MCKEY_P1_COMP_MASK  (0x00)
#define MCKEY_P1_IO_MASK    (0x00)
#define MCKEY_P1_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P1_COMP_MASK  (0x02)
#define ASHLD_P1_IO_MASK    (0x02) /*PB1*/
#define ASHLD_P1_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P1_COMP_MASK  (0x20)
#define ASHLD_P1_IO_MASK    (0x08) /*PB3*/
#define ASHLD_P1_STATE_MASK (0x02)
#else
#define ASHLD_P1_COMP_MASK  (0x00)
#define ASHLD_P1_IO_MASK    (0x00)
#define ASHLD_P1_STATE_MASK (0x00)
#endif
#define P1_COMP_MASK  (SCKEY_P1_COMP_MASK | MCKEY_P1_COMP_MASK | ASHLD_P1_COMP_MASK)
#define P1_IO_MASK    (SCKEY_P1_IO_MASK | MCKEY_P1_IO_MASK | ASHLD_P1_IO_MASK)
#define P1_STATE_MASK (SCKEY_P1_STATE_MASK | MCKEY_P1_STATE_MASK | ASHLD_P1_STATE_MASK)

#elif ((SCKEY_P1_CH == CH3) || MKEY_CH3_MASK)
#define P1_PORT        (GPIOD)
#define P1_IO_MASK_1   (0x01) /*PD0*/
#define P1_IO_MASK_2   (0x04) /*PD2*/
#if (SCKEY_P1_CH == CH3)
/*single channel key*/
#if ((SCKEY_P1_A == GROUP1) && (SCKEY_P1_B == GROUP2)) || ((SCKEY_P1_A == GROUP2) && (SCKEY_P1_B == GROUP1))
#define SCKEY_P1_COMP_MASK  (0x44)
#define SCKEY_P1_IO_MASK    (0x05) /*PD2 and PD0*/
#define SCKEY_P1_STATE_MASK (0x03)
#elif (SCKEY_P1_A == GROUP1) || (SCKEY_P1_B == GROUP1)
#define SCKEY_P1_COMP_MASK  (0x04)
#define SCKEY_P1_IO_MASK    (0x01) /*PD0*/
#define SCKEY_P1_STATE_MASK (0x01)
#elif (SCKEY_P1_A == GROUP2) || (SCKEY_P1_B == GROUP2)
#define SCKEY_P1_COMP_MASK  (0x40) /*PD2*/
#define SCKEY_P1_IO_MASK    (0x04)
#define SCKEY_P1_STATE_MASK (0x02)
#else
#define SCKEY_P1_COMP_MASK  (0x00)
#define SCKEY_P1_IO_MASK    (0x00)
#define SCKEY_P1_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P1_COMP_MASK  (0x00)
#define SCKEY_P1_IO_MASK    (0x00)
#define SCKEY_P1_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P1_CH == CH3)
/*Multi channel key*/
#if MKEY_CH3_MASK == (GROUP1|GROUP2)
#define MCKEY_P1_COMP_MASK  (0x44)
#define MCKEY_P1_IO_MASK    (0x05) /*PD2 and PD0*/
#define MCKEY_P1_STATE_MASK (0x03)
#elif MKEY_CH3_MASK == GROUP1
#define MCKEY_P1_COMP_MASK  (0x04)
#define MCKEY_P1_IO_MASK    (0x01) /*PD0*/
#define MCKEY_P1_STATE_MASK (0x01)
#elif MKEY_CH3_MASK == GROUP2
#define MCKEY_P1_COMP_MASK  (0x40) /*PD2*/
#define MCKEY_P1_IO_MASK    (0x04)
#define MCKEY_P1_STATE_MASK (0x02)
#else
#define MCKEY_P1_COMP_MASK  (0x00)
#define MCKEY_P1_IO_MASK    (0x00)
#define MCKEY_P1_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P1_COMP_MASK  (0x04)
#define ASHLD_P1_IO_MASK    (0x01) /*PD0*/
#define ASHLD_P1_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P1_COMP_MASK  (0x40)
#define ASHLD_P1_IO_MASK    (0x04) /*PD2*/
#define ASHLD_P1_STATE_MASK (0x02)
#else
#define ASHLD_P1_COMP_MASK  (0x00)
#define ASHLD_P1_IO_MASK    (0x00)
#define ASHLD_P1_STATE_MASK (0x00)
#endif

#define P1_COMP_MASK  (SCKEY_P1_COMP_MASK | MCKEY_P1_COMP_MASK | ASHLD_P1_COMP_MASK)
#define P1_IO_MASK    (SCKEY_P1_IO_MASK | MCKEY_P1_IO_MASK | ASHLD_P1_IO_MASK)
#define P1_STATE_MASK (SCKEY_P1_STATE_MASK | MCKEY_P1_STATE_MASK | ASHLD_P1_STATE_MASK)

#elif ((SCKEY_P1_CH == CH4) || MKEY_CH4_MASK)
#define P1_PORT              (GPIOD)
#define P1_IO_MASK_1         (0x02) /*PB1*/
#define P1_IO_MASK_2         (0x08) /*PB3*/
#if (SCKEY_P1_CH == CH4)
/*Single channel key*/
#if ((SCKEY_P1_A == GROUP1) && (SCKEY_P1_B == GROUP2)) || ((SCKEY_P1_A == GROUP2) && (SCKEY_P1_B == GROUP1))
#define SCKEY_P1_COMP_MASK  (0x88)
#define SCKEY_P1_IO_MASK    (0x0A) /*PD3 and PD1*/
#define SCKEY_P1_STATE_MASK (0x03)
#elif (SCKEY_P1_A == GROUP1) || (SCKEY_P1_B == GROUP1)
#define SCKEY_P1_COMP_MASK  (0x08)
#define SCKEY_P1_IO_MASK    (0x02) /*PD1*/
#define SCKEY_P1_STATE_MASK (0x01)
#elif (SCKEY_P1_A == GROUP2) || (SCKEY_P1_B == GROUP2)
#define SCKEY_P1_COMP_MASK  (0x80) /*PD3*/
#define SCKEY_P1_IO_MASK    (0x08)
#define SCKEY_P1_STATE_MASK (0x02)
#else
#define SCKEY_P1_COMP_MASK  (0x00)
#define SCKEY_P1_IO_MASK    (0x00)
#define SCKEY_P1_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P1_COMP_MASK  (0x00)
#define SCKEY_P1_IO_MASK    (0x00)
#define SCKEY_P1_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P1_CH == CH4)
/*Multi channel key*/
#if MKEY_CH4_MASK == (GROUP1|GROUP2)
#define MCKEY_P1_COMP_MASK  (0x88)
#define MCKEY_P1_IO_MASK    (0x0A) /*PD3 and PD1*/
#define MCKEY_P1_STATE_MASK (0x03)
#elif MKEY_CH4_MASK == GROUP1
#define MCKEY_P1_COMP_MASK  (0x08)
#define MCKEY_P1_IO_MASK    (0x02) /*PD1*/
#define MCKEY_P1_STATE_MASK (0x01)
#elif MKEY_CH4_MASK == GROUP2
#define MCKEY_P1_COMP_MASK  (0x80) /*PD3*/
#define MCKEY_P1_IO_MASK    (0x08)
#define MCKEY_P1_STATE_MASK (0x02)
#else
#define MCKEY_P1_COMP_MASK  (0x00)
#define MCKEY_P1_IO_MASK    (0x00)
#define MCKEY_P1_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P1_COMP_MASK  (0x08)
#define ASHLD_P1_IO_MASK    (0x02) /*PD1*/
#define ASHLD_P1_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P1_COMP_MASK  (0x80)
#define ASHLD_P1_IO_MASK    (0x08) /*PD3*/
#define ASHLD_P1_STATE_MASK (0x02)
#else
#define ASHLD_P1_COMP_MASK  (0x00)
#define ASHLD_P1_IO_MASK    (0x00)
#define ASHLD_P1_STATE_MASK (0x00)
#endif
#define P1_COMP_MASK  (SCKEY_P1_COMP_MASK | MCKEY_P1_COMP_MASK | ASHLD_P1_COMP_MASK)
#define P1_IO_MASK    (SCKEY_P1_IO_MASK | MCKEY_P1_IO_MASK | ASHLD_P1_IO_MASK)
#define P1_STATE_MASK (SCKEY_P1_STATE_MASK | MCKEY_P1_STATE_MASK | ASHLD_P1_STATE_MASK)

#else
#error "Wrong Channel selection for SCKEY_P1 or MKEY_CHn_MASK"
#endif


#if NUMBER_OF_ACQUISITION_PORTS > 1
/*define the PORT2 comparator channel mask*/
#if   ((SCKEY_P2_CH == CH1) || MKEY_CH1_MASK)
#define P2_PORT        (GPIOB)
#define P2_IO_MASK_1   (0x01) /*PB0*/
#define P2_IO_MASK_2   (0x04) /*PB2*/
#if   (SCKEY_P2_CH == CH1)
#if ((SCKEY_P2_A == GROUP1) && (SCKEY_P2_B == GROUP2)) || ((SCKEY_P2_A == GROUP2) && (SCKEY_P2_B == GROUP1))
#define SCKEY_P2_COMP_MASK  (0x11)
#define SCKEY_P2_IO_MASK    (0x05) /*PB2 and PB0*/
#define SCKEY_P2_STATE_MASK (0x03)
#elif (SCKEY_P2_A == GROUP1) || (SCKEY_P2_B == GROUP1)
#define SCKEY_P2_COMP_MASK  (0x01)
#define SCKEY_P2_IO_MASK    (0x01) /*PB0*/
#define SCKEY_P2_STATE_MASK (0x01)
#elif (SCKEY_P2_A == GROUP2) || (SCKEY_P2_B == GROUP2)
#define SCKEY_P2_COMP_MASK  (0x10)
#define SCKEY_P2_IO_MASK    (0x04) /*PB2*/
#define SCKEY_P2_STATE_MASK (0x02)
#else
#define SCKEY_P2_COMP_MASK  (0x00)
#define SCKEY_P2_IO_MASK    (0x00)
#define SCKEY_P2_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P2_COMP_MASK  (0x00)
#define SCKEY_P2_IO_MASK    (0x00)
#define SCKEY_P2_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P2_CH == CH1)
/*Multi channel key*/
#if MKEY_CH1_MASK == (GROUP1|GROUP2)
#define MCKEY_P2_COMP_MASK  (0x11)
#define MCKEY_P2_IO_MASK    (0x05) /*PB2 and PB0*/
#define MCKEY_P2_STATE_MASK (0x03)
#elif MKEY_CH1_MASK == GROUP1
#define MCKEY_P2_COMP_MASK  (0x01)
#define MCKEY_P2_IO_MASK    (0x01) /*PB0*/
#define MCKEY_P2_STATE_MASK (0x01)
#elif MKEY_CH1_MASK == GROUP2
#define MCKEY_P2_COMP_MASK  (0x10) /*PB2*/
#define MCKEY_P2_IO_MASK    (0x04)
#define MCKEY_P2_STATE_MASK (0x02)
#else
#define MCKEY_P2_COMP_MASK  (0x00)
#define MCKEY_P2_IO_MASK    (0x00)
#define MCKEY_P2_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P2_COMP_MASK  (0x01)
#define ASHLD_P2_IO_MASK    (0x01) /*PB0*/
#define ASHLD_P2_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P2_COMP_MASK  (0x10)
#define ASHLD_P2_IO_MASK    (0x04) /*PB2*/
#define ASHLD_P2_STATE_MASK (0x02)
#else
#define ASHLD_P2_COMP_MASK  (0x00)
#define ASHLD_P2_IO_MASK    (0x00)
#define ASHLD_P2_STATE_MASK (0x00)
#endif

#define P2_COMP_MASK  (SCKEY_P2_COMP_MASK | MCKEY_P2_COMP_MASK | ASHLD_P2_COMP_MASK)
#define P2_IO_MASK    (SCKEY_P2_IO_MASK | MCKEY_P2_IO_MASK | ASHLD_P2_IO_MASK)
#define P2_STATE_MASK (SCKEY_P2_STATE_MASK | MCKEY_P2_STATE_MASK | ASHLD_P2_STATE_MASK)

#elif ((SCKEY_P2_CH == CH2) || MKEY_CH2_MASK)
#define P2_PORT        (GPIOB)
#define P2_IO_MASK_1   (0x02) /*PB1*/
#define P2_IO_MASK_2   (0x08) /*PB3*/
#if (SCKEY_P2_CH == CH2)
#if ((SCKEY_P2_A == GROUP1) && (SCKEY_P2_B == GROUP2)) || ((SCKEY_P2_A == GROUP2) && (SCKEY_P2_B == GROUP1))
#define SCKEY_P2_COMP_MASK  (0x22)
#define SCKEY_P2_IO_MASK    (0x0A) /*PB3 and PB1*/
#define SCKEY_P2_STATE_MASK (0x03)
#elif (SCKEY_P2_A == GROUP1) || (SCKEY_P2_B == GROUP1)
#define SCKEY_P2_COMP_MASK  (0x02)
#define SCKEY_P2_IO_MASK    (0x02) /*PB1*/
#define SCKEY_P2_STATE_MASK (0x01)
#elif (SCKEY_P2_A == GROUP2) || (SCKEY_P2_B == GROUP2)
#define SCKEY_P2_COMP_MASK  (0x20)
#define SCKEY_P2_IO_MASK    (0x08) /*PB3*/
#define SCKEY_P2_STATE_MASK (0x02)
#else
#define SCKEY_P2_COMP_MASK  (0x00)
#define SCKEY_P2_IO_MASK    (0x00)
#define SCKEY_P2_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P2_COMP_MASK  (0x00)
#define SCKEY_P2_IO_MASK    (0x00)
#define SCKEY_P2_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P2_CH == CH2)
/*Multi channel key*/
#if MKEY_CH2_MASK == (GROUP1|GROUP2)
#define MCKEY_P2_COMP_MASK  (0x22)
#define MCKEY_P2_IO_MASK    (0x0A) /*PB1 and PB3*/
#define MCKEY_P2_STATE_MASK (0x03)
#elif MKEY_CH2_MASK == GROUP1
#define MCKEY_P2_COMP_MASK  (0x02)
#define MCKEY_P2_IO_MASK    (0x02) /*PB1*/
#define MCKEY_P2_STATE_MASK (0x01)
#elif MKEY_CH2_MASK == GROUP2
#define MCKEY_P2_COMP_MASK  (0x20) /*PB3*/
#define MCKEY_P2_IO_MASK    (0x08)
#define MCKEY_P2_STATE_MASK (0x02)
#else
#define MCKEY_P2_COMP_MASK  (0x00)
#define MCKEY_P2_IO_MASK    (0x00)
#define MCKEY_P2_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P2_COMP_MASK  (0x02)
#define ASHLD_P2_IO_MASK    (0x02) /*PB1*/
#define ASHLD_P2_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P2_COMP_MASK  (0x20)
#define ASHLD_P2_IO_MASK    (0x08) /*PB3*/
#define ASHLD_P2_STATE_MASK (0x02)
#else
#define ASHLD_P2_COMP_MASK  (0x00)
#define ASHLD_P2_IO_MASK    (0x00)
#define ASHLD_P2_STATE_MASK (0x00)
#endif

#define P2_COMP_MASK  (SCKEY_P2_COMP_MASK | MCKEY_P2_COMP_MASK | ASHLD_P2_COMP_MASK)
#define P2_IO_MASK    (SCKEY_P2_IO_MASK | MCKEY_P2_IO_MASK | ASHLD_P2_IO_MASK)
#define P2_STATE_MASK (SCKEY_P2_STATE_MASK | MCKEY_P2_STATE_MASK | ASHLD_P2_STATE_MASK)

#elif ((SCKEY_P2_CH == CH3) || MKEY_CH3_MASK)
#define P2_PORT        (GPIOD)
#define P2_IO_MASK_1   (0x01) /*PD0*/
#define P2_IO_MASK_2   (0x04) /*PD2*/
#if (SCKEY_P2_CH == CH3)
/*single channel key*/
#if ((SCKEY_P2_A == GROUP1) && (SCKEY_P2_B == GROUP2)) || ((SCKEY_P2_A == GROUP2) && (SCKEY_P2_B == GROUP1))
#define SCKEY_P2_COMP_MASK  (0x44)
#define SCKEY_P2_IO_MASK    (0x05) /*PD2 and PD0*/
#define SCKEY_P2_STATE_MASK (0x03)
#elif (SCKEY_P2_A == GROUP1) || (SCKEY_P2_B == GROUP1)
#define SCKEY_P2_COMP_MASK  (0x04)
#define SCKEY_P2_IO_MASK    (0x01) /*PD0*/
#define SCKEY_P2_STATE_MASK (0x01)
#elif (SCKEY_P2_A == GROUP2) || (SCKEY_P2_B == GROUP2)
#define SCKEY_P2_COMP_MASK  (0x40) /*PD2*/
#define SCKEY_P2_IO_MASK    (0x04)
#define SCKEY_P2_STATE_MASK (0x02)
#else
#define SCKEY_P2_COMP_MASK  (0x00)
#define SCKEY_P2_IO_MASK    (0x00)
#define SCKEY_P2_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P2_COMP_MASK  (0x00)
#define SCKEY_P2_IO_MASK    (0x00)
#define SCKEY_P2_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P2_CH == CH3)
/*Multi channel key*/
#if MKEY_CH3_MASK == (GROUP1|GROUP2)
#define MCKEY_P2_COMP_MASK  (0x44)
#define MCKEY_P2_IO_MASK    (0x05) /*PD2 and PD0*/
#define MCKEY_P2_STATE_MASK (0x03)
#elif MKEY_CH3_MASK == GROUP1
#define MCKEY_P2_COMP_MASK  (0x04)
#define MCKEY_P2_IO_MASK    (0x01) /*PD0*/
#define MCKEY_P2_STATE_MASK (0x01)
#elif MKEY_CH3_MASK == GROUP2
#define MCKEY_P2_COMP_MASK  (0x40) /*PD2*/
#define MCKEY_P2_IO_MASK    (0x04)
#define MCKEY_P2_STATE_MASK (0x02)
#else
#define MCKEY_P2_COMP_MASK  (0x00)
#define MCKEY_P2_IO_MASK    (0x00)
#define MCKEY_P2_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P2_COMP_MASK  (0x04)
#define ASHLD_P2_IO_MASK    (0x01) /*PD0*/
#define ASHLD_P2_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P2_COMP_MASK  (0x40)
#define ASHLD_P2_IO_MASK    (0x04) /*PD2*/
#define ASHLD_P2_STATE_MASK (0x02)
#else
#define ASHLD_P2_COMP_MASK  (0x00)
#define ASHLD_P2_IO_MASK    (0x00)
#define ASHLD_P2_STATE_MASK (0x00)
#endif

#define P2_COMP_MASK  (SCKEY_P2_COMP_MASK | MCKEY_P2_COMP_MASK | ASHLD_P2_COMP_MASK)
#define P2_IO_MASK    (SCKEY_P2_IO_MASK | MCKEY_P2_IO_MASK | ASHLD_P2_IO_MASK)
#define P2_STATE_MASK (SCKEY_P2_STATE_MASK | MCKEY_P2_STATE_MASK | ASHLD_P2_STATE_MASK)

#elif ((SCKEY_P2_CH == CH4) || MKEY_CH4_MASK)
#define P2_PORT              (GPIOD)
#define P2_IO_MASK_1         (0x02) /*PD1*/
#define P2_IO_MASK_2         (0x08) /*PD3*/
#if (SCKEY_P2_CH == CH4)
/*Single channel key*/
#if ((SCKEY_P2_A == GROUP1) && (SCKEY_P2_B == GROUP2)) || ((SCKEY_P2_A == GROUP2) && (SCKEY_P2_B == GROUP1))
#define SCKEY_P2_COMP_MASK  (0x88)
#define SCKEY_P2_IO_MASK    (0x0A) /*PD3 and PD1*/
#define SCKEY_P2_STATE_MASK (0x03)
#elif (SCKEY_P2_A == GROUP1) || (SCKEY_P2_B == GROUP1)
#define SCKEY_P2_COMP_MASK  (0x08)
#define SCKEY_P2_IO_MASK    (0x02) /*PD1*/
#define SCKEY_P2_STATE_MASK (0x01)
#elif (SCKEY_P2_A == GROUP2) || (SCKEY_P2_B == GROUP2)
#define SCKEY_P2_COMP_MASK  (0x80) /*PD3*/
#define SCKEY_P2_IO_MASK    (0x08)
#define SCKEY_P2_STATE_MASK (0x02)
#else
#define SCKEY_P2_COMP_MASK  (0x00)
#define SCKEY_P2_IO_MASK    (0x00)
#define SCKEY_P2_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P2_COMP_MASK  (0x00)
#define SCKEY_P2_IO_MASK    (0x00)
#define SCKEY_P2_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P2_CH == CH4)
/*Multi channel key*/
#if MKEY_CH4_MASK == (GROUP1|GROUP2)
#define MCKEY_P2_COMP_MASK  (0x88)
#define MCKEY_P2_IO_MASK    (0x0A) /*PD3 and PD1*/
#define MCKEY_P2_STATE_MASK (0x03)
#elif MKEY_CH4_MASK == GROUP1
#define MCKEY_P2_COMP_MASK  (0x08)
#define MCKEY_P2_IO_MASK    (0x02) /*PD1*/
#define MCKEY_P2_STATE_MASK (0x01)
#elif MKEY_CH4_MASK == GROUP2
#define MCKEY_P2_COMP_MASK  (0x80) /*PD3*/
#define MCKEY_P2_IO_MASK    (0x08)
#define MCKEY_P2_STATE_MASK (0x02)
#else
#define MCKEY_P2_COMP_MASK  (0x00)
#define MCKEY_P2_IO_MASK    (0x00)
#define MCKEY_P2_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P2_COMP_MASK  (0x08)
#define ASHLD_P2_IO_MASK    (0x02) /*PD1*/
#define ASHLD_P2_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P2_COMP_MASK  (0x80)
#define ASHLD_P2_IO_MASK    (0x08) /*PD3*/
#define ASHLD_P2_STATE_MASK (0x02)
#else
#define ASHLD_P2_COMP_MASK  (0x00)
#define ASHLD_P2_IO_MASK    (0x00)
#define ASHLD_P2_STATE_MASK (0x00)
#endif

#define P2_COMP_MASK  (SCKEY_P2_COMP_MASK | MCKEY_P2_COMP_MASK | ASHLD_P2_COMP_MASK)
#define P2_IO_MASK    (SCKEY_P2_IO_MASK | MCKEY_P2_IO_MASK | ASHLD_P2_IO_MASK)
#define P2_STATE_MASK (SCKEY_P2_STATE_MASK | MCKEY_P2_STATE_MASK | ASHLD_P2_STATE_MASK)

#else
#error "Wrong Channel selection for SCKEY_P2"
#endif

#endif

#if (NUMBER_OF_ACQUISITION_PORTS > 2)
/*define the PORT1 comparator channel mask*/
#if   ((SCKEY_P3_CH == CH1) || MKEY_CH1_MASK)
#define P3_PORT        (GPIOB)
#define P3_IO_MASK_1   (0x01) /*PB0*/
#define P3_IO_MASK_2   (0x04) /*PB2*/
#if   (SCKEY_P3_CH == CH1)
#if ((SCKEY_P3_A == GROUP1) && (SCKEY_P3_B == GROUP2)) || ((SCKEY_P3_A == GROUP2) && (SCKEY_P3_B == GROUP1))
#define SCKEY_P3_COMP_MASK  (0x11)
#define SCKEY_P3_IO_MASK    (0x05) /*PB2 and PB0*/
#define SCKEY_P3_STATE_MASK (0x03)
#elif (SCKEY_P3_A == GROUP1) || (SCKEY_P3_B == GROUP1)
#define SCKEY_P3_COMP_MASK  (0x01)
#define SCKEY_P3_IO_MASK    (0x01) /*PB0*/
#define SCKEY_P3_STATE_MASK (0x01)
#elif (SCKEY_P3_A == GROUP2) || (SCKEY_P3_B == GROUP2)
#define SCKEY_P3_COMP_MASK  (0x10)
#define SCKEY_P3_IO_MASK    (0x04) /*PB2*/
#define SCKEY_P3_STATE_MASK (0x02)
#else
#define SCKEY_P3_COMP_MASK  (0x00)
#define SCKEY_P3_IO_MASK    (0x00)
#define SCKEY_P3_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P3_COMP_MASK  (0x00)
#define SCKEY_P3_IO_MASK    (0x00)
#define SCKEY_P3_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P3_CH == CH1)
/*Multi channel key*/
#if MKEY_CH1_MASK == (GROUP1|GROUP2)
#define MCKEY_P3_COMP_MASK  (0x11)
#define MCKEY_P3_IO_MASK    (0x05) /*PB2 and PB0*/
#define MCKEY_P3_STATE_MASK (0x03)
#elif MKEY_CH1_MASK == GROUP1
#define MCKEY_P3_COMP_MASK  (0x01)
#define MCKEY_P3_IO_MASK    (0x01) /*PB0*/
#define MCKEY_P3_STATE_MASK (0x01)
#elif MKEY_CH1_MASK == GROUP2
#define MCKEY_P3_COMP_MASK  (0x10) /*PB2*/
#define MCKEY_P3_IO_MASK    (0x04)
#define MCKEY_P3_STATE_MASK (0x02)
#else
#define MCKEY_P3_COMP_MASK  (0x00)
#define MCKEY_P3_IO_MASK    (0x00)
#define MCKEY_P3_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P3_COMP_MASK  (0x01)
#define ASHLD_P3_IO_MASK    (0x01) /*PB0*/
#define ASHLD_P3_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P3_COMP_MASK  (0x10)
#define ASHLD_P3_IO_MASK    (0x04) /*PB2*/
#define ASHLD_P3_STATE_MASK (0x02)
#else
#define ASHLD_P3_COMP_MASK  (0x00)
#define ASHLD_P3_IO_MASK    (0x00)
#define ASHLD_P3_STATE_MASK (0x00)
#endif

#define P3_COMP_MASK  (SCKEY_P3_COMP_MASK | MCKEY_P3_COMP_MASK | ASHLD_P3_COMP_MASK)
#define P3_IO_MASK    (SCKEY_P3_IO_MASK | MCKEY_P3_IO_MASK | ASHLD_P3_IO_MASK)
#define P3_STATE_MASK (SCKEY_P3_STATE_MASK | MCKEY_P3_STATE_MASK | ASHLD_P3_STATE_MASK)

#elif ((SCKEY_P3_CH == CH2) || MKEY_CH2_MASK)
#define P3_PORT        (GPIOB)
#define P3_IO_MASK_1   (0x02) /*PB1*/
#define P3_IO_MASK_2   (0x08) /*PB3*/

#if (SCKEY_P3_CH == CH2)
#if ((SCKEY_P3_A == GROUP1) && (SCKEY_P3_B == GROUP2)) || ((SCKEY_P3_A == GROUP2) && (SCKEY_P3_B == GROUP1))
#define SCKEY_P3_COMP_MASK  (0x22)
#define SCKEY_P3_IO_MASK    (0x0A) /*PB3 and PB1*/
#define SCKEY_P3_STATE_MASK (0x03)
#elif (SCKEY_P3_A == GROUP1) || (SCKEY_P3_B == GROUP1)
#define SCKEY_P3_COMP_MASK  (0x02)
#define SCKEY_P3_IO_MASK    (0x02) /*PB1*/
#define SCKEY_P3_STATE_MASK (0x01)
#elif (SCKEY_P3_A == GROUP2) || (SCKEY_P3_B == GROUP2)
#define SCKEY_P3_COMP_MASK  (0x20)
#define SCKEY_P3_IO_MASK    (0x08) /*PB3*/
#define SCKEY_P3_STATE_MASK (0x02)
#else
#define SCKEY_P3_COMP_MASK  (0x00)
#define SCKEY_P3_IO_MASK    (0x00)
#define SCKEY_P3_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P3_COMP_MASK  (0x00)
#define SCKEY_P3_IO_MASK    (0x00)
#define SCKEY_P3_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P3_CH == CH2)
/*Multi channel key*/
#if MKEY_CH2_MASK == (GROUP1|GROUP2)
#define MCKEY_P3_COMP_MASK  (0x22)
#define MCKEY_P3_IO_MASK    (0x0A) /*PB1 and PB3*/
#define MCKEY_P3_STATE_MASK (0x03)
#elif MKEY_CH2_MASK == GROUP1
#define MCKEY_P3_COMP_MASK  (0x02)
#define MCKEY_P3_IO_MASK    (0x02) /*PB1*/
#define MCKEY_P3_STATE_MASK (0x01)
#elif MKEY_CH2_MASK == GROUP2
#define MCKEY_P3_COMP_MASK  (0x20) /*PB3*/
#define MCKEY_P3_IO_MASK    (0x08)
#define MCKEY_P3_STATE_MASK (0x02)
#else
#define MCKEY_P3_COMP_MASK  (0x00)
#define MCKEY_P3_IO_MASK    (0x00)
#define MCKEY_P3_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P3_COMP_MASK  (0x02)
#define ASHLD_P3_IO_MASK    (0x02) /*PB1*/
#define ASHLD_P3_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P3_COMP_MASK  (0x20)
#define ASHLD_P3_IO_MASK    (0x08) /*PB3*/
#define ASHLD_P3_STATE_MASK (0x02)
#else
#define ASHLD_P3_COMP_MASK  (0x00)
#define ASHLD_P3_IO_MASK    (0x00)
#define ASHLD_P3_STATE_MASK (0x00)
#endif
#define P3_COMP_MASK  (SCKEY_P3_COMP_MASK | MCKEY_P3_COMP_MASK | ASHLD_P3_COMP_MASK)
#define P3_IO_MASK    (SCKEY_P3_IO_MASK | MCKEY_P3_IO_MASK | ASHLD_P3_IO_MASK)
#define P3_STATE_MASK (SCKEY_P3_STATE_MASK | MCKEY_P3_STATE_MASK | ASHLD_P3_STATE_MASK)

#elif ((SCKEY_P3_CH == CH3) || MKEY_CH3_MASK)
#define P3_PORT        (GPIOD)
#define P3_IO_MASK_1   (0x01) /*PD0*/
#define P3_IO_MASK_2   (0x04) /*PD2*/

#if (SCKEY_P3_CH == CH3)
/*single channel key*/
#if ((SCKEY_P3_A == GROUP1) && (SCKEY_P3_B == GROUP2)) || ((SCKEY_P3_A == GROUP2) && (SCKEY_P3_B == GROUP1))
#define SCKEY_P3_COMP_MASK  (0x44)
#define SCKEY_P3_IO_MASK    (0x05) /*PD2 and PD0*/
#define SCKEY_P3_STATE_MASK (0x03)
#elif (SCKEY_P3_A == GROUP1) || (SCKEY_P3_B == GROUP1)
#define SCKEY_P3_COMP_MASK  (0x04)
#define SCKEY_P3_IO_MASK    (0x01) /*PD0*/
#define SCKEY_P3_STATE_MASK (0x01)
#elif (SCKEY_P3_A == GROUP2) || (SCKEY_P3_B == GROUP2)
#define SCKEY_P3_COMP_MASK  (0x40) /*PD2*/
#define SCKEY_P3_IO_MASK    (0x04)
#define SCKEY_P3_STATE_MASK (0x02)
#else
#define SCKEY_P3_COMP_MASK  (0x00)
#define SCKEY_P3_IO_MASK    (0x00)
#define SCKEY_P3_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P3_COMP_MASK  (0x00)
#define SCKEY_P3_IO_MASK    (0x00)
#define SCKEY_P3_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P3_CH == CH3)
/*Multi channel key*/
#if MKEY_CH3_MASK == (GROUP1|GROUP2)
#define MCKEY_P3_COMP_MASK  (0x44)
#define MCKEY_P3_IO_MASK    (0x05) /*PD2 and PD0*/
#define MCKEY_P3_STATE_MASK (0x03)
#elif MKEY_CH3_MASK == GROUP1
#define MCKEY_P3_COMP_MASK  (0x04)
#define MCKEY_P3_IO_MASK    (0x01) /*PD0*/
#define MCKEY_P3_STATE_MASK (0x01)
#elif MKEY_CH3_MASK == GROUP2
#define MCKEY_P3_COMP_MASK  (0x40) /*PD2*/
#define MCKEY_P3_IO_MASK    (0x04)
#define MCKEY_P3_STATE_MASK (0x02)
#else
#define MCKEY_P3_COMP_MASK  (0x00)
#define MCKEY_P3_IO_MASK    (0x00)
#define MCKEY_P3_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P3_COMP_MASK  (0x04)
#define ASHLD_P3_IO_MASK    (0x01) /*PD0*/
#define ASHLD_P3_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P3_COMP_MASK  (0x40)
#define ASHLD_P3_IO_MASK    (0x04) /*PD2*/
#define ASHLD_P3_STATE_MASK (0x02)
#else
#define ASHLD_P3_COMP_MASK  (0x00)
#define ASHLD_P3_IO_MASK    (0x00)
#define ASHLD_P3_STATE_MASK (0x00)
#endif

#define P3_COMP_MASK  (SCKEY_P3_COMP_MASK | MCKEY_P3_COMP_MASK | ASHLD_P3_COMP_MASK)
#define P3_IO_MASK    (SCKEY_P3_IO_MASK | MCKEY_P3_IO_MASK | ASHLD_P3_IO_MASK)
#define P3_STATE_MASK (SCKEY_P3_STATE_MASK | MCKEY_P3_STATE_MASK | ASHLD_P3_STATE_MASK)

#elif ((SCKEY_P3_CH == CH4) || MKEY_CH4_MASK)
#define P3_PORT              (GPIOD)
#define P3_IO_MASK_1         (0x02) /*PD1*/
#define P3_IO_MASK_2         (0x08) /*PD3*/

#if (SCKEY_P3_CH == CH4)
/*Single channel key*/
#if ((SCKEY_P3_A == GROUP1) && (SCKEY_P3_B == GROUP2)) || ((SCKEY_P3_A == GROUP2) && (SCKEY_P3_B == GROUP1))
#define SCKEY_P3_COMP_MASK  (0x88)
#define SCKEY_P3_IO_MASK    (0x0A) /*PD3 and PD1*/
#define SCKEY_P3_STATE_MASK (0x03)
#elif (SCKEY_P3_A == GROUP1) || (SCKEY_P3_B == GROUP1)
#define SCKEY_P3_COMP_MASK  (0x08)
#define SCKEY_P3_IO_MASK    (0x02) /*PD1*/
#define SCKEY_P3_STATE_MASK (0x01)
#elif (SCKEY_P3_A == GROUP2) || (SCKEY_P3_B == GROUP2)
#define SCKEY_P3_COMP_MASK  (0x80) /*PD3*/
#define SCKEY_P3_IO_MASK    (0x08)
#define SCKEY_P3_STATE_MASK (0x02)
#else
#define SCKEY_P3_COMP_MASK  (0x00)
#define SCKEY_P3_IO_MASK    (0x00)
#define SCKEY_P3_STATE_MASK (0x00)
#endif
#else
#define SCKEY_P3_COMP_MASK  (0x00)
#define SCKEY_P3_IO_MASK    (0x00)
#define SCKEY_P3_STATE_MASK (0x00)
#endif // end of #if (SCKEY_P3_CH == CH4)
/*Multi channel key*/
#if MKEY_CH4_MASK == (GROUP1|GROUP2)
#define MCKEY_P3_COMP_MASK  (0x88)
#define MCKEY_P3_IO_MASK    (0x0A) /*PD3 and PD1*/
#define MCKEY_P3_STATE_MASK (0x03)
#elif MKEY_CH4_MASK == GROUP1
#define MCKEY_P3_COMP_MASK  (0x08)
#define MCKEY_P3_IO_MASK    (0x02) /*PD1*/
#define MCKEY_P3_STATE_MASK (0x01)
#elif MKEY_CH4_MASK == GROUP2
#define MCKEY_P3_COMP_MASK  (0x80) /*PD3*/
#define MCKEY_P3_IO_MASK    (0x08)
#define MCKEY_P3_STATE_MASK (0x02)
#else
#define MCKEY_P3_COMP_MASK  (0x00)
#define MCKEY_P3_IO_MASK    (0x00)
#define MCKEY_P3_STATE_MASK (0x00)
#endif

#if ACTIVE_SHIELD_GROUP == GROUP1
#define ASHLD_P3_COMP_MASK  (0x08)
#define ASHLD_P3_IO_MASK    (0x02) /*PD1*/
#define ASHLD_P3_STATE_MASK (0x01)
#elif ACTIVE_SHIELD_GROUP == GROUP2
#define ASHLD_P3_COMP_MASK  (0x80)
#define ASHLD_P3_IO_MASK    (0x08) /*PD3*/
#define ASHLD_P3_STATE_MASK (0x02)
#else
#define ASHLD_P3_COMP_MASK  (0x00)
#define ASHLD_P3_IO_MASK    (0x00)
#define ASHLD_P3_STATE_MASK (0x00)
#endif
#define P3_COMP_MASK  (SCKEY_P3_COMP_MASK | MCKEY_P3_COMP_MASK | ASHLD_P3_COMP_MASK)
#define P3_IO_MASK    (SCKEY_P3_IO_MASK | MCKEY_P3_IO_MASK | ASHLD_P3_IO_MASK)
#define P3_STATE_MASK (SCKEY_P3_STATE_MASK | MCKEY_P3_STATE_MASK | ASHLD_P3_STATE_MASK)
#else
#error "Wrong Channel selection for SCKEY_P3"
#endif

#endif

//--------        LOCAL VARIABLES                 --------------


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----             LIBRARY PRIVATE GLOBALS                              -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TOUCH_PORT_Info_T TINY sTouchIO;

u16 TINY CounterStop;
u8 TINY SamplingShifter;
u8 TINY AcquisitionBitMask;

Info_Channel Channel_P1;

#if (NUMBER_OF_ACQUISITION_PORTS > 1)
Info_Channel Channel_P2;
#endif
#if (NUMBER_OF_ACQUISITION_PORTS > 2)
Info_Channel Channel_P3;
#endif

/* This table is always defined */
#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 0
CONST u8 Table_SCKEY_P1[SCKEY_P1_KEY_COUNT] =
  {

#if   (SCKEY_P1_A == GROUP1)
    0x00
#elif (SCKEY_P1_A == GROUP2)
    0x01
#elif (SCKEY_P1_A == GROUP3)
    0x02
#elif (SCKEY_P1_A == GROUP4)
    0x03
#elif (SCKEY_P1_A == GROUP5)
    0x04
#elif (SCKEY_P1_A == GROUP6)
    0x05
#elif (SCKEY_P1_A == GROUP7)
    0x06
#elif (SCKEY_P1_A == GROUP8)
    0x07
#endif

#if SCKEY_P1_KEY_COUNT > 1
#if   (SCKEY_P1_B == GROUP1)
    , 0x00
#elif (SCKEY_P1_B == GROUP2)
    , 0x01
#elif (SCKEY_P1_B == GROUP3)
    , 0x02
#elif (SCKEY_P1_B == GROUP4)
    , 0x03
#elif (SCKEY_P1_B == GROUP5)
    , 0x04
#elif (SCKEY_P1_B == GROUP6)
    , 0x05
#elif (SCKEY_P1_B == GROUP7)
    , 0x06
#elif (SCKEY_P1_B == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P1_KEY_COUNT > 2
#if   (SCKEY_P1_C == GROUP1)
    , 0x00
#elif (SCKEY_P1_C == GROUP2)
    , 0x01
#elif (SCKEY_P1_C == GROUP3)
    , 0x02
#elif (SCKEY_P1_C == GROUP4)
    , 0x03
#elif (SCKEY_P1_C == GROUP5)
    , 0x04
#elif (SCKEY_P1_C == GROUP6)
    , 0x05
#elif (SCKEY_P1_C == GROUP7)
    , 0x06
#elif (SCKEY_P1_C == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P1_KEY_COUNT > 3
#if   (SCKEY_P1_D == GROUP1)
    , 0x00
#elif (SCKEY_P1_D == GROUP2)
    , 0x01
#elif (SCKEY_P1_D == GROUP3)
    , 0x02
#elif (SCKEY_P1_D == GROUP4)
    , 0x03
#elif (SCKEY_P1_D == GROUP5)
    , 0x04
#elif (SCKEY_P1_D == GROUP6)
    , 0x05
#elif (SCKEY_P1_D == GROUP7)
    , 0x06
#elif (SCKEY_P1_D == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P1_KEY_COUNT > 4
#if   (SCKEY_P1_E == GROUP1)
    , 0x00
#elif (SCKEY_P1_E == GROUP2)
    , 0x01
#elif (SCKEY_P1_E == GROUP3)
    , 0x02
#elif (SCKEY_P1_E == GROUP4)
    , 0x03
#elif (SCKEY_P1_E == GROUP5)
    , 0x04
#elif (SCKEY_P1_E == GROUP6)
    , 0x05
#elif (SCKEY_P1_E == GROUP7)
    , 0x06
#elif (SCKEY_P1_E == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P1_KEY_COUNT > 5
#if   (SCKEY_P1_F == GROUP1)
    , 0x00
#elif (SCKEY_P1_F == GROUP2)
    , 0x01
#elif (SCKEY_P1_F == GROUP3)
    , 0x02
#elif (SCKEY_P1_F == GROUP4)
    , 0x03
#elif (SCKEY_P1_F == GROUP5)
    , 0x04
#elif (SCKEY_P1_F == GROUP6)
    , 0x05
#elif (SCKEY_P1_F == GROUP7)
    , 0x06
#elif (SCKEY_P1_F == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P1_KEY_COUNT > 6
#if   (SCKEY_P1_G == GROUP1)
    , 0x00
#elif (SCKEY_P1_G == GROUP2)
    , 0x01
#elif (SCKEY_P1_G == GROUP3)
    , 0x02
#elif (SCKEY_P1_G == GROUP4)
    , 0x03
#elif (SCKEY_P1_G == GROUP5)
    , 0x04
#elif (SCKEY_P1_G == GROUP6)
    , 0x05
#elif (SCKEY_P1_G == GROUP7)
    , 0x06
#elif (SCKEY_P1_G == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P1_KEY_COUNT > 7
#if   (SCKEY_P1_H == GROUP1)
    , 0x00
#elif (SCKEY_P1_H == GROUP2)
    , 0x01
#elif (SCKEY_P1_H == GROUP3)
    , 0x02
#elif (SCKEY_P1_H == GROUP4)
    , 0x03
#elif (SCKEY_P1_H == GROUP5)
    , 0x04
#elif (SCKEY_P1_H == GROUP6)
    , 0x05
#elif (SCKEY_P1_H == GROUP7)
    , 0x06
#elif (SCKEY_P1_H == GROUP8)
    , 0x07
#endif
#endif
  };
#endif
#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 1
CONST u8 Table_SCKEY_P2[SCKEY_P2_KEY_COUNT] =
  {

#if   (SCKEY_P2_A == GROUP1)
    0x00
#elif (SCKEY_P2_A == GROUP2)
    0x01
#elif (SCKEY_P2_A == GROUP3)
    0x02
#elif (SCKEY_P2_A == GROUP4)
    0x03
#elif (SCKEY_P2_A == GROUP5)
    0x04
#elif (SCKEY_P2_A == GROUP6)
    0x05
#elif (SCKEY_P2_A == GROUP7)
    0x06
#elif (SCKEY_P2_A == GROUP8)
    0x07
#endif

#if SCKEY_P2_KEY_COUNT > 1
#if   (SCKEY_P2_B == GROUP1)
    , 0x00
#elif (SCKEY_P2_B == GROUP2)
    , 0x01
#elif (SCKEY_P2_B == GROUP3)
    , 0x02
#elif (SCKEY_P2_B == GROUP4)
    , 0x03
#elif (SCKEY_P2_B == GROUP5)
    , 0x04
#elif (SCKEY_P2_B == GROUP6)
    , 0x05
#elif (SCKEY_P2_B == GROUP7)
    , 0x06
#elif (SCKEY_P2_B == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P2_KEY_COUNT > 2
#if   (SCKEY_P2_C == GROUP1)
    , 0x00
#elif (SCKEY_P2_C == GROUP2)
    , 0x01
#elif (SCKEY_P2_C == GROUP3)
    , 0x02
#elif (SCKEY_P2_C == GROUP4)
    , 0x03
#elif (SCKEY_P2_C == GROUP5)
    , 0x04
#elif (SCKEY_P2_C == GROUP6)
    , 0x05
#elif (SCKEY_P2_C == GROUP7)
    , 0x06
#elif (SCKEY_P2_C == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P2_KEY_COUNT > 3
#if   (SCKEY_P2_D == GROUP1)
    , 0x00
#elif (SCKEY_P2_D == GROUP2)
    , 0x01
#elif (SCKEY_P2_D == GROUP3)
    , 0x02
#elif (SCKEY_P2_D == GROUP4)
    , 0x03
#elif (SCKEY_P2_D == GROUP5)
    , 0x04
#elif (SCKEY_P2_D == GROUP6)
    , 0x05
#elif (SCKEY_P2_D == GROUP7)
    , 0x06
#elif (SCKEY_P2_D == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P2_KEY_COUNT > 4
#if   (SCKEY_P2_E == GROUP1)
    , 0x00
#elif (SCKEY_P2_E == GROUP2)
    , 0x01
#elif (SCKEY_P2_E == GROUP3)
    , 0x02
#elif (SCKEY_P2_E == GROUP4)
    , 0x03
#elif (SCKEY_P2_E == GROUP5)
    , 0x04
#elif (SCKEY_P2_E == GROUP6)
    , 0x05
#elif (SCKEY_P2_E == GROUP7)
    , 0x06
#elif (SCKEY_P2_E == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P2_KEY_COUNT > 5
#if   (SCKEY_P2_F == GROUP1)
    , 0x00
#elif (SCKEY_P2_F == GROUP2)
    , 0x01
#elif (SCKEY_P2_F == GROUP3)
    , 0x02
#elif (SCKEY_P2_F == GROUP4)
    , 0x03
#elif (SCKEY_P2_F == GROUP5)
    , 0x04
#elif (SCKEY_P2_F == GROUP6)
    , 0x05
#elif (SCKEY_P2_F == GROUP7)
    , 0x06
#elif (SCKEY_P2_F == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P2_KEY_COUNT > 6
#if   (SCKEY_P2_G == GROUP1)
    , 0x00
#elif (SCKEY_P2_G == GROUP2)
    , 0x01
#elif (SCKEY_P2_G == GROUP3)
    , 0x02
#elif (SCKEY_P2_G == GROUP4)
    , 0x03
#elif (SCKEY_P2_G == GROUP5)
    , 0x04
#elif (SCKEY_P2_G == GROUP6)
    , 0x05
#elif (SCKEY_P2_G == GROUP7)
    , 0x06
#elif (SCKEY_P2_G == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P2_KEY_COUNT > 7
#if   (SCKEY_P2_H == GROUP1)
    , 0x00
#elif (SCKEY_P2_H == GROUP2)
    , 0x01
#elif (SCKEY_P2_H == GROUP3)
    , 0x02
#elif (SCKEY_P2_H == GROUP4)
    , 0x03
#elif (SCKEY_P2_H == GROUP5)
    , 0x04
#elif (SCKEY_P2_H == GROUP6)
    , 0x05
#elif (SCKEY_P2_H == GROUP7)
    , 0x06
#elif (SCKEY_P2_H == GROUP8)
    , 0x07
#endif
#endif
  };
#endif

#if NUMBER_OF_SINGLE_CHANNEL_PORTS > 2
CONST u8 Table_SCKEY_P3[SCKEY_P3_KEY_COUNT] =
  {

#if   (SCKEY_P3_A == GROUP1)
    0x00
#elif (SCKEY_P3_A == GROUP2)
    0x01
#elif (SCKEY_P3_A == GROUP3)
    0x02
#elif (SCKEY_P3_A == GROUP4)
    0x03
#elif (SCKEY_P3_A == GROUP5)
    0x04
#elif (SCKEY_P3_A == GROUP6)
    0x05
#elif (SCKEY_P3_A == GROUP7)
    0x06
#elif (SCKEY_P3_A == GROUP8)
    0x07
#endif

#if SCKEY_P3_KEY_COUNT > 1
#if   (SCKEY_P3_B == GROUP1)
    , 0x00
#elif (SCKEY_P3_B == GROUP2)
    , 0x01
#elif (SCKEY_P3_B == GROUP3)
    , 0x02
#elif (SCKEY_P3_B == GROUP4)
    , 0x03
#elif (SCKEY_P3_B == GROUP5)
    , 0x04
#elif (SCKEY_P3_B == GROUP6)
    , 0x05
#elif (SCKEY_P3_B == GROUP7)
    , 0x06
#elif (SCKEY_P3_B == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P3_KEY_COUNT > 2
#if   (SCKEY_P3_C == GROUP1)
    , 0x00
#elif (SCKEY_P3_C == GROUP2)
    , 0x01
#elif (SCKEY_P3_C == GROUP3)
    , 0x02
#elif (SCKEY_P3_C == GROUP4)
    , 0x03
#elif (SCKEY_P3_C == GROUP5)
    , 0x04
#elif (SCKEY_P3_C == GROUP6)
    , 0x05
#elif (SCKEY_P3_C == GROUP7)
    , 0x06
#elif (SCKEY_P3_C == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P3_KEY_COUNT > 3
#if   (SCKEY_P3_D == GROUP1)
    , 0x00
#elif (SCKEY_P3_D == GROUP2)
    , 0x01
#elif (SCKEY_P3_D == GROUP3)
    , 0x02
#elif (SCKEY_P3_D == GROUP4)
    , 0x03
#elif (SCKEY_P3_D == GROUP5)
    , 0x04
#elif (SCKEY_P3_D == GROUP6)
    , 0x05
#elif (SCKEY_P3_D == GROUP7)
    , 0x06
#elif (SCKEY_P3_D == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P3_KEY_COUNT > 4
#if   (SCKEY_P3_E == GROUP1)
    , 0x00
#elif (SCKEY_P3_E == GROUP2)
    , 0x01
#elif (SCKEY_P3_E == GROUP3)
    , 0x02
#elif (SCKEY_P3_E == GROUP4)
    , 0x03
#elif (SCKEY_P3_E == GROUP5)
    , 0x04
#elif (SCKEY_P3_E == GROUP6)
    , 0x05
#elif (SCKEY_P3_E == GROUP7)
    , 0x06
#elif (SCKEY_P3_E == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P3_KEY_COUNT > 5
#if   (SCKEY_P3_F == GROUP1)
    , 0x00
#elif (SCKEY_P3_F == GROUP2)
    , 0x01
#elif (SCKEY_P3_F == GROUP3)
    , 0x02
#elif (SCKEY_P3_F == GROUP4)
    , 0x03
#elif (SCKEY_P3_F == GROUP5)
    , 0x04
#elif (SCKEY_P3_F == GROUP6)
    , 0x05
#elif (SCKEY_P3_F == GROUP7)
    , 0x06
#elif (SCKEY_P3_F == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P3_KEY_COUNT > 6
#if   (SCKEY_P3_G == GROUP1)
    , 0x00
#elif (SCKEY_P3_G == GROUP2)
    , 0x01
#elif (SCKEY_P3_G == GROUP3)
    , 0x02
#elif (SCKEY_P3_G == GROUP4)
    , 0x03
#elif (SCKEY_P3_G == GROUP5)
    , 0x04
#elif (SCKEY_P3_G == GROUP6)
    , 0x05
#elif (SCKEY_P3_G == GROUP7)
    , 0x06
#elif (SCKEY_P3_G == GROUP8)
    , 0x07
#endif
#endif
#if SCKEY_P3_KEY_COUNT > 7
#if   (SCKEY_P3_H == GROUP1)
    , 0x00
#elif (SCKEY_P3_H == GROUP2)
    , 0x01
#elif (SCKEY_P3_H == GROUP3)
    , 0x02
#elif (SCKEY_P3_H == GROUP4)
    , 0x03
#elif (SCKEY_P3_H == GROUP5)
    , 0x04
#elif (SCKEY_P3_H == GROUP6)
    , 0x05
#elif (SCKEY_P3_H == GROUP7)
    , 0x06
#elif (SCKEY_P3_H == GROUP8)
    , 0x07
#endif
#endif
  };
#endif

/* Table_SCKEY_BITS contents the individual masks for the port acquisitions */
#if NUMBER_OF_SINGLE_CHANNEL_KEYS > 0
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
#endif

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
CONST u16 Table_MCKEY_PORTS[
#if NUMBER_OF_MULTI_CHANNEL_KEYS == 1
  CHANNEL_PER_MCKEY
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS == 2
  CHANNEL_PER_MCKEY + CHANNEL_PER_MCKEY
#endif
] =
  {
    MCKEY1_A_CH
    , MCKEY1_B_CH
    , MCKEY1_C_CH
#if CHANNEL_PER_MCKEY > 3
    , MCKEY1_D_CH
    , MCKEY1_E_CH
#endif
#if CHANNEL_PER_MCKEY > 5
    , MCKEY1_F_CH
    , MCKEY1_G_CH
    , MCKEY1_H_CH
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
    , MCKEY2_A_CH
    , MCKEY2_B_CH
    , MCKEY2_C_CH
#if CHANNEL_PER_MCKEY > 3
    , MCKEY2_D_CH
    , MCKEY2_E_CH
#endif
#if CHANNEL_PER_MCKEY > 5
    , MCKEY2_F_CH
    , MCKEY2_G_CH
    , MCKEY2_H_CH
#endif
#endif
  };
#endif

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
CONST u8 Table_MCKEY_BITS[
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
#if CHANNEL_PER_MCKEY > 3
    , MCKEY1_D
    , MCKEY1_E
#endif
#if CHANNEL_PER_MCKEY > 5
    , MCKEY1_F
    , MCKEY1_G
    , MCKEY1_H
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
    , MCKEY2_A
    , MCKEY2_B
    , MCKEY2_C
#if CHANNEL_PER_MCKEY > 3
    , MCKEY2_D
    , MCKEY2_E
#endif
#if CHANNEL_PER_MCKEY > 5
    , MCKEY2_F
    , MCKEY2_G
    , MCKEY2_H
#endif
#endif
  };
#endif


/* Basic delay function*/
void wait(u16 d)
{
  while (d--) {}}

#if SPREAD_SPECTRUM
/**
  ******************************************************************************
  * @brief Spread Spectrum waiting routine. A variable delay is
  * inserted between each step.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * SPREAD_SPECTRUM must be defined in the configuration file
  ******************************************************************************
  */
INLINE void TSL_SW_Spread_Spectrum(void)
{
  u8 i;

  SpreadCounter++;

  if (SpreadCounter == SPREAD_COUNTER_MAX)
  {
    SpreadCounter = SPREAD_COUNTER_MIN;
  }
  i = SpreadCounter;
  while (--i);

}
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
  /*enable the comparators 1 and 2 */
#if defined(COMP1) && defined(COMP2)
  COMP->CR = 0x06;
#elif defined(COMP1)
  COMP->CR = 0x02;
#else
  COMP->CR = 0x04;
#endif
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
//void TSL_IO_Clamp(void)
//{

//All the analog switch OPEN
//COMP->CCS = 0x00;

//All IO used to pushpull LOW for discharging all capacitors (Ctouch and Csense)
/*Port B*/
//GPIOB->DDR = 0x0F;
//GPIOB->CR1 = 0x0F;
//GPIOB->ODR = 0x00;
///*Port D*/
//GPIOD->DDR = 0x0F;
//GPIOD->CR1 = 0x0F;
//GPIOD->ODR = 0x00;
/*wait a while*/
//wait(200);


//All IO in input with the analog switch OPEN
/*Port B*/
//GPIOB->DDR = 0x00;
//GPIOB->CR1 = 0x00;
/*Port D*/
//GPIOD->DDR = 0x00;
// GPIOD->CR1 = 0x00;
//}

/**
  ******************************************************************************
  * @brief Acquisition function for the 1st Channel IO of each group
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_IO_Acquisition_P1(u16 MaxAcqNumber)
{

  u16 MeasurementCounter;

  /*reset the counter values*/
  MeasurementCounter = 0x0000;
  Channel_P1.Measure[0] = 0x0000;
  Channel_P1.Measure[1] = 0x0000;
  Channel_P1.State.whole = 0x00;

  /*open the analog switches*/
  COMP->CCS &= (u8)(~(SAMP_CAP_COMP_MASK | P1_COMP_MASK));

  /*All IO to pushpull LOW for discharging all capacitors (Ctouch and Csense)*/
  /*discharging Csample*/
#ifdef PROTECT_IO_ACCESS
  disableInterrupts();
#endif
  SAMP_CAP_PORT->DDR |= SAMP_CAP_IO_MASK;
  SAMP_CAP_PORT->CR1 |= SAMP_CAP_IO_MASK;
  SAMP_CAP_PORT->ODR &= (u8)(~(SAMP_CAP_IO_MASK));
  /*discharging Ctouch*/
  P1_PORT->DDR |= P1_IO_MASK;
  P1_PORT->CR1 |= P1_IO_MASK;
  P1_PORT->ODR &= (u8)(~(P1_IO_MASK));
#ifdef PROTECT_IO_ACCESS
  enableInterrupts();
#endif

  /*wait a while for good discharging of all capacitors*/
  wait(200);

  /*All IO in input floating*/
#ifdef PROTECT_IO_ACCESS
  disableInterrupts();
#endif
  P1_PORT->DDR &= (u8)(~(P1_IO_MASK));
  P1_PORT->CR1 &= (u8)(~(P1_IO_MASK));
#ifdef PROTECT_IO_ACCESS
  enableInterrupts();
#endif

  //close the Channel #1 analog switches (COMP1 CHA and COMP2 CH1 ie PB0 and PB2)
  COMP->CCS |= SAMP_CAP_COMP_MASK;

  /*loop while all the 1st channel of each group have not reach the VIH level*/
  do
  {
    /*Close the sampling capacitor analog switch*/
    COMP->CCS |= SAMP_CAP_COMP_MASK;
    /*charging Ctouch with connecting the IO to Vdd (io in push-pull HIGH)*/
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    P1_PORT->DDR |= P1_IO_MASK;//output push pull config
    P1_PORT->CR1 |= P1_IO_MASK;
    P1_PORT->ODR |= P1_IO_MASK; //HIGH level
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif
    /*wait a while for good charging*/
    CLWHTA; //wait(5);

    /*All IO in input */
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    P1_PORT->DDR &= (u8)(~(P1_IO_MASK));
    P1_PORT->CR1 &= (u8)(~(P1_IO_MASK));
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif

    MeasurementCounter++;

    /*charging the Csense cap with connecting it to Ctouch by closing the analog switch*/
    COMP->CCS |= P1_COMP_MASK;
    /*wait a while for good charge transfering*/
    CLWLTA; //wait(5);

#if SPREAD_SPECTRUM
    TSL_SW_Spread_Spectrum();
#endif

    /*open the analog switches to allow checking of the inputs*/
    COMP->CCS &= (u8)(~(SAMP_CAP_COMP_MASK | P1_COMP_MASK));

    /*Sampling capacitor IOs in input floating*/
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    SAMP_CAP_PORT->DDR &= (u8)(~(SAMP_CAP_IO_MASK));
    SAMP_CAP_PORT->CR1 &= (u8)(~(SAMP_CAP_IO_MASK));
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif



    if ((Channel_P1.State.b.Grp1 == 0) && ((SAMP_CAP_PORT->IDR&SAMP_CAP_IO_MASK_1) == SAMP_CAP_IO_MASK_1))
    {
      Channel_P1.Measure[0] += MeasurementCounter;
      Channel_P1.State.whole |= Group1;
    }
    if ((Channel_P1.State.b.Grp2 == 0) && ((SAMP_CAP_PORT->IDR&SAMP_CAP_IO_MASK_2) == SAMP_CAP_IO_MASK_2))
    {
      Channel_P1.Measure[1] += MeasurementCounter;
      Channel_P1.State.whole |= Group2;
    }
    /*it's better to implement this like that because it's much more faster than to put this test in the "while test" below and only the MSByte is tested in order to speed up the code execution*/
    if ((u8)(MeasurementCounter >> 8) > (u8)(MaxAcqNumber >> 8))
    {
      break;
    }
  }
  while (((Channel_P1.State.whole & Channel_P1.EnabledChannels) != Channel_P1.EnabledChannels));

}


/**
  ******************************************************************************
  * @brief Acquisition function for the 2nd Channel IO of each group
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
#if (NUMBER_OF_ACQUISITION_PORTS > 1)
void TSL_IO_Acquisition_P2(u16 MaxAcqNumber)
{

  u16 MeasurementCounter;

  /*reset the counter values*/
  MeasurementCounter = 0x0000;
  Channel_P2.Measure[0] = 0x0000;
  Channel_P2.Measure[1] = 0x0000;
  Channel_P2.State.whole = 0x00;

  /*open the analog switches*/
  COMP->CCS &= (u8)(~(SAMP_CAP_COMP_MASK | P2_COMP_MASK));

  /*All IO to pushpull LOW for discharging all capacitors (Ctouch and Csense)*/
  /*discharging Csample*/
#ifdef PROTECT_IO_ACCESS
  disableInterrupts();
#endif
  SAMP_CAP_PORT->DDR |= SAMP_CAP_IO_MASK;
  SAMP_CAP_PORT->CR1 |= SAMP_CAP_IO_MASK;
  SAMP_CAP_PORT->ODR &= (u8)(~(SAMP_CAP_IO_MASK));
  /*discharging Ctouch*/
  P2_PORT->DDR |= P2_IO_MASK;
  P2_PORT->CR1 |= P2_IO_MASK;
  P2_PORT->ODR &= (u8)(~(P2_IO_MASK));
#ifdef PROTECT_IO_ACCESS
  enableInterrupts();
#endif

  /*wait a while for good discharge of all capacitors*/
  wait(200);

  /*All IO in input floating*/
#ifdef PROTECT_IO_ACCESS
  disableInterrupts();
#endif
  P2_PORT->DDR &= (u8)(~(P2_IO_MASK));
  P2_PORT->CR1 &= (u8)(~(P2_IO_MASK));
#ifdef PROTECT_IO_ACCESS
  enableInterrupts();
#endif

  //close the Chanel #1 analog switches (COMP1 CHA and COMP2 CH1 ie PB0 and PB2)
  COMP->CCS |= SAMP_CAP_COMP_MASK;

  /*loop while all the 1st channel of each group have not reach the VIH level*/
  do
  {
    /*Close the sampling capacitor analog switch*/
    COMP->CCS |= SAMP_CAP_COMP_MASK;
    /*charging Ctouch with connecting the IO to Vdd (io in push-pull HIGH)*/
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    P2_PORT->DDR |= P2_IO_MASK;//output push pull config
    P2_PORT->CR1 |= P2_IO_MASK;
    P2_PORT->ODR |= P2_IO_MASK; //HIGH level
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif
    /*wait a while for good charging*/
    CLWHTA; //wait(5);

    /*All IO in input */
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    P2_PORT->DDR &= (u8)(~(P2_IO_MASK));
    P2_PORT->CR1 &= (u8)(~(P2_IO_MASK));
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif

    MeasurementCounter++;

    /*charging the Csense cap with connecting it to Ctouch by closing the analog switch*/
    COMP->CCS |= P2_COMP_MASK;
    /*wait a while for good charge transfering*/
    CLWLTA; //wait(5);

#if SPREAD_SPECTRUM
    TSL_SW_Spread_Spectrum();
#endif

    /*open the analog switches to allow checking of the inputs*/
    COMP->CCS &= (u8)(~(SAMP_CAP_COMP_MASK | P2_COMP_MASK));

    /*Sampling capacitor IOs in input folating */
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    SAMP_CAP_PORT->DDR &= (u8)(~(SAMP_CAP_IO_MASK));
    SAMP_CAP_PORT->CR1 &= (u8)(~(SAMP_CAP_IO_MASK));
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif

    if ((Channel_P2.State.b.Grp1 == 0) && ((SAMP_CAP_PORT->IDR&SAMP_CAP_IO_MASK_1) == SAMP_CAP_IO_MASK_1))
    {
      Channel_P2.Measure[0] += MeasurementCounter;
      Channel_P2.State.whole |= Group1;
    }
    if ((Channel_P2.State.b.Grp2 == 0) && ((SAMP_CAP_PORT->IDR&SAMP_CAP_IO_MASK_2) == SAMP_CAP_IO_MASK_2))
    {
      Channel_P2.Measure[1] += MeasurementCounter;
      Channel_P2.State.whole |= Group2;
    }

    /*it's better to implement this like that because it's much more faster than to put this test in the "while test" below  and only the MSByte is tested in order to speed up the code execution*/
    if ((u8)(MeasurementCounter >> 8) > (u8)(MaxAcqNumber >> 8))
    {
      break;
    }
  }
  while (((Channel_P2.State.whole & Channel_P2.EnabledChannels) != Channel_P2.EnabledChannels));
}
#endif


/**
  ******************************************************************************
  * @brief Acquisition function for the 3rd Channel IO of each group
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
#if (NUMBER_OF_ACQUISITION_PORTS > 2)
void TSL_IO_Acquisition_P3(u16 MaxAcqNumber)
{

  u16 MeasurementCounter;

  /*reset the counter values*/
  MeasurementCounter = 0x0000;
  Channel_P3.Measure[0] = 0x0000;
  Channel_P3.Measure[1] = 0x0000;
  Channel_P3.State.whole = 0x00;

  /*open the analog switches*/
  COMP->CCS &= (u8)(~(SAMP_CAP_COMP_MASK | P3_COMP_MASK));

  /*All IO to pushpull LOW for discharging all capacitors (Ctouch and Csense)*/
  /*discharging Csample*/
#ifdef PROTECT_IO_ACCESS
  disableInterrupts();
#endif
  SAMP_CAP_PORT->DDR |= SAMP_CAP_IO_MASK;
  SAMP_CAP_PORT->CR1 |= SAMP_CAP_IO_MASK;
  SAMP_CAP_PORT->ODR &= (u8)(~(SAMP_CAP_IO_MASK));
  /*discharging Ctouch*/
  P3_PORT->DDR |= P3_IO_MASK;
  P3_PORT->CR1 |= P3_IO_MASK;
  P3_PORT->ODR &= (u8)(~(P3_IO_MASK));
#ifdef PROTECT_IO_ACCESS
  enableInterrupts();
#endif

  /*wait a while for good discharge of all capacitors*/
  wait(200);

  /*All IO in input floating*/
#ifdef PROTECT_IO_ACCESS
  disableInterrupts();
#endif
  P3_PORT->DDR &= (u8)(~(P3_IO_MASK));
  P3_PORT->CR1 &= (u8)(~(P3_IO_MASK));
#ifdef PROTECT_IO_ACCESS
  enableInterrupts();
#endif

  //close the Chanel #1 analog switches (COMP1 CHA and COMP2 CH1 ie PB0 and PB2)
  COMP->CCS |= SAMP_CAP_COMP_MASK;

  /*loop in this loop while all the 1st channel of each group have not reach the VIH level*/
  do
  {
    /*Close the sampling capacitor analog switch*/
    COMP->CCS |= SAMP_CAP_COMP_MASK;
    /*charging Ctouch with connecting the IO to Vdd (io in push-pull HIGH)*/
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    P3_PORT->DDR |= P3_IO_MASK;//output push pull config
    P3_PORT->CR1 |= P3_IO_MASK;
    P3_PORT->ODR |= P3_IO_MASK; //HIGH level
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif

    /*wait a while for good charging*/
    CLWHTA; //wait(5);

    /*All IO in input */
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    P3_PORT->DDR &= (u8)(~(P3_IO_MASK));
    P3_PORT->CR1 &= (u8)(~(P3_IO_MASK));
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif

    /*increment the MeasurementCounter*/
    MeasurementCounter++;

    /*charging the Csense cap with connecting it to Ctouch by closing the analog switch*/
    COMP->CCS |= P3_COMP_MASK;
    /*wait a while for good charge transfering*/
    CLWLTA; //wait(5);

#if SPREAD_SPECTRUM
    TSL_SW_Spread_Spectrum();
#endif

    /*open the analog switches to allow checking of the inputs*/
    COMP->CCS &= (u8)(~(SAMP_CAP_COMP_MASK | P3_COMP_MASK));

    /*Sampling capacitor IOs in input folating */
#ifdef PROTECT_IO_ACCESS
    disableInterrupts();
#endif
    SAMP_CAP_PORT->DDR &= (u8)(~(SAMP_CAP_IO_MASK));
    SAMP_CAP_PORT->CR1 &= (u8)(~(SAMP_CAP_IO_MASK));
#ifdef PROTECT_IO_ACCESS
    enableInterrupts();
#endif

    if ((Channel_P3.State.b.Grp1 == 0) && ((SAMP_CAP_PORT->IDR&SAMP_CAP_IO_MASK_1) == SAMP_CAP_IO_MASK_1))
    {
      Channel_P3.Measure[0] += MeasurementCounter;
      Channel_P3.State.whole |= Group1;
    }
    if ((Channel_P3.State.b.Grp2 == 0) && ((SAMP_CAP_PORT->IDR&SAMP_CAP_IO_MASK_2) == SAMP_CAP_IO_MASK_2))
    {
      Channel_P3.Measure[1] += MeasurementCounter;
      Channel_P3.State.whole |= Group2;
    }
    /*it's better to implement this like that because it's much more faster than to put this test in the "while test" below and only the MSByte is tested in order to speed up the code execution*/
    if ((u8)(MeasurementCounter >> 8) > (u8)(MaxAcqNumber >> 8))
    {
      break;
    }
  }
  while (((Channel_P3.State.whole & Channel_P3.EnabledChannels) != Channel_P3.EnabledChannels));

}
#endif


#endif

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
