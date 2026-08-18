model Raspberry_out
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(modelType=Control,PortArrangement(Left(inport, inport1, inport2, inport3), Right(outport, outport1, outport2, outport3, outport4)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.02),CodeGeneration(Config = {"code_placement":{"mode":"Compact"},"code_replacement":{"fixed_point_library":"Fixed-TY","standard_c_library":"C99"},"custom_code":{"code":{"function_declare":{"head":"","item_head":"","item_tail":"","tail":""},"function_define":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_declare":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_define":{"head":"","item_head":"","item_tail":"","tail":""},"include":{"head":"","item_head":"","item_tail":"","tail":""},"macro":{"head":"","item_head":"","item_tail":"","tail":""},"type":{"head":"","item_head":"","item_tail":"","tail":""}},"code_protection":{"integer_division_by_zero":false,"overflow":false}},"data_type":{"real_as_float":true},"experiment":{"task_and_sample":{"muti_task_mode":false}},"hardware_platform":{"byte_ordering":"Big Endian","largest_atomic_size":{"floating_point":"32","integer":"32"},"number_of_bits":{"char":8,"double":32,"float":32,"int":32,"long":32,"long_long":0,"pointer":32,"ptrdiff_t":32,"size_t":32},"support_dynamic_memory_allocation":false,"support_float_point":true,"target":"get","type_platform":"ARM Cortex-M0","vendor":"中颖科技"},"identifier":{"format":{"function":"{{model_name}}{{name}}","global_variable":"{{model_name}}{{data_type}}{{prefix}}{{name}}","local_variable":"{{data_type}}{{prefix}}{{name}}","macro":"{{model_name}}{{name}}","mem_var":"{{model_name}}{{name}}","type":"{{model_name}}{{name}}"},"format_string":{"boolean":"b","input":"in","integer":"i","output":"out","parameter":"p","real":"r"},"max_length":32,"style":{"function":"camelCase","global_variable":"camelCase","local_variable":"camelCase","macro":"camelCase","mem_var":"camelCase","type":"camelCase"}},"interface":{"function_name":{"initialize"
:"Init","step"
:"Step","terminate"
:""},"have_terminate"
:
false},"optimization"
:{"Code":
"size"
,"array_loop_threshold"
:5,"logical_operator"
:"logical"}}, Sim_seting = {"sim_seting":{"output":"C:\\Users\\admin\\Documents\\MWORKS\\Simulation"}})),Icon(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2}),graphics = {Rectangle(origin={0,0}, 
fillColor={255,245,225}, 
fillPattern=FillPattern.Solid, 
extent={{-100,-100},{100,100}}), Rectangle(origin={0,7.10543e-15}, 
lineColor={0,0,0}, 
fillColor={179,179,179}, 
lineThickness=1, 
extent={{-60,60},{60,-60}}, 
radius=10), Rectangle(origin={0,0}, 
lineColor={0,0,0}, 
fillColor={179,179,179}, 
lineThickness=1, 
extent={{-45,45},{45,-45}}), Line(origin={-65.5437,-8}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-65.5437,24}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-65.5437,8}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-65.5437,40}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-65.5437,-24}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-65.5437,-40}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={66.0833,-8}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={66.0833,24}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={66.0833,8}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={66.0833,40}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={66.0833,-24}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={66.0833,-40}, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={8,65.4261}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-24,65.4261}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-8,65.4261}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-40,65.4261}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={24,65.4261}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={40,65.4261}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={8,-65.9799}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-24,-65.9799}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-8,-65.9799}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={-40,-65.9799}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={24,-65.9799}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Line(origin={40,-65.9799}, 
rotation=90, 
points={{-5,0},{5,0}}, 
thickness=1, 
smooth=Smooth.Bezier, 
__MWorks_Manhattanize=true), Text(origin={0,-120}, 
extent={{-150,20},{150,-20}}, 
textString="%name", 
fontSize=14, 
verticalAlignment=TextAlignment.Top)}),experiment(Algorithm=Euler),Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, 
grid={2,2})));
  block CCaller

      annotation(
       __MWORKS(PortArrangement(Left(), Right()),BlockSystem(blockKind = BlockKind.atomic,bltBlockKind = BltBlockKind.ccaller,SampleTime=-1),independentInstance = true,sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller,ExternalFunctionBlock,hide = true), 
            Icon(coordinateSystem(extent = { {-200.0, -100.0}, {200.0, 100.0} }, 
            preserveAspectRatio = false, 
            initialScale = 0.1, 
            grid = { 2.0, 2.0 }), graphics = { Rectangle(origin = {0.0, 0.0}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0}, 
            extent = {{-200.0, 20.0}, {200, -20}}, 
            textString = "rasInit", 
            verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0}, 
            lineColor = {0, 0, 0}, 
            extent = {{-150, 20}, {150, -20}}, 
            textString = "%name", 
            fontSize = 14, 
           textStyle = {TextStyle.None}, 
            textColor = {0, 0, 0}, 
            verticalAlignment = TextAlignment.Top) }), 
        Diagram(coordinateSystem(extent = { {-100.0, -100.0}, {100.0, 100.0} }, 
            preserveAspectRatio = false, 
            initialScale = 0.1, 
            grid = { 2.0, 2.0 })));
    function func_CCaller
  external "C" rasInit() 
  annotation (Include = "#include <wiringPi.h>
#include <wiringSerial.h>
#include <softPwm.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <signal.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>

#define Trig1 4     // 传感器 Trig端口
#define Echo1 5    // 正前方传感器 Echo端口
#define Echo2 12    // 正前方舵机传感器 Echo端口
#define Echo3 13    // 右侧方传感器 Echo端口
#define Echo4 14    // 左侧方传感器 Echo端口
#define Echo5 6    // 后方传感器 Echo端口
#define PWM_PIN1 26    // 转向舵机引脚
#define PWM_PIN2 23    // 正前方传感器舵机引脚
#define PWM_PIN3 2    // 后方传感器舵机引脚
#define Zx_Motor_FRAME_HEADER1  0XFA
#define Zx_Motor_FRAME_HEADER2  0XAF
#define Zx_Motor_READ_ANGLE     0X02
#define Zx_Motor_FRAME_END      0XED
#define Zx_Motor_RUNS           0XFD
#define Zx_Motor_RUNN           0XFE
#define uint8     char
#define uint32    unsigned int   
#define GET_LOW_BYTE(A)  ((char)(A))
#define GET_HIGH_BYTE(A) ((char)((A) >> 8))
#define PI acos(-1)
double distances[5];
double SPEED;

void rasInit()
{
	 if(wiringPiSetup() == -1)
	 {   
	 	printf(\"硬件初始化失败！\\n\");
	 	return ;
	 }
  printf(\"wiringPiSetup ok!\\n\");
	pinMode(Trig1, OUTPUT);   // 配置端口为输出模式
	pinMode(Echo1, INPUT);   // 配置端口为输入模式
	pinMode(Echo2, INPUT);   // 配置端口为输入模式
	pinMode(Echo3, INPUT);   // 配置端口为输入模式
	pinMode(Echo4, INPUT);   // 配置端口为输入模式
	pinMode(Echo5, INPUT);   // 配置端口为输入模式
	pullUpDnControl(Echo1, PUD_UP); // 对一个设置 IO 模式为 INPUT 的输入引脚设置拉电阻模式
	pullUpDnControl(Echo2, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo3, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo4, PUD_UP); // PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pullUpDnControl(Echo5, PUD_UP);	// PUD_UP 启用上拉电阻，引脚电平拉到 3.3v
	pinMode(PWM_PIN1, PWM_OUTPUT);
	pinMode(PWM_PIN2, PWM_OUTPUT);
	pinMode(PWM_PIN3, OUTPUT);
	pwmSetMode(PWM_MODE_MS);
	pwmSetClock(192);
	pwmSetRange(2000);
	softPwmCreate(PWM_PIN3, 0, 200);
	
  printf(\" Raspberry Pi Setup ok!\\n\");
	return ;
}

/**
* @brief  获取超声波传感器探测的距离
**/
double getDistance(int echoPin)
{
	double dis;
	long start;
	long end;
	struct timeval tv1;
	struct timeval tv2;
 
  int cot = 0;

	digitalWrite(Trig1, LOW);   // 先通入低电平，避免后续误差过大
	delayMicroseconds(2);
	digitalWrite(Trig1, HIGH);
	delayMicroseconds(10);   // 树莓派发送 10us 脉冲信号
	digitalWrite(Trig1, LOW);

  while((digitalRead(echoPin) != HIGH)&&(cot++ < 31000)); // HIGH（1），检测到高电平时跳出循环
	gettimeofday(&tv1, NULL);   // 获取时间（此为高电平开始时间）
  cot = 0;
  while((digitalRead(echoPin) != LOW)&&(cot++ < 36000));   // LOW（0），检测到低电平跳出循环
	gettimeofday(&tv2, NULL);   // 获取时间（此为低电平开始时间，即为高电平结束时间）
  cot = 0;
	start = tv1.tv_sec * 1000000 + tv1.tv_usec;   // 单位（微秒）
	end = tv2.tv_sec * 1000000 + tv2.tv_usec;   // 单位（微秒）
	dis = (double)(end - start) / 1000000 * 34000 / 2;   // 距离计算（高电平时间 * 音速 / 2）

	delayMicroseconds(15000);   // 树莓派等待10ms
  return dis;
}


/**
* @brief  CRC校验
* @param[in] inst  buf[]
*/
char Zx_MotorCheckSum(char buf[])
{
	int i;
	unsigned int sum = 0;
	for (i = 2; i < 8; i++)
	{
		sum += buf[i];
	}
	if (sum > 255)sum &= 0x00FF;
	return sum;
}

/**
* @brief  电机正转
* @param[in] inst  fd:串口标识位
* @param[in] inst  id:电机id号
* @param[in] inst  speed:车速
*/
void Zx_MotorRunS(int fd, double id, double speed)
{
	int rpm = speed / (2 * PI * 3.4) * 60;
	int idi = (int)id;
	char  buf[10];
	buf[0] = 0XFA;
	buf[1] = 0XAF;
	buf[2] = idi;
	buf[3] = 0x01;
	buf[4] = 0XFD;
	buf[5] = 0x00;
	buf[6] = (char)((rpm) >> 8);
	buf[7] = (char)(rpm);
	buf[8] = Zx_MotorCheckSum(buf);
	buf[9] = 0XED;
	write(fd, buf, 10);//将指令发送出去
	delayMicroseconds(10000);   // 树莓派等待50ms
}

/**
* @brief  电机反转
* @param[in] inst  fd:串口标识位
* @param[in] inst  id:电机id号
* @param[in] inst  rpm:给定电机转速
*/
void Zx_MotorRunN(int fd, double id, double speed)
{
	int rpm = speed / (2 * PI * 3.4) * 60;
	int idi = (int)id;
	char  buf[10];
	buf[0] = 0XFA;
	buf[1] = 0XAF;
	buf[2] = idi;
	buf[3] = 0x01;
	buf[4] = 0XFE;
	buf[5] = 0x00;
	buf[6] = (char)((rpm) >> 8);
	buf[7] = (char)(rpm);
	buf[8] = Zx_MotorCheckSum(buf);
	buf[9] = 0XED;
	write(fd, buf, 10);//将指令发送出去
	delayMicroseconds(10000);   // 树莓派等待50ms
}

/**
* @brief  获取电机转速
* @param[in] inst  fd:串口文件描述符
* @param[in] inst  id:电机ID号
*/
double GetMotorSpeed(int fd, double id)
{
	int idi = (int)id;
	int rpm;
	double speed;
	int n;
	char  buf[10];
	buf[0] = 0XFA;
	buf[1] = 0XAF;
	buf[2] = idi;
	buf[3] = 0X02;
	buf[4] = 0X00;
	buf[5] = 0x00;
	buf[6] = 0x00;
	buf[7] = 0x00;
	buf[8] = Zx_MotorCheckSum(buf);
	buf[9] = 0XED;
	write(fd, buf, 10);//将指令发送出去

	n = read(fd,buf,10);
	if(n!=0)
	{
		rpm = buf[7];
		//printf(\"speed = %d\\n rpm\",rpm);
	}
	speed = rpm * 2 * PI * 3.4 / 60;
  printf(\"speed = %d\\n \",speed);
	return speed;
}

/**
* @brief  运行小车
* @param[in] inst  fd:串口文件描述符
* @param[in] inst  speed:车速
* @param[in] inst  gap:差速
*/
void vehicle_speed(int fd, double speed, double gap)
{
  
  if(gap > 0.00001)
  {
    gap = gap-(speed*0.1);//标定值
  }
  else
  {
    gap=0;
  }
	
  
	if(speed > 0)
	{
		Zx_MotorRunN(fd, 2, speed+gap);   //电机2正转
		Zx_MotorRunS(fd, 1, speed-gap);   //电机1正转
	}
	else
	{
		Zx_MotorRunS(fd, 2, fabs(speed)+gap);   //电机2反转
		Zx_MotorRunN(fd, 1, fabs(speed)-gap);   //电机1反转
	}
  printf(\"\\n rigth speed = %5.2fcm, left speed= %5.2fcm\\n\", speed+gap, speed-gap);
	return;
}

void steer_cmd(double steer)
{
	int PulseWidth;
	PulseWidth = (int)(steer*100+150);
	pwmWrite(PWM_PIN1 ,PulseWidth);
  return;
	//printf(\"steer_cmd:%f\\n\", steer);
}

void front_sensor_cmd(double steer)
{
	int PulseWidth;
	PulseWidth = (int)(steer*100+150);
	pwmWrite(PWM_PIN2 ,PulseWidth);
  return;
}

void rear_sensor_cmd(double angle)
{
	int cmd = angle * 20 / 180 + 5;
	softPwmWrite(PWM_PIN3, cmd);
	return;
  //printf(\"可变雷达角度:%f\\n\", angle);
}

/**
* @brief  复位
*/
void reset()
{
  int fd = serialOpen(\"/dev/ttyAMA0\", 115200);
  delayMicroseconds(20000);
  vehicle_speed(fd, 0, 0);
  steer_cmd(0);
  front_sensor_cmd(0);
  printf(\"reset success!\\n\");
  exit(0);
}

void wait(double delayTime)
{
  delayMicroseconds(delayTime * 1000000);
}

void GetCarMsg(int fd,double* sensor1_distence,double* sensor2_distence,double* sensor3_distence,double* sensor4_distence,double* sensor5_distence)
{
	// 获取传感器探测的距离
	*sensor1_distence=getDistance(Echo1);
	*sensor2_distence=getDistance(Echo2);
	*sensor3_distence=getDistance(Echo3);
	*sensor4_distence=getDistance(Echo4);
	*sensor5_distence=getDistance(Echo5);	
}
");
  end func_CCaller;
    initial equation

    func_CCaller();
  end CCaller;
  CCaller c_caller 
    annotation (Placement(transformation(origin={-65.8544,118.765}, 
extent={{-20,-10},{20,10}})),__MWORKS(BlockSystem(SampleTime(group="D1")=0.02)));
  CCaller1 c_caller1 
    annotation (Placement(transformation(origin={-160,63.3334}, 
extent={{-20,-16},{20,16}})),__MWORKS(ComponentNamePlacement(BOTTOM),BlockSystem(SampleTime(group="D1")=0.02)));
  CCaller2 c_caller2 
    annotation (Placement(transformation(origin={48,50.2667}, 
extent={{-20,-10},{20,10}})),__MWORKS(BlockSystem(SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport outport 
    annotation (Placement(transformation(origin={-93.5,86}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,80}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport outport1 
    annotation (Placement(transformation(origin={-93.5,63.3334}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,40}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport outport2 
    annotation (Placement(transformation(origin={-93.5,40.6667}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,0}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport outport3 
    annotation (Placement(transformation(origin={-93.5,18.0001}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,-40}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport outport4 
    annotation (Placement(transformation(origin={-93.5,-4.66653}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,-80}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Inport inport 
    annotation (Placement(transformation(origin={-203.5,63.3334}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={-101.8,75}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="int32"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Inport inport1 
    annotation (Placement(transformation(origin={-20.5,72.8334}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={-101.8,25}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="int32"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Inport inport2 
    annotation (Placement(transformation(origin={-29.5,53.7667}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={-101.8,-25}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Inport inport3 
    annotation (Placement(transformation(origin={-20.5,34.7}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={-101.8,-75}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  block CCaller1

      annotation(
       __MWORKS(PortArrangement(Left(fd), Right(sensor1_distence,sensor2_distence,sensor3_distence,sensor4_distence,sensor5_distence)),BlockSystem(blockKind = BlockKind.atomic,bltBlockKind = BltBlockKind.ccaller,SampleTime=-1),independentInstance = true,sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller,ExternalFunctionBlock,hide = true), 
            Icon(coordinateSystem(extent = { {-200.0, -100.0}, {200.0, 100.0} }, 
            preserveAspectRatio = false, 
            initialScale = 0.1, 
            grid = { 2.0, 2.0 }), graphics = { Rectangle(origin = {0.0, 0.0}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0}, 
            extent = {{-200.0, 20.0}, {200, -20}}, 
            textString = "GetCarMsg", 
            verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0}, 
            lineColor = {0, 0, 0}, 
            extent = {{-150, 20}, {150, -20}}, 
            textString = "%name", 
            fontSize = 14, 
           textStyle = {TextStyle.None}, 
            textColor = {0, 0, 0}, 
            verticalAlignment = TextAlignment.Top) }), 
        Diagram(coordinateSystem(extent = { {-100.0, -100.0}, {100.0, 100.0} }, 
            preserveAspectRatio = false, 
            initialScale = 0.1, 
            grid = { 2.0, 2.0 })));
    function func_CCaller1
    input SysplorerEmbeddedCoder.Types.Auto fd annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="int32"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor1_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor2_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor3_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor4_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor5_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
  external "C" GetCarMsg(fd,sensor1_distence,sensor2_distence,sensor3_distence,sensor4_distence,sensor5_distence);
  end func_CCaller1;
      SysplorerEmbeddedCoder.Port.Inport fd 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "int32"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Outport sensor1_distence 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Outport sensor2_distence 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Outport sensor3_distence 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Outport sensor4_distence 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Outport sensor5_distence 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
    equation

    (sensor1_distence, sensor2_distence, sensor3_distence, sensor4_distence, sensor5_distence) = func_CCaller1(fd);
  end CCaller1;
  block CCaller2

      annotation(
       __MWORKS(PortArrangement(Left(fd,speed,gap), Right()),BlockSystem(blockKind = BlockKind.atomic,bltBlockKind = BltBlockKind.ccaller,SampleTime=-1),independentInstance = true,sourceModel = SysplorerEmbeddedCoder.Utilities.CCaller,ExternalFunctionBlock,hide = true), 
            Icon(coordinateSystem(extent = { {-200.0, -100.0}, {200.0, 100.0} }, 
            preserveAspectRatio = false, 
            initialScale = 0.1, 
            grid = { 2.0, 2.0 }), graphics = { Rectangle(origin = {0.0, 0.0}, 
            fillColor = {255, 255, 255}, 
            fillPattern = FillPattern.Solid, 
            extent = {{-200.0, 100.0}, {200.0, -100.0}}), Text(origin = {0.0, 0.0}, 
            extent = {{-200.0, 20.0}, {200, -20}}, 
            textString = "vehicle_speed", 
            verticalAlignment = TextAlignment.VCenter), Text(origin = {0.0, -120.0}, 
            lineColor = {0, 0, 0}, 
            extent = {{-150, 20}, {150, -20}}, 
            textString = "%name", 
            fontSize = 14, 
           textStyle = {TextStyle.None}, 
            textColor = {0, 0, 0}, 
            verticalAlignment = TextAlignment.Top) }), 
        Diagram(coordinateSystem(extent = { {-100.0, -100.0}, {100.0, 100.0} }, 
            preserveAspectRatio = false, 
            initialScale = 0.1, 
            grid = { 2.0, 2.0 })));
    function func_CCaller2
    input SysplorerEmbeddedCoder.Types.Auto fd annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="int32"), Dimension(dimensionType = DimensionType.none) = 1)));
    input SysplorerEmbeddedCoder.Types.Auto speed annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    input SysplorerEmbeddedCoder.Types.Auto gap annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
  external "C" vehicle_speed(fd,speed,gap);
  end func_CCaller2;
      SysplorerEmbeddedCoder.Port.Inport fd 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "int32"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Inport speed 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
      SysplorerEmbeddedCoder.Port.Inport gap 
      annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref = "double"),Dimension(dimensionType = DimensionType.none) = 1)), Placement(transformation(origin = {0,0}, extent = { {-10,-10}, {10,10} })));
    equation

    func_CCaller2(fd, speed, gap);
  end CCaller2;
equation
  connect(c_caller1.sensor1_distence, outport) 
  annotation(Line(origin={-116,81}, 
  points={{-22.2,-4.86663},{22.5,-4.86663},{22.5,5}}, 
  color={0,0,0}));
  connect(c_caller1.sensor2_distence, outport1) 
  annotation(Line(origin={-116,67}, 
  points={{-22.2,2.73337},{22.5,2.73337},{22.5,-3.66663}}, 
  color={0,0,0}));
  connect(c_caller1.sensor3_distence, outport2) 
  annotation(Line(origin={-116,52}, 
  points={{-22.2,11.3334},{22.5,11.3334},{22.5,-11.3333}}, 
  color={0,0,0}));
  connect(c_caller1.sensor4_distence, outport3) 
  annotation(Line(origin={-116,37}, 
points={{-22.2,19.9334},{10,19.9334},{10,-18.9999},{22.5,-18.9999}}, 
color={0,0,0}));
  connect(c_caller1.sensor5_distence, outport4) 
  annotation(Line(origin={-116,23}, 
  points={{-22.2,27.5334},{-22.2,-27.6665},{22.5,-27.6665}}, 
  color={0,0,0}));
  connect(c_caller2.fd, inport1) 
  annotation(Line(origin={3,65}, 
  points={{23.2,-8.06663},{-23.5,-8.06663},{-23.5,7.83337}}, 
  color={0,0,0}));
  connect(c_caller2.speed, inport2) 
  annotation(Line(origin={-2,52}, 
  points={{28.2,-1.7333},{-27.5,-1.7333},{-27.5,1.7667}}, 
  color={0,0,0}));
  connect(c_caller2.gap, inport3) 
  annotation(Line(origin={3,39}, 
  points={{23.2,4.60003},{-23.5,4.60003},{-23.5,-4.29997}}, 
  color={0,0,0}));
  connect(c_caller1.fd, inport) 
  annotation(Line(origin={-219,75}, 
points={{37.2,-11.6666},{15.5,-11.6666}}, 
color={0,0,0}));
  end Raspberry_out;