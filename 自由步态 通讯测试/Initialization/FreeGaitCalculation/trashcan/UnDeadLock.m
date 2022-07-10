% UnDeadLock：如果预判到下一步自锁，则改变这一步的落脚点，保证下一步身体有可行域
% 输入：BODY_FOR_CALU（身体）, LockedFoot（这一步原本要迈的腿）, Gap（障碍物）
% 输出：StepForBody（下一步身体步长），unlockedFootNum（为了解锁而抬起的腿）

function [StepForBody,unlockedFootNum] = UnDeadLock(BODY_FOR_CALU, lockedFootNum, Gap)
BODY_FOR_CALU0 = BODY_FOR_CALU;
COG_Pos = grad_comparation(BODY_FOR_CALU); % 现在重心点的位置

% 列出表格
% 四列分别是：case number / COG / LockedFoot / UnlockedFoot / 身体试图偏离的方向
table = cell(21,4); 
table(:,1) = num2cell([1:21]');
table(:,2) = {'OCD','OCD','OBC','OBC','OAB','OAB','OAD','OAD',...
    'OABC','OABC','OBCD','OBCD','OACD','OACD','OABD','OABD',...
    'OABC','OBCD','OACD','OABD','OABCD'};
table(:,3) = num2cell([3;4;2;3; 1;2;1;4; 1;3;2;4; 1;3;2;4; 2;3;4;1; 5]);
table(:,4) = num2cell([2;1;1;4; 4;3;2;3; 4;4;1;1; 2;2;3;3; 4;1;2;3; 5]);
table(:,5) = {[1 -1];[1 1];[-1 -1];[1 -1]; [-1 1];[-1 -1];[-1 1];[1 1]; ...
    [-1 1];[1 -1];[-1 -1];[1 1]; [-1 1];[1 -1];[-1 -1];[1 1]; nan;nan;nan;nan; nan};

% 根据现在位置和自锁脚，判断哪一个是解锁脚
caseNumber = find(strcmp(table(:,2), COG_Pos) & cell2mat(table(:,3)) == lockedFootNum, 1);
unlockedFootNum = table{caseNumber, 4};

switch lockedFootNum
    case 1
        lockedFootCha = 'A';
    case 2
        lockedFootCha = 'B';
    case 3
        lockedFootCha = 'C';
    case 4
        lockedFootCha = 'D';
end

% 若无法直接解锁，让身体先向右上角移动，移动到也许能够解锁的位置
SequenceX = BODY_FOR_CALU.Leg().map_x(1,:); 
SequenceY = BODY_FOR_CALU.Leg().map_y(:,1);
SequenceX = [linspace(0,min(BODY_FOR_CALU.WorkSpaceRadius(:,1)),100); linspace(0,-min(BODY_FOR_CALU.WorkSpaceRadius(:,2)),100)];
SequenceY = [linspace(0,min(BODY_FOR_CALU.WorkSpaceRadius(:,3)),100); linspace(0,-min(BODY_FOR_CALU.WorkSpaceRadius(:,4)),100)];
SequenceX = reshape(SequenceX,[1,200]); SequenceY = reshape(SequenceY,[1,200]);
for Body_Move_X = SequenceX 
    for Body_Move_Y = SequenceY       
        if case_number <= 16
            break
        else
            BODY_FOR_CALU = BODY_FOR_CALU0;
            [COG_Pos,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,5,Body_Move_X,Body_Move_Y,0);
            BODY_FOR_CALU.WorkSpaceRadius(1:4,1) = BODY_FOR_CALU.WorkSpaceRadius(1:4,1) - Body_Move_X;
            BODY_FOR_CALU.WorkSpaceRadius(1:4,2) = BODY_FOR_CALU.WorkSpaceRadius(1:4,2) + Body_Move_X;
            BODY_FOR_CALU.WorkSpaceRadius(1:4,3) = BODY_FOR_CALU.WorkSpaceRadius(1:4,3) - Body_Move_Y;
            BODY_FOR_CALU.WorkSpaceRadius(1:4,4) = BODY_FOR_CALU.WorkSpaceRadius(1:4,4) + Body_Move_Y;
        end
    end
    if case_number <= 16
        break
    end
end

if case_number > 16
    error('Unlock failed');
end

% 取未自锁这条腿的工作空间
BODY_FOR_CALU.len_x = length(BODY_FOR_CALU.Leg(unlockedFootNum).map_x(1,:));
BODY_FOR_CALU.len_y = length(BODY_FOR_CALU.Leg(unlockedFootNum).map_y(:,1)); 
map_x = BODY_FOR_CALU.Leg(unlockedFootNum).map_x;
map_y = BODY_FOR_CALU.Leg(unlockedFootNum).map_y;
% 对map_z赋值
map_z = getHeight(Gap, BODY_FOR_CALU, unlockedFootNum, map_x, map_y);
map_z = map_z - BODY_FOR_CALU.Body(unlockedFootNum+10); % map_z减去现在这只脚的高度，求相对值

% 计算障碍物在地图上的位置
if Gap(1).RectangleLengthWidth == [0 0]
    % 没有gap
    Bit_Foot = ones(BODY_FOR_CALU.len_y,BODY_FOR_CALU.len_x);
else
    Bit_Foot = if_InRectangle(BODY_FOR_CALU, unlockedFootNum, map_z);
    % Bit矩阵表示了3-D矩阵（地图）中哪些位置可以走，哪些不能走
end

if ~find(Bit_Foot, 1)
    % 如果找不到1，说明下一步的范围内全是gap
    error('No reachable position is in next foot area.');
end

% % 根据腿长条件确定哪些可以走，哪些不能走
% % 腿长条件应该可以不需要，因为在工作空间内一定满足腿长条件
% leg_x = BODY_FOR_CALU.Body(unlockedFootNum) + map_x - BODY_FOR_CALU.Body(unlockedFootNum+10);
% leg_y = BODY_FOR_CALU.Body(unlockedFootNum+5) + map_y - BODY_FOR_CALU.Body(unlockedFootNum+14);
% Bit_Leg = ones(BODY_FOR_CALU.len_y,BODY_FOR_CALU.len_x);
% Bit_Leg(sqrt(leg_x.^2 + leg_y.^2) >= BODY_FOR_CALU.LegMax(unlockedFootNum)) = 0;
% 
% % 满足障碍物和腿长条件的就是可达点
% ReachablePos = Bit_Foot .* Bit_Leg == 1;
% % ReachablePos：可以到达的点

ReachablePos = Bit_Foot == 1;

%{
% 根据地图，判断是否地图上的点是否可达
[BODY_FOR_CALU, ReachablePos, map] = getReachPosforFoot(BODY_FOR_CALU, footReadytoMove, Gap);
map_x = map(:,:,1);
map_y = map(:,:,2);
%}
[rows, columns] = size(ReachablePos);
ReachablePos = reshape(ReachablePos,[1 columns rows]);
% stepX stepY是3-D矩阵，目的是方便IfMove移动计算
% 若stepX stepY是移动距离，对没有自锁的那条腿进行移动，试图找到不自锁的解
stepX = reshape(map_x,[1 columns rows]);
stepY = reshape(map_y,[1 columns rows]);
BODY_FOR_CALU.Body = repmat(BODY_FOR_CALU.Body,1,BODY_FOR_CALU.len_x,BODY_FOR_CALU.len_y);
stepZ = getHeight(Gap, BODY_FOR_CALU, unlockedFootNum, map_x, map_y);
stepZ = stepZ - BODY_FOR_CALU.Body(unlockedFootNum+10); % map_z减去现在这只脚的高度，求相对值
stepZ = reshape(stepZ,[1 columns rows]);
[~,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,unlockedFootNum,stepX,stepY,stepZ);

% 设一个workspace的变量，内容是把4*6的矩阵拉成一列，并方便扩展成3-D矩阵
workspace = reshape(BODY_FOR_CALU.WorkSpaceRadius,24,1);
workspace = repmat(workspace,1,columns,rows);
workspace(unlockedFootNum,:,:) = workspace(unlockedFootNum,:,:) + stepX; % a
workspace(unlockedFootNum+4,:,:) = workspace(unlockedFootNum+4,:,:) - stepX; % b
workspace(unlockedFootNum+8,:,:) = workspace(unlockedFootNum+8,:,:) + stepY; % c
workspace(unlockedFootNum+12,:,:) = workspace(unlockedFootNum+12,:,:) - stepY; % d
workspace(unlockedFootNum+16,:,:) = workspace(unlockedFootNum+16,:,:) + stepZ; % c
workspace(unlockedFootNum+20,:,:) = workspace(unlockedFootNum+20,:,:) - stepZ; % d

% 需要知道现在身体最多可以走多少
max_x_body = min(workspace(1:4,:,:));
min_x_body = min(workspace(5:8,:,:));
max_y_body = min(workspace(9:12,:,:));
min_y_body = min(workspace(13:16,:,:));
% 在下面代入时，min必须带负号

% 判断下一步身体尽量移动到什么位置
if case_number == 1 || case_number == 4 || case_number == 10 || case_number == 14
    next_body_x = max_x_body; next_body_y = -min_y_body; % 脚尽量向左上走（身体向右下）
elseif case_number == 2 || case_number == 8 || case_number == 12 || case_number == 16
    next_body_x = max_x_body; next_body_y = max_y_body; % 脚尽量向左下走（身体向右上）
elseif case_number == 3 || case_number == 6 || case_number == 11 || case_number == 15
    next_body_x = -min_x_body; next_body_y = -min_y_body; % 脚尽量向右上走（身体向左下）
elseif case_number == 5 || case_number == 7 || case_number == 9 || case_number == 13
    next_body_x = -min_x_body; next_body_y = max_y_body; % 脚尽量向右下走（身体向左上）
end

[PosG,~] = IfMove(BODY_FOR_CALU, 5, next_body_x, next_body_y, 0); % 如果移动了身体，计算现在重心点会在哪个三角形内
ReachablePos = ~contains(PosG,lockedFootCha) & ReachablePos; % 有1，就说明有解

if isempty(find(ReachablePos == 1,1)) % 如果找不到1，说明下一步自锁，无解
    error('Unlock failed');
else
    % 如果有1，说明有解，解锁成功
    % 找到尽可能向前走的那个值
    % flag = false;
    disp('Successfully unlocked.');

    cost_fx = abs(stepY);
    cost_fx(~ReachablePos) = nan; % 不能走的情况设为0
    % 找到成本最小的那种情况。
    IdealPos = find(cost_fx == min(cost_fx(cost_fx(:)>=0)));
    % 在成本最小的这些情况中，选择map_x最大的那种
    IdealPos = IdealPos(stepX(IdealPos) == max(stepX(IdealPos)));

    StepForBody(1) = stepX(IdealPos); StepForBody(2) = stepY(IdealPos); StepForBody(3) = stepZ(IdealPos);
     % 如果没有合适的迈腿（case>16），身体需要先挪一挪；
     % 前3是动脚，后6是身体。如果不动身体，这个4:9不用管
    StepForBody(4) = Body_Move_X; StepForBody(5) = Body_Move_Y; StepForBody(6:9) = 0;
end
