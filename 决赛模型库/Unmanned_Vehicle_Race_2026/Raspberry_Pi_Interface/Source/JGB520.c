#include <wiringPi.h>
#include <wiringSerial.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <errno.h>

#define SPEED_POS 600
#define SPEED_NEG -20
#define RUN_TIME 5000
extern int fd;
// int uart_fd;

// int uart_init()
// {
	// if(wiringPiSetup() == -1)
	 // {
	 	// return 1;
	 // }
    // fd = serialOpen("/dev/ttyAMA0", 115200);
    // if (uart_fd < 0)
    // {
        // perror("open uart failed");
        // return -1;
    // }
    // perror("open uart sussend");
    // return 0;
// }

void motor_send_cmd(int id, double speed, int time_ms)
{
    char cmd_buf[15] = {0};
	int PWM = 0;
	PWM = (int)((speed) / 0.003 /100);
    int p_val = 1500 + PWM;
    // 标准闭环指令：#000P1520B2000! 无多余\r\n，手册标准指令不带换行
    sprintf(cmd_buf, "#%03dP%04dT%04d!", id, p_val, time_ms);
    int len = strlen(cmd_buf);
    write(fd, cmd_buf, len);
    //tcdrain(uart_fd); // 等待串口数据全部发送完成
    printf("send control: %s\n", cmd_buf);
}

// 停机专用函数
void motor_stop(int id)
{
    motor_send_cmd(id, 0, 0);
}
