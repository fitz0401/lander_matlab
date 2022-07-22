% 启动ROS参数服务器
GlobalParam = rosparam;
% rossvcclient的参数是在服务器（lander）端定义的话题名称
lander_client = rossvcclient('GaitPlanFeedback');
req_msg = rosmessage(lander_client);
%% 清除错误并重新使能电机
req_msg.CommandIndex = -1;
isFinishFlag = false;
lander_resp = call(lander_client, req_msg);
while isFinishFlag == false
        isFinishFlag = get(GlobalParam, '/isFinishFlag');
end
%% 位姿初始化
req_msg.CommandIndex = 1;
isFinishFlag = false;
lander_resp = call(lander_client, req_msg);
while isFinishFlag == false
        isFinishFlag = get(GlobalParam, '/isFinishFlag');
end
disp("————————————已完成位姿初始化————————————")
rosshutdown