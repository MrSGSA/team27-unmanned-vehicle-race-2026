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
#include "tim.h"

#define Dbg_Test 0

#if Dbg_Test
#include "./Model/Speed_Close.h"
#endif

#if !Dbg_Test
#include "./Model/server_control.h"
#include "./Model/stm32_server_tcp.h"
#include "./Model/rt_task.h"
#endif

int main(void)
{  
	uint8_t t=0;
	uint8_t k=0;
    sys_cache_enable();                 /* 使能L1-Cache */
    HAL_Init();                         /* 初始化HAL库 */
    sys_stm32_clock_init(192, 5, 2, 4); /* 配置时钟，480MHz */
    //delay_init(480);                    /* 初始化延时 */
    // uart_init();                        /* 初始化串口 */
	dma_init();
    //gpio_init();                        /* 初始化IO */

	adc_dma_init();
	dac_init();
	
#if Dbg_Test
	Init();
#endif
	
	tim_init();		
    mpu_memory_protection();            /* 保护相关存储区域 */

	//printf("d425\r\n");
#if !Dbg_Test
	InitTcp();
	CreateControlFunc();
	GetGlobalControlPtr()->Init(GetGlobalControlPtr());
#endif 
	
	while(1)
	{
#if !Dbg_Test
		// TCP 处理数据
		TcpServerProcess();
#endif
		//delay_ms(1);
	}
}


int flag3 = 0;

int flag2 = 0;



void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
		flag3++;
//		if (htim->Instance == TIM3)
//    {
//        
//   }
	
	if(htim->Instance == TIM17)
	{
		//time += step;
		flag2++;
		//Ualpha11 =  AMPLITUDE * cosf(2 * 3.1415 * FREQUENCY * time);
		//Ubeta11  =  AMPLITUDE * sinf(2 * 3.1415 * FREQUENCY * time);
#if Dbg_Test
		Step();
#else
		//TcpServerProcess();
		RtPeriodicTask();
#endif
		//tim1_set_compare((uint16_t)tcm1 * 300,(uint16_t)tcm2 * 300,(uint16_t) tcm3* 300);
		//tim1_set_compare(50,50,50);
	}
		
}


