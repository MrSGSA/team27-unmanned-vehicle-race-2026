#ifndef _RT_SOCKET_C_H
#define _RT_SOCKET_C_H

#include <stdbool.h>

struct THadnleControl
{
    void* fd;
    unsigned char busy;
};

bool InitSerial(void);
void StartListen(void);
bool IsOpen(void);
bool IsRunning(void);
void Connected(void);
void Disconnected(void);
void CloseSerialPort();

bool Send(const  unsigned char* data, const int bodyLen);

#endif

