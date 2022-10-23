% 根据地图，判断是否地图上的点是否可达

function [BODY_FOR_CALU, ReachablePos, map] = getReachPosforFoot(BODY_FOR_CALU, footReadytoMove, Gap)

BODY_FOR_CALU.len_x = length(BODY_FOR_CALU.Leg(footReadytoMove).map_x(1,:));
BODY_FOR_CALU.len_y = length(BODY_FOR_CALU.Leg(footReadytoMove).map_y(:,1)');
map_x = BODY_FOR_CALU.Leg(footReadytoMove).map_x;
map_y = BODY_FOR_CALU.Leg(footReadytoMove).map_y;

% 对map_z赋值
map_z = getHeight(Gap, BODY_FOR_CALU, footReadytoMove, map_x, map_y);
map_z = map_z - BODY_FOR_CALU.Body(footReadytoMove+10); % map_z减去现在这只脚的高度，求相对值

% 对map_z求梯度，梯度过大的点不能踩
[gradX,gradY] = gradient(map_z);

% 计算障碍物在地图上的位置
% ReachablePos矩阵表示了地图中哪些位置可以走，哪些不能走
if Gap(1).RectangleLengthWidth == [0 0]
    % 没有gap
    ReachablePos = true(BODY_FOR_CALU.len_y,BODY_FOR_CALU.len_x);
else
    % map_z不能大于最大值，小于最小值；梯度grad不能大于最大值
    ReachablePos = map_z >= BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down & map_z <= BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up ...
        & gradX <= BODY_FOR_CALU.gradBoundry & gradY <= BODY_FOR_CALU.gradBoundry;
end
ReachablePos(abs(map_x) <= 1e-4 & abs(map_y) <= 1e-4) = false; % x/y不能同时为0
if isempty(find(ReachablePos == 1,1))
    % 如果找不到1，说明下一步的范围内全是gap
    error('No reachable position is in next foot area.');
end

map = zeros(size(map_z,1), size(map_z,2), 3);
map(:,:,1) = map_x;
map(:,:,2) = map_y;
map(:,:,3) = map_z;

end