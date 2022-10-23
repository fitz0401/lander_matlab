function [apexData,robot] = ProcessApex(table,robot)

% n*18的数据
apexData = zeros(size(table,1)+1,18); % 第一行是刚开始的数据，还未运动
robot = [robot; zeros(size(table,1),42)];

for i = 1:2:size(table,1)
    % i = 1时，身体动（6个数据）；i = 2时，脚动身体不动
    apexData(i+1,1:6) = table{i,3};
    robot(i+1,:) = table{i,1}'; 
    if i < size(table,1)
        robot(i+2,:) = table{i+1,1}';
    end
end
% 只有角度(:,4:6)是相对的，其他的都是绝对值，直接从robot里赋值
% xm,ym,zm为绝对坐标系内白色结构体中心G相对，绝对坐标系原点O的坐标值；
% theta_G,beta_G,gama_G，为机身转动的欧拉角。
% 每个时刻都需要出，18个数值，n个时刻需要出n×18的矩阵，如下：
% [xm,ym,zm,theta_G,beta_G,gama_G,[x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4]]
apexData(:,1:3) = [robot(:,5)+80 robot(:,10) robot(:,15)];
apexData(:,7:18) = [robot(:,1) robot(:,6) robot(:,11)...
    robot(:,2) robot(:,7) robot(:,12)...
    robot(:,3) robot(:,8) robot(:,13)...
    robot(:,4) robot(:,9) robot(:,14)] - ...
    repmat(apexData(:,1:3),1,4);
end