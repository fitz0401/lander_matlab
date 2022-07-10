% 根据工作空间，获得可行解
%若工作空间非矩形区域，该算法是否可用？
function [BODY_FOR_CALU, Bit_BodyStableArea, Bit_ReachableArea, map] = getReachPosforBody(BODY_FOR_CALU, index, bodyMovement)
% 若身体转动，则相应的四脚工作空间需要变化
% 在leg中，x/y轴的方向不变，表示的是局部坐标系，所以在移动时要注意
% 在全局坐标系下移动多少距离，需要在局部坐标系下移动多少距离
for i = 1:4
    % 脚在工作空间的位置发生变化
    % 脚的工作空间表示的是局部坐标系
    footMat = [BODY_FOR_CALU.Body0(i);BODY_FOR_CALU.Body0(i+5);BODY_FOR_CALU.Body0(i+10)] ...
        - [BODY_FOR_CALU.Body0(5);BODY_FOR_CALU.Body0(10);BODY_FOR_CALU.Body0(15)]; % footMat表示的是相对于初始位置
    delta = footMat - eul2rotm(bodyMovement(4:6),'XYZ') * footMat;
    delta = eul2rotm(-bodyMovement(linspace(6,4,3)),'ZYX') * delta;
    delta = RoundDis(BODY_FOR_CALU.Inteval, delta);
    
    BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x - delta(1);
    BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y - delta(2);
    BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up - delta(3);
    BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down - delta(3);
    
    % 若身体确定发生z向运动，则相应的四脚工作空间需要变化
%     bodyMovement(1:3) = eul2rotm([-bodyMovement(6) -bodyMovement(5) -bodyMovement(4)])...
%         * bodyMovement(1:3)';
    bodyMovement(1:3) = eul2rotm(-bodyMovement(linspace(6,4,3)),'ZYX') * bodyMovement(1:3)';
    BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up + bodyMovement(3);
    BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down + bodyMovement(3);
    
end

%这一段计算身体工作空间范围的代码存疑，疑似只能适用于长方体工作空间

% 四足工作空间的极值
xBoundry(1) = min([BODY_FOR_CALU.Leg(1).map_x(:,1); BODY_FOR_CALU.Leg(2).map_x(:,1); BODY_FOR_CALU.Leg(3).map_x(:,1); BODY_FOR_CALU.Leg(4).map_x(:,1)]);
xBoundry(2) = max([BODY_FOR_CALU.Leg(1).map_x(:,end); BODY_FOR_CALU.Leg(2).map_x(:,end); BODY_FOR_CALU.Leg(3).map_x(:,end); BODY_FOR_CALU.Leg(4).map_x(:,end)]);
yBoundry(1) = max([BODY_FOR_CALU.Leg(1).map_y(1,:) BODY_FOR_CALU.Leg(2).map_y(1,:) BODY_FOR_CALU.Leg(3).map_y(1,:) BODY_FOR_CALU.Leg(4).map_y(1,:)]);
yBoundry(2) = min([BODY_FOR_CALU.Leg(1).map_y(end,:) BODY_FOR_CALU.Leg(2).map_y(end,:) BODY_FOR_CALU.Leg(3).map_y(end,:) BODY_FOR_CALU.Leg(4).map_y(end,:)]);
% 通过极值，计算出身体工作空间的极值
step_x = linspace(xBoundry(1), xBoundry(2), (xBoundry(2)-xBoundry(1))/BODY_FOR_CALU.Inteval+1); % x从小到大 y从大到小
step_y = linspace(yBoundry(1), yBoundry(2), (yBoundry(1)-yBoundry(2))/BODY_FOR_CALU.Inteval+1); 
BODY_FOR_CALU.len_x = length(step_x);
BODY_FOR_CALU.len_y = length(step_y);

map_x = repmat(step_x,1,1,BODY_FOR_CALU.len_y);
map_y = repmat(step_y,1,1,BODY_FOR_CALU.len_x); 
map_y = permute(map_y,[1 3 2]);
% 只需要找map_x_body对应的值即可，因为输出的bit在map_x和map_y相同
%寻找各腿工作空间重合的交集
Bit_ReachableArea = getBodyAreaBit(BODY_FOR_CALU, step_x, step_y);
% Bit_ReachableArea = ~isnan(map_z);
% Bit_map_body是二维的，需要改成三维
Bit_ReachableArea = permute(Bit_ReachableArea,[3 2 1]);
% map_z = permute(map_z,[3 2 1]);
% 上述map和bit都是建立在脚的公共工作空间下的，反应到身体上还需要取反
%为什么要把矩阵值旋转180度？？？与脚和机身坐标系有关？？？
Bit_ReachableArea = rot90(Bit_ReachableArea,2);
map_x = rot90(map_x,2); map_y = rot90(map_y,2);
map_x = -map_x; map_y = -map_y;

map_z = zeros(size(Bit_ReachableArea));
% map_z(~Bit_ReachableArea) = nan; % 不能走的位置置为nan，其他为0
map_x(~Bit_ReachableArea) = nan; map_y(~Bit_ReachableArea) = nan;
% map需要先转化到全局坐标系下，才能去计算对应位置
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
% 以上是map发生了变化

BODY_FOR_CALU.Body = repmat(BODY_FOR_CALU.Body,1,BODY_FOR_CALU.len_x,BODY_FOR_CALU.len_y);
% 若走G，则走完以后得到现在身体所在三角形。1 * BODY_FOR_CALU.len_x * BODY_FOR_CALU.len_y 的string array
[PosG, BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,5,map_x,map_y,map_z); 
% 有nan存在的矩阵，不管怎么计算，哪一项永远是nan

Next(index == 1) = "A"; Next(index == 2) = "B";
Next(index == 3) = "C"; Next(index == 4) = "D";

Bit_BodyStableArea = ~contains(PosG,Next) & PosG ~= ""; % 3-D逻辑矩阵。下一步可以走的为1

map = zeros(size(map_z));
map(1,:,:) = map_x;
map(2,:,:) = map_y;
map(3,:,:) = map_z;

end