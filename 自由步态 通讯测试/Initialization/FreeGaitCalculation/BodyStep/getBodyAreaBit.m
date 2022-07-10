% 找到腿的工作空间的交集
% map_body_bit:腿的工作空间的交集在总工作空间下的bit
function map_body_bit = getBodyAreaBit(BODY_FOR_CALU, step_x_body, step_y_body)
lenx = length(step_x_body);
leny = length(step_y_body);

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

map_z_up = min(min(map_z1_up, map_z2_up), min(map_z3_up, map_z4_up)); map_z_down = max(max(map_z1_down, map_z2_down), max(map_z3_down, map_z4_down));
map_z_up(isnan(map_z1_up) | isnan(map_z2_up) | isnan(map_z3_up) | isnan(map_z4_up)) = nan; % 只要4个map中有一个是nan，说明该点都不可取
map_z_down(isnan(map_z_up)) = nan;
map_z_down(~(map_z_up >= 0  & map_z_down <= 0)) = nan; 
% map_z_down(~(map_z_up > map_z_down)) = nan; 
% map_z_down(map_z_down < 0) = 0;

map_body_bit = ~isnan(map_z_down);
% map_body_bit = map_z_down;
end