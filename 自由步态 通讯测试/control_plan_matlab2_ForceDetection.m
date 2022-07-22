%% 实验2：基于触地检测的巡视行走
% 初始化ROS网络, 网线通讯已经搭建好，不需要再设置默认端口
rosinit
% 启动ROS参数服务器
GlobalParam = rosparam;

%% 使用'rossvcclient'创建一个客户端，用于等待接收触地后返回的足端位置信息
% rossvcclient的参数是在服务器（lander）端定义的话题名称
% MessageType: 'lander/gait_plan_msgs'
%     CommandIndex: 0
%         LegIndex: 0
%      Foot1Motion: [3×1 double]
%      Foot2Motion: [3×1 double]
%      Foot3Motion: [3×1 double]
%      Foot4Motion: [3×1 double]
%          DataNum: 0
%      Foot1TraceX: [0×1 double]
%      Foot1TraceY: [0×1 double]
%      Foot1TraceZ: [0×1 double]
%      Foot2TraceX: [0×1 double]
%      Foot2TraceY: [0×1 double]
%      Foot2TraceZ: [0×1 double]
%      Foot3TraceX: [0×1 double]
%      Foot3TraceY: [0×1 double]
%      Foot3TraceZ: [0×1 double]
%      Foot4TraceX: [0×1 double]
%      Foot4TraceY: [0×1 double]
%      Foot4TraceZ: [0×1 double]
lander_client = rossvcclient('GaitPlanFeedback');
% 检查通讯是否建立
if(isServerAvailable(lander_client))
    [connectionStatus,connectionStatustext] = waitForServer(lander_client)
end
% 创建服务请求函数
req_msg = rosmessage(lander_client);

%% 【检查编码器和足端初始位置信息是否正确】
% The default service request message is an empty message of type serviceclient.ServiceType.
req_msg.CommandIndex = 0;
% 向着陆器发送命令，每次发布命令前设置完成标志为为false，程序会从着陆器处获取该标志位
isFinishFlag = false;
lander_resp = call(lander_client, req_msg);
% 用户输入，检查初始位置信息后决定是否继续执行
cheak_string = input("请检查编码器位置是否正确（初始姿态下均为0），并决定是否继续执行[y/n]:","s");
if(cheak_string == 'n')
    % 关闭ROS网络并退出程序
    rosshutdown
    error("需要重新配置kannh.xml，调整编码器初始位置")
end
% 利用ROS全局参数，判断着陆器动作是否执行完毕
while isFinishFlag == false
    isFinishFlag = get(GlobalParam, '/isFinishFlag');
end
disp("————————————已完成初始位置检查————————————")

%% 【着陆器复位程序】：建议每次开始运行前都进行初始化
% 用户输入，决定是否需要初始化位姿
cheak_string = input("是否需要初始化位姿（建议开机后均进行初始化操作）[y/n]:","s");
if(cheak_string == 'y')
    req_msg.CommandIndex = 1;
    isFinishFlag = false;
    lander_resp = call(lander_client, req_msg);
    while isFinishFlag == false
        isFinishFlag = get(GlobalParam, '/isFinishFlag');
    end
    disp("————————————已完成位姿初始化————————————")
end

% %% 规划算法初始化
% BODY_FOR_CALU = class_BODY_CALU;
% BODY_PARA = class_BODY_PARA;
% BODY_FOR_CALU = InitialBodyData(BODY_FOR_CALU,BODY_PARA); % 初始化身体数据
% % 生成Gap数据
% gap = InitialGapData('clear');
% % 指定若干终点
% targetArgu = [3000; 0]; % 第一行是运动距离；第二行是相对角度（弧度）
% % target 第i行，第i个终点的绝对位置 targetTotalNumber 目标点的个数
% [target, targetTotalNumber] = InitialTargetPosition([BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10)], targetArgu);
% % 初始化画图窗口
% BODY_FOR_CALU=InitialSimulationData(BODY_FOR_CALU,BODY_PARA, gap, target);
% robotBodyData = BODY_FOR_CALU.Body'; % 存储数据，为后处理准备
% % 先计算步态，然后运动（同时生成运动图像）。若遇到障碍物，转向。然后循环
% targetNumber = 1; flagDeadLock = false; stepNumber = 1; indexFoot = 0;
% DELTA_LEG_initial=roundn(BODY_FOR_CALU.TraceData-repmat(BODY_FOR_CALU.Land_pose,1,4),-3);

%% 【单腿运动程序】：使着陆器进入运动规划的初始位姿
% 单腿运动：l=0/1/2/3；多腿同时运动：l=12
% 足端位移单位：mm, [3×1 double]
req_msg.CommandIndex = 2;
req_msg.LegIndex = 1;
% req_msg.Foot1Motion = DELTA_LEG_initial(1:3);
% req_msg.Foot2Motion = DELTA_LEG_initial(4:6);
% req_msg.Foot3Motion = DELTA_LEG_initial(7:9);
% req_msg.Foot4Motion = DELTA_LEG_initial(10:12);
req_msg.Foot1Motion = [0,0,0];
req_msg.Foot2Motion = [0,0,-50];
req_msg.Foot3Motion = [0,0,0];
req_msg.Foot4Motion = [0,0,0];
isFinishFlag = false;
lander_resp = call(lander_client, req_msg);
while isFinishFlag == false
    isFinishFlag = get(GlobalParam, '/isFinishFlag');
end
disp("————————————着陆器已进入运动规划的初始位姿————————————")
disp(lander_resp.Foot1Position)
disp(lander_resp.Foot2Position)
disp(lander_resp.Foot3Position)
disp(lander_resp.Foot4Position)

% %% 【运动规划程序】：进入运动规划主循环
% req_msg.CommandIndex = 3;
% % 记录执行次数
% count = 0;
% while(1)
%     %% 规划循环内容
%     if stepNumber == 63
%         robot1 = BODY_FOR_CALU;
%     elseif stepNumber == 41
%         robot2 = BODY_FOR_CALU;
%     end
%     %计算出下一步身体位置
%     [BodyStep, indexFoot, flagDeadLock, FlagTargetReach] = NextBodyStep(BODY_FOR_CALU, ...
%         target(targetNumber,:), indexFoot, targetArgu(2,targetNumber), flagDeadLock);
%     % 若不自锁，则找到合适的距离后，走这一段距离
%     BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, 5, BodyStep ,BODY_PARA);
%     % 记录相关信息
%     stepNumber = stepNumber + 1;
%     % 如果抵达终点，则跳出循环
% 
%     % 根据腿长、地形因素判断下一步的步长
%     if ~flagDeadLock
%         % 若不自锁，则计算这一步脚能迈多大
%         FootStep = NextFootStep(BODY_FOR_CALU, indexFoot, gap, targetArgu(2,targetNumber));
%     else
%         % 若自锁，则先调整脚的位置，然后进入下一个循环，重新计算身体移动距离
%         error("Deadlock!");
%         %         [FootStep, Foot_index] = UnDeadLock(BODY_FOR_CALU, Foot_index, Gap);
%     end
%     
%     % 找到合适的距离后，走这一段距离
%     if flagDeadLock && FootStep(4) ~= 0 && FootStep(5) ~= 0
%         % 如果自锁，计算结果可能会有身体的移动，因此先走身体，再走脚
%         BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, 5, FootStep(4:9),BODY_PARA);
%         % 记录相关信息
%         stepNumber = stepNumber + 1;
%     end
%     %腿的运动
%     BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, indexFoot, FootStep(1:3),BODY_PARA);
%     % 记录相关信息
%     stepNumber = stepNumber + 1;
%     %% 判断上个指令的动作是否执行完毕，并发送数据
%     Leg_Point=roundn(BODY_FOR_CALU.TraceData(20*(stepNumber-3)+1:20*(stepNumber-2),:),-3);
%     if ~isempty(find((Leg_Point(1,:)==Leg_Point(end,:))==0))
%         req_msg.DataNum = 20;
%         req_msg.Foot1TraceX = Leg_Point(:,1);
%         req_msg.Foot1TraceY = Leg_Point(:,2);
%         req_msg.Foot1TraceZ = Leg_Point(:,3);
%         req_msg.Foot2TraceX = Leg_Point(:,4);
%         req_msg.Foot2TraceY = Leg_Point(:,5);
%         req_msg.Foot2TraceZ = Leg_Point(:,6);
%         req_msg.Foot3TraceX = Leg_Point(:,7);
%         req_msg.Foot3TraceY = Leg_Point(:,8);
%         req_msg.Foot3TraceZ = Leg_Point(:,9);
%         req_msg.Foot4TraceX = Leg_Point(:,10);
%         req_msg.Foot4TraceY = Leg_Point(:,11);
%         req_msg.Foot4TraceZ = Leg_Point(:,12);
%         if count ~= 0
%             while isFinishFlag == false
%                 isFinishFlag = get(GlobalParam, '/isFinishFlag');
%             end
%         end
%         % 发布第一段运动
%         isFinishFlag = false;
%         lander_resp = call(lander_client, req_msg);
%     end
% 
%     %% 判断上个指令的动作是否执行完毕，并发送数据
%     Leg_Point=roundn(BODY_FOR_CALU.TraceData(20*(stepNumber-2)+1:20*(stepNumber-1),:),-3);
%     req_msg.Foot1TraceX = Leg_Point(:,1);
%     req_msg.Foot1TraceY = Leg_Point(:,2);
%     req_msg.Foot1TraceZ = Leg_Point(:,3);
%     req_msg.Foot2TraceX = Leg_Point(:,4);
%     req_msg.Foot2TraceY = Leg_Point(:,5);
%     req_msg.Foot2TraceZ = Leg_Point(:,6);
%     req_msg.Foot3TraceX = Leg_Point(:,7);
%     req_msg.Foot3TraceY = Leg_Point(:,8);
%     req_msg.Foot3TraceZ = Leg_Point(:,9);
%     req_msg.Foot4TraceX = Leg_Point(:,10);
%     req_msg.Foot4TraceY = Leg_Point(:,11);
%     req_msg.Foot4TraceZ = Leg_Point(:,12);
%     
%     while isFinishFlag == false
%             isFinishFlag = get(GlobalParam, '/isFinishFlag');
%     end
%     % 发布第二段运动，之后直接进入下一个循环计算轨迹
%     isFinishFlag = false;
%     lander_resp = call(lander_client, req_msg);
%     
%     count = count + 1;
%     fprintf("————————————正在执行第 %d 次规划命令————————————\n", count);
% end

% 关闭ROS网络
rosshutdown
