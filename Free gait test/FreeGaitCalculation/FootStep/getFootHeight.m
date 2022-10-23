% 根据障碍物，计算下一步的脚需要抬多高
function map_z = getFootHeight(Obstacle_Point, Robot, Foot, map_x, map_y)

map_z = zeros(size(map_x));
% map_z是脚需要迈步的高度，当然默认为0
% 如果遇到障碍物或者沟壑，那么高度就是障碍物表面高度

xv = reshape(map_x,1,Robot.len_x * Robot.len_y);
yv = reshape(map_y,1,Robot.len_x * Robot.len_y);

TransMat = [Robot.Body(Foot) Robot.Body(Foot+5)] - [0 0];%当前足端在坐标系G中的位置


%目前的思路是首先把障碍物坐标变换到局部坐标系下，然后判断MAP中的点是否在障碍物顶点围成的区域内，对区域内的点赋高度值；
%在读取真实地图时，首先把地图的坐标点转换到当前足端坐标系下，然后对mapZ中每个xy点对应的位置进行搜索，找到与map点最接近的地图点作为该点的近似点，近似点的Z值即为该map点的Z值；
%为了提高速度这里可以对obstacle做适当的精简；
Obstacle_temp=Obstacle_Point(1:3,:).';
Obstacle_temp(:,1:2)=Obstacle_temp(:,1:2)-TransMat;
margin=10;
index=find((Obstacle_temp(:,1)>(min(xv)-margin))&(Obstacle_temp(:,1)<(max(xv)+margin))&(Obstacle_temp(:,2)>(min(yv)-margin))&(Obstacle_temp(:,2)<(max(yv)+margin)));
Obstacle_temp=Obstacle_temp(index,:);
if isempty(Obstacle_temp)
    map_z=Robot.Body(Foot+10)*ones(size(map_x));
else
    for i=1:length(xv)
        Distance=sqrt((Obstacle_temp(:,1)-xv(i)).^2+(Obstacle_temp(:,2)-yv(i)).^2);
        [~,k]=min(Distance);
        map_z(i) = Obstacle_temp(k,3);
    end
end
%scatter3(Obstacle_temp(:,1),Obstacle_temp(:,2), Obstacle_temp(:,3), 10,[1,0.89,0.9],'filled'); % 重心投影点
% for 

% for i = 1:length(Gap)
%     % 把全局坐标系下的障碍物转移到局部坐标系下
%     Gap(i).RectangleInitial = Gap(i).RectangleInitial - TransMat;
%     A = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) 0];
%     B = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2)];
%     C = Gap(i).RectangleInitial + [0 Gap(i).RectangleLengthWidth(2)];
%     D = Gap(i).RectangleInitial;
%     ObsMatrix = [A; B; C; D]; % 障碍物的顶点
%     
%     in = inpolygon(xv,yv,ObsMatrix(:,1),ObsMatrix(:,2)); % 位于障碍物区域边缘内部或边缘上的点
%     if Gap(i).Height(2) > 0 
%         % 如果是障碍物
%         map_z(in) = Gap(i).Height(2);
%     else
%         % 如果是沟壑
%         map_z(in) = Gap(i).Height(1);
%     end
% 
% end
end