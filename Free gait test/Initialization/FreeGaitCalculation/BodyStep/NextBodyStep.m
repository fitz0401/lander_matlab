% NextBody_FreeGait：计算迈步。根据地形判断身体这一步迈多少、下一步迈哪个脚
% 输入：BODY_FOR_CALU（目前身体）, End_Pos（目标点位置）。LastFoot_index（若上一步自锁，则这一步指定迈这个脚，若不自锁，无此输入）
% 输出：StepForBody（这一步的步长 1*2 double）, NextFoot_index（下一步迈的脚，1*1 double），DeadLock（是否自锁标志）

function [StepForBody, Foot_index, DeadLock, TargetReach] = NextBodyStep(BODY_FOR_CALU, End_Pos, Foot_index, alpha, FlagDeadLock)
DeadLock = false; TargetReach = false;
bodytemp = BODY_FOR_CALU;
%% 第一步，通过四个足端点拟合出的平面，找到身体应当转动的三个转角
% % 四个点，坐标x/y/z都是列向量
% x = BODY_FOR_CALU.Body(1:4) + BODY_FOR_CALU.IdealLegLength(:,1);
% y = BODY_FOR_CALU.Body(6:9) + BODY_FOR_CALU.IdealLegLength(:,2);
% z = BODY_FOR_CALU.Body(11:14) + BODY_FOR_CALU.IdealLegLength(:,3);
% % 需要拟合的点，是分别以四个足端点为中心，理想的四个身体顶点
% % 用四个点拟合平面，并计算出身体应该走的高度和三个转角
% StepForBody = FitPlane(BODY_FOR_CALU,x,y,z);
% % StepForBody = zeros(1,6);

% 四个点，坐标x/y/z都是列向量
x = BODY_FOR_CALU.Body(1:4);
y = BODY_FOR_CALU.Body(6:9);
z = BODY_FOR_CALU.Body(11:14);
% 需要拟合的点，是分别以四个足端点为中心，理想的四个身体顶点
% 用四个点拟合平面，并计算出身体应该走的高度和三个转角
StepForBody = FitPlane(BODY_FOR_CALU,x,y,z);

%% 第二步，根据稳定裕度找到可行域
% 找到下一步要迈的腿
if ~FlagDeadLock % 不自锁
%     [~,Foot_index] = min(BODY_FOR_CALU.interSpace(:,1));
    Foot_index = MinFootInterSpace(BODY_FOR_CALU.interSpace, Foot_index, alpha);
    % 否则，仍然是上一步的index
end
% 根据下一步迈的腿，确定身体的可行域
% 可行域也是在平行于腿的局部坐标系的身体下的坐标系
[BODY_FOR_CALU, Bit_BodyStableArea, Bit_ReachableArea, map] = getReachPosforBody(BODY_FOR_CALU, Foot_index, StepForBody);
map_x = map(1,:,:);
map_y = map(2,:,:);
% map_z = map(3,:,:);

if isempty(find(Bit_BodyStableArea == 1,1)) % 如果找不到1，说明下一步自锁，无解
    warning('DeadLock in choosing next leg.');
    StepForBody(1:3) = [0 0 0];
    DeadLock = true;
    return
end

% Bit_TargetReach 判断是否下一步可以到达终点
Bit_TargetReach =  sqrt((End_Pos(1)-BODY_FOR_CALU.Body(5,:,:)).^2 + (End_Pos(2)-BODY_FOR_CALU.Body(10,:,:)).^2) <= BODY_FOR_CALU.Inteval;
Bit_TargetReach(Bit_ReachableArea == false) = false;
if find(Bit_TargetReach, 1)
    StepForBody(1:3) = [End_Pos(1)-bodytemp.Body(5) End_Pos(2)-bodytemp.Body(10) 0];
    TargetReach = true;
    return
end

%% 第三步，根据稳定裕度和距离工作空间的最优位置，找到最优解
% 身体中心距离四足的距离，方差（标准差）越小越好
% 各个腿的理想位置就是初始时刻的位置，现在时刻的位置与之相减，求四个差值的标准差
stanDevi(1,:,:) = sqrt((BODY_FOR_CALU.Body(1,:,:) - BODY_FOR_CALU.Body(5,:,:)).^2 + (BODY_FOR_CALU.Body(6,:,:) - BODY_FOR_CALU.Body(10,:,:)).^2);
stanDevi(2,:,:) = sqrt((BODY_FOR_CALU.Body(2,:,:) - BODY_FOR_CALU.Body(5,:,:)).^2 + (BODY_FOR_CALU.Body(7,:,:) - BODY_FOR_CALU.Body(10,:,:)).^2);
stanDevi(3,:,:) = sqrt((BODY_FOR_CALU.Body(3,:,:) - BODY_FOR_CALU.Body(5,:,:)).^2 + (BODY_FOR_CALU.Body(8,:,:) - BODY_FOR_CALU.Body(10,:,:)).^2);
stanDevi(4,:,:) = sqrt((BODY_FOR_CALU.Body(4,:,:) - BODY_FOR_CALU.Body(5,:,:)).^2 + (BODY_FOR_CALU.Body(9,:,:) - BODY_FOR_CALU.Body(10,:,:)).^2);
cost_stdx = std(stanDevi,1,1);

% 计算z方向移动距离
% cost_fz = map_z;

% 下面要计算出地图上每一格的移动成本
% 身体移动距离尽可能小
cost_fx = sqrt((BODY_FOR_CALU.Body(32,:,:) - bodytemp.Body(32,:,:)).^2 + (BODY_FOR_CALU.Body(37,:,:) - bodytemp.Body(37,:,:)).^2);
cost_fx = cost_fx / max(max(cost_fx)) + cost_stdx / max(max(cost_stdx));
cost_fx(~Bit_BodyStableArea) = nan; % 不能走的情况设为nan
% cost_fx(map_x == 0 & map_y == 0) = nan;
% 找到成本最小的那种情况。
IdealPos = cost_fx == min(min(cost_fx));
% pos：查找IdealPos中1的位置
% 如果有两个以上，只取第一个
pos = find(IdealPos == 1);
if length(pos) > 1
    for i = 2:length(pos)
        IdealPos(pos(i)) = false;
    end
end

% % 下面要计算出地图上每一格的移动成本
% % 取y尽量为0
% % cost_fx = sqrt((BODY_FOR_CALU.Body(5,:,:) - End_Pos(1)).^2 + (BODY_FOR_CALU.Body(10,:,:) - End_Pos(2)).^2);
% cost_fx = sqrt((BODY_FOR_CALU.Body(32,:,:) - End_Pos(1)).^2 + (BODY_FOR_CALU.Body(37,:,:) - End_Pos(2)).^2) ...
%     + 1.0*sqrt((BODY_FOR_CALU.Body(32,:,:) - BODY_FOR_CALU.Body0(32,:,:)).^2 + (BODY_FOR_CALU.Body(37,:,:) - BODY_FOR_CALU.Body0(37,:,:)).^2);
% cost_fx(~Bit_NextFoot) = nan; % 不能走的情况设为nan
% cost_fx(map_x == 0 & map_y == 0) = nan;
% % 找到成本最小的那种情况。
% IdealPos = find(cost_fx == min(cost_fx(cost_fx(:)>=0)));
% % 在成本最小的这些情况中，选择map_x最小的那种
% IdealPos = IdealPos(map_x(IdealPos) == min(map_x(IdealPos)));
% IdealPos = IdealPos(1);

StepForBody(1) = map_x(IdealPos); StepForBody(2) = map_y(IdealPos); 
StepForBody(1) = RoundDis(BODY_FOR_CALU.Inteval, StepForBody(1));
StepForBody(2) = RoundDis(BODY_FOR_CALU.Inteval, StepForBody(2));
end