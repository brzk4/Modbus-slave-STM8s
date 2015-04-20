/**
  ******************************************************************************
  * @file    stm8l15x_tsl_ct_acquisition.c
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file provides all the functions
  *          to manage the Charge-Transfer acquisition based on STM8L15x devices.
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
#include "stm8l15x_tsl_ct_acquisition.h"
#include "stm8_tsl_services.h"
#include "stm8_tsl_conf.h"

#if defined(CHARGE_TRANSFER) && defined(STM8L15X)

/* Memory section ------------------------------------------------------------*/
#if defined(_COSMIC_) && defined(USE_PRAGMA_SECTION)
#pragma section [TSL_IO_RAM]
#pragma section @tiny [TSL_IO_RAM0]
#pragma section const {TSL_IO_CONST}
#pragma section (TSL_IO_CODE)
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
//define the init value for the channel
#define INIT_VALUE 0x0000

//define the 1st Channel mask
#if SCKEY_P1_CH == CH1
#define SCKEY_P1_MASK (SCKEY_P1_A | SCKEY_P1_B | SCKEY_P1_C | SCKEY_P1_D | SCKEY_P1_E | SCKEY_P1_F | SCKEY_P1_G | SCKEY_P1_H | MKEY_CH1_MASK | ACTIVE_SHIELD_GROUP)
#elif SCKEY_P1_CH == CH2
#define SCKEY_P1_MASK (SCKEY_P1_A | SCKEY_P1_B | SCKEY_P1_C | SCKEY_P1_D | SCKEY_P1_E | SCKEY_P1_F | SCKEY_P1_G | SCKEY_P1_H | MKEY_CH2_MASK | ACTIVE_SHIELD_GROUP)
#else //SCKEY_P1_CH == CH3
#define SCKEY_P1_MASK (SCKEY_P1_A | SCKEY_P1_B | SCKEY_P1_C | SCKEY_P1_D | SCKEY_P1_E | SCKEY_P1_F | SCKEY_P1_G | SCKEY_P1_H | MKEY_CH3_MASK | ACTIVE_SHIELD_GROUP)
#endif


//define the 2nd Channel mask
#if (NUMBER_OF_ACQUISITION_PORTS > 1)
#if SCKEY_P2_CH == CH1
#define SCKEY_P2_MASK (SCKEY_P2_A | SCKEY_P2_B | SCKEY_P2_C | SCKEY_P2_D | SCKEY_P2_E | SCKEY_P2_F | SCKEY_P2_G | SCKEY_P2_H | MKEY_CH1_MASK | ACTIVE_SHIELD_GROUP)
#elif SCKEY_P2_CH == CH2
#define SCKEY_P2_MASK (SCKEY_P2_A | SCKEY_P2_B | SCKEY_P2_C | SCKEY_P2_D | SCKEY_P2_E | SCKEY_P2_F | SCKEY_P2_G | SCKEY_P2_H | MKEY_CH2_MASK | ACTIVE_SHIELD_GROUP)
#else //SCKEY_P2_CH == CH3
#define SCKEY_P2_MASK (SCKEY_P2_A | SCKEY_P2_B | SCKEY_P2_C | SCKEY_P2_D | SCKEY_P2_E | SCKEY_P2_F | SCKEY_P2_G | SCKEY_P2_H | MKEY_CH3_MASK | ACTIVE_SHIELD_GROUP)
#endif
#else
#define SCKEY_P2_MASK (0)
#endif

//define the SAMPLING capacitor channel mask
#define SAMP_CAP_MASK (SCKEY_P1_MASK | SCKEY_P2_MASK)

#if (SCKEY_P1_CH == CH1)
#define CCMR_P1                (RI->IOCMR1)
#define IOSR_P1                (RI->IOSR1)
#define CGCR_P1_PP_LOW_MASK    (0x00)
#define CGCR_P1_PP_HIGH_MASK   (0x01)
#define CGCR_P1_SW_OPEN_MASK   (0x02)
#define CGCR_P1_SW_CLOSE_MASK  (0x03)
#define CGCR_P1_GLOBAL_MASK    (0xFC)
#elif (SCKEY_P1_CH == CH2)
#define CCMR_P1                (RI->IOCMR2)
#define IOSR_P1                (RI->IOSR2)
#define CGCR_P1_PP_LOW_MASK    (0x00)
#define CGCR_P1_PP_HIGH_MASK   (0x04)
#define CGCR_P1_SW_OPEN_MASK   (0x08)
#define CGCR_P1_SW_CLOSE_MASK  (0x0C)
#define CGCR_P1_GLOBAL_MASK    (0xF3)
#else //(SCKEY_P1_CH == CH3)
#define CCMR_P1                (RI->IOCMR3)
#define IOSR_P1                (RI->IOSR3)
#define CGCR_P1_PP_LOW_MASK    (0x00)
#define CGCR_P1_PP_HIGH_MASK   (0x10)
#define CGCR_P1_SW_OPEN_MASK   (0x20)
#define CGCR_P1_SW_CLOSE_MASK  (0x30)
#define CGCR_P1_GLOBAL_MASK    (0xCF)

#endif

#if NUMBER_OF_ACQUISITION_PORTS > 1
#if (SCKEY_P2_CH == CH1)
#define CCMR_P2                (RI->IOCMR1)
#define IOSR_P2                (RI->IOSR1)
#define CGCR_P2_PP_LOW_MASK    (0x00)
#define CGCR_P2_PP_HIGH_MASK   (0x01)
#define CGCR_P2_SW_OPEN_MASK   (0x02)
#define CGCR_P2_SW_CLOSE_MASK  (0x03)
#define CGCR_P2_GLOBAL_MASK    (0xFC)
#elif (SCKEY_P2_CH == CH2)
#define CCMR_P2                (RI->IOCMR2)
#define IOSR_P2                (RI->IOSR2)
#define CGCR_P2_PP_LOW_MASK    (0x00)
#define CGCR_P2_PP_HIGH_MASK   (0x04)
#define CGCR_P2_SW_OPEN_MASK   (0x08)
#define CGCR_P2_SW_CLOSE_MASK  (0x0C)
#define CGCR_P2_GLOBAL_MASK    (0xF3)
#else //(SCKEY_P2_CH == CH3)
#define CCMR_P2                (RI->IOCMR3)
#define IOSR_P2                (RI->IOSR3)
#define CGCR_P2_PP_LOW_MASK    (0x00)
#define CGCR_P2_PP_HIGH_MASK   (0x10)
#define CGCR_P2_SW_OPEN_MASK   (0x20)
#define CGCR_P2_SW_CLOSE_MASK  (0x30)
#define CGCR_P2_GLOBAL_MASK    (0xCF)

#endif
#endif

#if (SAMP_CAP_CH == CH1)
#define CCMR_SAMP                (RI->IOCMR1)
#define IOSR_SAMP                (RI->IOSR1)
#define CSR_SAMP                 (RI->IOIR1)
#define CGCR_SAMP_PP_LOW_MASK    (0x00)
#define CGCR_SAMP_PP_HIGH_MASK   (0x01)
#define CGCR_SAMP_SW_OPEN_MASK   (0x02)
#define CGCR_SAMP_SW_CLOSE_MASK  (0x03)
#define CGCR_SAMP_GLOBAL_MASK    (0xFC)
#elif (SAMP_CAP_CH == CH2)
#define CCMR_SAMP                (RI->IOCMR2)
#define IOSR_SAMP                (RI->IOSR2)
#define CSR_SAMP                 (RI->IOIR2)
#define CGCR_SAMP_PP_LOW_MASK    (0x00)
#define CGCR_SAMP_PP_HIGH_MASK   (0x04)
#define CGCR_SAMP_SW_OPEN_MASK   (0x08)
#define CGCR_SAMP_SW_CLOSE_MASK  (0x0C)
#define CGCR_SAMP_GLOBAL_MASK    (0xF3)
#else //(SCKEY_SAMP_CH == CH3)
#define CCMR_SAMP                (RI->IOCMR3)
#define IOSR_SAMP                (RI->IOSR3)
#define CSR_SAMP                 (RI->IOIR3)
#define CGCR_SAMP_PP_LOW_MASK    (0x00)
#define CGCR_SAMP_PP_HIGH_MASK   (0x10)
#define CGCR_SAMP_SW_OPEN_MASK   (0x20)
#define CGCR_SAMP_SW_CLOSE_MASK  (0x30)
#define CGCR_SAMP_GLOBAL_MASK    (0xCF)
#endif

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
#if SPREAD_SPECTRUM
#if SW_SPREAD_SPECTRUM
static u8 SpreadCounter;
#endif  //SW_SPREAD_SPECTRUM
u8 Previous_calibration_value;
#endif //SPREAD_SPECTRUM
TOUCH_PORT_Info_T TINY sTouchIO;
u16 TINY CounterStop;
u8 TINY SamplingShifter;
u8 TINY AcquisitionBitMask;
Info_Channel Channel_P1;
Info_Channel Channel_P2;
Info_Channel Channel_P3;

/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
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
#elif NUMBER_OF_MULTI_CHANNEL_KEYS == 2
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

#if SPREAD_SPECTRUM && SW_SPREAD_SPECTRUM
/**
  ******************************************************************************
  * @brief Spread Spectrum waiting routine. A variable delay is
  * inserted between each step.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * SPREAD_SPECTRUM must be defined and not null in the configuration file
 * SW_SPREAD_SPECTRUM must be defined and not null in the configuration file
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
#endif /* SPREAD_SPECTRUM && SW_SPREAD_SPECTRUM */


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

  /*init the IO to use with the TS controller registers*/

  /*Enable the TS IP clcock*/
  CLK->PCKENR2 |= 0x20;

  /*initialization of TS IP*/

  //select which IOs will be managed by the TS IP
  CCMR_P1   = SCKEY_P1_MASK;
#if NUMBER_OF_ACQUISITION_PORTS > 1
  CCMR_P2   = SCKEY_P2_MASK;
#endif
  CCMR_SAMP = SAMP_CAP_MASK;

  //select which channel will be enabled
  IOSR_P1   = SCKEY_P1_MASK;
#if NUMBER_OF_ACQUISITION_PORTS > 1
  IOSR_P2   = SCKEY_P2_MASK;
#endif
  IOSR_SAMP = SAMP_CAP_MASK;
#if ACTIVE_SHIELD_GROUP
	ACTIVE_SHIELD_P1_PORT->DDR &= (uint8_t)(~ACTIVE_SHIELD_P1_BIT);
	ACTIVE_SHIELD_P1_PORT->CR1 &= (uint8_t)(~ACTIVE_SHIELD_P1_BIT);
	ACTIVE_SHIELD_P2_PORT->DDR &= (uint8_t)(~ACTIVE_SHIELD_P2_BIT);
	ACTIVE_SHIELD_P2_PORT->CR1 &= (uint8_t)(~ACTIVE_SHIELD_P2_BIT);
#endif
  TSL_IO_Clamp();

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

  //All IO in input with the analog switch OPEN
  RI->IOGCR = CGCR_P1_SW_OPEN_MASK | CGCR_SAMP_SW_OPEN_MASK
#if NUMBER_OF_ACQUISITION_PORTS > 1
              | CGCR_P2_SW_OPEN_MASK
#endif
              ;

  //All IO to pushpull LOW for discharging all capacitors (Ctouch and Csense)
  RI->IOGCR = CGCR_P1_PP_LOW_MASK | CGCR_SAMP_PP_LOW_MASK
#if NUMBER_OF_ACQUISITION_PORTS > 1
              | CGCR_P2_PP_LOW_MASK
#endif
              ;

  //wait for good discharging of all capacitors
  {u16 i;
    for (i = 0; i < 2000 ;i++) {}
  }

  //All IO in input with the analog switch OPEN
  RI->IOGCR = CGCR_P1_SW_OPEN_MASK | CGCR_SAMP_SW_OPEN_MASK
#if NUMBER_OF_ACQUISITION_PORTS > 1
              | CGCR_P2_SW_OPEN_MASK
#endif
              ;

  //close the analog switch of the channel used for the sampling capacitor
  //RI->IOGCR = CGCR_SAMP_SW_CLOSE_MASK;
}

/**
  ******************************************************************************
  * @brief Acquisition function for the 1st Channel IO of each group
  * @param[in] AcqNumber Number of times the acquisition is done.
  * @param[in] AdjustmentLevel Used to adjust the measured level.
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_IO_Acquisition_P1(u16 MaxAcqNumber)
{

  u16 MeasurementCounter;
#if SPREAD_SPECTRUM && !SW_SPREAD_SPECTRUM
  u8 HSI_fact_Calib;
#endif

  Channel_P1.Measure[0] = INIT_VALUE;
  Channel_P1.Measure[1] = INIT_VALUE;
  Channel_P1.Measure[2] = INIT_VALUE;
  Channel_P1.Measure[3] = INIT_VALUE;
  Channel_P1.Measure[4] = INIT_VALUE;
  Channel_P1.Measure[5] = INIT_VALUE;
  Channel_P1.Measure[6] = INIT_VALUE;
  Channel_P1.Measure[7] = INIT_VALUE;

#if (ACTIVE_SHIELD_GROUP)
	CCMR_P1   |= ACTIVE_SHIELD_GROUP;
#if NUMBER_OF_ACQUISITION_PORTS > 1
  CCMR_P2   &= (uint8_t)(~ACTIVE_SHIELD_GROUP);
#endif
#endif

	//P1 and Sampling capacitor IOs in input with the analog switch OPEN
  RI->IOGCR = (u8)((RI->IOGCR & (CGCR_P1_GLOBAL_MASK & CGCR_SAMP_GLOBAL_MASK)) | (CGCR_P1_SW_OPEN_MASK | CGCR_SAMP_SW_OPEN_MASK));

  //close the analog switch of the channel used for the sampling capacitor
  RI->IOGCR |= CGCR_SAMP_SW_CLOSE_MASK;

  Channel_P1.State.whole = 0x00;

  /*reset the counter*/
  MeasurementCounter = 0x0000;

  /*START spread spectrum*/
#if SPREAD_SPECTRUM && !SW_SPREAD_SPECTRUM
  /*save the user application calibration value*/
  if (CLK->HSITRIMR != 0x00) /*the application  use the Triming register*/
  {
    Previous_calibration_value = CLK->HSITRIMR;
  }
  else /*the application doesn't use the trimming register*/
  {
    Previous_calibration_value = CLK->HSICALR;
  }

  HSI_fact_Calib = CLK->HSICALR;
  CLK->HSIUNLCKR = 0xAC;
  CLK->HSIUNLCKR = 0x35;
  CLK->HSITRIMR = HSI_fact_Calib;

#endif

  /*loop while all the 1st channel of each group have not reach the VIH level*/
  do
  {
    /*charging the Ctouch cap with connecting the IO to Vdd (IO in push-pull HIGH)*/
    RI->IOGCR = (u8)((RI->IOGCR & CGCR_P1_GLOBAL_MASK) | CGCR_P1_PP_HIGH_MASK);

    if (CSR_SAMP & (uint8_t)~Channel_P1.State.whole)
    {
      /*To guaranty a good charging the high level on Ctouch has to be maintained about 2us.
      Instead of performing a waiting loop, the first part of the test to detect if a pin 
      has reach the VDDIO/2 threshold is performed here.*/
      if ((Channel_P1.State.b.Grp1 == 0) && ((CSR_SAMP&Group1) == Group1))
      {
        Channel_P1.Measure[0] = MeasurementCounter;
        Channel_P1.State.whole |= Group1;
      }
      if ((Channel_P1.State.b.Grp2 == 0) && ((CSR_SAMP&Group2) == Group2))
      {
        Channel_P1.Measure[1] = MeasurementCounter;
        Channel_P1.State.whole |= Group2;
      }
      if ((Channel_P1.State.b.Grp3 == 0) && ((CSR_SAMP&Group3) == Group3))
      {
        Channel_P1.Measure[2] = MeasurementCounter;
        Channel_P1.State.whole |= Group3;
      }
      if ((Channel_P1.State.b.Grp4 == 0) && ((CSR_SAMP&Group4) == Group4))
      {
        Channel_P1.Measure[3] = MeasurementCounter;
        Channel_P1.State.whole |= Group4;
      }
      if ((Channel_P1.State.b.Grp5 == 0) && ((CSR_SAMP&Group5) == Group5))
      {
        Channel_P1.Measure[4] = MeasurementCounter;
        Channel_P1.State.whole |= Group5;
      }

      if ((Channel_P1.State.b.Grp6 == 0) && ((CSR_SAMP&Group6) == Group6))
      {
        Channel_P1.Measure[5] = MeasurementCounter;
        Channel_P1.State.whole |= Group6;
      }
      if ((Channel_P1.State.b.Grp7 == 0) && ((CSR_SAMP&Group7) == Group7))
      {
        Channel_P1.Measure[6] = MeasurementCounter;
        Channel_P1.State.whole |= Group7;
      }
      if ((Channel_P1.State.b.Grp8 == 0) && ((CSR_SAMP&Group8) == Group8))
      {
        Channel_P1.Measure[7] = MeasurementCounter;
        Channel_P1.State.whole |= Group8;
      }
    }
    MeasurementCounter++;

    CLWHTA;  /**< programmable delay */

    /*charging the Csense cap with connecting it to Ctouch by closing the analog switch.
    Here the charge is transfered from the Ctouch to the Csens capacitors*/
    RI->IOGCR = (u8)((RI->IOGCR & CGCR_P1_GLOBAL_MASK) | CGCR_P1_SW_CLOSE_MASK);

#if SPREAD_SPECTRUM && !SW_SPREAD_SPECTRUM
    if (CLK->HSITRIMR > HSI_fact_Calib - SPREAD_COUNTER_MAX)
    {
      u8 Prev_HSI_TRIM;
      Prev_HSI_TRIM = (u8)(CLK->HSITRIMR - 1);
      CLK->HSIUNLCKR = 0xAC;
      CLK->HSIUNLCKR = 0x35;
      CLK->HSITRIMR = Prev_HSI_TRIM;
    }
    else
    {
      CLK->HSIUNLCKR = 0xAC;
      CLK->HSIUNLCKR = 0x35;
      CLK->HSITRIMR = HSI_fact_Calib ;
    }
#endif

    /*it's better to implement this like that because it's much more faster than to put this test in the "while test" below
      and only the MSByte is tested in order to speed the test up */
    if ((u8)(MeasurementCounter >> 8) > (u8)(MaxAcqNumber >> 8))
    {
      break;
    }
    /*wait for good discharging of the the Ctouch cap in the Csense */
    CLWLTA;  /**< programmable delay */

#if SPREAD_SPECTRUM && SW_SPREAD_SPECTRUM
    TSL_SW_Spread_Spectrum();
#endif

  }
  while (((Channel_P1.State.whole & Channel_P1.EnabledChannels) != Channel_P1.EnabledChannels));
  /*problem with the line above when the MASK is not done.
  In fact when the SCKEY_P1_MASK is not performed some unused channels are is detected state */

#if SPREAD_SPECTRUM && !SW_SPREAD_SPECTRUM
  /*Restore the user application calibration value*/
  CLK->HSIUNLCKR = 0xAC;
  CLK->HSIUNLCKR = 0x35;
  CLK->HSITRIMR = Previous_calibration_value;
#endif

  //P1 and Sampling capacitor IOs in input with the analog switch OPEN
  RI->IOGCR = (u8)((RI->IOGCR & (CGCR_P1_GLOBAL_MASK & CGCR_SAMP_GLOBAL_MASK)) | (CGCR_P1_SW_OPEN_MASK | CGCR_SAMP_SW_OPEN_MASK));

  //P1 and Sampling capacitors IOs to LOW for discharging
  RI->IOGCR = (u8)((RI->IOGCR & (CGCR_P1_GLOBAL_MASK & CGCR_SAMP_GLOBAL_MASK)) | (CGCR_P1_PP_LOW_MASK | CGCR_SAMP_PP_LOW_MASK));
}


/**
  ******************************************************************************
  * @brief Acquisition function for the 1st Channel IO of each group
  * @param[in] AcqNumber Number of times the acquisition is done.
  * @param[in] AdjustmentLevel Used to adjust the measured level.
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
#if NUMBER_OF_ACQUISITION_PORTS > 1
void TSL_IO_Acquisition_P2(u16 MaxAcqNumber)
{

  u16 MeasurementCounter;

#if SPREAD_SPECTRUM && !SW_SPREAD_SPECTRUM
  u8 HSI_fact_Calib;
#endif

  Channel_P2.Measure[0] = INIT_VALUE;
  Channel_P2.Measure[1] = INIT_VALUE;
  Channel_P2.Measure[2] = INIT_VALUE;
  Channel_P2.Measure[3] = INIT_VALUE;
  Channel_P2.Measure[4] = INIT_VALUE;
  Channel_P2.Measure[5] = INIT_VALUE;
  Channel_P2.Measure[6] = INIT_VALUE;
  Channel_P2.Measure[7] = INIT_VALUE;

#if (ACTIVE_SHIELD_GROUP)
	CCMR_P2   |= ACTIVE_SHIELD_GROUP;
	CCMR_P1   &= (uint8_t)(~ACTIVE_SHIELD_GROUP);  
#endif

  //P2 and Sampling capacitor IOs in input with the analog switch OPEN
  RI->IOGCR = (u8)((RI->IOGCR & (CGCR_P2_GLOBAL_MASK & CGCR_SAMP_GLOBAL_MASK)) | (CGCR_P2_SW_OPEN_MASK | CGCR_SAMP_SW_OPEN_MASK));

  //close the analog switch of the channel used for the sampling capacitor
  RI->IOGCR |= CGCR_SAMP_SW_CLOSE_MASK;

  Channel_P2.State.whole = 0x00;

  /*reset the counter*/
  MeasurementCounter = 0x0000;

  /*START spread spectrum*/
#if SPREAD_SPECTRUM && !SW_SPREAD_SPECTRUM
  /*save the user application calibration value*/
  if (CLK->HSITRIMR != 0x00) /*the application  use the Triming register*/
  {
    Previous_calibration_value = CLK->HSITRIMR;
  }
  else /*the application doesn't use the trimming register*/
  {
    Previous_calibration_value = CLK->HSICALR;
  }

  HSI_fact_Calib = CLK->HSICALR;
  CLK->HSIUNLCKR = 0xAC;
  CLK->HSIUNLCKR = 0x35;
  CLK->HSITRIMR = HSI_fact_Calib;

#endif

  /*loop while all the 1st channel of each group have not reach the VIH level*/
  do
  {
    /*charging the Ctouch cap with connecting the IO to Vdd (IO in push-pull HIGH)*/
    RI->IOGCR = (u8)((RI->IOGCR & CGCR_P2_GLOBAL_MASK) | CGCR_P2_PP_HIGH_MASK);

    if (CSR_SAMP & (uint8_t)~Channel_P2.State.whole)
    {
      /*To guaranty a good charging the high level on Ctouch has to be maintained about 2us.
      Instead of performing a waiting loop, the first part of the test to detect if a pin 
      has reach the VDDIO/2 threshold is performed here.*/
      if ((Channel_P2.State.b.Grp1 == 0) && ((CSR_SAMP&Group1) == Group1))
      {
        Channel_P2.Measure[0] = MeasurementCounter;
        Channel_P2.State.whole |= Group1;
      }
      if ((Channel_P2.State.b.Grp2 == 0) && ((CSR_SAMP&Group2) == Group2))
      {
        Channel_P2.Measure[1] = MeasurementCounter;
        Channel_P2.State.whole |= Group2;
      }
      if ((Channel_P2.State.b.Grp3 == 0) && ((CSR_SAMP&Group3) == Group3))
      {
        Channel_P2.Measure[2] = MeasurementCounter;
        Channel_P2.State.whole |= Group3;
      }
      if ((Channel_P2.State.b.Grp4 == 0) && ((CSR_SAMP&Group4) == Group4))
      {
        Channel_P2.Measure[3] = MeasurementCounter;
        Channel_P2.State.whole |= Group4;
      }
      if ((Channel_P2.State.b.Grp5 == 0) && ((CSR_SAMP&Group5) == Group5))
      {
        Channel_P2.Measure[4] = MeasurementCounter;
        Channel_P2.State.whole |= Group5;
      }

      if ((Channel_P2.State.b.Grp6 == 0) && ((CSR_SAMP&Group6) == Group6))
      {
        Channel_P2.Measure[5] = MeasurementCounter;
        Channel_P2.State.whole |= Group6;
      }
      if ((Channel_P2.State.b.Grp7 == 0) && ((CSR_SAMP&Group7) == Group7))
      {
        Channel_P2.Measure[6] = MeasurementCounter;
        Channel_P2.State.whole |= Group7;
      }
      if ((Channel_P2.State.b.Grp8 == 0) && ((CSR_SAMP&Group8) == Group8))
      {
        Channel_P2.Measure[7] = MeasurementCounter;
        Channel_P2.State.whole |= Group8;
      }
    }

    MeasurementCounter++;

    CLWHTA;  /**< programmable delay */

    /*charging the Csense cap with connecting it to Ctouch by closing the analog switch.
    Here the charge is transfered from the Ctouch to the Csens capacitors*/
    RI->IOGCR = (u8)((RI->IOGCR & CGCR_P2_GLOBAL_MASK) | CGCR_P2_SW_CLOSE_MASK);

#if SPREAD_SPECTRUM && !SW_SPREAD_SPECTRUM
    if (CLK->HSITRIMR > HSI_fact_Calib - SPREAD_COUNTER_MAX)
    {
      u8 Prev_HSI_TRIM;
      Prev_HSI_TRIM = (u8)(CLK->HSITRIMR - 1);
      CLK->HSIUNLCKR = 0xAC;
      CLK->HSIUNLCKR = 0x35;
      CLK->HSITRIMR = Prev_HSI_TRIM;
    }
    else
    {
      CLK->HSIUNLCKR = 0xAC;
      CLK->HSIUNLCKR = 0x35;
      CLK->HSITRIMR = HSI_fact_Calib ;
    }
#endif

    /*it's better to implement this like that because it's much more faster than to put this test in the "while test" below
      and only the MSByte is tested in order to speed the test up */
    if ((u8)(MeasurementCounter >> 8) > (u8)(MaxAcqNumber >> 8))
    {
      break;
    }
    /*wait for good discharging of the the Ctouch cap in the Csense */
    CLWLTA;  /**< programmable delay */
#if SPREAD_SPECTRUM && SW_SPREAD_SPECTRUM
    TSL_SW_Spread_Spectrum();
#endif

  }
  while (((Channel_P2.State.whole & Channel_P2.EnabledChannels) != Channel_P2.EnabledChannels));

#if SPREAD_SPECTRUM && !SW_SPREAD_SPECTRUM
  /*Restore the user application calibration value*/
  CLK->HSIUNLCKR = 0xAC;
  CLK->HSIUNLCKR = 0x35;
  CLK->HSITRIMR = Previous_calibration_value;
#endif

  //P2 and Sampling capacitor IOs in input with the analog switch OPEN
  RI->IOGCR = (u8)((RI->IOGCR & (CGCR_P2_GLOBAL_MASK & CGCR_SAMP_GLOBAL_MASK)) | (CGCR_P2_SW_OPEN_MASK | CGCR_SAMP_SW_OPEN_MASK));

  //P2 and Sampling capacitors IOs to LOW for discharing
  RI->IOGCR = (u8)((RI->IOGCR & (CGCR_P2_GLOBAL_MASK & CGCR_SAMP_GLOBAL_MASK)) | (CGCR_P2_PP_LOW_MASK | CGCR_SAMP_PP_LOW_MASK));

}
#endif
#endif


/* Public functions ----------------------------------------------------------*/

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
