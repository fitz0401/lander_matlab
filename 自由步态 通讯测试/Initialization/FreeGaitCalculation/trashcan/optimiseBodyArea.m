% �ҵ��ȵĹ����ռ�Ľ���

function [map_body_bit, map_z_up, map_z_down] = optimiseBodyArea(BODY_FOR_CALU, step_x_body, step_y_body, size)
%% ��1��Ӧ�ֵ��map_body
[~, legx_start] = find(step_x_body == BODY_FOR_CALU.Leg(1).map_x(1,1)); % ������map�leg1��(1,leg1_start)ȡ��(1,leg1_end)
[~, legx_end] = find(step_x_body == BODY_FOR_CALU.Leg(1).map_x(1,end));
[~, legy_start] = find(step_y_body == BODY_FOR_CALU.Leg(1).map_y(1,1)); % �ֱ���x��y
[~, legy_end] = find(step_y_body == BODY_FOR_CALU.Leg(1).map_y(end,1));
map_body_bit1 = false(size); 
map_body_bit1(legy_start:legy_end, legx_start:legx_end) = true;
% leg_start��Щֵ�ǲ���ûʲô���ˣ����Ը���

%% ��2��Ӧ�ֵ��map_body
[~, legx_start] = find(step_x_body == BODY_FOR_CALU.Leg(2).map_x(1,1)); % ������map�leg1��(1,leg1_start)ȡ��(1,leg1_end)
[~, legx_end] = find(step_x_body == BODY_FOR_CALU.Leg(2).map_x(1,end));
[~, legy_start] = find(step_y_body == BODY_FOR_CALU.Leg(2).map_y(1,1)); % �ֱ���x��y
[~, legy_end] = find(step_y_body == BODY_FOR_CALU.Leg(2).map_y(end,1));
map_body_bit2 = false(size);
map_body_bit2(legy_start:legy_end, legx_start:legx_end) = true;

%% ��3��Ӧ�ֵ��map_body
[~, legx_start] = find(step_x_body == BODY_FOR_CALU.Leg(3).map_x(1,1)); % ������map�leg1��(1,leg1_start)ȡ��(1,leg1_end)
[~, legx_end] = find(step_x_body == BODY_FOR_CALU.Leg(3).map_x(1,end));
[~, legy_start] = find(step_y_body == BODY_FOR_CALU.Leg(3).map_y(1,1)); % �ֱ���x��y
[~, legy_end] = find(step_y_body == BODY_FOR_CALU.Leg(3).map_y(end,1));
map_body_bit3 = false(size);
map_body_bit3(legy_start:legy_end, legx_start:legx_end) = true;

%% ��4��Ӧ�ֵ��map_body
[~, legx_start] = find(step_x_body == BODY_FOR_CALU.Leg(4).map_x(1,1)); % ������map�leg1��(1,leg1_start)ȡ��(1,leg1_end)
[~, legx_end] = find(step_x_body == BODY_FOR_CALU.Leg(4).map_x(1,end));
[~, legy_start] = find(step_y_body == BODY_FOR_CALU.Leg(4).map_y(1,1)); % �ֱ���x��y
[~, legy_end] = find(step_y_body == BODY_FOR_CALU.Leg(4).map_y(end,1));
map_body_bit4 = false(size); 
map_body_bit4(legy_start:legy_end, legx_start:legx_end) = true;

%% �����ȵĽ�����Ϊ������Ե��˶���Χ
% map_body_bit = map_body_bit1 & map_body_bit2 & map_body_bit3 & map_body_bit4;

%% ����map_z
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
map_z_up(isnan(map_z1_up) | isnan(map_z2_up) | isnan(map_z3_up) | isnan(map_z4_up)) = nan; % ֻҪ4��map����һ����nan��˵���õ㶼����ȡ
map_z_down(isnan(map_z_up)) = nan;
map_z_up(map_z_up < map_z_down) = nan; % ���һ����nan����ô�����һ������false�������Ǵ��ڻ���С��
map_z_down(isnan(map_z_up)) = nan;

map_body_bit = ~isnan(map_z_up);
end