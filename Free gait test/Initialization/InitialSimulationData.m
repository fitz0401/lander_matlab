function BODY_FOR_CALU=InitialSimulationData(BODY_FOR_CALU,BODY_PARA, Obstacle_Point, target)
%global BODY_FOR_MOVE BODY_FOR_SHOW ReLML
global BODY_FOR_MOVE BODY_FOR_SHOW

%% ��ʼ�� BODY_FOR_MOVE
% ���� BodyApex Foot COG RotNum/Cha
%��Ƶ¼�ƺ���
% global ReLML
% ReLML=VideoWriter('simulation.avi');  %// ����һ����Ƶ�ļ������涯��
% ReLML.FrameRate=10;
% open(ReLML); 
% ��ΪBODY_FOR_CALU.Body��������ʼ���ģ����Լ��㲽̬ʱ�������û�б仯
% ��Ȼ���ظ��ĳ�ʼ״̬����˰�����ֵ��BODY_FOR_MOVE
% BodyColumn = BODY_FOR_CALU.Body(:,1,1,1);

% �ĸ��ŵ�λ�� 4*3 double
BODY_FOR_MOVE.Foot = [BODY_FOR_CALU.Body(1:4), BODY_FOR_CALU.Body(6:9), BODY_FOR_CALU.Body(11:14)];


% �����ĸ������λ�� 4*3 double
BODY_FOR_MOVE.BodyApex = [BODY_FOR_CALU.Body(16:19), BODY_FOR_CALU.Body(20:23), BODY_FOR_CALU.Body(24:27)];
Body_line_G(:,:,1)=BODY_FOR_CALU.TBG*BODY_FOR_CALU.Body_line(:,:,1);
Body_line_G(:,:,2)=BODY_FOR_CALU.TBG*BODY_FOR_CALU.Body_line(:,:,2);

BODY_FOR_MOVE.TBG=BODY_FOR_CALU.TBG;
for k=1:4
    BODY_FOR_MOVE.TCjG(:,:,k)=BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,k);
%     [XS YS WS_down WS_up] = WSC(k,BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,k),BODY_PARA,BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,k)*[441.8408+8*sqrt(2),0,-520.1427,1].');
%    [XS YS WS_down WS_up] = WSC(k,BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,k),BODY_PARA,BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,k)*[450,0,-520,1].');
    BODY_FOR_CALU.WS_Data(:,:,k) = plot3D_jthWalkLegExeMechWS(k,BODY_FOR_CALU.TCB(:,:,k),BODY_PARA);
    
    WS_Data(:,:,k)=BODY_FOR_CALU.TBG*BODY_FOR_CALU.WS_Data(:,:,k);
end
BODY_FOR_MOVE.ntotal=length(BODY_FOR_CALU.WS_Data(1,:,1));
M_RGB_GEN_n=ceil(BODY_FOR_MOVE.ntotal/4)*4;
BODY_FOR_MOVE.M_RGB=M_RGB_GEN(M_RGB_GEN_n); % ����ɫֵ�����������죩
BODY_FOR_MOVE.Body_line=BODY_FOR_CALU.Body_line;
BODY_FOR_MOVE.BodyApex2(:,:,1) = [[Body_line_G(1,1,1);Body_line_G(1,2,1)],[Body_line_G(1,2,1);Body_line_G(1,3,1)],[Body_line_G(1,3,1);Body_line_G(1,4,1)],...
    [Body_line_G(1,4,1);Body_line_G(1,5,1)],[Body_line_G(1,5,1);Body_line_G(1,6,1)],[Body_line_G(1,6,1);Body_line_G(1,7,1)],...
    [Body_line_G(1,7,1);Body_line_G(1,8,1)],[Body_line_G(1,8,1);Body_line_G(1,1,1)],...
    [Body_line_G(1,1,2);Body_line_G(1,2,2)],[Body_line_G(1,2,2);Body_line_G(1,3,2)],[Body_line_G(1,3,2);Body_line_G(1,4,2)],...
    [Body_line_G(1,4,2);Body_line_G(1,5,2)],[Body_line_G(1,5,2);Body_line_G(1,6,2)],[Body_line_G(1,6,2);Body_line_G(1,7,2)],...
    [Body_line_G(1,7,2);Body_line_G(1,8,2)],[Body_line_G(1,8,2);Body_line_G(1,1,2)],...
    [Body_line_G(1,1,1);Body_line_G(1,1,2)],[Body_line_G(1,2,1);Body_line_G(1,2,2)],[Body_line_G(1,3,1);Body_line_G(1,3,2)],...
    [Body_line_G(1,4,1);Body_line_G(1,4,2)],[Body_line_G(1,5,1);Body_line_G(1,5,2)],[Body_line_G(1,6,1);Body_line_G(1,6,2)],...
    [Body_line_G(1,7,1);Body_line_G(1,7,2)],[Body_line_G(1,8,1);Body_line_G(1,8,2)]];
BODY_FOR_MOVE.BodyApex2(:,:,2) = [[Body_line_G(2,1,1);Body_line_G(2,2,1)],[Body_line_G(2,2,1);Body_line_G(2,3,1)],[Body_line_G(2,3,1);Body_line_G(2,4,1)],...
    [Body_line_G(2,4,1);Body_line_G(2,5,1)],[Body_line_G(2,5,1);Body_line_G(2,6,1)],[Body_line_G(2,6,1);Body_line_G(2,7,1)],...
    [Body_line_G(2,7,1);Body_line_G(2,8,1)],[Body_line_G(2,8,1);Body_line_G(2,1,1)],...
    [Body_line_G(2,1,2);Body_line_G(2,2,2)],[Body_line_G(2,2,2);Body_line_G(2,3,2)],[Body_line_G(2,3,2);Body_line_G(2,4,2)],...
    [Body_line_G(2,4,2);Body_line_G(2,5,2)],[Body_line_G(2,5,2);Body_line_G(2,6,2)],[Body_line_G(2,6,2);Body_line_G(2,7,2)],...
    [Body_line_G(2,7,2);Body_line_G(2,8,2)],[Body_line_G(2,8,2);Body_line_G(2,1,2)],...
    [Body_line_G(2,1,1);Body_line_G(2,1,2)],[Body_line_G(2,2,1);Body_line_G(2,2,2)],[Body_line_G(2,3,1);Body_line_G(2,3,2)],...
    [Body_line_G(2,4,1);Body_line_G(2,4,2)],[Body_line_G(2,5,1);Body_line_G(2,5,2)],[Body_line_G(2,6,1);Body_line_G(2,6,2)],...
    [Body_line_G(2,7,1);Body_line_G(2,7,2)],[Body_line_G(2,8,1);Body_line_G(2,8,2)]];
BODY_FOR_MOVE.BodyApex2(:,:,3) = [[Body_line_G(3,1,1);Body_line_G(3,2,1)],[Body_line_G(3,2,1);Body_line_G(3,3,1)],[Body_line_G(3,3,1);Body_line_G(3,4,1)],...
    [Body_line_G(3,4,1);Body_line_G(3,5,1)],[Body_line_G(3,5,1);Body_line_G(3,6,1)],[Body_line_G(3,6,1);Body_line_G(3,7,1)],...
    [Body_line_G(3,7,1);Body_line_G(3,8,1)],[Body_line_G(3,8,1);Body_line_G(3,1,1)],...
    [Body_line_G(3,1,2);Body_line_G(3,2,2)],[Body_line_G(3,2,2);Body_line_G(3,3,2)],[Body_line_G(3,3,2);Body_line_G(3,4,2)],...
    [Body_line_G(3,4,2);Body_line_G(3,5,2)],[Body_line_G(3,5,2);Body_line_G(3,6,2)],[Body_line_G(3,6,2);Body_line_G(3,7,2)],...
    [Body_line_G(3,7,2);Body_line_G(3,8,2)],[Body_line_G(3,8,2);Body_line_G(3,1,2)],...
    [Body_line_G(3,1,1);Body_line_G(3,1,2)],[Body_line_G(3,2,1);Body_line_G(3,2,2)],[Body_line_G(3,3,1);Body_line_G(3,3,2)],...
    [Body_line_G(3,4,1);Body_line_G(3,4,2)],[Body_line_G(3,5,1);Body_line_G(3,5,2)],[Body_line_G(3,6,1);Body_line_G(3,6,2)],...
    [Body_line_G(3,7,1);Body_line_G(3,7,2)],[Body_line_G(3,8,1);Body_line_G(3,8,2)]];

% BODY_FOR_MOVE.BodyApex2(:,:,1) = [[Body_line_G(1,1,1);Body_line_G(1,2,1)],[Body_line_G(1,2,1);Body_line_G(1,3,1)],[Body_line_G(1,3,1);Body_line_G(1,4,1)],...
%     [Body_line_G(1,4,1);Body_line_G(1,5,1)],[Body_line_G(1,5,1);Body_line_G(1,6,1)],[Body_line_G(1,6,1);Body_line_G(1,7,1)],...
%     [Body_line_G(1,7,1);Body_line_G(1,8,1)],[Body_line_G(1,8,1);Body_line_G(1,1,1)],...
%     [Body_line_G(1,1,2);Body_line_G(1,2,2)],[Body_line_G(1,2,2);Body_line_G(1,3,2)],[Body_line_G(1,3,2);Body_line_G(1,4,2)],...
%     [Body_line_G(1,4,2);Body_line_G(1,5,2)],[Body_line_G(1,5,2);Body_line_G(1,6,2)],[Body_line_G(1,6,2);Body_line_G(1,7,2)],...
%     [Body_line_G(1,7,2);Body_line_G(1,8,2)],[Body_line_G(1,8,2);Body_line_G(1,1,2)],...
%     [Body_line_G(1,1,1);Body_line_G(1,1,2)],[Body_line_G(1,2,1);Body_line_G(1,2,2)],[Body_line_G(1,3,1);Body_line_G(1,3,2)],...
%     [Body_line_G(1,4,1);Body_line_G(1,4,2)],[Body_line_G(1,5,1);Body_line_G(1,5,2)],[Body_line_G(1,6,1);Body_line_G(1,6,2)],...
%     [Body_line_G(1,7,1);Body_line_G(1,7,2)],[Body_line_G(1,8,1);Body_line_G(1,8,2)]];
% BODY_FOR_MOVE.BodyApex2(:,:,2) = [[Body_line_G(2,1,1);Body_line_G(2,2,1)],[Body_line_G(2,2,1);Body_line_G(2,3,1)],[Body_line_G(2,3,1);Body_line_G(2,4,1)],...
%     [Body_line_G(2,4,1);Body_line_G(2,5,1)],[Body_line_G(2,5,1);Body_line_G(2,6,1)],[Body_line_G(2,6,1);Body_line_G(2,7,1)],...
%     [Body_line_G(2,7,1);Body_line_G(2,8,1)],[Body_line_G(2,8,1);Body_line_G(2,1,1)],...
%     [Body_line_G(2,1,2);Body_line_G(2,2,2)],[Body_line_G(2,2,2);Body_line_G(2,3,2)],[Body_line_G(2,3,2);Body_line_G(2,4,2)],...
%     [Body_line_G(2,4,2);Body_line_G(2,5,2)],[Body_line_G(2,5,2);Body_line_G(2,6,2)],[Body_line_G(2,6,2);Body_line_G(2,7,2)],...
%     [Body_line_G(2,7,2);Body_line_G(2,8,2)],[Body_line_G(2,8,2);Body_line_G(2,1,2)],...
%     [Body_line_G(2,1,1);Body_line_G(2,1,2)],[Body_line_G(2,2,1);Body_line_G(2,2,2)],[Body_line_G(2,3,1);Body_line_G(2,3,2)],...
%     [Body_line_G(2,4,1);Body_line_G(2,4,2)],[Body_line_G(2,5,1);Body_line_G(2,5,2)],[Body_line_G(2,6,1);Body_line_G(2,6,2)],...
%     [Body_line_G(2,7,1);Body_line_G(2,7,2)],[Body_line_G(2,8,1);Body_line_G(2,8,2)]];
% BODY_FOR_MOVE.BodyApex2(:,:,3) = [[Body_line_G(3,1,1);Body_line_G(3,2,1)],[Body_line_G(3,2,1);Body_line_G(3,3,1)],[Body_line_G(3,3,1);Body_line_G(3,4,1)],...
%     [Body_line_G(3,4,1);Body_line_G(3,5,1)],[Body_line_G(3,5,1);Body_line_G(3,6,1)],[Body_line_G(3,6,1);Body_line_G(3,7,1)],...
%     [Body_line_G(3,7,1);Body_line_G(3,8,1)],[Body_line_G(3,8,1);Body_line_G(3,1,1)],...
%     [Body_line_G(3,1,2);Body_line_G(3,2,2)],[Body_line_G(3,2,2);Body_line_G(3,3,2)],[Body_line_G(3,3,2);Body_line_G(3,4,2)],...
%     [Body_line_G(3,4,2);Body_line_G(3,5,2)],[Body_line_G(3,5,2);Body_line_G(3,6,2)],[Body_line_G(3,6,2);Body_line_G(3,7,2)],...
%     [Body_line_G(3,7,2);Body_line_G(3,8,2)],[Body_line_G(3,8,2);Body_line_G(3,1,2)],...
%     [Body_line_G(3,1,1);Body_line_G(3,1,2)],[Body_line_G(3,2,1);Body_line_G(3,2,2)],[Body_line_G(3,3,1);Body_line_G(3,3,2)],...
%     [Body_line_G(3,4,1);Body_line_G(3,4,2)],[Body_line_G(3,5,1);Body_line_G(3,5,2)],[Body_line_G(3,6,1);Body_line_G(3,6,2)],...
%     [Body_line_G(3,7,1);Body_line_G(3,7,2)],[Body_line_G(3,8,1);Body_line_G(3,8,2)]];

% Body_line_G(:,:,1)=[R2_B_EX_up(:,1),R3_B_EX_up(:,1),R2_B_EX_up(:,2),R3_B_EX_up(:,2),R2_B_EX_up(:,3),R3_B_EX_up(:,3),R2_B_EX_up(:,4),R3_B_EX_up(:,4)];%�ϰ˵�
% Body_line_G(:,:,2)=[R2_B_EX_bottom(:,1),R3_B_EX_bottom(:,1),R2_B_EX_bottom(:,2),R3_B_EX_bottom(:,2),R2_B_EX_bottom(:,3),R3_B_EX_bottom(:,3),R2_B_EX_bottom(:,4),R3_B_EX_bottom(:,4)];%�°˵�


% �����ȵ�����/��������/������ 6*3 double
COG = BODY_FOR_CALU.Body(28:42);
BODY_FOR_MOVE.COG = [COG(1:5), COG(6:10),COG(11:15)];
BODY_FOR_MOVE.COG(6,:) = BODY_FOR_MOVE.COG(5,:);
BODY_FOR_MOVE.COG(5,:) = [BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10) BODY_FOR_CALU.Body(15)];

% �����Ⱥ�����������ռ��
BODY_FOR_MOVE.MassRatio = BODY_FOR_CALU.MassRatio;

%Ϊ�켣���Ʒ������
BODY_FOR_MOVE.PreStep=[];

%% ��ʼ�� BODY_FOR_SHOW

set(gcf,'units','centimeters','position',[2,2,38,18]); % figure������״[����Ļ���½Ǿ��� ���Ϳ�]
% BODY_FOR_SHOW.SubFigure.Robot = subplot('Position',[0.04 0.12 0.45 0.8]); % ����figure�������½ǵľ��루�ٷֱȣ���������ֵͬ��
% % SubFigure.Robot�Ǵ��ڵ����ƣ�Robot��ͼ����ֱ�ߵȵȵ�����
% title('Robot');
% hold on
% axis([-2000,5000,-5000,2000]); %axis([-3000,4000,-5000,2000]); % [xmin xmax ymin ymax]
% for i = 1:length(Gap)
%     if Gap(i).Height(2) > 0
%         rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.86 0.86 0.86],'EdgeColor',[0.86 0.86 0.86]); % �ϰ��RGB��Ⱦ��ǻ�ɫ
%     else
%         rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.7 0.7 0.7],'EdgeColor',[0.7 0.7 0.7]); % �ϰ��RGB��Ⱦ��ǻ�ɫ
%     end
%     
% end
% scatter(target(:,1),target(:,2),50,'filled');
% hold off

% �ڶ���ͼ��3Dͼ
% BODY_FOR_SHOW.SubFigure.threeD = subplot('Position',[0.54 0.12 0.45 0.8]);
% BODY_FOR_SHOW.SubFigure.threeD = plot('Position',[0.54 0.12 0.45 0.8]);
title('3-D of robot');
axis equal
% axis([-1100,4000,-2000,2000,0,1000]); 
% axis([-800,1500,-1200,1200,0,1000]); 
% axis([-800,2000,-1200,1200,0,1000]); 
axis([-800,3000,-1200,1200,-500,1000]); 
%axis([-3000,4000,-5000,2000,0,1500]); % [xmin xmax ymin ymax zmin zmax]
xlabel('x (mm)')
ylabel('y (mm)')
zlabel('z (mm)')
% scrsz = get(0,'ScreenSize'); 
% set(gcf,'Position',scrsz);
set(gca,'FontName','Times New Roman','FontSize',15);
view([0 -3 1]);
hold on
N = 2;
scatter3(Obstacle_Point(1,:),Obstacle_Point(2,:), Obstacle_Point(3,:), 10,[1,0.89,0.7],'filled'); % ����ͶӰ��
% [X,Y] = meshgrid(linspace(-2000,6500,N),linspace(-5000,2000,N)); %[X,Y] = meshgrid(linspace(-3000,4000,N),linspace(-5000,2000,N));
% Z = zeros(N);
% C = 0.86*ones(N,N,3);
% surf(X,Y,Z,C); % �Ȼ�ƽ��

% for i = 1:length(Gap)
%     % ֻ���ϰ���Ż������壬����ֻ����Ӱ
%     if Gap(i).Height(2) > 0
%         % PLOTCUBE(EDGES,ORIGIN,ALPHA,COLOR) displays a 3D-cube in the current axes
%         plotcube([Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2) Gap(i).Height(2)],...
%             [Gap(i).RectangleInitial(1) Gap(i).RectangleInitial(2) Gap(i).Height(1)],1,[0.86 0.86 0.86],[0.5 0.5 0.5]);
%     else
%         rectangle('Position',[Gap(i).RectangleInitial Gap(i).RectangleLengthWidth],'FaceColor',[0.5 0.5 0.5],'EdgeColor',[0.5 0.5 0.5]); % �ϰ��RGB��Ⱦ��ǻ�ɫ
%     end
% end

hold off
[~] = Aminate_ShowBody(5,0,BODY_PARA,WS_Data); % ��û��ʼ�˶�ǰ���ȳ���ʼ״̬��ͼ


end