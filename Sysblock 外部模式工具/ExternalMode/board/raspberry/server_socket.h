#ifndef _EXTERN_SOCKET_H
#define _EXTERN_SOCKET_H

#include <stdbool.h>

bool InitSocket();
void StartListen();
bool IsConnect();
void Connected();
void Disconnected();

bool Send(const unsigned char* data, const int bodyLen);


#endif

