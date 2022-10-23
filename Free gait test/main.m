% 输入五个点的坐标5*2 double array，计算可行步态，并画出运动过程图
% 允许身体发生前后左右的移动，使其完成自由步态

%目前问题产生的原因不在于步伐超过工作空间范围，而在于身体移动时1腿超过工作空间边缘，解决办法，考虑将腿初始位型打开一点，即增加足端相对机身的距离

clear;clc;close all
clear global
clear classes
dbstop if error
% addpath(genpath(pwd)); 
addpath(pwd); 

%% 输入参数并初始化
BODY_FOR_CALU = class_BODY_CALU;
BODY_PARA = class_BODY_PARA;
BODY_FOR_CALU = InitialBodyData(BODY_FOR_CALU,BODY_PARA); % 初始化身体数据
% 生成Gap数据
% gap = InitialGapData('read');
% gap = InitialGapData('stair');
% gap = InitialGapData('clear');
Obstacle_Point = InitialObstacleData();
gap = InitialGapData('clear');
% 指定若干终点  
targetArgu = [3000; 0]; % 第一行是运动距离；第二行是相对角度（弧度）
% target 第i行，第i个终点的绝对位置 targetTotalNumber 目标点的个数
[target, targetTotalNumber] = InitialTargetPosition([BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10)], targetArgu); 
% 初始化画图窗口
BODY_FOR_CALU=InitialSimulationData(BODY_FOR_CALU,BODY_PARA, Obstacle_Point, target);
robotBodyData = BODY_FOR_CALU.Body'; % 存储数据，为后处理准备
DELTA_LEG_initial=roundn(BODY_FOR_CALU.TraceData-repmat(BODY_FOR_CALU.Land_pose,1,4),-4);
%% 先计算步态，然后运动（同时生成运动图像）。若遇到障碍物，转向。然后循环
targetNumber = 1; flagDeadLock = false; stepNumber = 1; indexFoot = 0;
while(1)
    if stepNumber == 63
        robot1 = BODY_FOR_CALU;
    elseif stepNumber == 41
        robot2 = BODY_FOR_CALU;
    end
    %% 计算出下一步身体位置
    [BodyStep, indexFoot, flagDeadLock, FlagTargetReach] = NextBodyStep(BODY_FOR_CALU, ...
        target(targetNumber,:), indexFoot, targetArgu(2,targetNumber), flagDeadLock,BODY_PARA);
%     if ~FlagTargetReach
%         BodyStep = Optimise_NextBody(BODY_FOR_CALU, targetArgu(2,NumForTarget), Foot_index, BodyStep);
%     end
    %% 若不自锁，则找到合适的距离后，走这一段距离
    % 走这一段距离
    
    BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, 5, BodyStep ,BODY_PARA);
    % 记录相关信息
%     table{stepNumber,1} = BODY_FOR_CALU.Body;
%     table{stepNumber,2} = 5;
%     table{stepNumber,3} = BodyStep;
    stepNumber = stepNumber + 1;
    
    %% 如果抵达终点，则跳出循环
    if FlagTargetReach
        if targetNumber == targetTotalNumber
            disp("******************************************");  %到达最终目标标点
            disp("Final target is reached.");
            break
        else
            disp(" ");
            disp("******************************************");
            disp(['Target ',num2str(targetNumber),' is reached']); %到达第targetNumber个目标点
            disp(" ");
            targetNumber = targetNumber + 1;
            FlagTargetReach = false;
        end
    end
    
    %% 根据腿长、地形因素判断下一步的步长
    if ~flagDeadLock
        % 若不自锁，则计算这一步脚能迈多大
        FootStep = NextFootStep(BODY_FOR_CALU, indexFoot, Obstacle_Point, targetArgu(2,targetNumber));
    else
        % 若自锁，则先调整脚的位置，然后进入下一个循环，重新计算身体移动距离
%         error("Deadlock!");
        disp('Deadlock!');
        indexFoot
        continue
%         [FootStep, Foot_index] = UnDeadLock(BODY_FOR_CALU, Foot_index, Gap);
    end
    
    %% 找到合适的距离后，走这一段距离
    if flagDeadLock && FootStep(4) ~= 0 && FootStep(5) ~= 0
        % 如果自锁，计算结果可能会有身体的移动，因此先走身体，再走脚
        BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, 5, FootStep(4:9),BODY_PARA);
        % 记录相关信息
        stepNumber = stepNumber + 1;
    end
    %腿的运动
    BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, indexFoot, FootStep(1:3),BODY_PARA);
    % 记录相关信息
    stepNumber = stepNumber + 1;
    Leg_Point=roundn(BODY_FOR_CALU.TraceData(20*(stepNumber-3)+1:20*(stepNumber-1),:),-4);
end
%% 后处理table数据
% load('table.mat');
% table = table';
% global ReLML
% close(ReLML);

