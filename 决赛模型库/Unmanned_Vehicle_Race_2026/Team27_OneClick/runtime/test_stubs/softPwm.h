#ifndef TEAM27_TEST_SOFT_PWM_H
#define TEAM27_TEST_SOFT_PWM_H
int softPwmCreate(int pin, int initial_value, int pwm_range);
void softPwmWrite(int pin, int value);
#endif

