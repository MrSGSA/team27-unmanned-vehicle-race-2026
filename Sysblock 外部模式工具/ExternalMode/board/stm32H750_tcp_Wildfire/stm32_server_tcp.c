#include "stm32_server_tcp.h"
#include <stdio.h>
#include <string.h>

#include "lwip/init.h"
#include "lwip/tcp.h"
#include "lwip/pbuf.h"
//#include "lwip/timeouts.h"
#include "app_ethernet.h"

#include "rt_task.h"
#include "server_control.h"

//#include "lwip_comm.h"
//#include "./SYSTEM/delay/delay.h"

#if defined(__GNUC__) || defined(__clang__)
#define FUNC_NAME __PRETTY_FUNCTION__
#elif defined(_MSC_VER)
#define FUNC_NAME __FUNCTION__
#else
#define FUNC_NAME __func__
#endif

#define PRINT_FUNC              //printf("Recive: [%s] \n", FUNC_NAME)

#define TCP_SERVER_PORT         8080  // TCP 服务器端口号

// TCP 服务器状态
static bool g_isConnected = false;    // Sever 端是否已经与客户端建立连接
//static bool g_isInitialized = false;
static struct tcp_pcb *g_tcp_pcb = NULL;     // TCP 控制块
static struct tcp_pcb *g_tcp_client = NULL;   // 当前连接的客户端

static uint8_t recvBuff[BUFFSIZE];          // 临时存储接收到的数据
static volatile uint32_t recvLen=0;			// 接收到的数据长度
static volatile bool hasDataProcess=false;  // 是否有新的数据要处理


// TCP 回调函数前向声明
static err_t tcp_server_accept(void *arg, struct tcp_pcb *newpcb, err_t err);
static err_t tcp_server_recv(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err);
static void tcp_server_err(void *arg, err_t err);
static err_t tcp_server_poll(void *arg, struct tcp_pcb *tpcb);
static err_t tcp_server_sent(void *arg, struct tcp_pcb *tpcb, u16_t len);

bool Send(const unsigned char* data, const int bodyLen)
{
    if (!g_tcp_client || !data || bodyLen <= 0) {
        return false;
    }
	
	// 检查Buff是否溢出
	if(tcp_sndbuf(g_tcp_client) < bodyLen)
	{
		int val1 = tcp_sndbuf(g_tcp_client);
		int diff = bodyLen - val1;
		return false;
	}
		
#if 1

	err_t err = tcp_write(g_tcp_client, data, bodyLen, TCP_WRITE_FLAG_COPY);
	if(err==ERR_MEM)
	{
		printf("tcp_write err");
		return false;
	}
	
	if (err == ERR_OK)
		return true;
	
	#if 0
	if (err == ERR_OK) {
        err = tcp_output(g_tcp_client);  // 立即发送
        if(err == ERR_OK)
			return true;
		else if(err==ERR_MEM)
		{
			printf("tcp_write err");
			return false;
		}
		else
			return false;
    }
	#endif
		
#endif
		
    return false;
}

void Connected(void)
{
    PRINT_FUNC;
    g_isConnected = true;
}

void Disconnected(void)
{
    PRINT_FUNC;
    g_isConnected = false;
    if (g_tcp_client) {
        tcp_arg(g_tcp_client, NULL);
        tcp_recv(g_tcp_client, NULL);
        tcp_sent(g_tcp_client, NULL);
        tcp_err(g_tcp_client, NULL);
        tcp_poll(g_tcp_client, NULL, 0);
        tcp_close(g_tcp_client);
        g_tcp_client = NULL;
    }
    GetGlobalControlPtr()->Stop(GetGlobalControlPtr());
}

static err_t tcp_server_accept(void *arg, struct tcp_pcb *newpcb, err_t err)
{
    if (err != ERR_OK || newpcb == NULL) {
        return ERR_VAL;
    }

    // 如果已有连接，关闭新连接
    if (g_tcp_client != NULL) {
        tcp_abort(newpcb);
        return ERR_ABRT;
    }

    g_tcp_client = newpcb;

    // 设置回调
    tcp_arg(newpcb, NULL);
    tcp_recv(newpcb, tcp_server_recv);
    tcp_err(newpcb, tcp_server_err);
    tcp_poll(newpcb, tcp_server_poll, 2);
    tcp_sent(newpcb, tcp_server_sent);

	//tcp_nagle_disable(newpcb);
    Connected();
    return ERR_OK;
}

static err_t tcp_server_recv(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err)
{
    if (!p) {
        // 连接关闭
        Disconnected();
        return ERR_OK;
    }

    if (p->tot_len > 0) {
		if(hasDataProcess){
			// 主循环数据未处理完, 丢弃掉数据
			tcp_recved(tpcb, p->tot_len);
			pbuf_free(p);
			return ERR_OK;
		}
		else if(p->tot_len > BUFFSIZE){
			// 接收数据超出缓冲区，暂时丢弃
			tcp_recved(tpcb, p->tot_len);
			pbuf_free(p);
			return ERR_OK;
		}
		
		// 复制接收到的数据
		pbuf_copy_partial(p, recvBuff, p->tot_len,0);
		recvLen = p->tot_len;
		hasDataProcess = true;
		
        tcp_recved(tpcb, p->tot_len);  // 更新接收窗口
    }

    pbuf_free(p);
    return ERR_OK;
}

static void tcp_server_err(void *arg, err_t err)
{
    PRINT_FUNC;
    Disconnected();
}

static err_t tcp_server_poll(void *arg, struct tcp_pcb *tpcb)
{
    //if (IsStart()) {
     //   SingleStep();
    //}
    return ERR_OK;
}

static err_t tcp_server_sent(void *arg, struct tcp_pcb *tpcb, u16_t len)
{
    return ERR_OK;
}

bool InitTcp(void)
{
    //if (g_isInitialized) {
    //    return true;
    //}

    // 初始化 lwIP
    lwip_init();
	Netif_Config();
	User_notification(&gnetif);

    // 创建 TCP 服务器
    g_tcp_pcb = tcp_new();
    if (!g_tcp_pcb) {
        return false;
    }

    err_t err = tcp_bind(g_tcp_pcb, IP_ADDR_ANY, TCP_SERVER_PORT);
    if (err != ERR_OK) {
        tcp_close(g_tcp_pcb);
        g_tcp_pcb = NULL;
        return false;
    }

    g_tcp_pcb = tcp_listen(g_tcp_pcb);
    if (!g_tcp_pcb) {
        return false;
    }

    tcp_accept(g_tcp_pcb, tcp_server_accept);
    //g_isInitialized = true;
    //printf("TCP Server initialized on port %d\r\n", TCP_SERVER_PORT);
    return true;
}


void TcpServerProcess(void)
{
	 if(hasDataProcess)
	 {
		 hasDataProcess=false;
		 LoopRecvMsg(recvBuff, recvLen);
	 }
		
	  // 仿真操作
	  if(g_isConnected && IsStart())
	  {
		  // 发送环形缓冲区中的仿真数据
		  RtDataSendTask();
	  }
	  
}

bool IsConnected(void)
{
    return g_isConnected;
}