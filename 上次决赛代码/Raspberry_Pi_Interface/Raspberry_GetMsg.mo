model Raspberry_GetMsg
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(modelType=Control,PortArrangement(Right(dis1, dis2, dis3, dis4, dis5)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.02),CodeGeneration(Config = {"code_placement":{"mode":"Compact"},"code_replacement":{"fixed_point_library":"Fixed-TY","standard_c_library":"C99"},"custom_code":{"code":{"function_declare":{"head":"","item_head":"","item_tail":"","tail":""},"function_define":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_declare":{"head":"","item_head":"","item_tail":"","tail":""},"global_variable_define":{"head":"","item_head":"","item_tail":"","tail":""},"include":{"head":"","item_head":"","item_tail":"","tail":""},"macro":{"head":"","item_head":"","item_tail":"","tail":""},"type":{"head":"","item_head":"","item_tail":"","tail":""}},"code_protection":{"integer_division_by_zero":false,"overflow":false}},"data_type":{"real_as_float":true},"experiment":{"task_and_sample":{"muti_task_mode":false}},"hardware_platform":{"byte_ordering":"Big Endian","largest_atomic_size":{"floating_point":"32","integer":"32"},"number_of_bits":{"char":8,"double":32,"float":32,"int":32,"long":32,"long_long":0,"pointer":32,"ptrdiff_t":32,"size_t":32},"support_dynamic_memory_allocation":false,"support_float_point":true,"target":"get","type_platform":"ARM Cortex-M0","vendor":"中颖科技"},"identifier":{"format":{"function":"{{model_name}}{{name}}","global_variable":"{{model_name}}{{data_type}}{{prefix}}{{name}}","local_variable":"{{data_type}}{{prefix}}{{name}}","macro":"{{model_name}}{{name}}","mem_var":"{{model_name}}{{name}}","type":"{{model_name}}{{name}}"},"format_string":{"boolean":"b","input":"in","integer":"i","output":"out","parameter":"p","real":"r"},"max_length":32,"style":{"function":"camelCase","global_variable":"camelCase","local_variable":"camelCase","macro":"camelCase","mem_var":"camelCase","type":"camelCase"}},"interface":{"function_name":{"initialize"
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
  CCaller1 c_caller1 
    annotation (Placement(transformation(origin={-168,68.3334}, 
extent={{-28,-45.6667},{28,45.6667}})),__MWORKS(ComponentNamePlacement(BOTTOM),BlockSystem(SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport dis1 
    annotation (Placement(transformation(origin={-79,104.867}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,80}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport dis2 
    annotation (Placement(transformation(origin={-79,86.6}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,40}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport dis3 
    annotation (Placement(transformation(origin={-79,68.3334}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,0}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport dis4 
    annotation (Placement(transformation(origin={-79,50.0667}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,-40}, 
extent={{-1.8,-1.8},{1.8,1.8}})),__MWORKS(BlockSystem(Type(ref="double"),Dimension=1,SampleTime(group="D1")=0.02)));
  SysplorerEmbeddedCoder.Port.Outport dis5 
    annotation (Placement(transformation(origin={-79,31.8}, 
extent={{-6.5,-6.5},{6.5,6.5}}), 
iconTransformation(origin={101.8,-80}, 
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
    output SysplorerEmbeddedCoder.Types.Auto sensor1_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor2_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor3_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor4_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
    output SysplorerEmbeddedCoder.Types.Auto sensor5_distence annotation(__MWORKS(BlockSystem(Type(inherit = InheritType.none, ref="double"), Dimension(dimensionType = DimensionType.none) = 1)));
  external "C" GetCarMsg(sensor1_distence,sensor2_distence,sensor3_distence,sensor4_distence,sensor5_distence);
  end func_CCaller1;
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

    (sensor1_distence, sensor2_distence, sensor3_distence, sensor4_distence, sensor5_distence) = func_CCaller1();
  end CCaller1;
  equation
  connect(c_caller1.sensor1_distence, dis1) 
  annotation(Line(origin={-116,81}, 
points={{-22.2,23.8668},{37,23.8668},{37,23.867}}, 
color={0,0,0}),__MWORKS(BlockSystem(NamedSignal)));
  connect(c_caller1.sensor2_distence, dis2) 
  annotation(Line(origin={-116,67}, 
points={{-22.2,19.6},{37,19.6}}, 
color={0,0,0}));
  connect(c_caller1.sensor3_distence, dis3) 
  annotation(Line(origin={-116,52}, 
points={{-22.2,16.3334},{37,16.3334}}, 
color={0,0,0}));
  connect(c_caller1.sensor4_distence, dis4) 
  annotation(Line(origin={-116,37}, 
points={{-22.2,13.0667},{37,13.0667}}, 
color={0,0,0}));
  connect(c_caller1.sensor5_distence, dis5) 
  annotation(Line(origin={-116,23}, 
points={{-22.2,8.80003},{37,8.80003}}, 
color={0,0,0}));
  end Raspberry_GetMsg;