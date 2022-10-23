% ��������������5*2 double array��������в�̬���������˶�����ͼ
% �������巢��ǰ�����ҵ��ƶ���ʹ��������ɲ�̬

%Ŀǰ���������ԭ�����ڲ������������ռ䷶Χ�������������ƶ�ʱ1�ȳ��������ռ��Ե������취�����ǽ��ȳ�ʼλ�ʹ�һ�㣬�����������Ի���ľ���

clear;clc;close all
clear global
clear classes
dbstop if error
% addpath(genpath(pwd)); 
addpath(pwd); 

%% �����������ʼ��
BODY_FOR_CALU = class_BODY_CALU;
BODY_PARA = class_BODY_PARA;
BODY_FOR_CALU = InitialBodyData(BODY_FOR_CALU,BODY_PARA); % ��ʼ����������
% ����Gap����
% gap = InitialGapData('read');
% gap = InitialGapData('stair');
% gap = InitialGapData('clear');
Obstacle_Point = InitialObstacleData();
gap = InitialGapData('clear');
% ָ�������յ�  
targetArgu = [3000; 0]; % ��һ�����˶����룻�ڶ�������ԽǶȣ����ȣ�
% target ��i�У���i���յ�ľ���λ�� targetTotalNumber Ŀ���ĸ���
[target, targetTotalNumber] = InitialTargetPosition([BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10)], targetArgu); 
% ��ʼ����ͼ����
BODY_FOR_CALU=InitialSimulationData(BODY_FOR_CALU,BODY_PARA, Obstacle_Point, target);
robotBodyData = BODY_FOR_CALU.Body'; % �洢���ݣ�Ϊ����׼��
DELTA_LEG_initial=roundn(BODY_FOR_CALU.TraceData-repmat(BODY_FOR_CALU.Land_pose,1,4),-4);
%% �ȼ��㲽̬��Ȼ���˶���ͬʱ�����˶�ͼ�񣩡��������ϰ��ת��Ȼ��ѭ��
targetNumber = 1; flagDeadLock = false; stepNumber = 1; indexFoot = 0;
while(1)
    if stepNumber == 63
        robot1 = BODY_FOR_CALU;
    elseif stepNumber == 41
        robot2 = BODY_FOR_CALU;
    end
    %% �������һ������λ��
    [BodyStep, indexFoot, flagDeadLock, FlagTargetReach] = NextBodyStep(BODY_FOR_CALU, ...
        target(targetNumber,:), indexFoot, targetArgu(2,targetNumber), flagDeadLock,BODY_PARA);
%     if ~FlagTargetReach
%         BodyStep = Optimise_NextBody(BODY_FOR_CALU, targetArgu(2,NumForTarget), Foot_index, BodyStep);
%     end
    %% �������������ҵ����ʵľ��������һ�ξ���
    % ����һ�ξ���
    
    BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, 5, BodyStep ,BODY_PARA);
    % ��¼�����Ϣ
%     table{stepNumber,1} = BODY_FOR_CALU.Body;
%     table{stepNumber,2} = 5;
%     table{stepNumber,3} = BodyStep;
    stepNumber = stepNumber + 1;
    
    %% ����ִ��յ㣬������ѭ��
    if FlagTargetReach
        if targetNumber == targetTotalNumber
            disp("******************************************");  %��������Ŀ����
            disp("Final target is reached.");
            break
        else
            disp(" ");
            disp("******************************************");
            disp(['Target ',num2str(targetNumber),' is reached']); %�����targetNumber��Ŀ���
            disp(" ");
            targetNumber = targetNumber + 1;
            FlagTargetReach = false;
        end
    end
    
    %% �����ȳ������������ж���һ���Ĳ���
    if ~flagDeadLock
        % �����������������һ�����������
        FootStep = NextFootStep(BODY_FOR_CALU, indexFoot, Obstacle_Point, targetArgu(2,targetNumber));
    else
        % �����������ȵ����ŵ�λ�ã�Ȼ�������һ��ѭ�������¼��������ƶ�����
%         error("Deadlock!");
        disp('Deadlock!');
        indexFoot
        continue
%         [FootStep, Foot_index] = UnDeadLock(BODY_FOR_CALU, Foot_index, Gap);
    end
    
    %% �ҵ����ʵľ��������һ�ξ���
    if flagDeadLock && FootStep(4) ~= 0 && FootStep(5) ~= 0
        % ������������������ܻ���������ƶ�������������壬���߽�
        BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, 5, FootStep(4:9),BODY_PARA);
        % ��¼�����Ϣ
        stepNumber = stepNumber + 1;
    end
    %�ȵ��˶�
    BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, indexFoot, FootStep(1:3),BODY_PARA);
    % ��¼�����Ϣ
    stepNumber = stepNumber + 1;
    Leg_Point=roundn(BODY_FOR_CALU.TraceData(20*(stepNumber-3)+1:20*(stepNumber-1),:),-4);
end
%% ����table����
% load('table.mat');
% table = table';
% global ReLML
% close(ReLML);

