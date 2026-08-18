#ifndef TEAM27_TEST_WIRING_SERIAL_H
#define TEAM27_TEST_WIRING_SERIAL_H
int serialOpen(const char *device, const int baud);
void serialClose(const int fd);
#endif

