% 找到腿的工作空间的交集

function [map_body_bit, map_z_up, map_z_down] = optimiseBodyArea(BODY_FOR_CALU, step_x_body, step_y_body, size)
%% 腿1对应项赋值到map_body
[~, legx_start] = find(step_x_body == BODY_FOR_CALU.Leg(1).map_x(1,1)); % 在身体map里，leg1从(1,leg1_start)取到(1,leg1_end)
[~, legx_end] = find(step_x_body == BODY_FOR_CALU.Leg(1).map_x(1,end));
[~, legy_start] = find(step_y_body == BODY_FOR_CALU.Leg(1).map_y(1,1)); % 分别是x和y
[~, legy_end] = find(step_y_body == BODY_FOR_CALU.Leg(1).map_y(end,1));
map_body_bit1 = false(size); 
map_body_bit1(legy_start:legy_end, legx_start:legx_end) = true;
% leg_start这些值是不是没什么用了，可以覆盖

%% 腿2对应项赋值到map_body
[~, legx_start] = find(step_x_body == BODY_FOR_CALU.Leg(2).map_x(1,1)); % 在身体map里，leg1从(1,leg1_start)取到(1,leg1_end)
[~, legx_end] = find(step_x_body == BODY_FOR_CALU.Leg(2).map_x(1,end));
[~, legy_start] = find(step_y_body == BODY_FOR_CALU.Leg(2).map_y(1,1)); % 分别是x和y
[~, legy_end] = find(step_y_body == BODY_FOR_CALU.Leg(2).map_y(end,1));
map_body_bit2 = false(size);
map_body_bit2(legy_start:legy_end, legx_start:legx_end) = true;

%% 腿3对应项赋值到map_body
[~, legx_start] = find(step_x_body == BODY_FOR_CALU.Leg(3).map_x(1,1)); % 在身体map里，leg1从(1,leg1_start)取到(1,leg1_end)
[~, legx_end] = find(step_x_body == BODY_FOR_CALU.Leg(3).map_x(1,end));
[~, legy_start] = find(step_y_body == BODY_FOR_CALU.Leg(3).map_y(1,1)); % 分别是x和y
[~, legy_end] = find(step_y_body == BODY_FOR_CALU.Leg(3).map_y(end,1));
map_body_bit3 = false(size);
map_body_bit3(legy_start:legy_end, legx_start:legx_end) = true;

%% 腿4对应项赋值到map_body
[~, legx_start] = find(step_x_body == BODY_FOR_CALU.Leg(4).map_x(1,1)); % 在身体map里，leg1从(1,leg1_start)取到(1,leg1_end)
[~, legx_end] = find(step_x_body == BODY_FOR_CALU.Leg(4).map_x(1,end));
[~, legy_start] = find(step_y_body == BODY_FOR_CALU.Leg(4).map_y(1,1)); % 分别是x和y
[~, legy_end] = find(step_y_body == BODY_FOR_CALU.Leg(4).map_y(end,1));
map_body_bit4 = false(size); 
map_body_bit4(legy_start:legy_end, legx_start:legx_end) = true;

%% 四条腿的交集即为身体可以的运动范围
% map_body_bit = map_body_bit1 & map_body_bit2 & map_body_bit3 & map_body_bit4;

%% 定义map_z
map_z1_up = zeros(size); map_z1_down = zeros(size);
map_z1_up(map_body_bit1) = BODY_FOR_CALU.Leg(1).zBoundry_up; map_z1_up(~map_body_bit1) = nan; 
map_z1_down(map_body_bit1) = BODY_FOR_CALU.Leg(1).zBoundry_down; map_z1_down(~map_body_bit1) = nan;

map_z2_up = zeros(size); map_z2_down = zeros(size);
map_z2_up(map_body_bit2) = BODY_FOR_CALU.Leg(2).zBoundry_up; map_z2_up(~map_body_bit2) = nan; 
map_z2_down(map_body_bit2) = BODY_FOR_CALU.Leg(2).zBoundry_down; map_z2_down(~map_body_bit2) = nan;

map_z3_up = zeros(size); map_z3_down = zeros(size);
map_z3_up(map_body_bit3) = BODY_FOR_CALU.Leg(3).zBoundry_up; map_z3_up(~map_body_bit3) = nan; 
map_z3_down(map_body_bit3) = BODY_FOR_CALU.Leg(3).zBoundry_down; map_z3_down(~map_body_bit3) = nan;

map_z4_up = zeros(size); map_z4_down = zeros(size);
map_z4_up(map_body_bit4) = BODY_FOR_CALU.Leg(4).zBoundry_up; map_z4_up(~map_body_bit4) = nan; 
map_z4_down(map_body_bit4) = BODY_FOR_CALU.Leg(4).zBoundry_down; map_z4_down(~map_body_bit4) = nan;

map_z_up = min(min(map_z1_up, map_z2_up), min(map_z3_up, map_z4_up)); map_z_down = max(max(map_z1_down, map_z2_down), max(map_z3_down, map_z4_down));
map_z_up(isnan(map_z1_up) | isnan(map_z2_up) | isnan(map_z3_up) | isnan(map_z4_up)) = nan; % 只要4个map中有一个是nan，说明该点都不可取
map_z_down(isnan(map_z_up)) = nan;
map_z_up(map_z_up < map_z_down) = nan; % 如果一个是nan，那么这个点一定返回false，不管是大于还是小于
map_z_down(isnan(map_z_up)) = nan;

map_body_bit = ~isnan(map_z_up);
end