/**
  ******************************************************************************
  * @file    stm8_tsl_services.c
  * @author  MCD Application Team
  * @version V2.3.1
  * @date    14-February-2011
  * @brief   STM8 Touch Sensing Library - This file provides a set of internal
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

/* Includes ------------------------------------------------------------------*/
#include "stm8_tsl_api.h"
#include "stm8_tsl_services.h"

/* Memory section ------------------------------------------------------------*/

#if defined(_COSMIC_) && defined(USE_PRAGMA_SECTION)
#pragma section [TSL_RAM]
#pragma section @tiny [TSL_RAM0]
#pragma section (TSL_CODE)
#pragma section const {TSL_CONST}
#endif

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/

/**
  ******************************************************************************
  * @brief Update pointer to current Key Structure.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
#if NUMBER_OF_SINGLE_CHANNEL_KEYS > 0
void TSL_SetStructPointer(void)
{
  pKeyStruct = &sSCKeyInfo[KeyIndex];
}


/**
  ******************************************************************************
  * @brief Delta calculation for the current Key structure.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_DeltaCalculation(void)
{
  /*
    Note that the delta calculation depends of the technology used:
    - With the RC technology, the measured value for a "touch" is higher than 
      the reference value.
    - With the Charge Transfer technology, the measured value for a "touch"
      is lower than the reference value.
  */
#ifdef CHARGE_TRANSFER
  /* Delta calculation for Charge transfer technology */
  Delta = (s16)(pKeyStruct->Channel.Reference - pKeyStruct->Channel.LastMeas);
#else
  /* Delta calculation for RC technology */
  Delta = (s16)(pKeyStruct->Channel.LastMeas - pKeyStruct->Channel.Reference);
#endif
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go to the IDLE state.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_SetIdleState(void)
{
  pKeyStruct->Setting.b.CHANGED = 1;
  TSL_SCKey_BackToIdleState();
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to return to the IDLE state and reset appropriate flags.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_BackToIdleState(void)
{
  pKeyStruct->State.whole = IDLE_STATE;
  pKeyStruct->Setting.b.DETECTED = 0;
  pKeyStruct->Setting.b.LOCKED = 0;
  pKeyStruct->Setting.b.ERROR = 0;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go to the PRE_DETECTED state and init integrator counter.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_SetPreDetectState(void)
{
  pKeyStruct->State.whole = PRE_DETECTED_STATE;
  pKeyStruct->Channel.IntegratorCounter = DetectionIntegrator;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go to the DETECTED state and init detection timeout + flags.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_SetDetectedState(void)
{
  pKeyStruct->State.whole = DETECTED_STATE;
  pKeyStruct->Setting.b.DETECTED = 1;
  pKeyStruct->Setting.b.CHANGED = 1;
  pKeyStruct->Counter = DetectionTimeout;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go to the POST_DETECTED state and init end integrator counter.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_SetPostDetectState(void)
{
  pKeyStruct->State.whole = POST_DETECTED_STATE;
  pKeyStruct->Channel.IntegratorCounter = EndDetectionIntegrator;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go back to the DETECTED state
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_BackToDetectedState(void)
{
  pKeyStruct->State.whole = DETECTED_STATE;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go to the PRE_CALIBRATION state and init integrator counter.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_SetPreRecalibrationState(void)
{
  pKeyStruct->State.whole = PRE_CALIBRATION_STATE;
  pKeyStruct->Channel.IntegratorCounter = RecalibrationIntegrator;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go to the CALIBRATION state and init appropriate flags.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_SetCalibrationState(void)
{
  pKeyStruct->State.whole = CALIBRATION_STATE;
  pKeyStruct->Setting.b.DETECTED = 0;
  pKeyStruct->Setting.b.CHANGED = 1;
  pKeyStruct->Setting.b.LOCKED = 0;
  pKeyStruct->Setting.b.ERROR = 0;
  pKeyStruct->Counter = SCKEY_CALIBRATION_COUNT_DEFAULT;
  pKeyStruct->Channel.Reference = 0;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go to the ERROR state and init appropriate flags.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_SetErrorState(void)
{
  pKeyStruct->State.whole = ERROR_STATE;
  pKeyStruct->Setting.b.DETECTED = 0;
  pKeyStruct->Setting.b.CHANGED = 1;
  pKeyStruct->Setting.b.LOCKED = 0;
  pKeyStruct->Setting.b.ERROR = 1;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup SCKey internal state machine.
  * Used to go to the DISABLE state and init appropriate flags.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_SetDisabledState(void)
{
  pKeyStruct->State.whole = DISABLED_STATE;
  pKeyStruct->Setting.b.DETECTED = 0;
  pKeyStruct->Setting.b.CHANGED = 1;
  pKeyStruct->Setting.b.LOCKED = 0;
  pKeyStruct->Setting.b.ERROR = 0;
}
#endif

/**
  ******************************************************************************
  * @brief Considers all Key information to apply the Environmental Change System (ECS).
  * Uses an IIR Filter with order 1:
  * Y(n) = K x X(n) + (1-K) x Y(n-1)
  * Y is the reference and X is the acquisition value.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_ECS(void)
{

  u8 K_Filter, K_Filter_Complement;
  s8 ECS_Fast_Direction, ECS_Fast_Enable;
  u32 IIR_Result;

  disableInterrupts();
  Local_TickECS10ms = TSL_TickCount_ECS_10ms;
  TSL_TickCount_ECS_10ms = 0;
  enableInterrupts();

  while (Local_TickECS10ms--)
  {
    ECSTimeStepCounter--;
    ECSTempoPrescaler--;
    if (!ECSTempoPrescaler)
    {
      ECSTempoPrescaler = 10;
      if (ECSTempoCounter)
        ECSTempoCounter--;
    }

    K_Filter = ECS_K_Slow;   // Default case !
    ECS_Fast_Enable = 1;
    ECS_Fast_Direction = 0;
#if NUMBER_OF_SINGLE_CHANNEL_KEYS > 0
    for (KeyIndex = 0; KeyIndex < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyIndex++)
    {
      TSL_SetStructPointer();
      // If any key is in DETECT state, ECS is disabled !
      if ((pKeyStruct->State.whole == PRE_DETECTED_STATE) || (pKeyStruct->State.whole == DETECTED_STATE) || (pKeyStruct->State.whole == POST_DETECTED_STATE))
      {
        ECSTempoCounter = ECSTemporization;    // Restart temporization counter ...
        break;           // Out from the for loop
      }
      if (pKeyStruct->State.whole == IDLE_STATE)
      {
        TSL_DeltaCalculation();
        if (Delta == 0)    // No Fast ECS !
          ECS_Fast_Enable = 0;
        else
        {
          if (Delta < 0)
          {
            if (ECS_Fast_Direction > 0)    // No Fast ECS !
              ECS_Fast_Enable = 0;
            else
              ECS_Fast_Direction = -1;
          }
          else
          {
            if (ECS_Fast_Direction < 0)    // No Fast ECS !
              ECS_Fast_Enable = 0;
            else
              ECS_Fast_Direction = + 1;
          }
        }
      }
    }
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
    for (KeyIndex = 0; KeyIndex < NUMBER_OF_MULTI_CHANNEL_KEYS; KeyIndex++)
    {
      TSL_MCKey_SetStructPointer();
      if ((pMCKeyStruct->State.whole == PRE_DETECTED_STATE) || (pMCKeyStruct->State.whole == DETECTED_STATE) || (pMCKeyStruct->State.whole == POST_DETECTED_STATE))
      {
        ECSTempoCounter = ECSTemporization;    // Restart temporization counter ...
        break;           // Out from the for loop
      }
      if (pMCKeyStruct->State.whole == IDLE_STATE)
      {
        for (ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++)
        {
          TSL_MCKey_DeltaCalculation(ChannelIndex);
          Delta1 += Delta;
        }
        if (Delta1 == 0)
        {   // No Fast ECS !
          ECS_Fast_Enable = 0;
        }
        else
        {
          if (Delta1 < 0)
          {
            if (ECS_Fast_Direction > 0)
            {   // No Fast ECS !
              ECS_Fast_Enable = 0;
            }
            else
              ECS_Fast_Direction = -1;
          }
          else
          {
            if (ECS_Fast_Direction < 0)
            {   // No Fast ECS !
              ECS_Fast_Enable = 0;
            }
            else
              ECS_Fast_Direction = + 1;
          }
        }
      }
    }
#endif

    if (!ECSTimeStepCounter && !ECSTempoCounter)
    {
      ECSTimeStepCounter = ECSTimeStep;

      if (ECS_Fast_Enable)
      {
        K_Filter = ECS_K_Fast;
      }

      K_Filter_Complement = (u8)((0xFF ^ K_Filter) + 1);

      if (K_Filter)
      {
#if NUMBER_OF_SINGLE_CHANNEL_KEYS > 0
        // Apply filter to generate new reference value.
        for (KeyIndex = 0; KeyIndex < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyIndex++)
        {
          TSL_SetStructPointer();
          if (pKeyStruct->State.whole == IDLE_STATE)
          {
            IIR_Result = ((u32)(pKeyStruct->Channel.Reference) << 8) + pKeyStruct->Channel.ECSRefRest;
            IIR_Result = K_Filter_Complement * IIR_Result;
            IIR_Result += K_Filter * ((u32)(pKeyStruct->Channel.LastMeas) << 8);
            pKeyStruct->Channel.Reference = (u16)(IIR_Result >> 16);
            pKeyStruct->Channel.ECSRefRest = (u8)(IIR_Result >> 8);
          }
        }
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
        for (KeyIndex = 0; KeyIndex < NUMBER_OF_MULTI_CHANNEL_KEYS; KeyIndex++)
        {
          TSL_MCKey_SetStructPointer();
          if (pMCKeyStruct->State.whole == IDLE_STATE)
          {
            for (ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY; ChannelIndex++)
            {
              IIR_Result = ((u32)(pMCKeyStruct->Channel[ChannelIndex].Reference) << 8) + pMCKeyStruct->Channel[ChannelIndex].ECSRefRest;
              IIR_Result = K_Filter_Complement * IIR_Result;
              IIR_Result += K_Filter * ((u32)(pMCKeyStruct->Channel[ChannelIndex].LastMeas) << 8);
              pMCKeyStruct->Channel[ChannelIndex].Reference = (u16)(IIR_Result >> 16);
              pMCKeyStruct->Channel[ChannelIndex].ECSRefRest = (u8)(IIR_Result >> 8);
            }
          }
        }
#endif
      }
    }
  }
}

#if NUMBER_OF_SINGLE_CHANNEL_KEYS > 0

/**
  ******************************************************************************
  * @brief Apply Detection exclusion System algorithm (DxS).
  * This function modify the LOCKED bit of current Key structure only.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_DxS(void)
{
  u8 DxSGroupMask, KeyToCheck;

  if (pKeyStruct->Setting.b.LOCKED)
    return;

  DxSGroupMask = pKeyStruct->DxSGroup;

  for (KeyToCheck = 0; KeyToCheck < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyToCheck++)
  {
    if (KeyToCheck != KeyIndex)
    {
      // KeyToCheck and current key are in same group ?
      if (sSCKeyInfo[KeyToCheck].DxSGroup & DxSGroupMask)
      {
        if (sSCKeyInfo[KeyToCheck].Setting.b.LOCKED)
        {
          goto ExitToIdle;
        }
      }
    }
  }

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
  for (KeyToCheck = 0; KeyToCheck < NUMBER_OF_MULTI_CHANNEL_KEYS; KeyToCheck++)
  {
    // KeyToCheck and current key are in same group ?
    if (sMCKeyInfo[KeyToCheck].DxSGroup & DxSGroupMask)
    {
      if (sMCKeyInfo[KeyToCheck].Setting.b.LOCKED)
      {
        goto ExitToIdle;
      }
    }
  }
#endif

  pKeyStruct->Setting.b.LOCKED = 1;
  return;

ExitToIdle:   // The DxS is verified at PRE DETECT state only !
  pKeyStruct->Channel.IntegratorCounter++;  // Increment integrator to never allow DETECT state
  return;
}


/**
  ******************************************************************************
  * @brief Verify Detection Timeout for current Key.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_SCKey_DetectionTimeout(void)
{
  if (Local_TickFlag.b.DTO_1sec)
  {
    if (DetectionTimeout)
    {
      pKeyStruct->Counter--;
      if (!pKeyStruct->Counter)
      {
        TSL_SCKey_SetCalibrationState();
      }
    }
  }
}
#endif
//============================================================================
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//-----             MULTI CHANNEL KEY SERVICES                           -----
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//============================================================================

//============================================================================
//-----         CONDITIONAL COMPILING FOR MCKEYS !!!               -----------
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
//============================================================================

//--------    SECTION DEFINITION FOR THIS FILE   --------------
#if defined(_COSMIC_) && defined(USE_PRAGMA_SECTION)
#pragma section [TSLMCK_RAM]
#pragma section @tiny [TSLMCK_RAM0]
#pragma section (TSLMCK_CODE)
#pragma section const {TSLMCK_CONST}
#endif

/* Coefficient table used to adjust the Delta on MCKey1 */
__CONST u16 MCKEY1_DELTA_COEFF[CHANNEL_PER_MCKEY] =
  {
#ifdef MCKEY1_DELTA_COEFF_A
    MCKEY1_DELTA_COEFF_A,
#else
    0x0100,
#endif
#ifdef MCKEY1_DELTA_COEFF_B
    MCKEY1_DELTA_COEFF_B,
#else
    0x0100,
#endif
#ifdef MCKEY1_DELTA_COEFF_C
    MCKEY1_DELTA_COEFF_C,
#else
    0x0100,
#endif
#if CHANNEL_PER_MCKEY > 3
#ifdef MCKEY1_DELTA_COEFF_D
    MCKEY1_DELTA_COEFF_D,
#else
    0x0100,
#endif
#ifdef MCKEY1_DELTA_COEFF_E
    MCKEY1_DELTA_COEFF_E,
#else
    0x0100,
#endif
#endif
#if CHANNEL_PER_MCKEY > 5
#ifdef MCKEY1_DELTA_COEFF_F
    MCKEY1_DELTA_COEFF_F,
#else
    0x0100,
#endif
#ifdef MCKEY1_DELTA_COEFF_G
    MCKEY1_DELTA_COEFF_G,
#else
    0x0100,
#endif
#ifdef MCKEY1_DELTA_COEFF_H
    MCKEY1_DELTA_COEFF_H
#else
    0x0100
#endif
#endif
  };

#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
__CONST u16 MCKEY2_DELTA_COEFF[CHANNEL_PER_MCKEY] =
  {
#ifdef MCKEY2_DELTA_COEFF_A
    MCKEY2_DELTA_COEFF_A,
#else
    0x0100,
#endif
#ifdef MCKEY2_DELTA_COEFF_B
    MCKEY2_DELTA_COEFF_B,
#else
    0x0100,
#endif
#ifdef MCKEY2_DELTA_COEFF_C
    MCKEY2_DELTA_COEFF_C,
#else
    0x0100,
#endif
#if CHANNEL_PER_MCKEY > 3
#ifdef MCKEY2_DELTA_COEFF_D
    MCKEY2_DELTA_COEFF_D,
#else
    0x0100,
#endif
#ifdef MCKEY2_DELTA_COEFF_E
    MCKEY2_DELTA_COEFF_E,
#else
    0x0100,
#endif
#endif
#if CHANNEL_PER_MCKEY > 5
#ifdef MCKEY2_DELTA_COEFF_F
    MCKEY2_DELTA_COEFF_F,
#else
    0x0100,
#endif
#ifdef MCKEY2_DELTA_COEFF_G
    MCKEY2_DELTA_COEFF_G,
#else
    0x0100,
#endif
#ifdef MCKEY2_DELTA_COEFF_H
    MCKEY2_DELTA_COEFF_H
#else
    0x0100
#endif
#endif
  };

#endif

/**
  ******************************************************************************
  * @brief Initialize the mask relative to MCKey for the channel in parameters
  * @par Parameters:
  * channel is the channel to be acquired (CH1, CH2, CH3 or CH4)
  * @retval u8 Mask
 * return the mask value relative to all MCKeys using the channel in parameter
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
u8 TSL_MCKey_InitAcq(u8 channel)
{
  u8 mask = 0;
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 0
  for (KeyIndex = 0; KeyIndex < NUMBER_OF_MULTI_CHANNEL_KEYS;KeyIndex++)
  {
    if ((sMCKeyInfo[KeyIndex].State.whole & (DISABLED_STATE | ERROR_STATE)) == 0)
    {
      for (ChannelIndex = 0; ChannelIndex < CHANNEL_PER_MCKEY * NUMBER_OF_MULTI_CHANNEL_KEYS; ChannelIndex++)
      {
        if (Table_MCKEY_PORTS[ChannelIndex] == channel)
        {
          mask |= Table_MCKEY_BITS[ChannelIndex];
        }
      }
    }
  }
#endif
  return (mask);
}

/**
  ******************************************************************************
  * @brief Update pointer to current MCKey Structure.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetStructPointer(void)
{
  pMCKeyStruct = &sMCKeyInfo[KeyIndex];
}


/**
  ******************************************************************************
  * @brief Calculates Delta for a channel of the current MCKey.
  * @param[in] ChIdx Channel index (0 = MCKEY1, 1 = MCKEY2)
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_DeltaCalculation(u8 ChIdx)
{
  /*
    Note that the delta calculation depends of the technology used:
    - With the RC technology, the measured value for a "touch" is higher than 
      the reference value.
    - With the Charge Transfer technology, the measured value for a "touch"
      is lower than the reference value.
  */
#ifdef CHARGE_TRANSFER
  /* Delta calculation for Charge transfer technology */
  Delta = (s16)(pMCKeyStruct->Channel[ChIdx].Reference - pMCKeyStruct->Channel[ChIdx].LastMeas);
#else
  /* Delta calculation for RC technology */
  Delta = (s16)(pMCKeyStruct->Channel[ChIdx].LastMeas - pMCKeyStruct->Channel[ChIdx].Reference);
#endif
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetIdleState(void)
{
  pMCKeyStruct->Setting.b.CHANGED = 1;
  TSL_MCKey_BackToIdleState();
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_BackToIdleState(void)
{
  pMCKeyStruct->State.whole = IDLE_STATE;
  pMCKeyStruct->Setting.b.DETECTED = 0;
  pMCKeyStruct->Setting.b.LOCKED = 0;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetPreDetectState(void)
{
  pMCKeyStruct->State.whole = PRE_DETECTED_STATE;
  pMCKeyStruct->Channel[0].IntegratorCounter = DetectionIntegrator;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetDetectedState(void)
{
  pMCKeyStruct->State.whole = DETECTED_STATE;
  pMCKeyStruct->Setting.b.DETECTED = 1;
  pMCKeyStruct->Setting.b.CHANGED = 1;
  pMCKeyStruct->Counter = DetectionTimeout;
  pMCKeyStruct->Channel[1].IntegratorCounter = pMCKeyStruct->DirectionChangeIntegrator;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetPostDetectState(void)
{
  pMCKeyStruct->State.whole = POST_DETECTED_STATE;
  pMCKeyStruct->Channel[0].IntegratorCounter = EndDetectionIntegrator;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_BackToDetectedState(void)
{
  pMCKeyStruct->State.whole = DETECTED_STATE;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetPreRecalibrationState(void)
{
  pMCKeyStruct->State.whole = PRE_CALIBRATION_STATE;
  pMCKeyStruct->Channel[0].IntegratorCounter = RecalibrationIntegrator;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetCalibrationState(void)
{
  u8 Index;

  pMCKeyStruct->State.whole = CALIBRATION_STATE;
  pMCKeyStruct->Setting.b.DETECTED = 0;
  pMCKeyStruct->Setting.b.CHANGED = 1;
  pMCKeyStruct->Setting.b.LOCKED = 0;
  pMCKeyStruct->Counter = MCKEY_CALIBRATION_COUNT_DEFAULT;
  for (Index = 0; Index < CHANNEL_PER_MCKEY; Index++)
  {
    pMCKeyStruct->Channel[Index].Reference = 0;
  }
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetErrorState(void)
{
  pMCKeyStruct->State.whole = ERROR_STATE;
  pMCKeyStruct->Setting.b.DETECTED = 0;
  pMCKeyStruct->Setting.b.CHANGED = 1;
  pMCKeyStruct->Setting.b.LOCKED = 0;
  pMCKeyStruct->Setting.b.ERROR = 1;
}


/**
  ******************************************************************************
  * @brief Short local routine to setup MCKey internal state machine.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_SetDisabledState(void)
{
  pMCKeyStruct->State.whole = DISABLED_STATE;
  pMCKeyStruct->Setting.b.DETECTED = 0;
  pMCKeyStruct->Setting.b.CHANGED = 1;
  pMCKeyStruct->Setting.b.LOCKED = 0;
}


/**
  ******************************************************************************
  * @brief Apply Detection exclusion System algorithm (DxS) on MCKeys.
  * This function modify the LOCKED bit of current MCKey structure only.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_DxS(void)
{

  u8 DxSGroupMask, KeyToCheck;

  if (pMCKeyStruct->Setting.b.LOCKED)
    return;

  DxSGroupMask = pMCKeyStruct->DxSGroup;
#if NUMBER_OF_SINGLE_CHANNEL_KEYS > 0
  for (KeyToCheck = 0; KeyToCheck < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyToCheck++)
  {
    // KeyToCheck and current key are in same group ?
    if (sSCKeyInfo[KeyToCheck].DxSGroup & DxSGroupMask)
    {
      if (sSCKeyInfo[KeyToCheck].Setting.b.LOCKED)
      {
        goto ExitToIdle;
      }
    }
  }
#endif
#if NUMBER_OF_MULTI_CHANNEL_KEYS > 1
  for (KeyToCheck = 0; KeyToCheck < NUMBER_OF_MULTI_CHANNEL_KEYS; KeyToCheck++)
  {
    if (KeyToCheck != KeyIndex)
    {
      // KeyToCheck and current key are in same group ?
      if (sMCKeyInfo[KeyToCheck].DxSGroup & DxSGroupMask)
      {
        if (sMCKeyInfo[KeyToCheck].Setting.b.LOCKED)
        {
          goto ExitToIdle;
        }
      }
    }
  }
#endif

  pMCKeyStruct->Setting.b.LOCKED = 1;
  return;

ExitToIdle:   // The DxS is verified at PRE DETECT state only !
  pMCKeyStruct->Channel[0].IntegratorCounter++;  // Increment integrator to never allow DETECT state
  return;
}


/**
  ******************************************************************************
  * @brief Verify Detection Timeout for current MCKey.
  * @par Parameters:
  * None
  * @retval void None
  * @par Required preconditions:
  * None
  ******************************************************************************
  */
void TSL_MCKey_DetectionTimeout(void)
{
  if (Local_TickFlag.b.DTO_1sec)
  {
    if (DetectionTimeout)
    {
      pMCKeyStruct->Counter--;
      if (!pMCKeyStruct->Counter)
      {
        TSL_MCKey_SetCalibrationState();
      }
    }
  }
}

//============================================================================
//-----         CONDITIONAL COMPILING FOR MCKEYS !!!               -----------
#endif
//============================================================================

/* Public functions ----------------------------------------------------------*/

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/
