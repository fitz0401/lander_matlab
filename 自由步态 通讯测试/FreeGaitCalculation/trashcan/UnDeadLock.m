% UnDeadLock�����Ԥ�е���һ����������ı���һ������ŵ㣬��֤��һ�������п�����
% ���룺BODY_FOR_CALU�����壩, LockedFoot����һ��ԭ��Ҫ�����ȣ�, Gap���ϰ��
% �����StepForBody����һ�����岽������unlockedFootNum��Ϊ�˽�����̧����ȣ�

function [StepForBody,unlockedFootNum] = UnDeadLock(BODY_FOR_CALU, lockedFootNum, Gap)
BODY_FOR_CALU0 = BODY_FOR_CALU;
COG_Pos = grad_comparation(BODY_FOR_CALU); % �������ĵ��λ��

% �г����
% ���зֱ��ǣ�case number / COG / LockedFoot / UnlockedFoot / ������ͼƫ��ķ���
table = cell(21,4); 
table(:,1) = num2cell([1:21]');
table(:,2) = {'OCD','OCD','OBC','OBC','OAB','OAB','OAD','OAD',...
    'OABC','OABC','OBCD','OBCD','OACD','OACD','OABD','OABD',...
    'OABC','OBCD','OACD','OABD','OABCD'};
table(:,3) = num2cell([3;4;2;3; 1;2;1;4; 1;3;2;4; 1;3;2;4; 2;3;4;1; 5]);
table(:,4) = num2cell([2;1;1;4; 4;3;2;3; 4;4;1;1; 2;2;3;3; 4;1;2;3; 5]);
table(:,5) = {[1 -1];[1 1];[-1 -1];[1 -1]; [-1 1];[-1 -1];[-1 1];[1 1]; ...
    [-1 1];[1 -1];[-1 -1];[1 1]; [-1 1];[1 -1];[-1 -1];[1 1]; nan;nan;nan;nan; nan};

% ��������λ�ú������ţ��ж���һ���ǽ�����
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

% ���޷�ֱ�ӽ������������������Ͻ��ƶ����ƶ���Ҳ���ܹ�������λ��
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

% ȡδ���������ȵĹ����ռ�
BODY_FOR_CALU.len_x = length(BODY_FOR_CALU.Leg(unlockedFootNum).map_x(1,:));
BODY_FOR_CALU.len_y = length(BODY_FOR_CALU.Leg(unlockedFootNum).map_y(:,1)); 
map_x = BODY_FOR_CALU.Leg(unlockedFootNum).map_x;
map_y = BODY_FOR_CALU.Leg(unlockedFootNum).map_y;
% ��map_z��ֵ
map_z = getHeight(Gap, BODY_FOR_CALU, unlockedFootNum, map_x, map_y);
map_z = map_z - BODY_FOR_CALU.Body(unlockedFootNum+10); % map_z��ȥ������ֻ�ŵĸ߶ȣ������ֵ

% �����ϰ����ڵ�ͼ�ϵ�λ��
if Gap(1).RectangleLengthWidth == [0 0]
    % û��gap
    Bit_Foot = ones(BODY_FOR_CALU.len_y,BODY_FOR_CALU.len_x);
else
    Bit_Foot = if_InRectangle(BODY_FOR_CALU, unlockedFootNum, map_z);
    % Bit�����ʾ��3-D���󣨵�ͼ������Щλ�ÿ����ߣ���Щ������
end

if ~find(Bit_Foot, 1)
    % ����Ҳ���1��˵����һ���ķ�Χ��ȫ��gap
    error('No reachable position is in next foot area.');
end

% % �����ȳ�����ȷ����Щ�����ߣ���Щ������
% % �ȳ�����Ӧ�ÿ��Բ���Ҫ����Ϊ�ڹ����ռ���һ�������ȳ�����
% leg_x = BODY_FOR_CALU.Body(unlockedFootNum) + map_x - BODY_FOR_CALU.Body(unlockedFootNum+10);
% leg_y = BODY_FOR_CALU.Body(unlockedFootNum+5) + map_y - BODY_FOR_CALU.Body(unlockedFootNum+14);
% Bit_Leg = ones(BODY_FOR_CALU.len_y,BODY_FOR_CALU.len_x);
% Bit_Leg(sqrt(leg_x.^2 + leg_y.^2) >= BODY_FOR_CALU.LegMax(unlockedFootNum)) = 0;
% 
% % �����ϰ�����ȳ������ľ��ǿɴ��
% ReachablePos = Bit_Foot .* Bit_Leg == 1;
% % ReachablePos�����Ե���ĵ�

ReachablePos = Bit_Foot == 1;

%{
% ���ݵ�ͼ���ж��Ƿ��ͼ�ϵĵ��Ƿ�ɴ�
[BODY_FOR_CALU, ReachablePos, map] = getReachPosforFoot(BODY_FOR_CALU, footReadytoMove, Gap);
map_x = map(:,:,1);
map_y = map(:,:,2);
%}
[rows, columns] = size(ReachablePos);
ReachablePos = reshape(ReachablePos,[1 columns rows]);
% stepX stepY��3-D����Ŀ���Ƿ���IfMove�ƶ�����
% ��stepX stepY���ƶ����룬��û�������������Ƚ����ƶ�����ͼ�ҵ��������Ľ�
stepX = reshape(map_x,[1 columns rows]);
stepY = reshape(map_y,[1 columns rows]);
BODY_FOR_CALU.Body = repmat(BODY_FOR_CALU.Body,1,BODY_FOR_CALU.len_x,BODY_FOR_CALU.len_y);
stepZ = getHeight(Gap, BODY_FOR_CALU, unlockedFootNum, map_x, map_y);
stepZ = stepZ - BODY_FOR_CALU.Body(unlockedFootNum+10); % map_z��ȥ������ֻ�ŵĸ߶ȣ������ֵ
stepZ = reshape(stepZ,[1 columns rows]);
[~,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,unlockedFootNum,stepX,stepY,stepZ);

% ��һ��workspace�ı����������ǰ�4*6�ľ�������һ�У���������չ��3-D����
workspace = reshape(BODY_FOR_CALU.WorkSpaceRadius,24,1);
workspace = repmat(workspace,1,columns,rows);
workspace(unlockedFootNum,:,:) = workspace(unlockedFootNum,:,:) + stepX; % a
workspace(unlockedFootNum+4,:,:) = workspace(unlockedFootNum+4,:,:) - stepX; % b
workspace(unlockedFootNum+8,:,:) = workspace(unlockedFootNum+8,:,:) + stepY; % c
workspace(unlockedFootNum+12,:,:) = workspace(unlockedFootNum+12,:,:) - stepY; % d
workspace(unlockedFootNum+16,:,:) = workspace(unlockedFootNum+16,:,:) + stepZ; % c
workspace(unlockedFootNum+20,:,:) = workspace(unlockedFootNum+20,:,:) - stepZ; % d

% ��Ҫ֪�����������������߶���
max_x_body = min(workspace(1:4,:,:));
min_x_body = min(workspace(5:8,:,:));
max_y_body = min(workspace(9:12,:,:));
min_y_body = min(workspace(13:16,:,:));
% ���������ʱ��min���������

% �ж���һ�����御���ƶ���ʲôλ��
if case_number == 1 || case_number == 4 || case_number == 10 || case_number == 14
    next_body_x = max_x_body; next_body_y = -min_y_body; % �ž����������ߣ����������£�
elseif case_number == 2 || case_number == 8 || case_number == 12 || case_number == 16
    next_body_x = max_x_body; next_body_y = max_y_body; % �ž����������ߣ����������ϣ�
elseif case_number == 3 || case_number == 6 || case_number == 11 || case_number == 15
    next_body_x = -min_x_body; next_body_y = -min_y_body; % �ž����������ߣ����������£�
elseif case_number == 5 || case_number == 7 || case_number == 9 || case_number == 13
    next_body_x = -min_x_body; next_body_y = max_y_body; % �ž����������ߣ����������ϣ�
end

[PosG,~] = IfMove(BODY_FOR_CALU, 5, next_body_x, next_body_y, 0); % ����ƶ������壬�����������ĵ�����ĸ���������
ReachablePos = ~contains(PosG,lockedFootCha) & ReachablePos; % ��1����˵���н�

if isempty(find(ReachablePos == 1,1)) % ����Ҳ���1��˵����һ���������޽�
    error('Unlock failed');
else
    % �����1��˵���н⣬�����ɹ�
    % �ҵ���������ǰ�ߵ��Ǹ�ֵ
    % flag = false;
    disp('Successfully unlocked.');

    cost_fx = abs(stepY);
    cost_fx(~ReachablePos) = nan; % �����ߵ������Ϊ0
    % �ҵ��ɱ���С�����������
    IdealPos = find(cost_fx == min(cost_fx(cost_fx(:)>=0)));
    % �ڳɱ���С����Щ����У�ѡ��map_x��������
    IdealPos = IdealPos(stepX(IdealPos) == max(stepX(IdealPos)));

    StepForBody(1) = stepX(IdealPos); StepForBody(2) = stepY(IdealPos); StepForBody(3) = stepZ(IdealPos);
     % ���û�к��ʵ����ȣ�case>16����������Ҫ��ŲһŲ��
     % ǰ3�Ƕ��ţ���6�����塣����������壬���4:9���ù�
    StepForBody(4) = Body_Move_X; StepForBody(5) = Body_Move_Y; StepForBody(6:9) = 0;
end
