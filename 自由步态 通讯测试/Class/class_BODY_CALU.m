classdef class_BODY_CALU
    properties
        Body   %机器人参数包括四个身体角点、四个足端角点和质心点
        
        %BODY数据的存储方式 1~4 四腿X 6~9 四腿Y 11~14 四腿Z 16~19 身体框X的坐标 20~23身体框Y坐标 
        %24~27 身体框Z坐标  5 10 15表示机身质心初始位置的X Y Z坐标
        %28~31表示四条腿的重心点的x坐标，32表示机器人总质心点X坐标
        %33~36表示四条腿的重心点的Y坐标，37表示机器人总质心点Y坐标
        %38~41表示四条腿的重心点的Z坐标，42表示机器人总质心点Z坐标
        Body0
        Body_line
        TraceData  %增加的轨迹储存变量，储存四足和机身的轨迹参数
        Foot_height=15;
        NUM_trace=20;
        NUM_Step
        TCB %机身坐标系与单腿坐标系的变换矩阵
        TBG %世界坐标系与机身坐标系的变换矩阵
        T
        SM % 稳定裕度
        MassRatio % 四条腿和身体的占比重量
        RotateAngle = [0 0 0]%这个参数的具体含义和应用？？？
        RotateAngle_Boundry = [-0.1, -0.2, -0.05; 0.1, 0.2, 0.05]
        gradBoundry = 1 % 地图梯度的最大范围，超过这个梯度的点不能踩
        Leg % 四腿的工作空间
%         Inteval = 6.25 % 工作空间的精度
        Inteval = 2.5 % 工作空间的精度
        WS_Data %绘图用的工作空间
        
        len_x = 1 % map_x长度         这里长度指的是？？
        len_y = 1 % map_y长度
        len_z = 1 % map_z长度
        
        % 自定义的公共工作空间的坐标系，每只脚初始位置都在这个坐标系原点
        interSpace % 格式是4*2矩阵
        BodySpace % 身体工作空间
%         stride = 100 % 最大跨距
        stride = 80 % 最大跨距
        % 4*3的矩阵，分别是以足端为中心，四个身体顶点相对于足端点的δx/y/z
        IdealLegLength
    end
    
   %添加轨迹目前的办法就是修改Move函数和show函数
    
    methods
        function Robot = Move(Robot, num, stepX, stepY, stepZ)%机器人运动函数
            %Robot机器人结构体  num??  stepX, stepY, stepZ分别为X Y Z方向的步长
            %BODY的具体数据存储方式？？？
            if num < 5
                Robot.Body(num,:,:) = Robot.Body(num,:,:) + stepX; % 迈腿
                Robot.Body(num+5,:,:) = Robot.Body(num+5,:,:) + stepY; % 迈腿
                Robot.Body(num+10,:,:) = Robot.Body(num+10,:,:) + stepZ; % 迈腿
                
                Robot.Body(num+27,:,:) = (Robot.Body(num+15,:,:) + Robot.Body(num,:,:))/2; % 腿重心变化
                Robot.Body(num+32,:,:) = (Robot.Body(num+19,:,:) + Robot.Body(num+5,:,:))/2; % 腿重心变化
                Robot.Body(num+37,:,:) = (Robot.Body(num+23,:,:) + Robot.Body(num+10,:,:))/2; % 腿重心变化
            elseif num == 5
                Robot.Body(5,:,:) = Robot.Body(5,:,:) + stepX; % 身体重心变化
                Robot.Body(10,:,:) = Robot.Body(10,:,:) + stepY;
                Robot.Body(15,:,:) = Robot.Body(15,:,:) + stepZ;
                
                Robot.Body(16:19,:,:) = Robot.Body(16:19,:,:) + stepX; % 身体顶点变化
                Robot.Body(20:23,:,:) = Robot.Body(20:23,:,:) + stepY;
                Robot.Body(24:27,:,:) = Robot.Body(24:27,:,:) + stepZ;
                
                Robot.Body(28:31,:,:) = (Robot.Body(1:4,:,:) + Robot.Body(16:19,:,:))/2; % 腿重心变化
                Robot.Body(33:36,:,:) = (Robot.Body(6:9,:,:) + Robot.Body(20:23,:,:))/2;
                Robot.Body(38:41,:,:) = (Robot.Body(11:14,:,:) + Robot.Body(24:27,:,:))/2;
            else
                error('Error in Foot/Body to move in calculation.');
            end
            Robot.Body(32,:,:) = Robot.Body(5,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(28,:,:) * Robot.MassRatio(1) + Robot.Body(29,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(30,:,:) * Robot.MassRatio(3) + Robot.Body(31,:,:) * Robot.MassRatio(4);
            Robot.Body(37,:,:) = Robot.Body(10,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(33,:,:) * Robot.MassRatio(1) + Robot.Body(34,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(35,:,:) * Robot.MassRatio(3) + Robot.Body(36,:,:) * Robot.MassRatio(4);
            Robot.Body(42,:,:) = Robot.Body(15,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(38,:,:) * Robot.MassRatio(1) + Robot.Body(39,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(40,:,:) * Robot.MassRatio(3) + Robot.Body(41,:,:) * Robot.MassRatio(4);
        end
        
        function Robot = Rotate(Robot, rx, ry, rz)
%             apex_in_body = [Robot.Body(16:19)'- Robot.Body(5); Robot.Body(20:23)'- Robot.Body(10); Robot.Body(24:27)'- Robot.Body(15)];
%             apex_in_body(4,:) = [1 1 1 1];
%             rotMat = [eul2rotm([rx, ry, rz]),[Robot.Body(5); Robot.Body(10); Robot.Body(15)];0,0,0,1];
%             apex_in_global = rotMat * apex_in_body; % 顶点在global下的坐标，每一列是一个顶点[x;y;z;1]
%             apex_in_global = apex_in_global'; % 顶点在global下的坐标，每一行是一个顶点[x,y,z,1]
%             
%             Robot.Body(16:19,:,:) = apex_in_global(:,1); % 身体顶点变化
%             Robot.Body(20:23,:,:) = apex_in_global(:,2);
%             Robot.Body(24:27,:,:) = apex_in_global(:,3);

            apex_in_body = [Robot.Body0(16:19)'- Robot.Body0(5); Robot.Body0(20:23)'- Robot.Body0(10); Robot.Body0(24:27)'- Robot.Body0(15)];
            apex_in_body_aftermove = eul2rotm([rx, ry, rz],'XYZ') * apex_in_body; % 顶点在global下的坐标，每一列是一个顶点[x;y;z;1]
            apex_in_body_aftermove = apex_in_body_aftermove';
            apex_in_global = apex_in_body_aftermove + repmat([Robot.Body(5), Robot.Body(10), Robot.Body(15)],[4,1]);
            % 顶点在global下的坐标，每一行是一个顶点[x,y,z]
            
            Robot.Body(16:19,:,:) = apex_in_global(:,1); % 身体顶点变化
            Robot.Body(20:23,:,:) = apex_in_global(:,2);
            Robot.Body(24:27,:,:) = apex_in_global(:,3);
            
            Robot.Body(28:31,:,:) = (Robot.Body(1:4,:,:) + Robot.Body(16:19,:,:))/2; % 腿重心变化
            Robot.Body(33:36,:,:) = (Robot.Body(6:9,:,:) + Robot.Body(20:23,:,:))/2;
            Robot.Body(38:41,:,:) = (Robot.Body(11:14,:,:) + Robot.Body(24:27,:,:))/2;
            
            Robot.Body(32,:,:) = Robot.Body(5,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(28,:,:) * Robot.MassRatio(1) + Robot.Body(29,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(30,:,:) * Robot.MassRatio(3) + Robot.Body(31,:,:) * Robot.MassRatio(4);
            Robot.Body(37,:,:) = Robot.Body(10,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(33,:,:) * Robot.MassRatio(1) + Robot.Body(34,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(35,:,:) * Robot.MassRatio(3) + Robot.Body(36,:,:) * Robot.MassRatio(4);
            Robot.Body(42,:,:) = Robot.Body(15,:,:) * Robot.MassRatio(5) ...
                + Robot.Body(38,:,:) * Robot.MassRatio(1) + Robot.Body(39,:,:) * Robot.MassRatio(2) ...
                + Robot.Body(40,:,:) * Robot.MassRatio(3) + Robot.Body(41,:,:) * Robot.MassRatio(4);
        end
    end
end