function findClosestObs "find nearest obstacle point"
  annotation(__MWORKS(version="26.3.0"),Protection(access=Access.diagram));
  input Real x;
  input Real y;
  input Real[:] obs_x;
  input Real[:] obs_y;
  input Real yaw;
  output Real vec_seg[2];
protected
  Integer n = size(obs_x, 1);
  Real min_dist = Modelica.Constants.inf;
  Real dx;
  Real dy;
  Real dist_sq;
  Real cos_yaw;
  Real sin_yaw;
  Real closest_dx;
  Real closest_dy;
algorithm
  cos_yaw := cos(yaw);
  sin_yaw := sin(yaw);
  closest_dx := 0;
  closest_dy := 0;

  for i in 1:n loop
    dx := obs_x[i] - x;
    dy := obs_y[i] - y;
    dist_sq := dx ^ 2 + dy ^ 2;

    if dist_sq < min_dist then
      min_dist := dist_sq;
      closest_dx := dx;
      closest_dy := dy;
    end if;
  end for;

  vec_seg[1] := cos_yaw * closest_dx + sin_yaw * closest_dy;
  vec_seg[2] := -sin_yaw * closest_dx + cos_yaw * closest_dy;
end findClosestObs;