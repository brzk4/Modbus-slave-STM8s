#ifndef __MODBUS_HEADER_H
#define __MODBUS_HEADER_H

/* Includes -----------------------------------------------*/
#include "stm8s.h"

/* Private defines -----------------------------------------------------------*/
#define BAUDRATE 19200
#define TOTAL_REG_SIZE 10
#define OFS 25   					// Output_Frame SIZE
#define REGSIZE 10	//Number of Output and Input registers
#define BufforsSize 45  //Size of Temporary and modbus frame buffor must be the same
/* If you want redefine this value you should 
change this value in _it file too
*/


//Error defines 
#define ILLEGAL_FUNCTION 01
#define ILLEGAL_DATA_ADDR 02
#define ILLEGAL_DATA_VAL 03

//uint16_t Output_Registers[10];



/* Private function prototypes -----------------------------------------------*/
void Delay_Init(void);
void Delay(uint32_t time);
void Modbus_Init(void);
void UART_SendStr(const char *s);
void ByteToHex(char *hexstring, uint8_t byte);
void HexToByte(char *hexstring, uint8_t *byte);
void HexToByte_4(char *hexstring_4, uint16_t *byte);
void SetDevAddr(uint8_t Addr);
bool CheckLRC(char *frame);
uint8_t GetLRC(char *frame);
void ByteToHex_4(char *hexstring, uint16_t byte);

/* Modbus handler function prototypes ------------------------------------------*/
void ReadCoilStatus(uint16_t *registers);
void ReadInputStatus(void);
void ReadHoldingRegisters(uint16_t *registers);
void ReadInputRegisters(void);
void ForceSingleCoil(void);
void PresetSingleRegister(void);
void ForceMultipleRegisters(void);

void RewritingChars(char *destination, uint8_t from, uint8_t to);
bool StateOfCoil(uint8_t NumberOfCoil, uint16_t registers[]);
void SetSingleCoil(uint16_t *Coil, uint16_t *StatusToWrite, uint16_t *registers);

/* Errors and check ------------------------------------------*/

void ErrorMessage(uint8_t ErrorCode);
uint8_t Check_DataAddr_F01_F02(uint16_t FirstCoil, uint16_t NumOfCoils);
uint8_t Check_DataAddr_F03_F04(uint16_t FirstReg, uint16_t NumofRegs);
uint8_t Check_DataAddr_F05(uint16_t Coil);
uint8_t Check_DataAddr_F06(uint16_t Register);
uint8_t Check_DataVal(void);
uint8_t Check_DataVal_F16(uint16_t Databytes);
uint8_t __checkAddr(uint8_t address); 
uint8_t __checkFunc(uint8_t Function_Number); 

/* Private variables -----------------------------------------------------------*/
extern uint32_t TimmingDelay;	
extern uint8_t Address;				//Device Address 
extern uint8_t buffer[BufforsSize];		//temporaty buffer for RX
extern uint8_t word[BufforsSize];			//buffer for modbus frame
extern uint8_t BYTES;					//Number of bytes in message

/*
*****************************************
INPUT and OUTPUT registers for user data
*****************************************
*/

extern uint16_t Input_Registers[REGSIZE];
extern uint16_t Output_Registers[REGSIZE];

/////////////////////////////



#endif