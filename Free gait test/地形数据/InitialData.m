% InitialData����ʼ�����������ݶ�������ݣ���ʼ�� CALU MOVE SHOW
% ���룺Gap���ϰ��,End_Pos����ֹ�㣩
% �������ֱ���������ȫ�ֱ����ĸ�ֵ

function InitialData(Gap)

set(gcf,'units','centimeters','position',[2,2,38,18]); % figure������״[����Ļ���½Ǿ��� ���Ϳ�]
SubFigure.Robot = subplot('Position',[0.04 0.12 0.45 0.8]); % ����figure�������½ǵľ��루�ٷֱȣ���������ֵͬ��
% SubFigure.Robot�Ǵ��ڵ����ƣ�Robot��ͼ����ֱ�ߵȵȵ�����
title('Robot');
hold on
axis([-2000,5000,-5000,2000]); %axis([-3000,4000,-5000,2000]); % [xmin xmax ymin ymax]
for i = 1:length(Gap)
    if Gap(i).Height(2) > 0
        rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.86 0.86 0.86],'EdgeColor',[0.7 0.7 0.7]); % �ϰ��RGB��Ⱦ��ǻ�ɫ
    else
        rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]); % �ϰ��RGB��Ⱦ��ǻ�ɫ
    end
    
end
hold off

% �ڶ���ͼ��x����λ��ͼ
SubFigure.threeD = subplot('Position',[0.54 0.12 0.45 0.8]);
title('3-D of robot');
axis([-2000,6500,-5000,2000,0,2500]); %axis([-3000,4000,-5000,2000,0,1500]); % [xmin xmax ymin ymax zmin zmax]
xlabel('x'); ylabel('y'); zlabel('z');

hold on
N = 2;
[X,Y] = meshgrid(linspace(-2000,6500,N),linspace(-5000,2000,N)); %[X,Y] = meshgrid(linspace(-3000,4000,N),linspace(-5000,2000,N));
Z = zeros(N);
C = 0.86*ones(N,N,3);
surf(X,Y,Z,C); % �Ȼ�ƽ��

for i = 1:length(Gap)
    % ֻ���ϰ���Ż������壬����ֻ����Ӱ
    if Gap(i).Height(2) > 0
        % PLOTCUBE(EDGES,ORIGIN,ALPHA,COLOR) displays a 3D-cube in the current axes
        plotcube([Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2) Gap(i).Height(2)],...
            [Gap(i).RectangleInitial(1) Gap(i).RectangleInitial(2) Gap(i).Height(1)],1,[0.86 0.86 0.86],[0.5 0.5 0.5]);
    else
        rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]); % �ϰ��RGB��Ⱦ��ǻ�ɫ
    end
end

hold off

end