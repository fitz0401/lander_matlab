% Aminate_ShowBody:画出现在这个时刻的Body图像
% 输入现在抬的脚（char），调用本函数的次数（times），输出调用本函数的次数（times），并画出这一时刻的运动图像

function times = Aminate_ShowBody(Foot, times ,BODY_PARA ,WS_Data)

if nargin == 0  %nargin表示输入变量个数的函数，没有输入时此时为身体运动
    Foot = 5;
    times = 0;
end
times = times + 1; % 调用次数

global BODY_FOR_MOVE
%global ReLML
global BODY_FOR_SHOW
% 【BODY_FOR_SHOW 这个变量只在这个子函数里反复调用，能否不用全局变量？】
% 【BODY_FOR_SHOW 里没有变量，只储存图像，就是为了方便delete上一步的图像】

% 每次调用前，删去上一步的图像，这样能保留最后一步的图像
if isfield(BODY_FOR_SHOW, 'threeD')
%     delete([BODY_FOR_SHOW.Robot.Body BODY_FOR_SHOW.Robot.legA BODY_FOR_SHOW.Robot.legB BODY_FOR_SHOW.Robot.legC...
%         BODY_FOR_SHOW.Robot.legD BODY_FOR_SHOW.Robot.COG BODY_FOR_SHOW.Robot.lineAC BODY_FOR_SHOW.Robot.lineBD...
%         BODY_FOR_SHOW.Robot.lineAB BODY_FOR_SHOW.Robot.lineBC BODY_FOR_SHOW.Robot.lineCD BODY_FOR_SHOW.Robot.lineAD]);
    delete([BODY_FOR_SHOW.threeD.Body;BODY_FOR_SHOW.threeD.leg1;BODY_FOR_SHOW.threeD.leg2;BODY_FOR_SHOW.threeD.leg3;...
        BODY_FOR_SHOW.threeD.leg4;BODY_FOR_SHOW.threeD.COG;BODY_FOR_SHOW.threeD.lineAC;BODY_FOR_SHOW.threeD.lineBD;...
        BODY_FOR_SHOW.threeD.lineAB;BODY_FOR_SHOW.threeD.lineBC;BODY_FOR_SHOW.threeD.lineCD;BODY_FOR_SHOW.threeD.lineAD]);
    delete(BODY_FOR_SHOW.threeD.WS);
end

% 画二维图
% subplot(BODY_FOR_SHOW.SubFigure.Robot);
% hold on%腿ABCD逆时针分布，A为右下角腿
% BODY_FOR_SHOW.Robot.Body = plot([BODY_FOR_MOVE.BodyApex(:,1)' BODY_FOR_MOVE.BodyApex(1,1)], [BODY_FOR_MOVE.BodyApex(:,2)',BODY_FOR_MOVE.BodyApex(1,2)],'Color','black'); % 身体
% BODY_FOR_SHOW.Robot.legA = plot([BODY_FOR_MOVE.BodyApex(1,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.BodyApex(1,2) BODY_FOR_MOVE.Foot(1,2)],'Color','black'); % 腿A
% BODY_FOR_SHOW.Robot.legB = plot([BODY_FOR_MOVE.BodyApex(2,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.BodyApex(2,2) BODY_FOR_MOVE.Foot(2,2)],'Color','black'); % 腿B
% BODY_FOR_SHOW.Robot.legC = plot([BODY_FOR_MOVE.BodyApex(3,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.BodyApex(3,2) BODY_FOR_MOVE.Foot(3,2)],'Color','black'); % 腿C
% BODY_FOR_SHOW.Robot.legD = plot([BODY_FOR_MOVE.BodyApex(4,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.BodyApex(4,2) BODY_FOR_MOVE.Foot(4,2)],'Color','black'); % 腿D
% BODY_FOR_SHOW.Robot.COG = scatter(BODY_FOR_MOVE.COG(6,1),BODY_FOR_MOVE.COG(6,2),50,'blue','filled'); % 重心投影点
% BODY_FOR_SHOW.Robot.linePointForCOG(times,1) = BODY_FOR_MOVE.COG(6,1);
% BODY_FOR_SHOW.Robot.linePointForCOG(times,2) = BODY_FOR_MOVE.COG(6,2); % 为了划COG经过的线
% 
% if times ~= 1
%     BODY_FOR_SHOW.Robot.lineForCOG(times) = plot([BODY_FOR_SHOW.Robot.linePointForCOG(times-1,1),BODY_FOR_SHOW.Robot.linePointForCOG(times,1)],...
%         [BODY_FOR_SHOW.Robot.linePointForCOG(times-1,2),BODY_FOR_SHOW.Robot.linePointForCOG(times,2)],'Color','black','linewidth',2); % 为了划COG经过的线
% else
%     [row,~] = size(BODY_FOR_SHOW.Robot.linePointForCOG);
%     if row > 1
%         BODY_FOR_SHOW.Robot.lineForCOG(times) = plot([BODY_FOR_SHOW.Robot.linePointForCOG(row,1),BODY_FOR_SHOW.Robot.linePointForCOG(times,1)],...
%             [BODY_FOR_SHOW.Robot.linePointForCOG(row,2),BODY_FOR_SHOW.Robot.linePointForCOG(times,2)],'Color','black','linewidth',2); % 为了划COG经过的线
%     end
% end
% 
% switch Foot
%     case 1 % 画BD BC CD
%         BODY_FOR_SHOW.Robot.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
%         BODY_FOR_SHOW.Robot.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BD对角线
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC对角线
%         BODY_FOR_SHOW.Robot.lineAB = 0; BODY_FOR_SHOW.Robot.lineAD = 0;
%     case 2 % 画AC AD CD
%         BODY_FOR_SHOW.Robot.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
%         BODY_FOR_SHOW.Robot.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AC对角线
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD对角线
%         BODY_FOR_SHOW.Robot.lineAB = 0; BODY_FOR_SHOW.Robot.lineBC = 0;
%     case 3 % 画AB AD BD
%         BODY_FOR_SHOW.Robot.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
%         BODY_FOR_SHOW.Robot.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BD对角线
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC对角线
%         BODY_FOR_SHOW.Robot.lineBC = 0; BODY_FOR_SHOW.Robot.lineCD = 0;
%     case 4 % 画AB BC AC
%         BODY_FOR_SHOW.Robot.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
%         BODY_FOR_SHOW.Robot.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AC对角线
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD对角线
%         BODY_FOR_SHOW.Robot.lineCD = 0; BODY_FOR_SHOW.Robot.lineAD = 0;
%     case 5 % 画AB BC CD AD
%         BODY_FOR_SHOW.Robot.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
%         BODY_FOR_SHOW.Robot.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
%         BODY_FOR_SHOW.Robot.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
%         BODY_FOR_SHOW.Robot.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD对角线
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC对角线
%     otherwise
%         error('Cannot show robot in such case.');
% end
% 
% % pause(0.1); % 暂停0.1s
% hold off

%% 画3D图
% subplot(BODY_FOR_SHOW.SubFigure.threeD);
hold on
% BODY_FOR_SHOW.threeD.Body = plot3([BODY_FOR_MOVE.BodyApex(:,1)' BODY_FOR_MOVE.BodyApex(1,1)], [BODY_FOR_MOVE.BodyApex(:,2)',BODY_FOR_MOVE.BodyApex(1,2)], ...
%     [BODY_FOR_MOVE.BodyApex(:,3)',BODY_FOR_MOVE.BodyApex(1,3)], 'Color','black'); % 身体
%绘制身体框架
BODY_FOR_SHOW.threeD.Body = plot3(BODY_FOR_MOVE.BodyApex2(:,:,1),BODY_FOR_MOVE.BodyApex2(:,:,2),BODY_FOR_MOVE.BodyApex2(:,:,3), 'Color','black'); % 身体


%绘制4条腿
for j=1:4 
    specified_footpad_j=inv(BODY_FOR_MOVE.TCjG(:,:,j))*[BODY_FOR_MOVE.Foot(j,:),1].';
    [LEGfigure,FOOTfigure,TransMechfigure,Dr_PARA] = plot3D_jthWalkLegExeMechDeleWS(j,BODY_FOR_MOVE.TCjG(:,:,j),specified_footpad_j,BODY_PARA);
    BODY_FOR_SHOW.threeD.WS(j)=scatter3(WS_Data(1,:,j),WS_Data(2,:,j),WS_Data(3,:,j),10,BODY_FOR_MOVE.M_RGB(1:BODY_FOR_MOVE.ntotal,:),'filled');
    eval(['BODY_FOR_SHOW.threeD.leg' num2str(j) '=[LEGfigure;FOOTfigure;TransMechfigure];']);
    
end
    
% BODY_FOR_SHOW.threeD.legA = plot3([BODY_FOR_MOVE.BodyApex(1,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.BodyApex(1,2) BODY_FOR_MOVE.Foot(1,2)], ...
%     [BODY_FOR_MOVE.BodyApex(1,3) BODY_FOR_MOVE.Foot(1,3)], 'Color','black'); % 腿A
% BODY_FOR_SHOW.threeD.legB = plot3([BODY_FOR_MOVE.BodyApex(2,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.BodyApex(2,2) BODY_FOR_MOVE.Foot(2,2)], ...
%     [BODY_FOR_MOVE.BodyApex(2,3) BODY_FOR_MOVE.Foot(2,3)], 'Color','black'); % 腿B
% BODY_FOR_SHOW.threeD.legC = plot3([BODY_FOR_MOVE.BodyApex(3,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.BodyApex(3,2) BODY_FOR_MOVE.Foot(3,2)], ...
%     [BODY_FOR_MOVE.BodyApex(3,3) BODY_FOR_MOVE.Foot(3,3)], 'Color','black'); % 腿C
% BODY_FOR_SHOW.threeD.legD = plot3([BODY_FOR_MOVE.BodyApex(4,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.BodyApex(4,2) BODY_FOR_MOVE.Foot(4,2)], ...
%     [BODY_FOR_MOVE.BodyApex(4,3) BODY_FOR_MOVE.Foot(4,3)],'Color','black'); % 腿D

%绘制重心投影点和重心轨迹
BODY_FOR_SHOW.threeD.COG = scatter3(BODY_FOR_MOVE.COG(6,1), BODY_FOR_MOVE.COG(6,2), BODY_FOR_MOVE.COG(6,3), 50,'blue','filled'); % 重心投影点
BODY_FOR_SHOW.threeD.linePointForCOG(times,1) = BODY_FOR_MOVE.COG(6,1);
BODY_FOR_SHOW.threeD.linePointForCOG(times,2) = BODY_FOR_MOVE.COG(6,2); % 为了画COG经过的线
BODY_FOR_SHOW.threeD.linePointForCOG(times,3) = BODY_FOR_MOVE.COG(6,3);
%绘制轨迹
if Foot~=5
    plot3([BODY_FOR_MOVE.PreStep(Foot,1),BODY_FOR_MOVE.Foot(Foot,1)], ...
        [BODY_FOR_MOVE.PreStep(Foot,2),BODY_FOR_MOVE.Foot(Foot,2)], ...
        [BODY_FOR_MOVE.PreStep(Foot,3),BODY_FOR_MOVE.Foot(Foot,3)], ...
        'Color','black','linewidth',2); % 为了划COG经过的线
end


if times ~= 1
    BODY_FOR_SHOW.threeD.lineForCOG(times) = plot3([BODY_FOR_SHOW.threeD.linePointForCOG(times-1,1),BODY_FOR_SHOW.threeD.linePointForCOG(times,1)], ...
        [BODY_FOR_SHOW.threeD.linePointForCOG(times-1,2),BODY_FOR_SHOW.threeD.linePointForCOG(times,2)], ...
        [BODY_FOR_SHOW.threeD.linePointForCOG(times-1,3),BODY_FOR_SHOW.threeD.linePointForCOG(times,3)], ...
        'Color','black','linewidth',2); % 为了划COG经过的线
else
    [row,~] = size(BODY_FOR_SHOW.threeD.linePointForCOG);
    if row > 1
        BODY_FOR_SHOW.threeD.lineForCOG(times) = plot3([BODY_FOR_SHOW.threeD.linePointForCOG(row,1),BODY_FOR_SHOW.threeD.linePointForCOG(times,1)], ...
            [BODY_FOR_SHOW.threeD.linePointForCOG(row,2),BODY_FOR_SHOW.threeD.linePointForCOG(times,2)], ...
            [BODY_FOR_SHOW.threeD.linePointForCOG(row,3),BODY_FOR_SHOW.threeD.linePointForCOG(times,3)], ...
            'Color','black','linewidth',2); % 为了划COG经过的线
    end
end

switch Foot
    case 1 % 画BD BC CD
        BODY_FOR_SHOW.threeD.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
        BODY_FOR_SHOW.threeD.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BD对角线
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC对角线
        BODY_FOR_SHOW.threeD.lineAB = 0; BODY_FOR_SHOW.threeD.lineAD = 0;
    case 2 % 画AC AD CD
        BODY_FOR_SHOW.threeD.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
        BODY_FOR_SHOW.threeD.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AC对角线
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD对角线
        BODY_FOR_SHOW.threeD.lineAB = 0; BODY_FOR_SHOW.threeD.lineBC = 0;
    case 3 % 画AB AD BD
        BODY_FOR_SHOW.threeD.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
        BODY_FOR_SHOW.threeD.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BD对角线
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC对角线
        BODY_FOR_SHOW.threeD.lineBC = 0; BODY_FOR_SHOW.threeD.lineCD = 0;
    case 4 % 画AB BC AC
        BODY_FOR_SHOW.threeD.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
        BODY_FOR_SHOW.threeD.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AC对角线
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD对角线
        BODY_FOR_SHOW.threeD.lineCD = 0; BODY_FOR_SHOW.threeD.lineAD = 0;
    case 5 % 画AB BC CD AD
        BODY_FOR_SHOW.threeD.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
        BODY_FOR_SHOW.threeD.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
        BODY_FOR_SHOW.threeD.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
        BODY_FOR_SHOW.threeD.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD对角线
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC对角线
    otherwise
        error('Cannot show robot in such case.');
end
%frame = getframe;            %// 把图像存入视频文件中
%writeVideo(ReLML,frame); %// 将帧写入视频
% pause(0.1); % 暂停0.1s
hold off
end
