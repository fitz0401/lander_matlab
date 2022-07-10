% InitialData：初始化参数，根据读入的数据，初始化 CALU MOVE SHOW
% 输入：Gap（障碍物）,End_Pos（终止点）
% 无输出，直接完成三个全局变量的赋值

function InitialData(Gap)

set(gcf,'units','centimeters','position',[2,2,38,18]); % figure窗口形状[离屏幕左下角距离 长和宽]
SubFigure.Robot = subplot('Position',[0.04 0.12 0.45 0.8]); % 距离figure窗口左下角的距离（百分比），具体数值同上
% SubFigure.Robot是窗口的名称，Robot是图像中直线等等的名称
title('Robot');
hold on
axis([-2000,5000,-5000,2000]); %axis([-3000,4000,-5000,2000]); % [xmin xmax ymin ymax]
for i = 1:length(Gap)
    if Gap(i).Height(2) > 0
        rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.86 0.86 0.86],'EdgeColor',[0.7 0.7 0.7]); % 障碍物。RGB相等就是灰色
    else
        rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]); % 障碍物。RGB相等就是灰色
    end
    
end
hold off

% 第二幅图，x方向位移图
SubFigure.threeD = subplot('Position',[0.54 0.12 0.45 0.8]);
title('3-D of robot');
axis([-2000,6500,-5000,2000,0,2500]); %axis([-3000,4000,-5000,2000,0,1500]); % [xmin xmax ymin ymax zmin zmax]
xlabel('x'); ylabel('y'); zlabel('z');

hold on
N = 2;
[X,Y] = meshgrid(linspace(-2000,6500,N),linspace(-5000,2000,N)); %[X,Y] = meshgrid(linspace(-3000,4000,N),linspace(-5000,2000,N));
Z = zeros(N);
C = 0.86*ones(N,N,3);
surf(X,Y,Z,C); % 先画平面

for i = 1:length(Gap)
    % 只有障碍物才画立方体，沟壑只画阴影
    if Gap(i).Height(2) > 0
        % PLOTCUBE(EDGES,ORIGIN,ALPHA,COLOR) displays a 3D-cube in the current axes
        plotcube([Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2) Gap(i).Height(2)],...
            [Gap(i).RectangleInitial(1) Gap(i).RectangleInitial(2) Gap(i).Height(1)],1,[0.86 0.86 0.86],[0.5 0.5 0.5]);
    else
        rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]); % 障碍物。RGB相等就是灰色
    end
end

hold off

end