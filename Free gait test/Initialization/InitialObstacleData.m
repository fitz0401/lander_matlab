function K = InitialObstacleData()
Data = load("1.txt");
% Data = load("1.txt");
Obstacle_Point1=Data(:,1:3);
%坐标系转换
Obstacle_Point1=(rotz(45)*Obstacle_Point1.').';

% Obstacle_Point1(:,1)=Obstacle_Point1(:,1)+0.050;
% Obstacle_Point1(:,2)=Obstacle_Point1(:,2)+0.200;
%单个相机点做对称
Obstacle_Point2=Obstacle_Point1;
Obstacle_Point2(:,2)=-Obstacle_Point2(:,2);
Obstacle_Point=[Obstacle_Point1;Obstacle_Point2];
Obstacle_Point=Obstacle_Point.*1000;
%做简单的筛选
index=find(Obstacle_Point(:,3)>=-660);
Obstacle_Point=Obstacle_Point(index,:);
% index=find(Obstacle_Point(:,3)<=-619.5);
% Obstacle_Point=Obstacle_Point(index,:);
% TBG=   [ [1.0000         0         0         0];
%          [0    1.0000         0         0];
%          [0         0    1.0000  504.6427+130];
%          [0         0         0    1.0000];];
%地形点坐标变换
TBG=   [ [1.0000         0         0         0];
         [0    1.0000         0         0];
         [0         0    1.0000  504.6427+130];
         [0         0         0    1.0000];];
K=TBG*[Obstacle_Point.';ones(1,length(Obstacle_Point(:,1)))];
% scatter3(K(1,:),K(2,:), K(3,:), 10,[1,0.89,0.7],'filled'); % 重心投影点
% scatter3(Obstacle_Point1(1,:),K(2,:), K(3,:), 10,[1,0.89,0.7],'filled'); % 重心投影点
end