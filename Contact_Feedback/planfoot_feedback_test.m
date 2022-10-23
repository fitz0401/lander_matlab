%% 实验1：单腿运动触地检测测试
% 存储运行参数
global Q_INT
window_length = 100;
foot_pos = zeros(3,1);
window_vel = zeros(3,window_length);
window_acc = zeros(3,window_length);
window_toq = zeros(3,window_length);
sum_data = zeros(9,1);

% 初始化ROS网络, 网线通讯已经搭建好，不需要再设置默认端口
rosinit
% 启动ROS参数服务器
GlobalParam = rosparam;
% rossvcclient的参数是在服务器（lander）端定义的话题名称
lander_pub = rospublisher('GaitPlan', "lander/gait_plan_msgs");
req_msg = rosmessage(lander_pub);
% 延时7s，等待着陆器主机订阅方启动
pause(7)

%% 【检查编码器和足端初始位置信息是否正确】
% The default service request message is an empty message of type serviceclient.ServiceType.
req_msg.CommandIndex = 0;
% 向着陆器发送命令，每次发布命令前设置完成标志为为false，程序会从着陆器处获取该标志位
isFinishFlag = false;
send(lander_pub, req_msg);
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
    send(lander_pub, req_msg);
    while isFinishFlag == false
        isFinishFlag = get(GlobalParam, '/isFinishFlag');
    end
    disp("————————————已完成位姿初始化————————————")
end

%% 【单腿运动程序】：单腿或多腿直线运动指定位移
% 单腿运动：l=0/1/2/3；多腿同时运动：l=12
% 足端位移单位：mm, [3×1 double]
req_msg.CommandIndex = 102;
req_msg.LegIndex = 1;
req_msg.Foot2Motion = [20, 10, -75];
isFinishFlag = false;
set(GlobalParam, '/contactIndex', 0);
contact_index = 0;
legIndex = req_msg.LegIndex;
send(lander_pub, req_msg);

%% 【触地检测程序】：基于动力学检测足端外力，并反馈检测结果
% 订阅机器人状态信息
lander_sub = rossubscriber('JointState',"sensor_msgs/JointState");
while isFinishFlag == false
    % 每个count接收和解析状态信息
    if contact_index == 0
        state_msg = receive(lander_sub);
    end
    current_count = state_msg.Header.Seq;
    [average_vel, average_acc, average_toq, window_vel, window_acc, window_toq, sum_data] = ...
    data_process(state_msg, legIndex, window_vel, window_acc, window_toq, sum_data);
    % 运行1秒后，每20ms检验一次
    if  (current_count > 1000) && (mod(current_count,20) == 0)
        foot_pos = state_msg.Position(legIndex*3+1:legIndex*3+3);
        contact_index = EndForce_Identify(foot_pos, average_vel, average_acc, average_toq);
        set(GlobalParam, '/contactIndex', contact_index);
    end
    isFinishFlag = get(GlobalParam, '/isFinishFlag');
end
disp("————————————着陆器已进入运动规划的初始位姿————————————")