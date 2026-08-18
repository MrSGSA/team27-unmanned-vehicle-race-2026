#ifndef _RT_SOCKET_C_H
#define _RT_SOCKET_C_H

#include <stdbool.h>

bool InitTcp(void);
void Connected(void);
bool IsConnected(void);
//void StartListen(void);
void Disconnected(void);
void TcpServerProcess(void);

bool Send(const  unsigned char* data, const int bodyLen);

#endif

