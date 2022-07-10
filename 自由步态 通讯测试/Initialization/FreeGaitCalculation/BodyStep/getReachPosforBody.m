% ���ݹ����ռ䣬��ÿ��н�
%�������ռ�Ǿ������򣬸��㷨�Ƿ���ã�
function [BODY_FOR_CALU, Bit_BodyStableArea, Bit_ReachableArea, map] = getReachPosforBody(BODY_FOR_CALU, index, bodyMovement)
% ������ת��������Ӧ���ĽŹ����ռ���Ҫ�仯
% ��leg�У�x/y��ķ��򲻱䣬��ʾ���Ǿֲ�����ϵ���������ƶ�ʱҪע��
% ��ȫ������ϵ���ƶ����پ��룬��Ҫ�ھֲ�����ϵ���ƶ����پ���
for i = 1:4
    % ���ڹ����ռ��λ�÷����仯
    % �ŵĹ����ռ��ʾ���Ǿֲ�����ϵ
    footMat = [BODY_FOR_CALU.Body0(i);BODY_FOR_CALU.Body0(i+5);BODY_FOR_CALU.Body0(i+10)] ...
        - [BODY_FOR_CALU.Body0(5);BODY_FOR_CALU.Body0(10);BODY_FOR_CALU.Body0(15)]; % footMat��ʾ��������ڳ�ʼλ��
    delta = footMat - eul2rotm(bodyMovement(4:6),'XYZ') * footMat;
    delta = eul2rotm(-bodyMovement(linspace(6,4,3)),'ZYX') * delta;
    delta = RoundDis(BODY_FOR_CALU.Inteval, delta);
    
    BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x - delta(1);
    BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y - delta(2);
    BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up - delta(3);
    BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down - delta(3);
    
    % ������ȷ������z���˶�������Ӧ���ĽŹ����ռ���Ҫ�仯
%     bodyMovement(1:3) = eul2rotm([-bodyMovement(6) -bodyMovement(5) -bodyMovement(4)])...
%         * bodyMovement(1:3)';
    bodyMovement(1:3) = eul2rotm(-bodyMovement(linspace(6,4,3)),'ZYX') * bodyMovement(1:3)';
    BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up + bodyMovement(3);
    BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down + bodyMovement(3);
    
end

%��һ�μ������幤���ռ䷶Χ�Ĵ�����ɣ�����ֻ�������ڳ����幤���ռ�

% ���㹤���ռ�ļ�ֵ
xBoundry(1) = min([BODY_FOR_CALU.Leg(1).map_x(:,1); BODY_FOR_CALU.Leg(2).map_x(:,1); BODY_FOR_CALU.Leg(3).map_x(:,1); BODY_FOR_CALU.Leg(4).map_x(:,1)]);
xBoundry(2) = max([BODY_FOR_CALU.Leg(1).map_x(:,end); BODY_FOR_CALU.Leg(2).map_x(:,end); BODY_FOR_CALU.Leg(3).map_x(:,end); BODY_FOR_CALU.Leg(4).map_x(:,end)]);
yBoundry(1) = max([BODY_FOR_CALU.Leg(1).map_y(1,:) BODY_FOR_CALU.Leg(2).map_y(1,:) BODY_FOR_CALU.Leg(3).map_y(1,:) BODY_FOR_CALU.Leg(4).map_y(1,:)]);
yBoundry(2) = min([BODY_FOR_CALU.Leg(1).map_y(end,:) BODY_FOR_CALU.Leg(2).map_y(end,:) BODY_FOR_CALU.Leg(3).map_y(end,:) BODY_FOR_CALU.Leg(4).map_y(end,:)]);
% ͨ����ֵ����������幤���ռ�ļ�ֵ
step_x = linspace(xBoundry(1), xBoundry(2), (xBoundry(2)-xBoundry(1))/BODY_FOR_CALU.Inteval+1); % x��С���� y�Ӵ�С
step_y = linspace(yBoundry(1), yBoundry(2), (yBoundry(1)-yBoundry(2))/BODY_FOR_CALU.Inteval+1); 
BODY_FOR_CALU.len_x = length(step_x);
BODY_FOR_CALU.len_y = length(step_y);

map_x = repmat(step_x,1,1,BODY_FOR_CALU.len_y);
map_y = repmat(step_y,1,1,BODY_FOR_CALU.len_x); 
map_y = permute(map_y,[1 3 2]);
% ֻ��Ҫ��map_x_body��Ӧ��ֵ���ɣ���Ϊ�����bit��map_x��map_y��ͬ
%Ѱ�Ҹ��ȹ����ռ��غϵĽ���
Bit_ReachableArea = getBodyAreaBit(BODY_FOR_CALU, step_x, step_y);
% Bit_ReachableArea = ~isnan(map_z);
% Bit_map_body�Ƕ�ά�ģ���Ҫ�ĳ���ά
Bit_ReachableArea = permute(Bit_ReachableArea,[3 2 1]);
% map_z = permute(map_z,[3 2 1]);
% ����map��bit���ǽ����ڽŵĹ��������ռ��µģ���Ӧ�������ϻ���Ҫȡ��
%ΪʲôҪ�Ѿ���ֵ��ת180�ȣ�������źͻ�������ϵ�йأ�����
Bit_ReachableArea = rot90(Bit_ReachableArea,2);
map_x = rot90(map_x,2); map_y = rot90(map_y,2);
map_x = -map_x; map_y = -map_y;

map_z = zeros(size(Bit_ReachableArea));
% map_z(~Bit_ReachableArea) = nan; % �����ߵ�λ����Ϊnan������Ϊ0
map_x(~Bit_ReachableArea) = nan; map_y(~Bit_ReachableArea) = nan;
% map��Ҫ��ת����ȫ������ϵ�£�����ȥ�����Ӧλ��
[~, row, col] = size(map_x);
% mapTemp = zeros(3,col,row);
mapTemp(1,:,:) = map_x;
mapTemp(2,:,:) = map_y;
mapTemp(3,:,:) = map_z;

mapTemp = reshape(mapTemp, [3 row * col]);
mapTemp = eul2rotm(bodyMovement(4:6),'XYZ') * mapTemp;
mapTemp = reshape(mapTemp, [3,row,col]);

map_x = mapTemp(1,:,:);
map_y = mapTemp(2,:,:);
map_z = mapTemp(3,:,:);
% map_x = reshape(mapTemp(1,:,:), [row, col]);
% map_y = reshape(mapTemp(2,:,:), [row, col]);
% map_z = reshape(mapTemp(3,:,:), [row, col]);
% ������map�����˱仯

BODY_FOR_CALU.Body = repmat(BODY_FOR_CALU.Body,1,BODY_FOR_CALU.len_x,BODY_FOR_CALU.len_y);
% ����G���������Ժ�õ������������������Ρ�1 * BODY_FOR_CALU.len_x * BODY_FOR_CALU.len_y ��string array
[PosG, BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,5,map_x,map_y,map_z); 
% ��nan���ڵľ��󣬲�����ô���㣬��һ����Զ��nan

Next(index == 1) = "A"; Next(index == 2) = "B";
Next(index == 3) = "C"; Next(index == 4) = "D";

Bit_BodyStableArea = ~contains(PosG,Next) & PosG ~= ""; % 3-D�߼�������һ�������ߵ�Ϊ1

map = zeros(size(map_z));
map(1,:,:) = map_x;
map(2,:,:) = map_y;
map(3,:,:) = map_z;

end