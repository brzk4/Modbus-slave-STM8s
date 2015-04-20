/**
  ******************************************************************************
  * @file    stm8_tsl_conf_CT_TOADAPT.h
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file is a template for the
  *          Charge-Transfer acquisition and must be adapted to your requirements.
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
#ifndef __TSL_CONF_H
#define __TSL_CONF_H


//==============================================================================
//
// 1) MCU FAMILY SELECTION
//
// Uncomment only one line to select the device used.
//
//==============================================================================

//#define STM8L15X (1)  /**< Select this line if the STM8L15X MCU is used */
#define STM8L10X (1)    /**< Select this line if the STM8L10X MCU is used */


//==============================================================================
//
// 2) GENERIC TIMEBASE TIMER SELECTION (TIMTICK)
//
// Set the generic timebase timer.
// The timer you select must be a basic 8-bit timer.
// This table summarizes the values for some products (consult the datasheet
// if your product is not in the list):
// Product                TIMTICK
// STM8L15x               TIM4
// STM8L10x               TIM4
// Warning: The selected timer update/overflow interrupt vector must point to
// the TSL_Timer_ISR() interrupt routine.
//
//==============================================================================

#define TIMTICK         (TIM4)


//==============================================================================
//
//  *** GROUP AND CHANNEL DESCRIPTION ***
//
//   CHARGE_TRANSFER group and channel description for STM8L10x
//       For more details please refer to the Comparator
//       section in the reference manual
//
// Group 1  CH1   PB0  __/____
//          CH2   PB1  __/__|
//          CH3   PD0  __/__|
//          CH4   PD1  __/__|
//
// Group 2  CH1   PB2  __/____
//          CH2   PB3  __/__|
//          CH3   PD2  __/__|
//          CH4   PD3  __/__|
//
//
//   CHARGE_TRANSFER group and channel description for STM8L15x
//       For more details please refer to the Routing Interface
//       section in the reference manual
//
// Group 1  CH1   PA6  __/____
//          CH2   PA5  __/__|
//          CH3   PA4  __/__|
//
// Group 2  CH1   PC7  __/____
//          CH2   PC4  __/__|
//          CH3   PC3  __/__|
//
// Group 3  CH1   PC2  __/____
//          CH2   PD7  __/__|
//          CH3   PD6  __/__|
//
// Group 4  CH1   PD5  __/____
//          CH2   PD4  __/__|
//          CH3   PB7  __/__|
//
// Group 5  CH1   PB6  __/____
//          CH2   PB5  __/__|
//          CH3   PB4  __/__|
//
// Group 6  CH1   PB3  __/____
//          CH2   PB2  __/__|
//          CH3   PB1  __/__|
//
// Group 7  CH1   PB0  __/____
//          CH2   PD3  __/__|
//          CH3   PD2  __/__|
//
// Group 8  CH1   PD1  __/____
//          CH2   PD0  __/__|
//          CH3   PE5  __/__|
//
// The below values are only used for the groups and channels settings.
// DO NOT change the values.
#define GROUP1 (0x01)
#define GROUP2 (0x02)
#define GROUP3 (0x04)
#define GROUP4 (0x08)
#define GROUP5 (0x10)
#define GROUP6 (0x20)
#define GROUP7 (0x40)
#define GROUP8 (0x80)
#define CH1    (1)
#define CH2    (2)
#define CH3    (3)
#define CH4    (4)
//==============================================================================


//==============================================================================
//
// 3) SAMPLING CAPACITOR CHANNEL SELECTION
//
// Set the sampling capacitors channel.
//
// The hardware for CHARGE_TRANSFER is done in such way that all the sampling
// capacitors have to be connected to the same channel of each group.
// For example, the sampling capacitors are connected to CH2 of each group.
//
//==============================================================================

#define SAMP_CAP_CH   (CH3)  /**< Possible values are CH1, CH2, CH3 and CH4 */


//==============================================================================
//
// 4) SINGLE CHANNEL KEYS DEFINITION FOR CHARGE_TRANSFER - 1st Channel
//
// Set the number of keys
// Set the Channel (cannot be the channel defined for the sampling capacitor)
// set the group for each key
//
//==============================================================================

#define SCKEY_P1_KEY_COUNT  (1)

#define SCKEY_P1_CH   (CH1) /**< Possible values are CH1, CH2, CH3 and CH4 */
/**< Even if SCKEY_P1_KEY_COUNT is null          */
/**< SCKEY_P1_CH must contain the channel number */
/**< used by a multi-key*/

#define SCKEY_P1_A  (GROUP2)
#define SCKEY_P1_B  (0)
#define SCKEY_P1_C  (0)
#define SCKEY_P1_D  (0)
#define SCKEY_P1_E  (0)
#define SCKEY_P1_F  (0)
#define SCKEY_P1_G  (0)
#define SCKEY_P1_H  (0)


//==============================================================================
//
// 5) SINGLE CHANNEL KEYS DEFINITION FOR CHARGE_TRANSFER - 2nd Channel
//
// Set the number of keys
// Set the Channel (cannot be the channel defined for the sampling capacitor)
// set the group for each key
//
//==============================================================================

#define SCKEY_P2_KEY_COUNT  (1)

#define SCKEY_P2_CH   (CH2) /**< Possible values are CH1, CH2, CH3 and CH4 */
/**< Even if SCKEY_P2_KEY_COUNT is null                */
/**< SCKEY_P2_CH must contain the channel number       */
/**< used by a multi-key if different from SCKEY_P1_CH */

#define SCKEY_P2_A  (GROUP2)
#define SCKEY_P2_B  (0)
#define SCKEY_P2_C  (0)
#define SCKEY_P2_D  (0)
#define SCKEY_P2_E  (0)
#define SCKEY_P2_F  (0)
#define SCKEY_P2_G  (0)
#define SCKEY_P2_H  (0)


/*==============================================================================
//                         *** ONLY FOR STM8L10x ***
//
// 6) SINGLE CHANNEL KEYS DEFINITION FOR CHARGE_TRANSFER - 3nd Channel
//
// Set the number of keys
// Set the Channel (cannot be the channel defined for the sampling capacitor)
// set the group for each key
//
//==============================================================================*/

#if defined(STM8L10X)

#define SCKEY_P3_KEY_COUNT  (1)

#define SCKEY_P3_CH   (CH4) /**< Possible values are CH1, CH2, CH3 and CH4 */
/**< Even if SCKEY_P3_KEY_COUNT is null                */
/**< SCKEY_P3_CH must contain the channel number       */
/**< used by a multi-key if different from SCKEY_P1_CH */
/**< and SCKEY_P2_CH                                   */

#define SCKEY_P3_A  (GROUP2)
#define SCKEY_P3_B  (0)

#endif


//==============================================================================
//
// 7) NUMBER OF MULTI CHANNEL KEYS AND NUMBER OF CHANNELS USED
//
// Set the total number of multi channel keys used (0, 1 or 2)
//
//==============================================================================

#define NUMBER_OF_MULTI_CHANNEL_KEYS  (2)  /**< Number of multi channel keys (value from 0 to 2) */


//==============================================================================
//
// 8) MULTI CHANNEL KEYS DEFINITION FOR CHARGE_TRANSFER - 1st Channel
//
// Set the number of keys
// Set the Channel (cannot be the channel defined for the sampling capacitor)
// set the group for each key
//
//==============================================================================

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0

#define MCKEY1_A_CH  (CH1)      /**< Multi channel key 1: 1st channel port */
#define MCKEY1_A     (GROUP1)   /**< Multi channel key 1: 1st channel mask */
#define MCKEY1_B_CH  (CH2)      /**< Multi channel key 1: 2nd channel port */
#define MCKEY1_B     (GROUP1)   /**< Multi channel key 1: 2nd channel mask */
#define MCKEY1_C_CH  (CH4)      /**< Multi channel key 1: 3rd channel port */
#define MCKEY1_C     (GROUP1)   /**< Multi channel key 1: 3rd channel mask */

#define MCKEY1_TYPE (0)         /**< Multi channel key 1 type: 0=wheel (zero between two electrodes), 1=slider (zero in the middle of one electrode) */

#endif


//==============================================================================
//
// 9) MULTI CHANNEL KEYS DEFINITION FOR CHARGE_TRANSFER - 2nd Channel (optional)
//
// Set the number of keys
// Set the Channel (cannot be the channel defined for the sampling capacitor)
// set the group for each key
//
//==============================================================================

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1

#define MCKEY2_A_CH   (0)          /**< Multi channel key 2: 1st channel port */
#define MCKEY2_A      (0)          /**< Multi channel key 2: 1st channel mask */
#define MCKEY2_B_CH   (0)          /**< Multi channel key 2: 2nd channel port */
#define MCKEY2_B      (0)          /**< Multi channel key 2: 2nd channel mask */
#define MCKEY2_C_CH   (0)          /**< Multi channel key 2: 3rd channel port */
#define MCKEY2_C      (0)          /**< Multi channel key 2: 3rd channel mask */

#define MCKEY2_TYPE (0)            /**< Multi channel key 2 type: 0=wheel (zero between two electrodes), 1=slider (zero in the middle of one electrode) */

#endif



//============================================================================
//
// 10) TSL PARAMETERS CONFIGURATION
//
//============================================================================

/** @addtogroup TSL_parameters_CT
  * @{ */

// Thresholds
#define SCKEY_DETECTTHRESHOLD_DEFAULT          (30)  /**< Single channel key detection threshold (value from 1 to 127) */
#define SCKEY_ENDDETECTTHRESHOLD_DEFAULT       (15)  /**< Single channel key end detection threshold (value from 1 to 127) */
#define SCKEY_RECALIBRATIONTHRESHOLD_DEFAULT  (-15)  /**< Single channel key calibration threshold (value from -1 to -128) */
#define MCKEY_DETECTTHRESHOLD_DEFAULT          (45)  /**< Multi channel key detection threshold (value from 1 to 127) */
#define MCKEY_ENDDETECTTHRESHOLD_DEFAULT       (40)  /**< Multi channel key end detection threshold (value from 1 to 127) */
#define MCKEY_RECALIBRATIONTHRESHOLD_DEFAULT  (-45)  /**< Multi channel key calibration threshold (value from -1 to -128) */

// MCKey resolution
#define MCKEY_RESOLUTION_DEFAULT                   (7)  /**< Multi channel key resolution (value from 1 to 8) */

// MCKey Direction Change process
#define MCKEY_DIRECTION_CHANGE_ENABLED               (1)  /**< Multi channel key direction change enable (1) or disable (0) switch */
#define MCKEY_DIRECTION_CHANGE_MAX_DISPLACEMENT    (255)  /**< Multi channel key direction change maximum displacement (value from 0 to 255) */
#define MCKEY_DIRECTION_CHANGE_INTEGRATOR_DEFAULT    (1)  /**< Multi channel key direction change integrator (value from 1 to 255) */
#define MCKEY_DIRECTION_CHANGE_THRESHOLD_DEFAULT    (10)  /**< Multi channel key direction change threshold (value from 1 to 255) */

// Integrators
#define DETECTION_INTEGRATOR_DEFAULT       (2)  /**< Detection Integrator = Debounce Filter (value from 0 to 255) */
#define END_DETECTION_INTEGRATOR_DEFAULT   (2)  /**< End detection Integrator = Debounce Filter (from 0 to 255) */
#define RECALIBRATION_INTEGRATOR_DEFAULT  (10)  /**< Calibration integrator (value from 1 to 255) */

// IIR Filter
#define ECS_TIME_STEP_DEFAULT  (20)  /**< Sampling frequency, multiple of 10ms */
#define ECS_TEMPO_DEFAULT      (20)  /**< Delay after detection, multiple of 100ms */
#define ECS_IIR_KFAST_DEFAULT  (20)  /**< K factor for fast filtering */
#define ECS_IIR_KSLOW_DEFAULT  (10)  /**< K factor for slow filtering */

// Detection Timeout
#define DTO_DEFAULT  (0)  /**< 1s unit (value from 0 (= infinite!) to 255) */

// Acquisition values limits
#define SCKEY_MIN_ACQUISITION     (50) /**< Single channel key minimum acquisition value */
#define SCKEY_MAX_ACQUISITION   (3000) /**< Single channel key maximum acquisition value */
#define MCKEY_MIN_ACQUISITION    (150) /**< Multi channel key minimum acquisition value */
#define MCKEY_MAX_ACQUISITION   (5000) /**< Multi channel key maximum acquisition value */

// Optional parameters for Delta Normalization Process (for Multi channel keys only).
// The MSB is the integer part, the LSB is the real part:
// For example to apply a factor 1.10:
// 0x01 to the MSB
// 0x1A to the LSB (0.1 x 256 = 25.6 -> 26 = 0x1A)
// Final value to define is: 0x011A

#define MCKEY1_DELTA_COEFF_A (0x0100) /**< MCKey1 Channel A parameter */
#define MCKEY1_DELTA_COEFF_B (0x0100) /**< MCKey1 Channel B parameter */
#define MCKEY1_DELTA_COEFF_C (0x0100) /**< MCKey1 Channel C parameter */
#define MCKEY1_DELTA_COEFF_D (0x0100) /**< MCKey1 Channel D parameter */
#define MCKEY1_DELTA_COEFF_E (0x0100) /**< MCKey1 Channel E parameter */
#define MCKEY1_DELTA_COEFF_F (0x0100) /**< MCKey1 Channel F parameter */
#define MCKEY1_DELTA_COEFF_G (0x0100) /**< MCKey1 Channel G parameter */
#define MCKEY1_DELTA_COEFF_H (0x0100) /**< MCKey1 Channel H parameter */

#define MCKEY2_DELTA_COEFF_A (0x0100) /**< MCKey2 Channel A parameter */
#define MCKEY2_DELTA_COEFF_B (0x0100) /**< MCKey2 Channel B parameter */
#define MCKEY2_DELTA_COEFF_C (0x0100) /**< MCKey2 Channel C parameter */
#define MCKEY2_DELTA_COEFF_D (0x0100) /**< MCKey2 Channel D parameter */
#define MCKEY2_DELTA_COEFF_E (0x0100) /**< MCKey2 Channel E parameter */
#define MCKEY2_DELTA_COEFF_F (0x0100) /**< MCKey2 Channel F parameter */
#define MCKEY2_DELTA_COEFF_G (0x0100) /**< MCKey2 Channel G parameter */
#define MCKEY2_DELTA_COEFF_H (0x0100) /**< MCKey2 Channel H parameter */

// Interrupt synchronisation
//#define IT_SYNC  (1) /**< Interrupt synchronisation. (=1) Allow to synchronize the aquisition with a flag set in an interrupt routine */

//IO Protection from Interrupt modification
#define PROTECT_IO_ACCESS (1)  /**< Protect the IO access : to be enabled to allow the access to the IO registers used by the STM Touch library by any interrupt routine */

// Capacitance Loading Waiting HIGH Time Adjustment
#define CLWHTA    {nop();}  /**< Add here the necessary number of NOP  or a call to wait(n);*/
// Capacitance Loading Waiting LOW Time Adjustment
#define CLWLTA    {}  /**< Add here the necessary number of NOP or a call to wait(n);*/

// Spread spectrum
#define SPREAD_SPECTRUM      (0) /**< Spread spectrum enabled (=1) */
#define SW_SPREAD_SPECTRUM   (0) /**< Software Spread spectrum enabled (=1) for STM8L15x only when the UART is also used, to comment if not used */
#define SPREAD_COUNTER_MIN   (1) /**< Spread min value (for STM8L10x devices or when STM8L15x and the Software Spread Spectrum is used) CAUTION :  0 is not a valid value*/
#define SPREAD_COUNTER_MAX  (20) /**< Spread max value (for STM8L10x devices or when the Software Spread Spectrum is used) or maximum amplitude of the HSI trimming for STM8L15x and Software Spread Spectrum disabled */
// Active Shield
#define ACTIVE_SHIELD_GROUP  (0) /**< Active Shield is disabled (=0), else this symbolic constant contains the group dedicated to this function, this group will be driven but never acquired  */
// RTOS Management of the acquisition (instead of the timebase interrupt sub-routine
#define RTOS_MANAGEMENT    (0) /**< The Timebase routine is launched by the application instead to be managed through a timebase interrupt routine */
// Timer Callback to allow the user to add its own function called from the timer interrupt sub-routine
#define TIMER_CALLBACK (0)    /**< if (1) Allows the use of a callback function in the timer interrupt. This function will be called every 0.5ms. The callback function must be defined inside the application and have the following prototype FAR void USER_TickTimerCallback(void);  */
//Inline functions
#define USE_INLINED_FUNCTIONS (1) /**< Inline functions are enabled (=1) */

/** @} */


//==============================================================================
//
// DEFINITIONS CHECK. DO NOT TOUCH ANYTHING BELOW !!!
//
//==============================================================================

#define CHARGE_TRANSFER (1)

// Automatic Calibration always enabled
#define NEGDETECT_AUTOCAL (1)

// Only 3 channels per MCKey are supported
#define CHANNEL_PER_MCKEY (3)
#define MCKEY1_D_CH   (0)
#define MCKEY1_D      (0)
#define MCKEY1_E_CH   (0)
#define MCKEY1_E      (0)
#define MCKEY1_F_CH   (0)
#define MCKEY1_F      (0)
#define MCKEY1_G_CH   (0)
#define MCKEY1_G      (0)
#define MCKEY1_H_CH   (0)
#define MCKEY1_H      (0)
#define MCKEY2_D_CH   (0)
#define MCKEY2_D      (0)
#define MCKEY2_E_CH   (0)
#define MCKEY2_E      (0)
#define MCKEY2_F_CH   (0)
#define MCKEY2_F      (0)
#define MCKEY2_G_CH   (0)
#define MCKEY2_G      (0)
#define MCKEY2_H_CH   (0)
#define MCKEY2_H      (0)

// Only the interlaced layout is supported
#define MCKEY1_LAYOUT_TYPE (0)
#define MCKEY2_LAYOUT_TYPE (0)

#include "stm8_tsl_checkconfig.h"

#endif /* __TSL_CONF_H */

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
