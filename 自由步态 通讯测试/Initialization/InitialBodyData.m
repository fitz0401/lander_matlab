% InitialData����ʼ�����������ݶ�������ݣ���ʼ�� CALU MOVE SHOW
% ���룺Gap���ϰ��,End_Pos����ֹ�㣩
% �������ֱ���������ȫ�ֱ����ĸ�ֵ

function [BODY_FOR_CALU] = InitialBodyData(BODY_FOR_CALU,BODY_PARA)
%% ��ʼ�� BODY_FOR_CALU
% �ȶ�ԣ��
BODY_FOR_CALU.SM = 15;
%���ò���������
BODY_FOR_CALU.NUM_Step=1;
% ����������ȵ�ռ������
BODY_FOR_CALU.MassRatio = [0.05; 0.05; 0.05; 0.05; 0.8];
% ��txt�ж�ȡ������󣬶�body��ǰ27�и�ֵ
matfromTXT = dlmread('initialPoints.txt');%ǰ����Ϊ�ĸ���˵�ĳ�ʼλ�ã�������Ϊ�������ĵ��ʼλ�ã�������Ϊ������������ƽ���λ��
% matfromTXT
% �����������޸������ʼ��ĳ���initialPoints�д洢������½λ���µ����λ�ã�deltaZ��ʾ��˴���½λ����Z�����½��ĸ߶ȣ�deltaXY��ʾ��XY�������Ƶľ���
deltaZ=0;
% deltaXY=8;
deltaXY=0;
matfromTXT(5:9,3)=matfromTXT(5:9,3)-deltaZ;
matfromTXT(1:2,1)=matfromTXT(1:2,1)+deltaXY;
matfromTXT(3:4,1)=matfromTXT(3:4,1)-deltaXY;
matfromTXT(1,2)=matfromTXT(1,2)-deltaXY;
matfromTXT(4,2)=matfromTXT(4,2)-deltaXY;
matfromTXT(2:3,2)=matfromTXT(2:3,2)+deltaXY;

BODY_FOR_CALU.Body = [matfromTXT(1:5,1); matfromTXT(1:5,2); matfromTXT(1:5,3); 
    matfromTXT(6:9,1); matfromTXT(6:9,2); matfromTXT(6:9,3)];
% ��COG��ֵ����body��28-42�и�ֵ
COG1 = (BODY_FOR_CALU.Body(1:4) + BODY_FOR_CALU.Body(16:19))/2; % �����ȵ����ĵ��x���꣬Ĭ�����ȵ��е�
COG3 = (BODY_FOR_CALU.Body(6:9) + BODY_FOR_CALU.Body(20:23))/2; % �����ȵ����ĵ��y���꣬Ĭ�����ȵ��е�
COG5 = (BODY_FOR_CALU.Body(11:14) + BODY_FOR_CALU.Body(24:27))/2; % �����ȵ����ĵ��y���꣬Ĭ�����ȵ��е�
COG2 = sum([COG1; BODY_FOR_CALU.Body(5)] .* BODY_FOR_CALU.MassRatio);
COG4 = sum([COG3; BODY_FOR_CALU.Body(10)] .* BODY_FOR_CALU.MassRatio);
COG6 = sum([COG5; BODY_FOR_CALU.Body(15)] .* BODY_FOR_CALU.MassRatio);
COG = [COG1;COG2;COG3;COG4;COG5;COG6];
BODY_FOR_CALU.Body = [BODY_FOR_CALU.Body; COG];
% �����ȵĹ����ռ�
% ���ȵĹ����ռ䣬��ʼ����Ϊ(0,0)�㣬֮�󲻹���ô�˶������ĸ��������ȵ�ǰ������Ϊx��
% Ҳ����(x,y)�����겻������ת
BODY_FOR_CALU = LoadWorkspace(BODY_FOR_CALU);
% ����Ĺ����ռ���ȫ���������
BODY_FOR_CALU = UpdateBodySpace(BODY_FOR_CALU); % 5 ��������
% ��ˣ������ռ����ʼ��ƽ����ǰ������
% ��ʹ����ת��Ҳ����һС����ǰ������

% Body��Body����Ϊ42*n*m*p����Body0��Ϊ�˳�ʼ����Body��Ϊ�˼��㲽̬
BODY_FOR_CALU.Body0 = BODY_FOR_CALU.Body;
% �����ʼʱ�̹��������ռ�Ĵ�С����ֵ��������
BODY_FOR_CALU.interSpace = zeros(4,2);
% �����ʼʱ�����嶥������˵��λ��
BODY_FOR_CALU.IdealLegLength = [BODY_FOR_CALU.Body(16:19) BODY_FOR_CALU.Body(20:23) BODY_FOR_CALU.Body(24:27)]...
    - [BODY_FOR_CALU.Body(1:4) BODY_FOR_CALU.Body(6:9) BODY_FOR_CALU.Body(11:14)];

% BODY_FOR_CALU.TraceData(1,:)=[BODY_FOR_CALU.Body(1),BODY_FOR_CALU.Body(6),BODY_FOR_CALU.Body(11),BODY_FOR_CALU.Body(2),BODY_FOR_CALU.Body(7),BODY_FOR_CALU.Body(12),...
%     BODY_FOR_CALU.Body(3),BODY_FOR_CALU.Body(8),BODY_FOR_CALU.Body(13),BODY_FOR_CALU.Body(4),BODY_FOR_CALU.Body(9),BODY_FOR_CALU.Body(14),...
%     BODY_FOR_CALU.Body(5),BODY_FOR_CALU.Body(10),BODY_FOR_CALU.Body(15)];
%�����ʼ����͵���λ�˱任����
d=BODY_PARA.Link_D;
h=BODY_PARA.Link_H;
b3=BODY_PARA.Link_B(3);
theta_in=BODY_PARA.Angle(1);
C_B(:,1)=[d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];  C_B(:,2)=[d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];
C_B(:,3)=[-d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C]; C_B(:,4)=[-d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];  % ��ʾC�����B
% C_B(:,1)=[d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];  C_B(:,2)=[-d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];
% C_B(:,3)=[-d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)]; C_B(:,4)=[d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];  % ��ʾC�����B
for j=1:4
    
%     RCB(:,:,j)=[cos(pi/4+(j-1)*pi/2)  -sin(pi/4+(j-1)*pi/2)  0 ;
%         sin(pi/4+(j-1)*pi/2)   cos(pi/4+(j-1)*pi/2)  0 ;
%         0                     0                 1];
    RCB(:,:,j)=[cos(pi/4+(j-2)*pi/2)  -sin(pi/4+(j-2)*pi/2)  0 ;
        sin(pi/4+(j-2)*pi/2)   cos(pi/4+(j-2)*pi/2)  0 ;
        0                     0                 1];
    BODY_FOR_CALU.TCB(:,:,j)=[RCB(:,:,j)  C_B(:,j);0 0 0 1];%�ӵ��Ⱦ�����ϵ����������ϵ�ı任
end
%�����ʼ��������ϵ�ͻ�������ϵ�任����
BODY_FOR_CALU.TBG=[eye(3),[0;0;BODY_FOR_CALU.Body(15)];0 0 0 1];
%��ʼ�������߿򴢴����

for j=1:4
    R2_C(:,j) = [0; -BODY_PARA.Link_A(3); -BODY_PARA.Link_B(3)*cos(BODY_PARA.Angle(1))];
    R3_C(:,j) = [0;  BODY_PARA.Link_A(3); -BODY_PARA.Link_B(3)*cos(BODY_PARA.Angle(1))];
    R2_C_EX_bottom(:,j) = [R2_C(1,j);1.7*R2_C(2,j);-BODY_PARA.Link_C];
    R3_C_EX_bottom(:,j) = [R3_C(1,j);1.7*R3_C(2,j);-BODY_PARA.Link_C];
    
    aaa = BODY_FOR_CALU.TCB(:,:,j)*[R2_C_EX_bottom(:,j);1];     R2_B_EX_bottom(:,j) = aaa;
    aaa = BODY_FOR_CALU.TCB(:,:,j)*[R3_C_EX_bottom(:,j);1];     R3_B_EX_bottom(:,j) = aaa;
    R2_B_EX_up(:,j) = [R2_B_EX_bottom(1,j),R2_B_EX_bottom(2,j),-R2_B_EX_bottom(3,j),1];
    R3_B_EX_up(:,j) = [R3_B_EX_bottom(1,j),R3_B_EX_bottom(2,j),-R3_B_EX_bottom(3,j),1];
    
    %���ﴢ�����16������������ڻ�������ϵ������������ں��������ͼʱӦ����TBG
    
    Foot_tem=[BODY_FOR_CALU.Body(j),BODY_FOR_CALU.Body(j+5),BODY_FOR_CALU.Body(j+10),1].';
    Foot_tem=inv(BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,j))*Foot_tem;
    BODY_FOR_CALU.TraceData(1,3*(j-1)+1:3*j)=[Foot_tem(1),Foot_tem(2),Foot_tem(3)];
end

BODY_FOR_CALU.Body_line(:,:,1)=[R2_B_EX_up(:,1),R3_B_EX_up(:,1),R2_B_EX_up(:,2),R3_B_EX_up(:,2),R2_B_EX_up(:,3),R3_B_EX_up(:,3),R2_B_EX_up(:,4),R3_B_EX_up(:,4)];%�ϰ˵�
BODY_FOR_CALU.Body_line(:,:,2)=[R2_B_EX_bottom(:,1),R3_B_EX_bottom(:,1),R2_B_EX_bottom(:,2),R3_B_EX_bottom(:,2),R2_B_EX_bottom(:,3),R3_B_EX_bottom(:,3),R2_B_EX_bottom(:,4),R3_B_EX_bottom(:,4)];%�°˵�


end