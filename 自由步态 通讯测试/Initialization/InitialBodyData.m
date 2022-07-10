% InitialData：初始化参数，根据读入的数据，初始化 CALU MOVE SHOW
% 输入：Gap（障碍物）,End_Pos（终止点）
% 无输出，直接完成三个全局变量的赋值

function [BODY_FOR_CALU] = InitialBodyData(BODY_FOR_CALU,BODY_PARA)
%% 初始化 BODY_FOR_CALU
% 稳定裕度
BODY_FOR_CALU.SM = 15;
%重置步伐计数器
BODY_FOR_CALU.NUM_Step=1;
% 身体和四条腿的占比重量
BODY_FOR_CALU.MassRatio = [0.05; 0.05; 0.05; 0.05; 0.8];
% 从txt中读取身体矩阵，对body的前27行赋值
matfromTXT = dlmread('initialPoints.txt');%前四行为四个足端点的初始位置；第五行为机身质心点初始位置，后四行为机身质心所在平面的位置
% matfromTXT
% 在这里增加修改足端起始点的程序，initialPoints中存储的是着陆位型下的足端位置，deltaZ表示足端从着陆位型沿Z方向下降的高度，deltaXY表示沿XY方向外移的距离
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
% 对COG赋值，对body的28-42行赋值
COG1 = (BODY_FOR_CALU.Body(1:4) + BODY_FOR_CALU.Body(16:19))/2; % 四条腿的重心点的x坐标，默认在腿的中点
COG3 = (BODY_FOR_CALU.Body(6:9) + BODY_FOR_CALU.Body(20:23))/2; % 四条腿的重心点的y坐标，默认在腿的中点
COG5 = (BODY_FOR_CALU.Body(11:14) + BODY_FOR_CALU.Body(24:27))/2; % 四条腿的重心点的y坐标，默认在腿的中点
COG2 = sum([COG1; BODY_FOR_CALU.Body(5)] .* BODY_FOR_CALU.MassRatio);
COG4 = sum([COG3; BODY_FOR_CALU.Body(10)] .* BODY_FOR_CALU.MassRatio);
COG6 = sum([COG5; BODY_FOR_CALU.Body(15)] .* BODY_FOR_CALU.MassRatio);
COG = [COG1;COG2;COG3;COG4;COG5;COG6];
BODY_FOR_CALU.Body = [BODY_FOR_CALU.Body; COG];
% 导入腿的工作空间
% 四腿的工作空间，初始点作为(0,0)点，之后不管怎么运动，这四个矩阵都以腿的前进方向为x轴
% 也即，(x,y)的坐标不进行旋转
BODY_FOR_CALU = LoadWorkspace(BODY_FOR_CALU);
% 身体的工作空间完全由四足决定
BODY_FOR_CALU = UpdateBodySpace(BODY_FOR_CALU); % 5 代表身体
% 因此，工作空间矩阵始终平行于前进方向
% 即使是旋转，也是这一小步的前进方向

% Body和Body都设为42*n*m*p矩阵，Body0是为了初始化，Body是为了计算步态
BODY_FOR_CALU.Body0 = BODY_FOR_CALU.Body;
% 计算初始时刻公共工作空间的大小并赋值给四条腿
BODY_FOR_CALU.interSpace = zeros(4,2);
% 计算初始时刻身体顶点在足端点的位置
BODY_FOR_CALU.IdealLegLength = [BODY_FOR_CALU.Body(16:19) BODY_FOR_CALU.Body(20:23) BODY_FOR_CALU.Body(24:27)]...
    - [BODY_FOR_CALU.Body(1:4) BODY_FOR_CALU.Body(6:9) BODY_FOR_CALU.Body(11:14)];

% BODY_FOR_CALU.TraceData(1,:)=[BODY_FOR_CALU.Body(1),BODY_FOR_CALU.Body(6),BODY_FOR_CALU.Body(11),BODY_FOR_CALU.Body(2),BODY_FOR_CALU.Body(7),BODY_FOR_CALU.Body(12),...
%     BODY_FOR_CALU.Body(3),BODY_FOR_CALU.Body(8),BODY_FOR_CALU.Body(13),BODY_FOR_CALU.Body(4),BODY_FOR_CALU.Body(9),BODY_FOR_CALU.Body(14),...
%     BODY_FOR_CALU.Body(5),BODY_FOR_CALU.Body(10),BODY_FOR_CALU.Body(15)];
%计算初始机身和单腿位姿变换矩阵
d=BODY_PARA.Link_D;
h=BODY_PARA.Link_H;
b3=BODY_PARA.Link_B(3);
theta_in=BODY_PARA.Angle(1);
C_B(:,1)=[d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];  C_B(:,2)=[d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];
C_B(:,3)=[-d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C]; C_B(:,4)=[-d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];  % 表示C相对于B
% C_B(:,1)=[d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];  C_B(:,2)=[-d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];
% C_B(:,3)=[-d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)]; C_B(:,4)=[d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];  % 表示C相对于B
for j=1:4
    
%     RCB(:,:,j)=[cos(pi/4+(j-1)*pi/2)  -sin(pi/4+(j-1)*pi/2)  0 ;
%         sin(pi/4+(j-1)*pi/2)   cos(pi/4+(j-1)*pi/2)  0 ;
%         0                     0                 1];
    RCB(:,:,j)=[cos(pi/4+(j-2)*pi/2)  -sin(pi/4+(j-2)*pi/2)  0 ;
        sin(pi/4+(j-2)*pi/2)   cos(pi/4+(j-2)*pi/2)  0 ;
        0                     0                 1];
    BODY_FOR_CALU.TCB(:,:,j)=[RCB(:,:,j)  C_B(:,j);0 0 0 1];%从单腿静坐标系到机身坐标系的变换
end
%计算初始世界坐标系和机身坐标系变换矩阵
BODY_FOR_CALU.TBG=[eye(3),[0;0;BODY_FOR_CALU.Body(15)];0 0 0 1];
%初始化身体线框储存矩阵

for j=1:4
    R2_C(:,j) = [0; -BODY_PARA.Link_A(3); -BODY_PARA.Link_B(3)*cos(BODY_PARA.Angle(1))];
    R3_C(:,j) = [0;  BODY_PARA.Link_A(3); -BODY_PARA.Link_B(3)*cos(BODY_PARA.Angle(1))];
    R2_C_EX_bottom(:,j) = [R2_C(1,j);1.7*R2_C(2,j);-BODY_PARA.Link_C];
    R3_C_EX_bottom(:,j) = [R3_C(1,j);1.7*R3_C(2,j);-BODY_PARA.Link_C];
    
    aaa = BODY_FOR_CALU.TCB(:,:,j)*[R2_C_EX_bottom(:,j);1];     R2_B_EX_bottom(:,j) = aaa;
    aaa = BODY_FOR_CALU.TCB(:,:,j)*[R3_C_EX_bottom(:,j);1];     R3_B_EX_bottom(:,j) = aaa;
    R2_B_EX_up(:,j) = [R2_B_EX_bottom(1,j),R2_B_EX_bottom(2,j),-R2_B_EX_bottom(3,j),1];
    R3_B_EX_up(:,j) = [R3_B_EX_bottom(1,j),R3_B_EX_bottom(2,j),-R3_B_EX_bottom(3,j),1];
    
    %这里储存的是16个身体框点相对于机身坐标系的坐标参数，在后续代码绘图时应乘以TBG
    
    Foot_tem=[BODY_FOR_CALU.Body(j),BODY_FOR_CALU.Body(j+5),BODY_FOR_CALU.Body(j+10),1].';
    Foot_tem=inv(BODY_FOR_CALU.TBG*BODY_FOR_CALU.TCB(:,:,j))*Foot_tem;
    BODY_FOR_CALU.TraceData(1,3*(j-1)+1:3*j)=[Foot_tem(1),Foot_tem(2),Foot_tem(3)];
end

BODY_FOR_CALU.Body_line(:,:,1)=[R2_B_EX_up(:,1),R3_B_EX_up(:,1),R2_B_EX_up(:,2),R3_B_EX_up(:,2),R2_B_EX_up(:,3),R3_B_EX_up(:,3),R2_B_EX_up(:,4),R3_B_EX_up(:,4)];%上八点
BODY_FOR_CALU.Body_line(:,:,2)=[R2_B_EX_bottom(:,1),R3_B_EX_bottom(:,1),R2_B_EX_bottom(:,2),R3_B_EX_bottom(:,2),R2_B_EX_bottom(:,3),R3_B_EX_bottom(:,3),R2_B_EX_bottom(:,4),R3_B_EX_bottom(:,4)];%下八点


end