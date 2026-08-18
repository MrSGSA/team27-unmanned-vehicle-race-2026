#include "for_code_JGB520_Team27.h"
/*** Current Block Name: raspberry_SetMsg.c_caller ***/
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

#define Trig1 4     // 传感器 Trig端口
#define Echo1 5    // 正前方传感器 Echo端口
#define Echo2 12    // 正前方舵机传感器 Echo端口
#define Echo3 13    // 右侧方传感器 Echo端口
#define Echo4 14    // 左侧方传感器 Echo端口
#define Echo5 6    // 后方传感器 Echo端口
#define PWM_PIN1 26    // 转向舵机引脚
#define PWM_PIN2 23    // 正前方传感器舵机引脚
#define PWM_PIN3 2    // 后方传感器舵机引脚
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
double distances[5];
double SPEED;
int fd=0;

double geted_msg[5];
double vehicle_speed_seted;
double vehicle_gap_seted;
double steer_cmd_seted;
double front_sensor_cmd_seted;
double rear_sensor_cmd_seted;

int rasInit()
{
	 if(wiringPiSetup() == -1)
	 {   
	 	printf("硬件初始化失败！\n");
	 	return 1;
	 }
  printf("wiringPiSetup ok!\n");
	pinMode(Trig1, OUTPUT);   // 配置端口为输出模式
	pinMode(Echo1, INPUT);   // 配置端口为输入模式
	pinMode(Echo2, INPUT);   // 配置端口为输入模式
	pinMode(Echo3, INPUT);   // 配置端口为输入模式
	pinMode(Echo4, INPUT);   // 配置端口为输入模式
	pinMode(Echo5, INPUT);   // 配置端口为输入模式
	pullUpDnControl(Echo1, PUD_UP); // 对一个设置 IO 模式为 INPUT 的输入引脚设置拉电阻模式
	pullUpDnControl(Echo2, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo3, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo4, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo5, PUD_UP);	// PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pinMode(PWM_PIN1, PWM_OUTPUT);
	pinMode(PWM_PIN2, PWM_OUTPUT);
	pinMode(PWM_PIN3, OUTPUT);
	pwmSetMode(PWM_MODE_MS);
	pwmSetClock(192);
	pwmSetRange(2000);
	softPwmCreate(PWM_PIN3, 0, 200);
	
  printf(" Raspberry Pi Setup ok!\n");
  fd = serialOpen("/dev/ttyAMA0", 115200);
  if(fd == -1)
  {
    printf("open serial failed\n");
    while(1)
    {}
  }
	return 0;
}

/**
* @brief  获取超声波传感器探测的距离
**/
double getDistance(int echoPin)
{
	double dis;
	long start;
	long end;
	struct timeval tv1;
	struct timeval tv2;
 
  int cot = 0;

	digitalWrite(Trig1, LOW);   // 先通入低电平，避免后续误差过大
	delayMicroseconds(2);
	digitalWrite(Trig1, HIGH);
	delayMicroseconds(10);   // 树莓派发送 10us 脉冲信号
	digitalWrite(Trig1, LOW);

  while((digitalRead(echoPin) != HIGH)&&(cot++ < 31000)); // HIGH（1），检测到高电平时跳出循环
	gettimeofday(&tv1, NULL);   // 获取时间（此为高电平开始时间）
  cot = 0;
  while((digitalRead(echoPin) != LOW)&&(cot++ < 36000));   // LOW（0），检测到低电平跳出循环
	gettimeofday(&tv2, NULL);   // 获取时间（此为低电平开始时间，即为高电平结束时间）
  cot = 0;
	start = tv1.tv_sec * 1000000 + tv1.tv_usec;   // 单位（微秒）
	end = tv2.tv_sec * 1000000 + tv2.tv_usec;   // 单位（微秒）
	dis = (double)(end - start) / 1000000 * 34000 / 2;   // 距离计算（高电平时间 * 音速 / 2）

	delayMicroseconds(15000);   // 树莓派等待10ms
  return dis;
}


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
	int rpm = speed / (2 * PI * 3.4) * 60;
	int idi = (int)id;
	char  buf[10];
	buf[0] = 0XFA;
	buf[1] = 0XAF;
	buf[2] = idi;
	buf[3] = 0x01;
	buf[4] = 0XFE;
	buf[5] = 0x00;
	buf[6] = (char)((rpm) >> 8);
	buf[7] = (char)(rpm);
	buf[8] = Zx_MotorCheckSum(buf);
	buf[9] = 0XED;
	write(fd, buf, 10);//将指令发送出去
	delayMicroseconds(10000);   // 树莓派等待50ms
}

/**
* @brief  获取电机转速
* @param[in] inst  fd:串口文件描述符
* @param[in] inst  id:电机ID号
*/
double GetMotorSpeed(double id)
{
	int idi = (int)id;
	int rpm;
	double speed;
	int n;
	char  buf[10];
	buf[0] = 0XFA;
	buf[1] = 0XAF;
	buf[2] = idi;
	buf[3] = 0X02;
	buf[4] = 0X00;
	buf[5] = 0x00;
	buf[6] = 0x00;
	buf[7] = 0x00;
	buf[8] = Zx_MotorCheckSum(buf);
	buf[9] = 0XED;
	write(fd, buf, 10);//将指令发送出去

	n = read(fd,buf,10);
	if(n!=0)
	{
		rpm = buf[7];
		//printf("speed = %d\n rpm",rpm);
	}
	speed = rpm * 2 * PI * 3.4 / 60;
  printf("speed = %f\n ",speed);
	return speed;
}

/**
* @brief  运行小车
* @param[in] inst  fd:串口文件描述符
* @param[in] inst  speed:车速
* @param[in] inst  gap:差速
*/
// void vehicle_speed(double speed, double gap)
// {
//   vehicle_speed_seted=speed;
//   vehicle_gap_seted=gap;
  
//   if(gap > 0.00001)
//   {
//     gap = gap-(speed*0.1);//标定值
//   }
//   else
//   {
//     gap=0;
//   }
	
  
// 	if(speed > 0)
// 	{
// 		Zx_MotorRunN(2, speed+gap);   //电机2正转
// 		Zx_MotorRunS(1, speed-gap);   //电机1正转
// 	}
// 	else
// 	{
// 		Zx_MotorRunS(2, fabs(speed)+gap);   //电机2反转
// 		Zx_MotorRunN(1, fabs(speed)-gap);   //电机1反转
// 	}
//   printf("\n rigth speed = %5.2fcm, left speed= %5.2fcm\n", speed+gap, speed-gap);
// 	return;
// }

void steer_cmd(double steer)
{
steer_cmd_seted=steer;

	int PulseWidth;
	PulseWidth = (int)(steer*100+150);
	pwmWrite(PWM_PIN1 ,PulseWidth);
  printf("steer_cmd:%f\n", steer);
  return;
	
}

void front_sensor_cmd(double steer)
{
front_sensor_cmd_seted=steer;

	int PulseWidth;
	PulseWidth = (int)(steer*100+150);
	pwmWrite(PWM_PIN2 ,PulseWidth);
  return;
}

void rear_sensor_cmd(double angle)
{
rear_sensor_cmd_seted=angle;

	int cmd = angle * 20 / 180 + 5;
	softPwmWrite(PWM_PIN3, cmd);
	return;
  //printf("可变雷达角度:%f\n", angle);
}

/**
* @brief  复位
*/


void wait(double delayTime)
{
  delayMicroseconds(delayTime * 1000000);
}

void GetCarMsg(double* sensor1_distence,double* sensor2_distence,double* sensor3_distence,double* sensor4_distence,double* sensor5_distence)
{
	// 获取传感器探测的距离
	*sensor1_distence=getDistance(Echo1);
	/* Team27 only installs four sensors. Echo2 is deliberately unused. */
	*sensor2_distence=300.0;
	*sensor3_distence=getDistance(Echo3);
	*sensor4_distence=getDistance(Echo4);
	*sensor5_distence=getDistance(Echo5);	
  
  geted_msg[0]= *sensor1_distence;
  geted_msg[1]= *sensor2_distence;
  geted_msg[2]= *sensor3_distence;
  geted_msg[3]= *sensor4_distence;
  geted_msg[4]= *sensor5_distence;  
  printf("sensor out: front| fl|right| left| fr|\n");
  printf("sensor out: %5.1f|%5.1f|%5.1f|%5.1f|%5.1f|\n",*sensor1_distence ,*sensor2_distence,*sensor3_distence,*sensor4_distence,*sensor5_distence);
}
