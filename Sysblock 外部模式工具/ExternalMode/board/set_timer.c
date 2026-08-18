#include "set_timer.h"


#ifdef _STM32_MODE_
#include "delay.h"
#elif defined(_STM32_TCP_MODE_)
//#include "delay.h"
#elif defined(_SERIAL_MODE_)
#include <px4_platform_common/time.h>
#else
#include <unistd.h>
#endif

#ifdef _RASP_MODE_
#include <unistd.h>
#include <float.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/timerfd.h>
#include <inttypes.h>
#include <math.h>


int g_pTimerHander = 0;
int InitTimer(const double dwStepSize)
{
    g_pTimerHander = timerfd_create(CLOCK_MONOTONIC, 0);
    if (-1 == g_pTimerHander)
    {
        perror("create failed");
        return -1;
    }

    struct itimerspec timer_spec;
    if (fabs(dwStepSize - 1) > DBL_EPSILON)
    {
        const int intSec = (int)dwStepSize;
        timer_spec.it_interval.tv_sec = intSec;
        timer_spec.it_interval.tv_nsec = (dwStepSize - intSec) * 1000 * 1000 * 1000;
        timer_spec.it_value.tv_sec = intSec;
        timer_spec.it_value.tv_nsec = (dwStepSize - intSec) * 1000 * 1000 * 1000;
    }
    else
    {
        timer_spec.it_interval.tv_sec = 0;
        timer_spec.it_interval.tv_nsec = dwStepSize * 1000 * 1000 * 1000;
        timer_spec.it_value.tv_sec = 0;
        timer_spec.it_value.tv_nsec = dwStepSize * 1000 * 1000 * 1000;
    }

    if (timerfd_settime(g_pTimerHander, 0, &timer_spec, NULL) == -1)
    {
        perror("settime failed");
        close(g_pTimerHander);
        return -1;
    }

    return g_pTimerHander;
}

void CloseTimer()
{
    if (-1 != g_pTimerHander)
    {
        close(g_pTimerHander);
		g_pTimerHander=-1;
    }
}
#endif


#ifdef _SERIAL_MODE_

static uint64_t next_time_ns = 0;

void ResetStepTimer(void)
{
    next_time_ns = 0;
}

uint64_t get_time_ns(void)
{
    struct timespec ts;
    px4_clock_gettime(CLOCK_MONOTONIC, &ts);
    return (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
}
#endif

void mwSleep(const double dwStepSize)
{
#ifdef _SERIAL_MODE_
    //usleep(dwStepSize * 1000 * 1000);

    const uint64_t step_ns = (uint64_t)(dwStepSize * 1000000000.0);

    if (next_time_ns == 0) {
        next_time_ns = get_time_ns() + step_ns;
        return;
    }

    // 获取当前时间
    const uint64_t time_now_ns = get_time_ns();
    
    // 检查是否超时
    if (time_now_ns >= next_time_ns) {
        next_time_ns += step_ns;
        return; 
    }
    
    // 未超时需要等待的时间计算
    const uint64_t wait_ns = next_time_ns - time_now_ns;
    const useconds_t wait_us = (useconds_t)((wait_ns + 500) / 1000);

    if (wait_us > 0) {
        px4_usleep(wait_us);
    }

    next_time_ns += step_ns;

#elif _STM32_MODE_
    //delay_us(dwStepSize * 1000 * 1000 * 1000);
#elif _STM32_TCP_MODE_
	  // Todo
#elif _RASP_MODE_
    if (-1 == g_pTimerHander)
    {
        return;
    }

    struct itimerspec timer_spec;
    uint64_t expirations;

    read(g_pTimerHander, &expirations, sizeof(expirations));
    if (expirations > 1)
    {
        printf(" (miss %" PRIu64 ", currentStepTime:%ld)", expirations - 1, dwStepSize);
    }
#endif
}

