% MoveUpdateShow：Move身体 & Update工作空间 & Show
% 输入：Foot_index（走哪一步 double）, Step（走的步长 1*2 double）

function BODY_FOR_CALU = Simulate_MoveShow(BODY_FOR_CALU, Foot_index, Step)

% BODY_FOR_CALU = Move(BODY_FOR_CALU,Foot_index,Step); % 5 代表身体

BODY_FOR_CALU = BODY_FOR_CALU.Move(Foot_index, Step(1), Step(2));

if Foot_index == 5
    % 局部坐标系的大小相应的也要变
    BODY_FOR_CALU.WorkSpaceRadius(1:4,1) = BODY_FOR_CALU.WorkSpaceRadius(1:4,1) - Step(1);
    BODY_FOR_CALU.WorkSpaceRadius(1:4,2) = BODY_FOR_CALU.WorkSpaceRadius(1:4,2) + Step(1);
    BODY_FOR_CALU.WorkSpaceRadius(1:4,3) = BODY_FOR_CALU.WorkSpaceRadius(1:4,3) - Step(2);
    BODY_FOR_CALU.WorkSpaceRadius(1:4,4) = BODY_FOR_CALU.WorkSpaceRadius(1:4,4) + Step(2);
else % Foot_index = 1-4
    BODY_FOR_CALU.WorkSpaceRadius(Foot_index,1) = BODY_FOR_CALU.WorkSpaceRadius(Foot_index,1) + Step(1);
    BODY_FOR_CALU.WorkSpaceRadius(Foot_index,2) = BODY_FOR_CALU.WorkSpaceRadius(Foot_index,2) - Step(1);
    BODY_FOR_CALU.WorkSpaceRadius(Foot_index,3) = BODY_FOR_CALU.WorkSpaceRadius(Foot_index,3) + Step(2);
    BODY_FOR_CALU.WorkSpaceRadius(Foot_index,4) = BODY_FOR_CALU.WorkSpaceRadius(Foot_index,4) - Step(2);
end

% 相应的，四只脚在其局部坐标系中的位置要向后移（更新四脚位置）
BODY_FOR_CALU.FootLocalPos(1:4,1) = BODY_FOR_CALU.WorkSpaceRadius(1:4,1);
BODY_FOR_CALU.FootLocalPos(5:8,1) = BODY_FOR_CALU.WorkSpaceRadius(1:4,2);
BODY_FOR_CALU.FootLocalPos(9:12,1) = BODY_FOR_CALU.WorkSpaceRadius(1:4,3);
BODY_FOR_CALU.FootLocalPos(13:16,1) = BODY_FOR_CALU.WorkSpaceRadius(1:4,4);
Simulate_MoveBody(Foot_index, Step);

end