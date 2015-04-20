#include "modbus.h"


//Method to send strings via UART
void UART_SendStr(const char *s)
{
	//Set Max485 in Transmitter mode
	GPIO_WriteHigh(GPIOA, GPIO_PIN_3);
	while(*s)
	{
	UART2_SendData8((uint8_t)(*s));
	while ((UART2->SR & UART2_SR_TXE ) != UART2_SR_TXE );
	s++;
	}
	//Set Max485 in Receiver mode
	GPIO_WriteLow(GPIOA, GPIO_PIN_3);
}

//Modbus Initialization
void Modbus_Init(void)
{
//Clock divider equals 1.Clock 16MHz
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
//Clear bits 
	TIM2_DeInit();
	GPIO_DeInit(GPIOA);
	UART2_DeInit();
//Peripetial Initialization
	TIM2_TimeBaseInit(TIM2_PRESCALER_2048, 78);
	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST);
	UART2_Init(BAUDRATE, UART2_WORDLENGTH_8D, UART2_STOPBITS_2,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,UART2_MODE_TXRX_ENABLE );  
//Enable Periphs
	TIM2_Cmd(ENABLE);
	UART2_Cmd(ENABLE);
//Interrupt configuration
	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
	UART2_ITConfig(UART2_IT_RXNE_OR, ENABLE);
#ifndef __DELAY_EN
	#define __MODBUS_EN
	enableInterrupts();
#endif
}

//Delay function Initialization
void Delay_Init(void)
{
//Clear bits 
	TIM3_DeInit();
//Peripetial Initialization
	TIM3_TimeBaseInit(TIM3_PRESCALER_16, 999);
//Enable Periphs
	TIM3_Cmd(ENABLE);
//Interrupt configuration
	TIM3_ITConfig(TIM3_IT_UPDATE, ENABLE);
#ifndef __MODBUS_EN
	#define __DELAY_EN
	enableInterrupts();
#endif
}

//Delay Function
void Delay(uint32_t time)
{
	TimmingDelay = time;
	while(TimmingDelay != 0 );
}

//Byte to HexString. ASCII coding
void ByteToHex(char *hexstring, uint8_t byte)
{
	char fhex;
	char lhex;
	uint8_t fchar = (byte & 0b11110000) >> 4 ;
	uint8_t lchar = (byte & 0b00001111) ; 
	
	if( fchar >= 0 && fchar <= 9 )
	{
		fhex = (char)(fchar+48);
	}
	else
	{
		fhex = (char)(fchar+55);
	}
		if( lchar >= 0 && lchar <= 9 )
	{
		lhex = (char)(lchar+48);
	}
		else
	{
		lhex = (char)(lchar+55);
	}
	hexstring[0] = fhex;
	hexstring[1] = lhex;
}
//HexString to Byte.ASCII decoding
void HexToByte(char *hexstring, uint8_t *byte)
{
	char fhex;
	char lhex;
	uint16_t tmpb;
	uint8_t fchar;
	uint8_t lchar;
	fhex	= hexstring[0];
	lhex = hexstring[1];
	if( ((int)fhex) >= 48 && ((int)fhex) <= 57 )
	{
		fchar = ((int)fhex) - 48; 
	}
	else
	{
		fchar = ((int)fhex) - 55;
	}
		if( ((int)lhex) >= 48 && ((int)lhex) <= 57 )
	{
		lchar = ((int)lhex) - 48; 
	}
	else
	{
		lchar = ((int)lhex) - 55;
	}
	tmpb = ((fchar<<4) | lchar);
	*byte =  (uint8_t)tmpb; 
	
}

//Function to make sure that your address is correct
uint8_t __checkAddr(uint8_t address)
{
	if(address >= 0 && address <= 255)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

//Set Device Address
void SetDevAddr(uint8_t Addr)
{
	if(__checkAddr(Addr))
	{
	Address = Addr;
	}
}

void RewritingChars(char *destination, uint8_t from, uint8_t to)
{
for(from; from<=to; ++from)
	{
	destination[from] = word[from];	
	}	
	
}

//* This function sets indicated coil ON or OFF. 
//* Registers: Output_registers, Input_Registers.
void SetSingleCoil(uint16_t *Coil, uint16_t *StatusToWrite, uint16_t *registers)
{ 
 
//* Set ON
if(*StatusToWrite == 0xFF00)
	{
		registers[*Coil/16 ] |= (1<<(*Coil%16));		
	}

//* Set OFF
else if(*StatusToWrite == 0x0000)
	{
		registers[*Coil/16 ] &= (!(1<<(*Coil%16)));
	}
else
	{
		ErrorMessage(ILLEGAL_DATA_VAL);
	}
}

//* Returns the value of single bit(coil).
bool StateOfCoil(uint8_t NumberOfCoil, uint16_t registers[])
{
//* Gets the value of current byte.
	uint16_t Value = registers[NumberOfCoil/16];   
	
//* Calculates the comparing value to find if coil is 1 or 0.
	uint16_t Compare = 1<<(NumberOfCoil%16);			
	
	if ((Value & Compare) == Compare )
		{
				return 1;
		}
		
	else
		{
				return 0;
		} 
}


//* If LRC in frame[] is correct returns 1, else 0. 
bool CheckLRC(char *frame)
{
	uint8_t a = 0;
	uint8_t Sum;
	char tempByte[2];
	uint8_t tempSum = 0;
	char temp[4];
	uint8_t LRC_calculated = 0;

	uint8_t LRC_dec_from_frame = 0;	
	
//* counts chars  in frame
	while(word[a] != '\r')
			{
				a++;
			}

temp[1] = frame[a-1];
temp[0] = frame[a-2];

HexToByte(temp,&LRC_dec_from_frame);

frame[a-1] = '\0';
frame[a-2] = '\0';

//* calculates LRC
LRC_calculated = GetLRC(frame);

if (LRC_calculated == LRC_dec_from_frame)
{
	return 1;
}
else
{
	return 0;
}
}

uint8_t GetLRC(char *frame)
{
uint8_t LRCsum = 0;
char temp[2];
uint8_t TempSum;
frame++;

while(*frame)
{
temp[0] = *frame++;
temp[1] = *frame++;
HexToByte(temp, &TempSum);
LRCsum += TempSum;
}
LRCsum = (~(LRCsum)+1);
return LRCsum;
}

//* This function changes hex char[4] to uint16_t.
void HexToByte_4(char *hexstring_4, uint16_t *byte)
{
char tempp[2];
uint8_t right_dec = 0;
uint8_t left_dec = 0;
uint16_t right_dec16 = 0;
uint16_t left_dec16 = 0;

tempp[0] = hexstring_4[0];
tempp[1] = hexstring_4[1];
HexToByte(tempp,&left_dec);

tempp[0] = hexstring_4[2];
tempp[1] = hexstring_4[3];
HexToByte(tempp,&right_dec);

left_dec16 = left_dec16 | left_dec;
right_dec16 = right_dec16 | right_dec;

*byte = (left_dec16 << 8) | right_dec16;
}


//* This function changes uint16_t to hex char[4].
void ByteToHex_4(char *hexstring, uint16_t byte)
{
	char temp1[2];
	char temp2[2];
	uint16_t D1 = byte >> 8;
  uint16_t D2 = byte & 255;
	uint8_t D1_8 = 0;
	uint8_t D2_8 = 0;
	uint8_t ct = 0;
	
	D1_8 |= D1;
	D2_8 |= D2;
	
	ByteToHex(temp1, D1_8);
	ByteToHex(temp2, D2_8);
	
	hexstring[0] = temp1[0];
	hexstring[1] = temp1[1];
	hexstring[2] = temp2[0];
	hexstring[3] = temp2[1];
		
}
//* ###########################################
//* ###########################################
//*																				 ####
//* @Implementations of funcs below.			 ####
//*																				 ####
//* ###########################################
//* ###########################################

//* FC01 This command requests the ON/OFF status of discrete output coils.
void ReadCoilStatus(uint16_t *registers)
{
char OutputFrame[OFS];  
uint8_t counter = 0;
uint8_t TempSum=0;
uint16_t FirstCoil;
uint16_t NumberOfCoils;
uint16_t Coil;
uint8_t NumberOfDataBytes;
char temp[2];
char temp4[4];
uint16_t n = 0;

//Clears table
for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}

// rewrites slave's address & number of function
RewritingChars(OutputFrame,0,4);
	
//gets number of first coil
temp4[0] = word[5];
temp4[1] = word[6];
temp4[2] = word[7];
temp4[3] = word[8];
HexToByte_4(temp4, &FirstCoil);

//gets quantity of coils
temp4[0] = word[9];
temp4[1] = word[10];
temp4[2] = word[11];
temp4[3] = word[12];
HexToByte_4(temp4, &NumberOfCoils);
if(Check_DataAddr_F01_F02(FirstCoil, NumberOfCoils) & Check_DataVal())
{
	// calculates the number of data bytes
	if((NumberOfCoils%8)!=0)
	{
		NumberOfDataBytes = ( NumberOfCoils/8)+1;
	}
	else
	{
		NumberOfDataBytes = NumberOfCoils/8;
	}

	//Writes the number of data bytes
	ByteToHex(temp,NumberOfDataBytes);
	OutputFrame[5] = temp[0];
	OutputFrame[6] = temp[1];

	// calculates data bits to HEX and writing to frame
	counter = 7; 
	Coil = FirstCoil;
	n = NumberOfCoils;
	while(n>0)
	{
					if(n>=8)                   //    changes 8bits to hex
					{
						uint8_t pwr = 0;
						for(pwr =0; pwr<8; pwr++,Coil++)
						{
							TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^0
							n--;
						}			
						
						ByteToHex(temp,TempSum);
						TempSum = 0;
						OutputFrame[counter] = temp[0];
						counter++;
						OutputFrame[counter] = temp[1];
						counter++;
					}
				
					else                                       //        changing incomplete octet to hex
					{
							uint8_t pwr = 0;
							uint8_t zm = n;
							for(pwr =0; pwr<zm; pwr++,Coil++)
							{
									TempSum += (1<<pwr)*StateOfCoil(Coil, registers);   ///////      (9 dec)  1001  =>  1*2^3 + 0*2^2 + 0*2^1 + 1*2^(
									n--;
							}
							ByteToHex(temp,TempSum);
							TempSum = 0;
							OutputFrame[counter] = temp[0];
							counter++;
							OutputFrame[counter] = temp[1];
							counter++;
					}
	}

	// writes LRC 
	ByteToHex(temp,GetLRC(OutputFrame));
	OutputFrame[counter] = temp[0];
	counter++;
	OutputFrame[counter] = temp[1];
	counter++;
	OutputFrame[counter] = 0x0D;
	counter++;
	OutputFrame[counter] = 0x0A;
	counter++;
	OutputFrame[counter] = 0x0A;
	counter++;

		// sends frame
		UART_SendStr(OutputFrame); 
}
}


//* FC02 This command requests the ON/OFF status of discrete inputs///
void ReadInputStatus(void)
{
ReadCoilStatus(Input_Registers);
}

///FC03  *This command is requests the content of analog output holding registers///
/// 			*registers => output or input
void ReadHoldingRegisters(uint16_t *registers)
{
char OutputFrame[OFS];    
char temp[4];
char temp2[2];

uint16_t FirstReg = 0;
uint16_t NumberOfRegs = 0;
uint8_t NumberOfBytes = 0 ;
uint8_t ct = 0;
uint8_t k = 0;
uint8_t counter = 0;
uint16_t Content_dec = 0;


//Clears table
for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}

// rewrites slave's address & number of function
RewritingChars(OutputFrame,0,4);

//gets number of first register
temp[0] = word[5];
temp[1] = word[6];
temp[2] = word[7];
temp[3] = word[8];
HexToByte_4(temp, &FirstReg);

//gets quantity of registers
temp[0] = word[9];
temp[1] = word[10];
temp[2] = word[11];
temp[3] = word[12];
HexToByte_4(temp, &NumberOfRegs);
if(Check_DataAddr_F03_F04(FirstReg, NumberOfRegs) & Check_DataVal())
{
	// calculates the number of data bytes to follow ( n registers * 2 bytes each)
	NumberOfBytes = NumberOfRegs*2;

	//Writes the number of data bytes
	ByteToHex(temp,NumberOfBytes);
	OutputFrame[5] = temp[0];
	OutputFrame[6] = temp[1];

	counter = 7;
	k = FirstReg;


	//Reads the contents from Output_Registers
	for(ct=0;ct<NumberOfRegs;ct++)
	{
		Content_dec = registers[k];
		ByteToHex_4(temp,Content_dec);
		OutputFrame[counter] = temp[0];
		counter++;
		OutputFrame[counter] = temp[1];
		counter++;
		OutputFrame[counter] = temp[2];
		counter++;
		OutputFrame[counter] = temp[3];
		counter++;
		k++;
	}
	
	
	// LRC
	ByteToHex(temp2,GetLRC(OutputFrame));
	OutputFrame[counter] = temp2[0];
	counter++;
	OutputFrame[counter] = temp2[1];
	counter++;
	OutputFrame[counter] = 0x0D;
	counter++;
	OutputFrame[counter] = 0x0A;
	counter++;
	OutputFrame[counter] = 0x0A;
	counter++;


	//sends frame 
	UART_SendStr(OutputFrame); 
}
}

///FC04 *This command is requests the content of analog input register///
void ReadInputRegisters(void)
{
	// FC03 used  because only difference is input or output
ReadHoldingRegisters(Input_Registers);
}


///FC05 *This command writes the contents of discrete coil ///
void ForceSingleCoil(void)
{
char OutputFrame[OFS];   // output frame
char temp4[4];
char temp2[2];

uint16_t Coil = 0;
uint16_t StatusToWrite = 0;
uint8_t k = 0;

//Clears table
for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}

// rewrites slave's address & number of function
RewritingChars(OutputFrame,0,12);


//* Gets data addres of the coil.
temp4[0] = word[5];
temp4[1] = word[6];
temp4[2] = word[7];
temp4[3] = word[8];
HexToByte_4(temp4, &Coil);
if(Check_DataAddr_F05(Coil))
{
	//* The status to write( FF00 = ON,  0000 = OFF ).
	temp4[0] = word[9];
	temp4[1] = word[10];
	temp4[2] = word[11];
	temp4[3] = word[12];
	HexToByte_4(temp4, &StatusToWrite);

	//* Sets the status.
	SetSingleCoil( &Coil,  &StatusToWrite, Output_Registers);

	//* Writes LRC.
	k = 13;
	ByteToHex(temp2,GetLRC(OutputFrame));
	OutputFrame[k] = temp2[0];
	k++;
	OutputFrame[k] = temp2[1];
	k++;
	OutputFrame[k] = 0x0D;
	k++;
	OutputFrame[k] = 0x0A;
	k++;
	OutputFrame[k] = 0x0A;
	k++;

	//sending frame 
	UART_SendStr(OutputFrame); 
}
}


//* FC06 This command writes the contents of analog output holding register.
void PresetSingleRegister(void)
{
char OutputFrame[OFS];   
char temp4[4];
char temp2[2];

uint16_t Register = 0;
uint16_t ValueToWrite = 0;
uint8_t k = 0;

//Clears table
for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}

// rewrites slave's address & number of function
RewritingChars(OutputFrame,0,12);


//* Gets data addres of the register.
temp4[0] = word[5];
temp4[1] = word[6];
temp4[2] = word[7];
temp4[3] = word[8];
HexToByte_4(temp4, &Register);
if(Check_DataAddr_F06(Register) & Check_DataVal())
{
	//* The value to write( FF00 = ON,  0000 = OFF ).
	temp4[0] = word[9];
	temp4[1] = word[10];
	temp4[2] = word[11];
	temp4[3] = word[12];
	HexToByte_4(temp4, &ValueToWrite);

	//* Sets the value.
	Output_Registers[Register] = ValueToWrite;

	//* Writes LRC.
	k = 13;
	ByteToHex(temp2,GetLRC(OutputFrame));
	OutputFrame[k] = temp2[0];
	k++;
	OutputFrame[k] = temp2[1];
	k++;
	OutputFrame[k] = 0x0D;
	k++;
	OutputFrame[k] = 0x0A;
	k++;
	OutputFrame[k] = 0x0A;
	k++;

	//sends frame 
	UART_SendStr(OutputFrame); 
}
}


//* FC16 This command    writes the contents of  analog output holding registers
void ForceMultipleRegisters()
{
char OutputFrame[OFS];  
uint8_t counter = 0;
uint16_t Value=0;
uint16_t FirstRegister;
uint16_t NumberOfRegs;
uint16_t Coil;
uint8_t NumberOfDataBytes;
char temp[2];
char temp4[4];
uint16_t n = 0;

//Clears table
for(n = 0; n<OFS; n++){OutputFrame[n] = '\0';}

// rewrites slave's address & number of function
RewritingChars(OutputFrame,0,12);
	
//gets number of first coil
temp4[0] = word[5];
temp4[1] = word[6];
temp4[2] = word[7];
temp4[3] = word[8];
HexToByte_4(temp4, &FirstRegister);

//gets number  of coils to written	
temp4[0] = word[9];
temp4[1] = word[10];
temp4[2] = word[11];
temp4[3] = word[12];
HexToByte_4(temp4, &NumberOfRegs);

//gets the number of data bytes to follow
temp[0] = word[13];
temp[1] = word[14];
HexToByte(temp, &NumberOfDataBytes);
if(Check_DataAddr_F03_F04(FirstRegister, NumberOfRegs) & Check_DataVal_F16(NumberOfDataBytes))
{

	counter=15;
	for(n=0; n<(NumberOfDataBytes/2); n++)
	{
		temp4[0] = word[counter];
		counter++;
		temp4[1] = word[counter];
		counter++;
		temp4[2] = word[counter];
		counter++;
		temp4[3] = word[counter];		
		counter++;
	
		HexToByte_4(temp4, &Value);
		Output_Registers[FirstRegister+n] = Value;
	}
	
	//* Writes LRC.
	counter = 13;
	ByteToHex(temp,GetLRC(OutputFrame));
	OutputFrame[counter] = temp[0];
	counter++;
	OutputFrame[counter] = temp[1];
	counter++;
	OutputFrame[counter] = 0x0D;
	counter++;
	OutputFrame[counter] = 0x0A;
	counter++;
	OutputFrame[counter] = 0x0A;
	counter++;

	//sending frame 
	UART_SendStr(OutputFrame); 
}
}
//* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//*																				 @@@@
//* $Function Error Codes 								 @@@@
//*																				 @@@@
//* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

//Illegal value in querry frame
void ErrorMessage(uint8_t ErrorCode)
{
char OutputFrame[OFS];   // output frame
char temp[2];
uint8_t FunC;
uint8_t ErrFuncCode;
uint8_t k;

//Clears table
for(k = 0; k<OFS; k++){OutputFrame[k] = '\0';}

//Rewrite first chars
RewritingChars(OutputFrame,0,2);

//Read Function Code from message
temp[0] = word[3];
temp[1] = word[4];
HexToByte(temp, &FunC);

//Calculate Function Code for Message with Error
ErrFuncCode = FunC + 80;
ByteToHex(temp,ErrFuncCode);
OutputFrame[3] = temp[0];
OutputFrame[4] = temp[1];

//Fill Data field with ILLEGAL FUNCTION CODE
ByteToHex(temp,ErrorCode);
OutputFrame[5] = temp[0];
OutputFrame[6] = temp[1];

//* Writes LRC.
ByteToHex(temp,GetLRC(OutputFrame));
OutputFrame[7] = temp[0];
OutputFrame[8] = temp[1];
OutputFrame[9] = 0x0D;
OutputFrame[10] = 0x0A;
OutputFrame[11] = 0x0A;

//sending frame 
UART_SendStr(OutputFrame); 
}


//Check Data Addresses in Function 1 and 2
uint8_t Check_DataAddr_F01_F02(uint16_t FirstCoil, uint16_t NumOfCoils)
{
	uint32_t MaxCoils;
	uint32_t LastCoil;
	
	//Maximum numbers of bits in 16 bit registers
	MaxCoils = REGSIZE*16;
	//Last Coil Address form query
	LastCoil = FirstCoil + NumOfCoils;
	
	if(LastCoil <= MaxCoils)
	{
		return 1;
	}
	else
	{
	ErrorMessage(ILLEGAL_DATA_ADDR);
	}
}

//Check Data Value in Function 1, 2 ,3 ,4 
uint8_t Check_DataVal()
{
	//Number of bytes in querry 
	if(BYTES == 16)
	{
		return 1;
	}
	else
	{
	ErrorMessage(ILLEGAL_DATA_VAL);	
	}
}

//Check Data Addresses in Function 3, 4 and 16
uint8_t Check_DataAddr_F03_F04(uint16_t FirstReg, uint16_t NumofRegs)
{
	uint32_t LastRegister = FirstReg + NumofRegs;
	if(LastRegister <= REGSIZE)
	{
		return 1;
	}
	else
	{
		ErrorMessage(ILLEGAL_DATA_ADDR);
	}	
}

//Check Address in Function 5
uint8_t Check_DataAddr_F05(uint16_t Coil)
{
	//Maximum numbers of bits in 16 bit registers
	uint16_t MaxCoil = REGSIZE*16;
	if(Coil <= MaxCoil)
	{
		return 1;
	}
	else
	{
		ErrorMessage(ILLEGAL_DATA_ADDR);
	}
	
}

//Check Address in Function 6
uint8_t Check_DataAddr_F06(uint16_t Register)
{
	if(Register <= REGSIZE)
	{
		return 1;
	}
	else
	{
		ErrorMessage(ILLEGAL_DATA_ADDR);
	}
}

//Chaeck Data Value in Function 15
uint8_t Check_DataVal_F16(uint16_t Databytes)
{
	uint16_t BytesInQuerry;
	BytesInQuerry = 18+2*Databytes;
	//Number of bytes in querry 
	if(BYTES == BytesInQuerry)
	{
		return 1;
	}
	else
	{
	ErrorMessage(ILLEGAL_DATA_VAL);	
	}
}


//Function to make sure that your Function code is correct
uint8_t __checkFunc(uint8_t Function_Number)
{
	if(Function_Number == 1 || Function_Number == 2 || Function_Number == 3 || Function_Number == 4 || Function_Number == 5 || Function_Number == 6 || Function_Number == 16)
	{
		return 1;
	}
	else 
	{
		ErrorMessage(ILLEGAL_FUNCTION);
		return 0;
	}
}



