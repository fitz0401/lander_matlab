% Aminate_ShowBody:�����������ʱ�̵�Bodyͼ��
% ��������̧�Ľţ�char�������ñ������Ĵ�����times����������ñ������Ĵ�����times������������һʱ�̵��˶�ͼ��

function times = Aminate_ShowBody(Foot, times ,BODY_PARA ,WS_Data)

if nargin == 0  %nargin��ʾ������������ĺ�����û������ʱ��ʱΪ�����˶�
    Foot = 5;
    times = 0;
end
times = times + 1; % ���ô���

global BODY_FOR_MOVE
%global ReLML
global BODY_FOR_SHOW
% ��BODY_FOR_SHOW �������ֻ������Ӻ����ﷴ�����ã��ܷ���ȫ�ֱ�������
% ��BODY_FOR_SHOW ��û�б�����ֻ����ͼ�񣬾���Ϊ�˷���delete��һ����ͼ��

% ÿ�ε���ǰ��ɾȥ��һ����ͼ�������ܱ������һ����ͼ��
if isfield(BODY_FOR_SHOW, 'threeD')
%     delete([BODY_FOR_SHOW.Robot.Body BODY_FOR_SHOW.Robot.legA BODY_FOR_SHOW.Robot.legB BODY_FOR_SHOW.Robot.legC...
%         BODY_FOR_SHOW.Robot.legD BODY_FOR_SHOW.Robot.COG BODY_FOR_SHOW.Robot.lineAC BODY_FOR_SHOW.Robot.lineBD...
%         BODY_FOR_SHOW.Robot.lineAB BODY_FOR_SHOW.Robot.lineBC BODY_FOR_SHOW.Robot.lineCD BODY_FOR_SHOW.Robot.lineAD]);
    delete([BODY_FOR_SHOW.threeD.Body;BODY_FOR_SHOW.threeD.leg1;BODY_FOR_SHOW.threeD.leg2;BODY_FOR_SHOW.threeD.leg3;...
        BODY_FOR_SHOW.threeD.leg4;BODY_FOR_SHOW.threeD.COG;BODY_FOR_SHOW.threeD.lineAC;BODY_FOR_SHOW.threeD.lineBD;...
        BODY_FOR_SHOW.threeD.lineAB;BODY_FOR_SHOW.threeD.lineBC;BODY_FOR_SHOW.threeD.lineCD;BODY_FOR_SHOW.threeD.lineAD]);
    delete(BODY_FOR_SHOW.threeD.WS);
end

% ����άͼ
% subplot(BODY_FOR_SHOW.SubFigure.Robot);
% hold on%��ABCD��ʱ��ֲ���AΪ���½���
% BODY_FOR_SHOW.Robot.Body = plot([BODY_FOR_MOVE.BodyApex(:,1)' BODY_FOR_MOVE.BodyApex(1,1)], [BODY_FOR_MOVE.BodyApex(:,2)',BODY_FOR_MOVE.BodyApex(1,2)],'Color','black'); % ����
% BODY_FOR_SHOW.Robot.legA = plot([BODY_FOR_MOVE.BodyApex(1,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.BodyApex(1,2) BODY_FOR_MOVE.Foot(1,2)],'Color','black'); % ��A
% BODY_FOR_SHOW.Robot.legB = plot([BODY_FOR_MOVE.BodyApex(2,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.BodyApex(2,2) BODY_FOR_MOVE.Foot(2,2)],'Color','black'); % ��B
% BODY_FOR_SHOW.Robot.legC = plot([BODY_FOR_MOVE.BodyApex(3,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.BodyApex(3,2) BODY_FOR_MOVE.Foot(3,2)],'Color','black'); % ��C
% BODY_FOR_SHOW.Robot.legD = plot([BODY_FOR_MOVE.BodyApex(4,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.BodyApex(4,2) BODY_FOR_MOVE.Foot(4,2)],'Color','black'); % ��D
% BODY_FOR_SHOW.Robot.COG = scatter(BODY_FOR_MOVE.COG(6,1),BODY_FOR_MOVE.COG(6,2),50,'blue','filled'); % ����ͶӰ��
% BODY_FOR_SHOW.Robot.linePointForCOG(times,1) = BODY_FOR_MOVE.COG(6,1);
% BODY_FOR_SHOW.Robot.linePointForCOG(times,2) = BODY_FOR_MOVE.COG(6,2); % Ϊ�˻�COG��������
% 
% if times ~= 1
%     BODY_FOR_SHOW.Robot.lineForCOG(times) = plot([BODY_FOR_SHOW.Robot.linePointForCOG(times-1,1),BODY_FOR_SHOW.Robot.linePointForCOG(times,1)],...
%         [BODY_FOR_SHOW.Robot.linePointForCOG(times-1,2),BODY_FOR_SHOW.Robot.linePointForCOG(times,2)],'Color','black','linewidth',2); % Ϊ�˻�COG��������
% else
%     [row,~] = size(BODY_FOR_SHOW.Robot.linePointForCOG);
%     if row > 1
%         BODY_FOR_SHOW.Robot.lineForCOG(times) = plot([BODY_FOR_SHOW.Robot.linePointForCOG(row,1),BODY_FOR_SHOW.Robot.linePointForCOG(times,1)],...
%             [BODY_FOR_SHOW.Robot.linePointForCOG(row,2),BODY_FOR_SHOW.Robot.linePointForCOG(times,2)],'Color','black','linewidth',2); % Ϊ�˻�COG��������
%     end
% end
% 
% switch Foot
%     case 1 % ��BD BC CD
%         BODY_FOR_SHOW.Robot.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
%         BODY_FOR_SHOW.Robot.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BD�Խ���
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC�Խ���
%         BODY_FOR_SHOW.Robot.lineAB = 0; BODY_FOR_SHOW.Robot.lineAD = 0;
%     case 2 % ��AC AD CD
%         BODY_FOR_SHOW.Robot.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
%         BODY_FOR_SHOW.Robot.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AC�Խ���
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD�Խ���
%         BODY_FOR_SHOW.Robot.lineAB = 0; BODY_FOR_SHOW.Robot.lineBC = 0;
%     case 3 % ��AB AD BD
%         BODY_FOR_SHOW.Robot.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
%         BODY_FOR_SHOW.Robot.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BD�Խ���
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC�Խ���
%         BODY_FOR_SHOW.Robot.lineBC = 0; BODY_FOR_SHOW.Robot.lineCD = 0;
%     case 4 % ��AB BC AC
%         BODY_FOR_SHOW.Robot.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
%         BODY_FOR_SHOW.Robot.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AC�Խ���
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD�Խ���
%         BODY_FOR_SHOW.Robot.lineCD = 0; BODY_FOR_SHOW.Robot.lineAD = 0;
%     case 5 % ��AB BC CD AD
%         BODY_FOR_SHOW.Robot.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
%         BODY_FOR_SHOW.Robot.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
%         BODY_FOR_SHOW.Robot.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
%         BODY_FOR_SHOW.Robot.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
%         BODY_FOR_SHOW.Robot.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD�Խ���
%         BODY_FOR_SHOW.Robot.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC�Խ���
%     otherwise
%         error('Cannot show robot in such case.');
% end
% 
% % pause(0.1); % ��ͣ0.1s
% hold off

%% ��3Dͼ
% subplot(BODY_FOR_SHOW.SubFigure.threeD);
hold on
% BODY_FOR_SHOW.threeD.Body = plot3([BODY_FOR_MOVE.BodyApex(:,1)' BODY_FOR_MOVE.BodyApex(1,1)], [BODY_FOR_MOVE.BodyApex(:,2)',BODY_FOR_MOVE.BodyApex(1,2)], ...
%     [BODY_FOR_MOVE.BodyApex(:,3)',BODY_FOR_MOVE.BodyApex(1,3)], 'Color','black'); % ����
%����������
BODY_FOR_SHOW.threeD.Body = plot3(BODY_FOR_MOVE.BodyApex2(:,:,1),BODY_FOR_MOVE.BodyApex2(:,:,2),BODY_FOR_MOVE.BodyApex2(:,:,3), 'Color','black'); % ����


%����4����
for j=1:4 
    specified_footpad_j=inv(BODY_FOR_MOVE.TCjG(:,:,j))*[BODY_FOR_MOVE.Foot(j,:),1].';
    [LEGfigure,FOOTfigure,TransMechfigure,Dr_PARA] = plot3D_jthWalkLegExeMechDeleWS(j,BODY_FOR_MOVE.TCjG(:,:,j),specified_footpad_j,BODY_PARA);
    BODY_FOR_SHOW.threeD.WS(j)=scatter3(WS_Data(1,:,j),WS_Data(2,:,j),WS_Data(3,:,j),10,BODY_FOR_MOVE.M_RGB(1:BODY_FOR_MOVE.ntotal,:),'filled');
    eval(['BODY_FOR_SHOW.threeD.leg' num2str(j) '=[LEGfigure;FOOTfigure;TransMechfigure];']);
    
end
    
% BODY_FOR_SHOW.threeD.legA = plot3([BODY_FOR_MOVE.BodyApex(1,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.BodyApex(1,2) BODY_FOR_MOVE.Foot(1,2)], ...
%     [BODY_FOR_MOVE.BodyApex(1,3) BODY_FOR_MOVE.Foot(1,3)], 'Color','black'); % ��A
% BODY_FOR_SHOW.threeD.legB = plot3([BODY_FOR_MOVE.BodyApex(2,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.BodyApex(2,2) BODY_FOR_MOVE.Foot(2,2)], ...
%     [BODY_FOR_MOVE.BodyApex(2,3) BODY_FOR_MOVE.Foot(2,3)], 'Color','black'); % ��B
% BODY_FOR_SHOW.threeD.legC = plot3([BODY_FOR_MOVE.BodyApex(3,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.BodyApex(3,2) BODY_FOR_MOVE.Foot(3,2)], ...
%     [BODY_FOR_MOVE.BodyApex(3,3) BODY_FOR_MOVE.Foot(3,3)], 'Color','black'); % ��C
% BODY_FOR_SHOW.threeD.legD = plot3([BODY_FOR_MOVE.BodyApex(4,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.BodyApex(4,2) BODY_FOR_MOVE.Foot(4,2)], ...
%     [BODY_FOR_MOVE.BodyApex(4,3) BODY_FOR_MOVE.Foot(4,3)],'Color','black'); % ��D

%��������ͶӰ������Ĺ켣
BODY_FOR_SHOW.threeD.COG = scatter3(BODY_FOR_MOVE.COG(6,1), BODY_FOR_MOVE.COG(6,2), BODY_FOR_MOVE.COG(6,3), 50,'blue','filled'); % ����ͶӰ��
BODY_FOR_SHOW.threeD.linePointForCOG(times,1) = BODY_FOR_MOVE.COG(6,1);
BODY_FOR_SHOW.threeD.linePointForCOG(times,2) = BODY_FOR_MOVE.COG(6,2); % Ϊ�˻�COG��������
BODY_FOR_SHOW.threeD.linePointForCOG(times,3) = BODY_FOR_MOVE.COG(6,3);
%���ƹ켣
if Foot~=5
    plot3([BODY_FOR_MOVE.PreStep(Foot,1),BODY_FOR_MOVE.Foot(Foot,1)], ...
        [BODY_FOR_MOVE.PreStep(Foot,2),BODY_FOR_MOVE.Foot(Foot,2)], ...
        [BODY_FOR_MOVE.PreStep(Foot,3),BODY_FOR_MOVE.Foot(Foot,3)], ...
        'Color','black','linewidth',2); % Ϊ�˻�COG��������
end


if times ~= 1
    BODY_FOR_SHOW.threeD.lineForCOG(times) = plot3([BODY_FOR_SHOW.threeD.linePointForCOG(times-1,1),BODY_FOR_SHOW.threeD.linePointForCOG(times,1)], ...
        [BODY_FOR_SHOW.threeD.linePointForCOG(times-1,2),BODY_FOR_SHOW.threeD.linePointForCOG(times,2)], ...
        [BODY_FOR_SHOW.threeD.linePointForCOG(times-1,3),BODY_FOR_SHOW.threeD.linePointForCOG(times,3)], ...
        'Color','black','linewidth',2); % Ϊ�˻�COG��������
else
    [row,~] = size(BODY_FOR_SHOW.threeD.linePointForCOG);
    if row > 1
        BODY_FOR_SHOW.threeD.lineForCOG(times) = plot3([BODY_FOR_SHOW.threeD.linePointForCOG(row,1),BODY_FOR_SHOW.threeD.linePointForCOG(times,1)], ...
            [BODY_FOR_SHOW.threeD.linePointForCOG(row,2),BODY_FOR_SHOW.threeD.linePointForCOG(times,2)], ...
            [BODY_FOR_SHOW.threeD.linePointForCOG(row,3),BODY_FOR_SHOW.threeD.linePointForCOG(times,3)], ...
            'Color','black','linewidth',2); % Ϊ�˻�COG��������
    end
end

switch Foot
    case 1 % ��BD BC CD
        BODY_FOR_SHOW.threeD.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
        BODY_FOR_SHOW.threeD.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BD�Խ���
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC�Խ���
        BODY_FOR_SHOW.threeD.lineAB = 0; BODY_FOR_SHOW.threeD.lineAD = 0;
    case 2 % ��AC AD CD
        BODY_FOR_SHOW.threeD.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
        BODY_FOR_SHOW.threeD.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AC�Խ���
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD�Խ���
        BODY_FOR_SHOW.threeD.lineAB = 0; BODY_FOR_SHOW.threeD.lineBC = 0;
    case 3 % ��AB AD BD
        BODY_FOR_SHOW.threeD.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
        BODY_FOR_SHOW.threeD.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BD�Խ���
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC�Խ���
        BODY_FOR_SHOW.threeD.lineBC = 0; BODY_FOR_SHOW.threeD.lineCD = 0;
    case 4 % ��AB BC AC
        BODY_FOR_SHOW.threeD.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
        BODY_FOR_SHOW.threeD.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AC�Խ���
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD�Խ���
        BODY_FOR_SHOW.threeD.lineCD = 0; BODY_FOR_SHOW.threeD.lineAD = 0;
    case 5 % ��AB BC CD AD
        BODY_FOR_SHOW.threeD.lineBC = plot([BODY_FOR_MOVE.Foot(2,1) BODY_FOR_MOVE.Foot(3,1)],[BODY_FOR_MOVE.Foot(2,2) BODY_FOR_MOVE.Foot(3,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % BC
        BODY_FOR_SHOW.threeD.lineAB = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(2,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AB
        BODY_FOR_SHOW.threeD.lineAD = plot([BODY_FOR_MOVE.Foot(1,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(1,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % AD
        BODY_FOR_SHOW.threeD.lineCD = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(4,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(4,2)],'Color','red','LineWidth',1,'LineStyle','- -'); % CD
        BODY_FOR_SHOW.threeD.lineBD = plot([BODY_FOR_MOVE.Foot(4,1) BODY_FOR_MOVE.Foot(2,1)],[BODY_FOR_MOVE.Foot(4,2) BODY_FOR_MOVE.Foot(2,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % BD�Խ���
        BODY_FOR_SHOW.threeD.lineAC = plot([BODY_FOR_MOVE.Foot(3,1) BODY_FOR_MOVE.Foot(1,1)],[BODY_FOR_MOVE.Foot(3,2) BODY_FOR_MOVE.Foot(1,2)],'Color','magenta','LineWidth',1,'LineStyle','- -'); % AC�Խ���
    otherwise
        error('Cannot show robot in such case.');
end
%frame = getframe;            %// ��ͼ�������Ƶ�ļ���
%writeVideo(ReLML,frame); %// ��֡д����Ƶ
% pause(0.1); % ��ͣ0.1s
hold off
end
