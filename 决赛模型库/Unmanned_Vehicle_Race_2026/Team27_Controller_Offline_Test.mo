model Team27_Controller_Offline_Test
  "Team27 V2 pure-ultrasonic controller offline constant-input smoke test"
  extends ModelWorkspace;
  import SysplorerEmbeddedCoder.Types.*;
  import BaseWorkspace.*;
  annotation(__MWORKS(modelType=Control,PortArrangement(Right(speed,steer,gap,scanner_cmd)),BlockSystem(blockKind=BlockKind.userModel,SampleTime(auto=true,group="")=0.05,OutputInterval=0.05),version="26.3.0"),
    experiment(Algorithm=Euler,Interval=0.05,StartTime=0,StopTime=3,IntegratorStep=0.05,StoreEventValue=0),
    version="26.3.0");

  // Default scenario: clear front and symmetric front-left/front-right 45 deg
  // sectors.  leftInput/rightInput are risk sectors, not 90 deg wall distances.
  SysplorerEmbeddedCoder.Sources.Constant frontInput(k=150) annotation(__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.Sources.Constant rearInput(k=150);
  SysplorerEmbeddedCoder.Sources.Constant leftInput(k=100) annotation(__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.Sources.Constant rightInput(k=100) annotation(__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  SysplorerEmbeddedCoder.Sources.Constant scannerInput(k=150) annotation(__MWORKS(BlockSystem(SampleTime(auto=true)=-1)));
  Controller.ObsAvoidController_Team27_MWorks controller;

  SysplorerEmbeddedCoder.Port.Outport speed;
  SysplorerEmbeddedCoder.Port.Outport steer;
  SysplorerEmbeddedCoder.Port.Outport gap;
  SysplorerEmbeddedCoder.Port.Outport scanner_cmd;

  model ModelWorkspace
    annotation(__MWORKS(hide=true,BlockSystem(blockKind=BlockKind.modelWorkspace)));
  end ModelWorkspace;
equation
  connect(frontInput.y,controller.front_dist);
  connect(rearInput.y,controller.rear_dist);
  connect(leftInput.y,controller.left_dist);
  connect(rightInput.y,controller.right_dist);
  connect(scannerInput.y,controller.fu_dist);
  connect(controller.speed,speed);
  connect(controller.steer,steer);
  connect(controller.gap,gap);
  connect(controller.fu_sensor_cmd,scanner_cmd);
end Team27_Controller_Offline_Test;
