Data = load("1.txt");
% hold on
% axis equal
Obstacle_Point1=Data(:,1:3);
% scatter3(Obstacle_Point1(:,1),Obstacle_Point1(:,2), Obstacle_Point1(:,3), 50,'blue','filled'); % 重心投影点
%坐标变换，绕Z轴转45度
% Obstacle_Point1=(rotz(-45)*Obstacle_Point1.').';
% scatter3(Obstacle_Point1(:,1),Obstacle_Point1(:,2), Obstacle_Point1(:,3), 50,'red','filled'); % 重心投影点
% axis equal

Obstacle_Point1=(rotz(45)*Obstacle_Point1.').';
Obstacle_Point2=Obstacle_Point1;
Obstacle_Point2(:,2)=-Obstacle_Point2(:,2);
Obstacle_Point=[Obstacle_Point1;Obstacle_Point2];
Obstacle_Point=Obstacle_Point.*1000;
% scatter3(Obstacle_Point(:,1),Obstacle_Point(:,2), Obstacle_Point(:,3), 50,'red','filled'); % 重心投影点

index=find(Obstacle_Point(:,3)>=-660);
Obstacle_Point=Obstacle_Point(index,:);
index=find(Obstacle_Point(:,3)<=-619.5);
Obstacle_Point=Obstacle_Point(index,:);
figure(1);
hold on
% scatter3(Obstacle_Point(:,1),Obstacle_Point(:,2), Obstacle_Point(:,3), 10,'blue','filled'); % 重心投影点
axis equal
hold off
TBG=   [ [1.0000         0         0         0];
         [0    1.0000         0         0];
         [0         0    1.0000  504.6427+130];
         [0         0         0    1.0000];];
K=TBG*[Obstacle_Point.';ones(1,length(Obstacle_Point(:,1)))];
scatter3(K(1,:),K(2,:), K(3,:), 10,[1,0.89,0.7],'filled'); % 重心投影点