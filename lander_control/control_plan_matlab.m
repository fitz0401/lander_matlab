% 初始化ROS网络, 网线通讯已经搭建好，不需要再设置默认端口
rosinit 
%% 使用'rossvcclient'创建一个客户端，采用我们自定义的数据结构
% MessageType: 'msgs_packages/mv_msgsRequest'
%     CommandIndex: 0
%              Leg: 0
%          XMotion: 0
%          YMotion: 0
%          ZMotion: 0
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
% rossvcclient的参数是在服务器（lander）端定义的话题名称
lander_client = rossvcclient('mv_msgs');
% 检查通讯是否建立
if(isServerAvailable(lander_client))
    [connectionStatus,connectionStatustext] = waitForServer(lander_client)
end
% 创建服务请求函数
req_msg = rosmessage(lander_client);

%% 【检查编码器和足端初始位置信息是否正确】
% The default service request message is an empty message of type serviceclient.ServiceType.
req_msg.CommandIndex = 0;
% 向着陆器发送命令
lander_resp = call(lander_client, req_msg);
% 用户输入，检查初始位置信息后决定是否继续执行
cheak_string = input("请检查编码器位置是否在零位，并决定是否继续执行[y/n]:","s");
if(cheak_string == 'n')
    % 关闭ROS网络并退出程序
    rosshutdown
    error("需要重新配置kannh.xml，调整编码器初始位置")
end
disp("Finish Status:")
disp(lander_resp.IsFinish)

%% 【着陆器复位程序】：建议每次开始运行前都进行初始化
req_msg.CommandIndex = 1;
lander_resp = call(lander_client, req_msg);
disp("Finish Status:")
disp(lander_resp.IsFinish)

%% 【单腿运动程序】：使着陆器进入运动规划的初始位姿
% 单腿运动：l=1/2/3/4；多腿同时运动：要求多腿起始和终止位置一致，l=12
% 足端位移单位：mm
req_msg.CommandIndex = 2;
req_msg.Leg = 12;
req_msg.ZMotion = -75;
lander_resp = call(lander_client, req_msg);
disp("Finish Status:")
disp(lander_resp.IsFinish)

%% 【运动规划程序】：进入运动规划主循环
req_msg.CommandIndex = 3;
% 记录执行次数
count = 0;
isFinishFlag = false;
% 启动ROS参数服务器
GlobalParam = rosparam;
while(1)
    %% 在此处添加运动规划代码，赋值给req_msg.DataNum和12个向量【记得每次数组第一个数和上次数组最后一个数一致】
    req_msg.DataNum = 10;
    req_msg.Foot1TraceX = [441.840797218405, 443.050321975698, 444.259846732991, 445.469371490284,446.678896247577, ...
                                447.888421004869, 449.097945762162, 450.307470519455, 451.516995276748, 452.72652003404];
    req_msg.Foot1TraceY = [-5.40E-15, 0.093040365945606, 0.186080731891216, 0.279121097836787,0.372161463782398, ...
                                0.465201829727969, 0.55824219567358, 0.651282561619191, 0.744322927564761, 0.837363293510372];
    req_msg.Foot1TraceZ = [-520.1427, -520.1427, -520.1427, -520.1427,-520.1427, ...
                                -520.1427, -520.1427, -520.1427, -520.1427, -520.1427];
    req_msg.Foot2TraceX = [441.840797218405, 443.050321975698, 444.259846732991, 445.469371490284,446.678896247577, ...
                                447.888421004869, 449.097945762162, 450.307470519455, 451.516995276748, 452.72652003404];
    req_msg.Foot2TraceY = [-5.40E-15, 0.093040365945606, 0.186080731891216, 0.279121097836787,0.372161463782398, ...
                                0.465201829727969, 0.55824219567358, 0.651282561619191, 0.744322927564761, 0.837363293510372];
    req_msg.Foot2TraceZ = [-520.1427, -520.1427, -520.1427, -520.1427,-520.1427, ...
                                -520.1427, -520.1427, -520.1427, -520.1427, -520.1427];
    req_msg.Foot3TraceX = [441.840797218405, 443.050321975698, 444.259846732991, 445.469371490284,446.678896247577, ...
                                447.888421004869, 449.097945762162, 450.307470519455, 451.516995276748, 452.72652003404];
    req_msg.Foot3TraceY = [-5.40E-15, 0.093040365945606, 0.186080731891216, 0.279121097836787,0.372161463782398, ...
                                0.465201829727969, 0.55824219567358, 0.651282561619191, 0.744322927564761, 0.837363293510372];
    req_msg.Foot3TraceZ = [-520.1427, -520.1427, -520.1427, -520.1427,-520.1427, ...
                                -520.1427, -520.1427, -520.1427, -520.1427, -520.1427];
    req_msg.Foot4TraceX = [441.840797218405, 443.050321975698, 444.259846732991, 445.469371490284,446.678896247577, ...
                                447.888421004869, 449.097945762162, 450.307470519455, 451.516995276748, 452.72652003404];
    req_msg.Foot4TraceY = [-5.40E-15, 0.093040365945606, 0.186080731891216, 0.279121097836787,0.372161463782398, ...
                                0.465201829727969, 0.55824219567358, 0.651282561619191, 0.744322927564761, 0.837363293510372];
    req_msg.Foot4TraceZ = [-520.1427, -520.1427, -520.1427, -520.1427,-520.1427, ...
                                -520.1427, -520.1427, -520.1427, -520.1427, -520.1427];
    %% 判断上个指令的动作是否执行完毕，并发送数据
    if count ~= 0
        while isFinishFlag == false
            isFinishFlag = get(GlobalParam, '/isFinishFlag');
        end
    end
    % 不等待回传指令，直接进入下一个循环
    lander_resp = call(lander_client, req_msg, 'Timeout', 1);
    count = count + 1;
    fprintf("————————————正在执行第 %d 次规划命令————————————\n", count);
end

% 关闭ROS网络
rosshutdown
