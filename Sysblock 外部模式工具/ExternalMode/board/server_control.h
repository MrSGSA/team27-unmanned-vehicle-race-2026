#ifndef _SERVER_SERIAL_H_
#define _SERVER_SERIAL_H_

#include "msg_define.h"

typedef struct ServerControl
{
    bool m_bPauseFlag;
    bool m_bStartSimulation;

    void (*Init)(struct ServerControl* );

    int (*Start)(struct ServerControl* ptr, const unsigned char* data, int len);

    bool (*Pause)(struct ServerControl*);

    bool (*Resume)(struct ServerControl*);

    bool (*Stop)(struct ServerControl*);

    void (*Disconnect)(struct ServerControl*);

    int (*MessageDispatch)(struct ServerControl* , const TMsgHeader* tHeader, const  unsigned char* body, int bodyLen);

    bool (*ModifyParams)(struct ServerControl* ptr, const unsigned char* data, const int len);
}CServerControl;

bool SendMsg(const int emType);
bool SendBodyMsg(void* body, const int bodyLen, const int emType);

CServerControl* CreateControlFunc();
CServerControl* GetGlobalControlPtr();
#endif // !RT_SIM_CONTROL_H