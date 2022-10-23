% �ҵ��ȵĹ����ռ�Ľ���
% map_body_bit:�ȵĹ����ռ�Ľ������ܹ����ռ��µ�bit
function map_body_bit = getBodyAreaBit(BODY_FOR_CALU, step_x_body, step_y_body,bodyMovement)
lenx = length(step_x_body);
leny = length(step_y_body);
%���������и߶Ȳ���ڵ�ʱ������Ĺ����ռ佻��ֻ������XY������˺��п��ܵ����ҵ��Ĺ����ռ佻����ʵ�����Ҫ��

%% �ҵ����������ܹ����ռ��е�λ��
map_legs_bit = getLegAreaBit(BODY_FOR_CALU, step_x_body, step_y_body);
%% ����z������ȡ0��ҲҪ��ȥ
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

%��������ϵ����ȡ�ĸ��������ϵ����map�е���Сֵ������ȡ�ĸ��������ϵ����map�е����ֵ
map_z_up = min(min(map_z1_up, map_z2_up), min(map_z3_up, map_z4_up)); map_z_down = max(max(map_z1_down, map_z2_down), max(map_z3_down, map_z4_down));
map_z_up(isnan(map_z1_up) | isnan(map_z2_up) | isnan(map_z3_up) | isnan(map_z4_up)) = nan; % ֻҪ4��map����һ����nan��˵���õ㶼����ȡ
map_z_down(isnan(map_z_up)) = nan;

% map_z_down(~(map_z_up >= 0  & map_z_down <= 0)) = nan; %�п���Ҫ�޸�����жϱ�׼��������Ϊmap_z�����½����0�Ϳ��ԣ�����ʵ���ϻ�����б��ʱ�򣬶�map_z��ѡ��Ҫ����ߣ�����������Ը������Ȳſ��ԣ��������������ƶ�ʱ��˳��������ռ�߽�������
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