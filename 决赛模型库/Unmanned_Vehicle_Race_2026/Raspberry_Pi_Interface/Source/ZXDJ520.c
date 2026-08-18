#include <wiringPi.h>
#include <wiringSerial.h>
#include <softPwm.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <signal.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

#define Zx_Motor_FRAME_HEADER1  0XFA
#define Zx_Motor_FRAME_HEADER2  0XAF
#define Zx_Motor_READ_ANGLE     0X02
#define Zx_Motor_FRAME_END      0XED
#define Zx_Motor_RUNS           0XFD
#define Zx_Motor_RUNN           0XFE
#define uint8     char
#define uint32    unsigned int   
#define GET_LOW_BYTE(A)  ((char)(A))
#define GET_HIGH_BYTE(A) ((char)((A) >> 8))
#define PI acos(-1)
extern double SPEED;
extern int fd;

/**
* @brief  CRC校验
* @param[in] inst  buf[]
*/
char Zx_MotorCheckSum(char buf[])
{
	int i;
	unsigned int sum = 0;
	for (i = 2; i < 8; i++)
	{
		sum += buf[i];
	}
	if (sum > 255)sum &= 0x00FF;
	return sum;
}

/**
* @brief  电机正转
* @param[in] inst  fd:串口标识位
* @param[in] inst  id:电机id号
* @param[in] inst  speed:车速
*/
void Zx_MotorRunS(double id, double speed)
{
	int rpm = speed / (2 * PI * 3.4) * 60;
	int idi = (int)id;
	char  buf[10];
	buf[0] = 0XFA;
	buf[1] = 0XAF;
	buf[2] = idi;
	buf[3] = 0x01;
	buf[4] = 0XFD;
	buf[5] = 0x00;
	buf[6] = (char)((rpm) >> 8);
	buf[7] = (char)(rpm);
	buf[8] = Zx_MotorCheckSum(buf);
	buf[9] = 0XED;
	write(fd, buf, 10);//将指令发送出去
	delayMicroseconds(10000);   // 树莓派等待50ms
}

/**
* @brief  电机反转
* @param[in] inst  fd:串口标识位
* @param[in] inst  id:电机id号
* @param[in] inst  rpm:给定电机转速
*/
void Zx_MotorRunN(double id, double speed)
{
	//int rpm = (fabs(speed) / (2 * PI * 3.4) * 60);
	int rpm = fabs(speed);
	int idi = (int)id;
	char  buf[10];
	buf[0] = 0XFA;
	buf[1] = 0XAF;
	buf[2] = idi;
	buf[3] = 0x01;
	if(speed > 0){
	  buf[4] = 0XFE;
	}else{
	  buf[4] = 0XFD;
	}
	buf[5] = 0x00;
	buf[6] = (char)((rpm) >> 8);
	buf[7] = (char)(rpm);
	buf[8] = Zx_MotorCheckSum(buf);
	buf[9] = 0XED;
	write(fd, buf, 10);//将指令发送出去
	delayMicroseconds(10000);   // 树莓派等待50ms
}

/**
* @brief  运行小车
* @param[in] inst  fd:串口文件描述符
* @param[in] inst  speed:车速
* @param[in] inst  gap:差速
*/
void vehicle_speed(int id,double speed)
{
  
	Zx_MotorRunN(id, speed);   //电机2正转
	//Zx_MotorRunS(id, speed);   //电机1正转
	return;
}