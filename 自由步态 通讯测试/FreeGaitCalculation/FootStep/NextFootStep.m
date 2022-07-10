% NextStep_FreeGait：计算迈步。根据地形判断这一步迈多少
% 输入：BODY_FOR_CALU（目前身体）, NextFoot_index（下一步要走的脚）, Gap（沟壑）, stride（最大跨度）
% 输出：这一步的步长（这一步的步长 1*2 double）

function StepForLeg = NextFootStep(BODY_FOR_CALU, footReadytoMove, Gap, alpha)
%% 首先要根据地图，判断是否地图上的点是否可达
% mapx/y是在脚的局部坐标系下的，需要首先转到全局的地图坐标系下
[row,col] = size(BODY_FOR_CALU.Leg(footReadytoMove).map_x);
mapTempX = reshape(BODY_FOR_CALU.Leg(footReadytoMove).map_x, [1 row * col]);
mapTempY = reshape(BODY_FOR_CALU.Leg(footReadytoMove).map_y, [1 row * col]);
mapTempZup = reshape(BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up, [1 row * col]);
mapTempZdown = reshape(BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down, [1 row * col]);

mapTemp3matUp = [mapTempX; mapTempY; mapTempZup];
mapTemp3matUp = eul2rotm(BODY_FOR_CALU.RotateAngle,'XYZ') * mapTemp3matUp;

mapTemp3matDown = [mapTempX; mapTempY; mapTempZdown];
mapTemp3matDown = eul2rotm(BODY_FOR_CALU.RotateAngle,'XYZ') * mapTemp3matDown;

BODY_FOR_CALU.Leg(footReadytoMove).map_x = reshape(mapTemp3matUp(1,:), [row,col]);
BODY_FOR_CALU.Leg(footReadytoMove).map_y = reshape(mapTemp3matUp(2,:), [row,col]);
BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up = reshape(mapTemp3matUp(3,:), [row,col]);
BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down = reshape(mapTemp3matDown(3,:), [row,col]);

BODY_FOR_CALU.len_x = length(BODY_FOR_CALU.Leg(footReadytoMove).map_x(1,:));
BODY_FOR_CALU.len_y = length(BODY_FOR_CALU.Leg(footReadytoMove).map_y(:,1)');
map_x = BODY_FOR_CALU.Leg(footReadytoMove).map_x;
map_y = BODY_FOR_CALU.Leg(footReadytoMove).map_y;

% 对map_z赋值
map_z = getFootHeight(Gap, BODY_FOR_CALU, footReadytoMove, map_x, map_y);
map_z = map_z - BODY_FOR_CALU.Body(footReadytoMove+10); % map_z减去现在这只脚的高度，求相对值

% 对map_z求梯度，梯度过大的点不能踩
[gradX,gradY] = gradient(map_z);

% 计算障碍物在地图上的位置
% ReachablePos矩阵表示了地图中哪些位置可以走，哪些不能走
%此处判断准则为包含在所给工作空间Z轴上下界之间的区域，且该位置的梯度要小于机器人运动准许梯度，这里其实为可行域判断，后续可以通过引入视觉信息中的可行域地图与工作空间求交得到
ReachablePos = map_z >= BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down & map_z <= BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up ...
    & gradX <= BODY_FOR_CALU.gradBoundry & gradY <= BODY_FOR_CALU.gradBoundry;
ReachablePos(abs(map_x) < BODY_FOR_CALU.Inteval & abs(map_y) < BODY_FOR_CALU.Inteval) = false; % x/y不能同时为0 %功能暂未确定
if isempty(find(ReachablePos == 1,1))
    % 如果找不到1，说明下一步的范围内全是gap
    error('No reachable position is in next foot area.');
end

%{
%% 对下一步是否自锁进行预判

% 先判断之后走哪一只脚
vectorForFoot = 1:4; vectorForFoot(footReadytoMove) = []; % 除了要迈的这只脚，考虑其他三脚的运动学裕度
[~, indexNextFoot] = min(BODY_FOR_CALU.interSpace(vectorForFoot,1));
nextFoot = vectorForFoot(indexNextFoot); % 下一步要走的脚
if nextFoot == 1 || nextFoot == 3
    lineForFoot = [2 4];
else
    lineForFoot = [1 3];
end

BODY_FOR_CALU.Body = repmat(BODY_FOR_CALU.Body,1,BODY_FOR_CALU.len_x,BODY_FOR_CALU.len_y);
% 为了IfMove，需要先reshape成三维矩阵
map_x_move = permute(reshape(map_x,[1 size(map_x)]),[1 3 2]);
map_y_move = permute(reshape(map_y,[1 size(map_y)]),[1 3 2]);
map_z_move = permute(reshape(map_z,[1 size(map_z)]),[1 3 2]);
% 这只脚走完这个距离，得到目前42*380*380的身体矩阵状态
[~,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,footReadytoMove,map_x_move,map_y_move,map_z_move); 
% PosG = reshape(permute(PosG,[1,3,2]),size(map_x)); % 将PosG转成二维
%{
NotDeadLock = false(1,size(map_x,1),size(map_x,2));

% 迈的那一只脚的工作空间会变化，因此单列出一个变量
mapFootX = BODY_FOR_CALU.Leg(footReadytoMove).map_x;
mapFootY = BODY_FOR_CALU.Leg(footReadytoMove).map_y;
mapFootZup = BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up;
mapFootZdown = BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down;
for xIndex = 1:BODY_FOR_CALU.len_x
    for yIndex = 1:BODY_FOR_CALU.len_y
        % 如果这一项是之前算出的可达点，预判下一步是否自锁
        % 否则直接跳过
        if ReachablePos(yIndex, xIndex) == true
            % 首先更新这个脚的工作空间
            BODY_FOR_CALU.Leg(footReadytoMove).map_x = BODY_FOR_CALU.Leg(footReadytoMove).map_x - map_x(yIndex, xIndex);
            BODY_FOR_CALU.Leg(footReadytoMove).map_y = BODY_FOR_CALU.Leg(footReadytoMove).map_y - map_y(yIndex, xIndex);
            BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down = BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down - map_z(yIndex, xIndex);
            BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up = BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up - map_z(yIndex, xIndex);
            
            % 计算身体的工作空间
            [~, Bit_NextFoot, ~, ~] = getReachPosforBody(BODY_FOR_CALU, footReadytoMove);
            
            if ~isempty(find(Bit_NextFoot == 1,1)) % 如果找得到1，说明下一步不自锁
                NotDeadLock(1, xIndex, yIndex) = true;
            end
            
            % 恢复这个脚的工作空间
            BODY_FOR_CALU.Leg(footReadytoMove).map_x = mapFootX;
            BODY_FOR_CALU.Leg(footReadytoMove).map_y = mapFootY;
            BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down = mapFootZup;
            BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up = mapFootZdown;
        end
    end
end

%}

% 找到身体需要靠近的那条线上的离散点（取10个）
pointsNumber = 10;
bodyMoveX1 = BODY_FOR_CALU.Body(lineForFoot(1),:,:) - BODY_FOR_CALU.Body(5,:,:);
bodyMoveX2 = BODY_FOR_CALU.Body(lineForFoot(2),:,:) - BODY_FOR_CALU.Body(5,:,:);
bodyMoveY1 = BODY_FOR_CALU.Body(lineForFoot(1)+5,:,:) - BODY_FOR_CALU.Body(10,:,:);
bodyMoveY2 = BODY_FOR_CALU.Body(lineForFoot(2)+5,:,:) - BODY_FOR_CALU.Body(10,:,:);
disX = (bodyMoveX2 - bodyMoveX1) / (pointsNumber-1); % 中间取8个点，加上首位，共10个点
disY = (bodyMoveY2 - bodyMoveY1) / (pointsNumber-1);
bodyMoveX = repmat(bodyMoveX1,[pointsNumber 1 1]);
bodyMoveY = repmat(bodyMoveX1,[pointsNumber 1 1]);
% bodyMoveX/Y是10*380*380的矩阵，每一层对应这个位置上的一对(x,y)
% 判断脚向后移动这个x/y后，是否在工作空间内
for i = 1:pointsNumber
    bodyMoveX(i,:,:) = bodyMoveX1 + (i-1) * disX;
    bodyMoveY(i,:,:) = bodyMoveY1 + (i-1) * disY;
end

NotDeadLock = false(1,size(map_x,1),size(map_x,2));
for i = vectorForFoot % 循环三只脚
    for j = 1:pointsNumber % 循环10个点
        mapx3d = BODY_FOR_CALU.Leg(i).map_x;
        mapy3d = BODY_FOR_CALU.Leg(i).map_y;
        mapx3d(isnan(BODY_FOR_CALU.Leg(i).zBoundry_down)) = nan;
        mapy3d(isnan(BODY_FOR_CALU.Leg(i).zBoundry_down)) = nan;
        % mapx3d是第i只脚的mapx/y
        % 对于10*380*380的矩阵来说，每一个元素对应的都一样
        cellMapx3d{1,1,1} = mapx3d;
        cellMapy3d{1,1,1} = mapy3d;
        cellMapx3d = repmat(cellMapx3d,[1,size(bodyMoveX,2),size(bodyMoveX,3)]);
        cellMapy3d = repmat(cellMapy3d,[1,size(bodyMoveY,2),size(bodyMoveY,3)]);
        % 10*380*380的cell中，每一项都与矩阵对应项相加
        cellMapx3d = cellfun(@cellAddMat, cellMapx3d, num2cell(bodyMoveX(j,:,:)),'UniformOutput',false);
        cellMapy3d = cellfun(@cellAddMat, cellMapy3d, num2cell(bodyMoveY(j,:,:)),'UniformOutput',false);
        % 只要这一个cell中有(0,0)这个点，则认为该腿在工作空间内
        % 只要10层内有任意一个1，则认为是true
        bitEachPoint = cellfun(@cellLeginWorkspace, b, c,'UniformOutput',false);
        bitEachPoint = cell2mat(bitEachPoint);
        NotDeadLock = bitEachPoint(1,:,:) | NotDeadLock;
    end
%     
%     mapx3d = permute(reshape(mapx3d,[1 size(mapx3d)]),[1 3 2]);
%     mapy3d = permute(reshape(mapy3d,[1 size(mapy3d)]),[1 3 2]);
%     
%     mapx3d = repmat(mapx3d,[pointsNumber,1,1]) + bodyMoveX;
%     mapy3d = repmat(mapy3d,[pointsNumber,1,1]) + bodyMoveY;
%     
%     % 若找到x/y均为0的那个点，说明该腿仍在工作空间内
%     mapxy3d = abs(mapx3d) <= BODY_FOR_CALU.Inteval/2 & abs(mapy3d) <= BODY_FOR_CALU.Inteval/2;
%     for j = 2:pointsNumber % 循环10个点
%         NotDeadLock = bitEachPoint(1,:,:) | NotDeadLock;
%     end
end
NotDeadLock = reshape(permute(NotDeadLock,[1,3,2]),size(map_x)); % 将PosG转成二维

% interSpace = reshape(BODY_FOR_CALU.interSpace, [1 1 8]);
% interSpace = repmat(interSpace,[size(map_z) 1]);
% interSpace(:,:,footReadytoMove) = interSpace(:,:,footReadytoMove) + map_x;
% interSpace(:,:,footReadytoMove+4) = interSpace(:,:,footReadytoMove+4) + map_y;
% % 现在只是找x的最小值(应该是找前进方向的最小值)，判断下一步走谁
% mapIndex = zeros(size(map_z));
% [row,column] = size(map_z);
% for j = 1:row
%     b = reshape(interSpace(1,:,1:4),[column,4]);
%     [~,index] = min(b,[],2);
%     mapIndex(j,:) = index';
% end
% % [~,index] = min(interSpace(:,:,1:4));
% 
% [~,index] = min(BODY_FOR_CALU.interSpace(:,1));
% Next(index == 1) = "A"; Next(index == 2) = "B";
% Next(index == 3) = "C"; Next(index == 4) = "D";
% NotDeadLock = ~contains(PosG,Next) & PosG ~= "";

ReachablePos = ReachablePos & NotDeadLock;
%}
%% 在地图上，根据判断函数选择最合适的点
% % 两个函数的权重
% omiga1 = 1; omiga2 = 1; omiga3 = 2;
% % costDotProduct：前进方向向量(1,tan(alpha))与落足点向量的点积最大（最接近stride）
% costDotProduct = getMapLegDot(map_x, map_y, alpha);
% costDeltaY = (-1)*abs(map_y);
% costStride = (-1)*sqrt((map_x - stride(1)).^2 + map_y.^2); % 与(stride,0)的距离
% costMap = omiga1 * costDotProduct + omiga2 * costDeltaY + omiga3 * costStride;
% costMap(~ReachablePos) = nan;
% IdealPos = costMap == max(costMap(:)); 

% % 两个函数的权重
% omiga1 = 1; omiga2 = 1; omiga3 = 2;
% % costDotProduct：前进方向向量(1,tan(alpha))与落足点向量的点积最大（最接近stride）
% costDotProduct = (-1)*abs(getMapLegDot(map_x, map_y, alpha) - BODY_FOR_CALU.stride);
% costDeltaY = (-1)*abs(map_y);
% % costStride = (-1)*sqrt((map_x - BODY_FOR_CALU.stride(1)).^2 + map_y.^2); % 与(stride,0)的距离
% costMap = omiga1 * costDotProduct + omiga2 * costDeltaY;
% costMap(~ReachablePos) = nan;
% map_x(~ReachablePos)=nan; map_y(~ReachablePos)=nan;
% IdealPos = costMap == max(costMap(:)); 

% 最接近点(stride,0)的
map_cost = sqrt((map_x - BODY_FOR_CALU.stride*cos(alpha)).^2 + (map_y - BODY_FOR_CALU.stride*sin(alpha)).^2);
map_cost(~ReachablePos | map_x<0) = nan;
IdealPos = map_cost == min(min(map_cost)); 

% % 两个函数的权重
% omiga1 = 1; omiga2 = 4000;
% % costDotProduct：前进方向向量(1,tan(alpha))与落足点向量的点积最大（最接近stride）
% costDotProduct = (-1)*abs(getMapLegDot(map_x, map_y, alpha) - BODY_FOR_CALU.stride);
% costDeltaAngle = (-1)*abs(atan2(map_y,map_x) - alpha);
% costMap = omiga1 * costDotProduct + omiga2 * costDeltaAngle;
% costMap(~ReachablePos) = nan;
% IdealPos = costMap == max(costMap(:)); 

% pos：查找IdealPos中1的位置
% 如果有两个以上，只取第一个
pos = find(IdealPos == 1);
if length(pos) > 1
    for i = 2:length(pos)
        IdealPos(pos(i)) = false;
    end
end
if isempty(pos)
    % 如果找不到1，说明找不到合适的点，自锁
    error('DeadLock in lifting next foot.');
end
% StepForBody就是这一次迈脚该迈的步长
StepForLeg(1) = map_x(IdealPos); StepForLeg(2) = map_y(IdealPos); StepForLeg(3) = map_z(IdealPos);
StepForLeg(1) = RoundDis(BODY_FOR_CALU.Inteval, StepForLeg(1));
StepForLeg(2) = RoundDis(BODY_FOR_CALU.Inteval, StepForLeg(2));
end