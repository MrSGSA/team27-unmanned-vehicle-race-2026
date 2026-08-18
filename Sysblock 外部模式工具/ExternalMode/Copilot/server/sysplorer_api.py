"""
Sysplorer Python API 接口文档
============================
本文件仅作为接口说明文档，不能直接import使用。
实际调用方式：
    import mworks.sysplorer as eng
    eng.ChangeDirectory(params)
"""


import json
import inspect
from colorama import init
import sys
from copy import deepcopy
from .Utils import MwConnect, mw_connect_decorator, path_resolver,parsing_data_type
from .mw_ani_listener import MwAniListener
import os
import ast

from .mw_class import (MwPyMSLVersion,MwPyFMIType,MwPyFMIVersion,MwPyFMIPlatform,MwPyFMI,
                      MwPyModelView,MwPyIntegration,MwPyResultFormat,MwPyLegendLayout,
                      MwPyAxisTitleType,MwPyLineStyle,MwPyLineColor,MwPyLineThickness,
                      MwPyMarkerStyle,MwPyVerticalAxis,MwPyPlotFileFormat,MwPyExperiment,
                      MwPySimulationTime,MwFillPattern,MwLinePattern,MwBorderPattern,MwArrowPattern,
                      MwSmooth,MwTextAlignment,MwShapeStyle,MwShapeType,MwEncryptLevel)

init(autoreset = True)

SimulationTime = MwPySimulationTime()
MSLVersion = MwPyMSLVersion()
FMI = MwPyFMI()
ModelView = MwPyModelView()
Integration = MwPyIntegration()
ResultFormat = MwPyResultFormat()
LegendLayout = MwPyLegendLayout()
AxisTitleType = MwPyAxisTitleType()
LineStyle = MwPyLineStyle()
LineColor = MwPyLineColor()
LineThickness = MwPyLineThickness()
MarkerStyle = MwPyMarkerStyle()
VerticalAxis = MwPyVerticalAxis()
PlotFileFormat = MwPyPlotFileFormat()
Experiment = MwPyExperiment()
FillPattern = MwFillPattern()
LinePattern = MwLinePattern()
BorderPattern = MwBorderPattern()
ArrowPattern = MwArrowPattern()
Smooth = MwSmooth()
TextAlignment = MwTextAlignment()
ShapeStyle = MwShapeStyle()
ShapeType = MwShapeType()
simOptions = {}
SysOptions = {}
EncryptLevel = MwEncryptLevel()

_MwConnect = MwConnect()
_MwAniListener = MwAniListener()

def Help(cmd: str = None):
    if cmd == None or cmd == "":
        msg = "  Help(): 显示本信息。\n  Help(String command_name): 显示指定命令的文档。\n  ListFunctions(): 列出所有函数。\n  ListVariables(): 列出所有变量。"
        print(msg)
    elif isinstance(cmd, str):
        cur_global = globals()
        if inspect.isfunction(cur_global.get(cmd, None)):
            return help(cur_global.get(cmd, None))
        else:
            print(f"  未找到函数: {cmd}")
    elif inspect.isfunction(cmd):
        return help(cmd)

def ListFunctions():
    """
    列出所有命令函数
    
    语法
        >>> ListFunctions()
    说明
        ListFunctions() 用于列出所有命令函数，结果每行每个元素表示函数的名字和描述。
    示例
    示例1：列出所有命令函数示例
        打印所有命令函数
        >>> print(ListFunctions())
        结果：
        > ClearAll: 清除系统所有内容，恢复到启动状态。返回是否清除成功
        > SetLicensePath: 设置许可证路径，True 表示应用成功
        > License: 依据传入的不同的ltype进行不同的许可证相关操作
        > ChangeDirectory: 设置工作目录，并打印（设置后的）当前目录到命令窗口
        > GetDirectory: 获取工作目录
        > ChangeSimResultDirectory: 修改仿真结果目录，并打印（设置后的）结果目录到命令窗口
        > GetSimResultDirectory: 获取仿真结果目录
        > ChangeCacheDirectory: 设置缓存目录，并打印（设置后的）缓存目录到命令窗口
        > GetCacheDirectory: 获取缓存目录
        > GetInstallationDirectory: 获取软件安装目录
        > GetLastErrors: 获取上一条命令的错误信息，若上一条的命令是正确的，即没有错误信息，将返回空
        > GetVersion: 获取软件版本号，并打印
        > GetKernelVersion: 获取软件内核版本号，并打印
        > GetLanguage: 获取当前系统语言,并打印
        > SetLanguage: 设置系统语言
        > ListOptions: 打印所有系统首选项
        > GetOption: 获取某个具体首选项的值
        > SetOption: 设置某个具体首选项的值
        > Echo: 设置/获取是否打开“反馈每条语句的执行结果”功能。如果不传入参数，则返回当前状态。
        > Exit: 退出Sysplorer，若此时存在修改而未保存的实例或模型时，不会弹出是否保存提示框
        > LoadLibrary: 加载指定模型库
        > OpenModelFile: 加载指定的 Modelica 模型文件，支持 .mol 和.mo文件
        > ImportFMU: 导入 FMU 文件，若已经导入过，则自动卸载并重新导入
        > ExportIcon: 把图标视图导出为图片
        > ExportDiagram: 把图形视图导出为图片
        > ExportDocumentation: 把模型文档信息导出到文件（仅支持导出为 htm /html 格式）
        > ExportDocumentationEx: 把模型文档信息导出到文件（仅支持导出为 htm /html 格式）
        > ExportFMU: 将模型导出为FMU
        > ExportVeristand: 模型导出为 Veristand 模型
        > CompareModel: 输入文件或模型全名图形化对比模型
        > OpenModel: 打开模型窗口
        > CheckModel: 检查模型
        > TranslateModel: 翻译模型
        > ListCodeGenerationOptions: 打印Sysblock代码生成配置
        > GetModelCodeGenerationOptions: 获取Sysblock代码生成配置
        > SetModelCodeGenerationOptions: 设置Sysblock代码生成配置
        > GenerateModelCode: 使用模型的代码生成配置进行代码生成
        > ListSimulationOptions: 获取所有的仿真设置
        > SimulateModelEx: 基于设置进行仿真
        > StartSimulate: 基于设置进行异步仿真
        > PauseSimulate: 暂停仿真
        > ResumeSimulate: 恢复仿真
        > StopSimulate: 停止仿真
        > GetSimulationExitState: 获取仿真的退出状态
        > GetCurrentSimTime: 获取当前仿真时刻
        > GetSimulationState: 获取当前的仿真状态
        > SimulateModel: 仿真模型
        > RemoveResults: 移除所有结果
        > RemoveResult: 移除最后一个仿真结果，不保存，也不询问用户
        > OpenResult: 打开已有的仿真结果
        > GetResultVariables: 获取结果中的变量列表
        > ImportInitial: 导入初值文件
        > ExportInitial: 导出初值文件
        > GetInitialValue: 获取仿真结果参数初值
        > SetInitialValue: 设置仿真结果参数初值
        > ExportResult: 导出结果文件，支持 csv 、 mat 、 msr 格式，并支持导出整个实例
        > SetCompileSolver64: 设置翻译时编译器平台位数。
        > GetCompileSolver64: 获取翻译时编译器平台位数，若为32位，则返回值为0，若为64位，则返回值为1
        > SetCompileFmu64: 设置 fmu 导出时编译器平台位数
        > GetCompileFmu64: 获取 fmu 导出时编译器平台位数
        > GetExperiment: 获取后处理仿真设置
        > GetModelExperiment: 获取模型仿真配置
        > SetModelExperiment: 设置某个模型的仿真配置
        > CreateLayout: 创建布局
        > CreatePlot: 新建曲线窗口
        > Plot: 在最后一个窗口中绘制指定变量的曲线，如果没有窗口则按系统默认设置新建一个窗口
        > RemovePlots: 关闭所有曲线窗口
        > ClearPlot: 清除曲线窗中当前子窗口内容
        > ExportPlot: 曲线导出
        > CreateAnimation: 新建动画窗口
        > RemoveAnimations: 关闭所有动画窗口
        > RunAnimation: 播放动画
        > AnimationSpeed: 设置动画播放速度
        > NewModel: 新建模型
        > CopyModel: 复制模型
        > RenameModel: 重命名模型
        > SaveModel: 保存指定模型
        > SaveModelAs: 模型另存为
        > SaveAllModels: 保存所有模型
        > EraseClasses: 删除子模型或卸载顶层模型
        > GetModelInfo: 通用的获取模型信息的接口
        > SetModelInfo: 通用的设置模型信息的接口
        > GetComponentInfo: 通用的获取组件属性的接口
        > SetComponentInfo: 通用的设置组件属性的接口
        > GetModelParamList: 获取模型中某个组件的参数列表
        > GetModelParamValue: 获取参数值
        > SetModelParamValue: 设置指定模型指定参数的值
        > AddComponent: 在指定模型下添加modelName类型的组件
        > AddGotoComponent: 创建GOTO组件
        > AddFromComponent: 创建FROM组件
        > CopyComponent: 复制组件
        > RemoveComponent: 移除组件
        > GetConnectionInfo: 获取连接线信息通用的获取连线属性的接口
        > SetConnectionInfo: 通用的设置连线属性的接口
        > ConnectPort: 在指定模型下连接两个端口
        > RemoveConnect: 移除连接
        > GetClasses: 获取指定模型的嵌套类型
        > GetComponents: 获取指定模型的嵌套组件
        > GetParamList: 获取指定组件前缀层次中的参数列表
        > GetModelDescription: 获取指定模型的描述文字
        > SetModelDescription: 设置指定模型的描述文字,替换原来的描述
        > ImportModelDataFile: 导入文件到工作区
        > ExportModelDataFile: 导出工作区数据到文件中
        > GetWorkspaceEntryProperty: 获取工作区数据属性
        > SetWorkspaceEntryProperty: 设置工作区数据属性      
        > ClearWorkspace: 清空指定工作区数据
        > BindDataDictionary: 绑定数据字典文件
        > UnbindDataDictionary: 解绑数据字典文件
        > GetComponentDescription: 获取指定模型中组件的描述文字
        > SetComponentDescription: 设置指定模型中组件的描述文字
        > GetComponentTypeName: 获取指定模型中组件的类型名字
        > GetComponentPorts: 获取组件端口
        > GetParamValue: 获取参数值
        > SetParamValue: 设置当前模型指定参数的值，支持设置内置类型属性
        > GetModelText: 获取模型文本
        > EditModelText: 编辑模型的Modelica文本内容
        > SetModelText: 修改模型的Modelica文本内容
        > GetVarValueAt: 获取变量在特定时刻的值
        > GetVarsValueAt: 批量获取所有给定变量在特定时刻的值
        > GetVarValues: 获取给定变量的所有时刻值
        > GetVarsValues: 批量获取所有给定变量的所有时刻值
        > AddConnection: 已弃用
        > DrawLine: 在指定模型视图绘制线段
        > DrawLines: 在指定模型视图绘制多段线
        > DrawPolygon: 在指定模型视图绘制多边形
        > DrawTriangle: 在指定模型视图绘制三角形
        > DrawRectangle: 在指定模型视图绘制矩形
        > DrawEllipse: 在指定模型视图绘制椭圆
        > DrawText: 在指定模型视图绘制文本
        > DrawBitmap: 在指定模型视图绘制位图
        > DrawShape: 在指定模型视图绘制图元
        > ClearShapes: 清空指定模型视图的所有图形
        > ClassExist: 判断给定的名字是否为已加载的类型
        > GetRestriction: 获取给定类型的限定类型
        > SendHeart: 用于保持Syslab与Sysplorer之间的通信
        > MessageText: 获取上一条命令的日志信息
    输入参数
        无
    返回值
        `str`：每个元素表示函数的名字和描述，并使用'\\n'分割
    另请参阅
        无
    """
    with open(os.path.abspath(__file__), "r", encoding="utf-8") as source_file:
        source_code = source_file.read()
    parsed_code = ast.parse(source_code)
    functions = []
    for node in ast.walk(parsed_code):
        if isinstance(node, ast.FunctionDef):
            # 函数名
            func_name = node.name
            if not (f"{func_name}".startswith('_') or f"{func_name}" == "ListFunctions" or f"{func_name}" == "GetVarTimes" or f"{func_name}" == "ListVariables"):#去除不显示的函数
                # 帮助
                docstring = ast.get_docstring(node)
                if docstring != None:
                    docstring = docstring.split('\n', 1)[0]
                functions.append(f"{func_name}: {docstring}")
                print(f"{func_name}: {docstring}")

    return functions
listfunctions=ListFunctions

# 通过文本行处理注释
def _extract_comments_from_code(code):
    comments = {}
    
    # 将代码按行分割
    lines = code.splitlines()
    
    comment_lines = {}
    
    # 遍历每一行
    current_line = 1  # 初始化行号为 1
    for line in lines:
        stripped_line = line.strip()
        if '#' in stripped_line:  # 如果行中包含 #，即为注释
            comment_content = stripped_line.split('#', 1)[1].strip()  # 获取 # 后的内容
            comment_lines[current_line] = comment_content
        current_line += 1  # 跳到下一行
    
    # 使用 AST 解析代码的结构
    tree = ast.parse(code)
    
    for node in ast.walk(tree):
        if isinstance(node, ast.ClassDef):  # 找到类定义
            class_name = node.name
            comments[class_name] = {}
            
            # 遍历类的成员变量并关联注释
            for item in node.body:
                if isinstance(item, ast.Assign):  # 找到赋值语句（类成员变量）
                    for target in item.targets:
                        if isinstance(target, ast.Name):
                            var_name = target.id
                            # 根据行号从注释中获取该成员的注释
                            var_comment = comment_lines.get(item.lineno, None)
                            comments[class_name][var_name] = var_comment if var_comment else "无描述"
    return comments

# 递归遍历并打印对象成员的注释
def _handle_class_doc(var, comments, parent_name=None, is_leaf=False):
    # 获取对象的类名
    class_name = var.__class__.__name__
    class_comment = comments.get(class_name, {})
    
    # 只打印叶子节点的成员
    for member, doc in class_comment.items():
        member_value = getattr(var, member)
        
        if isinstance(member_value, object) and member_value.__class__.__name__ in comments:  # 如果成员是对象
                _handle_class_doc(member_value, comments, f"{parent_name}.{member}", is_leaf=False)
        else:
            # 打印叶子节点（不是对象成员）
            print(f"{parent_name}.{member}: {doc or '无描述'}")
    
def ListVariables():
    """
    列出所有变量
    """
    cur_dir = os.path.dirname( os.path.abspath(__file__));
    with open( os.path.join(cur_dir, 'mw_class.py'), "r", encoding="utf-8") as class_file:
        class_code = class_file.read()
    comments = _extract_comments_from_code(class_code)
    _handle_class_doc(SimulationTime, comments, "SimulationTime")
    _handle_class_doc(MSLVersion, comments, "MSLVersion")
    _handle_class_doc(FMI, comments, "FMI")
    _handle_class_doc(ModelView, comments, "ModelView")
    _handle_class_doc(Integration, comments, "Integration")
    _handle_class_doc(ResultFormat, comments, "ResultFormat")
    _handle_class_doc(LegendLayout, comments, "LegendLayout")
    _handle_class_doc(AxisTitleType, comments, "AxisTitleType")
    _handle_class_doc(LineStyle, comments, "LineStyle")
    _handle_class_doc(LineColor, comments, "LineColor")
    _handle_class_doc(LineThickness, comments, "LineThickness")
    _handle_class_doc(MarkerStyle, comments, "MarkerStyle")
    _handle_class_doc(VerticalAxis, comments, "VerticalAxis")
    _handle_class_doc(PlotFileFormat, comments, "PlotFileFormat")
    _handle_class_doc(Experiment, comments, "Experiment")
    _handle_class_doc(FillPattern, comments, "FillPattern")
    _handle_class_doc(LinePattern, comments, "LinePattern")
    _handle_class_doc(BorderPattern, comments, "BorderPattern")
    _handle_class_doc(ArrowPattern, comments, "ArrowPattern")
    _handle_class_doc(Smooth, comments, "Smooth")
    _handle_class_doc(TextAlignment, comments, "TextAlignment")
    _handle_class_doc(ShapeStyle, comments, "ShapeStyle")
    _handle_class_doc(ShapeType, comments, "ShapeType")
    return
listvariables=ListVariables

@mw_connect_decorator(_MwConnect._process_path)
def ClearAll() -> bool:
    """
    清除系统所有内容，恢复到启动状态。返回是否清除成功
    
    语法
        >>> ClearAll()
    说明
        ClearAll() 软件恢复到启动状态，恢复成功返回True，恢复失败返回False。
    示例
    示例1：软件恢复到启动状态
        加载标准模型库`Modelica 3.2.3`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，随后使用`ClearAll`使软件恢复到启动状态，清除模型浏览器以及仿真浏览器中的内容
        >>> LoadLibrary("Modelica", "3.2.3")
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> ClearAll()
    输入参数
        无参数
    返回值
        `bool`（`True` 或 `False`) ：表示函数执行的成功或失败状态
    另请参阅
        LoadLibrary|SimulateModel
    """
    params = inspect.signature(ClearAll).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ClearAll, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetLicensePath(path:str):
    """
    [deprecated] 设置许可证路径，True 表示应用成功
    
    语法
        >>> SetLicensePath(path)
    说明
        SetLicensePath(path) 用于设置许可证路径。多个路径之间以“ ; ”分割，许可证文件全路径中，不允许有 @ 符号，True表示应用成功。
    示例
    示例1：本地许可证文件格式示例
        文件默认存储在%安装路径%Docs/Interface/Samples/SysplorerAPI文件夹下
        加载本地许可证文件，path为file@ + 许可证路径
        >>> SetLicensePath("file@C:\Program Files\MWORKS\Sysplorer 2025a(day)\Docs\Interface\Samples\SysplorerAPI\License.txt")
        结果：
        > True
    示例2：许可证服务器格式示例
        从服务器加载许可证，path为server@ + 许可证服务器地址
        >>> SetLicensePath("server@|172.16.1.36;172.16.1.37;172.16.1.38")
        结果：
        > True
    输入参数
        path - 指定的使用许可路径
        数据类型：str
    返回值
        错误代码， 0 表示应用成功，其他错误代码按照 Sysplorer 软件补充完毕
    另请参阅
        无
    """
    params = inspect.signature(SetLicensePath).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetLicensePath, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def License(ltype:str, lparams:dict = {}):
    """
    依据传入的ltype进行不同的许可证相关操作
    
    参数列表：
        `ltype`: 操作的类型 ['activate',           激活许可证
                            'deactivate',          移除许可证
                            'device_code',         获取设备码
                            'feature_list',        获取特征项列表       
                            'expired_days',        获取许可证或特征项剩余时间
                            'inuse',               获取当前正在使用的许可模块列表
                            'info']                获取许可证信息               
        `lparams`: 依据ltype传入不同的lparams，
                            ltype = 'activate'：
                                单服务器激活:
                                    {'type':'server','server1':'IP:Port'}
                                主从服务器激活:
                                    {'type':'server','server1':'IP:Port','server2':'IP:Port','server3':'IP:Port'}
                                文件激活:
                                    {'type':'file','path':'许可证文件的绝对路径'}
                                账号激活:
                                    {'type':'account'}
                            ltype = 'deactivate':
                                无需参数
                            ltype = 'device_code':
                                无需参数
                            ltype = 'feature_list':
                                无需参数
                            ltype = 'expired_days':
                                获取基础环境许可证剩余时间:
                                    无需参数
                                获取特定特征项剩余事件:
                                    {'name':'特征项名称'}
                            ltype = 'inuse':
                                无需参数
                            ltype = 'info':
                                无需参数
        详见文档

    函数返回值：
        依据ltype返回不同的结果

    示例：
        >>> eng.License('activate',{'type':'server','server1':'172.16.1.36'})
        True
        >>> eng.License('deactivate')
        True
        >>> eng.License('feature_list')
        ['MW_Sysplr_Standard', ...]

    """
    for key,value in lparams.items():
        if type(value) == int or type(value) == bool or type(value) == str:
            lparams[key] = str(value)
        else:
            _CheckArgTypes('License', value, 'lparams.value', [int, bool, str])
    
    params = inspect.signature(License).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(License, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ChangeDirectory(workDir:str) -> bool:
    """
    设置工作目录，并打印（设置后的）当前目录到命令窗口
    
    语法
        >>> ChangeDirectory(workDir)
    说明
        ChangeDirectory(workDir) 用于设置工作目录，并打印（设置后的）当前目录到命令窗口，如果是空字符串，则显示当前工作目录。
    示例
    示例1：修改工作目录
        将工作目录修改为D:\Result，创建一个模型CarModel，执行保存模型后，由于工作目录修改为D:\Result，所以模型保存在该目录下
        >>> ChangeDirectory(r"D:\Result") 
        >>> NewModel("CarModel")
        >>> SaveModel("CarModel")
    示例2：显示工作目录
        显示当前工作目录
        >>> ChangeDirectory("") 
        结果：
        > 当前目录是“D:\Result” 
    输入参数
        workDir - 工作目录
        数据类型：str
    返回值
        `bool`（`True` 或 `False`) ：表示函数执行的成功或失败状态
    另请参阅
        SaveModel
    """
    if workDir == "":
        return GetDirectory()
    params = inspect.signature(ChangeDirectory).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ChangeDirectory, args=args, kwargs={}, expected_types = expected_types)
cd=ChangeDirectory

@mw_connect_decorator(_MwConnect._process_path)
def GetDirectory():
    """
    获取工作目录
    
    语法
        >>> GetDirectory()
    说明
        GetDirectory() 用于获取工作目录。
    示例
    示例1：获取当前工作目录路径示例
        获取当前工作目录并打印
        >>> print(GetDirectory())
        结果：
        > C:/Users/TR/Documents/MWORKS
    输入参数
        无
    返回值
        `str` : 工作目录
    另请参阅
        无
    """
    params = inspect.signature(GetDirectory).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetDirectory, args=args, kwargs={}, expected_types = expected_types)


@mw_connect_decorator(_MwConnect._process_path)
def ChangeSimResultDirectory(simResultDirectory:str = "", **kwargs) -> bool:
    """
    修改仿真结果目录，并打印（设置后的）结果目录到命令窗口
    
    语法
        >>> ChangeSimResultDirectory(simResultDirectory) 
    说明
        ChangeSimResultDirectory(simResultDirectory) 用于将仿真结果目录更改为此目录，如果是空字符串，则显示当前仿真结果目录
    示例
    示例1：修改仿真结果目录
        将仿真结果工作目录修改为D:\\Result，加载标准模型库`Modelica 3.2.3`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，可以在更改后的仿真结果工作目录中观察到生成了模型的仿真结果
        >>> ChangeSimResultDirectory(r"D:\\Result")
        >>> LoadLibrary("Modelica", "3.2.3")
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
    示例2：显示当前仿真结果目录
        显示当前仿真结果目录
        >>> ChangeSimResultDirectory("")
        结果：
        > 当前目录是“C:/Users/TR/Documents/MWORKS/Simulation”
    输入参数
        simResultDirectory - 仿真结果目录
        数据类型：str
    返回值
        `bool`（`True` 或 `False`) ：表示函数执行的成功或失败状态
    另请参阅
        SimulateModel
    """
    params = inspect.signature(ChangeSimResultDirectory).parameters
    if kwargs != {}:
        valid_kwargs = set(params.keys())
        valid_kwargs.update(["simResultDir"])
        # 判断参数是否传递正确
        for key in kwargs:
            if key in valid_kwargs:
                continue
            raise TypeError(f"ChangeSimResultDirectory() got an unexpected keyword argument '{key}'")
        # 兼容旧版调用
        simResultDirectory = kwargs["simResultDir"]
    if simResultDirectory == "":
        return GetSimResultDirectory()
    params = inspect.signature(ChangeSimResultDirectory).parameters
    args = tuple(v for k, v in locals().items() if k not in ('kwargs'))
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    return _MwConnect.__RunCurrentFunction__(ChangeSimResultDirectory, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetSimResultDirectory():
    """
    获取仿真结果目录
    
    语法
        >>> GetSimResultDirectory()
    说明
        GetSimResultDirectory()用于获取仿真结果目录。
    示例
    示例1：获取当前仿真结果目录路径示例
        获取当前仿真结果目录并打印
        >>> print(GetSimResultDirectory())
        结果：
        > D:\\simulate
    输入参数
        无
    返回值
        `str`:仿真结果目录
    另请参阅
        无
    """
    params = inspect.signature(GetSimResultDirectory).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetSimResultDirectory, args=args, kwargs={}, expected_types = expected_types)


@mw_connect_decorator(_MwConnect._process_path)
def ChangeCacheDirectory(cacheDirectory:str) -> bool:
    """
    设置缓存目录，并打印（设置后的）缓存目录到命令窗口
    
    语法
        >>> ChangeCacheDirectory(cacheDirectory)
    说明
        ChangeCacheDirectory(cacheDirectory)用于设置缓存目录，并打印（设置后的）缓存目录到命令窗口，`cacheDirectory`:  缓存目录更改为此目录，如果是空字符串，则显示当前缓存目录。
    示例
    示例1：更改缓存目录
        更改缓存目录为"C:/Users/TR/Desktop"，显示更改前和更改后的缓存目录。
        >>> print(GetCacheDirectory())
        >>> ChangeCacheDirectory(r"C:/Users/TR/Desktop")
        >>> print(GetCacheDirectory())
        结果：
        > C:\\ProgramData\\MWORKS_Sysplorer_Cache
        > C:/Users/TR/Desktop\\MWORKS_Sysplorer_Cache
    输入参数
        cacheDirectory - 更改的缓存目录
        数据类型：str
    返回值
        `bool`（`True` 或 `False`) ：表示函数执行的成功或失败状态
    另请参阅
        无
    """
    if cacheDirectory == "":
        return GetCacheDirectory()
    params = inspect.signature(ChangeCacheDirectory).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ChangeCacheDirectory, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetCacheDirectory():
    """
    获取缓存目录
    
    语法
        >>> GetCacheDirectory()
    说明
        GetCacheDirectory() 用于获取缓存目录。
    示例
    示例1：获取当前缓存目录路径示例
        获取当前缓存目录并打印
        >>> print(GetCacheDirectory())
        结果：
        > C:\\ProgramData\\MWORKS_Sysplorer_Cache
    输入参数
        无
    返回值
        缓存目录路径
    另请参阅
        无
    """
    params = inspect.signature(GetCacheDirectory).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetCacheDirectory, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetInstallationDirectory():
    """
    获取软件安装目录
    
    语法
        >>> GetInstallationDirectory()
    说明
        GetInstallationDirectory() 用于获取软件安装目录。
    示例
    示例1：获取当前工作目录路径示例
        获取当前工作目录并打印
        >>> print(GetInstallationDirectory())
        结果：
        > C:\Program Files\MWORKS\Sysplorer 2025a
    输入参数
        无
    返回值
        `str` : 工作目录
    另请参阅
        无
    """
    params = inspect.signature(GetInstallationDirectory).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetInstallationDirectory, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetLastErrors():
    """
    获取上一条命令的错误信息，若上一条的命令是正确的，即没有错误信息，将返回空
    
    语法
        >>> GetLastErrors()
    说明
        GetLastErrors() 用于获取上一条命令的错误信息，若上一条的命令是正确的，即没有错误信息，将返回空
    示例
    示例1：存在错误信息时，获取上一条命令的错误信息
        打开一个没有加载的模型`DoublePendulum`，获取上一条命令的错误信息
        >>> OpenModel("DoublePendulum")
        >>> GetLastErrors()
        结果：
        > 模型“DoublePendulum”不存在。
    示例2：不存在错误信息时，获取上一条命令的错误信息
        DoublePendulum.mo模型默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下
        不存在错误信息时，获取上一条命令的错误信息
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo")
        >>> OpenModel("DoublePendulum")
        >>> GetLastErrors()
        结果：
        > 
    输入参数
        无参数
    返回值
        `str` : 上一条错误信息
    另请参阅
        无
    """
    params = inspect.signature(GetLastErrors).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetLastErrors, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetVersion():
    """
    获取软件版本号，并打印
    
    语法
        >>> GetVersion()
    说明
        GetVersion()用于获取软件版本号，并打印。
    示例
    示例1：获取当前软件版本号示例
        获取当前软件版本号，并打印
        >>> print(GetVersion())
        结果：
        > 7.0.0.5350
    输入参数
        无
    返回值
        `str` : 软件版本号
    另请参阅
        无
    """
    params = inspect.signature(GetVersion).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetVersion, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetKernelVersion():
    """
    获取软件内核版本号，并打印
    
    语法
        >>> GetKernelVersion()
    说明
        GetKernelVersion()用于获取软件内核版本号，并打印。
    示例
    示例1：获取当前软件内核版本号示例
        获取当前软件内核版本号，并打印
        >>> print(GetKernelVersion())
        结果：
        > 7.0.0.3866
    输入参数
        无
    返回值
        `str` : 内核版本号
    另请参阅
        无
    """
    params = inspect.signature(GetKernelVersion).parameters
    args = tuple(v for k, v in locals().items() if k not in ('params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetKernelVersion, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetLanguage():
    """
    获取当前系统语言，并打印
    
    语法
        >>> GetLanguage()
    说明
        GetLanguage()用于获取当前系统语言，并打印。
    示例
    示例1：获取当前系统语言示例
        获取当前系统语言，并打印
        >>> print(GetLanguage())
        结果：
        > zh
    输入参数
        无
    返回值
        `str` : 当前系统语言
    另请参阅
        无
    """
    params = inspect.signature(GetLanguage).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetLanguage, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetLanguage(language:str) -> bool:
    """
    设置系统语言
    
    语法
        >>> SetLanguage(language)
    说明
        SetLanguage(language)用于设置系统语言，`language` 表示需要设置的目标语言。
    示例
    示例1：设置系统语言为英文示例
        设置系统语言为英文
        >>> print(SetLanguage("en"))
        >>> print(GetLanguage())
        结果：
        > True
        > en
    输入参数
        language - 要设置的目标语言
        数据类型：str
    返回值
        bool（`True` 或 `False`) ：表示函数执行的成功或失败状态
    另请参阅
        无
    """
    params = inspect.signature(SetLanguage).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetLanguage, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ListOptions():
    """
    打印所有系统首选项
    
    语法
        >>> ListOptions()
    说明
        ListOptions()用于打印所有系统首选项。
    示例
    示例1：打印所有系统首选项
        打印所有系统首选项
        >>> print(ListOptions())
        结果：
        > {
        >     "Environment.General.Language": "en",
        >     "Environment.General.UndoLevels": "50",
        >     "Environment.General.AutomaticallySaveModelBeforeCheck": "True",
        >     "Environment.General.PeriodicallyBackupModel": "True",
        >     "Environment.General.PeriodicallyBackupModelTimeInterval(minute)": "5",
        >     "Environment.ModelicaLibraries.UserLib": "[]",
        >     "Environment.ModelicaLibraries.PreloadUserLib": "[]",
        >     "Environment.ModelicaLibraries.PreBuiltinLibInfo": "['Modelica ','SysplorerEmbeddedCoder ']",
        >     "Environment.SystemPath.WorkingDirectory": "C:/Users/TR/Documents/MWORKS",
        >     "Environment.SystemPath.SimulationResultDirectory": "D:\\\\Projects\\\\automatic_test\\\\7_Code\\\\temps\\\\simulate",
        >     "Environment.SystemPath.SoftwareCacheDirectory": "C:\\\\ProgramData\\\\MWORKS_Sysplorer_Cache",
        >     "Environment.Keyboard.TextEditor.Comment": "Ctrl+K",
        >     "Environment.Keyboard.TextEditor.UnComment": "Ctrl+Shift+K",
        >     "Environment.Keyboard.TextEditor.FoldingAll": "Ctrl+1",
        >     "Environment.Keyboard.TextEditor.ExpandingAll": "Ctrl+3",
        >     "Environment.Keyboard.TextEditor.GotoLine": "Ctrl+G",
        >     "Environment.EnvironmentVariables.Value": "['SYSPLORER_PYPATH=C:/Program Files/MWORKS/Sysplorer 2025a/external/python64']",
        >     "Modeling.ClassBrowser.IconSizeCustom": "20",
        >     "Modeling.ClassBrowser.TreeViewLabels": "Name",
        >     "Modeling.ClassBrowser.ShowProtectedClassesInClassBrowser": "True",
        >     "Modeling.ClassBrowser.ShowReplaceableClassesInClassBrowser": "True",
        >     "Modeling.ClassBrowser.SynchronizeTheModelBrowserItemWhenOpeningTheModelWindow": "False",
        >     "Modeling.ClassBrowser.DoubleClickTheModelToOpenInNewTab": "False",
        >     "Modeling.GraphicsView.ShowComponentNavigationBar": "True",
        >     "Modeling.GraphicsView.ShowScrollBar": "False",
        >     "Modeling.GraphicsView.ShowGrid(OnlyForEditableModels)": "False",
        >     "Modeling.GraphicsView.SnapGrid": "False",
        >     "Modeling.GraphicsView.SnapBorder": "False",
        >     "Modeling.GraphicsView.SnapCenterPoint": "False",
        >     "Modeling.GraphicsView.SnapPort": "False",
        >     "Modeling.GraphicsView.SnapSpacing": "False",
        >     "Modeling.GraphicsView.SnapSize": "False",
        >     "Modeling.GraphicsView.AutomaticallyConnectDuringTheMove": "False",
        >     "Modeling.GraphicsView.AutomaticallyConnectWhenClickPort": "False",
        >     "Modeling.GraphicsView.ConnectAutomaticLayout": "False",
        >     "Modeling.GraphicsView.KeepTheConnectWhenDeleteTheComponentAndFastReconnect": "False",
        >     "Modeling.GraphicsView.HigherQualityTextDisplay": "True",
        >     "Modeling.GraphicsView.HigherQualityBitmapDisplay": "True",
        >     "Modeling.GraphicsView.HigherQualityShapeDisplay": "True",
        >     "Modeling.GraphicsView.RestrictMinimunFontSize": "True",
        >     "Modeling.GraphicsView.StoreImageInModel": "False",
        >     "Modeling.GraphicsView.MinimalUpdateMode": "False",
        >     "Modeling.TextView.FontFamily": "Courier New",
        >     "Modeling.TextView.FontSize": "10",
        >     "Modeling.TextView.KeywordColor": "0,0,255",
        >     "Modeling.TextView.TypeColor": "255,0,0",
        >     "Modeling.TextView.StringColor": "0,128,0",
        >     "Modeling.TextView.NumberColor": "0,128,128",
        >     "Modeling.TextView.CommentColor": "0,128,0",
        >     "Modeling.TextView.OperatorColor": "128,128,0",
        >     "Modeling.TextView.Margin": "32",
        >     "Modeling.TextView.CollapseAnnotationsAsDefault": "True",
        >     "Simulation.General.NumbersOfResultsToKeep": "2",
        >     "Simulation.General.PromptWhenSimulationResultsAreClosed": "False",
        >     "Simulation.General.AutomaticallySaveSimulationResults": "False",
        >     "Simulation.CCompiler.CompilerType": "Built-in-gcc",
        >     "Simulation.CCompiler.CompilerName": "GCC",
        >     'Simulation.CCompiler.VcCompilerNames': ['Microsoft Visual Studio 2010', 'Microsoft Visual Studio 2015', 'Microsoft Visual Studio 2017']
        >     "Simulation.CCompiler.CompilerPathX86": "C:/Program Files/MWORKS/Sysplorer 2025a/Simulator/mingw32",
        >     "Simulation.CCompiler.CompilerPathX64": "C:/Program Files/MWORKS/Sysplorer 2025a/Simulator/mingw64",
        >     "Simulation.Optimization.RuntimeCheck": "False"
        > }
    输入参数
        无
    返回值
        `dict`:包含系统首选项及对应的值
    另请参阅
        无
    """
    params = inspect.signature(ListOptions).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    tempOptions = _MwConnect.__RunCurrentFunction__(ListOptions, args=args, kwargs={}, expected_types = expected_types) 
    res_dict = {}
    for item in tempOptions:
        res_dict[item[0][3:]] = item[2]
        SysOptions[item[0][3:]] = item[1]

    for key ,value in dict.items(res_dict):
        # print(key,value)
        res_value = parsing_data_type(SysOptions,key,value)
        res_dict[key] = res_value
    json_str = json.dumps(res_dict, indent=4, sort_keys=False)
    res = json.loads(json_str)
    # print(res)
    return res

@mw_connect_decorator(_MwConnect._process_path)    
def GetOption(name:str,defaultValue = None):
    """
    获取某个具体首选项的值
    
    语法
        >>> GetOption(name,defaultValue)
    说明
        GetOption(name,defaultValue)用于获取某个具体首选项的值，未获取到时，取默认值，此时将默认值设到系统中。
    示例
    示例1：获取CompilerName的值
        获取CompilerName的值，并设置默认值为GCC
        >>> print(GetOption("Simulation.CCompiler.CompilerName","GCC"))
        结果：
        > GCC
    输入参数
        name - 首选项的名称
        数据类型：str
        defaultValue - 未获取到时，取的默认值
        数据类型：str
    返回值
        目标首选项的值
    另请参阅
        无
    """
    if len(SysOptions) == 0:
        ListOptions()
    if name not in SysOptions:
        print('Error: Invalid key',name)
        return False
    if defaultValue == None:
        defaultValue = ''
    else:
        if type(defaultValue) == int or type(defaultValue) == bool or type(defaultValue) == str or type(defaultValue) == list:
            defaultValue = str(defaultValue)
        else:
            _CheckArgTypes('GetOption', defaultValue, 'defaultValue', [int, bool, str, list])
    params = inspect.signature(GetOption).parameters
    args = tuple(v for k, v in list(locals().items()) if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('defaultValue')] = type(defaultValue)
    cur_val = _MwConnect.__RunCurrentFunction__(GetOption, args=args, kwargs={}, expected_types = expected_types)
    real_val = parsing_data_type(SysOptions,name,cur_val)
    return real_val

@mw_connect_decorator(_MwConnect._process_path)
def SetOption(name:str,value = None) -> bool:
    """
    设置某个具体首选项的值
    
    语法
        >>> SetOption(name,value)
    说明
        SetOption(name,value)用于设置某个具体首选项的值，name表示首选项的名称，value表示目标选项的值，设置成功返回True，失败返回False。
    示例
    示例1：设置CompilerName的值为Microsoft Visual Studio 2017
        设置CompilerName的值为Microsoft Visual Studio 2017
        >>> print(SetOption("Simulation.CCompiler.CompilerName","Microsoft Visual Studio 2017"))
        结果：
        > True
    输入参数
        name - 首选项的名称
        数据类型：str
        value - 目标选项的值
        数据类型：str
    返回值
        `bool`，表示函数执行成功或失败
    另请参阅
        无
    """
    if value == None:
        value = ''
    else:
        if type(value) == int or type(value) == bool or type(value) == str or type(value) == list:
            value = str(value)
        else:
            _CheckArgTypes('SetOption', value, 'value', [int, bool, str, list])
    params = inspect.signature(SetOption).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('value')] = type(value)
    return _MwConnect.__RunCurrentFunction__(SetOption, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def Echo(on : bool = None):
    """
    设置/获取是否打开“反馈每条语句的执行结果”功能，如果不传入参数，则返回当前状态
    
    语法
        >>> Echo(on)
    说明
        Echo(on) 用于设置/获取是否打开“反馈每条语句的执行结果”功能，打开则传入True，关闭则传入False，如果不传入参数，则返回当前状态。
    示例
    示例1：打开和关闭“反馈每条语句的执行结果”功能
        打开“反馈每条语句的执行结果”功能
        >>> print("打开“反馈每条语句的执行结果”功能")
        >>> Echo(on=True)
        >>> LoadLibrary("Modelica")
        >>> SimulateModel("Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum")
        >>> ClearAll()
        >>> print("关闭“反馈每条语句的执行结果”功能")
        >>> Echo(on=False)
        >>> LoadLibrary("Modelica")
        >>> SimulateModel("Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum")
        结果：
        > 打开“反馈每条语句的执行结果”功能
        >
        > True
        > True
        >
        > 关闭“反馈每条语句的执行结果”功能
    示例2：查询“反馈每条语句的执行结果”功能状态
        查询”反馈每条语句的执行结果”功能状态
        >>> print(Echo())
        >>> Echo(on=True)
        >>> print(Echo())
        结果：
        > False
        > True
    输入参数
        on - 设置状态
        数据类型：bool
    返回值
        `bool` : 表示该功能是否开启
    另请参阅
        无
    """
    if not isinstance(on, (bool, type(None))):
        _CheckArgTypes('Echo', on, 'on', [bool])
    if on is None:
        return _MwConnect.get_echo_on()
    else:
        _MwConnect.set_echo_on(on)
        return True

@mw_connect_decorator(_MwConnect._process_path)
def Exit():
    """
    退出Sysplorer，若此时存在修改而未保存的实例或模型时，不会弹出是否保存提示框
    
    语法
        >>> Exit()
    说明
        Exit() 用于退出Sysplorer，若此时存在修改而未保存的实例或模型时，不会弹出是否保存提示框。
    示例
    示例1：退出Sysplorer
        更改工作目录为D:\\Data，新建一个模型`CarModel`后直接退出Sysplorer，此时存在修改而未保存的实例或模型时，不会弹出是否保存提示框，该模型也不会保存
        >>> ChangeDirectory("D:\\Data")
        >>> NewModel("CarModel")
        >>> Exit()
    输入参数
        无参数
    返回值
        `bool` : 表示程序是否正常退出
    另请参阅
        无
    """
    params = inspect.signature(Exit).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(Exit, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetMainLogLevel(level:int) -> bool:
    """
    设置Sysplorer日志的级别，共有如下级别:
        FATAL_LEVEL = 000,
        ERROR_LEVEL = 100,
        WARN_LEVEL = 200,
        NOTICE_LEVEL = 300,
        INFO_LEVEL = 400,
        DEBUG_LEVEL = 500,
        TRACE_LEVEL = 600,
        NOT_SET = 700
    设置低级别时将不会打印高级别的日志
    
    语法
        >>> SetMainLogLevel(600)
    说明
        SetMainLogLevel(level)，用于设置Sysplorer的日志级别
    示例
    示例：设置日志级别为Debug
        >>> SetMainLogLevel(500)
    输入参数
        level - 日志级别
        数据类型：int
    返回值
        `bool` : 是否设置成功
    另请参阅
        无
    """
    params = inspect.signature(SetMainLogLevel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetMainLogLevel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetMainLogWriteMode(mode:int) -> bool:
    """
    设置Sysplorer日志写入模式，共有如下模式：
        ASYNC = 0,
        SYNC = 1
    其中ASYNC为异步写入模式，SYNC为同步写入模式
    语法
        >>> SetMainLogWriteMode(0)
    说明
        SetMainLogWriteMode(mode) 用于设置Sysplorer日志的写入模式。
    示例
    示例：设置写入模式为异步写入模式
        >>> SetMainLogWriteMode(0)
    输入参数
        mode - 写入模式
        数据类型：int
    返回值
        `bool` : 表示程序是否正常退出
    另请参阅
        无
    """
    params = inspect.signature(SetMainLogWriteMode).parameters
    args = tuple(v for k, v in locals().items() if k not in ('params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetMainLogWriteMode, args=args, kwargs={}, expected_types = expected_types)

#--------------------------文件命令-------------------------------
@mw_connect_decorator(_MwConnect._process_path)
def LoadLibrary(libraryName:str = "", libraryVersion:str = MSLVersion.Default, **kwargs) -> bool:
    """
    加载指定模型库
    
    语法
        >>> LoadLibrary(libraryName)
        >>> LoadLibrary(libraryName, libraryVersion)
    说明
        LoadLibrary(libraryName) 用于加载指定模型库libraryName的最新版本。
        LoadLibrary(libraryName, libraryVersion = "") 用于加载指定模型库libraryName的指定libraryVersion 版本。
        模型库指的是安装在MWORKS.Sysplorer 安装目录下的 Library 目录下的包，模型库文件夹的名字以“libraryName libraryVersion ”命名
    示例
    示例1：不指定版本加载Modelice标准库
        加载最新的Modelica标准库
        >>> LoadLibrary("Modelica")
    示例2：指定版本加载Modelica标准库
        加载Modelica 3.2.3 标准库
        >>> LoadLibrary("Modelica", "3.2.3")
    输入参数
        libraryName - 模型库名
        数据类型：str
        libraryVersion - 模型库版本
        数据类型：str
    返回值
        `bool` : 表示模型库是否成功加载
    另请参阅
        无
    """
    # 定义允许参数名
    params = inspect.signature(LoadLibrary).parameters
    if kwargs != {}:
        valid_kwargs = set(params.keys())
        valid_kwargs.update(["libName", "libVersion"])
        # 判断参数是否传递正确
        for key in kwargs:
            if key in valid_kwargs:
                continue
            raise TypeError(f"LoadLibrary() got an unexpected keyword argument '{key}'")
        # 兼容旧版调用
        libraryName = kwargs["libName"]
        libraryVersion = kwargs["libVersion"]

    args = tuple(v for k, v in locals().items() if k not in ('kwargs'))
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    return _MwConnect.__RunCurrentFunction__(LoadLibrary, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], True, GetDirectory, Echo)
def OpenModelFile(path:str, autoReload:bool = True) -> bool:
    """
    加载指定的Modelica模型文件，支持.mol 和.mo文件
    
    语法
        >>> OpenModelFile(path)
        >>> OpenModelFile(path, autoReload)
    说明
        OpenModelFile(path) 加载指定的Modelica模型文件，支持.mol 和.mo文件。
        OpenModelFile(path, autoReload) 加载指定的Modelica模型文件，支持.mol 和.mo文件，并指定加载重复模型时，是否自动重新加载模型。
        默认情况下，不指定autoReload加载重复模型时，会自动重新加载模型。
    示例
    示例1：默认参数加载指定Modelica模型文件
        DoublePendulum.mo默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下
        加载指定的Modelica模型文件，支持.mol 和.mo文件
        >>> OpenModelFile(GetInstallationDirectory() + r"Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo")
    示例2：指定参数加载Modelica模型文件
        加载指定的Modelica模型文件，支持.mol 和.mo文件，并指定加载重复模型时，不自动重新加载模型
        >>> OpenModelFile(GetInstallationDirectory() + r"Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo", autoReload = False)
    输入参数
        path - Modelica模型文件的全路径
        数据类型：str
        autoReload - 已经加载是否自动重新加载
        数据类型：bool
    返回值
        `bool` : 表示模型是否成功打开
    另请参阅
        无
    """
    params = inspect.signature(OpenModelFile).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(OpenModelFile, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['fmuPath'], True, GetDirectory, Echo)
def ImportFMU(fmuPath:str, within:str = "", modelName:str = "") -> bool:
    """
    导入FMU文件，若已经导入过，则自动卸载并重新导入
    
    语法
        >>> ImportFMU(fmuPath) 
        >>> ImportFMU(fmuPath, within)
        >>> ImportFMU(fmuPath, within, modelName)
    说明
        ImportFMU(fmuPath) 用于导入FMU文件，fmuPath为FMU文件的全路径。
        ImportFMU(fmuPath, within) 用于导入FMU文件，fmuPath为FMU文件的全路径，within表示FMU模型要插入的父模型，默认为空，表示插入到顶层。
        ImportFMU(fmuPath, within, modelName) 用于导入FMU文件，fmuPath为FMU文件的全路径，within表示FMU模型要插入的父模型，modelName表示导入的FMU模型名，默认为空，表示由系统设定。
    示例
    示例1：导入FMU文件
        FDoublePendulum.fmu文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下
        加载ExportFMU导出的FMU文件
        >>> ImportFMU(GetInstallationDirectory() + "\\Docs\\Samples\\PythonAPI\\DoublePendulum.fmu") 
    输入参数
        fmuPath - FMU文件全路径
        数据类型：str
        within - 导入的FMU模型要插入的父模型
        数据类型：str
        modelName - 导入的FMU模型名
        数据类型：str
    返回值
        `bool` : 表示导入是否成功
    另请参阅
        无
    """
    params = inspect.signature(ImportFMU).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ImportFMU, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['publishPath'], False, GetDirectory, Echo)
def EncryptClass(className:str, publishPath:str,modelEncryptLevel:dict = {},modelLicenseFeature:dict = {},dependsResourcePaths:list=[],copyResourceInLibrary:bool = True) -> bool:
    """
    发布模型功能
    
    语法
        >>> EncryptClass(className, publishPath)
        >>> EncryptClass(className, publishPath, modelEncryptLevel)
        >>> EncryptClass(className, publishPath, modelEncryptLevel, modelLicenseFeature)
        >>> EncryptClass(className, publishPath, modelEncryptLevel, modelLicenseFeature, dependsResourcePaths)
        >>> EncryptClass(className, publishPath, modelEncryptLevel, modelLicenseFeature, dependsResourcePaths, copyResourceInLibrary)
    示例
    示例1：
        >>> EncryptClass("ModelPublishDemo",r"C:/Users/DELL/Documents/MWorks/ModelPublishDemo_publish_5")
        True
    示例2：
        >>> dic1 = {"ModelPublishDemo":EncryptLevel.default, "ModelPublishDemo.pak1":EncryptLevel.hide}
        >>> dic2 = {"ModelPublishDemo":"MW_Sysplr_Standard"}
        >>> eng.EncryptClass("ModelPublishDemo",r"C:/Users/DELL/Documents/MWorks/ModelPublishDemo_publish_5",modelEncryptLevel = dic1,modelLicenseFeature=dic2)
        True

    输入参数：
        className - 模型名
        数据类型：str
        publishPath -   发布路径
        数据类型：str
        modelEncryptLevel - 模型加密等级
        数据类型：dict
        modelLicenseFeature - 模型加密特征
        数据类型：dict
        dependsResourcePaths - 附加资源路径(当发布的模型为单模型时生效)
        数据类型：list
        copyResourceInLibrary - 是否拷贝资源(当发布的模型为非单模型时生效)
        数据类型：bool
    返回值：
        `bool` : 发布是否成功
    另请参阅
        无
    """

    params = inspect.signature(EncryptClass).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(EncryptClass, args=args, kwargs={}, expected_types=expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], False, GetDirectory, Echo)
def ExportIcon(modelName:str, path:str = "", width = 0, height = 0, **kwargs) -> bool:
    """
    把图标视图导出为图片
    
    语法
        >>> ExportIcon(modelName, path, width, height)
    说明
        ExportIcon(modelName, path, width, height) 用于把模型名为modelName的模型图标视图导出到path路径下，图片长宽根据width和height指定。
    示例
    示例1：图标视图导出为图片
        加载标准模型库`Modelica 3.2.1`，打开模型`Modelica.Blocks.Examples.PID_Controller`，将模型的图标视图生成为40*40像素的图片，导出到D:\\Data下，命名为Icon.png
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> ExportIcon('Modelica.Blocks.Examples.PID_Controller', 'D:\\Data\\Icon.png', 40, 40)
        结果:
        > 可以在对应的文件夹下找到生成的图标文件。
    输入参数
        modelName - 模型全名
        数据类型：str
        path - 图片文件路径
        数据类型：str
        width - 图片宽度，默认为包围盒的大小(400)
        数据类型：int
        height - 图片长度，默认为包围盒的大小(400)
        数据类型：int
    返回值
        `bool` : 表示图片是否成功保存
    另请参阅
        无
    """
    params = inspect.signature(ExportIcon).parameters
    if kwargs != {}:
        valid_kwargs = set(params.keys())
        valid_kwargs.update(["imageFile"])
        # 判断参数是否传递正确
        for key in kwargs:
            if key in valid_kwargs:
                continue
            raise TypeError(f"ExportIcon() got an unexpected keyword argument '{key}'")
        # 兼容旧版调用
        path = kwargs["imageFile"]

    if type(width) == int or type(width) == float:
        width = int(width)
    else:
        _CheckArgTypes('ExportIcon', width, 'width', [int, float])
    if type(height) == int or type(height) == float:
        height = int(height)
    else:
        _CheckArgTypes('ExportIcon', height, 'height', [int, float])

    args = tuple(v for k, v in locals().items() if k not in ('kwargs'))
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    expected_types[list(params.keys()).index('width')] = type(width)
    expected_types[list(params.keys()).index('height')] = type(height)
    return _MwConnect.__RunCurrentFunction__(ExportIcon, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], False, GetDirectory, Echo)
def ExportDiagram(modelName:str, path:str, width = 0, height = 0, **kwargs) -> bool:
    """
    把图形视图导出为图片
    
    语法
        >>> ExportDiagram(modelName, path, width, height)
    说明
        ExportDiagram (modelName, path, width, height) 用于把模型名为modelName的模型图形视图导出到path路径下，图片长宽根据width和height指定。
    示例
    示例1：将图形视图导出为图片
        加载标准模型库`Modelica 3.2.1`，打开模型`Modelica.Blocks.Examples.PID_Controller`，将模型的图形视图生成为400*400像素的图片，导出到D:\\Data下，命名为Diagram.png
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> ExportDiagram("Modelica.Blocks.Examples.PID_Controller", 'D:\\Data\\Diagram.png', 400, 400)
        结果:
        > 可以在对应的文件夹下找到生成的图标文件。
    输入参数
        modelName - 模型全名
        数据类型：str
        path - 图片文件路径
        数据类型：str
        width - 图片宽度，默认为包围盒的大小(400)
        数据类型：int
        height - 图片长度，默认为包围盒的大小(400)
        数据类型：int
    返回值
        `bool` : 表示图片是否成功保存
    另请参阅
        无
    """
    params = inspect.signature(ExportDiagram).parameters
    if kwargs != {}:
        valid_kwargs = set(params.keys())
        valid_kwargs.update(["imageFile"])
        # 判断参数是否传递正确
        for key in kwargs:
            if key in valid_kwargs:
                continue
            raise TypeError(f"ExportDiagram() got an unexpected keyword argument '{key}'")
        # 兼容旧版调用
        path = kwargs["imageFile"]
    if type(width) == int or type(width) == float:
        width = int(width)
    else:
        _CheckArgTypes('ExportDiagram', width, 'width', [int, float])
    if type(height) == int or type(height) == float:
        height = int(height)
    else:
        _CheckArgTypes('ExportDiagram', height, 'height', [int, float])
    args = tuple(v for k, v in locals().items() if k not in ('kwargs'))
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    expected_types[list(params.keys()).index('width')] = type(width)
    expected_types[list(params.keys()).index('height')] = type(height)
    return _MwConnect.__RunCurrentFunction__(ExportDiagram, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['docFile'], False, GetDirectory, Echo)
def ExportDocumentation(modelName:str, docFile:str) -> bool:
    """
    把模型文档信息导出到文件（仅支持导出为htm/html格式）
    
    语法
        >>> ExportDocumentation(modelName, docFile)
    说明
        ExportDocumentation(modelName, docFile) 用于把模型文档信息导出到文件中，指定文件保存路径和名称
    示例
    示例1：把模型文档导出到文件
        加载标准模型库`Modelica 3.2.1`，打开模型`Modelica.Blocks.Examples.PID_Controller`，将模型的模型文档信息导出到D:\\Data下，命名为PID_Controller.html
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> ExportDocumentation("Modelica.Blocks.Examples.PID_Controller", 'D:\\Data\\PID_Controller.html')
        结果:
        > 可以在对应的文件夹下找到生成的图标文件。
    输入参数
        modelName - 模型全名
        数据类型：str
        docFile - 文档文件名
        数据类型：str
    返回值
        `bool` : 表示文档是否成功保存
    另请参阅
        无
    """
    params = inspect.signature(ExportDocumentation).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ExportDocumentation, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['fmuPath'], False, GetDirectory, Echo)
def ExportFMU(modelName:str, fmuType:str = FMI.Type.ModelExchange, fmuVersion:str = FMI.Version.V1, fmuPath:str = "",
                platform:str = FMI.Platform.x86, algo:str = Integration.Dassl, integralStep = 0.002, **kwargs) -> bool:
    """
    将模型导出为FMU
    
    语法
        >>> ExportFMU(modelName)
        >>> ExportFMU(modelName, fmuType)
        >>> ExportFMU(modelName, fmuType, fmuVersion)
        >>> ExportFMU(modelName, fmuType, fmuVersion, fmuPath)
        >>> ExportFMU(modelName, fmuType, fmuVersion, fmuPath, platform)
        >>> ExportFMU(modelName, fmuType, fmuVersion, fmuPath, platform, algo)
        >>> ExportFMU(modelName, fmuType, fmuVersion, fmuPath, platform, algo, integral_step)
    说明
        `ExportFMU(modelName)` 将模型导出为FMU，其余参数按默认值。
        `ExportFMU(modelName, fmuType)` 将模型导出为FMU，并指定FMI类型，其余参数按默认值。
        `ExportFMU(modelName, fmuType, fmuVersion)` 将模型导出为FMU，指定FMI类型，并选择FMI版本，其余参数按默认值。
        `ExportFMU(modelName, fmuType, fmuVersion, fmuPath)` 将模型导出为FMU，指定FMI类型，选择FMI版本，并手动选择FMU文件的保存路径。默认保存路径为工作路径，其余参数按默认值。
        `ExportFMU(modelName, fmuType, fmuVersion, fmuPath, platform)` 将模型导出为FMU，指定FMI类型，选择FMI版本，手动选择FMU文件的保存路径，并选择FMU文件的平台，其余参数按默认值。
        `ExportFMU(modelName, fmuType, fmuVersion, fmuPath, platform, algo)` 将模型导出为FMU，指定FMI类型，选择FMI版本，手动选择FMU文件的保存路径，选择FMU文件的平台，并选择积分算法。
        `ExportFMU(modelName, fmuType, fmuVersion, fmuPath, platform, algo, integral_step)` 将模型导出为FMU，指定FMI类型，选择FMI版本，手动选择FMU文件的保存路径，选择FMU文件的平台，选择积分算法，并选择积分步长，对于定步长算法设置固定积分步长，对于变步长算法设置初始积分步长。
    示例
    示例1：以默认参数导出模型FMU
        加载标准模型库`Modelica 3.2.1`，打开模型`Modelica.Blocks.Examples.PID_Controller`，将模型导出为FMU，其余参数按默认值，默认导出路径为工作目录
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> ExportFMU("Modelica.Blocks.Examples.PID_Controller")
        结果:
        > 可以在对应的文件夹下找到生成的图标文件。
    示例2：指定参数导出模型FMU
        将模型导出FMU，导出的FMI版本为V2，类型为Co-Simulation，平台位数为32位，积分算法为Dassl，积分步长为0.002，保存位置为D:\\Data
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> ExportFMU('Modelica.Blocks.Examples.PID_Controller','cs','2',r'D:\\Data','x86','Dassl',0.002)
        结果:
        > 可以在对应的文件夹下找到生成的图标文件。
    输入参数
        modelName - 模型全名
        数据类型：str

        fmuType - FMI类型
        数据类型：str

        fmuVersion - FMI版本
        数据类型：str
        可选FMI版本如下：
        - **FMI 1.0：**`FMI.Version.V1`，命令中可缩写为`"1"`
        - **FMI 2.0：**`FMI.Version.V2`，命令中可缩写为`"2"`

        fmuPath - FMU文件保存路径
        数据类型：str

        platform - FMI平台
        数据类型：str
        可选FMI平台如下：
        - **32位：**`FMI.Platform.x86`，命令中可缩写为`"x86"`
        - **64位：**`FMI.Platform.x64`，命令中可缩写为`"x64"`

        algo - 积分算法
        数据类型：str
        可选积分算法如下：
        | 积分算法名称                 | 缩写        |
        |-----------------------------|-------------|
        | Integration.Dassl           | Dassl       |
        | Integration.Radau5 | Radau5 |
        | Integration.Dop853 | Dop853 |
        | Integration.Dopri5 | Dopri5 |
        | Integration.Mebdf | Mebdf |
        | Integration.Mebdfi | Mebdfi |
        | Integration.Lsode | Lsode |
        | Integration.Lsodar | Lsodar |
        | Integration.Cvode | Cvode |
        | Integration.Ida | Ida |
        | Integration.Sdirk34 | Sdirk34 |
        | Integration.Esdirk23 | Esdirk23 |
        | Integration.Esdirk34 | Esdirk34 |
        | Integration.Esdirk45 | Esdirk45 |
        | Integration.Euler | Euler |
        | Integration.Rkfix2 | Rkfix2 |
        | Integration.Rkfix3 | Rkfix3 |
        | Integration.Rkfix4 | Rkfix4 |
        | Integration.Rkfix6 | Rkfix6 |
        | Integration.Rkfix8 | Rkfix8 |
        | Integration.lmplicitEuler | lmplicitEuler |
        | Integration.lmplicitTrapezoid | lmplicitTrapezoid |
        | Integration.Custom | Custom |

        integral_step - 积分步长
        数据类型：float
    返回值
        `bool` : 表示模型是否成功导出
    另请参阅
        无
    """
    if type(integralStep) == int or type(integralStep) == float:
        integralStep = float(integralStep)
    else:
        _CheckArgTypes('ExportFMU', integralStep, 'integralStep', [int, float])
    params = inspect.signature(ExportFMU).parameters
    if kwargs != {}:
        valid_kwargs = set(params.keys())
        valid_kwargs.update(["fmiType", "fmiVerision"])
        # 判断参数是否传递正确
        for key in kwargs:
            if key in valid_kwargs:
                continue
            raise TypeError(f"ExportFMU() got an unexpected keyword argument '{key}'")
        # 兼容旧版调用
        fmuType = kwargs["fmiType"]
        fmuVersion = kwargs["fmiVerision"]
    args = tuple(v for k, v in locals().items() if k not in ('kwargs'))
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    expected_types[list(params.keys()).index('integralStep')] = type(integralStep)
    return _MwConnect.__RunCurrentFunction__(ExportFMU, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ExportFMUEx(modelName:str, options:dict = {}) -> bool:
    """
    将模型导出为FMU
    
    语法
        >>> ExportFMUEx(modelName, options)
    说明
        `ExportFMUEx(modelName, options)` 将模型导出为FMU，其余参数按默认值。相比ExportFMU()增加了可设置的选项。
    示例
    示例1：导出模型FMU
        加载标准模型库`Modelica 3.2.1`，打开模型`Modelica.Blocks.Examples.PID_Controller`，将模型导出为FMU，其余参数按默认值，默认导出路径为工作目录
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> ExportFMUEx("Modelica.Blocks.Examples.PID_Controller", {"algorithm" : "Euler","fmiVersion" : "2","exportVars" : ["PI.y", "PI.u_s"],"resourcesPath" : ["D:\\Data\\test.txt", "D:\\Data"]})
        结果:
        > 可以在对应的文件夹下找到生成的FMU文件。
    输入参数
        modelName - 模型全名
        数据类型：str

        options - 导出设置
        数据类型：dict
        **支持的参数(options):**
        | 参数名                                          | 格式  | 示例                                  | 说明                                                         |
        | ----------------------------------------------- | ----- | ------------------------------------- | ------------------------------------------------------------ |
        | fmiVersion                                      | str   | '2'                                   | FMI版本，可选"1"、"2"、"3"，缺省值为"2"                                            |
        | fmiType                                         | str   | 'cs'                                  | FMI类型，可选"cs"、"me"，缺省值为"cs"                                             |
        | platform                                        | str   | 'x64'                                 | FMI平台，32位传"x86"，64位传"x64"，缺省值为"x64"                          |
        | optimizationRuntimeCheck                        | bool  | True                                  | 运行时检查错误，缺省值为true                                    |
        | optimizationDebugInfo                           | bool  | True                                  | 仿真调试信息，缺省值为false                                |
        | algorithm                                       | str   | 'Dassl'                               | 积分算法，缺省值为'Dassl'，具体说明见ExportFMU接口中对参数algo - 积分算法的说明                  |
        | tolerance                                       | float | 0.0001                                | 求解精度，缺省值为0.0001                                  |
        | integralStepSize                                | float | 0.002                                 | 积分步长，缺省值为0.002                                |
        | exportMode                                      | int   | 1                                     | FMU变量导出模式，1为黑盒导出，2为部分导出，3为完整导出，缺省值为3                      |
        | exportParameter                                 | bool  | True                                  | 是否导出可调参量，缺省值为false                                  |
        | exportProtectedVar                              | bool  | True                                  | 是否导出保护变量，缺省值为false                                  |
        | applyToModel                                    | bool  | True                                  | 应用到模型，暂未实现                                      |
        | exportVars                                      | list  | ['PI.y', 'PI.u_s']                    | 要导出的变量名，缺省值为空                                      |
        | resourcesPath                                   | list  | ['D:\\Data\\test.txt', 'D:\\Data']    | 要导出的资源文件/文件夹路径，缺省值为空                                      |
        | exportPath                                      | str   | 'D:\\Data'                            | FMU文件的导出路径，缺省值为工作目录                                      |

    返回值
        `bool` : 表示模型是否成功导出
    另请参阅
        无
    """
    for key, value in options.items():
        if type(value) == int or type(value) == float or type(value) == bool or type(value) == str or type(value) == list:
            options[key] = str(value)
    params = inspect.signature(ExportFMUEx).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ExportFMUEx, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['veristandFile'], False, GetDirectory, Echo)
def ExportVeristand(modelName:str, headFile:str, veristandFile:str) -> bool:
    """
    模型导出为Veristand模型
    
    语法
        >>> ExportVeristand(modelName, headFile, veristandFile)
    说明
        ExportVeristand(modelName, headFile, veristandFile) 用于把模型导出为 Veristand 模型，指定文件保存路径和名称
    示例
    示例1：模型导出为Veristand模型
        加载标准模型库`Modelica 3.2.1`，打开模型`Modelica.Blocks.Examples.PID_Controller`，设置头文件，头文件ModelInterface在Sample文件夹下，将模型导出为Veristand文件，导出文件的全路径为D:\\Data\\PID_Controller.dll
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> ExportVeristand('Modelica.Blocks.Examples.PID_Controller', 'D:\\Sample\\ModelInterface', 'D:\\Data\\PID_Controller.dll')
        结果:
        > 可以在对应的文件夹下找到生成的 Veristand 文件。
    输入参数
        modelName - 模型全名
        数据类型：str
        headFile - 头文件
        数据类型：str
        veristandFile - Veristand模型文件
        数据类型：str
    返回值
        `bool` : 表示是否导出成功
    另请参阅
        无
    """
    params = inspect.signature(ExportVeristand).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ExportVeristand, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def CompareModel(firstModel:str, secondModel:str, isFile:bool) -> bool:
    """
    模型对比
    
    语法
        >>> CompareModel(firstModel, secondModel, isFile)
    说明
        CompareModel(firstModel, secondModel, isFile)
        用于图形化模型对比
    示例
    示例1：对比文件
        >>> CompareModel('D:\\Sample\\CompareModel1.mo', 'D:\\Sample\\CompareModel2.mo', True)
    示例2：对比已加载模型
        >>> CompareModel('TestCompareModel.Model1', 'TestCompareModel.Model2', False)
    输入参数
        firstModel - 模型文件名或模型全名
        数据类型：str
        secondModel - 模型文件名或模型全名
        数据类型：str
        isFile - 对比模型文件还是已加载的模型全名
        数据类型：bool
    返回值
        'bool'：表示是否对比成功
    另请参阅
        无
    """
    params = inspect.signature(CompareModel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(CompareModel, args=args, kwargs={}, expected_types = expected_types)

#--------------------------仿真命令-------------------------------
@mw_connect_decorator(_MwConnect._process_path)
def OpenModel(modelName:str, viewType:str = ModelView.Diagram) -> bool:
    """
    打开模型窗口
    
    语法
        >>> OpenModel(modelName)
        >>> OpenModel(modelName, viewType)
    说明
        OpenModel(modelName) 用于打开模型窗口，默认打开图形视图。
        OpenModel(modelName, viewType) 用于打开模型窗口，viewType指定打开视图类别。
    示例
    示例1：以默认配置打开自建模型
        首先加载标准模型库`Modelica 3.2.1`，随后打开模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，默认打开图形视图
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
    示例2：以文本视图打开自建模型
        首先加载标准模型库`Modelica 3.2.1`，随后打开模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，并设置参数`text`，指定打开文本视图
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum', 'text')
    输入参数
        modelName - 模型全名
        数据类型：str
        
        viewType - 视图类别
        数据类型：str
        | 视图类别 | 描述       |
        | -------- | ---------- |
        | icon | 图标视图 |
        | diagram | 图形视图 |
        | text | 文本视图 |
        | info | 文档视图 |
    返回值
        `bool` : 表示模型窗口是否成功打开
    另请参阅
        无
    """
    params = inspect.signature(OpenModel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(OpenModel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def CheckModel(modelName:str) -> bool:
    """
    检查模型
    
    语法
        >>> CheckModel(modelName)
    说明
        CheckModel(modelName) 用于检查模型。
    示例
    示例1：检查模型
        加载标准模型库，检查模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`
        >>> LoadLibrary("Modelica", "3.2.3")
        >>> CheckModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        结果：
        > ---- 检查模型: Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum ----
        >
        > 正在解析模型...
        > 正在实例化模型...
        >
        > 模型有 0 个错误和 0 个警告.
        > 模型有 1815 个变量和 1815 个方程.
        >
        > 检查模型用时: 00:00:00.216007.
        >
        > ---- 检查完毕 ----
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        检查模型的相关信息
    另请参阅
        无
    """
    params = inspect.signature(CheckModel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(CheckModel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def TranslateModel(modelName:str) -> bool:
    """
    翻译模型
    
    语法
        >>> TranslateModel(modelName)
    说明
        TranslateModel(modelName) 用于翻译模型。
    示例
    示例1：翻译模型
        加载标准模型库`Modelica 3.2.1`，翻译模型Modelica.Blocks.Examples.PID_Controller
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> TranslateModel("Modelica.Blocks.Examples.PID_Controller")
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        翻译模型的相关信息
    另请参阅
        无
    """
    params = inspect.signature(TranslateModel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(TranslateModel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ListCodeGenerationOptions():
    """
    打印 Sysblock 代码生成配置
    
    语法
        >>> ListCodeGenerationOptions()
    说明
        ListCodeGenerationOptions() 用于打印 Sysblock 代码生成配置。
    示例
    示例1：打印 Sysblock 代码生成配置
        打印 Sysblock 代码生成配置
        >>> print(ListCodeGenerationOptions())
        结果：
        > {
        >     "CodeCustom.CodeToProtect": {
        >         "integer_division_by_zero": "bool",
        >         "overflow": "bool"
        >     },
        >     "CodeCustom.DataType": {
        >         "real_as_float": "bool"
        >     },
        >     "CodeCustom.Expand": {
        >         "is_expand": "bool"
        >     },
        >     "CodeCustom.InsertSectionFunctionDeclare": {
        >         "head": "str",
        >         "item_head": "str",
        >         "item_tail": "str",
        >         "tail": "str"
        >     },
        >     "CodeCustom.InsertSectionFunctionDefine": {
        >         "head": "str",
        >         "item_head": "str",
        >         "item_tail": "str",
        >         "tail": "str"
        >     },
        >     "CodeCustom.InsertSectionGlobalVariableDeclare": {
        >         "head": "str",
        >         "item_head": "str",
        >         "item_tail": "str",
        >         "tail": "str"
        >     },
        >     "CodeCustom.InsertSectionGlobalVariableDefine": {
        >         "head": "str",
        >         "item_head": "str",
        >         "item_tail": "str",
        >         "tail": "str"
        >     },
        >     "CodeCustom.InsertSectionInclude": {
        >         "head": "str",
        >         "item_head": "str",
        >         "item_tail": "str",
        >         "tail": "str"
        >     },
        >     "CodeCustom.InsertSectionMacro": {
        >         "head": "str",
        >         "item_head": "str",
        >         "item_tail": "str",
        >         "tail": "str"
        >     },
        >     "CodeCustom.InsertSectionType": {
        >         "head": "str",
        >         "item_head": "str",
        >         "item_tail": "str",
        >         "tail": "str"
        >     },
        >     "CodeDesign.FileOrganization": {
        >         "mode": "str"
        >     },
        >     "CodeDesign.LogicalOperator": {
        >         "logical_operator": "str"
        >     },
        >     "CodeDesign.NamingConventions": {
        >         "max_length": "int"
        >     },
        >     "CodeDesign.NamingRules": {
        >         "function": "str",
        >         "local_variable": "str",
        >         "macro": "str",
        >         "mem_var": "str",
        >         "type": "str"
        >     },
        >     "CodeDesign.NamingStyle": {
        >         "function": "str",
        >         "local_variable": "str",
        >         "macro": "str",
        >         "mem_var": "str",
        >         "type": "str"
        >     },
        >     "CodeOptimization.Array": {
        >         "array_loop_threshold": "int"
        >     },
        >     "CodeOptimization.ModeEnterFunctionChoice": {
        >         "muti_task_mode": "bool",
        >         "whether_to_use_prefix": "bool"
        >     },
        >     "CodeOptimization.ModeEnterFunctionName": {
        >         "initialize": "str",
        >         "step": "str"
        >     },
        >     "CodePlatform.AtomicLength": {
        >         "floating_point": "str",
        >         "integer": "str"
        >     },
        >     "CodePlatform.DataBits": {
        >         "char": "int",
        >         "double": "int",
        >         "float": "int",
        >         "int": "int",
        >         "long": "int",
        >         "long_long": "int",
        >         "pointer": "int",
        >         "ptrdiff_t": "int",
        >         "szie_t": "int"
        >     },
        >     "CodePlatform.OutPath": {
        >         "output": "str"
        >     },
        >     "CodeReplaceAll.DataType": {
        >         "bool": "str",
        >         "char": "str",
        >         "double": "str",
        >         "float": "str",
        >         "int16": "str",
        >         "int32": "str",
        >         "int64": "str",
        >         "int8": "str",
        >         "isTypeReplacement": "bool",
        >         "uint": "str",
        >         "uint16": "str",
        >         "uint32": "str",
        >         "uint64": "str",
        >         "uint8": "str"
        >     },
        >     "CodeReplaceAll.LibFunctionReplacement": {
        >         "standard_c_library": "str"
        >     }
        > }
    输入参数
        无
    返回值
        返回值为字典类型，包含 Sysblock 代码生成配置。
    另请参阅
        无
    """
    params = inspect.signature(ListCodeGenerationOptions).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    my_dict = _MwConnect.__RunCurrentFunction__(ListCodeGenerationOptions, args=args, kwargs={}, expected_types = expected_types)
    return my_dict

@mw_connect_decorator(_MwConnect._process_path)
def GetModelCodeGenerationOptions(modelName:str):
    """
    获取 Sysblock 代码生成配置
    
    语法
        >>> GetModelCodeGenerationOptions(modelName)
    说明
        GetModelCodeGenerationOptions(modelName) 用于获取Sysblock代码生成配置，modelName表示模型全名
    示例
    示例1：获取 Sysblock 代码生成配置
        SysblockModel1 模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下。
        加载模型文件，随后获取SysblockModel1的代码生成配置
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\SysblockModel1.mo")
        >>> print(GetModelCodeGenerationOptions("SysblockModel1"))
        结果：
        >
        {
            "CodeCustom.CodeToProtect": {
                "integer_division_by_zero": false,
                "overflow": false
            },
            "CodeCustom.DataType": {
                "real_as_float": true
            },
            "CodeCustom.Expand": {
                "is_expand": false
            },
            "CodeCustom.InsertSectionFunctionDeclare": {
                "head": "",
                "item_head": "",
                "item_tail": "",
                "tail": ""
            },
            "CodeCustom.InsertSectionFunctionDefine": {
                "head": "",
                "item_head": "",
                "item_tail": "",
                "tail": ""
            },
            "CodeCustom.InsertSectionGlobalVariableDeclare": {
                "head": "",
                "item_head": "",
                "item_tail": "",
                "tail": ""
            },
            "CodeCustom.InsertSectionGlobalVariableDefine": {
                "head": "",
                "item_head": "",
                "item_tail": "",
                "tail": ""
            },
            "CodeCustom.InsertSectionInclude": {
                "head": "",
                "item_head": "",
                "item_tail": "",
                "tail": ""
            },
            "CodeCustom.InsertSectionMacro": {
                "head": "",
                "item_head": "",
                "item_tail": "",
                "tail": ""
            },
            "CodeCustom.InsertSectionType": {
                "head": "",
                "item_head": "",
                "item_tail": "",
                "tail": ""
            },
            "CodeDesign.FileOrganization": {
                "mode": "Compact"
            },
            "CodeDesign.LogicalOperator": {
                "logical_operator": "logical"
            },
            "CodeDesign.NamingConventions": {
                "max_length": 64
            },
            "CodeDesign.NamingRules": {
                "function": "",
                "local_variable": "",
                "macro": "",
                "mem_var": "",
                "type": ""
            },
            "CodeDesign.NamingStyle": {
                "function": "camelCase",
                "local_variable": "camelCase",
                "macro": "camelCase",
                "mem_var": "camelCase",
                "type": "camelCase"
            },
            "CodeOptimization.Array": {
                "array_loop_threshold": 5
            },
            "CodeOptimization.ModeEnterFunctionChoice": {
                "muti_task_mode": false,
                "whether_to_use_prefix": false
            },
            "CodeOptimization.ModeEnterFunctionName": {
                "initialize": "Init",
                "step": "Step"
            },
            "CodePlatform.AtomicLength": {
                "floating_point": "32",
                "integer": "32"
            },
            "CodePlatform.DataBits": {
                "char": 0,
                "double": 0,
                "float": 0,
                "int": 0,
                "long": 0,
                "long_long": 0,
                "pointer": 0,
                "ptrdiff_t": 0,
                "szie_t": 0
            },
            "CodePlatform.OutPath": {
                "output": "D:\\Projects\\SysplorerDoc\\Data"
            },
            "CodeReplaceAll.DataType": {
                "bool": "",
                "char": "",
                "double": "",
                "float": "",
                "int16": "",
                "int32": "",
                "int64": "",
                "int8": "",
                "isTypeReplacement": false,
                "uint": "",
                "uint16": "",
                "uint32": "",
                "uint64": "",
                "uint8": ""
            },
            "CodeReplaceAll.LibFunctionReplacement": {
                "standard_c_library": "C99"
            }
        }
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        模型的 Sysblock 代码生成配置。
    另请参阅
        无
    """
    old_echo = Echo()
    Echo(False)
    check_dict = ListCodeGenerationOptions()
    Echo(old_echo)
    params = inspect.signature(GetModelCodeGenerationOptions).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    my_dict = _MwConnect.__RunCurrentFunction__(GetModelCodeGenerationOptions, args=args, kwargs={}, expected_types = expected_types) 
    if (type(my_dict) == dict):
        for key,value in my_dict.items():
            for key1,value1 in value.items():
                if check_dict[key][key1] == 'bool':
                    my_dict[key][key1] = value1 == 'true'
                if check_dict[key][key1] == 'int':
                    my_dict[key][key1] = int(value1)
        print(json.dumps(my_dict, indent = 4,sort_keys = True))
    return my_dict

@mw_connect_decorator(_MwConnect._process_path)
def SetModelCodeGenerationOptions(modelName:str, options:dict) -> bool:
    """
    设置 Sysblock 代码生成配置
    
    语法
        >>> SetModelCodeGenerationOptions(modelName, options)
    说明
        SetModelCodeGenerationOptions(modelName, options) 用于设置Sysblock代码生成配置，modelName表示模型全名，options表示代码生成配置全文本
    示例
    示例1：设置 Sysblock 代码生成配置
        模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下
        加载SysblockModel1模型文件，设置Sysblock代码生成配置，将输出路径更改为D:\\Data
        >>> LoadLibrary('SysplorerEmbeddedCoder')
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\SysblockModel1.mo")
        >>> option = GetModelCodeGenerationOptions("SysblockModel1")
        >>> option['CodePlatform.OutPath'] = {'output': "D:\\Data"}
        >>> print(SetModelCodeGenerationOptions("SysblockModel1", option))
        结果：
        > True
    输入参数
        modelName - 模型全名
        数据类型：str
        options - 代码生成配置全文本
        数据类型：dict
    返回值
        `bool` : 表示是否设置成功
    另请参阅
        无
    """
    for key,value in options.items():
        if key == 'CodePlatform.DataBits' or key == 'CodeDesign.NamingRules':
            print('Warnning: Option %s is readonly, can not be configured.' % (key))
        for key1,value1 in value.items():
            if type(value1) == int or type(value1) == bool or type(value1) == str:
                options[key][key1] = str(value1)
            else:
                _CheckArgTypes('SetModelCodeGenerationOptions', value1, key + ', ' + key1, [int, bool, str])
    params = inspect.signature(SetModelCodeGenerationOptions).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetModelCodeGenerationOptions, args=args, kwargs={}, expected_types = expected_types)  

@mw_connect_decorator(_MwConnect._process_path)
def GenerateModelCode(modelName:str) -> bool:
    """
    使用模型的代码生成配置进行代码生成
    
    语法
        >>> GenerateModelCode(modelName)
    说明
        GenerateModelCode(modelName) 用于设置使用模型的代码生成配置进行代码生成，modelName表示模型全名。
    示例
    示例1：设置使用模型的代码生成配置进行代码生成
        SysblockModel1模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下。
        加载模型文件，随后获取SysblockModel1的代码生成配置，设置代码生成配置，最后使用模型的代码生成配置进行代码生成。
        >>> LoadLibrary('SysplorerEmbeddedCoder')
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\SysblockModel1.mo")
        >>> option = GetModelCodeGenerationOptions("SysblockModel1")
        >>> SetModelCodeGenerationOptions("SysblockModel1", option)
        >>> print(GenerateModelCode("SysblockModel1"))
        结果：
        > True
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        `bool` : 表示是否操作成功
    另请参阅
        无
    """
    params = inspect.signature(GenerateModelCode).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GenerateModelCode, args=args, kwargs={}, expected_types = expected_types)  

@mw_connect_decorator(_MwConnect._process_path)
def ListSimulationOptions():
    """
    获取所有的仿真设置
    
    语法
        >>> ListSimulationOptions()
    说明
        ListSimulationOptions() 用于获取所有的仿真设置，返回值为所有的仿真设置以及对应参数的类型。
    示例
    示例1：获取所有的仿真设置
        获取所有的仿真设置，返回值为所有的仿真设置以及对应参数的类型。
        >>> print(ListSimulationOptions())
        结果：
        > {'algorithm': 'str', 'compileSolver64': 'int', 'compileStoreProtectedVar': 'bool', 'debugIncludeFunctionCallInErrorMessages': 'bool', 'debugLinearSolution': 'bool', 'debugLoggingDynamicStateSelection': 'bool', 'debugLoggingEventsDuringSimulation': 'bool', 'debugLoggingNormalWarningMessage': 'bool', 'debugMixedIteration': 'bool', 'debugNonlinearIteration': 'bool', 'debugNonlinearSolution': 'bool', 'debugNonlinearStatistic': 'bool', 'debugSingularLinearSolution': 'bool', 'fixedOrInitStepSize': 'float', 'inlineIntegrator': 'bool', 'inlineStepSize': 'bool', 'interval': 'float', 'outputBackupSimulationDataStepInterval(steps)': 'int', 'outputBackupSimulationDataTimeInterval(minutes)': 'int', 'outputContinuePointsTime(s)': 'list', 'outputGenerateStepsOfPointsBeforeSimulationStops': 'int', 'outputGenerateTheContinueSimulationResultFile': 'bool', 'outputGeneratingIsFixedContinueInterval': 'bool', 'outputGeneratingIsSaveBeforeStop': 'bool', 'outputMaximumNumberOfSimulationVariables': 'int', 'outputNumberOfContinuePoints': 'int', 'outputNumberOfResultsToKeep': 'int', 'outputPeriodicallyBackupSimulationResults': 'bool', 'path': 'str', 'pieceWiseStep': 'tuple', 'realtimeSimulationMode': 'int', 'realtimeSlowdownFactor': 'float', 'startTime': 'float', 'steadyStateInitialization': 'bool', 'steadyStateOmitFixedStartOfContinuousVariable': 'bool', 'steadyStateOmitInitialEquationAlgorithm': 'bool', 'steadyStateSearchSettingDetectionTolerance': 'float', 'steadyStateSearchSettingStartTimeForSearching': 'float', 'steadyStateSimulationMode': 'int', 'stopTime': 'float', 'storeDouble': 'bool', 'storeEvent': 'bool', 'tolerance': 'float', 'translationCheckConnection_Strictly': 'bool', 'translationDeduceUnits': 'bool', 'translationEvaluateParametersToReduceModels': 'bool', 'translationGenerateFlat_ModelicaCodeInMofFile': 'bool', 'translationListContinuousTimeStatesSelected': 'bool', 'translationLogInformationWhenDifferentiatingForIndexReduction': 'bool', 'translationLogNonlinearIterationVariableAndTheInitialValue': 'bool', 'translationLogSelectedDefaultInitialConditons': 'bool'}
    输入参数
        无
    返回值
        所有的仿真设置以及对应参数的类型。
    另请参阅
        无
    """
    params = inspect.signature(ListSimulationOptions).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    my_dict = _MwConnect.__RunCurrentFunction__(ListSimulationOptions, args=args, kwargs={}, expected_types = expected_types)   
    for key,value in my_dict.items():
        simOptions[key] = value
    return simOptions

@mw_connect_decorator(_MwConnect._process_path)
def SimulateModelEx(modelName:str,options:dict = {}) -> bool:
    """
    基于设置进行仿真
    
    语法
        >>> SimulateModelEx(modelName,options)
    说明
        SimulateModelEx(modelName,options)用于基于设置进行仿真，相比SimulateModel()增加了可设置的选项。
    示例
    示例1：在 0 ~ 1s 范围仿真模型 DoublePendulum
        加载标准库Modelica，设置开始时间和结束时间，并仿真DoublePendulum模型。
        >>> LoadLibrary("Modelica")
        >>> print(SimulateModelEx("Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum", {'startTime': 0.0,'stopTime': 1.0}))
        结果：
        > True
    示例2：采用积分算法Euler，64位编译，仿真模型 DoublePendulum
        加载标准库Modelica，设置积分算法Euler，64位编译，仿真DoublePendulum模型。
        >>> LoadLibrary("Modelica")
        >>> print(SimulateModelEx("Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum", {"algorithm" : "Euler","compileSolver64" : 1}))
        结果：
        > True
    示例3：使用默认设置仿真模型 DoublePendulum
        加载标准库Modelica，使用默认设置仿真DoublePendulum模型。
        >>> LoadLibrary("Modelica")
        >>> print(SimulateModelEx("Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum"))
        结果：
        > True
    输入参数
        modelName - 模型全名
        数据类型：str

        options - 仿真设置
        数据类型：dict
        **支持的参数(options):**
        | 参数名                                                        | 格式  | 示例                          | 说明                                                         |
        | ------------------------------------------------------------ | ----- | ----------------------------- | ------------------------------------------------------------|
        | algorithm                                                    | str   | 'Dassl'                       | 算法名                                                       |
        | compileSolver64                                              | int   | 1                             | 是否使用64位编译                                              |
        | compileOptions                                               | int   | 1                             | 选择编译策略 (0:仿真效率优先, 1:翻译效率优先, 2: 均衡)          |
        | cCompileWarningMessage                                       | bool  | True                          | C编译选项是否开启警告信息                                     |
        | cCompileAllowSymbolRedef                                     | bool  | True                          | C编译选项是否允许符号重定义                                   |
        | debugIncludeFunctionCallInErrorMessages                      | bool  | True                          | 调试信息-错误信息中包含函数调用环境                            |
        | debugLinearSolution                                          | bool  | True                          | 调试信息-诊断线性求解结果                                     |
        | debugLoggingDynamicStateSelection                            | bool  | True                          | 调试信息-记录动态状态变量选择                                 |
        | debugLoggingEventsDuringSimulation                           | bool  | True                          | 调试信息-记录仿真中的事件                                     |
        | debugLoggingNormalWarningMessage                             | bool  | True                          | 调试信息-记录正常的警告信息                                   |
        | debugMixedIteration                                          | bool  | True                          | 调试信息-记录混合方程迭代过程                                 |
        | debugNonlinearIteration                                      | bool  | True                          | 调试信息-诊断非线性迭代过程                                   |
        | debugNonlinearSolution                                       | bool  | True                          | 调试信息-诊断非线性求解结果                                   |
        | debugNonlinearStatistic                                      | bool  | True                          | 调试信息-诊断非线性统计信息                                   |
        | debugSingularLinearSolution                                  | bool  | True                          | 调试信息-诊断线性奇异解                                       |
        | fixedOrInitStepSize                                          | float | 0.002                         | 固定或初始化积分步长，当算法为定步长算法、离散积分算法时表示固定积分步长，为变步长算法时表示初始积分步长 |
        | inlineIntegrator                                             | bool  | True                          | 内联离散积分步长算法                                         |
        | inlineStepSize                                               | bool  | True                          | 内联积分步长                                                 |
        | interval                                                     | float | 0.002                         | 输出区间长度（-1 表示auto, 仅限Sysblock模型）                 |                      |
        | outputContinuePointsTime(s)  *(not supported)                | list  | [1.0, 2.0]                    | 自定义接续仿真的接续时刻点(暂不支持)                          |
        | outputGenerateStepsOfPointsBeforeSimulationStops             | int   | 10                            | 仿真停止前接续仿真的接续时刻点数量                           |
        | outputGenerateTheContinueSimulationResultFile                | bool  | True                          | 是否生成接续仿真文件                                         |
        | outputGeneratingIsFixedContinueInterval                      | bool  | True                          | 是否生成固定区间的接续时刻点                                 |
        | outputGeneratingIsSaveBeforeStop                             | bool  | True                          | 是否在仿真停止前生成接续时刻点                               |
        | outputMaximumNumberOfSimulationVariables                     | int   | 1000000                       | 最大仿真变量数                                               |
        | outputNumberOfContinuePoints                                 | int   | 10                            | 固定区间的接续时刻点数量                                     |
        | outputNumberOfResultsToKeep                                  | int   | 2                             | 仿真面板上保持的结果数量                                     |                              |
        | Path                                                         | str   | 'D/Smiulation'                | 仿真结果路径                                                 |
        | pieceWiseStep                                                | tuple | ((0.0, 0.001), (1.0, 0.002),) | 分段固定步长                                                 |
        | realtimeSimulationMode                                       | int   | 1                             | 实时仿真模式，0为使用当前仿真模式，1表示自动，2表示实时          |
        | realtimeSlowdownFactor                                       | float | 1.0                           | 实时仿真减速比                                               |
        | startTime                                                    | float | 0.0                           | 仿真开始时间                                                 |
        | steadyStateInitialization                                    | bool  | True                          | 是否使用稳态初始化                                           |
        | steadyStateOmitFixedStartOfContinuousVariable                | bool  | True                          | 是否忽略连续变量的 fixed、start属性                          |
        | steadyStateOmitInitialEquationAlgorithm                      | bool  | True                          | 是否忽略初始化方程算法                                       |
        | steadyStateSearchSettingDetectionTolerance                   | float | 0.0001                        | 稳态查找的容差                                               |
        | steadyStateSearchSettingStartTimeForSearching                | float | 0.1                           | 稳态查找的开始时间                                           |
        | steadyStateSimulationMode                                    | int   | 1                             | 稳态仿真模式，0表示动态仿真，1表示静态仿真，2表示动态稳态查找    |
        | stopTime                                                     | float | 1.0                           | 仿真停止时间                                                 |
        | storeDouble                                                  | bool  | True                          | 是否以双精度保存结果                                         |
        | storeEvent                                                   | bool  | True                          | 是否存储事件时刻变量值                                       |
        | tolerance                                                    | float | 0.0001                        | 精度                                                         |
        | translationCheckConnection_Strictly                          | bool  | True                          | 翻译-严格检查连接                                            |
        | translationDeduceUnits                                       | bool  | True                          | 翻译-自动推导单位                                            |
        | translationEvaluateParametersToReduceModels                  | bool  | True                          | 翻译-参数估值以提升效率                                      |
        | translationGenerateFlat_ModelicaCodeInMofFile                | bool  | True                          | 翻译-生成平坦化Modelica模型到mof文件                         |
        | translationListContinuousTimeStatesSelected                  | bool  | True                          | 翻译-记录所选的连续时间状态变量                              |
        | translationLogInformationWhenDifferentiatingForIndexReduction| bool  | True                          | 翻译-输出指标约简时的微分方程信息                            |
        | translationLogNonlinearIterationVariableAndTheInitialValue   | bool  | True                          | 翻译-记录非线性迭代变量及其初值                              |
        | translationLogSelectedDefaultInitialConditons                | bool  | True                          | 翻译-记录所选的缺省初值条件                                  |
        | optimizationRuntimeCheck                                     | bool  | True                          | 调试-运行时检查错误                                         |
    返回值
        `bool` : 表示是否成功仿真
    另请参阅
        无
    """
    tempOptions = deepcopy(options)
    for key, value in tempOptions.items():
        if type(value) == int or type(value) == float or type(value) == bool or type(value) == str or type(value) == list or type(value) == tuple:
            tempOptions[key] = str(value)
        else:
            _CheckArgTypes('SimulateModelEx', value, key, [int, float, bool, str, list, tuple])
    params = inspect.signature(SimulateModelEx).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params','options'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SimulateModelEx, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def StartSimulate(modelName:str,options:dict = {}) -> bool:
    """
    基于设置进行异步仿真

    语法
        >>> StartSimulate(modelName,options)
    说明
        StartSimulate(modelName,options) 用于基于设置进行异步仿真，`modelName`表示模型全名，`options`表示扩展选项设置，参考SimulateModelEx命令，函数返回值为仿真时的相关信息。
    示例
    示例1：在 0 ~ 1s 范围异步仿真模型 DoublePendulum 
        加载标准模型库Modelica，设置在0 ~ 1s 范围异步仿真模型 DoublePendulum
        >>> LoadLibrary("Modelica")
        >>> print(StartSimulate("Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum",{'startTime': 0.0,'stopTime': 1.0}))
        结果：
        > True
    输入参数
        modelName - 模型全名
        数据类型：str
        options - 代码生成配置全文本
        数据类型：dict
    返回值
        仿真时的相关信息
    另请参阅
        SimulateModelEx
    """
    tempOptions = deepcopy(options)
    for key, value in tempOptions.items():
        if type(value) == int or type(value) == float or type(value) == bool or type(value) == str or type(value) == list or type(value) == tuple:
            tempOptions[key] = str(value)
        else:
            _CheckArgTypes('StartSimulate', value, key, [int, float, bool, str, list, tuple])
    params = inspect.signature(StartSimulate).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params','options'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(StartSimulate, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def PauseSimulate() -> bool:
    """
    暂停仿真
    
    语法
        >>> PauseSimulate()
    说明
        PauseSimulate() 用于配合函数StartSimulate()使用，暂停仿真，暂停成功后，GetSimulationState 的值会成为'Paused'，函数返回True表示成功暂停仿真，False表示暂停失败。
    示例
    示例1：仿真模型 PID_Controller 并暂停
        加载标准模型库Modelica，仿真模型 PID_Controller 并暂停仿真。
        >>> LoadLibrary("Modelica")
        >>> count=0
        >>> for i in range(10):
        >>>     count+=1
        >>>     StartSimulate('Modelica.Blocks.Examples.Filter', {'startTime': 0.0, 'stopTime': 10.0,'realtimeSimulationMode': 2})
        >>>     res = GetSimulationState()
        >>>     if res == 'Running':
        >>>         print(PauseSimulate())
        >>>         print(GetSimulationState())
        >>>         StopSimulate()
        >>>         break
        结果：
        > True
        True
        Paused
    输入参数
        无
    返回值
        `bool` : 表示是否成功暂停仿真
    另请参阅
        StartSimulate | GetSimulationState
    """
    params = inspect.signature(PauseSimulate).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(PauseSimulate, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ResumeSimulate() -> bool:
    """
    恢复仿真
    
    语法
        >>> ResumeSimulate()
    说明
        ResumeSimulate() 用于恢复仿真，配合函数PauseSimulate()使用，只有当GetSimulationState为''Paused''时有效。继续成功后，GetSimulationState的值会成为'Running'
    示例
    示例1：仿真模型 PID_Controller 暂停后继续仿真
        加载标准模型库Modelica，仿真模型 PID_Controller 并暂停仿真，随后继续仿真。
        >>> LoadLibrary("Modelica")
        >>> print(StartSimulate("Modelica.Blocks.Examples.PID_Controller", {'realtimeSimulationMode': 2}))
        >>> print(PauseSimulate())
        >>> print(GetSimulationState())
        >>> print(ResumeSimulate())
        >>> print(GetSimulationState())
        结果：
        > True
        True
        Paused
        True
        Running
    输入参数
        无
    返回值
        `bool` : 表示是否成功恢复仿真
    另请参阅
        PauseSimulate
    """
    params = inspect.signature(ResumeSimulate).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ResumeSimulate, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def StopSimulate(timeout:float = None) -> bool:
    """
    停止仿真，超时时间单位为秒
    
    语法
        >>> StopSimulate()
        >>> StopSimulate(timeout)
    说明
        StopSimulate() 用于停止仿真，停止成功后，GetSimulationState的值会成为'Idle'，配合StartSimulate()或者PauseSimulate()使用，返回True表示停止成功，返回False表示停止失败。
        未传入超时时间时（或超时时间小于0），一直等待仿真停止并于2.5秒后弹出确认是否立即终止的窗口
        传入超时时间时（大于等于0），若停止仿真超时则直接终止仿真不弹窗确认，等于0时相当于KillSimulate
    示例
    示例1：仿真模型 PID_Controller 随后停止仿真
        加载标准模型库Modelica，仿真模型 PID_Controller 并停止仿真。
        >>> LoadLibrary("Modelica")
        >>> print(StartSimulate("Modelica.Blocks.Examples.PID_Controller", {'realtimeSimulationMode': 2}))
        >>> print(StopSimulate())
        >>> print(GetSimulationState())
        结果：
        > True
        True
        Idle
    输入参数
        timeout - 停止仿真的超时时间（单位秒）
        数据类型：float
    返回值
        `bool` : 表示是否成功停止仿真
    另请参阅
        StartSimulate
    """
    if(timeout == None):
        timeout = -1.0
    if type(timeout) == int:
        timeout = float(timeout)
    params = inspect.signature(StopSimulate).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(StopSimulate, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ResimulateCurrentResult(options:dict = {}) -> bool:
    """
    重新仿真当前结果
    
    语法
        >>> ResimulateCurrentResult(option)
    说明
        ResimulateCurrentResult(option) 用于以仿真设置 option 重新仿真当前结果，当 option 为空时，以当前结果的仿真设置重新仿真。
        该命令为同步命令，仿真结束后，该命令才会返回。
        注意：
        - 若当前结果的算法是离散求解算法（如 InlinelmplicitEuler 或 InlinelmplicitTrapezoid）时，则仅允许修改仿真时间；
        - 若当前结果的算法不是离散求解算法，则不允许切换为离散求解算法。
    示例
    示例1：以当前结果的仿真设置仿真当前结果
        不传 option 参数，可以以当前结果本身的仿真设置重新仿真
        >>> ResimulateCurrentResult()
    示例2：修改仿真结束时间与仿真算法并重新仿真
        设置新的仿真停止时间为10s，仿真算法为 Euler，重新仿真
        option = {'stopTime': 1.0, 'algorithm':'Euler'}
        >>> ResimulateCurrentResult(option)
    示例3：修改可调参数的值，然后重新仿真
        配合 SetInitialValue 命令，可以修改可调参数的值，然后重新仿真.
        当前结果为PID_Controller 模型的仿真结果，修改参数 driveAngle 的值为 2 弧度，然后重新仿真
        SetInitialValue("driveAngle", 2)
        ResimulateCurrentResult()
    输入参数
        option - 仿真设置
        数据类型 dict
        **支持的参数(options):**
        | 参数名                                                       | 格式  | 示例                           | 说明                                                         |
        | ------------------------------------------------------------ | ----- | ----------------------------- | ------------------------------------------------------------ |
        | algorithm                                                    | str   | 'Dassl'                       | 算法名                                                        |
        | fixedOrInitStepSize                                          | float | 0.002                         | 固定或初始化积分步长，当算法为定步长算法、离散积分算法时表示固定积分步长，为变步长算法时表示初始积分步长 |
        | interval                                                     | float | 0.002                         | 输出区间长度（不可设为-1）                                     |
        | pieceWiseStep                                                | tuple | ((0.0, 0.001), (1.0, 0.002),) | 分段固定步长                                                  |
        | startTime                                                    | float | 0.0                           | 仿真开始时间                                                  |
        | stopTime                                                     | float | 1.0                           | 仿真停止时间                                                  | 
        | tolerance                                                    | float | 0.0001                        | 精度                                                         |
        
    返回值
        `bool` : 表示是否仿真成功
    另请参阅
        SetInitialValue
    """
    tempOptions = deepcopy(options)
    for key, value in tempOptions.items():
        if type(value) == int or type(value) == float or type(value) == bool or type(value) == str or type(value) == list or type(value) == tuple:
            tempOptions[key] = str(value)
        else:
            _CheckArgTypes('ResimulateCurrentResult', value, key, [int, float, bool, str, list, tuple])
    params = inspect.signature(ResimulateCurrentResult).parameters
    args = tuple(v for k, v in locals().items() if k not in ('params','options'))
    expected_types = [v.annotation for k, v in params.items()]
    return _MwConnect.__RunCurrentFunction__(ResimulateCurrentResult, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetSimulationExitState():
    """
    获取仿真的退出状态
    
    语法
        >>> GetSimulationExitState()
    说明
        GetSimulationExitState() 用于获取仿真的退出状态，正常退出为0，用户主动停止为1，仿真失败为2，未知错误为-1。
    示例
    示例1：仿真模型 PID_Controller 并获取仿真的退出状态
        加载标准模型库Modelica，仿真模型 PID_Controller ，随后获取仿真的退出状态。
        >>> LoadLibrary("Modelica")
        >>> print(StartSimulate("Modelica.Blocks.Examples.PID_Controller", {'realtimeSimulationMode': 2}))
        >>> print(GetSimulationExitState())
        结果：
        > 0
    输入参数
        无
    返回值
        `int` : 表示仿真的退出状态
    另请参阅
        无
    """
    params = inspect.signature(GetSimulationExitState).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetSimulationExitState, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetCurrentSimTime():
    """
    获取当前仿真时刻
    
    语法
        >>> GetCurrentSimTime()
    说明
        GetCurrentSimTime() 用于获取当前仿真时刻，非仿真状态下，返回上一次仿真的停止时间，若尚未进行过仿真，则会返回NONE配合StartSimulate()函数，并加入实时仿真配置使用。
    示例
    示例1：仿真模型 PID_Controller 并获取当前仿真时刻
        加载标准模型库Modelica，仿真模型 PID_Controller ，获取当前仿真时刻。
        >>> LoadLibrary("Modelica")
        >>> print(SimulateModel("Modelica.Blocks.Examples.PID_Controller"))
        >>> print(GetCurrentSimTime())
        结果：
        > True
        4.0
    输入参数
        无
    返回值
        `int`类型，表示当前仿真的时刻
    另请参阅
        无
    """
    params = inspect.signature(GetCurrentSimTime).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetCurrentSimTime, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def GetSimulationState():
    """
    获取当前的仿真状态
    
    语法
        >>> GetSimulationState()
    说明
        GetSimulationState() 用于获取当前的仿真状态，包括 'Idle' ，'Running' ，'Paused' 三种状态 。
    示例
    示例1：仿真模型 PID_Controller 并获取当前仿真状态
        加载标准模型库Modelica，仿真模型 PID_Controller ，获取当前仿真状态，由于是在SimulateModel之后运行，所以结果是Idle，表示空闲状态。
        >>> LoadLibrary("Modelica")
        >>> print(SimulateModel("Modelica.Blocks.Examples.PID_Controller"))
        >>> print(GetSimulationState())
        结果：
        > True
        Idle
    输入参数
        无
    返回值
        `str` : 表示当前的仿真状态
    另请参阅
        无
    """
    params = inspect.signature(GetSimulationState).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetSimulationState, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetWatchVariables(vars: list) -> bool:
    """
    设置要实时通信的监视变量
    
    语法
        >>> SetWatchVariables(vars)
    说明
        SetWatchVariables(vars) 用于设置要通知的监视变量，在 TranslateModel 之后、StartSimulate 前调用 SetWatchVariables，则在仿真过程中会循环调用通过 RegisterHandleVarsCBFunction 注册的 handle 函数，以通知仿真数据
    示例
    示例1：设置 PID_Controller 的监视变量 PI.u_m 和 PI.u_s
        首先写一个用来处理数据的函数 SaveSimData。注意：在命令行中使用 Shift + 回车进行换行
        >>> import pandas as pd
        >>> import os
        >>> def SaveSimData(vars: list, last_vars, user_data):
        ..>     if len(last_vars) == 0:
        ..>         return
        ..>     times = last_vars[0]
        ..>     if len(times) == 0:
        ..>         return
        ..>     # 本函数的功能是将数据写入到文件，注册的时候传的是一个路径
        ..>     if type(user_data) != str:
        ..>         return
        ..>     # 默认为列主模式，转置为行主模式
        ..>     df = pd.DataFrame(last_vars).T
        ..>     header = vars
        ..>     # 仅在第一次写入时（文件不存在时）写入标题
        ..>     df.to_csv(user_data, mode='a', index=False, header=header if not os.path.exists(user_data) else False)
        然后加载标准模型库 Modelica，设置监视变量 PI.u_m 和 PI.u_s，注册 SaveSimData 函数，仿真模型 PID_Controller。
        >>> LoadLibrary('Modelica')
        >>> TranslateModel('Modelica.Blocks.Examples.PID_Controller')
        >>> SetWatchVariables(['PI.u_m', 'PI.u_s'])
        >>> RegisterHandleVarsCBFunction(SaveSimData, GetDirectory() + r'\WatchVars.csv')
        >>> OpenHandleVarsCBFunction()
        >>> StartSimulate('Modelica.Blocks.Examples.PID_Controller')
        待仿真完成后，关闭回调函数的调用以节省内存和CPU资源
        >>> CloseHandleVarsCBFunction()
        结果：
        工作目录下的WatchVars.csv文件中保存了仿真数据
        
    输入参数
        vars - 要实时通信的监视变量
        数据类型 list
        vars 的元素形式为变量全名的字符串
    返回值
        `bool` : 表示是否成功设置
    另请参阅
        RegisterHandleVarsCBFunction|OpenHandleVarsCBFunction|CloseHandleVarsCBFunction
    """
    if type(vars) is not list:
        _CheckArgTypes('SetWatchVariables', vars, 'vars', [list])
    for i in range(len(vars)):
        var = vars[i]
        if type(var) is not str:
            _CheckArgTypes('SetWatchVariables', var, 'vars[]', [str])
    params = inspect.signature(SetWatchVariables).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    res = _MwConnect.__RunCurrentFunction__(SetWatchVariables, args=args, kwargs={}, expected_types = expected_types)
    # TODO：暂时使用以下方法，后续可能完善
    if _MwConnect.lastMessageType != 0:
        substring = ': ' 
        substring_ch = '： '
        if substring in _MwConnect.messageText:
            not_found_vars_str = _MwConnect.messageText.split(substring)[-1]
            not_found_vars = not_found_vars_str.split(', ')
            for not_found_var in not_found_vars:
                if not_found_var in vars:
                    vars.remove(not_found_var)
        elif substring_ch in _MwConnect.messageText:
            not_found_vars_str = _MwConnect.messageText.split(substring_ch)[-1]
            not_found_vars = not_found_vars_str.split(', ')
            for not_found_var in not_found_vars:
                if not_found_var in vars:
                    vars.remove(not_found_var)
    _MwAniListener.SetWatchVariables(vars)
    return res

@mw_connect_decorator(_MwConnect._process_path)
def RegisterHandleVarsCBFunction(handle, userdata: any = None):
    """
    注册实时处理数据的函数
    
    语法
        >>> RegisterHandleVarsCBFunction(handle, userdata)
    
    说明
        RegisterHandleVarsCBFunction(handle, userdata) 用来注册处理通知数据的函数，在 TranslateModel 之后、StartSimulate 前调用 SetWatchVariables，则在仿真过程中会循环调用通过 RegisterHandleVarsCBFunction 注册的 handle 函数，以通知仿真数据
    
    示例
    示例1：设置 PID_Controller 的监视变量 PI.u_m 和 PI.u_s
        首先写一个用来处理数据的函数 SaveSimData。注意：在命令行中使用 Shift + 回车进行换行
        >>> import pandas as pd
        >>> import os
        >>> def SaveSimData(vars: list, last_datas, userdata):
        ..>     if len(last_datas) == 0:
        ..>         return
        ..>     times = last_datas[0]
        ..>     if len(times) == 0:
        ..>         return
        ..>     # 本函数的功能是将数据写入到文件，注册的时候传的是一个路径
        ..>     if type(userdata) != str:
        ..>         return
        ..>     # 默认为列主模式，转置为行主模式
        ..>     df = pd.DataFrame(last_datas).T
        ..>     header = vars
        ..>     # 仅在第一次写入时（文件不存在时）写入标题
        ..>     df.to_csv(userdata, mode='a', index=False, header=header if not os.path.exists(userdata) else False)
        然后加载标准模型库 Modelica，设置监视变量 PI.u_m 和 PI.u_s，注册 SaveSimData 函数，仿真模型 PID_Controller。
        >>> LoadLibrary('Modelica')
        >>> TranslateModel('Modelica.Blocks.Examples.PID_Controller')
        >>> SetWatchVariables(['PI.u_m', 'PI.u_s'])
        >>> RegisterHandleVarsCBFunction(SaveSimData, GetDirectory() + r'\WatchVars.csv')
        >>> OpenHandleVarsCBFunction()
        >>> StartSimulate('Modelica.Blocks.Examples.PID_Controller')
        待仿真完成后，关闭回调函数的调用以节省内存和CPU资源
        >>> CloseHandleVarsCBFunction()
        结果：
        工作目录下的WatchVars.csv文件中保存了仿真数据
        
    输入参数
        handle - 处理通知数据的回调函数
        数据类型 function
        handle 函数的格式为：
        handle(vars: list, last_datas, userdata)
        其中，
        vars 为 list[str]，表示变量列表。其值为 SetWatchVariables 函数设置的通知变量的变量名列表，并在第一个元素插入 'time'
        last_datas 为 float 二维数组，表示从上一次处理到本次处理期间的仿真数据。其值为列主数据，即每个元素为某个变量在这一时间段内的所有数据，变量顺序与 vars 一致
        userdata 为任意类型，表示用户数据。其值来自于 RegisterHandleVarsCBFunction 注册时传入的自定义数据
        
        userdata - 传给回调函数的自定义数据
        数据类型为任意
        用于将外部的数据传到回调函数中
        
    另请参阅
        SetWatchVariables|OpenHandleVarsCBFunction|CloseHandleVarsCBFunction
    """
    _MwAniListener.SetHandle(handle, userdata)

@mw_connect_decorator(_MwConnect._process_path)
def OpenHandleVarsCBFunction():
    """
    开启实时获取仿真结果回调函数的调用，仿真前调用
    另请参阅
        RegisterHandleVarsCBFunction
    """
    _MwAniListener.OpenCallback()

@mw_connect_decorator(_MwConnect._process_path)
def CloseHandleVarsCBFunction():
    """
    关闭实时获取仿真结果回调函数的调用，仿真停止后调用
    另请参阅
        RegisterHandleVarsCBFunction
    """
    _MwAniListener.CloseCallback()

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], False, GetDirectory, Echo)
def SimulateModel(modelName:str, startTime:float = None, stopTime:float = None,
    interval:float = None, tolerance:float = None, algo:str = None , integralStep:float = None,
    storeDouble:bool = None, storeEvent:bool = None, simMode:int = None, isPieceWiseStep:bool = None, path:str = "",
    pieceWiseStep:tuple = None,**kwargs) -> bool:
    """
    仿真模型
    
    语法
        >>> SimulateModel(modelName)
        >>> SimulateModel(modelName, startTime, stopTime,
        >>>     interval, tolerance, algo, integralStep,
        >>>     storeDouble, storeEvent, simMode, isPieceWiseStep, path,
        >>>     pieceWiseStep)
    说明
        SimulateModel(modelName) 用于以默认设置仿真模型。modelName 为仿真模型名称必须指定。
        SimulateModel(modelName, startTime, stopTime, interval, tolerance, algo, integralStep,
            storeDouble, storeEvent, simMode, isPieceWiseStep, path, pieceWiseStep) 
        用于仿真模型，参数modelName必须指定，其余参数可按默认值。
    示例
    示例1：Dassl算法仿真模型并保存结果
        加载标准模型库`Modelica 3.2.1`，仿真模型`Modelica.Blocks.Examples.PID_Controller`，选用Dassl算法，将实例文件生成在D:\\Data文件夹下，不使用分段固定积分步长，其余仿真设置采用缺省设置，即：仿真开始时间为0，结束时间为1，输出步数为500，精度为0.0001，积分步长为0.002，结果保存为Float精度，不保存事件点。
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel(modelName="Modelica.Blocks.Examples.PID_Controller", algo="Dassl", path=r"D:\\Data", isPieceWiseStep=False)
        可以在Sysplorer中打开相关曲线图：
    示例2：Euler算法仿真模型并保存结果
        加载标准模型库`Modelica 3.2.1`，仿真模型`Modelica.Blocks.Examples.PID_Controller`，选用Euler算法，将实例文件生成在D:\\Data文件夹下，使用分段固定积分步长[0, 0.001]，其余仿真设置采用缺省设置，即：仿真开始时间为0，结束时间为1，输出步数为500，精度为0.0001，积分步长为0.002，结果保存为Float精度，不保存事件点。
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel(modelName="Modelica.Blocks.Examples.PID_Controller", algo="Euler", path="D:\\Data", isPieceWiseStep=True, pieceWiseStep=((0, 0.001), ))
        可以在Sysplorer中打开相关曲线图：
    输入参数
        modelName - 模型名
        数据类型：str

        startTime - 仿真开始时间
        数据类型：float

        stopTime - 仿真终止时间
        数据类型：float

        interval - 输出区间长度
        数据类型：float

        algo - 积分算法
        数据类型：str
        可选变量如下：
        - Integration.Dassl: 积分算法:Dassl,命令中可缩写为"Dassl"
        - Integration.Radau5: 积分算法:Radau5,命令中可缩写为"Radau5"
        - Integration.Dop853: 积分算法:Dop853,命令中可缩写为"Dop853"
        - Integration.Dopri5: 积分算法:Dopri5,命令中可缩写为"Dopri5"
        - Integration.Mebdf: 积分算法:Mebdf,命令中可缩写为"Mebdf"
        - Integration.Mebdfi: 积分算法:Mebdfi,命令中可缩写为"Mebdfi"
        - Integration.Lsode: 积分算法:Lsode,命令中可缩写为"Lsode"
        - Integration.Lsodar: 积分算法:Lsodar,命令中可缩写为"Lsodar"
        - Integration.Cvode: 积分算法:Cvode,命令中可缩写为"Cvode"
        - Integration.Ida: 积分算法:Ida,命令中可缩写为"Ida"
        - Integration.Sdirk34: 积分算法:Sdirk34,命令中可缩写为"Sdirk34"
        - Integration.Esdirk23: 积分算法:Esdirk23,命令中可缩写为"Esdirk23"
        - Integration.Esdirk34: 积分算法:Esdirk34,命令中可缩写为"Esdirk34"
        - Integration.Esdirk45: 积分算法:Esdirk45,命令中可缩写为"Esdirk45"
        - Integration.Euler: 积分算法:Euler,命令中可缩写为"Euler"
        - Integration.Rkfix2: 积分算法:Rkfix2,命令中可缩写为"Rkfix2"
        - Integration.Rkfix3: 积分算法:Rkfix3,命令中可缩写为"Rkfix3"
        - Integration.Rkfix4: 积分算法:Rkfix4,命令中可缩写为"Rkfix4"
        - Integration.Rkfix6: 积分算法:Rkfix6,命令中可缩写为"Rkfix6"
        - Integration.Rkfix8: 积分算法:Rkfix8,命令中可缩写为"Rkfix8"
        - Integration.lmplicitEuler: 积分算法:lmplicitEuler,命令中可缩写为"lmplicitEuler"
        - Integration.lmplicitTrapezoid: 积分算法:lmplicitTrapezoid,命令中可缩写为"lmplicitTrapezoid"
        - Integration.Custom: 积分算法:Custom,命令中可缩写为"Custom" 

        integralStep - 初始积分步长
        数据类型：float

        storeDouble - 结果是否存为双精度
        数据类型：bool

        storeEvent - 是否存储事件时刻的变量值
        数据类型：bool

        simMode - 设置仿真模式，0为使用当前仿真模式，1为独立仿真，2为实时仿真
        数据类型：int

        isPieceWiseStep - 是否使用分段固定积分步长
        数据类型：bool

        path - 仿真结果文件存放的文件夹路径
        数据类型：str

        pieceWiseStep - 设置某段时间节点采用的积分步长。pieceWiseStep = ((0, xxx), (m, xxx), (n, xxx), ...), pieceWiseStep以二维数组表示，第一个数为时间节点，"xxx"为从当前时间节点开始的步长。
        数据类型：tuple
    返回值
        `bool` : 表示是否仿真成功
    另请参阅
        无
    """
    if startTime:
        if type(startTime) == int or type(startTime) == float:
            startTime = float(startTime)
        else:
            return False

    if stopTime: 
        if type(stopTime) == int or type(stopTime) == float:
            stopTime = float(stopTime)
        else:
            return False

    if interval:
        if type(interval) == int or type(interval) == float:
            interval = float(interval)
        else:
            return False

    if tolerance:
        if type(tolerance) == int or type(tolerance) == float:
            tolerance = float(tolerance)
        else:
            return False

    if integralStep:
        if type(integralStep) == int or type(integralStep) == float:
            integralStep = float(integralStep)
        else:
            return False

    if simMode:
        if type(simMode) == int or type(simMode) == float:
            simMode = int(simMode)
        else:
            return False

    params = inspect.signature(SimulateModel).parameters
    if kwargs != {}:
        valid_kwargs = set(params.keys())
        valid_kwargs.update(["resultFile"])
        # 判断参数是否传递正确
        for key in kwargs:
            if key in valid_kwargs:
                continue
            raise TypeError(f"SimulateModel() got an unexpected keyword argument '{key}'")
        # 兼容旧版调用
        path = kwargs["resultFile"]

    args = tuple(v for k, v in locals().items() if k not in ('kwargs', 'params','ModelExperiment','numberOfIntervals','oldEcho'))
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    expected_types[list(params.keys()).index('startTime')] = type(startTime)
    expected_types[list(params.keys()).index('stopTime')] = type(stopTime)
    expected_types[list(params.keys()).index('interval')] = type(interval)
    expected_types[list(params.keys()).index('algo')] = type(algo)
    expected_types[list(params.keys()).index('tolerance')] = type(tolerance)
    expected_types[list(params.keys()).index('integralStep')] = type(integralStep)
    expected_types[list(params.keys()).index('simMode')] = type(simMode)
    return _MwConnect.__RunCurrentFunction__(SimulateModel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetPauseTimeForSimulation(pauseTime:float = None)-> bool:
    """
    仿真模型
    
    语法
        >>> SetPauseTimeForSimulation()
        >>> SetPauseTimeForSimulation(pauseTime)
    说明
        SetPauseTimeForSimulation() 用于清空仿真暂停时间设置。
        SetPauseTimeForSimulation(pauseTime) 用于设置仿真暂停时间。
    示例
    示例1：设置仿真暂停时间
        加载标准模型库`Modelica 3.2.1`，仿真模型`Modelica.Blocks.Examples.PID_Controller`
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SetPauseTimeForSimulation(pauseTime=1.0)
        >>> SimulateModel(modelName="Modelica.Blocks.Examples.PID_Controller", stopTime=4.0)
        模型将会在仿真到 1 秒时暂停仿真

    输入参数
        pauseTime - 暂停时间
        数据类型: float
        
    返回值
        `bool` : 表示是否设置成功
    另请参阅
        无
    """
    
    if pauseTime:
        if type(pauseTime) == int or type(pauseTime) == float:
            pauseTime = float(pauseTime)
        else:
            return False
        
    params = inspect.signature(SetPauseTimeForSimulation).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetPauseTimeForSimulation, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def RemoveResults() -> bool:
    """
    移除所有结果
    
    语法
        >>> RemoveResults()
    说明
        RemoveResults() 用于清除所有实例，包括未保存的。
    示例
    示例1：加载两个模型仿真并清除所有仿真结果
        先加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，再加载模型`Modelica.Blocks.Examples.PID_Controller`并仿真，随后清除所有实例，包括未保存的
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> SimulateModel('Modelica.Blocks.Examples.PID_Controller')
        >>> RemoveResults()
        结果：
        > 可以在仿真浏览器中看到，所有仿真结果被清除。
    输入参数
        无参数
    返回值
        `bool` : 表示是否清除成功
    另请参阅
        SimulateModel
    """
    params = inspect.signature(RemoveResults).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(RemoveResults, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def RemoveResult() -> bool:
    """
    移除最后一个仿真结果，不保存，也不询问用户
    
    语法
        >>> RemoveResult()
    说明
        RemoveResult() 用于移除最后一个仿真结果，不保存，也不询问用户。
    示例
    示例1：仿真两个模型，移除最后一个仿真的结果
        先加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，再加载模型`Modelica.Blocks.Examples.PID_Controller`并仿真，随后移除最后一个仿真结果，不保存，也不询问用户
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> SimulateModel('Modelica.Blocks.Examples.PID_Controller')
        >>> RemoveResult()
        结果：
        > 可以在仿真浏览器中看到，最后一个仿真结果被移除。
    输入参数
        无参数
    返回值
        `bool` : 表示是否清除成功
    另请参阅
        SimulateModel
    """
    params = inspect.signature(RemoveResult).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(RemoveResult, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], True, GetDirectory, Echo)
def OpenResult(path:str) -> bool:
    """
    打开已有的仿真结果
    
    语法
        >>> OpenResult(path)
    说明
        OpenResult(path)用于打开已有的仿真结果文件，需包含Result.msr
    示例
    示例1：打开已有的仿真结果
        Result.msr文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下。
        给出包含Result.msr文件的路径，打开仿真结果文件
        >>> OpenResult(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Result.msr\\Result.msr")
    输入参数
        path - 结果文件路径
        数据类型：str
    返回值
        `bool` : 表示是否打开成功
    另请参阅
        无
    """
    params = inspect.signature(OpenResult).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(OpenResult, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetResultVariables(varType:int):
    """
    获取结果中的变量列表
    
    语法
        >>> GetResultVariables(varType)
    说明
        GetResultVariables(varType) 用于获取结果中的变量列表，varType控制获取的变量类型，为0则获取所有变量，为1则获取所有参量，为2则获取所有时变变量，为3则获取所有状态变量
    示例
    示例1：获取所有变量
        加载标准模型库`Modelica 3.2.3`，以视图模式打开模型`Modelica.Blocks.Examples.PID_Controller`，仿真模型，获取所有变量
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel("Modelica.Blocks.Examples.PID_Controller")
        >>> print(GetResultVariables(0))
        结果：
        > ['driveAngle', 'PI.u_s', 'PI.u_m', 'PI.y', 'PI.controlError', 'PI.controllerType', 'PI.k', 'PI.Ti', 'PI.Td', 'PI.yMax', 'PI.yMin', 'PI.wp', 'PI.wd', 'PI.Ni', 'PI.Nd', 'PI.initType', 'PI.limitsAtInit', 'PI.xi_start', 'PI.xd_start', 'PI.y_start', 'PI.strict', 'PI.addP.u1', 'PI.addP.u2', 'PI.addP.y', 'PI.addP.k1', 'PI.addP.k2', 'PI.P.k', 'PI.P.u', 'PI.P.y', 'PI.I.k', 'PI.I.initType', 'PI.I.y_start', 'PI.I.u', 'PI.I.y', 'PI.gainPID.k', 'PI.gainPID.u', 'PI.gainPID.y', 'PI.addPID.k1', 'PI.addPID.k2', 'PI.addPID.k3', 'PI.addPID.u1', 'PI.addPID.u2', 'PI.addPID.u3', 'PI.addPID.y', 'PI.addI.k1', 'PI.addI.k2', 'PI.addI.k3', 'PI.addI.u1', 'PI.addI.u2', 'PI.addI.u3', 'PI.addI.y', 'PI.addSat.u1', 'PI.addSat.u2', 'PI.addSat.y', 'PI.addSat.k1', 'PI.addSat.k2', 'PI.gainTrack.k', 'PI.gainTrack.u', 'PI.gainTrack.y', 'PI.limiter.uMax', 'PI.limiter.uMin', 'PI.limiter.strict', 'PI.limiter.limitsAtInit', 'PI.limiter.u', 'PI.limiter.y', 'PI.Dzero.k', 'PI.Dzero.y', 'inertia1.flange_a.phi', 'inertia1.flange_a.tau', 'inertia1.flange_b.phi', 'inertia1.flange_b.tau', 'inertia1.J', 'inertia1.phi', 'inertia1.w', 'inertia1.a', 'torque.flange.phi', 'torque.flange.tau', 'torque.tau', 'spring.c', 'spring.d', 'spring.phi_rel0', 'spring.phi_rel', 'spring.w_rel', 'spring.a_rel', 'spring.tau', 'spring.flange_a.phi', 'spring.flange_a.tau', 'spring.flange_b.phi', 'spring.flange_b.tau', 'spring.phi_nominal', 'spring.lossPower', 'inertia2.flange_a.phi', 'inertia2.flange_a.tau', 'inertia2.flange_b.phi', 'inertia2.flange_b.tau', 'inertia2.J', 'inertia2.phi', 'inertia2.w', 'inertia2.a', 'kinematicPTP.deltaq[1]', 'kinematicPTP.qd_max[1]', 'kinematicPTP.qdd_max[1]', 'kinematicPTP.startTime', 'kinematicPTP.nout', 'kinematicPTP.y[1]', 'integrator.k', 'integrator.initType', 'integrator.y_start', 'integrator.u', 'integrator.y', 'speedSensor.flange.phi', 'speedSensor.flange.tau', 'speedSensor.w', 'loadTorque.flange.phi', 'loadTorque.flange.tau', 'loadTorque.phi', 'loadTorque.tau_constant', 'loadTorque.tau']
    示例2：获取所有参量
        加载标准模型库`Modelica 3.2.3`，以视图模式打开模型`Modelica.Blocks.Examples.PID_Controller`，仿真模型，获取所有参量
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel("Modelica.Blocks.Examples.PID_Controller")
        >>> print(GetResultVariables(1))
        结果：
        > ['driveAngle', 'PI.k', 'PI.Ti', 'PI.Td', 'PI.wp', 'PI.wd', 'PI.Ni', 'PI.Nd', 'PI.xi_start', 'PI.xd_start', 'PI.addP.k2', 'PI.P.k', 'PI.addPID.k1', 'PI.addPID.k2', 'PI.addPID.k3', 'PI.addI.k1', 'PI.addI.k2', 'PI.addI.k3', 'PI.addSat.k1', 'PI.addSat.k2', 'PI.Dzero.k', 'inertia1.J', 'spring.c', 'spring.d', 'spring.phi_rel0', 'inertia2.J', 'kinematicPTP.qd_max[1]', 'kinematicPTP.qdd_max[1]', 'kinematicPTP.startTime', 'integrator.k', 'integrator.y_start', 'loadTorque.tau_constant']
    示例3：获取所有时变变量
        加载标准模型库`Modelica 3.2.3`，以视图模式打开模型`Modelica.Blocks.Examples.PID_Controller`，仿真模型，获取所有时变变量
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel("Modelica.Blocks.Examples.PID_Controller")
        >>> print(GetResultVariables(2))
        结果：
        > ['PI.u_s', 'PI.u_m', 'PI.y', 'PI.controlError', 'PI.controllerType', 'PI.yMax', 'PI.yMin', 'PI.initType', 'PI.limitsAtInit', 'PI.y_start', 'PI.strict', 'PI.addP.u1', 'PI.addP.u2', 'PI.addP.y', 'PI.addP.k1', 'PI.P.u', 'PI.P.y', 'PI.I.k', 'PI.I.initType', 'PI.I.y_start', 'PI.I.u', 'PI.I.y', 'PI.gainPID.k', 'PI.gainPID.u', 'PI.gainPID.y', 'PI.addPID.u1', 'PI.addPID.u2', 'PI.addPID.u3', 'PI.addPID.y', 'PI.addI.u1', 'PI.addI.u2', 'PI.addI.u3', 'PI.addI.y', 'PI.addSat.u1', 'PI.addSat.u2', 'PI.addSat.y', 'PI.gainTrack.k', 'PI.gainTrack.u', 'PI.gainTrack.y', 'PI.limiter.uMax', 'PI.limiter.uMin', 'PI.limiter.strict', 'PI.limiter.limitsAtInit', 'PI.limiter.u', 'PI.limiter.y', 'PI.Dzero.y', 'inertia1.flange_a.phi', 'inertia1.flange_a.tau', 'inertia1.flange_b.phi', 'inertia1.flange_b.tau', 'inertia1.phi', 'inertia1.w', 'inertia1.a', 'torque.flange.phi', 'torque.flange.tau', 'torque.tau', 'spring.phi_rel', 'spring.w_rel', 'spring.a_rel', 'spring.tau', 'spring.flange_a.phi', 'spring.flange_a.tau', 'spring.flange_b.phi', 'spring.flange_b.tau', 'spring.phi_nominal', 'spring.lossPower', 'inertia2.flange_a.phi', 'inertia2.flange_a.tau', 'inertia2.flange_b.phi', 'inertia2.flange_b.tau', 'inertia2.phi', 'inertia2.w', 'inertia2.a', 'kinematicPTP.deltaq[1]', 'kinematicPTP.nout', 'kinematicPTP.y[1]', 'integrator.initType', 'integrator.u', 'integrator.y', 'speedSensor.flange.phi', 'speedSensor.flange.tau', 'speedSensor.w', 'loadTorque.flange.phi', 'loadTorque.flange.tau', 'loadTorque.phi', 'loadTorque.tau']
    输入参数
        varType - 变量类型
        数据类型：int
    返回值
        变量名列表
    另请参阅
        SimulateModel
    """
    params = inspect.signature(GetResultVariables).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetResultVariables, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetResultVariableInfo(varName:str, infoType:str) -> str:
    """
    获取当前仿真结果的指定变量信息
    
    语法
        GetResultVariableInfo(varName, infoType)
    说明
        用于获取当前仿真结果的指定变量信息，包括 Type、Description、Unit、DisplayUnit、Variability
    示例1：获取变量PI.y的单位和描述
        加载 Modelica 标准库，仿真`Modelica.Blocks.Examples.PID_Controller`，获取变量PI.y的单位和描述。
        >>> LoadLibrary("Modelica")
        >>> SimulateModel("Modelica.Blocks.Examples.PID_Controller")
        >>> unit = GetResultVariableInfo("PI.y", "Unit")
        >>> description = GetResultVariableInfo("PI.y", "Description")
        >>> print(unit)
        >>> print(description)
    结果:
        N.m
        Connector of actuator output signal
    输入参数
      varName - 变量全名
      数据类型：str
      infoType - 信息字段名
      数据类型：str
      包含以下字段：
      - Type（变量类型）
      - Description（变量描述）
      - Unit（变量单位）
      - DisplayUnit（变量显示单位）
      - Variability（变量可变性，1表示时变变量、2表示常量、3表示仿真前可调参数、4表示仿真中可调参数）
    返回值
        `str` : 返回的变量信息
    另请参阅
    """
    if type(varName) != str:
        _CheckArgTypes('GetResultVariableInfo', varName, 'varName', [str])
    if type(infoType) != str:
        _CheckArgTypes('GetResultVariableInfo', infoType, 'infoType', [str])
    if _CheckVarExisting(varName):
        params = inspect.signature(GetResultVariableInfo).parameters
        args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
        expected_types = [v.annotation for k, v in params.items() if k != 'self']
        return _MwConnect.__RunCurrentFunction__(GetResultVariableInfo, args=args, kwargs={}, expected_types = expected_types)
    return None

@mw_connect_decorator(_MwConnect._process_path)
def GetResultVariablesInfo(varNames:list, infoType:str):
    """
    批量获取当前仿真结果的指定变量信息
    
    语法
        GetResultVariablesInfo(varNames, infoType)
    说明
        用于批量获取当前仿真结果的指定变量信息，包括 Type、Description、Unit、DisplayUnit、Variability
    示例1：获取变量PI.y的单位和描述
        加载 Modelica 标准库，仿真`Modelica.Blocks.Examples.PID_Controller`，获取变量PI.y和PI.u_s的单位和描述。
        >>> LoadLibrary("Modelica")
        >>> SimulateModel("Modelica.Blocks.Examples.PID_Controller")
        >>> unit = GetResultVariablesInfo(["PI.y","PI.u_s"], "Unit")
        >>> description = GetResultVariablesInfo(["PI.y","PI.u_s"], "Description")
        >>> print(unit)
        >>> print(description)
    结果:
        ['N.m', '']
        ['Connector of actuator output signal', 'Connector of setpoint input signal']
    输入参数
      varNames - 变量全名的列表
      数据类型：list
      infoType - 信息字段名
      数据类型：str
      包含以下字段：
      - Type（变量类型）
      - Description（变量描述）
      - Unit（变量单位）
      - DisplayUnit（变量显示单位）
      - Variability（变量可变性，1表示时变变量、2表示常量、3表示仿真前可调参数、4表示仿真中可调参数）
    返回值
        `list` : 返回的变量信息列表
    另请参阅
    """
    if type(varNames) != list:
        _CheckArgTypes('GetResultVariablesInfo', varNames, 'varNames', [list])
    for item in varNames:
        if type(item)==  str:
            pass
        else:
            _CheckArgTypes('GetResultVariablesInfo',item,'varNames',[str])
    if type(infoType) != str:
        _CheckArgTypes('GetResultVariablesInfo', infoType, 'infoType', [str])
    params = inspect.signature(GetResultVariablesInfo).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetResultVariablesInfo, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], True, GetDirectory, Echo)
def ImportInitial(path:str = "", **kwargs) -> bool:
    """
    导入初值文件
    
    语法
        >>> ImportInitial(path)
    说明
        ImportInitial(path) 用于导入初值文件
    示例
    示例1：导入初值文件至仿真浏览器当前实例
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`。在本示例中，模型`world.g`的原始初值为`9.81`，为了更直观看到初值文件对参数初始值的更改，可以将`Initial.txt`中的参数`world.g`值更改为`10`，再从`Sample`文件夹中导入初值文件Initial.txt至仿真浏览器当前的实例中
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> print("模型参数world.g的默认初值：")
        >>> print(GetInitialValue('world.g'))
        >>> ImportInitial("D:\\Data\\Sample\\Initial.txt")
        >>> print("导入初值文件后，模型参数world.g的初值：")
        >>> print(GetInitialValue('world.g'))
        结果：
        > 模型参数world.g的默认初值：
        > 9.81
        >
        > 导入初值文件后，模型参数world.g的初值：
        > 10.0
    输入参数
        path - 初值文件路径
        数据类型：str
    返回值
        `bool` : 表示是否导入成功
    另请参阅
        GetInitialValue
    """
    params = inspect.signature(ImportInitial).parameters
    if kwargs != {}:
        valid_kwargs = set(params.keys())
        valid_kwargs.update(["initialFile"])
        # 判断参数是否传递正确
        for key in kwargs:
            if key in valid_kwargs:
                continue
            raise TypeError(f"ImportInitial() got an unexpected keyword argument '{key}'")
        # 兼容旧版调用
        path = kwargs["initialFile"]
    args = tuple(v for k, v in locals().items() if k not in ('kwargs'))
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    return _MwConnect.__RunCurrentFunction__(ImportInitial, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['initialFile'], False, GetDirectory, Echo)
def ExportInitial(initialFile:str) -> bool:
    """
    导出初值文件
    
    语法
        >>> ExportInitial(initialFile)
    说明
        ExportInitial(initialFile) 用于导出初值文件，指定初值文件的路径为initialFile，初值文件一般采用txt或csv格式。
    示例
    示例1：导出标准库模型DoublePendulum仿真初值文件
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，导出当前实例的初值至`Initial.txt`文件
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> ExportInitial("D:\\Data\\Initial.txt")
        结果：
        在对应的文件夹找到生成的初值文件`Initial.txt`
    输入参数
        initialFile - 初值文件路径
        数据类型：str
    返回值
        `bool` : 表示是否导出成功。
    另请参阅
        SimulateModel
    """
    params = inspect.signature(ExportInitial).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ExportInitial, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetInitialValue(varName:str):
    """
    获取仿真结果参数初值
    
    语法
        >>> GetInitialValue(varName)
    说明
        GetInitialValue(varName) 用于获取指定参数varName的仿真参数初始值。
    示例
    示例1：获取模型参数world.g仿真初始值
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，获取参数world.g的仿真参数初值
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> print("参数world.g的仿真参数初值：")
        >>> print(GetInitialValue("world.g"))
        结果：
        > 参数world.g的仿真参数初值：
        > 9.81
    输入参数
        varName - 参数全名
        数据类型：str
    返回值
        该参数的仿真结果初值
    另请参阅
        SimulateModel
    """
    if _CheckVarTunable(varName):
        params = inspect.signature(GetInitialValue).parameters
        args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
        expected_types = [v.annotation for k, v in params.items() if k != 'self']
        return _MwConnect.__RunCurrentFunction__(GetInitialValue, args=args, kwargs={}, expected_types = expected_types)
    return None

@mw_connect_decorator(_MwConnect._process_path)
def SetInitialValue(varName:str, varValue) -> bool:
    """
    设置仿真结果参数初值
    
    语法
        >>> SetInitialValue(varName, varValue)
    说明
        SetInitialValue(varName, varValue) 用于设置仿真结果参数varName的初值为varValue。
    示例
    示例1：加载标准库模型并设置world.g初值
        先加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，设置仿真参数world.g的初值为10
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> print("模型world.g参数的默认初始值：")
        >>> print(GetInitialValue("world.g"))
        >>> SetInitialValue("world.g", 10)
        >>> print("模型world.g参数的设置后初始值：")
        >>> print(GetInitialValue("world.g"))
        结果：
        > 模型world.g参数的默认初始值：
        > 9.81
        > 模型world.g参数的设置后初始值：
        > 10.0
    输入参数
        varName - 参数名
        数据类型：str
        varValue - 待设置的参数值
        数据类型：float
    返回值
        `bool` : 表示参数设置是否成功
    另请参阅
        SimulateModel|GetInitialValue
    """
    if type(varValue) == int or type(varValue) == float:
        varValue = float(varValue)
    else:
        _CheckArgTypes('SetInitialValue', varValue, 'varValue', [int, float])
    params = inspect.signature(SetInitialValue).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('varValue')] = type(varValue)
    return _MwConnect.__RunCurrentFunction__(SetInitialValue, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], False, GetDirectory, Echo)
def ExportResult(path:str, formatType:str = ResultFormat.Default, vars:list = [], withUnit:bool = False) -> bool:
    """
    导出结果文件，支持csv、mat、msr格式，并支持导出整个实例
    
    语法
        >>> ExportResult(path, vars)
        >>> ExportResult(path, formatType, vars, withUnit)
    说明
        ExportResult(path, vars) 用于导出结果文件，结果文件的路径 path 是必须指定的。
        ExportResult(path, formatType, vars, withUnit) 用于导出结果文件，支持csv、mat、msr格式，并支持导出整个实例，结果文件的路径path是必须指定的，其余参数可按默认值。
    示例
    示例1：导出标准库模型DoublePendulum实例结果为csv文件
        加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，将当前实例结果保存至Result.csv文件中,变量名后不跟随单位
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> ExportResult(r'D:\\Data\\Result.csv', 'csv', [], False)
        结果：
        实例结果文件`Result.csv`保存在指定位置
    示例2：导出标准库模型DoublePendulum实例结果为msr文件
        加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，在D:\\Data\\Result下生成文件夹，文件夹中放置该实例的所有文件。
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> ExportResult(r'D:\\Data\\Result', 'msr')
        结果：
        在指定文件夹下生成Result文件夹，保存了该实例的所有文件
    输入参数
        path - 结果文件的路径
        数据类型：str

        formatType - 文件格式
        数据类型：str
        可选变量如下：
        - ResultFormat.Csv: csv文件格式,命令中可缩写为"csv"
        - ResultFormat.Mat: mat文件格式,命令中可缩写为"mat"
        - ResultFormat.Default: msr结果文件格式,命令中可缩写为"msr" 

        vars - 变量名
        数据类型：list

        withUnit - 变量名后是否跟随单位
        数据类型：bool
    返回值
        `bool` : 表示是否导出成功
    另请参阅
        SimulateModel
    """
    params = inspect.signature(ExportResult).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ExportResult, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ExportResultEx(variables:list = [], option:dict={}) -> bool:
    """
    导出结果文件，支持csv、mat、msr、txt格式，并支持导出整个实例
    语法
        >>> ExportResultEx()
        >>> ExportResultEx(variables)
        >>> ExportResultEx(option)
        >>> ExportResultEx(variables,option)
    说明
        ExportResultEx() 用于按默认配置导出全部结果文件。
        ExportResultEx(variables) 用于按默认配置导出指定的变量列表。
        ExportResultEx(option) 用于按给定配置导出全部结果文件。
        ExportResultEx(variables,option) 用于按给定配置导出指定的变量列表。
    示例
    示例1：导出标准库模型DoublePendulum实例结果为csv文件
        加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，将当前实例结果保存至Result.csv文件中,变量名后不跟随单位
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> ExportResultEx(option={"filePath":r"D:\\Data\\Result.csv","formatType":"csv"})
        结果：
        实例结果文件`Result.csv`保存在指定位置
    示例2：导出标准库模型DoublePendulum实例结果为csv文件，指定采样时间，采样倍率，携带单位和描述
        加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，在D:\\Data下生成文件Result.csv。
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> ExportResultEx(["damper.phi_rel","damper.w_rel"],option={"withUnit":True,"withDescription":True,"timeRange":(1,),"sampleScale":30,"filePath":"D:\\Data\\Result.csv","formatType":"csv"})
        结果：
        在指定文件夹下生成Result.csv文件，保存指定变量的仿真结果
    输入参数
        variables：要导出的变量名列表，为空表示导出所有可见变量
        数据类型：list
        option：导出结果选项配置
        数据类型：dict
        可选配置如下
        - timeRange：导出的时间段，使用元组(t1, t2)表示，缺省为导出全部时间段。数据类型：tuple
        - sampleScale：采样倍率，表示等间隔采样后，剩余点数为原来的几分之一，使用正整数表示，缺省为不采样。数据类型：Int
        - withUnit：是否带单位导出，使用bool表示，缺省为 False。数据类型：bool
        - withDescription：是否带描述导出，使用bool表示，缺省为 False。数据类型：bool
        - unitType：导出单位类型，withUnit为True时生效，使用整数1,2表示，1表示显示单位，2表示国标单位，缺省为1。数据类型：Int
        - order：导出变量顺序，使用整数1,2表示，1表示变量声明顺序，2表示按首字母排序，缺省为1。数据类型：Int
        - target：导出为本地文件还是Syslab工作区，使用整数1,2表示，表示导出为本地文件，2表示导出到工作区，缺省为1。数据类型：Int
        - filePath：本地文件的绝对路径，不含文件名，target为1时生效，缺省为软件工作路径。数据类型：str
        - formatType：文件后缀，可选变量如下，缺省为 msr
            - ResultFormat.Txt: txt文件格式,命令中可缩写为"txt"
            - ResultFormat.Csv: csv文件格式,命令中可缩写为"csv"
            - ResultFormat.Mat: mat文件格式,命令中可缩写为"mat"
            - ResultFormat.Default: msr结果文件格式,命令中可缩写为"msr" 。选择target为1，且导出为 msr 时，timeRange、sampleScale、withUnit、withDescription、unitType、order 均不生效
    返回值
        `bool` : 表示是否导出成功
    另请参阅
        ExportResult
    """
    option_dict = {"timeRange":tuple,
               "sampleScale":int,
               "withUnit":bool,
               "withDescription":bool,
               "unitType":int,
               "order":int,
               "target":int,
               "filePath":str,
               "formatType":str}
    _CheckDictTypes('ExportResultEx',option_dict,option)
    params = inspect.signature(ExportResultEx).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ExportResultEx, args=args, kwargs={}, expected_types = expected_types)


@mw_connect_decorator(_MwConnect._process_path)
def SetCompileSolver64(i = 1) -> bool:
    """
    设置翻译时编译器平台位数。
    
    语法
        >>> SetCompileSolver64(i)
    说明
        SetCompileSolver64(i) 用于设置翻译时编译器平台位数，i = 1 时表示 64 位平台，i = 0 时表示 32 位平台，i为其他数值时也表示32位平台。
    示例
    示例1：更改翻译时编译器平台位数为64位
        先加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，设置翻译时编译器平台位数为64位
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> print("原先的编译器平台位数：")
        >>> print(GetCompileSolver64())
        >>> SetCompileSolver64(1)
        >>> print("更改后编译器平台位数：")
        >>> print(GetCompileSolver64())
        结果：
        > 原先的编译器平台位数：
        > 0
        > 更改后编译器平台位数：
        > 1
    输入参数
        i - 设置编译器平台位数
        数据类型：int
    返回值
        `bool` : 表示是否设置成功
    另请参阅
        SimulateModel|GetCompileSolver64
    """
    if type(i) == int or type(i) == float:
        i = int(i)
    else:
        _CheckArgTypes('SetCompileSolver64', i, 'i', [int, float])
    params = inspect.signature(SetCompileSolver64).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('i')] = type(i)
    return _MwConnect.__RunCurrentFunction__(SetCompileSolver64, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetCompileSolver64():
    """
    获取翻译时编译器平台位数，若为32位，则返回值为0，若为64位，则返回值为1
    
    语法
        >>> GetCompileSolver64()
    说明
        GetCompileSolver64() 用于获取翻译时编译器平台位数，若为32位，则返回值为0，若为64位，则返回值为1。
    示例
    示例1：获取模型翻译时编译器平台位数
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，获取到翻译时编译器平台位数
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> print("模型翻译时编译器平台位数：")
        >>> print(GetCompileSolver64())
        结果：
        > 模型翻译时编译器平台位数：
        > 1
    输入参数
        无参数
    返回值
        `int`类型，表示编译器平台的位数，32位为0，64位为1
    另请参阅
        SimulateModel
    """
    params = inspect.signature(GetCompileSolver64).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetCompileSolver64, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetCompileFmu64(i = 1) -> bool:
    """
    设置fmu导出时编译器平台位数
    
    语法
        >>> SetCompileFmu64(i)
    说明
        SetCompileFmu64(i) 用于设置fmu导出时编译器平台位数，i=1表示64位编译器，i=0表示32位编译器，i=其他也表示32位编译器。
    示例
    示例1：更改FMU编译器平台位数为32位
        先加载标准库`Modelica 3.2.1`，仿真标准库模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，设置fmu导出时编译器平台位数为32位
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> print("原先的编译器平台位数：")
        >>> print(GetCompileFmu64())
        >>> SetCompileFmu64(0)
        >>> print("更改后编译器平台位数：")
        >>> print(GetCompileFmu64())
        结果：
        > 原先的编译器平台位数：
        > 1
        > 更改后编译器平台位数：
        > 0
    输入参数
        i - 设置fmu导出时编译器平台位数
        数据类型：int
    返回值
        `bool` : 表示是否设置成功
    另请参阅
        SimulateModel|GetCompileFmu64
    """
    if type(i) == int or type(i) == float:
        i = int(i)
    else:
        _CheckArgTypes('SetCompileFmu64', i, 'i', [int, float])
    params = inspect.signature(SetCompileFmu64).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('i')] = type(i)
    return _MwConnect.__RunCurrentFunction__(SetCompileFmu64, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetCompileFmu64():
    """
    获取fmu导出时编译器平台位数
    
    语法
        >>> GetCompileFmu64()
    说明
        GetCompileFmu64() 用于获取fmu导出时编译器平台位数，若为32位，则返回值为0，若为64位，则返回值为1。
    示例
    示例1：获取模型fmu导出时编译器平台位数
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，获取fmu导出时编译器平台位数
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> print("模型fmu导出时编译器平台位数：")
        >>> print(GetCompileFmu64())
        结果：
        > 模型fmu导出时编译器平台位数：
        > 1
    输入参数
        无参数
    返回值
        `int`类型，表示编译器平台的位数，32位为0，64位为1
    另请参阅
        SimulateModel
    """
    params = inspect.signature(GetCompileFmu64).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetCompileFmu64, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetExperiment():
    """
    获取后处理仿真设置
    
    语法
        >>> GetExperiment()
    说明
        GetExperiment() 用于获取后处理仿真设置，包括仿真开始时间，结束时间，数据点数，使用输出步长，算法，精度，初始积分步长。
    示例
    示例1：获取自建模型的后处理仿真设置
        加载标准模型库`Modelica 3.2.1`，打开模型`Modelica.Blocks.Examples.PID_Controller`，获取后处理仿真设置
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> print("模型的后处理仿真设置为：")
        >>> GetExperiment()
        结果：
        > 模型的后处理仿真设置为：
        > {'startTime': 0.0, 'stopTime': 4.0, 'intervalLength': 0.0, 'numberOfIntervals': 500, 'algorithm': 'Dassl', 'tolerance': 0.0001, 'fixedOrInitStepSize': 0.0}
    输入参数
        无参数
    返回值
        python字典格式的仿真设置
    另请参阅
        无
    """
    params = inspect.signature(GetExperiment).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetExperiment, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetModelExperiment(modelName:str):
    """
    获取模型仿真配置
    
    语法
        >>> GetModelExperiment(modelName)
    说明
        GetModelExperiment(modelName) 用于获取模型仿真配置。
    示例
    示例1：获取标准库模型的模型仿真配置
        获取Modelica.Mechanics.Rotational.Examples.First的仿真配置，包括仿真开始时间，结束时间，数据点数，使用输出步长，算法，精度，初始积分步长，模型中未配置的项将不会列出。
        >>> LoadLibrary('Modelica', '3.2.3')
        >>> print("模型的仿真配置为：")
        >>> GetModelExperiment('Modelica.Mechanics.Rotational.Examples.First')
        结果：
        > 模型的仿真配置为：
        > {'startTime': 0.0, 'stopTime': 1.0, 'interval': 0.001, 'numberOfIntervals': 1000, 'isIntervalLength': False, 'algorithm': 'Dassl', 'isPieceWiseStep': False, 'pieceWiseStep': [], 'fixedOrInitStepSize': 0.0, 'tolerance': 0.0001, 'inlineIntegrator': False, 'inlineStepSize': False, 'storeEvent': 1}
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        python字典格式的仿真设置
    另请参阅
        LoadLibrary
    """
    params = inspect.signature(GetModelExperiment).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetModelExperiment, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetModelExperiment(modelName:str, experiment:dict) -> bool:
    """
    设置某个模型的仿真配置
    
    语法
        >>> SetModelExperiment(modelName, experiment)
    说明
        SetModelExperiment(modelName, experiment) 用于设置某个模型的仿真配置。函数返回bool表示是否设置成功。
    示例
    示例1：设置模型的仿真配置
        DoublePendulum模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载示例模型DoublePendulum，设置模型DoublePendulum的仿真配置，随后仿真模型。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo")
        >>> print(SetModelExperiment("DoublePendulum", {'startTime':0.0,'stopTime':1.0, }))
        >>> print(SimulateModel("DoublePendulum"))
        结果：
        > True
        True
    输入参数
        modelName - 模型全名
        数据类型：str

        experiment - 以字典格式输入的仿真配置
        数据类型：dict
        以字典格式输入的仿真配置：
        - `startTime`（仿真开始时间）
        - `stopTime`（仿真结束时间）
        - `numberOfIntervals`（数据点数）
        - `interval`（输出步长）
        - `isIntervalLength`（是否使用输出步长）
        - `algorithm`（算法）, 参考SimulateModelEx()
        - `tolerance`（精度）
        - `fixedOrInitStepSize`（初始积分步长）
        - `isPieceWiseStep`（是否使用分段固定积分步长）
        - `pieceWiseStep`（分段步长）
        - `inlineIntegrator`（内联积分器）
        - `inlineStepSize`（内联步长）
        - `storeEvent`（存储事件）
    返回值
        `bool` : 表示是否成功配置设置
    另请参阅
        无
    """
    if experiment.get('pieceWiseStep') == None or isinstance(experiment['pieceWiseStep'], list):
        if experiment.get('pieceWiseStep') != None:
            for subarr in experiment['pieceWiseStep']:
                if not _IsArrayAllNumeric(subarr):
                    raise TypeError("SetModelExperiment() argument 'pieceWiseStep' must be 'list[list[float]]'") from None
    else:
        _CheckArgTypes('SetModelExperiment', experiment['pieceWiseStep'], 'pieceWiseStep', [list])

    for key, value in experiment.items():
        if type(value) == int or type(value) == float or type(value) == bool or type(value) == str or type(value) == list or type(value) == tuple:
            experiment[key] = str(value)
        else:
            _CheckArgTypes('SetModelExperiment', value, key, [int, float, bool, str, list, tuple])

    params = inspect.signature(SetModelExperiment).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params','ModelExperiment','oldEcho','key_list','key','value','item'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetModelExperiment, args=args, kwargs={}, expected_types = expected_types)

#--------------------------曲线命令-------------------------------
@mw_connect_decorator(_MwConnect._process_path)
def CreateLayout(row:int,column:int,widths:list=[],heights:list=[],window:str="")->bool:
    """
    创建窗口布局
    
    语法
        >>> CreateLayout(row,column)
        >>> CreateLayout(row,column,widths,heights)
        >>> CreateLayout(row,column,widths,heights,window)
  
    说明
        CreateLayout() 用于创建界面窗口布局
    示例
    示例1：新建2行3列的布局
        >>> CreateLayout(2,3)
    示例2：新建2行3列的布局，并给出每个格子宽度和高度大小
        >>> CreateLayout(2,3,[500,500,1600],[300,20])
    输入参数
        row - 布局行数
        数据类型：int

        column - 布局列数
        数据类型：int

        widths - 每个格子宽度大小 
        数据类型：list

        heights - 每个格子高度大小 
        数据类型：list
      
        window - 布局的窗口，默认为后处理窗口
        数据类型：str
        可选变量如下：
        - "ResultViewer" 后处理窗口布局

    返回值
        `bool` : 表示是否成功创建布局
    另请参阅
        无
    """
            
    params = inspect.signature(CreateLayout).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(CreateLayout, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def CreatePlot(id:int = 0, position:list = [], x:str = "", y:list = [], heading:str = "", grid:bool = True,
    legendLayout:int = LegendLayout.FloatingTopCenter, legendFrame:bool = False, legend:list = [], xDisplayUnit:str = "",
    yDisplayUnit:list = [], yAxis:list = [], leftTitleType:int = AxisTitleType.Default, leftTitle:str = "",
    bottomTitleType:int = AxisTitleType.Default, bottomTitle:str = "",rightTitleType:int = AxisTitleType.Default,
    rightTitle:str = "", curveVernier:bool = False, fixTimeRange:bool = False, fixTimeRangeValue:float = 10.0,
    resultFile:str = "", zoomX:tuple = (), zoomY:tuple = (), subPlot:tuple = (1,1), zoomYR:tuple = (), **kwargs) -> bool:
    """
    新建曲线窗口
    
    语法
        >>> CreatePlot()
        >>> CreatePlot(id, position, x, y, heading, grid,
        >>>     legendLayout, legendFrame, legend, xDisplayUnit,
        >>>     yDisplayUnit, yAxis, leftTitleType, leftTitle,
        >>>     bottomTitleType, bottomTitle, rightTitleType, rightTitle, curveVernier, fixTimeRange, fixTimeRangeValue, resultFile, subPlot)
    说明
        CreatePlot() 用于以默认参数设置新建曲线窗口。如果 id 和 sub_plot 所唯一指定的子窗口已存在，则清空子窗口中已有变量。
        CreatePlot(id, position, x, y, heading, grid, legendLayout, legendFrame, legend, xDisplayUnit,
            yDisplayUnit, yAxis, leftTitleType, leftTitle, bottomTitleType, bottomTitle, rightTitleType,
            rightTitle, curveVernier, fixTimeRange, fixTimeRangeValue, resultFile, subPlot) 
        用于新建曲线窗口。当x使用默认参数时，创建y(time)窗口。当x被设置时，检查x与所有y是否都来自同一个实例，来自同一个实例则创建y(x)窗口，否则创建失败。如果id和sub_plot所唯一指定的子窗口已存在，则清空子窗口中已有变量。
    示例
    示例1：新建曲线窗口
        Result.msr文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下
        创建编号为2的曲线窗口，显示实例DoublePendulum中以boxBody2.frame_b.r_0[2]为X轴的boxBody2.frame_a.r_0[1],boxBody2.frame_a.r_0[2]的曲线，图例悬浮在左下，并在该曲线窗口显示游标。
        >>> CreatePlot(id=2,x='time',y=['boxBody2.frame_a.r_0[1]', 'boxBody2.frame_a.r_0[2]'],legendLayout=10,curveVernier=True, resultFile=GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Result.msr\\Result.msr")
    输入参数
        id - 窗口编号
        数据类型：int
        id=0,表示新建曲线窗口;id>0,表示创建编号id的曲线,若指定id的窗口已存在且窗口类型一致，直接覆盖创建，否则新建窗口。
        
        position - 窗口位置（新曲线窗口暂不支持设置该参数，保留参数为了兼容旧版调用）
        数据类型：list
        数组变量依次为 x0, y0, width, height;以左上角坐标为位置坐标，宽和高表示窗口大小。电脑屏幕的最左上角为原点即坐标为[0,0]，屏幕上边界向右为x轴正方向，屏幕左边y轴正方向。
        
        x - 自变量
        数据类型：str
        默认是time。

        y - 变量列表
        数据类型：list

        heading - 标题
        数据类型：str

        grid - 显示网格
        数据类型：bool

        legendLayout - 图例位置
        数据类型：int
        1-嵌入上方，2-嵌入下方，3-嵌入左方，4-嵌入右方，5-浮动于左上，6-浮动于正上方，7-浮动于右上，8-浮动于左边中央，9-浮动于右边中央，10-浮动于左下，11-浮动于正下方，12-浮动于右下，13-隐藏，默认6

        legendFrame - 是否绘制图例边框
        数据类型：bool

        legend - 图例列表
        数据类型：list

        xDisplayUnit - x轴显示单位
        数据类型：str

        yDisplayUnit - 变量的显示单位
        数据类型：list

        yAxis - 该曲线属于左/右坐标轴[1左，-1右]
        数据类型：list

        leftTitleType - 左纵坐标标题类型
        数据类型：int
        可选变量如下：
        - AxisTitleType.None_ 无轴标题
        - AxisTitleType.Default 使用默认的轴标题
        - AxisTitleType.Custom 自定义的轴标题 

        leftTitle - 自定义的左纵坐标标题
        数据类型：str

        bottomTitleType - 横坐标标题类型
        数据类型：int
        可选变量如下：
        - AxisTitleType.None_ 无轴标题
        - AxisTitleType.Default 使用默认的轴标题
        - AxisTitleType.Custom 自定义的轴标题

        bottomTitle - 自定义的横坐标标题
        数据类型：str

        rightTitleType - 右纵坐标标题类型
        数据类型：int
        可选变量如下：
        - AxisTitleType.None_ 无轴标题
        - AxisTitleType.Default 使用默认的轴标题
        - AxisTitleType.Custom 自定义的轴标题

        rightTitle - 自定义的右纵坐标标题
        数据类型：str

        curveVernier - 显示曲线游标
        数据类型：bool

        fixTimeRange - 限定时间范围
        数据类型：bool

        fixTimeRangeValue - 限定的时间范围值
        数据类型：float

        resultFile - 结果文件，需填写结果文件的全路径
        数据类型：str

        subPlot - 子窗口序号，[1,1]表示该窗口的第一行第一列的子窗口
        数据类型：list
    返回值
        `bool` : 表示是否成功新建窗口
    另请参阅
        无
    """
    #兼容旧版保存曲线结果 模型配置 CreatePlot()
    if kwargs != {}:
        yDisplayUnit = kwargs.get("yDisplayUnits",yDisplayUnit if yDisplayUnit is not None else [])
        legend = kwargs.get("legends", legend if legend is not None else [])

    if isinstance(subPlot, list):
        subPlot = tuple(subPlot)

    if len(subPlot) == 2:
        if not all(isinstance(i, int) for i in subPlot):
            print("Value Error: subPlot must be a tuple of two int values.")
            return False
    else:
        print("Value Error: subPlot must be a tuple of two int values.")

    if zoomX == ():
        pass
    elif len(zoomX) == 2:
        if not all(isinstance(i, (float, int)) for i in zoomX):
            print("Value Error: ZoomX must be a tuple of two float or int values.")
            return False
        if zoomX[0] >= zoomX[1]:
            print("Value Error: The ZoomX end value must be greater than the start.")
            return False
    else:
        print("Value Error: ZoomX must be a tuple of two float or int values.")
        return False

    if zoomY == ():
        pass
    elif len(zoomY) == 2:
        if not all(isinstance(i, (float, int)) for i in zoomY):
            print("Value Error: ZoomY must be a tuple of two float or int values.")
            return False
        if zoomY[0] >= zoomY[1]:
            print("Value Error: The zoomY end value must be greater than the start.")
            return False
    else:
        print("Value Error: The zoomY end value must be greater than the start.")
        return False
    
    if zoomYR == ():
        pass
    elif len(zoomYR) == 2:
        if not all(isinstance(i, (float, int)) for i in zoomYR):
            print("Value Error: zoomYR must be a tuple of two float or int values.")
            return False
        if zoomYR[0] >= zoomYR[1]:
            print("Value Error: The zoomYR end value must be greater than the start.")
            return False
    else:
        print("Value Error: The zoomYR end value must be greater than the start.")
        return False

    if type(id) == int or type(id) == float:
        id = int(id)
    else:
        return False
    if type(fixTimeRangeValue) == int or type(fixTimeRangeValue) == float:
        fixTimeRangeValue = float(fixTimeRangeValue)
    else:
        return False
    if (x == "time" and xDisplayUnit == ""):
        xDisplayUnit="s"
    if type(y) == str:
        y = [y]
    if type(legend) == str:
        legend = [legend]
    if type(yDisplayUnit) == str:
        yDisplayUnit = [yDisplayUnit]
    if type(yAxis) == int:
        yAxis = [yAxis]

    position = [int(i) if isinstance(i,float) else i for i in position]

    params = inspect.signature(CreatePlot).parameters
    args = tuple(v for k, v in locals().items() if k != 'kwargs' and k != 'params' and k != 'args')
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    return _MwConnect.__RunCurrentFunction__(CreatePlot, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def CreatePlotEx(data:list = None, variables:list = [], position:list = [], option:dict = {})->bool:
    """
    创建绘图。支持使用传入的 data 与使用当前结果的 variables 两种方式

    语法
        >>> CreatePlotEx(data)
        >>> CreatePlotEx(data, variables = [], position)
        >>> CreatePlotEx(data, variables = [], position, option)
        >>> CreatePlotEx(data = None, variables)
        >>> CreatePlotEx(data = None, variables, position)
        >>> CreatePlotEx(data = None, variables, position, option)
    说明
        CreatePlotEx(data) 基于 data 这个二维向量中第一个向量的数据作为 x 轴，绘制第二个向量之后的数据

        CreatePlotEx(data, variables = [], position) 在 position 位置绘制 data

        CreatePlotEx(data, variables = [], position, option) 使用 option 配置，在 position 位置绘制 data

        CreatePlotEx(data = None, variables) 基于当前结果的 variables 变量绘制数据, 其横坐标为当前结果的时间。

        CreatePlotEx(data = None, variables, position) 在 position 位置绘制当前结果中的 variables 变量

        CreatePlotEx(data = None, variables, position, option) 使用 option 中的绘图属性配置绘制当前结果中的 variables 变量。

        若 data 和 variables 均不为空时，以 data 为准。
    示例
        
    输入参数
        data - 绘图数据
        数据类型: list (2d)
        每个元素是一个向量，对应变量的值

        variables - 变量名列表
        数据类型: list
        变量名列表，当 data 有数据时视为每组数据的变量名

        position - 窗口位置，需要先使用CreateLayout或CreateLayoutEx创建出对应的窗口布局
        数据类型: list
        用一个长度为5的int数组来表示窗口的类型和位置：
        第1位表示type: 窗口的布局，分为平铺和独立窗口，平铺模式为1， 独立窗口为2；
        第2位表示x0: 在平铺模式下，表示窗口占用的布局器范围的最左边区域的 index 值（左上角第一格为 1, 1）；在独立窗口模式下，表示窗口的左侧边的屏幕坐标（屏幕左上角为 0, 0）
        第3位表示y0: 在平铺模式下，表示窗口占用的布局器范围的最上边区域的 index 值（左上角第一格为 1, 1）；在独立窗口模式下，表示窗口的上侧边的屏幕坐标（屏幕左上角为 0, 0）
        第4位表示x1: 在平铺模式下，表示窗口占用的布局器范围的最右边区域的 index 值（左上角第一格为 1, 1）；在独立窗口模式下，表示窗口的右侧边的屏幕坐标（屏幕左上角为 0, 0）
        第5位表示y1: 在平铺模式下，表示窗口占用的布局器范围的最下边区域的 index 值（左上角第一格为 1, 1）；在独立窗口模式下，表示窗口的下侧边的屏幕坐标（屏幕左上角为 0, 0）

        option - 窗口设置
        数据类型: dict
        用一组字典来表示窗口属性
        id: int, 窗口编号。id=0,表示新建窗口;id>0,表示创建编号id的窗口,若指定id的窗口已存在且窗口类型一致，直接覆盖，否则报错。
        plotType: str, 窗口的类型，分为'Curve-yt', 'Curve-yx', 'Table'。分别表示yt曲线、yx曲线、表格
        x: 横坐标变量名字，仅在'Curve-yx'类型下生效，此时横坐标将不再使用输入数据的第一列
        heading: str,  窗口标题
        grid: bool,  是否显示网格
        legendLayout: int, 1 表示嵌入上方， 2 表示嵌入下方， 3 表示嵌入左方， 4 表示嵌入右方， 5 表示浮动于左上， 6 表示浮动于正上方， 7 表示浮动于右上， 8 表示浮动于左边中央， 9 表示浮动于右边中央， 10 表示浮动于左下， 11 表示浮动于正下方， 12 表示浮动于右下， 13 表示隐藏，默认 6 
        legends: list, 图例列表，与变量一一对应
        xDisplayUnit: str, x轴显示单位
        yDisplayUnit: list, 变量显示单位，与变量一一对应
        yAxis: list: 该曲线属于左/右坐标轴，与变量一一对应, 1 表示左，-1 表示右
        leftTitleType: int, 左纵坐标标题类型
            可选变量如下：
            - AxisTitleType.None_ 无轴标题
            - AxisTitleType.Default 使用默认的轴标题
            - AxisTitleType.Custom 自定义的轴标题 
        leftTitle: str, 自定义的左纵坐标标题
        bottomTitleType: int, 
            可选变量如下：横坐标标题类型
            - AxisTitleType.None_ 无轴标题
            - AxisTitleType.Default 使用默认的轴标题
            - AxisTitleType.Custom 自定义的轴标题
        bottomTitle: str, 自定义的横坐标标题
        rightTitleType: int, 右纵坐标标题类型
            可选变量如下：
            - AxisTitleType.None_ 无轴标题
            - AxisTitleType.Default 使用默认的轴标题
            - AxisTitleType.Custom 自定义的轴标题 
        rightTitle: str, 自定义的右纵坐标标题
        curveVernier: bool, 显示曲线游标
        fixTimeRange: bool, 限定时间范围
        fixTimeRangeValue: float, 限定的时间范围值
        resultFile: str, 结果文件，需填写结果文件的全路径，该选项可以指定结果数据，而不只是当前结果
        subPlot: list, 子窗口序号，[1,1]表示该窗口的第一行第一列的子窗口
    """

    if data != None:
        for subarr in data:
            if not _IsArrayAllNumeric(subarr):
                raise TypeError("CreatePlotEx() argument 'data' must be 'list[list[float]]'") from None
    if not _IsArrayAllInt(position):
        raise TypeError("CreatePlotEx() argument 'position' must be 'list[int]'") from None

    for key, value in option.items():
        option[key] = str(value)
    params = inspect.signature(CreatePlotEx).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(CreatePlotEx, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def CreateLayoutEx(position:list = [], columnSize:list = [], rowSize:list = [])->bool:
    """
    创建布局。

    语法
        >>> CreateLayoutEx(position, columnSize, rowSize)
    说明

    示例
        CreateLayoutEx([1,1,1,2,2,1,2,1,2,2,2,2])
        CreateLayoutEx([1,1,1,2,2,1,2,1,2,2,2,2], [500,500], [400,400])
    输入参数
        position - 窗口位置
        数据类型: list
        用一个int数组来表示窗口的位置，每四位数字为一组分别表示一个窗口的位置：
        x0: 表示窗口占用的布局器范围的最左边区域的 index 值（左上角第一格为 1, 1）
        y0: 表示窗口占用的布局器范围的最上边区域的 index 值（左上角第一格为 1, 1）
        x1: 表示窗口占用的布局器范围的最右边区域的 index 值（左上角第一格为 1, 1）
        y1: 表示窗口占用的布局器范围的最下边区域的 index 值（左上角第一格为 1, 1）

        columnSize - 列宽
        数据类型: list
        分别对应每一列的宽度

        rowSize - 行宽
        数据类型: list
        分别对应每一行的宽度
    """

    if not _IsArrayAllInt(position):
        raise TypeError("CreateLayoutEx() argument 'position' must be 'list[int]'") from None
    if not _IsArrayAllInt(columnSize):
        raise TypeError("CreateLayoutEx() argument 'columnSize' must be 'list[int]'") from None
    if not _IsArrayAllInt(rowSize):
        raise TypeError("CreateLayoutEx() argument 'rowSize' must be 'list[int]'") from None

    params = inspect.signature(CreateLayoutEx).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(CreateLayoutEx, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def Plot(y:list = [], legend:list = [], colors:list = [], lineStyles:list = [],
    markerStyles:list = [], thicknesses:list = [], displayUnits:list = [], verticalAxes:list = []) -> bool:
    """
    在最后一个窗口中绘制指定变量的曲线，如果没有窗口则按系统默认设置新建一个窗口
    
    语法
        >>> Plot()
        >>> Plot(y, legend, colors, lineStyles,
        >>>     markerStyles, thicknesses, displayUnits, verticalAxes)
    说明
        Plot() 用于以默认设置在最后一个窗口中绘制曲线，如果没有窗口则按系统默认设置新建一个窗口。
        Plot(y, legend, colors, lineStyles,
            markerStyles, thicknesses, displayUnits, verticalAxes)
        用于在最后一个窗口中绘制指定变量的曲线，如果没有窗口则按系统默认设置新建一个窗口。
    示例
    示例1：在现有最后一个窗口或新建窗口中绘制曲线
        加载标准模型库`Modelica 3.2.1`，仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，在曲线窗口按照如下设置显示以下三个曲线
        boxBody2.frame_a.r_0[2]：颜色为黑色，显示单位为cm，显示为左纵坐标轴
        boxBody1.frame_a.r_0[1]：颜色为红色，显示单位为m，显示为左纵坐标轴
        damper.phi_rel：颜色为紫色，显示单位为rad，显示为右纵坐标轴
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> Plot(y=['boxBody2.frame_a.r_0[2]','boxBody1.frame_a.r_0[1]','damper.phi_rel'], colors=[LineColor.Black, LineColor.Red, LineColor.Purple], displayUnits=['cm','m','rad'],verticalAxes=[VerticalAxis.Left, VerticalAxis.Left, VerticalAxis.Right])
    输入参数
        y - 变量名列表
        数据类型：list

        legend - 图例文字列表
        数据类型：list

        colors - 曲线颜色
        数据类型：list
        可选变量如下：
        - LineColor.Black: 黑色
        - LineColor.Brown: 棕色
        - LineColor.Green: 绿色
        - LineColor.Magenta: 洋红
        - LineColor.Purple: 紫色
        - LineColor.Red: 红色
        - LineColor.Yellow: 黄色

        lineStyles - 曲线线型
        数据类型：list
        可选变量如下：
        - LineStyle.DashDot: 点划线
        - LineStyle.DashDotDot: 双点划线
        - LineStyle.Dashed: 虚线
        - LineStyle.Dotted: 点线
        - LineStyle.Solid: 实线

        markerStyles - 曲线数据点样式
        数据类型：list
        可选变量如下：
        - MarkerStyle.Circle: 圆形
        - MarkerStyle.Cross: 交叉形
        - MarkerStyle.Diamond: 菱形
        - MarkerStyle.FilledCircle: 实心圆
        - MarkerStyle.FilledSquare: 实心正方形
        - MarkerStyle.None_: 不显示数据点
        - MarkerStyle.Square: 正方形
        - MarkerStyle.TriangleDown: 倒三角形
        - MarkerStyle.TriangleUp: 正三角形

        thicknesses - 线宽
        数据类型：list
        可选变量如下：
        - LineThickness.Double: 双倍线宽
        - LineThickness.Quad: 四倍线宽
        - LineThickness.Single: 单倍线宽

        displayUnits - 显示单位列表
        数据类型：list

        verticalAxes - 纵轴类型
        数据类型：list
        可选变量如下：
        - VerticalAxis.Left: 左纵轴
        - VerticalAxis.Right: 右纵轴
    返回值
        `bool` : 表示是否成功绘制曲线
    另请参阅
        SimulateModel
    """
    if type(y) == str:
        y = [y]
    if type(legend) == str:
        legend = [legend]
    if type(displayUnits) == str:
        displayUnits = [displayUnits]
    colors = [str(i) for i in colors]
    thicknesses = [int(i) if isinstance(i,float) else i for i in thicknesses]
    params = inspect.signature(Plot).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(Plot, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def RemovePlots() -> bool:
    """
    关闭所有曲线窗口
    
    语法
        >>> RemovePlots()
    说明
        RemovePlots() 用于关闭所有曲线窗口。
    示例
    示例1：关闭所有窗口
        见Plot文档，创建一个曲线窗口，随后关闭所有曲线窗口
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> Plot(y=['boxBody2.frame_a.r_0[2]','boxBody1.frame_a.r_0[1]','damper.phi_rel'], colors=[LineColor.Black, LineColor.Red, LineColor.Purple], displayUnits=['cm','m','rad'],verticalAxes=[VerticalAxis.Left, VerticalAxis.Left, VerticalAxis.Right])
        >>> RemovePlots()
    输入参数
        无参数
    返回值
        `bool` : 表示是否关闭成功
    另请参阅
        Plot
    """
    params = inspect.signature(RemovePlots).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(RemovePlots, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ClearPlot(remove:bool = False, id = -1) -> bool:
    """
    清除曲线窗中当前子窗口内容
    
    语法
        >>> ClearPlot(remove = False, id)
    说明
        ClearPlot(remove, id) 用于清除曲线窗中当前子窗口内容。如果remove为True，则移除当前子窗口。最后一个子窗口不会被移除。
    示例
    示例1：清楚指定id的曲线窗口
        Result.msr文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下。
        根据CreatePlot文档创建一个id为3的窗口，随后清除“曲线窗口-3”中的所有曲线，并移除当前子窗口
        >>> CreatePlot(id=3,x='boxBody2.frame_b.r_0[2]',y=['boxBody2.frame_a.r_0[1]', 'boxBody2.frame_a.r_0[2]'],legendLayout=10,curveVernier=True, resultFile=OpenModelFile(GetInstallationDirectory() + '\\Docs\\Samples\\PythonAPI\\Result.msr\\Result.msr')
        >>> ClearPlot(remove = True, id = 3)
    输入参数
        remove - 是否移除子窗口
        数据类型：bool
        id - 窗口编号
        数据类型：int
    返回值
        `bool` : 表示是否清除成功
    另请参阅
        CreatePlot
    """
    if type(id) == int or type(id) == float:
        id = int(id)
    else:
        _CheckArgTypes('ClearPlot', id, 'id', [int, float])
        return False
    params = inspect.signature(ClearPlot).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('id')] = type(id)
    return _MwConnect.__RunCurrentFunction__(ClearPlot, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['filePath'], False, GetDirectory, Echo)
def ExportPlot(filePath:str, fileFormat:int, id = -1, w = -1, h = -1) -> bool:
    """
    曲线导出
    
    语法
        >>> ExportPlot(filePath, fileFormat)
        >>> ExportPlot(filePath, fileFormat, id, w, h)
    说明
        ExportPlot(filePath, fileFormat) 用于将指定图形导出到指定文件中。
        ExportPlot(filePath, fileFormat, id, w, h) 用于指定窗口编号、图片宽度和图片高度将指定图形导出到指定文件中。                                         |
    示例
    示例1：导出曲线为png文件
        请确保您已查看过Plot文档
        按照Plot文档的流程创建曲线，曲线id为1，将曲线窗口-1作为500*500大小的图片导出，导出的文件路径为'D:\\Data\\Plot.png'
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> Plot(y=['boxBody2.frame_a.r_0[2]','boxBody1.frame_a.r_0[1]','damper.phi_rel'], colors=[LineColor.Black, LineColor.Red, LineColor.Purple], displayUnits=['cm','m','rad'],verticalAxes=[VerticalAxis.Left, VerticalAxis.Left, VerticalAxis.Right])
        >>> ExportPlot('D:\Data\Plot.png', 1, 1, 500, 500)
    输入参数
        filePath - 存储路径
        数据类型：str

        fileFormat - 文件格式
        数据类型：str
        可选变量如下：
        - PlotFileFormat.Image    曲线窗口导出为图片,命令中可缩写为"1"
        - PlotFileFormat.Csv      曲线导出为csv文件，命令中可缩写为"2"
        - PlotFileFormat.Mat      曲线导出为mat文件，命令中可缩写为"3"
        - PlotFileFormat.Text     曲线导出为文本文件，命令中可缩写为"4"

        id - 窗口编号
        数据类型：int

        w - 图片宽度
        数据类型：int

        h - 图片高度
        数据类型：int
    返回值
        `bool` : 表示是否导出成功
    另请参阅
        Plot
    """
    if type(id) == int or type(id) == float:
        id = int(id)
    else:
        _CheckArgTypes('ExportPlot', id, 'id', [int, float])
    if type(w) == int or type(w) == float:
        w = int(w)
    else:
        _CheckArgTypes('ExportPlot', id, 'id', [int, float])
    if type(h) == int or type(h) == float:
        h = int(h)
    else:
        _CheckArgTypes('ExportPlot', id, 'id', [int, float])
    params = inspect.signature(ExportPlot).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('id')] = type(id)
    expected_types[list(params.keys()).index('w')] = type(w)
    expected_types[list(params.keys()).index('h')] = type(h)
    return _MwConnect.__RunCurrentFunction__(ExportPlot, args=args, kwargs={}, expected_types = expected_types)

#--------------------------动画命令-------------------------------
@mw_connect_decorator(_MwConnect._process_path)
def CreateAnimation() -> bool:
    """
    新建动画窗口
    
    语法
        >>> CreateAnimation()
    说明
        CreateAnimation() 用于新建动画窗口。
    示例
    示例1：为标准库模型DoublePendulum新建动画窗口
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，新建动画窗口
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> CreateAnimation()
    输入参数
        无参数
    返回值
        `bool` : True表示操作成功，False表示失败。
    另请参阅
        SimulateModel
    """
    params = inspect.signature(CreateAnimation).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(CreateAnimation, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def RemoveAnimations() -> bool:
    """
    关闭所有动画窗口
    
    语法
        >>> RemoveAnimations()
    说明
        RemoveAnimations() 用于关闭所有动画窗口。
    示例
    示例1：关闭已打开的所有动画窗口
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，新建动画窗口，随后关闭所有动画窗口
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> CreateAnimation()
        >>> RemoveAnimations()
    输入参数
        无参数
    返回值
        `bool` : True表示操作成功，False表示失败。
    另请参阅
        CreateAnimation
    """
    params = inspect.signature(RemoveAnimations).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(RemoveAnimations, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def RunAnimation() -> bool:
    """
    播放动画
    
    语法
        >>> RunAnimation()
    说明
        RunAnimation() 用于播放动画。
    示例
    示例1：打开并播放标准库模型DoublePendulum动画
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，新建动画窗口，并播放动画
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> CreateAnimation()
        >>> RunAnimation() 
    输入参数
        无参数
    返回值
        `bool` : 表示是否播放成功。
    另请参阅
        CreateAnimation
    """
    params = inspect.signature(RunAnimation).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(RunAnimation, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def AnimationSpeed(speed) -> bool:
    """
    设置动画播放速度
    
    语法
        >>> AnimationSpeed(speed)
    说明
        AnimationSpeed(speed) 用于设置动画播放速度。speed为加速因子，大于1表示加速，小于1表示减速，在播放的过程中设置为0则停止播放。
    示例
    示例1：设置标准库下的DoublePendulum模型动画播放速度
        加载标准库`Modelica 3.2.1`，并仿真模型`Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum`，新建动画窗口，并设置动画播放速度为0.1，最后播放动画
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel('Modelica.Mechanics.MultiBody.Examples.Elementary.DoublePendulum')
        >>> CreateAnimation()
        >>> AnimationSpeed(0.1)
        >>> RunAnimation()
    输入参数
        speed - 加速因子
        数据类型：float
    返回值
        `bool` : True表示操作成功，False表示失败。
    另请参阅
        CreateAnimation|RunAnimation
    """
    if type(speed) == int or type(speed) == float:
        speed = float(speed)
    else:
        _CheckArgTypes('AnimationSpeed', speed, 'speed', [int, float])
    params = inspect.signature(AnimationSpeed).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('speed')] = type(speed)
    return _MwConnect.__RunCurrentFunction__(AnimationSpeed, args=args, kwargs={}, expected_types = expected_types)

#--------------------------模型操作命令-------------------------
@mw_connect_decorator(_MwConnect._process_path)
def NewModel(modelName:str = "", restriction:str = "model", description:str = "", base:str = "", parent:str = "", saveInOneFile:bool = True, partial:bool = False) -> bool:
    """
    新建模型
    
    语法
        >>> NewModel(modelName:str = "", restriction:str = "model", description:str = "", base:str = "", parent:str = "", saveInOneFile:bool = True, partial:bool = False)
    说明
        NewModel(modelName, restriction, description, base, parent, saveInOneFile, partial) 用于新建模型，函数返回`str`表示新建的模型名。modelName为新建模型的全名，restriction为新建模型的限定类型，description为新建模型的描述，base为基类全名，parent为插入的父模型全名，saveInOneFile为保存为单个文件，partial为是否为抽象类。
    示例
    示例1：按默认配置新建一个模型
        不限定任何参数，按照默认配置新建一个模型。
        >>> print(NewModel())
        结果：
        > Model6
    示例2：设置参数新建一个模型
        限定参数，按照配置新建一个模型，模型名称为NewModel，限定类型为model，模型描述为：This is a New Model，基类为MainPackage，保存为单个文件，不是抽象类。
        >>> print(NewModel(modelName="NewModel", restriction="model", description="This is a New Model", base="MainPackage", parent="", saveInOneFile=True, partial=False))
        结果：
        > NewModel
    输入参数
        modelName - 模型全名
        数据类型：str
        restriction - 模型的限定类型
        数据类型：str
        description - 模型描述
        数据类型：str
        base - 基类全名
        数据类型：str
        parent - 插入的父模型全名
        数据类型：str
        saveInOneFile - 保存为单个文件
        数据类型：bool
        partial - 是否为抽象类
        数据类型：bool
    返回值
        `str` : 返回新建的模型名
    另请参阅
        无
    """
    params = inspect.signature(NewModel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(NewModel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def CopyModel(srcParentModel:str, modelName:str, tarParentModel:str = "", newModelName:str = "") -> bool:
    """
    复制模型
    
    语法
        >>> CopyModel(srcParentModel, modelName, tarParentModel:str = "", newModelName:str = "")
    说明
        CopyModel(srcParentModel, modelName, tarParentModel, newModelName) 用于复制模型，函数返回`bool`表示是否复制成功。`srcParentModel`表示源父模型全名，若为顶层模型，此项为空，`modelName`表示模型简名，`tarParentModel`表示目标父模型全名，默认为空，表示复制到顶层，`newModelName`表示新模型简名，默认为空，表示与原模型一致。
    示例
    示例1：按参数配置复制一个模型
        加载标准模型库Modelica，限定参数，按照配置从Modelica.Blocks.Examples下复制PID_Controller模型，到rootpackage下，新复制的模型名称为CopyModel。
        >>> LoadLibrary("Modelica")
        >>> NewModel(modelName= "rootpackage", restriction= "package", description = "", base = "", parent = "", saveInOneFile = False, partial= False)
        >>> print(CopyModel(srcParentModel="Modelica.Blocks.Examples", modelName="PID_Controller",
        >>> tarParentModel="rootpackage", newModelName= "CopyModel"))
        结果：
        > True
    输入参数
        srcParentModel - 源父模型全名，若为顶层模型，此项为空
        数据类型：str
        modelName - 模型简名
        数据类型：str
        tarParentModel - 目标父模型全名，默认为空，表示复制到顶层
        数据类型：str
        newModelName - 新模型简名，默认为空，表示与原模型一致
        数据类型：str
    返回值
        `bool` : 表示是否复制成功
    另请参阅
        无
    """
    params = inspect.signature(CopyModel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(CopyModel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def RenameModel(srcModelName:str, newModelName:str, parentModel:str = "") -> bool:
    """
    重命名模型
    
    语法
        >>> RenameModel(srcModelName, newModelName, parentModel:str = "")
    说明
        RenameModel(srcModelName, newModelName, parentModel) 用于重命名模型，函数返回值`bool`表示是否改名成功。
    示例
    示例1：修改自建模型的名称
        DoublePendulum 模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI 文件夹下
        加载自建模型文件`DoublePendulum.mo`，修改模型名称为`NewTestmodel`
        >>> OpenModelFile(OpenModelFile(GetInstallationDirectory() + "\\Docs\\Samples\\PythonAPI\\DoublePendulum.mo")
        >>> print(RenameModel(srcModelName= "DoublePendulum", newModelName= "NewTestmodel"))
        结果：
        > True
    输入参数
        srcModelName - 原模型简名
        数据类型：str
        newModelName - 新模型简名
        数据类型：str
        ParentModel - 父模型全名，缺省为空，表示顶层模型改名
        数据类型：str
    返回值
        `bool` : 表示是否改名成功
    另请参阅
        无
    """
    params = inspect.signature(RenameModel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(RenameModel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SaveModel(modelName:str) -> bool:
    """
    保存指定模型
    
    语法
        >>> SaveModel(modelName)
    说明
        SaveModel(modelName) 用于保存指定模型。
    示例
    示例1：保存自建模型的修改内容
        DoublePendulum 模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下
        加载自建模型文件`DoublePendulum.mo`，设置模型描述为`"This is a test model"`，保存模型DoublePendulum的所有修改。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo")
        >>> print("模型保存前的描述：")
        >>> print(GetModelDescription("DoublePendulum"))
        >>> SetModelDescription("DoublePendulum", "This is a test model")
        >>> SaveModel('DoublePendulum')
        >>> print("模型保存后的描述：")
        >>> print(GetModelDescription("DoublePendulum"))
        结果：
        > 模型保存前的描述：
        > This is a double pendulum model
        > 模型保存后的描述：
        > This is a test model
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        `bool` : 表示是否保存成功
    另请参阅
        无
    """
    params = inspect.signature(SaveModel).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SaveModel, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], False, GetDirectory, Echo)
def SaveModelAs(modelName:str, path:str = "", newModelName:str = "") -> bool:
    """
    模型另存为
    
    语法
        >>> SaveModelAs(modelName, path:str = "", newModelName:str = "")
    说明
        SaveModelAs(modelName, path, newModelName) 用于另存指定模型。
    示例
    示例1：另存自建模型的修改内容
        DoublePendulum 模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下。
        加载自建模型文件`DoublePendulum.mo`，另存模型DoublePendulum为DoublePendulum1
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo")
        >>> print(GetModelDescription("DoublePendulum"))
        >>> SaveModelAs('DoublePendulum', "D:\\Sample", "DoublePendulum1")
        >>> OpenModelFile("D:\\Sample\\DoublePendulum1.mo")
    输入参数
        modelName - 模型全名
        数据类型：str
        path - 保存路径
        数据类型：str
        newModelName - 新的模型简名，默认为空，表示与原模型一致
        数据类型：str
    返回值
        `bool` : 表示是否保存成功
    另请参阅
        无
    """
    params = inspect.signature(SaveModelAs).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SaveModelAs, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SaveAllModels() -> bool:
    """
    保存所有模型
    
    语法
        >>> SaveAllModels()
    说明
        SaveAllModels() 用于保存所有模型，返回bool表示是否保存成功
    示例
    示例1：保存自建模型的修改内容
        新建两个模型NewModel1和NewModel2，然后保存所有模型，默认保存在缓存目录下
        >>> NewModel("NewModel1")
        >>> NewModel("NewModel2")
        >>> print(SaveAllModels())
    输入参数
        无
    返回值
        `bool` : 表示是否保存成功
    另请参阅
        无
    """
    params = inspect.signature(SaveAllModels).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SaveAllModels, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def EraseClasses(classList:tuple) -> bool:
    """
    删除子模型或卸载顶层模型
    
    语法
        >>> EraseClasses(classList)
    说明
        EraseClasses(classList) 用于删除子模型或卸载顶层模型
    示例
    示例1：卸载顶层模型
        加载标准模型库，`Modelica 3.2.1`，卸载顶层模型`Modelica`
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> EraseClasses(('Modelica',))
    示例2：删除子模型
        TestModel104模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI 文件夹下
        加载自建模型`Testmodel104`，删除模型下的子模型`M2`
        >>> OpenModelFile(OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestModel104\\package.mo")
        >>> EraseClasses(('TestModel104.M2'))
    输入参数
        classList - 模型名列表
        数据类型：tuple
    返回值
        `bool` : 表示是否删除成功
    另请参阅
        无
    """
    params = inspect.signature(EraseClasses).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(EraseClasses, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetModelInfo(modelName:str, infoType:str):
    """
    通用的获取模型信息的接口
    
    语法
        >>> GetModelInfo(modelName, infoType)
    说明
        GetModelInfo(modelName, infoType) 是通用的获取模型信息的接口。
    示例
    示例1：获取模型PID_Controller的组件列表
        加载标准模型库Modelica，随后获取模型PID_Controller的组件列表
        >>> LoadLibrary("Modelica")
        >>> print(GetModelInfo("Modelica.Blocks.Examples.PID_Controller","Components"))
        结果：
        >[driveAngle, PI, inertia1, torque, spring, inertia2, kinematicPTP, integrator, speedSensor, loadTorque]
    示例2：获取模型PID_Controller的JSON序列化的仿真设置
        加载标准模型库Modelica，随后获取模型PID_Controller的JSON序列化的仿真设置
        >>> LoadLibrary("Modelica")
        >>> print(GetModelInfo("Modelica.Blocks.Examples.PID_Controller","Experiment"))
        结果：
        >{
            "algorithm": "Dassl",
            "fixedOrInitStepSize": 0,
            "inlineIntegrator": false,
            "inlineStepSize": false,
            "interval": 0.008,
            "isIntervalLength": false,
            "isPieceWiseStep": false,
            "numberOfIntervals": 500,
            "pieceWiseStep": [
            ],
            "startTime": 0,
            "stopTime": 4,
            "storeEvent": 1,
            "tolerance": 0.0001
        }
    示例3：获取模型PID_Controller的全文本
        加载标准模型库Modelica，随后获取模型PID_Controller的全文本
        >>> LoadLibrary("Modelica")
        >>> print(GetModelInfo("Modelica.Blocks.Examples.PID_Controller","Text"))
        结果：
        > model PID_Controller 
        > "Demonstrates the usage of a Continuous.LimPID controller"
        > extends Modelica.Icons.Example;
        > parameter SI.Angle driveAngle=1.570796326794897
        > "Reference distance to move";
        > Modelica.Blocks.Continuous.LimPID PI(
        > k=100,
        > Ti=0.1,
        > yMax=12,
        > Ni=0.1,
        > initType=Modelica.Blocks.Types.Init.SteadyState,
        > controllerType=Modelica.Blocks.Types.SimpleController.PI,
        > limiter(u(start = 0)),
        > Td=0.1) annotation (Placement(transformation(extent={{-56,-20},{-36,0}})));
        > Modelica.Mechanics.Rotational.Components.Inertia inertia1(
        > phi(fixed=true, start=0),
        > J=1,
        > a(fixed=true, start=0)) annotation (Placement(transformation(extent={{2,-20},
        >       {22,0}})));
        >
        >   Modelica.Mechanics.Rotational.Sources.Torque torque annotation (Placement(
        >         transformation(extent={{-25,-20},{-5,0}})));
        >   Modelica.Mechanics.Rotational.Components.SpringDamper spring(
        >     c=1e4,
        >     d=100,
        >     stateSelect=StateSelect.prefer,
        >     w_rel(fixed=true)) annotation (Placement(transformation(extent={{32,-20},
        >             {52,0}})));
        >   Modelica.Mechanics.Rotational.Components.Inertia inertia2(J=2) annotation (
        >       Placement(transformation(extent={{60,-20},{80,0}})));
        >   Modelica.Blocks.Sources.KinematicPTP kinematicPTP(
        >     startTime=0.5,
        >     deltaq={driveAngle},
        >     qd_max={1},
        >     qdd_max={1}) annotation (Placement(transformation(extent={{-92,20},{-72,
        >             40}})));
        >   Modelica.Blocks.Continuous.Integrator integrator(initType=Modelica.Blocks.Types.Init.InitialState)
        >     annotation (Placement(transformation(extent={{-63,20},{-43,40}})));
        >   Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
        >       Placement(transformation(extent={{22,-50},{2,-30}})));
        >   Modelica.Mechanics.Rotational.Sources.ConstantTorque loadTorque(
        >       tau_constant=10, useSupport=false) annotation (Placement(transformation(
        >           extent={{98,-15},{88,-5}})));
        > initial equation
        >   der(spring.w_rel) = 0;
        >
        > equation
        >   connect(spring.flange_b, inertia2.flange_a)
        >     annotation (Line(points={{52,-10},{60,-10}}));
        >   connect(inertia1.flange_b, spring.flange_a)
        >     annotation (Line(points={{22,-10},{32,-10}}));
        >   connect(torque.flange, inertia1.flange_a)
        >     annotation (Line(points={{-5,-10},{2,-10}}));
        >   connect(kinematicPTP.y[1], integrator.u)
        >     annotation (Line(points={{-71,30},{-65,30}}, color={0,0,127}));
        >   connect(speedSensor.flange, inertia1.flange_b)
        >     annotation (Line(points={{22,-40},{22,-10}}));
        >   connect(loadTorque.flange, inertia2.flange_b)
        >     annotation (Line(points={{88,-10},{80,-10}}));
        >   connect(PI.y, torque.tau)
        >     annotation (Line(points={{-35,-10},{-27,-10}}, color={0,0,127}));
        >   connect(speedSensor.w, PI.u_m)
        >     annotation (Line(points={{1,-40},{-46,-40},{-46,-22}}, color={0,0,127}));
        >   connect(integrator.y, PI.u_s) annotation (Line(points={{-42,30},{-37,30},{-37,
        >           11},{-67,11},{-67,-10},{-58,-10}}, color={0,0,127}));
        >   annotation (
        >     Diagram(coordinateSystem(
        >         preserveAspectRatio=true,
        >         extent={{-100,-100},{100,100}}), graphics={
        >         Rectangle(extent={{-99,48},{-32,8}}, lineColor={255,0,0}),
        >         Text(
        >           extent={{-98,59},{-31,51}},
        >           textColor={255,0,0},
        >           textString="reference speed generation"),
        >         Text(
        >           extent={{-98,-46},{-60,-52}},
        >           textColor={255,0,0},
        >           textString="PI controller"),
        >         Line(
        >           points={{-76,-44},{-57,-23}},
        >           color={255,0,0},
        >           arrow={Arrow.None,Arrow.Filled}),
        >         Rectangle(extent={{-25,6},{99,-50}}, lineColor={255,0,0}),
        >         Text(
        >           extent={{4,14},{71,7}},
        >           textColor={255,0,0},
        >           textString="plant (simple drive train)")}),
        >     experiment(StopTime=4),
        >     Documentation();
        > end PID_Controller;
    输入参数
        modelName - 模型全名
        数据类型：str

        infoType - 信息的字段类型
        数据类型：str
        包含以下字段：
        - Specialization（限定类型）
        - Description（描述）
        - NestClasses（子类）
        - Text（全文本）
        - Prefixes（前缀列表）
        - Experiment（试验属性）
        - Imports（引用类型列表）
        - Extends（基类列表）
        - Equations（方程列表）
        - Algorithm（算法文本）
        - Connections（连线列表）
        - Components（组件列表，含基本类型变量）
    返回值
        返回的值，类型不强制规定，每种属性有自己的类型
    另请参阅
        无
    """
    params = inspect.signature(GetModelInfo).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetModelInfo, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetModelInfo(modelName:str, infoType:str, value:str) -> bool:
    """
    通用的设置模型信息的接口
    
    语法
        >>> SetModelInfo(modelName, infoType, value)
    说明
        SetModelInfo(modelName, infoType, value) 是通用的设置模型信息的接口。
    示例
    示例1：设置模型的文本描述
        DoublePendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下
        加载模型文件DoublePendulum.mo，随后修改模型文本描述，获取修改后的模型的文本描述
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\DoublePendulum.mo")
        >>> print(SetModelInfo("DoublePendulum","Description","description_content"))
        >>> print(GetModelInfo("DoublePendulum","Description"))
        结果：
        >True
        description_content
    示例2：设置模型的前缀节点列表为['replaceable']
        DoublePendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件DoublePendulum.mo，随后设置模型的前缀节点列表为['replaceable']，获取修改后的模型的前缀列表。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\DoublePendulum.mo")
        >>> print(SetModelInfo("DoublePendulum",'Prefixes', 'replaceable'))
        >>> print(GetModelInfo("DoublePendulum","Prefixes"))
        结果：
        >True
        public replaceable
    示例3：设置模型的积分算法为Euler
        DoublePendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下
        加载模型文件DoublePendulum.mo，随后设置模型的积分算法为Euler，获取修改后的模型的积分算法。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\DoublePendulum.mo")
        >>> ExperimentDist = {"algorithm": "Euler"}
        >>> print(SetModelInfo("DoublePendulum","Experiment",json.dumps(ExperimentDist)))
        >>> print(GetModelInfo("DoublePendulum","Experiment"))
        结果：
        >True
        {
            "algorithm": "Euler",
            "fixedOrInitStepSize": 0.002,
            "inlineIntegrator": false,
            "inlineStepSize": false,
            "interval": 0.002,
            "isIntervalLength": false,
            "isPieceWiseStep": false,
            "numberOfIntervals": 500,
            "pieceWiseStep": [
            ],
            "startTime": 0,
            "stopTime": 1,
            "storeEvent": 1,
            "tolerance": 0.0001
        }
    示例4：设置带有路径的描述信息
        DoublePendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件DoublePendulum.mo，随后修改模型文本描述，获取修改后的模型的文本描述。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\DoublePendulum.mo")
        >>> print(SetModelInfo("DoublePendulum","Description",r'文件结果在"D:\\Data"目录下'))
        >>> print(GetModelInfo("DoublePendulum","Description"))
        结果：
        >True
        文件结果在"D:\\Data"目录下
    输入参数
        modelName - 模型全名
        数据类型：str

        infoType - 信息的字段类型
        数据类型：str
        `infoType` 支持的值及对应的接口设置值格式列于下表：
        | infoType           | 设置值内容及格式                           | 设置值示例                   |
        |--------------------|--------------------------------------------|------------------------------|
        | "Specialization"   | 模型的特化类型                              | "connector"                  |
        | "Description" | 模型的描述内容 |
        | "Text" | 模型的全文本 |
        | "Prefixes" | 模型的前缀 |
        | "Experiment" | JSON 序列化的仿真设置 |
        | "Imports" | 模型的所有 import 语句，语句间以换行符分隔 |
        | "Extends" | 模型的所有 extends 语句，语句间以换行符分隔 |
        | "Equations" | 模型的所有方程表达式，以换行符分隔 |
        | "Algorithms" | 模型的所有算法表达式，以换行符分隔 |
        Json值示例：
        | 键                  | 值内容及格式                                   | 示例                 |
        |---------------------|------------------------------------------------|----------------------|
        | "startTime"         | double                                         | 0.1                  |
        | "stopTime" | double |
        | "numberOfIntervals" | int |
        | "interval" | double |
        | "isIntervalLength" | bool |
        | "algorithm" | string, 可能的值："Dassl","Ida","Mebdfi", "Lsodar", "Lsode", "Cvode", "Mebdf", "Radau5", "Sdirk34", "Esdirk23", "Esdirk34", "Esdirk45", "Dopri5", "Dop853", "Euler", "Rkfix2", "Rkfix3", "Rkfix4", "Rkfix6", "Rkfix8", "ImplicitEuler", "ImplicitTrapezoid", "InlineImplicitEuler", "InlineImplicitTrapezoid" |
        | "tolerance" | double |
        | "fixedOrInitStepSize" | double |
        | "isPieceWiseStep" | bool |
        | "pieceWiseStep" | double 二维数组 |
        | "inlineIntegrator" | bool |
        | "inlineStepSize" | int |
        | "storeEvent" | int, 0 表示不存储，1 表示跟随上一次设置，2 表示存储 |
        
        value - 值
        数据类型：str
        
    返回值
        `bool` : 是否设置成功。设置失败返回false。部分属性无法设置的，如components，也返回false
    另请参阅
        无
    """
    params = inspect.signature(SetModelInfo).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetModelInfo, args=args, kwargs={}, expected_types = expected_types)

#--------------------------组件操作命令-------------------------
@mw_connect_decorator(_MwConnect._process_path)
def GetComponentInfo(modelName:str, component:str, infoType:str):
    """
    通用的获取组件属性的接口
    
    语法
        >>> GetComponentInfo(modelName, component, infoType)
    说明
        GetComponentInfo(modelName, component, infoType) 是通用的获取组件属性的接口。
    示例
    示例1：获取模型Pendulum中的组件world的组件类型
        加载标准模型库Modelica，并获取模型Pendulum中的组件world的组件类型
        >>> LoadLibrary("Modelica")
        >>> print(GetComponentInfo("Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum","world","Type"))
        结果：
        >Modelica.Mechanics.MultiBody.World
    示例2：获取模型Pendulum中的组件world的组件描述
        加载标准模型库Modelica，并获取模型Pendulum中的组件world的组件描述
        >>> LoadLibrary("Modelica")
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(GetComponentInfo("Pendulum","world","Description"))
        结果：
        >test of description
    示例3：获取模型Pendulum中的组件world的组件前缀
        加载标准模型库Modelica，并获取模型Pendulum中的组件world的组件前缀
        >>> LoadLibrary("Modelica")
        >>> print(GetComponentInfo("Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum","world","Prefixes"))
        结果：
        >public inner
    输入参数
        modelName - 模型全名
        数据类型：str

        component - 组件名
        数据类型：str

        infoType - 属性的字段类型
        数据类型：str
        支持的值及对应的接口返回值格式列于下表：
        | 键名          | 返回值内容及格式 | 返回值示例                    |
        | ------------- | ---------------- | ----------------------------- |
        | `Type`        | 组件类型         | Modelica.Units.SI.Length      |
        | `Description` | 组件描述         | this is a subsystem           |
        | `Prefixes`    | 组件前缀         | protected replaceable         |
        | `Dimension`   | 组件维度         | [4]                           |
        | `Condition`   | 组件条件         | false                         |
        | `Constraint`  | 组件约束子句     | Modelica.Blocks.Continuous.PI |
    返回值
        返回的值，类型不强制规定，每种属性有自己的类型
    另请参阅
        无
    """
    params = inspect.signature(GetComponentInfo).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetComponentInfo, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def SetComponentInfo(modelName:str, component:str, infoType:str, value:str) -> bool:
    """
    通用的设置组件属性的接口
    
    语法
        >>> SetComponentInfo(modelName, component, infoType, value)
    说明
        SetComponentInfo(modelName, component, infoType, value) 是通用的设置模型属性的接口。
    示例
    示例1：设置模型 Pendulum 中的组件 world 的描述文本
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件Pendulum.mo，并设置模型中的组件world的描述文本，随后获取该组件的描述文本。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(SetComponentInfo("Pendulum","world","Description","test of description"))
        >>> print(GetComponentInfo("Pendulum","world","Description"))
        结果：
        >True
        test of description
    示例2：设置模型Pendulum中的组件world的组件条件为True
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件Pendulum.mo，并设置模型中的组件world的组件条件为false，随后获取组件条件。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(SetComponentInfo("Pendulum","world","Condition","false"))
        >>> print(GetComponentInfo("Pendulum","world","Condition"))
        结果：
        >True
        false
    示例3：设置模型Pendulum中的组件world的组件维度为4
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件Pendulum.mo，并设置模型中的组件world的组件维度为4，随后获取组件维度。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(SetComponentInfo("Pendulum","world","Dimension","[4]"))
        >>> print(GetComponentInfo("Pendulum","world","Dimension"))
        结果：
        >True
        [4]
    输入参数
        modelName - 模型全名
        数据类型：str

        component - 组件名
        数据类型：str

        infoType - 属性的字段类型
        数据类型：str
        字段包括：
        - `Type`（类型）
        - `Description`（描述）
        - `Prefixes`（前缀列表）
        - `Dimension`（维度信息）
        - `Condition`（组件条件）
        - `Constraint`（组件约束子句）
        - `Rotation`（旋转角）（暂不支持）
        - `Extent`（包围盒）（暂不支持）
        - `Commented`（被注释）（暂不支持）
        - `Layer`（图层）（暂不支持）
        
        value - 属性的值
        数据类型：str
    返回值
        `bool` : 是否设置成功。设置失败返回false。部分属性无法设置的，也返回false
    另请参阅
        无
    """
    params = inspect.signature(SetComponentInfo).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetComponentInfo, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def GetModelParamList(modelName:str, component:str):
    """
    获取模型中某个组件的参数列表
    
    语法
        >>> GetModelParamList(modelName, component)
    说明
        GetModelParamList(modelName, component) 用于获取模型中某个组件的参数列表，函数返回一个列表形式的参数名。
    示例
    示例1：获取模型Pendulum中的组件world的参数列表
        加载标准模型库，并获取模型Pendulum中的组件world的参数列表。
        >>> LoadLibrary("Modelica")
        >>> print(GetModelParamList("Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum","world"))
        结果：
        >['enableAnimation', 'animateWorld', 'animateGravity', 'animateGround', 'label1', 'label2', 'gravityType', 'g', 'n', 'mu', 'driveTrainMechanics3D', 'axisLength', 'axisDiameter', 'axisShowLabels', 'axisColor_x', 'axisColor_y', 'axisColor_z', 'gravityArrowTail', 'gravityArrowLength', 'gravityArrowDiameter', 'gravityArrowColor', 'gravitySphereDiameter', 'gravitySphereColor', 'groundAxis_u', 'groundLength_u', 'groundLength_v', 'groundColor', 'nominalLength', 'defaultAxisLength', 'defaultJointLength', 'defaultJointWidth', 'defaultForceLength', 'defaultForceWidth', 'defaultBodyDiameter', 'defaultWidthFraction', 'defaultArrowDiameter', 'defaultFrameDiameterFraction', 'defaultSpecularCoefficient', 'defaultN_to_m', 'defaultNm_to_m']
    输入参数
        modelName - 模型全名
        数据类型：str
        component - 组件名
        数据类型：str
    返回值
        `list` : 列表形式的组件参数名
    另请参阅
        无
    """

    params = inspect.signature(GetModelParamList).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetModelParamList, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetModelParamValue(modelName:str, component:str, paramName:str):
    """
    获取参数值
    
    语法
        >>> GetModelParamValue(modelName, component, paramName)
    说明
        GetModelParamValue(modelName, component, paramName) 用于获取参数值。返回值是参数变型表达式的字符串表示，而非估算后的数值。支持Sysblock，每个Sysblock可以返回的参数，通过Sysblock的模块帮助，获取失败返回None
    示例
    示例1：获取模型Pendulum中的组件world的参数g的值
        加载标准模型库，并获取模型Pendulum中的组件world的参数g的值。
        >>> LoadLibrary("Modelica")
        >>> print(GetModelParamValue("Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum","world", "g"))
        结果：
        >Modelica.Constants.g_n
    输入参数
        modelName - 模型全名
        数据类型：str
        component - 组件名
        数据类型：str
        paramName - 参数名
        数据类型：str
    返回值
        `str` : 参数变型表达式的字符串表示
    另请参阅
        无
    """
    params = inspect.signature(GetModelParamValue).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetModelParamValue, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def SetModelParamValue(modelName:str, component:str, paramName:str, value:str) -> bool:
    """
    设置指定modelName模型指定参数的值
    
    语法
        >>> SetModelParamValue(modelName, component, paramName, value)
    说明
        SetModelParamValue(modelName, component, paramName, value) 用于设置指定模型指定参数的值，支持设置内置类型属性。支持Sysblock。
    示例
    示例1：设置模型Pendulum中的组件world的参数g的值
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件Pendulum.mo，并设置模型中的组件world的组件维度为4，随后获取组件维度。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(SetModelParamValue("Pendulum","world", "g", "9.81"))
        >>> print(GetModelParamValue("Pendulum","world", "g"))
        结果：
        >True
        9.81
    输入参数
        modelName - 模型全名
        数据类型：str
        component - 组件名
        数据类型：str
        paramName - 参数名
        数据类型：str
        value - 参数值
        数据类型：str
    返回值
        `bool` : 表示修改是否成功
    另请参阅
        无
    """
    params = inspect.signature(SetModelParamValue).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetModelParamValue, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def AddComponent(typeName:str, modelName:str, name:str, x = 0.0, y = 0.0, width = 20.0, height = 20.0, **kwargs) -> bool:
    """
    在modelName模型下添加typeName类型的组件
    
    语法
        >>> AddComponent(typeName, modelName)
        >>> AddComponent(typeName, modelName, name, x, y, width, height)
    说明
        AddComponent(typeName, modelName) 用于在指定模型下以默认参数和位置添加 typeName 类型的组件
        AddComponent(typeName, modelName, name, x, y, width, height) 用于在指定模型下以指定的坐标位置和长宽大小添加 typeName 类型的组件。
    示例
    示例1：在自建模型中加入组件
        DoublePendulum.mo 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        打开自建模型`DoublePendulum`，在指定模型DoublePendulum的（70.0,0.0）的位置添加组件`Modelica.Mechanics.MultiBody.Parts.BodyBox`，命名为boxBody2，宽度为20.0，高度为20.0。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo")
        >>> OpenModel('DoublePendulum')
        >>> RemoveComponent('DoublePendulum', 'boxBody2')
        >>> AddComponent('Modelica.Mechanics.MultiBody.Parts.BodyBox', 'DoublePendulum','boxBody2', 70, 0, 20.0, 20.0)
    输入参数
        typeName - 组件的类型
        数据类型：str
        modelName - 组件要插入的模型
        数据类型：str
        name - 组件名
        数据类型：str
        x - 组件位置的x坐标
        数据类型：float
        y - 组件位置的y坐标
        数据类型：float
        width - 组件的宽度
        数据类型：float
        height - 组件的高度
        数据类型：float
    返回值
        `bool` : 表示添加是否成功
    另请参阅
        OpenModel
    """
    if type(x) == int or type(x) == float:
        x = float(x)
    else:
        _CheckArgTypes('AddComponent', x, 'x', [int, float])
    if type(y) == int or type(y) == float:
        y = float(y)
    else:
        _CheckArgTypes('AddComponent', y, 'y', [int, float])
    if type(width) == int or type(width) == float:
        width = float(width)
    else:
        _CheckArgTypes('AddComponent', width, 'width', [int, float])
    if type(height) == int or type(height) == float:
        height = float(height)
    else:
        _CheckArgTypes('AddComponent', height, 'height', [int, float])
    params = inspect.signature(AddComponent).parameters
    if kwargs != {}:
        valid_kwargs = set(params.keys())
        valid_kwargs.update(["ident"])
        # 判断参数是否传递正确
        for key in kwargs:
            if key in valid_kwargs:
                continue
            raise TypeError(f"AddComponent() got an unexpected keyword argument '{key}'")
        # 兼容旧版调用
        name = kwargs["ident"]

    args = tuple(v for k, v in locals().items() if k not in ('kwargs'))
    expected_types = [v.annotation for k, v in params.items() if k != 'kwargs']
    expected_types[list(params.keys()).index('x')] = type(x)
    expected_types[list(params.keys()).index('y')] = type(y)
    expected_types[list(params.keys()).index('width')] = type(width)
    expected_types[list(params.keys()).index('height')] = type(height)
    return _MwConnect.__RunCurrentFunction__(AddComponent, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def AddGotoComponent(modelName:str, name:str, portType:str, portDimension:list = [], x = 0.0, y = 0.0, width = 20.0, height = 20.0, tagVisibility:str = 'Local') -> bool:
    """
    创建GOTO组件
    
    语法
        >>> AddGotoComponent(modelName, name, portType)
        >>> AddGotoComponent(modelName, name, portType, portDimension, x, y, width, height, tagVisibility)
    说明
        AddGotoComponent(modelName, name, portType) 用于以默认参数创建 GOTO 组件，函数返回`bool`值，表示创建是否成功。
        AddGotoComponent(modelName, name, portType, portDimension, x, y, width, height, tagVisibility) 用于指定各个参数并创建 GOTO 组件，函数返回`bool`值，表示创建是否成功。
    示例
    示例1：在模型 Pendulum 中添加 GOTO 组件
        Pendulum 模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下。
        加载 Pendulum 模型文件，并在模型Pendulum中添加GOTO组件。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(AddGotoComponent("Pendulum","goto_1", "Real", x=-50))
        结果：
        >True
    输入参数
        modelName - 要添加到的模型全名
        数据类型：str
        name - 生成的组件名，已有重名则报错
        数据类型：str
        portType - 端口类型，目前仅支持Real、Boolean、Integer
        数据类型：str
        portDimension - 维度，使用一维数组表示，例如[2, 3]表示二维，的2 * 3 的矩阵
        数据类型：list
        x - 组件位置的 x 坐标，默认为 0
        数据类型：float
        y - 组件位置的 y 坐标，默认为 0
        数据类型：float
        width - 组件的宽度，为0时表示不显示图形
        数据类型：float
        heigh - 组件的高度，为0时表示不显示图形
        数据类型：float
        tagVisibility - 可见性，用于Sysblock，物理建模中默认为Local，如果不是需要报错
        数据类型：str
    返回值
        `bool` : 表示创建是否成功
    另请参阅
        无
    """
    if type(x) == int or type(x) == float:
        x = float(x)
    else:
        _CheckArgTypes('AddGotoComponent', x, 'x', [int, float])
    if type(y) == int or type(y) == float:
        y = float(y)
    else:
        _CheckArgTypes('AddGotoComponent', y, 'y', [int, float])
    if type(width) == int or type(width) == float:
        width = float(width)
    else:
        _CheckArgTypes('AddGotoComponent', width, 'width', [int, float])
    if type(height) == int or type(height) == float:
        height = float(height)
    else:
        _CheckArgTypes('AddGotoComponent', height, 'height', [int, float])
    for dim in portDimension:
        if type(dim) is not float and type(dim) is not int:
            _CheckArgTypes('AddGotoComponent', dim, 'portDimension[]', [int, float])
    params = inspect.signature(AddGotoComponent).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('x')] = type(x)
    expected_types[list(params.keys()).index('y')] = type(y)
    expected_types[list(params.keys()).index('width')] = type(width)
    expected_types[list(params.keys()).index('height')] = type(height)
    return _MwConnect.__RunCurrentFunction__(AddGotoComponent, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def AddFromComponent(gotoName:str, modelName:str, name:str, x = 0.0, y = 0.0, width = 20.0, height = 20.0) -> bool:
    """
    创建FROM组件
    
    语法
        >>> AddFromComponent(gotoName, modelName, name)
        >>> AddFromComponent(gotoName, modelName, name, x, y, width, height)
    说明
        AddFromComponent(gotoName, modelName, name) 用于以默认的位置和大小创建 FROM 组件，函数返回`bool`值，表示创建是否成功。
        AddFromComponent(gotoName, modelName, name, x, y, width, height) 用于以指定的位置和大小创建 FROM 组件，函数返回`bool`值，表示创建是否成功。
    示例
    示例1：在模型Pendulum中添加FROM组件
        Pendulum 模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI文件夹下。
        加载 Pendulum 模型文件，并在模型Pendulum中添加GOTO组件。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(AddFromComponent('goto_1','Pendulum','from_1',x=50))
        结果：
        >True
    输入参数
        gotoName - 要连接的GOTO组件名
        数据类型：str
        modelName - 要添加到的模型全名
        数据类型：str
        name - 生成的组件名，已有重名则报错
        数据类型：str
        x - 组件位置的 x 坐标，默认为 0
        数据类型：float
        y - 组件位置的 y 坐标，默认为 0
        数据类型：float
        width - 组件的宽度，为0时表示不显示图形
        数据类型：float
        heigh - 组件的高度，为0时表示不显示图形
        数据类型：float
    返回值
        `bool` : 表示创建是否成功
    另请参阅
        无
    """
    if type(x) == int or type(x) == float:
        x = float(x)
    else:
        _CheckArgTypes('AddFromComponent', x, 'x', [int, float])
    if type(y) == int or type(y) == float:
        y = float(y)
    else:
        _CheckArgTypes('AddFromComponent', y, 'y', [int, float])
    if type(width) == int or type(width) == float:
        width = float(width)
    else:
        _CheckArgTypes('AddFromComponent', width, 'width', [int, float])
    if type(height) == int or type(height) == float:
        height = float(height)
    else:
        _CheckArgTypes('AddFromComponent', height, 'height', [int, float])
    params = inspect.signature(AddFromComponent).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('x')] = type(x)
    expected_types[list(params.keys()).index('y')] = type(y)
    expected_types[list(params.keys()).index('width')] = type(width)
    expected_types[list(params.keys()).index('height')] = type(height)
    return _MwConnect.__RunCurrentFunction__(AddFromComponent, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def CopyComponent(srcModelName:str, tarModelName:str, name:str, tarName:str = "") -> bool:
    """
    复制组件
    
    语法
        >>> CopyComponent(srcModelName, tarModelName, name)
        >>> CopyComponent(srcModelName, tarModelName, name, tarName)
    说明
        CopyComponent(srcModelName, tarModelName, name) 用于从目标模型中选择组件名称并复制到源模型中，使用默认组件名称，函数返回`bool`值，表示创建是否成功。
        CopyComponent(srcModelName, tarModelName, name, tarName) 用于从目标模型中选择组件名称并复制到源模型中，并重新设置组件名称，函数返回`bool`值，表示创建是否成功。
    示例
    示例1：在模型Pendulum中复制一个world组件
        Pendulum 模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI 文件夹下
        加载Pendulum模型文件，并在模型Pendulum中复制一个world组件。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(CopyComponent('Pendulum','Pendulum','world','world2'))
        结果：
        >True
    输入参数
        srcModelName - 源模型全名
        数据类型：str
        tarModelName - 目标模型全名。若两个模型名相同，则在当前模型下复制
        数据类型：str
        name - 生成的组件名，已有重名则报错
        数据类型：str
        tarName - 目标组件名，默认为空 ，表示使用相同的组件名
        数据类型：str
    返回值
        `bool` : 表示复制是否成功
    另请参阅
        无
    """
    params = inspect.signature(CopyComponent).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(CopyComponent, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def RemoveComponent(modelName:str, name:str, withConnect:bool = True) -> bool:
    """
    移除组件
    
    语法
        >>> RemoveComponent(modelName, name)
        >>> RemoveComponent(modelName, name, withConnect)
    说明
        RemoveComponent(modelName, name) 用于移除组件，函数返回`bool`值，表示移除是否成功。
        RemoveComponent(modelName, name, withConnect) 用于移除组件，并指定是否移除链接。函数返回`bool`值，表示移除是否成功。
    示例
    示例1：在模型Pendulum中移除组件
        Pendulum 模型文件默认存储在%安装路径%/Docs/Interface/Samples/SysplorerAPI 文件夹下。
        加载Pendulum模型文件，先在模型Pendulum中复制一个world组件命名为world2，随后将其移除。
        >>> OpenModelFile(r"C:\\Program Files\\MWORKS\\Sysplorer 2025a\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> print(CopyComponent('Pendulum','Pendulum','world','world2'))
        >>> print(RemoveComponent("Pendulum","world2"))
        结果：
        >True
        True
    输入参数
        modelName - 模型全名
        数据类型：str
        name - 组件名
        数据类型：str
        withConnect - 同时删除组件的连线，默认为True
        数据类型：bool
    返回值
        `bool` : 表示删除是否成功
    另请参阅
        无
    """
    params = inspect.signature(RemoveComponent).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(RemoveComponent, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetConnectionInfo(modelName:str, connection:tuple, infoType:str):
    """
    获取连接线信息通用的获取连线属性的接口
    
    语法
        >>> GetConnectionInfo(modelName, connection, infoType)
    说明
        GetConnectionInfo(modelName, connection, infoType) 用于获取连接线信息通用的获取连线属性的接口。
    示例
    示例1：获取模型接线描述信息
        加载标准模型库Modelica，获取模型Pendulum的连接线描述信息。
        >>> LoadLibrary("Modelica")
        >>> print(GetConnectionInfo("Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum",("world.frame_b", 'rev.frame_a'),"Description"))
        结果：
        >test of connecting
    输入参数
        modelName - 模型全名或子系统全名
        数据类型：str

        connection - 连接，使用左右端口名表示
        数据类型：tuple

        infoType - 属性的字段类型
        数据类型：str
        | infoType       | 返回值内容及格式                               | 返回值示例                   |
        |----------------|----------------------------------------------|----------------------------|
        | "Name"         | 信号名                                         | "aaa"                      |
        | "Description" | 连线描述 |
        | "Points" | 连线点，格式为`{{x1, y1}, {x2, y2}, ...}` |
        | "Manhattanize" | 连线是否横平竖直，`true`为是，`false`为否 |
        | "Smooth" | 连线是否光滑，`true`为是，`false`为否 |
    返回值
        返回的值，类型不强制规定，每种属性有自己的类型
    另请参阅
        无
    """
    params = inspect.signature(GetConnectionInfo).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetConnectionInfo, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def SetConnectionInfo(modelName:str, connection:tuple, infoType:str, value:str) -> bool:
    """
    通用的设置连线属性的接口
    
    语法
        >>> SetConnectionInfo(modelName, connection, infoType, value)
    说明
        SetConnectionInfo(modelName, connection, infoType, value) 用于设置连线属性的接口。
    示例
    示例1：设置模型接线描述信息
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\Pendulum.mo")
        >>> SetConnectionInfo("Pendulum" ,("world.frame_b","rev.frame_a"),"Description","New Description")
        >>> print(GetConnectionInfo("Pendulum",("world.frame_b", 'rev.frame_a'),"Description"))
        结果：
        >New Description
    输入参数
        modelName - 模型全名或子系统全名
        数据类型：str

        connection - 连接，使用左右端口名表示
        数据类型：tuple

        infoType - 属性的字段类型
        数据类型：str
        | infoType       | 返回值内容及格式                               | 返回值示例                   |
        |----------------|----------------------------------------------|----------------------------|
        | "Name"         | 信号名                                         | "aaa"                      |
        | "Description" | 连线描述 |
        | "Points" | 连线点，格式为`{{x1, y1}, {x2, y2}, ...}` |
        | "Manhattanize" | 连线是否横平竖直，`true`为是，`false`为否 |
        | "Smooth" | 连线是否光滑，`true`为是，`false`为否 |

        value - 值
        数据类型：str
    返回值
        `bool` : 表示是否设置成功
    另请参阅
        无
    """
    params = inspect.signature(SetConnectionInfo).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetConnectionInfo, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ConnectPort(modelName:str, leftPort:str, rightPort:str, gripPoints:tuple = (), manhattanize:bool = True, smooth:bool = False) -> bool:
    """
    在指定模型下连接两个端口
    
    语法
        >>> ConnectPort(modelName, leftPort, rightPort)
        >>> ConnectPort(modelName, leftPort, rightPort, gripPoints, manhattanize, smooth)
    说明
        ConnectPort(modelName, leftPort, rightPort) 用于在某模型下，指定左右端口，其余按默认参数连接两个端口。
        ConnectPort(modelName, leftPort, rightPort, gripPoints, manhattanize, smooth) 用于在某模型下，指定左右端口，其余参数手动设置连接两个端口。
    示例
        模型文件默认存储在`%安装路径%/Docs/Samples/PythonAPI`文件夹下
    示例1：连接自建模型的u1和y端口
        ModelTestConnect.mo 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件`ModelTestConnect.mo`，在当前模型ModelTestConnect下连接u1和y端口。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\ModelTestConnect.mo")
        >>> modelName = 'ModelTestConnect'
        >>> leftPort = 'realExpression[1].y'
        >>> rightPort = 'add[2].u1'
        >>> ConnectPort(modelName, leftPort, rightPort)
    示例2：连接子系统内部的u和gain.u端口
        SysblockConnect.mo 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件`SysblockConnect.mo`，在当前模型SysblockConnect下的subSystem中连接u和gain.u端口。
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\SysblockConnect.mo")
        >>> modelName = 'SysblockConnect/subSystem'
        >>> leftPort = 'u'
        >>> rightPort = 'gain.u'
        >>> ConnectPort(modelName, leftPort, rightPort)
    输入参数
        modelName - 模型全名或子系统全名
        数据类型：str
        leftPort - 连接左端口名字
        数据类型：str
        rightPort - 连接右端口名字
        数据类型：str
        gripPoints - 连接夹点链表
        数据类型：tuple
        manhattanize - 进行曼哈顿化处理
        数据类型：bool
        smooth - 显示为Bezier光顺曲线
        数据类型：bool
    返回值
        `bool` : 表示是否连接成功
    另请参阅
        无
    """
    params = inspect.signature(ConnectPort).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ConnectPort, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def RemoveConnect(modelName:str, leftPort:str, rightPort:str) -> bool:
    """
    移除连接
    
    语法
        >>> RemoveConnect(modelName, leftPort, rightPort)
    说明
        RemoveConnect(modelName, leftPort, rightPort) 用于移除连接，模型返回`bool`表示是否设置成功
    示例
    示例1：移除模型接线
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下
        加载Pendulum模型文件，移除模型Pendulum的接线。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(RemoveConnect("Pendulum","world.frame_b", 'rev.frame_a'))
        结果：
        >True
    输入参数
        modelName - 模型全名或子系统全名
        数据类型：str
        leftPort - 连接左端口名字
        数据类型：str
        rightPort - 连接右端口名字
        数据类型：str
    返回值
        `bool` : 表示是否删除成功
    另请参阅
        无
    """
    params = inspect.signature(RemoveConnect).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(RemoveConnect, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetClasses(modelName:str):
    """
    获取指定模型的嵌套类型
    
    语法
        >>> GetClasses(modelName)
    说明
        GetClasses(modelName) 用于获取指定模型的嵌套类型。当给定空字符串时，则获取模型浏览器上所有顶层模型列表。
    示例
    示例1：获取Modelica的嵌套模型
        加载标准库`Modelica 3.2.1`，获取Modelica的嵌套模型
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> print("Modelica的嵌套模型：")
        >>> print(GetClasses('Modelica'))
        结果：
        > Modelica的嵌套模型：
        > ['UsersGuide', 'Blocks', 'ComplexBlocks', 'StateGraph', 'Electrical', 'Magnetic', 'Mechanics', 'Fluid', 'Media', 'Thermal', 'Math', 'ComplexMath', 'Utilities', 'Constants', 'Icons', 'SIunits']
    示例2：获取自建模型的所有顶层模型列表
        TestModel104 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载TestModel104模型的子模型`M2.mo`，获取模型浏览器上所有顶层模型列表
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\TestModel104\M2.mo")
        >>> print("自建模型的所有顶层模型列表：")
        >>> print(GetClasses(""))
        结果：
        > 自建模型的所有顶层模型列表：
        > ['Modelica', 'ModelicaServices', 'TYUtility', 'BaseWorkspace', 'SysplorerEmbeddedCoder', 'TestModel104']
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        `list` : 模型的嵌套类型构成的列表
    另请参阅
        无
    """
    params = inspect.signature(GetClasses).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetClasses, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetComponents(modelName:str,component:str = ""):
    """
    获取指定模型的嵌套组件
    
    语法
        >>> GetComponents(modelName)
        >>> GetComponents(modelName,component)
    说明
        GetComponents(modelName) 用于获取指定模型modelName的嵌套组件。
        GetComponents(modelName,component) 用于获取指定模型modelName中component内的嵌套组件。
    示例
    示例1：获取标准库模型的所有嵌套组件
        加载标准库`Modelica 3.2.3`，获取模型Modelica.Blocks.Examples.PID_Controller中的所有嵌套组件
        >>> LoadLibrary('Modelica', '3.2.3')
        >>> print("该模型的所有组件为：")
        >>> GetComponents('Modelica.Blocks.Examples.PID_Controller')
        结果：
        > 该模型的所有组件为：
        > ['driveAngle', 'PI', 'inertia1', 'torque', 'spring', 'inertia2', 'kinematicPTP', 'integrator', 'speedSensor', 'loadTorque']
    示例2：获取Sysblock模型内子系统中的所有嵌套组件
        SubSystemModel模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载模型文件SubSystemModel.mo，获取模型内部子系统subSystem中的嵌套组件
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\SubSystemModel.mo")
        >>> print("该模型的所有组件为：")
        >>> print(GetComponents("SubSystemModel","subSystem"))
        结果：
        > 该模型的所有组件为：
        > ['u', 'y', 'gain']
    输入参数
        modelName - 模型全名
        数据类型：str
        component - 组件名
        数据类型：str
    返回值
        `list` : 模型的嵌套组件构成的列表
    另请参阅
        LoadLibrary
    """
    params = inspect.signature(GetComponents).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetComponents, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetParamList(preName:str = ""):
    """
    获取指定组件前缀层次中的参数列表
    
    语法
        >>> GetParamList(preName = "")
    说明
        GetParamList(preName) 用于获取指定组件前缀层次中的参数列表。返回值列表中的元素为：<参数名-参数类型名>的键-值对。preName若为空，表示获取模型顶层参数。
    示例
    示例1：获取标准库模型某组件的参数列表
        获取模型Modelica.Blocks.Examples.PID_Controller中组件kinematicPTP的参数列表
        >>> LoadLibrary('Modelica', '3.2.3')
        >>> OpenModel('Modelica.Blocks.Examples.PID_Controller', 'diagram')
        >>> print("模型组件的参数列表为：")
        >>> GetParamList('kinematicPTP')
        结果：
        > 模型组件的参数列表为：
        > [{'paramName': 'nout', 'paramType': 'Integer'}, {'paramName': 'deltaq', 'paramType': 'Real'}, {'paramName': 'qd_max', 'paramType': 'Real'}, {'paramName': 'qdd_max', 'paramType': 'Real'}, {'paramName': 'startTime', 'paramType': 'Modelica.SIunits.Time'}]
    输入参数
        preName - 组件前缀名
        数据类型：str
    返回值
        `list` : 指定组件前缀层次中的参数列表
    另请参阅
        LoadLibrary|OpenModel
    """
    params = inspect.signature(GetParamList).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetParamList, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetModelDescription(modelName:str):
    """
    获取指定模型的描述文字
    
    语法
        >>> GetModelDescription(modelName)
    说明
        GetModelDescription(modelName) 用于获取指定模型的描述文字。
    示例
    示例1：获取标准库模型的模型描述
        加载标准模型库`Modelica 3.2.3`，获取Modelica.Blocks.Examples.PID_Controller的模型描述
        >>> LoadLibrary('Modelica', '3.2.3')
        >>> print("模型的描述为：")
        >>> GetModelDescription('Modelica.Blocks.Examples.PID_Controller')
        > 模型的描述为：
        > Demonstrates the usage of a Continuous.LimPID controller
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        `str` : 指定模型的描述文字
    另请参阅
        LoadLibrary
    """
    params = inspect.signature(GetModelDescription).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetModelDescription, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetModelDescription(modelName:str, description:str) -> bool:
    """
    设置指定模型的描述文字,替换原来的描述
    
    语法
        >>> SetModelDescription(modelName, description)
    说明
        SetModelDescription(modelName, description) 用于设置指定模型modelName的描述文字，替换原来的描述。注意，对于模型库或加密模型该命令不可用。
    示例
    示例1：设置指定模型的描述文字
        DoublePendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载自建模型文件`DoublePendulum.mo`，设置模型DoublePendulum的描述信息为"测试模型"。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo")
        >>> SetModelDescription('DoublePendulum', 'This is a double pendulum model')
    输入参数
        modelName - 模型全名
        数据类型：str
        description - 描述文字
        数据类型：str
    返回值
        `bool` : 表示是否成功设置
    另请参阅
        无
    """
    params = inspect.signature(SetModelDescription).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetModelDescription, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['strPath'], True, GetDirectory, Echo)
def ImportModelDataFile(strModelName:str, strPath:str) -> bool:
    """
    导入文件到工作区
    
    语法
        >>> ImportModelDataFile(strModelName, strPath)
    说明
        ImportModelDataFile(strModelName, strPath)
        用于导入工作区文件到工作区中。
        strModelName为空时，表示将文件导入到基础工作区中；strModelName不为空时，它只能是Sysblock模型，表示将文件导入到该模型的模型工作区中。
        若工作区中已存在同名数据，旧的数据会被新导入的数据覆盖。
    示例
    示例1：导入文件到基础工作区
        >>> ImportModelDataFile('', GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestImportExport\\bw.json")
    示例2：导入文件到模型工作区
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestImportExport\\package.mo")
        >>> ImportModelDataFile('TestImportExport.Model1', GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestImportExport\\bw.json")
    输入参数
        strModelName - 模型全名
        数据类型：str
        strPath - 文件路径
        数据类型：str
    返回值
        'bool'：表示是否导入成功
    另请参阅
        ExportModelDataFile
    """
    params = inspect.signature(ImportModelDataFile).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ImportModelDataFile, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['strPath'], False, GetDirectory, Echo)
def ExportModelDataFile(strModelName:str, strPath:str) -> bool:
    """
    导出工作区数据到文件中
    
    语法
        >>> ExportModelDataFile(strModelName, strPath)
    说明
        ExportModelDataFile(strModelName, strPath)
        用于导出工作区数据到文件中。
        strModelName为空时，表示导出基础工作区数据到文件中；strModelName不为空时，它只能是Sysblock模型，导出该模型的模型工作区数据到文件中。
    示例
    示例1：导出基础工作区数据到文件
        >>> ImportModelDataFile('', GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestImportExport\\bw.json")
        >>> ExportModelDataFile('', r"C:\\Users\\DELL\\Documents\\MWORKS\\TestImportExport\\export_bw.json")
    示例2：导出模型工作区数据到文件
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestImportExport\\package.mo")
        >>> ExportModelDataFile('TestImportExport.Model1', r"C:\\Users\\DELL\\Documents\\MWORKS\\TestImportExport\\export_mw.json")
    输入参数
        strModelName - 模型全名
        数据类型：str
        strPath - 文件路径
        数据类型：str
    返回值
        'bool'：表示是否导出成功
    另请参阅
        ImportModelDataFile
    """
    params = inspect.signature(ExportModelDataFile).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ExportModelDataFile, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetWorkspaceEntryProperty(modelName:str, entryName:str, propertyName:str) -> str:
    """
    获取模型工作区数据项属性
    
    语法
        >>> GetWorkspaceEntryProperty(modelName, entryName, propertyName)
    说明
        >>> GetWorkspaceEntryProperty(modelName, entryName, propertyName)
        用于获取模型工作区数据项属性。
    示例
    示例1：获取模型工作区参数值
        TestWorkspace 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载自建模型文件`TestWorkspace.mo`，获取模型TestWorkspace的工作区参数值。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\TestWorkspace.mo")
        >>> GetWorkspaceEntryProperty('TestWorkspace', 'Param1', 'Value')
    输入参数
        modelName - 模型全名
        数据类型：str
    输入参数
        entryName - 数据项名
        数据类型：str
    输入参数
        propertyName - 属性名
        数据类型：str
    返回值
        `str` : 数据项属性值
    另请参阅
        SetWorkspaceEntryProperty
    """
    params = inspect.signature(GetWorkspaceEntryProperty).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetWorkspaceEntryProperty, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def SetWorkspaceEntryProperty(modelName:str, entryName:str, propertyName:str, propertyValue:str) -> bool:
    """
    设置模型工作区数据项属性
    
    语法
        >>> SetWorkspaceEntryProperty(modelName:str, entryName:str, propertyName:str, propertyValue:str)
    说明
        SetWorkspaceEntryProperty(modelName:str, entryName:str, propertyName:str, propertyValue:str)
        用于设置模型工作区数据项属性。
    示例
    示例1：设置模型工作区参数值
        TestWorkspace 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载自建模型文件`TestWorkspace.mo`，设置模型TestWorkspace的工作区参数值。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\TestWorkspace.mo")
        >>> SetWorkspaceEntryProperty('TestWorkspace', 'Param1', 'Value', '2.22')
    输入参数
        modelName - 模型全名
        数据类型：str
    输入参数
        entryName - 数据项名
        数据类型：str
    输入参数
        propertyName - 属性名
        数据类型：str
    输入参数
        propertyValue - 属性值
        数据类型：str
    返回值
        'bool'：表示是否设置成功
    另请参阅
        GetWorkspaceEntryProperty
    """
    params = inspect.signature(SetWorkspaceEntryProperty).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetWorkspaceEntryProperty, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def ClearWorkspace(strModelName:str = "") -> bool:
    """
    清空指定工作区数据
    
    语法
        >>> ClearWorkspace(strModelName)
    说明
        ClearWorkspace(strModelName)
        用于清空指定工作区数据。
        strModelName为空时，表示清空基础工作区数据；strModelName不为空时，它只能是Sysblock模型，表示清空该Sysblock模型的模型工作区数据。
        若该工作区已经没有数据了，仍然会返回True。
    示例
    示例1：清空基础工作区数据
        >>> ClearWorkspace()
    示例2：清空模型工作区数据
        >>> OpenModelFile(GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestImportExport\\package.mo")
        >>> ImportModelDataFile('TestImportExport.Model1', GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestImportExport\\bw.json")
        >>> ClearWorkspace('TestImportExport.Model1')
    输入参数
        strModelName - 模型全名
        数据类型：str
    返回值
        'bool'：表示是否清空
    另请参阅
        ImportModelDataFile
        ExportModelDataFile
    """
    params = inspect.signature(ClearWorkspace).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ClearWorkspace, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['strPath'], False, GetDirectory, Echo)
def BindDataDictionary(strModelName:str, strPath:str, bSaveDict:bool = True) -> bool:
    """
    绑定数据字典文件
    
    语法
        >>> BindDataDictionary(strModelName, strPath, bSaveDict)
    说明
        BindDataDictionary(strModelName, strPath, bSaveDict)
        用于绑定数据字典文件
    示例
    示例1：绑定数据字典文件
        demo_dict.modd字典文件默认存储在‘%安装路径%/Docs/Interface/Samples/SysplorerAPI’文件夹下
        >>> BindDataDictionary('TestBindDataDict.Model1', GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestBindDataDict\\demo_dict.modd")
    输入参数
        strModelName - 模型全名
        数据类型：str
        strPath - 文件路径
        数据类型：str
        bSaveDict - 是否保存当前编辑内容到被替换的字典文件中
        数据类型：bool
    返回值
        'bool'：表示是否绑定成功
    另请参阅
        UnbindDataDictionary
    """
    params = inspect.signature(BindDataDictionary).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(BindDataDictionary, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def UnbindDataDictionary(strModelName:str, bSaveDict: bool = True) -> bool:
    """
    解绑数据字典文件
    
    语法
        >>> UnbindDataDictionary(strModelName, bSaveDict)
    说明
        UnbindDataDictionary(strModelName, bSaveDict)
        用于解绑数据字典文件
    示例
    示例1：解绑数据字典文件
        >>> BindDataDictionary('TestBindDataDict.Model1', GetInstallationDirectory() + "\\Docs\\Interface\\Samples\\SysplorerAPI\\TestBindDataDict\\demo_dict.modd")
        >>> UnbindDataDictionary('TestBindDataDict.Model1')
    输入参数
        strModelName - 模型全名
        数据类型：str
        bSaveDict - 是否保存当前编辑内容到即将解绑的字典文件中
        数据类型：bool
    返回值
        'bool'：表示是否解绑成功
    另请参阅
        BindDataDictionary
    """
    params = inspect.signature(UnbindDataDictionary).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(UnbindDataDictionary, args=args, kwargs={}, expected_types = expected_types)
    
@mw_connect_decorator(_MwConnect._process_path)
def GetComponentDescription(modelName:str, componentName:str):
    """
    获取指定模型中组件的描述文字
    
    语法
        >>> GetComponentDescription(modelName, componentName)
    说明
        GetComponentDescription(modelName, componentName) 用于获取指定模型modelName中组件componentName的描述文字。
    示例
    示例1：获取标准库模型中组件的描述
        加载标准模型库`Modelica 3.2.3`，获取模型Modelica.Blocks.Continuous.PI中组件u的描述
        >>> LoadLibrary("Modelica", '3.2.3')
        >>> print("组件的描述为：")
        >>> GetComponentDescription('Modelica.Blocks.Continuous.PI','u')
        结果：
        > 组件的描述为：
        > Connector of Real input signal
    输入参数
        modelName - 模型全名
        数据类型：str
        componentName - 组件名
        数据类型：str
    返回值
        `str` : 指定模型中组件的描述文字
    另请参阅
        LoadLibrary
    """
    params = inspect.signature(GetComponentDescription).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetComponentDescription, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetComponentDescription(modelName:str, componentName:str, description:str) -> bool:
    """
    设置指定模型中组件的描述文字
    
    语法
        >>> SetComponentDescription(modelName, componentName, description)
    说明
        SetComponentDescription(modelName, componentName, description) 用于设置指定模型中组件的描述文字，注意，对于模型库或加密模型该命令不可用。
    示例
    示例1：设置模型组件的描述文字
        TestModel104 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载自建模型`package.mo`，打开子模型M2窗口，设置模型TestModel104.M2中的组件model1_1的描述信息为"这是一个测试"。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\TestModel104\package.mo")
        >>> OpenModel('TestModel104.M2')
        >>> SetComponentDescription('','model1_1', '这是一个测试')
    输入参数
        modelName - 模型名
        数据类型：str
        componentName - 组件名
        数据类型：str
        description - 描述文字
        数据类型：str
    返回值
        `bool` : 表示是否设置成功
    另请参阅
        无
    """
    params = inspect.signature(SetComponentDescription).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetComponentDescription, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetComponentTypeName(modelName:str, componentName:str, fullName:bool = False):
    """
    获取指定模型中组件的类型名字 
    
    语法
        >>> GetComponentTypeName(modelName, componentName, fullName:bool = False)
    说明
        GetComponentTypeName(modelName, componentName, fullName) 用于获取指定模型中组件的类型名字 ，模型返回`str`表示组件的类型名字
    示例
    示例1：获取模型中组件类型名字
        加载标准模型库Modelica，获取模型Pendulum中world组件的类型名字，并获取全名。
        >>> LoadLibrary("Modelica")
        >>> print(GetComponentTypeName("Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum","world",True))
        结果：
        >Modelica.Mechanics.MultiBody.World
    输入参数
        modelName - 模型全名
        数据类型：str
        componentName - 组件名
        数据类型：str
        fullName - 是否返回类型全名,默认为False
        数据类型：bool
    返回值
        `str` : 组件的类型名字
    另请参阅
        无
    """
    params = inspect.signature(GetComponentTypeName).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetComponentTypeName, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetComponentPorts(modelName:str, componentName:str, portDirection:int = 0):
    """
    获取组件端口
    
    语法
        >>> GetComponentPorts(modelName, componentName, portDirection:int = 0)
    说明
        GetComponentPorts(modelName, componentName, portDirection) 用于获取组件端口。如果不传组件名，获取顶层连接器。函数返回值`list`表示列表形式的组件端口。
    示例
    示例1：获取模型中组件端口
        加载标准模型库Modelica，获取模型Pendulum中组件world的端口。
        >>> LoadLibrary("Modelica")
        >>> print(GetComponentPorts("Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum","world",0))
        结果：
        >['world.frame_b']
    输入参数
        modelName - 模型全名
        数据类型：str
        componentName - 组件名
        数据类型：str
        portDirection - 端口流向，0表示所有，1表示输入，2表示输出，3表示无方向性的
        数据类型：int
    返回值
        `list` : 列表形式的组件端口
    另请参阅
        无
    """
    params = inspect.signature(GetComponentPorts).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetComponentPorts, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetParamValue(paramName:str):
    """
    获取参数值
    
    语法
        >>> GetParamValue(paramName)
    说明
        GetParamValue(paramName) 用于获取参数值。返回值是参数变型表达式的字符串表示，而非估算后的数值。
    示例
    示例1：获取自建模型的参数值
        加载标准模型库`Modelica 3.2.1`，打开模型`Modelica.Blocks.Examples.PID_Controller`，获取参数`driveAngle`的参数值
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> OpenModel("Modelica.Blocks.Examples.PID_Controller")
        >>> print("参数值为：")
        >>> GetParamValue('driveAngle')
        结果：
        > 参数值为：
        > 1.57
    输入参数
        paramName - 参数全名
        数据类型：str
    返回值
        `str` : 参数变型表达式的字符串表示
    另请参阅
        无
    """
    params = inspect.signature(GetParamValue).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetParamValue, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetParamValue(paramName:str, value:str) -> bool:
    """
    设置当前模型指定参数的值，支持设置内置类型属性
    
    语法
        >>> SetParamValue(paramName, value)
    说明
        SetParamValue(paramName, value) 用于设置当前模型指定参数的值，支持设置内置类型属性。
    示例
    示例1：修改自建模型参数的值
        TestModel104 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载自建模型文件`package.mo`，打开模型，设置模型TestModel104中组件M1IN的参数y的值为"60"。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\TestModel104\package.mo")
        >>> OpenModel('TestModel104.M1IN')
        >>> SetParamValue('y', '60')
    示例2：修改自建模型路径参数的值
        TestModel104 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载自建模型文件`package.mo`，打开模型，设置模型TestModel104中组件M1IN的参数y的值为"60"。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\TestModel104\package.mo")
        >>> OpenModel('TestModel104.M1IN')
        >>> SetParamValue('path', r'"D:\\Data"')
    输入参数
        paramName - 参数全名
        数据类型：str
        value - 参数值
        数据类型：str
    返回值
        `bool` : 表示是否设置成功
    另请参阅
        无
    """
    params = inspect.signature(SetParamValue).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetParamValue, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetParamValues(paramValues: dict) -> bool:
    """
    设置当前模型指定参数的值，支持设置内置类型属性
    
    语法
        >>> SetParamValues(paramValues)
    说明
        SetParamValues(paramValues) 用于批量设置当前模型指定参数的值，支持设置内置类型属性。
    示例
    示例1：修改自建模型参数的值
        TestModel104 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载自建模型文件`package.mo`，打开模型，设置模型TestModel104中组件M1IN的参数y的值为"60"。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\TestModel104\package.mo")
        >>> OpenModel('TestModel104.M1IN')
        >>> SetParamValues({'y': '60'})
    示例2：修改自建模型路径参数的值
        TestModel104 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载自建模型文件`package.mo`，打开模型，设置模型TestModel104中组件M1IN的参数y的值为"60"，path的值为"D:\\Data"。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\TestModel104\package.mo")
        >>> OpenModel('TestModel104.M1IN')
        >>> SetParamValues({'y': '60', 'path': r'"D:\\Data"'})
    输入参数
        paramValues - 参数全名与值的键值对
        数据类型：dict
    返回值
        `bool` : 表示是否设置成功
    另请参阅
        无
    """
    params = inspect.signature(SetParamValues).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetParamValues, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetModelText(modelName:str):
    """
    获取模型文本
    
    语法
        >>> GetModelText(modelName)
    说明
        GetModelText(modelName) 用于获取模型文本。函数返回值为模型文本内容。
    示例
    示例1：获取模型文本信息
        加载标准模型库Modelica，获取模型Pendulum的文本信息。
        >>> LoadLibrary("Modelica")
        >>> print(GetModelText("Modelica.Mechanics.MultiBody.Examples.Elementary.Pendulum"))
        结果：
        >model Pendulum "Simple pendulum with one revolute joint and one body"
          extends Modelica.Icons.Example;
          inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.
                UniformGravity) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
          Modelica.Mechanics.MultiBody.Joints.Revolute rev(n={0,0,1},useAxisFlange=true,
            phi(fixed=true),
            w(fixed=true)) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
          Modelica.Mechanics.Rotational.Components.Damper damper(
                                                      d=0.1)
            annotation (Placement(transformation(extent={{-20,30},{0,50}})));
          Modelica.Mechanics.MultiBody.Parts.Body body(m=1.0, r_CM={0.5,0,0})
            annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        equation
          connect(world.frame_b, rev.frame_a)
            annotation (Line(
              points={{-40,0},{-20,0}},
              color={95,95,95},
              thickness=0.5));
          connect(damper.flange_b, rev.axis) annotation (Line(points={{0,40},{0,20},{-10,20},{-10,10}}));
          connect(rev.support, damper.flange_a) annotation (Line(points={{-16,10},{-16,20},{-20,20},{-20,40}}));
          connect(body.frame_a, rev.frame_b) annotation (Line(
              points={{20,0},{0,0}},
              color={95,95,95},
              thickness=0.5));
          annotation (
            experiment(StopTime=5),
            Documentation();
            end Pendulum;
    输入参数
        modelName - 模型全名
        数据类型：str
    返回值
        模型文本内容
    另请参阅
        无
    """
    params = inspect.signature(GetModelText).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetModelText, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def EditModelText(modelName:str, modelText:str, beginLine, endLine) -> bool:
    """
    编辑模型的Modelica文本内容
    
    语法
        >>> EditModelText(modelName, modelText, beginLine, endLine)
    说明
        EditModelText(modelName, modelText, beginLine, endLine) 用于编辑模型的Modelica文本内容，只能编辑整行，将从第`beginLine`末尾到第`endLine`行末尾的文本替换为`modelText`的内容。
    示例
    示例1：编辑模型的Modelica文本内容
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，编辑模型Pendulum的文本内容。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(EditModelText("Pendulum","\"Simple pendulum with one revolute joint and one body\"", 16,17))
    输入参数
        modelName - 模型全名
        数据类型：str
        modelText - Modelica 文本
        数据类型：str
        beginLine - 起始行号
        数据类型：int
        endLine - 终止行号
        数据类型：int
    返回值
        `bool` : 表示是否成功编辑
    另请参阅
        无
    """
    if type(beginLine) == int or type(beginLine) == float:
        beginLine = int(beginLine)
    else:
        _CheckArgTypes('EditModelText', beginLine, 'beginLine', [int, float])
    if type(endLine) == int or type(endLine) == float:
        endLine = int(endLine)
    else:
        _CheckArgTypes('EditModelText', endLine, 'endLine', [int, float])
    params = inspect.signature(EditModelText).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('beginLine')] = type(beginLine)
    expected_types[list(params.keys()).index('endLine')] = type(endLine)
    return _MwConnect.__RunCurrentFunction__(EditModelText, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SetModelText(modelName:str, modelText:str) -> bool:
    """
    修改模型的Modelica文本内容
    
    语法
        >>> SetModelText(modelName, modelText)
    说明
        SetModelText(modelName, modelText) 用于修改模型的Modelica文本内容。
    示例
    示例1：修改模型的文本内容
        DoublePendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下
        加载自建模型`DoublePendulum.mo`，将模型DoublePendulum的文本修改为'model a Real x=time; end a;'
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\DoublePendulum.mo")
        >>> SetModelText('DoublePendulum', 'model a Real x=time; end a;')
    输入参数
        modelName - 模型全名
        数据类型：str
        modelText - Modelica文本
        数据类型：str
    返回值
        `bool` : 表示是否成功设置
    另请参阅
        无
    """
    params = inspect.signature(SetModelText).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetModelText, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetVarValueAt(varName:str, time = SimulationTime.End):
    """
    获取变量在特定时刻的值
    
    语法
        >>> GetVarValueAt(varName)
        >>> GetVarValueAt(varName, time)
    说明
        GetVarValueAt(varName) 用于获取变量在默认仿真结束时刻的值。
        GetVarValueAt(varName, time) 用于获取变量在特定时刻的值，带查询时刻可以是数值或SimulationTime.Begin和SimulationTime.End。
    示例
    示例1：获取变量在仿真开始时刻的值
        加载标准模型库`Modelica 3.2.3`，以视图模式打开模型`Modelica.Blocks.Examples.PID_Controller`，仿真模型，获取inertia1.J变量在仿真开始时刻的值
        >>> LoadLibrary('Modelica', '3.2.3')
        >>> OpenModel('Modelica.Blocks.Examples.PID_Controller', 'diagram')
        >>> SimulateModel('Modelica.Blocks.Examples.PID_Controller')
        >>> print("在仿真开始时刻的值为：")
        >>> GetVarValueAt('inertia1.J', pyapi.SimulationTime.Begin)
        结果：
        > 在仿真开始时刻的值为：
        > 1.0
    示例2：获取变量在仿真第1秒时的值
        加载标准模型库`Modelica 3.2.3`，以视图模式打开模型`Modelica.Blocks.Examples.PID_Controller`，仿真模型，获取inertia1.J变量在仿真1秒时的值
        >>> LoadLibrary('Modelica', '3.2.3')
        >>> OpenModel('Modelica.Blocks.Examples.PID_Controller', 'diagram')
        >>> SimulateModel('Modelica.Blocks.Examples.PID_Controller')
        >>> print("在仿真开始后 1 秒的值为：")
        >>> GetVarValueAt('inertia1.J', 1)
        结果：
        > 在仿真开始后1秒的值为：
        > 1.0
    输入参数
        varName - 变量名
        数据类型：str
        libraryVersion - 待查询的时刻
        数据类型：float | str
    返回值
        变量在特定时刻的值
    另请参阅
        SimulateModel
    """
    if type(time) == int or type(time) == float:
        time = float(time)
    elif type(time) == str and (time == SimulationTime.Begin or time == SimulationTime.End):
        pass
    else:
        _CheckArgTypes('GetVarValueAt', time, 'time', [int, float])
    if not _CheckVarExisting(varName):
        return False
    times = _GetVarTimes()
    if time == SimulationTime.Begin:
        if  len(times) <=  0:
           time = 0
        else:
            time = times[0]
    elif time == SimulationTime.End:
        if  len(times) <=  0:
           time = 0
        else:
            time = times[len(times)-1]
    if len(times) != 0:
        if time < times[0]:
            return False
        if time > times[len(times)-1]:
            time = times[len(times)-1]
    params = inspect.signature(GetVarValueAt).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params','times'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('time')] = type(time)
    return _MwConnect.__RunCurrentFunction__(GetVarValueAt, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetVarsValueAt(varNames:list = [], time = SimulationTime.End):
    """
    批量获取所有给定变量在特定时刻的值
    
    语法
        >>> GetVarsValueAt(varNames)
        >>> GetVarsValueAt(varNames, time)
    说明
        GetVarsValueAt(varNames) 用于批量获取给定变量在默认仿真结束时刻的值。
        GetVarsValueAt(varNames, time) 用于批量获取给定变量在特定时刻的值，带查询时刻可以是数值或SimulationTime.Begin和SimulationTime.End。
    示例
    示例1：批量获取变量在仿真第1秒时的值
        >>> LoadLibrary('Modelica', '3.2.3')
        >>> OpenModel('Modelica.Blocks.Examples.PID_Controller', 'diagram')
        >>> SimulateModel('Modelica.Blocks.Examples.PID_Controller')
        >>> GetVarsValueAt(['inertia1.J', 'inertia1.phi', 'inertia1.w', 'inertia1.a'], 1)
        结果：
        > [1.0, 0.1219993180706224, 0.500005922835674, 1.0000477600586493]
    输入参数
        varNames - 变量名
        数据类型：list
        time - 待查询的时刻
        数据类型：float
    返回值
        变量在特定时刻的值
    另请参阅
        GetVarValueAt
    """
    for item in varNames:
        if type(item)==  str:
            pass
        else:
            _CheckArgTypes('GetVarsValueAt',item,'varNames',[type(item)])

    if type(time) == int or type(time) == float:
        time = float(time)
    elif type(time) == str and (time == SimulationTime.Begin or time == SimulationTime.End):
        pass
    else:
        _CheckArgTypes('GetVarsValueAt', time, 'time', [int, float])
    times = _GetVarTimes()
    
    if time == SimulationTime.Begin:
        if  len(times) <=  0:
           time = 0
        else:
            time = times[0]
    elif time == SimulationTime.End:
        if  len(times) <=  0:
            time =  0
        else:
            time = times[len(times)-1]
        
    if len(times) != 0:
        if time < times[0]:
            return []
        if time > times[len(times)-1]:
            time = times[len(times)-1]
    params = inspect.signature(GetVarsValueAt).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params','times'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('time')] = type(time)
    return _MwConnect.__RunCurrentFunction__(GetVarsValueAt, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetVarValues(varName:str):
    """
    获取给定变量的所有时刻值
    
    语法
        >>> GetVarValues(varName)
    说明
        GetVarValues(varName) 用于获取给定变量的所有时刻值，如果varName="time"，则返回时间序列。
    示例
    示例1：获取变量的所有时刻值
        加载标准模型库`Modelica 3.2.3`，以视图模式打开模型`Modelica.Blocks.Examples.PID_Controller`，仿真模型，获取inertia1.J变量的所有时刻值
        >>> LoadLibrary('Modelica', '3.2.3')
        >>> OpenModel('Modelica.Blocks.Examples.PID_Controller', 'diagram')
        >>> SimulateModel('Modelica.Blocks.Examples.PID_Controller')
        >>> print("该变量所有时刻值为：")
        >>> print(GetVarValues('inertia1.J'))
        结果：
        > 该变量所有时刻值为：
        > [array([1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1.])]
    输入参数
        varName - 变量名或"time"
        数据类型：str
    返回值
        给定变量的所有时刻值或时间序列
    另请参阅
        SimulateModel
    """
    if varName == 'time' or _CheckVarExisting(varName):
        params = inspect.signature(GetVarValues).parameters
        args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
        expected_types = [v.annotation for k, v in params.items() if k != 'self']
        return _MwConnect.__RunCurrentFunction__(GetVarValues, args=args, kwargs={}, expected_types = expected_types)
    return False

@mw_connect_decorator(_MwConnect._process_path)
def GetVarsValues(varNames:list = []):
    """
    批量获取所有给定变量的所有时刻值
    
    语法
        >>> GetVarsValues(varNames)
    说明
        GetVarsValues(varNames) 用于批量获取所有给定变量的所有时刻值，如果含有"time"，则返回的是时间序列。
    示例
    示例1：获取给定变量列表的所有时刻值
        加载标准模型库`Modelica 3.2.3`，仿真模型`Modelica.Blocks.Examples.PID_Controller`，获取`['inertia1.J', 'inertia1.phi', 'inertia1.w', 'inertia1.a']`变量的所有时刻值
        >>> LoadLibrary('Modelica', '3.2.1')
        >>> SimulateModel("Modelica.Blocks.Examples.PID_Controller")
        >>> print(GetVarsValues(['inertia1.J', 'inertia1.phi', 'inertia1.w', 'inertia1.a']))
        结果：
        > [array([1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.,
        >        1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.]), array([0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 0.00000000e+00, 0.00000000e+00, 0.00000000e+00,
        >        0.00000000e+00, 8.95606469e-07, 1.74589839e-05, 6.29311929e-05,
        >        1.42422384e-04, 2.60502800e-04, 4.23375535e-04, 6.37741516e-04,
        >        9.09860711e-04, 1.24502717e-03, 1.64729614e-03, 2.11958903e-03,
        >        2.66390675e-03, 3.28153966e-03, 3.97339176e-03, 4.73995925e-03,
        >        5.58136024e-03, 6.49746868e-03, 7.48786131e-03, 8.55205242e-03,
        >        9.68940666e-03, 1.08993103e-02, 1.21811609e-02, 1.35343111e-02,
        >        1.49581144e-02, 1.64519322e-02, 1.80151237e-02, 1.96471995e-02,
        >        2.13475839e-02, 2.31158095e-02, 2.49515550e-02, 2.68542730e-02,
        >        2.88234919e-02, 3.08590164e-02, 3.29604494e-02, 3.51274546e-02,
        >        3.73598300e-02, 3.96577454e-02, 4.20207232e-02, 4.44485278e-02,
        >        4.69409694e-02, 4.94981405e-02, 5.21197816e-02, 5.48057803e-02,
        >        5.75560409e-02, 6.03707978e-02, 6.32498826e-02, 6.61931753e-02,
        >        6.92006061e-02, 7.22721274e-02, 7.54078137e-02, 7.86075658e-02,
        >        8.18713567e-02, 8.51991642e-02, 8.85909920e-02, 9.20469622e-02,
        >        9.55669689e-02, 9.91509998e-02, 1.02799043e-01, 1.06511086e-01,
        >        1.10287141e-01, 1.14127206e-01, 1.18031266e-01, 1.21999318e-01,
        >        1.26031359e-01, 1.30127385e-01, 1.34287423e-01, 1.38511480e-01,
        >        1.42799539e-01, 1.47151597e-01, 1.51567655e-01, 1.56047711e-01,
        >        1.60591766e-01, 1.65199818e-01, 1.69871857e-01, 1.74607890e-01,
        >        1.79407920e-01, 1.84271945e-01, 1.89199965e-01, 1.94191981e-01,
        >        1.99247993e-01, 2.04368001e-01, 2.09552004e-01, 2.14800003e-01,
        >        2.20112004e-01, 2.25488007e-01, 2.30928008e-01, 2.36432010e-01,
        >        2.42000011e-01, 2.47632012e-01, 2.53328013e-01, 2.59088014e-01,
        >        2.64912017e-01, 2.70800020e-01, 2.76752025e-01, 2.82768032e-01,
        >        2.88848041e-01, 2.94992051e-01, 3.01200052e-01, 3.07472052e-01,
        >        3.13808051e-01, 3.20208049e-01, 3.26672046e-01, 3.33200041e-01,
        >        3.39792035e-01, 3.46448026e-01, 3.53168014e-01, 3.59952000e-01,
        >        3.66799982e-01, 3.73711961e-01, 3.80687935e-01, 3.87727905e-01,
        >        3.94831870e-01, 4.01999829e-01, 4.09231797e-01, 4.16527786e-01,
        >        4.23887775e-01, 4.31311766e-01, 4.38799759e-01, 4.46351753e-01,
        >        4.53967750e-01, 4.61647748e-01, 4.69391748e-01, 4.77199751e-01,
        >        4.85071756e-01, 4.93007764e-01, 4.96999769e-01, 4.96999769e-01,
        >        5.01006905e-01, 5.09054394e-01, 5.17136962e-01, 5.25249493e-01,
        >        5.33387415e-01, 5.41544553e-01, 5.49714209e-01, 5.57890122e-01,
        >        5.66066991e-01, 5.74240738e-01, 5.82408632e-01, 5.90568434e-01,
        >        5.98718846e-01, 6.06858889e-01, 6.14988169e-01, 6.23106577e-01,
        >        6.31214452e-01, 6.39312085e-01, 6.47399953e-01, 6.55478552e-01,
        >        6.63548570e-01, 6.71610702e-01, 6.79665556e-01, 6.87713725e-01,
        >        6.95755824e-01, 7.03792457e-01, 7.11824247e-01, 7.19851800e-01,
        >        7.27875713e-01, 7.35896116e-01, 7.43913572e-01, 7.51928455e-01,
        >        7.59941112e-01, 7.67951877e-01, 7.75961021e-01, 7.83968795e-01,
        >        7.91975393e-01, 7.99980952e-01, 8.07985620e-01, 8.15989488e-01,
        >        8.23992612e-01, 8.31995153e-01, 8.39997282e-01, 8.47998986e-01,
        >        8.56000323e-01, 8.64001348e-01, 8.72002139e-01, 8.80002782e-01,
        >        8.88003254e-01, 8.96003569e-01, 9.04003727e-01, 9.12003719e-01,
        >        9.20003662e-01, 9.28003534e-01, 9.36003321e-01, 9.44003028e-01,
        >        9.52002659e-01, 9.60002216e-01, 9.68001831e-01, 9.76001491e-01,
        >        9.84001179e-01, 9.92000907e-01, 1.00000069e+00, 1.00800053e+00,
        >        1.01600038e+00, 1.02400018e+00, 1.03200000e+00, 1.03999985e+00,
        >        1.04799972e+00, 1.05599962e+00, 1.06399956e+00, 1.06999953e+00,
        >        1.06999953e+00, 1.07199942e+00, 1.07998871e+00, 1.08795107e+00,
        >        1.09588051e+00, 1.10377361e+00, 1.11163148e+00, 1.11945634e+00,
        >        1.12724558e+00, 1.13499469e+00, 1.14270045e+00, 1.15036224e+00,
        >        1.15798100e+00, 1.16555709e+00, 1.17309046e+00, 1.18058117e+00,
        >        1.18802922e+00, 1.19543463e+00, 1.20279739e+00, 1.21011750e+00,
        >        1.21739494e+00, 1.22462973e+00, 1.23182185e+00, 1.23897131e+00,
        >        1.24607810e+00, 1.25314222e+00, 1.26016367e+00, 1.26714245e+00,
        >        1.27407856e+00, 1.28097200e+00, 1.28782277e+00, 1.29463088e+00,
        >        1.30139632e+00, 1.30811910e+00, 1.31479921e+00, 1.32143666e+00,
        >        1.32803144e+00, 1.33458355e+00, 1.34109300e+00, 1.34755978e+00,
        >        1.35398389e+00, 1.36036534e+00, 1.36670412e+00, 1.37300023e+00,
        >        1.37925368e+00, 1.38546446e+00, 1.39163257e+00, 1.39775802e+00,
        >        1.40384080e+00, 1.40988091e+00, 1.41587836e+00, 1.42183313e+00,
        >        1.42774525e+00, 1.43361469e+00, 1.43944147e+00, 1.44522559e+00,
        >        1.45096703e+00, 1.45666581e+00, 1.46232192e+00, 1.46793537e+00,
        >        1.47350615e+00, 1.47903426e+00, 1.48451971e+00, 1.48996249e+00,
        >        1.49536260e+00, 1.50072005e+00, 1.50603483e+00, 1.51130694e+00,
        >        1.51653638e+00, 1.52172316e+00, 1.52686728e+00, 1.53196872e+00,
        >        1.53702750e+00, 1.54204361e+00, 1.54701706e+00, 1.55194784e+00,
        >        1.55683595e+00, 1.56168140e+00, 1.56648418e+00, 1.57124429e+00,
        >        1.57596174e+00, 1.58063652e+00, 1.58526863e+00, 1.58985807e+00,
        >        1.59440485e+00, 1.59890897e+00, 1.60337041e+00, 1.60778919e+00,
        >        1.61216530e+00, 1.61649875e+00, 1.62078953e+00, 1.62503764e+00,
        >        1.62924309e+00, 1.63340587e+00, 1.63752598e+00, 1.64160343e+00,
        >        1.64563820e+00, 1.64963032e+00, 1.65357976e+00, 1.65748654e+00,
        >        1.66135065e+00, 1.66517210e+00, 1.66895088e+00, 1.67268699e+00,
        >        1.67638044e+00, 1.68003122e+00, 1.68363933e+00, 1.68720478e+00,
        >        1.69072756e+00, 1.69420767e+00, 1.69764511e+00, 1.70103989e+00,
        >        1.70439201e+00, 1.70770145e+00, 1.71096823e+00, 1.71419234e+00,
        >        1.71737379e+00, 1.72051257e+00, 1.72360868e+00, 1.72666213e+00,
        >        1.72967291e+00, 1.73264102e+00, 1.73556647e+00, 1.73844925e+00,
        >        1.74128936e+00, 1.74408680e+00, 1.74615689e+00, 1.74615689e+00,
        >        1.74684158e+00, 1.74955370e+00, 1.75222329e+00, 1.75485018e+00,
        >        1.75743432e+00, 1.75997573e+00, 1.76247450e+00, 1.76493063e+00,
        >        1.76734409e+00, 1.76971488e+00, 1.77204299e+00, 1.77432843e+00,
        >        1.77657121e+00, 1.77877132e+00, 1.78092877e+00, 1.78304355e+00,
        >        1.78511566e+00, 1.78714511e+00, 1.78913189e+00, 1.79107600e+00,
        >        1.79297745e+00, 1.79483622e+00, 1.79665234e+00, 1.79842578e+00,
        >        1.80015656e+00, 1.80184468e+00, 1.80349012e+00, 1.80509290e+00,
        >        1.80665301e+00, 1.80817046e+00, 1.80964524e+00, 1.81107735e+00,
        >        1.81246680e+00, 1.81381358e+00, 1.81511769e+00, 1.81637914e+00,
        >        1.81759791e+00, 1.81877403e+00, 1.81990747e+00, 1.82099825e+00,
        >        1.82204636e+00, 1.82305181e+00, 1.82401459e+00, 1.82493470e+00,
        >        1.82581215e+00, 1.82664693e+00, 1.82743904e+00, 1.82818849e+00,
        >        1.82889527e+00, 1.82955938e+00, 1.83018082e+00, 1.83075960e+00,
        >        1.83129572e+00, 1.83178927e+00, 1.83224137e+00, 1.83265355e+00,
        >        1.83302763e+00, 1.83336530e+00, 1.83366867e+00, 1.83393973e+00,
        >        1.83418039e+00, 1.83439314e+00, 1.83458047e+00, 1.83474484e+00,
        >        1.83488839e+00, 1.83501331e+00, 1.83512145e+00, 1.83521489e+00,
        >        1.83529538e+00, 1.83536439e+00, 1.83542347e+00, 1.83547341e+00,
        >        1.83551577e+00, 1.83555167e+00, 1.83558176e+00, 1.83560709e+00,
        >        1.83562835e+00, 1.83564604e+00, 1.83566069e+00, 1.83567271e+00,
        >        1.83568266e+00, 1.83569073e+00, 1.83569710e+00, 1.83570222e+00,
        >        1.83570629e+00, 1.83570937e+00, 1.83571154e+00, 1.83571315e+00,
        >        1.83571422e+00, 1.83571486e+00, 1.83571518e+00, 1.83571519e+00,
        >        1.83571499e+00, 1.83571467e+00, 1.83571431e+00, 1.83571391e+00,
        >        1.83571344e+00, 1.83571298e+00, 1.83571256e+00, 1.83571222e+00,
        >        1.83571188e+00, 1.83571156e+00, 1.83571127e+00, 1.83571099e+00,
        >        1.83571071e+00, 1.83571047e+00, 1.83571024e+00, 1.83571003e+00,
        >        1.83570984e+00, 1.83570967e+00, 1.83570950e+00, 1.83570930e+00,
        >        1.83570911e+00, 1.83570893e+00, 1.83570877e+00, 1.83570865e+00,
        >        1.83570849e+00, 1.83570849e+00]), array([ 0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  6.26880908e-04,  3.75846504e-03,  7.68552084e-03,
        >         1.21835197e-02,  1.73966379e-02,  2.34349863e-02,  3.02903566e-02,
        >         3.78726378e-02,  4.60301814e-02,  5.46148631e-02,  6.34952586e-02,
        >         7.25832770e-02,  8.18202922e-02,  9.11421635e-02,  1.00498184e-01,
        >         1.09848917e-01,  1.19163003e-01,  1.28418484e-01,  1.37605179e-01,
        >         1.46716784e-01,  1.55748430e-01,  1.64698451e-01,  1.73566717e-01,
        >         1.82356975e-01,  1.91071217e-01,  1.99711237e-01,  2.08282432e-01,
        >         2.16788241e-01,  2.25234046e-01,  2.33627050e-01,  2.41971366e-01,
        >         2.50272160e-01,  2.58532741e-01,  2.66757774e-01,  2.74951514e-01,
        >         2.83117579e-01,  2.91258219e-01,  2.99378263e-01,  3.07481555e-01,
        >         3.15571177e-01,  3.23645445e-01,  3.31708612e-01,  3.39762448e-01,
        >         3.47808446e-01,  3.55844924e-01,  3.63874401e-01,  3.71898787e-01,
        >         3.79919502e-01,  3.87937507e-01,  3.95951293e-01,  4.03962869e-01,
        >         4.11972787e-01,  4.19981497e-01,  4.27989013e-01,  4.35993529e-01,
        >         4.43996881e-01,  4.51999387e-01,  4.60001367e-01,  4.68003141e-01,
        >         4.76004363e-01,  4.84005023e-01,  4.92005514e-01,  5.00005923e-01,
        >         5.08006312e-01,  5.16006722e-01,  5.24006735e-01,  5.32006259e-01,
        >         5.40005644e-01,  5.48004923e-01,  5.56004131e-01,  5.64003303e-01,
        >         5.72002473e-01,  5.80001677e-01,  5.88001216e-01,  5.96000840e-01,
        >         6.04000524e-01,  6.12000270e-01,  6.20000076e-01,  6.27999944e-01,
        >         6.35999872e-01,  6.43999862e-01,  6.51999913e-01,  6.60000024e-01,
        >         6.68000086e-01,  6.76000084e-01,  6.84000080e-01,  6.92000069e-01,
        >         7.00000045e-01,  7.08000003e-01,  7.15999937e-01,  7.23999842e-01,
        >         7.31999711e-01,  7.39999540e-01,  7.47999321e-01,  7.55999051e-01,
        >         7.63998723e-01,  7.71998387e-01,  7.79998278e-01,  7.87998194e-01,
        >         7.95998144e-01,  8.03998136e-01,  8.11998178e-01,  8.19998279e-01,
        >         8.27998451e-01,  8.35998704e-01,  8.43999049e-01,  8.51999500e-01,
        >         8.60000068e-01,  8.68000768e-01,  8.76001615e-01,  8.84002622e-01,
        >         8.92003807e-01,  9.00005185e-01,  9.08006243e-01,  9.16006622e-01,
        >         9.24006964e-01,  9.32007265e-01,  9.40007521e-01,  9.48007727e-01,
        >         9.56007879e-01,  9.64007972e-01,  9.72008002e-01,  9.80007964e-01,
        >         9.88007854e-01,  9.96007668e-01,  1.00000755e+00,  1.00000755e+00,
        >         1.00337998e+00,  1.00824709e+00,  1.01231890e+00,  1.01581985e+00,
        >         1.01860592e+00,  1.02056844e+00,  1.02171302e+00,  1.02213144e+00,
        >         1.02197194e+00,  1.02138318e+00,  1.02048949e+00,  1.01939287e+00,
        >         1.01815814e+00,  1.01684286e+00,  1.01549614e+00,  1.01415353e+00,
        >         1.01284183e+00,  1.01158347e+00,  1.01039345e+00,  1.00928133e+00,
        >         1.00824828e+00,  1.00729439e+00,  1.00642371e+00,  1.00563421e+00,
        >         1.00492608e+00,  1.00429273e+00,  1.00372335e+00,  1.00321693e+00,
        >         1.00276886e+00,  1.00237461e+00,  1.00202959e+00,  1.00172922e+00,
        >         1.00146879e+00,  1.00124332e+00,  1.00104809e+00,  1.00087818e+00,
        >         1.00073145e+00,  1.00060756e+00,  1.00050185e+00,  1.00041184e+00,
        >         1.00033538e+00,  1.00027025e+00,  1.00021436e+00,  1.00016636e+00,
        >         1.00012486e+00,  1.00008871e+00,  1.00005732e+00,  1.00003100e+00,
        >         1.00000908e+00,  9.99991679e-01,  9.99979158e-01,  9.99972162e-01,
        >         9.99966359e-01,  9.99962494e-01,  9.99960839e-01,  9.99960838e-01,
        >         9.99961799e-01,  9.99962863e-01,  9.99965232e-01,  9.99968573e-01,
        >         9.99972169e-01,  9.99975785e-01,  9.99979204e-01,  9.99982230e-01,
        >         9.99985527e-01,  9.99989529e-01,  9.99993347e-01,  9.99996857e-01,
        >         9.99999937e-01,  1.00000247e+00,  1.00000432e+00,  1.00000519e+00,
        >         1.00000519e+00,  9.99828852e-01,  9.97143384e-01,  9.93348278e-01,
        >         9.89006760e-01,  9.84304747e-01,  9.80179022e-01,  9.76002368e-01,
        >         9.71251493e-01,  9.65954140e-01,  9.60464843e-01,  9.55036765e-01,
        >         9.49679222e-01,  9.44339186e-01,  9.39002339e-01,  9.33670152e-01,
        >         9.28339861e-01,  9.23010531e-01,  9.17680649e-01,  9.12349469e-01,
        >         9.07017127e-01,  9.01683591e-01,  8.96349215e-01,  8.91014956e-01,
        >         8.85680851e-01,  8.80347246e-01,  8.75013596e-01,  8.69680018e-01,
        >         8.64346571e-01,  8.59013254e-01,  8.53680008e-01,  8.48346761e-01,
        >         8.43013541e-01,  8.37680330e-01,  8.32347109e-01,  8.27013861e-01,
        >         8.21680595e-01,  8.16347330e-01,  8.11014058e-01,  8.05680779e-01,
        >         8.00347492e-01,  7.95014199e-01,  7.89680899e-01,  7.84347591e-01,
        >         7.79014279e-01,  7.73680960e-01,  7.68347634e-01,  7.63014302e-01,
        >         7.57680963e-01,  7.52347617e-01,  7.47014265e-01,  7.41680906e-01,
        >         7.36347541e-01,  7.31014169e-01,  7.25680804e-01,  7.20347462e-01,
        >         7.15014120e-01,  7.09680779e-01,  7.04347438e-01,  6.99014097e-01,
        >         6.93680757e-01,  6.88347418e-01,  6.83014078e-01,  6.77680739e-01,
        >         6.72347401e-01,  6.67014063e-01,  6.61680725e-01,  6.56347388e-01,
        >         6.51014051e-01,  6.45680715e-01,  6.40347379e-01,  6.35014043e-01,
        >         6.29680708e-01,  6.24347373e-01,  6.19014038e-01,  6.13680704e-01,
        >         6.08347370e-01,  6.03014037e-01,  5.97680704e-01,  5.92347371e-01,
        >         5.87014039e-01,  5.81680707e-01,  5.76347376e-01,  5.71014045e-01,
        >         5.65680714e-01,  5.60347384e-01,  5.55014054e-01,  5.49680725e-01,
        >         5.44347396e-01,  5.39014067e-01,  5.33680737e-01,  5.28347404e-01,
        >         5.23014072e-01,  5.17680739e-01,  5.12347406e-01,  5.07014074e-01,
        >         5.01680741e-01,  4.96347408e-01,  4.91014076e-01,  4.85680743e-01,
        >         4.80347410e-01,  4.75014078e-01,  4.69680745e-01,  4.64347412e-01,
        >         4.59014080e-01,  4.53680747e-01,  4.48347414e-01,  4.43014081e-01,
        >         4.37680748e-01,  4.32347416e-01,  4.27014083e-01,  4.21680750e-01,
        >         4.16347417e-01,  4.11014084e-01,  4.05680751e-01,  4.00347418e-01,
        >         3.95014086e-01,  3.89680753e-01,  3.84347420e-01,  3.79014087e-01,
        >         3.73680754e-01,  3.68347421e-01,  3.63014088e-01,  3.57680754e-01,
        >         3.52347421e-01,  3.47014088e-01,  3.43014087e-01,  3.43014087e-01,
        >         3.41680754e-01,  3.36347415e-01,  3.31014077e-01,  3.25680742e-01,
        >         3.20347408e-01,  3.15014075e-01,  3.09680742e-01,  3.04347409e-01,
        >         2.99014076e-01,  2.93680742e-01,  2.88347409e-01,  2.83014076e-01,
        >         2.77680742e-01,  2.72347409e-01,  2.67014076e-01,  2.61680742e-01,
        >         2.56347409e-01,  2.51014076e-01,  2.45680742e-01,  2.40347409e-01,
        >         2.35014076e-01,  2.29680742e-01,  2.24347409e-01,  2.19014076e-01,
        >         2.13680742e-01,  2.08347409e-01,  2.03014076e-01,  1.97680742e-01,
        >         1.92347409e-01,  1.87014076e-01,  1.81680742e-01,  1.76347409e-01,
        >         1.71014076e-01,  1.65680742e-01,  1.60347409e-01,  1.55014076e-01,
        >         1.49680742e-01,  1.44347409e-01,  1.39014076e-01,  1.33680742e-01,
        >         1.28347409e-01,  1.23014076e-01,  1.17680742e-01,  1.12347409e-01,
        >         1.07014076e-01,  1.01680742e-01,  9.63474091e-02,  9.10140757e-02,
        >         8.56807424e-02,  8.03474091e-02,  7.50140757e-02,  6.96807424e-02,
        >         6.43474091e-02,  5.90399480e-02,  5.39444932e-02,  4.90673473e-02,
        >         4.44063282e-02,  3.99746373e-02,  3.57963848e-02,  3.18924679e-02,
        >         2.82787326e-02,  2.49615009e-02,  2.19363101e-02,  1.92032972e-02,
        >         1.67477828e-02,  1.45562784e-02,  1.26037992e-02,  1.08726199e-02,
        >         9.34524879e-03,  8.00429955e-03,  6.83200741e-03,  5.81019223e-03,
        >         4.92115277e-03,  4.14954123e-03,  3.48521119e-03,  2.91358076e-03,
        >         2.42315840e-03,  2.00388850e-03,  1.64638008e-03,  1.34249648e-03,
        >         1.08509228e-03,  8.68297306e-04,  6.87302604e-04,  5.35660689e-04,
        >         4.09299837e-04,  3.05636622e-04,  2.22432236e-04,  1.54232463e-04,
        >         9.98736396e-05,  5.71763259e-05,  2.41374305e-05, -3.77782741e-07,
        >        -1.80728014e-05, -3.04640854e-05, -3.90335423e-05, -4.41948563e-05,
        >        -4.62115091e-05, -4.64921434e-05, -4.59075783e-05, -4.53702079e-05,
        >        -4.35293022e-05, -4.10750798e-05, -3.83943596e-05, -3.55649299e-05,
        >        -3.26131912e-05, -2.97970315e-05, -2.70677806e-05, -2.44682706e-05,
        >        -2.20735713e-05, -1.99958507e-05, -1.77762120e-05, -1.53778215e-05,
        >        -1.29892197e-05, -1.06650622e-05, -8.50530336e-06, -6.66481409e-06,
        >        -4.38704903e-06, -4.38704903e-06]), array([ 0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  0.00000000e+00,  0.00000000e+00,  0.00000000e+00,
        >         0.00000000e+00,  2.77959406e-01,  4.56126804e-01,  5.21741146e-01,
        >         6.02286519e-01,  7.02489901e-01,  8.09165827e-01,  9.06800969e-01,
        >         9.86567245e-01,  1.04732411e+00,  1.09186428e+00,  1.12460490e+00,
        >         1.14769155e+00,  1.16185824e+00,  1.16883719e+00,  1.17003556e+00,
        >         1.16675062e+00,  1.16060617e+00,  1.15290780e+00,  1.14401470e+00,
        >         1.13442623e+00,  1.12451788e+00,  1.11439506e+00,  1.10425538e+00,
        >         1.09414436e+00,  1.08450129e+00,  1.07541481e+00,  1.06693494e+00,
        >         1.05919343e+00,  1.05219806e+00,  1.04575449e+00,  1.03996920e+00,
        >         1.03484844e+00,  1.03029722e+00,  1.02629448e+00,  1.02279687e+00,
        >         1.01973755e+00,  1.01702425e+00,  1.01462847e+00,  1.01249597e+00,
        >         1.01058805e+00,  1.00896323e+00,  1.00755892e+00,  1.00636316e+00,
        >         1.00536968e+00,  1.00451973e+00,  1.00379583e+00,  1.00318264e+00,
        >         1.00265762e+00,  1.00220384e+00,  1.00183486e+00,  1.00152084e+00,
        >         1.00124992e+00,  1.00101150e+00,  1.00080236e+00,  1.00065438e+00,
        >         1.00053299e+00,  1.00043080e+00,  1.00034045e+00,  1.00025456e+00,
        >         1.00018419e+00,  1.00013114e+00,  1.00008596e+00,  1.00004776e+00,
        >         1.00001626e+00,  9.99991842e-01,  9.99977084e-01,  9.99970310e-01,
        >         9.99968816e-01,  9.99971683e-01,  9.99977993e-01,  9.99986827e-01,
        >         9.99997267e-01,  1.00000839e+00,  1.00001043e+00,  1.00001123e+00,
        >         1.00001154e+00,  1.00001135e+00,  1.00001067e+00,  1.00000949e+00,
        >         1.00000781e+00,  1.00000563e+00,  1.00000296e+00,  9.99999796e-01,
        >         9.99997726e-01,  9.99996962e-01,  9.99996597e-01,  9.99996713e-01,
        >         9.99997390e-01,  9.99998711e-01,  1.00000076e+00,  1.00000361e+00,
        >         1.00000734e+00,  1.00001205e+00,  1.00001780e+00,  1.00002469e+00,
        >         1.00003278e+00,  1.00004100e+00,  1.00004437e+00,  1.00004709e+00,
        >         1.00004895e+00,  1.00004974e+00,  1.00004925e+00,  1.00004724e+00,
        >         1.00004345e+00,  1.00003761e+00,  1.00002945e+00,  1.00001867e+00,
        >         1.00000495e+00,  9.99987982e-01,  9.99967410e-01,  9.99942885e-01,
        >         9.99914036e-01,  9.99880481e-01,  9.99854748e-01,  9.99845522e-01,
        >         9.99837127e-01,  9.99829667e-01,  9.99823243e-01,  9.99817959e-01,
        >         9.99813919e-01,  9.99811224e-01,  9.99809978e-01,  9.99810284e-01,
        >         9.99812245e-01,  9.99815963e-01,  9.99818514e-01,  9.99818514e-01,
        >         7.21871670e-01,  5.43740412e-01,  4.78180163e-01,  3.97633759e-01,
        >         2.97509025e-01,  1.90849264e-01,  9.31524452e-02,  1.32424747e-02,
        >        -4.75003432e-02, -9.16762556e-02, -1.23625188e-01, -1.46152824e-01,
        >        -1.60455614e-01, -1.67679010e-01, -1.69449515e-01, -1.66784623e-01,
        >        -1.60909725e-01, -1.52985856e-01, -1.43921442e-01, -1.34098072e-01,
        >        -1.23879437e-01, -1.13469916e-01, -1.03256214e-01, -9.33842247e-02,
        >        -8.40834028e-02, -7.53489369e-02, -6.70380309e-02, -5.93363919e-02,
        >        -5.23049398e-02, -4.58710257e-02, -4.00853637e-02, -3.49448244e-02,
        >        -3.04170162e-02, -2.64236166e-02, -2.29067408e-02, -1.97710519e-02,
        >        -1.70175759e-02, -1.47071894e-02, -1.27050740e-02, -1.09499290e-02,
        >        -9.37546210e-03, -7.97321105e-03, -6.75226925e-03, -5.64868158e-03,
        >        -4.64305475e-03, -3.72536567e-03, -2.90097853e-03, -2.17890285e-03,
        >        -1.55348327e-03, -1.03600785e-03, -6.43450293e-04, -3.98469975e-04,
        >        -1.75775614e-04,  3.34082124e-06,  1.33544801e-04,  2.35981273e-04,
        >         3.37974059e-04,  4.73930887e-04,  5.33042488e-04,  5.35576848e-04,
        >         5.20291955e-04,  4.91789110e-04,  4.54410382e-04,  4.12238616e-04,
        >         3.59497562e-04,  2.93211728e-04,  2.25535236e-04,  1.59796308e-04,
        >         9.93231696e-05,  4.74440438e-05,  7.48715499e-06, -1.26544089e-05,
        >        -1.26544089e-05, -1.66060463e-01, -4.33594706e-01, -5.04901261e-01,
        >        -5.80094769e-01, -5.62532167e-01, -4.88151291e-01, -5.53576596e-01,
        >        -6.38893199e-01, -6.80009089e-01, -6.82279736e-01, -6.74458977e-01,
        >        -6.70587533e-01, -6.69021872e-01, -6.67437079e-01, -6.66468656e-01,
        >        -6.66026848e-01, -6.66068312e-01, -6.66302942e-01, -6.66594069e-01,
        >        -6.66734261e-01, -6.66803295e-01, -6.66819248e-01, -6.66831108e-01,
        >        -6.66840771e-01, -6.66866028e-01, -6.66853264e-01, -6.66818923e-01,
        >        -6.66768188e-01, -6.66701058e-01, -6.66634178e-01, -6.66587958e-01,
        >        -6.66554341e-01, -6.66538520e-01, -6.66545691e-01, -6.66581045e-01,
        >        -6.66600847e-01, -6.66601348e-01, -6.66604378e-01, -6.66609937e-01,
        >        -6.66618024e-01, -6.66628640e-01, -6.66641784e-01, -6.66657458e-01,
        >        -6.66662737e-01, -6.66666604e-01, -6.66669811e-01, -6.66672358e-01,
        >        -6.66674244e-01, -6.66675469e-01, -6.66676035e-01, -6.66675939e-01,
        >        -6.66675184e-01, -6.66673767e-01, -6.66672693e-01, -6.66673199e-01,
        >        -6.66673572e-01, -6.66673812e-01, -6.66673920e-01, -6.66673895e-01,
        >        -6.66673737e-01, -6.66673447e-01, -6.66673024e-01, -6.66672469e-01,
        >        -6.66671781e-01, -6.66670961e-01, -6.66670008e-01, -6.66668923e-01,
        >        -6.66667704e-01, -6.66666955e-01, -6.66666738e-01, -6.66666539e-01,
        >        -6.66666358e-01, -6.66666194e-01, -6.66666047e-01, -6.66665918e-01,
        >        -6.66665807e-01, -6.66665713e-01, -6.66665637e-01, -6.66665579e-01,
        >        -6.66665538e-01, -6.66665514e-01, -6.66665509e-01, -6.66665520e-01,
        >        -6.66665550e-01, -6.66665597e-01, -6.66665661e-01, -6.66665743e-01,
        >        -6.66665843e-01, -6.66665960e-01, -6.66666018e-01, -6.66665998e-01,
        >        -6.66665980e-01, -6.66665965e-01, -6.66665953e-01, -6.66665942e-01,
        >        -6.66665935e-01, -6.66665930e-01, -6.66665928e-01, -6.66665928e-01,
        >        -6.66665930e-01, -6.66665936e-01, -6.66665943e-01, -6.66665954e-01,
        >        -6.66665967e-01, -6.66665982e-01, -6.66666000e-01, -6.66666021e-01,
        >        -6.66666044e-01, -6.66666070e-01, -6.66666098e-01, -6.66666129e-01,
        >        -6.66666162e-01, -6.66666198e-01, -6.66666237e-01, -6.66666278e-01,
        >        -6.66666321e-01, -6.66666367e-01, -6.66666416e-01, -6.66666467e-01,
        >        -6.66666521e-01, -6.66666577e-01, -6.66666636e-01, -6.66666674e-01,
        >        -6.66666710e-01, -6.66666747e-01, -6.66666774e-01, -6.66666774e-01,
        >        -6.66667045e-01, -6.66667370e-01, -6.66667112e-01, -6.66666813e-01,
        >        -6.66666640e-01, -6.66666597e-01, -6.66666619e-01, -6.66666649e-01,
        >        -6.66666661e-01, -6.66666662e-01, -6.66666661e-01, -6.66666660e-01,
        >        -6.66666665e-01, -6.66666674e-01, -6.66666676e-01, -6.66666678e-01,
        >        -6.66666675e-01, -6.66666670e-01, -6.66666665e-01, -6.66666662e-01,
        >        -6.66666659e-01, -6.66666658e-01, -6.66666659e-01, -6.66666660e-01,
        >        -6.66666660e-01, -6.66666660e-01, -6.66666661e-01, -6.66666662e-01,
        >        -6.66666664e-01, -6.66666665e-01, -6.66666667e-01, -6.66666668e-01,
        >        -6.66666669e-01, -6.66666669e-01, -6.66666670e-01, -6.66666670e-01,
        >        -6.66666670e-01, -6.66666670e-01, -6.66666670e-01, -6.66666670e-01,
        >        -6.66666670e-01, -6.66666670e-01, -6.66666670e-01, -6.66666670e-01,
        >        -6.66666670e-01, -6.66666669e-01, -6.66666669e-01, -6.66666669e-01,
        >        -6.66666668e-01, -6.66666667e-01, -6.66666667e-01, -6.66666667e-01,
        >        -6.66666667e-01, -6.58879187e-01, -6.22969573e-01, -5.95688864e-01,
        >        -5.68948280e-01, -5.39599431e-01, -5.06240835e-01, -4.70404903e-01,
        >        -4.33152206e-01, -3.95252350e-01, -3.58061930e-01, -3.22741478e-01,
        >        -2.89420654e-01, -2.58356100e-01, -2.29490815e-01, -2.02983269e-01,
        >        -1.78848855e-01, -1.57012386e-01, -1.37413787e-01, -1.19724284e-01,
        >        -1.03899525e-01, -8.98173638e-02, -7.73723622e-02, -6.64448354e-02,
        >        -5.68954297e-02, -4.85398523e-02, -4.12481728e-02, -3.48890756e-02,
        >        -2.94163943e-02, -2.46850149e-02, -2.05896082e-02, -1.70748232e-02,
        >        -1.40698459e-02, -1.15028663e-02, -9.31972310e-03, -7.46427357e-03,
        >        -5.89931971e-03, -4.59181440e-03, -3.51618505e-03, -2.62545528e-03,
        >        -1.90199402e-03, -1.32620724e-03, -8.79216274e-04, -5.39537746e-04,
        >        -2.85631518e-04, -9.98662329e-05,  3.87034657e-05,  1.53060969e-04,
        >         2.16411317e-04,  2.48772111e-04,  2.64266759e-04,  2.70936197e-04,
        >         2.76462738e-04,  2.70680018e-04,  2.61962971e-04,  2.52177734e-04,
        >         2.41647437e-04,  2.29909311e-04,  2.18911895e-04,  2.08252628e-04,
        >         1.96329723e-04,  1.82302140e-04,  1.65373096e-04,  1.44916439e-04,
        >         1.21930138e-04,  1.21930138e-04])]
    输入参数
        varNames - 变量名或"time"
        数据类型：list
    返回值
        给定所有变量的所有时刻值或时间序列
    另请参阅
        SimulateModel
    """
    for item in varNames:
        if type(item)==  str:
            pass
        else:
            _CheckArgTypes('GetVarsValues',item,'varNames',[type(item)])
    
    params = inspect.signature(GetVarsValues).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetVarsValues, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def AddConnection(modelName:str, portBegin:str, portEnd:str, points:tuple):
    """

    已弃用

    """
    params = inspect.signature(AddConnection).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(AddConnection, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def DrawLine(modelName:str, graphicsLayer:str, leftEnd:tuple, rightEnd:tuple, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制线段
    
    语法
        >>> DrawLine(modelName, graphicsLayer, leftEnd, rightEnd)
        >>> DrawLine(modelName, graphicsLayer, leftEnd, rightEnd, style)
    说明
        DrawLine(modelName, graphicsLayer, leftEnd, rightEnd) 用于在指定模型视图绘制线段，函数返回`bool` 表示是否绘制成功。
        DrawLine(modelName, graphicsLayer, leftEnd, rightEnd, style) 用于在指定模型视图绘制线段，并指定图形样式。函数返回`bool` 表示是否绘制成功。
    示例
    示例1：在模型视图绘制线段
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型视图绘制线段。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawLine('Pendulum', 'diagram', (-10, 45), (48, 89)))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        leftEnd - 左端点
        数据类型：tuple
        rightEnd - 右端点
        数据类型：tuple
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    option_list = {}
    option_list['leftEnd'] = leftEnd
    option_list['rightEnd'] = rightEnd
    return DrawShape(modelName, ShapeType.Line, graphicsLayer, option_list, style)

@mw_connect_decorator(_MwConnect._process_path)
def DrawLines(modelName:str, graphicsLayer:str, gripPoints:list, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制多段线
    
    语法
        >>> DrawLines(modelName, graphicsLayer, gripPoints)
        >>> DrawLines(modelName, graphicsLayer, gripPoints, style)
    说明
        DrawLines(modelName, graphicsLayer, gripPoints) 用于在指定模型视图绘制多段线。函数返回`bool`表示是否绘制成功。
        DrawLines(modelName, graphicsLayer, gripPoints, style) 用于在指定模型视图绘制多段线，并指定图形样式。函数返回`bool`表示是否绘制成功。
    示例
    示例1：在模型中绘制多段线
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型中绘制多段线。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawLines('Pendulum', 'diagram', [-10, 25, 48, 89, 100, -47]))
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        gripPoints - 夹点列表，格式为[x0,y0,x1,y1,...,xn,yn)，两辆组合构成坐标，至少为4
        数据类型：list
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    option_list = {}
    option_list['gripPoints'] = gripPoints
    return DrawShape(modelName, ShapeType.Lines, graphicsLayer, option_list, style)

@mw_connect_decorator(_MwConnect._process_path)
def DrawPolygon(modelName:str, graphicsLayer:str, vertex:list, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制多边形
    
    语法
        >>> DrawPolygon(modelName, graphicsLayer, vertex)
        >>> DrawPolygon(modelName, graphicsLayer, vertex, style)
    说明
        DrawPolygon(modelName, graphicsLayer, vertex) 用于在指定模型视图绘制多边形。函数返回`bool`表示是否绘制成功。
        DrawPolygon(modelName, graphicsLayer, vertex, style) 用于在指定模型视图绘制多边形，并指定图形样式。函数返回`bool`表示是否绘制成功。
    示例
    示例1：在模型视图绘制多边形
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型视图绘制多边形。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawPolygon('Pendulum', 'diagram', [-10, 25, 48, 89, 100, -47]))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        vertex - 顶点列表，格式为[x0,y0,x1,y1,...,xn,yn)，两辆组合构成坐标，至少为6
        数据类型：list
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    option_list = {}
    option_list['vertex'] = vertex
    return DrawShape(modelName, ShapeType.Polygon, graphicsLayer, option_list, style)

@mw_connect_decorator(_MwConnect._process_path)
def DrawTriangle(modelName:str, graphicsLayer:str, vertex1:tuple, vertex2:tuple, vertex3:tuple, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制三角形
    
    语法
        >>> DrawTriangle(modelName, graphicsLayer, vertex1, vertex2, vertex3)
        >>> DrawTriangle(modelName, graphicsLayer, vertex1, vertex2, vertex3, style)
    说明
        DrawTriangle(modelName, graphicsLayer, vertex1, vertex2, vertex3) 用于在指定模型视图绘制三角形。函数返回`bool`表示是否绘制成功。
        DrawTriangle(modelName, graphicsLayer, vertex1, vertex2, vertex3, style) 用于在指定模型视图绘制三角形，并指定图形样式。函数返回`bool`表示是否绘制成功。
    示例
    示例1：在模型视图绘制三角形
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型视图绘制三角形。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawTriangle('Pendulum', 'diagram', (-10, 25), (48, 89), (100, -47)))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        vertex1 - 顶点1
        数据类型：tuple
        vertex2 - 顶点2
        数据类型：tuple
        vertex3 - 顶点3
        数据类型：tuple
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    option_list = {}
    option_list['vertex1'] = vertex1
    option_list['vertex2'] = vertex2
    option_list['vertex3'] = vertex3
    return DrawShape(modelName, ShapeType.Triangle, graphicsLayer, option_list, style)

@mw_connect_decorator(_MwConnect._process_path)
def DrawRectangle(modelName:str, graphicsLayer:str, x:float, y:float, width:float, height:float, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制矩形
    
    语法
        >>> DrawRectangle(modelName, graphicsLayer, x, y, width, height)
        >>> DrawRectangle(modelName, graphicsLayer, x, y, width, height, style)
    说明
        DrawRectangle(modelName, graphicsLayer, x, y, width, height) 用于在指定模型视图绘制矩形。函数返回`bool`表示是否绘制成功。
        DrawRectangle(modelName, graphicsLayer, x, y, width, height, style) 用于在指定模型视图绘制矩形，并指定图形样式。函数返回`bool`表示是否绘制成功。
    示例
    示例1：在模型视图绘制矩形
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型视图绘制矩形。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawRectangle('Pendulum', 'diagram', -10, 25, 48, 89))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        x - 中心横坐标
        数据类型：float
        y - 中心纵坐标
        数据类型：float
        width - 宽
        数据类型：float
        height - 高
        数据类型：float
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    option_list = {}
    option_list['x'] = x
    option_list['y'] = y
    option_list['width'] = width
    option_list['height'] = height
    return DrawShape(modelName, ShapeType.Rectangle, graphicsLayer, option_list, style)

@mw_connect_decorator(_MwConnect._process_path)
def DrawEllipse(modelName:str, graphicsLayer:str, x:float, y:float, width:float, height:float, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制椭圆
    
    语法
        >>> DrawEllipse(modelName, graphicsLayer, x, y, width, height)
        >>> DrawEllipse(modelName, graphicsLayer, x, y, width, height, style)
    说明
        DrawEllipse(modelName, graphicsLayer, x, y, width, height) 用于在指定模型视图以指定位置和大小绘制椭圆。函数返回`bool`表示是否绘制成功。
        DrawEllipse(modelName, graphicsLayer, x, y, width, height, style) 用于在指定模型视图以指定位置和大小绘制椭圆，并指定图形样式。函数返回`bool`表示是否绘制成功。
    示例
    示例1：在模型视图绘制椭圆
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型视图绘制椭圆。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawEllipse('Pendulum', 'diagram', -10, 25, 48, 89))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        x - 中心横坐标
        数据类型：float
        y - 中心纵坐标
        数据类型：float
        width - 宽
        数据类型：float
        height - 高
        数据类型：float
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    option_list = {}
    option_list['x'] = x
    option_list['y'] = y
    option_list['width'] = width
    option_list['height'] = height
    return DrawShape(modelName, ShapeType.Ellipse, graphicsLayer, option_list, style)

@mw_connect_decorator(_MwConnect._process_path)
def DrawText(modelName:str, graphicsLayer:str, x:float, y:float, text:str, width:float = 0, height:float = 10, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制文本
    
    语法
        >>> DrawText(modelName, graphicsLayer, x, y, text)
        >>> DrawText(modelName, graphicsLayer, x, y, text, width, height, style)
    说明
        DrawText(modelName, graphicsLayer, x, y, text) 用于在指定模型视图绘制文本。函数返回`bool`表示是否绘制成功。
        DrawText(modelName, graphicsLayer, x, y, text, width, height, style) 用于在指定模型视图绘制文本，并指定文本的宽高和图形样式。函数返回`bool`表示是否绘制成功。
    示例
    示例1：在模型视图绘制文本
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型视图绘制文本。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawText('Pendulum', 'diagram', -10, 25, 'Hello'))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        x - 中心横坐标
        数据类型：float
        y - 中心纵坐标
        数据类型：float
        width - 文本控件的宽
        数据类型：float
        height - 文本控件的高
        数据类型：float
        text - 文本
        数据类型：str
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    option_list = {}
    option_list['x'] = x
    option_list['y'] = y
    option_list['width'] = width
    option_list['height'] = height
    option_list['text'] = text
    return DrawShape(modelName, ShapeType.Text, graphicsLayer, option_list, style)

@mw_connect_decorator(_MwConnect._process_path)
@path_resolver(['path'], True, GetDirectory, Echo)
def DrawBitmap(modelName:str, graphicsLayer:str, x:float, y:float, path:str, saveToModel:bool, width:float, height:float, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制位图
    
    语法
        >>> DrawBitmap(modelName, graphicsLayer, x, y, path, saveToModel, width, height)
        >>> DrawBitmap(modelName, graphicsLayer, x, y, path, saveToModel, width, height, style)
    说明
        DrawBitmap(modelName, graphicsLayer, x, y, path, saveToModel, width, height) 用于在指定模型选择图形视图和位置大小绘制位图，并设置保存位置以及图片数据是否保存到模型。函数返回`bool`表示是否绘制成功
        DrawBitmap(modelName, graphicsLayer, x, y, path, saveToModel, width, height, style) 用于在指定模型选择图形视图和位置大小绘制位图，并设置保存位置以及图片数据是否保存到模型，指定图形样式。函数返回`bool`表示是否绘制成功。
    示例
    示例1：在模型视图绘制位图
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型视图绘制位图。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawBitmap('Pendulum', 'diagram', -10, 25, 'D:\\Plot.png', False, 60, 80))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        x - 中心横坐标
        数据类型：float
        y - 中心纵坐标
        数据类型：float
        width - 图片控件的宽
        数据类型：float
        height - 图片控件的高
        数据类型：float
        text - 文本
        数据类型：str
        path - 图片的路径
        数据类型：str
        saveToModel - 图片数据是否保存到模型
        数据类型：bool
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    option_list = {}
    option_list['x'] = x
    option_list['y'] = y
    option_list['width'] = width
    option_list['height'] = height
    option_list['path'] = path
    option_list['saveToModel'] = saveToModel
    return DrawShape(modelName, ShapeType.Bitmap, graphicsLayer, option_list, style)

@mw_connect_decorator(_MwConnect._process_path)
def DrawShape(modelName:str, shapeType:str, graphicsLayer:str, options:dict = {}, style:ShapeStyle = None) -> bool:
    """
    在指定模型视图绘制图元
    
    语法
        >>> DrawShape(modelName, shapeType, graphicsLayer)
        >>> DrawShape(modelName, shapeType, graphicsLayer, options, style)
    说明
        DrawShape(modelName, shapeType, graphicsLayer) 用于在指定模型视图绘制图元。函数返回`bool`表示是否绘制成功。
        DrawShape(modelName, shapeType, graphicsLayer, options, style) 用于在指定模型视图绘制图元，并指定图形选项和图形样式。函数返回`bool`表示是否绘制成功。
    示例
    示例1：在模型视图绘制图元
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，在模型视图绘制图元。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(DrawShape('Pendulum', 'Line', 'diagram', {'leftEnd':(-10, 25), 'rightEnd':(48, 89)}))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
        shapeType - 形状类型，包括'Line','Lines','Polygon','Triangle','Rectangle','Ellipse','Text',Bitmap'
        数据类型：str
        options - 图形选项，根据不同的形状类型，输入不同的字典
        数据类型：dict
        style - 图形样式
        数据类型：str
    返回值
        `bool` : 表示绘制是否成功
    另请参阅
        无
    """
    if style != None:
        if not _CheckShapeStyle(style):
            return False
        else:
            style_dict = {}
            for attr in dir(style):
                if not attr.startswith('__') and not callable(getattr(style, attr)):
                    style_dict[attr] = str(getattr(style, attr))
            style = style_dict
    else:
        style = {}
    if not _CheckShapeOption(shapeType, options):
        return False
    else:
        for key,value in options.items():
            options[key] = str(value)
    params = inspect.signature(DrawShape).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    expected_types[list(params.keys()).index('style')] = dict
    return _MwConnect.__RunCurrentFunction__(DrawShape, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def ClearShapes(modelName:str, graphicsLayer:str) -> bool:
    """
    清空指定模型视图的所有图形
    
    语法
        >>> ClearShapes(modelName, graphicsLayer)
    说明
        ClearShapes(modelName, graphicsLayer) 用于清空指定模型视图的所有图形，函数返回bool表示是否绘制成功。
    示例
    示例1：清空指定模型视图的所有图形
        Pendulum 模型文件默认存储在`%安装路径%/Docs/Interface/Samples/SysplorerAPI`文件夹下。
        加载Pendulum.mo模型文件，清空指定模型视图的所有图形。
        >>> OpenModelFile(GetInstallationDirectory() + r"\Docs\Interface\Samples\SysplorerAPI\Pendulum.mo")
        >>> print(ClearShapes('Pendulum', 'diagram'))
        结果：
        >True
    输入参数
        modelName - 模型全名
        数据类型：str
        graphicsLayer - 图形视图或图标视图，'diagram'、'icon'
        数据类型：str
    返回值
        `bool` : 表示清空是否成功
    另请参阅
        无
    """
    params = inspect.signature(ClearShapes).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ClearShapes, args=args, kwargs={}, expected_types = expected_types)

    #--------------------------模型属性命令-------------------------
@mw_connect_decorator(_MwConnect._process_path)
def ClassExist(className:str) -> bool:
    """
    判断给定的名字是否为已加载的类型
    
    语法
        >>> ClassExist(className)
    说明
        ClassExist(className) 用于判断给定的名字是否为已加载的类型，函数返回bool表示是否绘制成功。
    示例
    示例1：判断标准库是否为已加载的类型
        加载标准库Modelica，判断Modelica标准库是否为已加载的类型。
        >>> LoadLibrary("Modelica")
        >>> print(ClassExist('Modelica'))
        结果：
        >True
    输入参数
        className - 类型全名
        数据类型：str
    返回值
        `bool` : 表示是否为已加载的类型
    另请参阅
        无
    """
    params = inspect.signature(ClassExist).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(ClassExist, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def GetRestriction(className:str):
    """
    获取给定类型的限定类型
    
    语法
        >>> GetRestriction(className)
    说明
        GetRestriction(className) 用于获取给定类型的限定类型 ， 返回 class 、 record 、 type 、 model 、 block 、 function 、 connector 、 package 、 operator 、 operator   record 或 operator   function，函数返回`str`表示给定类型的限定类型。
    示例
    示例1：获取标准库的限定类型
        加载标准库Modelica，获取标准库的限定类型。
        >>> LoadLibrary("Modelica")
        >>> print(GetRestriction('Modelica'))
        结果：
        >package
    输入参数
        className - 类型全名
        数据类型：str
    返回值
        `str` : 给定类型的限定类型
    另请参阅
        无
    """
    params = inspect.signature(GetRestriction).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetRestriction, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def SendHeart():
    """
    用于保持Syslab与Sysplorer之间的通信
    """
    if(_MwConnect.get_to_receive() == True):
        return
    params = inspect.signature(SendHeart).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SendHeart, args=args, kwargs={}, expected_types = expected_types)

@mw_connect_decorator(_MwConnect._process_path)
def MessageText():
    """
    获取上一条命令的日志信息
    
    语法
        >>> MessageText()
    说明
        MessageText() 用于获取上一条命令的日志信息。
    示例
    示例1：使用MessageText获取上一条命令的日志信息
        使用MessageText获取上一条命令的日志信息。
        >>> ChangeDirectory("")
        >>> print(MessageText())
        结果：
        > [2024-12-09 11:44:38] Message(0):本地路径为“C:\\\\Users\\TR\\Documents\\MWORKS”。
    输入参数
        无
    返回值
        返回上一条命令的日志信息
    另请参阅
        无
    """
    if _MwConnect.messageText == "":
        return "[上一条命令没有日志信息]"
    return _MwConnect.messageText

@mw_connect_decorator(_MwConnect._process_path)
def SetPanelVisiable(name:str, flag:bool):
    """
    设置侧边栏窗口显示
    
    语法
        >>> SetPanelVisiable(name, flag)
    说明
        SetPanelVisiable(name, flag) 用于设定指定窗口显示还是隐藏。
    示例
    示例1：
        使用SetPanelVisiable设定指定窗口显示。
        >>> SetPanelVisiable("Command Window", True)
        >>> True
        结果：
            命令行窗口显示
    输入参数
        name - 窗口英文名称
        数据类型：str
        **支持的名称选项(name):**
        |         窗口名          |  格式 |             示例              |
        | ----------------------- | ----- | ----------------------------- |
        | Library Browser         |  str  | "Library Browser"             |
        | User Models             |  str  | "User Models"                 |
        | Component Browser       |  str  | "Component Browser"           |
        | Info Browser            |  str  | "Info Browser"                |
        | Code Browser            |  str  | "Code Browser"                |
        | Categorize Display      |  str  | "Categorize Display"          |
        | Data Dictionary         |  str  | "Data Dictionary"             |
        | Sysblock Model Finder   |  str  | "Sysblock Model Finder"       |
        | Break Points            |  str  | "Break Points"                |
        | Component Parameters    |  str  | "Component Parameters"        |
        | Component Variables     |  str  | "Component Variables"         |
        | Command Window          |  str  | "Command Window"              |
        | Output Window           |  str  | "Output Window"               |
        | CAD Browser             |  str  | "CAD Browser"                 |
        | File Explorer           |  str  | "File Explorer"               |
        
        flag - 显示或关闭
        数据类型：bool
    返回值
        True/False: 是否显示成功
    另请参阅
        无
    """
    params = inspect.signature(SetPanelVisiable).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(SetPanelVisiable, args=args, kwargs={}, expected_types = expected_types)

#--------------------------附加操作命令-------------------------
# 附加函数以"_"开头 不被外部调用，但是connect函数中需要去掉"_", 与平台接口保持一致
def _CheckRange(key,value)->str:
    INT_MAX = sys.maxsize
    key_list = {'outputNumberOfResultsToKeep':(1,99),'outputBackupSimulationDataStepInterval(steps)':(1,99999999),'outputBackupSimulationDataTimeInterval(minutes)':(1,99999999),
                'outputMaximumNumberOfSimulationVariables':(1000000, 999999999),'realtimeSlowdownFactor':(0,-1),'steadyStateSearchSettingDetectionTolerance':(0,-1),
                'CodePlatform.AtomicLength':('32'),'CodeReplaceAll.LibFunctionReplacement':('C99','CMSIS-DSP'),'outputNumberOfContinuePoints':(1, -1),
                'CodeDesign.NamingStyle':('camelCase','PascalCase','lower_snake_case','UPPER_SNAKE_CASE'),'CodeDesign.LogicalOperator':('logical','bitwise'),
                'CodeDesign.NamingConventions':(32,255),'CodeOptimization.Array':(0,99), 'realtimeSimulationMode':{0,1,2},
                'Environment.General.UndoLevels':(0,999),'Environment.General.PeriodicallyBackupModelTimeInterval(minute)':(1,99),'Modeling.ClassBrowser.IconSizeCustom':(0,99),
                'Modeling.TextView.FontSize':(6,24),'Modeling.TextView.Margin':(0,99),'Simulation.General.NumbersOfResultsToKeep':(1,99),
                'outputGenerateStepsOfPointsBeforeSimulationStops':(1, 99), }

    if not key in key_list:
        return ''
    #dict 表示 输入值只能是对应的元素
    _value = key_list[key]
    if type(_value) == set:
        if value not in _value:
            return _value
    else:
        if type(_value[0]) == str:
            if value not in _value:
                return str(_value)
        if type(_value[0]) == int:
            min_val = _value[0]
            max_val = _value[1]
            if max_val == -1:
                if value < min_val :
                    return '%d ~ INF'%(min_val)
            elif value < min_val or value > max_val:
                return '%d ~ %d'%(min_val,max_val)
    return ''

def _CheckVarTunable(varName:str):
    params = inspect.signature(_CheckVarTunable).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(_CheckVarTunable, args=args, kwargs={}, expected_types = expected_types)

def _CheckVarExisting(varName:str):
    params = inspect.signature(_CheckVarExisting).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(_CheckVarExisting, args=args, kwargs={}, expected_types = expected_types)

def _GetVarTimes():
    params = inspect.signature(_GetVarTimes).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(_GetVarTimes, args=args, kwargs={}, expected_types = expected_types)

def GetVarTimes():
    params = inspect.signature(GetVarTimes).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(GetVarTimes, args=args, kwargs={}, expected_types = expected_types)

def _SetEcho(on:bool):
    params = inspect.signature(_SetEcho).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(_SetEcho, args=args, kwargs={}, expected_types = expected_types)

def _IsAlgoFixedStep(algo:str):
    params = inspect.signature(_IsAlgoFixedStep).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(_IsAlgoFixedStep, args=args, kwargs={}, expected_types = expected_types)

def _CheckShapeOption(shapeType:str, options:dict):
    line_options = ['leftEnd', 'rightEnd']
    lines_options = ['gripPoints']
    poly_options = ['vertex']
    tri_options = ['vertex1', 'vertex2', 'vertex3']
    rect_ell_options = ['x', 'y', 'width', 'height']
    text_options = ['x', 'y', 'width', 'height', 'text']
    bitmap_options = ['x', 'y', 'width', 'height', 'path', 'saveToModel']
    option_map = {ShapeType.Line:line_options, ShapeType.Lines:lines_options, ShapeType.Polygon:poly_options, 
        ShapeType.Triangle:tri_options, ShapeType.Rectangle:rect_ell_options, ShapeType.Ellipse:rect_ell_options, 
        ShapeType.Text:text_options, ShapeType.Bitmap:bitmap_options}
    if shapeType not in option_map.keys():
        print('Invalid shape type.')
        return False
    else:
        op_list = option_map[shapeType]
        if len(op_list) != len(options):
            print('The number of option keys is incorrect, too many or too less keys.', shapeType)
            return False
        else:
            for key in op_list:
                if key not in options:
                    print('Key error,%s lacked.'%key)
                    return False
                val = options[key]
                if key in line_options+tri_options:
                    if not isinstance(val, tuple) or len(val) != 2:
                        print('Value of key %s error, invalid format.'%key)
                        return False
                    for num in val:
                        if not isinstance(num, (int, float)):
                            print('Value of key %s error, invalid format.'%key)
                            return False
                if key == 'gripPoints' or key == 'vertex':
                    if not isinstance(val, list) or len(val) % 2 != 0:
                        print('Value of key %s error, invalid format.'%key)
                        return False
                    if key == 'gripPoints' and len(val) < 4 or key == 'vertex' and len(val) < 6:
                        print('Value of key %s error, invalid format.'%key)
                        return False
                    for num in val:
                        if not isinstance(num, (int, float)):
                            print('Value of key %s error, invalid format.'%key)    
                            return False
                if key == 'smooth' or key == 'saveToModel':
                    if not isinstance(val, bool):
                        print('Value of key %s error, invalid format.'%key)
                        return False
                if key in rect_ell_options:
                    if not isinstance(val, (int, float)):
                        print('Value of key %s error, invalid format.'%key)
                        return False
                if key == 'text' or key == 'path':
                    if not isinstance(val, str):
                        print('Value of key %s error, invalid format.'%key)
                        return False
                    if val == '':
                        print('Value of key %s error, not empty.'%key)
                        return False
    return True

def _IsValidColor(color_list):
    if not isinstance(color_list, list) or len(color_list) != 3:
        return False
    for val in color_list:
        if not isinstance(val, int) or not (0 <= val <= 255):
            return False
    return True

def _CheckShapeStyle(style:ShapeStyle):
    if not isinstance(style, MwShapeStyle):
        print('Invalid style format.')
        return False
    if not _IsValidColor(style.textColor) or not _IsValidColor(style.fillColor) or not _IsValidColor(style.lineColor):
        print('Error color format,shoube be [0,0,0].')
        return False
    if not isinstance(style.textSize, (int ,float))  or not isinstance(style.lineWidth, (int ,float))  or \
        not isinstance(style.radius, (int ,float))  or not isinstance(style.arrowSize, (int ,float)):
        print('Error number format.')
        return False
    if not isinstance(style.textFont, str):
        print('Invalid text font format.')
        return False
    if style.fillPattern != None and (not isinstance(style.fillPattern, (str)) or not hasattr(MwFillPattern, style.fillPattern)): 
        print('Error fill pattern format.')
        return False
    if style.linePattern != None and (not isinstance(style.linePattern, (str)) or not hasattr(MwLinePattern, style.linePattern)): 
        print('Error line pattern format.')
        return False
    if style.borderPattern != None and (not isinstance(style.borderPattern, (str)) or not hasattr(MwBorderPattern, style.borderPattern)):
        print('Error border pattern format.')
        return False
    if style.arrowStart != None and (not isinstance(style.arrowStart, (str)) or not hasattr(MwArrowPattern, style.arrowStart)):
        print('Error arrow pattern format.')
        return False
    if style.arrowEnd != None and (not isinstance(style.arrowEnd, (str)) or not hasattr(MwArrowPattern, style.arrowEnd)):
        print('Error arrow pattern format.')
        return False
    if not isinstance(style.textBold, bool) or not isinstance(style.textItalic, bool) or not isinstance(style.textUnderLine, bool):
        print('Error text-style format.')
        return False
    if not isinstance(style.manhattanize, bool):
        print('Error manhattanize value format')
        return False
    if style.horizontalAlignment != None and (not isinstance(style.horizontalAlignment, (str)) or not hasattr(MwTextAlignment, style.horizontalAlignment)):
        print('Error text-alignment value format.')
        return False
    if style.smooth != None and style.smooth != 'None' and (not isinstance(style.smooth, (str)) or not hasattr(MwSmooth, style.smooth)):
        print('Error smooth value format.')
        return False
    return True

def _PrepareToExit():
    params = inspect.signature(_PrepareToExit).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(_PrepareToExit, args=args, kwargs={}, expected_types = expected_types)

def _GetWatchVarsValues():
    params = inspect.signature(_GetWatchVarsValues).parameters
    args = tuple(v for k, v in locals().items() if k not in ('self', 'params'))
    expected_types = [v.annotation for k, v in params.items() if k != 'self']
    return _MwConnect.__RunCurrentFunction__(_GetWatchVarsValues, args=args, kwargs={}, expected_types = expected_types)

def _CheckArgTypes(func_name: str, arg, arg_name: str, types: list):
    if len(types) == 0:
        return
    allowed_type_name = ""
    if len(types) == 1:
        allowed_type_name += types[0].__name__
    else:
        for index in range(len(types)):
            if index == len(types) - 1:
                allowed_type_name += " or "
            elif index != 0:
                allowed_type_name += ", "
            allowed_type_name += f"'{types[index].__name__}'"
    raise TypeError("%s() argument '%s' must be %s, not %r" %
        (func_name, arg_name, allowed_type_name, type(arg).__name__)) from None


def _CheckDictTypes(func_name: str,option_dict:dict,actual_dict:dict):
    for actual_key,actual_value in actual_dict.items():
        if actual_key in set(option_dict.keys()):
            expected_type = option_dict.get(actual_key)
            if not isinstance(actual_value,expected_type):
                raise TypeError(f"{func_name}() argument {actual_key} must be {expected_type},not {type(actual_value).__name__}") from None
        else:
            raise TypeError(f"{func_name}() unknown arguments found: {actual_key}") from None

def _IsArrayAllNumeric(arr):
    if not isinstance(arr, list):
        return False
    for element in arr:
        if type(element) not in (int, float):
            return False
    return True

def _IsArrayAllInt(arr):
    if not isinstance(arr, list):
        return False
    for element in arr:
        if type(element) != int:
            return False
    return True

# def GetModule(moduleName: str = ''):
#     if moduleName in subModules:
#         # module = self.subModules[moduleName]
#         # module.ws = self.ws
#         # return module
#         plugin = getattr(self.subModules[moduleName], moduleName)
#         self.pluginInstance = plugin(self.ws)
#         return self.pluginInstance
#     else:
#         print(f"没有找到名为{moduleName}的模块")
#         return None
__all__ = [name for name in globals() if not name.startswith('_')]