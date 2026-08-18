#include <signal.h>
#include <unistd.h>

#include "for_code_JGB520_Team27.h"

static volatile sig_atomic_t team27_running = 1;

static void team27_stop_signal(int signal_number)
{
    (void)signal_number;
    team27_running = 0;
}

int main(void)
{
    signal(SIGINT, team27_stop_signal);
    signal(SIGTERM, team27_stop_signal);
    signal(SIGHUP, team27_stop_signal);

    Init();
    while (team27_running) {
        Step();
        usleep(5000);
    }
    Terminate();
    return 0;
}

