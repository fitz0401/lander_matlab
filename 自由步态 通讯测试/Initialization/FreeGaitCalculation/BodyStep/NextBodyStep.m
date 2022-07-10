% NextBody_FreeGait���������������ݵ����ж�������һ�������١���һ�����ĸ���
% ���룺BODY_FOR_CALU��Ŀǰ���壩, End_Pos��Ŀ���λ�ã���LastFoot_index������һ������������һ��ָ��������ţ������������޴����룩
% �����StepForBody����һ���Ĳ��� 1*2 double��, NextFoot_index����һ�����Ľţ�1*1 double����DeadLock���Ƿ�������־��

function [StepForBody, Foot_index, DeadLock, TargetReach] = NextBodyStep(BODY_FOR_CALU, End_Pos, Foot_index, alpha, FlagDeadLock)
DeadLock = false; TargetReach = false;
bodytemp = BODY_FOR_CALU;
%% ��һ����ͨ���ĸ���˵���ϳ���ƽ�棬�ҵ�����Ӧ��ת��������ת��
% % �ĸ��㣬����x/y/z����������
% x = BODY_FOR_CALU.Body(1:4) + BODY_FOR_CALU.IdealLegLength(:,1);
% y = BODY_FOR_CALU.Body(6:9) + BODY_FOR_CALU.IdealLegLength(:,2);
% z = BODY_FOR_CALU.Body(11:14) + BODY_FOR_CALU.IdealLegLength(:,3);
% % ��Ҫ��ϵĵ㣬�Ƿֱ����ĸ���˵�Ϊ���ģ�������ĸ����嶥��
% % ���ĸ������ƽ�棬�����������Ӧ���ߵĸ߶Ⱥ�����ת��
% StepForBody = FitPlane(BODY_FOR_CALU,x,y,z);
% % StepForBody = zeros(1,6);

% �ĸ��㣬����x/y/z����������
x = BODY_FOR_CALU.Body(1:4);
y = BODY_FOR_CALU.Body(6:9);
z = BODY_FOR_CALU.Body(11:14);
% ��Ҫ��ϵĵ㣬�Ƿֱ����ĸ���˵�Ϊ���ģ�������ĸ����嶥��
% ���ĸ������ƽ�棬�����������Ӧ���ߵĸ߶Ⱥ�����ת��
StepForBody = FitPlane(BODY_FOR_CALU,x,y,z);

%% �ڶ����������ȶ�ԣ���ҵ�������
% �ҵ���һ��Ҫ������
if ~FlagDeadLock % ������
%     [~,Foot_index] = min(BODY_FOR_CALU.interSpace(:,1));
    Foot_index = MinFootInterSpace(BODY_FOR_CALU.interSpace, Foot_index, alpha);
    % ������Ȼ����һ����index
end
% ������һ�������ȣ�ȷ������Ŀ�����
% ������Ҳ����ƽ�����ȵľֲ�����ϵ�������µ�����ϵ
[BODY_FOR_CALU, Bit_BodyStableArea, Bit_ReachableArea, map] = getReachPosforBody(BODY_FOR_CALU, Foot_index, StepForBody);
map_x = map(1,:,:);
map_y = map(2,:,:);
% map_z = map(3,:,:);

if isempty(find(Bit_BodyStableArea == 1,1)) % ����Ҳ���1��˵����һ���������޽�
    warning('DeadLock in choosing next leg.');
    StepForBody(1:3) = [0 0 0];
    DeadLock = true;
    return
end

% Bit_TargetReach �ж��Ƿ���һ�����Ե����յ�
Bit_TargetReach =  sqrt((End_Pos(1)-BODY_FOR_CALU.Body(5,:,:)).^2 + (End_Pos(2)-BODY_FOR_CALU.Body(10,:,:)).^2) <= BODY_FOR_CALU.Inteval;
Bit_TargetReach(Bit_ReachableArea == false) = false;
if find(Bit_TargetReach, 1)
    StepForBody(1:3) = [End_Pos(1)-bodytemp.Body(5) End_Pos(2)-bodytemp.Body(10) 0];
    TargetReach = true;
    return
end

%% �������������ȶ�ԣ�Ⱥ;��빤���ռ������λ�ã��ҵ����Ž�
% �������ľ�������ľ��룬�����׼�ԽСԽ��
% �����ȵ�����λ�þ��ǳ�ʼʱ�̵�λ�ã�����ʱ�̵�λ����֮��������ĸ���ֵ�ı�׼��
stanDevi(1,:,:) = sqrt((BODY_FOR_CALU.Body(1,:,:) - BODY_FOR_CALU.Body(5,:,:)).^2 + (BODY_FOR_CALU.Body(6,:,:) - BODY_FOR_CALU.Body(10,:,:)).^2);
stanDevi(2,:,:) = sqrt((BODY_FOR_CALU.Body(2,:,:) - BODY_FOR_CALU.Body(5,:,:)).^2 + (BODY_FOR_CALU.Body(7,:,:) - BODY_FOR_CALU.Body(10,:,:)).^2);
stanDevi(3,:,:) = sqrt((BODY_FOR_CALU.Body(3,:,:) - BODY_FOR_CALU.Body(5,:,:)).^2 + (BODY_FOR_CALU.Body(8,:,:) - BODY_FOR_CALU.Body(10,:,:)).^2);
stanDevi(4,:,:) = sqrt((BODY_FOR_CALU.Body(4,:,:) - BODY_FOR_CALU.Body(5,:,:)).^2 + (BODY_FOR_CALU.Body(9,:,:) - BODY_FOR_CALU.Body(10,:,:)).^2);
cost_stdx = std(stanDevi,1,1);

% ����z�����ƶ�����
% cost_fz = map_z;

% ����Ҫ�������ͼ��ÿһ����ƶ��ɱ�
% �����ƶ����뾡����С
cost_fx = sqrt((BODY_FOR_CALU.Body(32,:,:) - bodytemp.Body(32,:,:)).^2 + (BODY_FOR_CALU.Body(37,:,:) - bodytemp.Body(37,:,:)).^2);
cost_fx = cost_fx / max(max(cost_fx)) + cost_stdx / max(max(cost_stdx));
cost_fx(~Bit_BodyStableArea) = nan; % �����ߵ������Ϊnan
% cost_fx(map_x == 0 & map_y == 0) = nan;
% �ҵ��ɱ���С�����������
IdealPos = cost_fx == min(min(cost_fx));
% pos������IdealPos��1��λ��
% ������������ϣ�ֻȡ��һ��
pos = find(IdealPos == 1);
if length(pos) > 1
    for i = 2:length(pos)
        IdealPos(pos(i)) = false;
    end
end

% % ����Ҫ�������ͼ��ÿһ����ƶ��ɱ�
% % ȡy����Ϊ0
% % cost_fx = sqrt((BODY_FOR_CALU.Body(5,:,:) - End_Pos(1)).^2 + (BODY_FOR_CALU.Body(10,:,:) - End_Pos(2)).^2);
% cost_fx = sqrt((BODY_FOR_CALU.Body(32,:,:) - End_Pos(1)).^2 + (BODY_FOR_CALU.Body(37,:,:) - End_Pos(2)).^2) ...
%     + 1.0*sqrt((BODY_FOR_CALU.Body(32,:,:) - BODY_FOR_CALU.Body0(32,:,:)).^2 + (BODY_FOR_CALU.Body(37,:,:) - BODY_FOR_CALU.Body0(37,:,:)).^2);
% cost_fx(~Bit_NextFoot) = nan; % �����ߵ������Ϊnan
% cost_fx(map_x == 0 & map_y == 0) = nan;
% % �ҵ��ɱ���С�����������
% IdealPos = find(cost_fx == min(cost_fx(cost_fx(:)>=0)));
% % �ڳɱ���С����Щ����У�ѡ��map_x��С������
% IdealPos = IdealPos(map_x(IdealPos) == min(map_x(IdealPos)));
% IdealPos = IdealPos(1);

StepForBody(1) = map_x(IdealPos); StepForBody(2) = map_y(IdealPos); 
StepForBody(1) = RoundDis(BODY_FOR_CALU.Inteval, StepForBody(1));
StepForBody(2) = RoundDis(BODY_FOR_CALU.Inteval, StepForBody(2));
end