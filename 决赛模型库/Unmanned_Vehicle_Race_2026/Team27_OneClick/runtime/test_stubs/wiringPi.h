#ifndef TEAM27_TEST_WIRING_PI_H
#define TEAM27_TEST_WIRING_PI_H
#define INPUT 0
#define OUTPUT 1
#define PWM_OUTPUT 2
#define LOW 0
#define HIGH 1
#define PUD_UP 2
#define PWM_MODE_MS 0
int wiringPiSetup(void);
void pinMode(int pin, int mode);
void pullUpDnControl(int pin, int pud);
void digitalWrite(int pin, int value);
int digitalRead(int pin);
void delayMicroseconds(unsigned int how_long);
void pwmSetMode(int mode);
void pwmSetClock(int divisor);
void pwmSetRange(unsigned int range);
void pwmWrite(int pin, int value);
#endif

