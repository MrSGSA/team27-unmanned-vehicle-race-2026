within FinalRace2026;
package ScenarioGenerator
  "可复现的随机障碍物场景生成工具"

  function generateObstacles
    "在预先验证过的赛道位置附近生成互不重叠的随机障碍物"
    input Integer seed = 27 "随机种子；相同种子生成相同场景";
    input Integer count = 8 "障碍物数量，建议 1..16";
    input Real lateralRange = 0.08 "相对中心线的最大横向偏移 / m";
    input Real zPosition = -0.1105 "初赛道路视景使用的障碍物 z 坐标 / m";
    output Real obstaclePoint[count,3] "障碍物 x、y、z 坐标";
  protected
    // 每行依次为中心线 x、y 以及局部左法向 nx、ny。
    // 点位覆盖直道与缓弯，但避开起点、坡道和最尖锐的折弯。
    // 槽位顺序经过交错排列，使27号默认种子在前半段长直道也会
    // 连续遇障；其他种子仍从同一组安全位置中生成不同组合。
    constant Real slots[16,4] = {
      {11.9,7.5,-1,0}, {-42,27,1,0}, {-6,27,1,0}, {-42,39,1,0},
      {-6,36,1,0}, {12,33,-1,0}, {-15,15,0,-1}, {-24,24,-1,0},
      {-24,39,-1,0}, {-33,54,0,-1}, {12,42,-1,0}, {12,24,-1,0},
      {-42,15,1,0}, {-33,0,0,1}, {-20.1423,3.6266,-0.419,0.908},
      {-8.1657,2.8457,0.419,-0.908}};
    Integer state;
    Integer slot;
    Real offset;
  algorithm
    // 小整数线性同余序列可避免 32 位整数溢出，并便于跨平台复现。
    state := integer(mod(if seed >= 0 then seed else -seed, 65536));
    for i in 1:count loop
      state := integer(mod(25173*state + 13849, 65536));
      // 步长 5 与 16 互质，因此 count<=16 时不会选择重复槽位。
      slot := 1 + integer(mod((if seed >= 0 then seed else -seed) +
        5*(i - 1), 16));
      offset := lateralRange*(2*state/65535.0 - 1);
      obstaclePoint[i,1] := slots[slot,1] + offset*slots[slot,3];
      obstaclePoint[i,2] := slots[slot,2] + offset*slots[slot,4];
      obstaclePoint[i,3] := zPosition;
    end for;
  end generateObstacles;

  annotation(Documentation(info = "<html>
<p>障碍位置采用固定候选区加伪随机横向偏移。这样既能随种子变化，又不会随机到赛道外、起点或不可通行位置。</p>
<p>随机过程只在模型参数展开时执行，不会在仿真运行过程中移动障碍物。</p>
</html>"));
end ScenarioGenerator;
