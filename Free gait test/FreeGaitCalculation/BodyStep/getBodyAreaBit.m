% 找到腿的工作空间的交集
% map_body_bit:腿的工作空间的交集在总工作空间下的bit
function map_body_bit = getBodyAreaBit(BODY_FOR_CALU, step_x_body, step_y_body,bodyMovement)
lenx = length(step_x_body);
leny = length(step_y_body);
%当四条腿有高度差存在的时候，这里的工作空间交集只考虑了XY方向，因此很有可能导致找到的工作空间交集比实际情况要大

%% 找到各个腿在总工作空间中的位置
map_legs_bit = getLegAreaBit(BODY_FOR_CALU, step_x_body, step_y_body);
%% 所有z方向不能取0的也要舍去
map_z1_up = zeros(leny,lenx); map_z1_down = zeros(leny,lenx);
map_z1_up(map_legs_bit(1,:,:)) = BODY_FOR_CALU.Leg(1).zBoundry_up; map_z1_up(~map_legs_bit(1,:,:)) = nan; 
map_z1_down(map_legs_bit(1,:,:)) = BODY_FOR_CALU.Leg(1).zBoundry_down; map_z1_down(~map_legs_bit(1,:,:)) = nan;

map_z2_up = zeros(leny,lenx); map_z2_down = zeros(leny,lenx);
map_z2_up(map_legs_bit(2,:,:)) = BODY_FOR_CALU.Leg(2).zBoundry_up; map_z2_up(~map_legs_bit(2,:,:)) = nan; 
map_z2_down(map_legs_bit(2,:,:)) = BODY_FOR_CALU.Leg(2).zBoundry_down; map_z2_down(~map_legs_bit(2,:,:)) = nan;

map_z3_up = zeros(leny,lenx); map_z3_down = zeros(leny,lenx);
map_z3_up(map_legs_bit(3,:,:)) = BODY_FOR_CALU.Leg(3).zBoundry_up; map_z3_up(~map_legs_bit(3,:,:)) = nan; 
map_z3_down(map_legs_bit(3,:,:)) = BODY_FOR_CALU.Leg(3).zBoundry_down; map_z3_down(~map_legs_bit(3,:,:)) = nan;

map_z4_up = zeros(leny,lenx); map_z4_down = zeros(leny,lenx);
map_z4_up(map_legs_bit(4,:,:)) = BODY_FOR_CALU.Leg(4).zBoundry_up; map_z4_up(~map_legs_bit(4,:,:)) = nan; 
map_z4_down(map_legs_bit(4,:,:)) = BODY_FOR_CALU.Leg(4).zBoundry_down; map_z4_down(~map_legs_bit(4,:,:)) = nan;

%机身坐标系上限取四个足端坐标系在总map中的最小值，下限取四个足端坐标系在总map中的最大值
map_z_up = min(min(map_z1_up, map_z2_up), min(map_z3_up, map_z4_up)); map_z_down = max(max(map_z1_down, map_z2_down), max(map_z3_down, map_z4_down));
map_z_up(isnan(map_z1_up) | isnan(map_z2_up) | isnan(map_z3_up) | isnan(map_z4_up)) = nan; % 只要4个map中有一个是nan，说明该点都不可取
map_z_down(isnan(map_z_up)) = nan;

% map_z_down(~(map_z_up >= 0  & map_z_down <= 0)) = nan; %有可能要修改这个判断标准，这里认为map_z的上下界包括0就可以，但是实际上机身倾斜的时候，对map_z的选择要求更高，必须满足可以覆盖四腿才可以，否则会出现身体移动时足端超出工作空间边界的情况；
% map_z_down(~(map_z_up >= 10  & map_z_down <= -10)) = nan;
if bodyMovement(3)>=0
    map_z_down(~(map_z_up >= bodyMovement(3)+5  &  map_z_down <= -3)) = nan;
else
    map_z_down(~(map_z_up >= 3  & map_z_down <= bodyMovement(3)-5)) = nan;
end
% map_z_down(~(map_z_up > map_z_down)) = nan; 
% map_z_down(map_z_down < 0) = 0;

map_body_bit = ~isnan(map_z_down);
% map_body_bit = map_z_down;
end