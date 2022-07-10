% 根据障碍物，计算下一步的脚需要抬多高
function map_z = getFootHeight(Gap, Robot, Foot, map_x, map_y)

map_z = zeros(size(map_x));
% map_z是脚需要迈步的高度，当然默认为0
% 如果遇到障碍物或者沟壑，那么高度就是障碍物表面高度

xv = reshape(map_x,1,Robot.len_x * Robot.len_y);
yv = reshape(map_y,1,Robot.len_x * Robot.len_y);

TransMat = [Robot.Body(Foot) Robot.Body(Foot+5)] - [0 0];
for i = 1:length(Gap)
    % 把全局坐标系下的障碍物转移到局部坐标系下
    Gap(i).RectangleInitial = Gap(i).RectangleInitial - TransMat;
    A = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) 0];
    B = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2)];
    C = Gap(i).RectangleInitial + [0 Gap(i).RectangleLengthWidth(2)];
    D = Gap(i).RectangleInitial;
    ObsMatrix = [A; B; C; D]; % 障碍物的顶点
    
    in = inpolygon(xv,yv,ObsMatrix(:,1),ObsMatrix(:,2)); % 位于障碍物区域边缘内部或边缘上的点
    if Gap(i).Height(2) > 0 
        % 如果是障碍物
        map_z(in) = Gap(i).Height(2);
    else
        % 如果是沟壑
        map_z(in) = Gap(i).Height(1);
    end

end

end