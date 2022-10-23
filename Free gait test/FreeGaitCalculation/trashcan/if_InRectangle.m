% if_Recognize(Obstacle,step)判断下一步迈步时，四个脚是否会遇到障碍物
% 输入Obstacle（之前定义的struct）,step（步长）
% 输出地图（二维），若有障碍物，返回1，无障碍物，返回0

function Bit = if_InRectangle(BODY_FOR_CALU, Foot, map_z, gradX, gradY)

Bit = map_z >= BODY_FOR_CALU.Leg(Foot).zBoundry_down & map_z <= BODY_FOR_CALU.Leg(Foot).zBoundry_up ...
    & gradX <= BODY_FOR_CALU.gradBoundry & gradY <= BODY_FOR_CALU.gradBoundry;

end