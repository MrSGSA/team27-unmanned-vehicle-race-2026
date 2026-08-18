#ifdef _RASP_MODE_
#include "server_socket.h"
#include "server_control.h"
int main(int argc, char* argv[])
{
    InitSocket();
    CreateControlFunc();
    GetGlobalControlPtr()->Init(GetGlobalControlPtr());
    StartListen();
    return 1;
}
#elif _SERIAL_MODE_
#include "server_serial.h"
#include "server_control.h"
int px4_Sysplorer_app_main(int argc, char* argv[])
{
    InitSerial();
    CreateControlFunc();
    GetGlobalControlPtr()->Init(GetGlobalControlPtr());
    StartListen();

    return 1;
}
#elif _STM32_MODE_
#include "stm32_server_serial.h"
#include "server_control.h"
int main(int argc, char* argv[])
{
    InitSerial();
    CreateControlFunc();
    GetGlobalControlPtr()->Init(GetGlobalControlPtr());
    StartListen();
    return 1;
}
#elif _STM32_TCP_MODE_
#include "./SYSTEM/sys/sys.h"
#include "./SYSTEM/delay/delay.h"
#include "./SYSTEM/usart/usart.h"
#include "./BSP/gpio.h"
#include "./BSP/tim.h"
#include "./BSP/MPU/mpu.h"
#include "./BSP/LCD/lcd.h"
#include "./BSP/ADC/adc.h"
#include "./BSP/DAC/dac.h"
#include "./BSP/SDRAM/sdram.h"
//#include "./BSP/zero_ctr.h"
//#include "./BSP/bldc.h"
#include "queue.h"
#include "comm.h"
//#include "./MALLOC/malloc.h"
#include <stdio.h>
#include "lwip_comm.h"
#include "lwipopts.h"
#include "./BSP/ETHERNET/ethernet_chip.h"
#include "lwip_demo.h"

#include "./Model/server_control.h"
#include "./Model/stm32_server_tcp.h"

int main(void)
{  
	uint8_t t=0;
	uint8_t k=0;
    sys_cache_enable();                 /* 使能L1-Cache */
    HAL_Init();                         /* 初始化HAL库 */
    sys_stm32_clock_init(192, 5, 2, 4); /* 配置时钟，480MHz */
    delay_init(480);                    /* 初始化延时 */
    uart_init();                        /* 初始化串口 */
//	dma_init();
    gpio_init();                        /* 初始化IO */

	adc_dma_init();
	dac_init();
	
	tim_init();		
    mpu_memory_protection();            /* 保护相关存储区域 */
 
	printf("d425\r\n");
/* Test send simulation result and recv cmd by TCP*/
	InitTcp();
	CreateControlFunc();
	GetGlobalControlPtr()->Init(GetGlobalControlPtr());
	
	while(1)
	{
		TcpServerProcess();
			 
		delay_ms(1);
	}
}
#else
int main(int argc, char* argv[])
{
    return -1;
}
#endif
