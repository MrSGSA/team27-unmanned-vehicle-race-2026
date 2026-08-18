#ifndef _SET_TIMER_H_
#define _SET_TIMER_H_

#ifdef _RASP_MODE_
int InitTimer(const double dwStepSize);
void CloseTimer(int pHandler);
#elif defined(_SERIAL_MODE_)
// PX4 related interfaces
void ResetStepTimer(void);
uint64_t get_time_ns(void);
#elif defined(_STM32_TCP_MODE_)
#define PreScaleFactor %replaceTxt%
#endif

void mwSleep(const double dwStepSize);

#endif

