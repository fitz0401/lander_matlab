clear all
% Leg_Data_C=[441.8407;0;-445.1427;1];
Leg_Data_C=[435;-25;-520;1];
Height=abs(Leg_Data_C(3))+59.5;
BODY_side=409.5;
BODY_PARA = class_BODY_PARA;
d=BODY_PARA.Link_D;
h=BODY_PARA.Link_H;
b3=BODY_PARA.Link_B(3);
theta_in=BODY_PARA.Angle(1);
C_B(:,1)=[d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];  C_B(:,2)=[d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];
C_B(:,3)=[-d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C]; C_B(:,4)=[-d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+BODY_PARA.Link_C];  % 表示C相对于B
% C_B(:,1)=[d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];  C_B(:,2)=[-d*sqrt(2)/2;d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];
% C_B(:,3)=[-d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)]; C_B(:,4)=[d*sqrt(2)/2;-d*sqrt(2)/2;-0.5*h+b3*cos(theta_in)];  % 表示C相对于B
j=1;
    
%     RCB(:,:,j)=[cos(pi/4+(j-1)*pi/2)  -sin(pi/4+(j-1)*pi/2)  0 ;
%         sin(pi/4+(j-1)*pi/2)   cos(pi/4+(j-1)*pi/2)  0 ;
%         0                     0                 1];
    RCB(:,:,j)=[cos(pi/4+(j-2)*pi/2)  -sin(pi/4+(j-2)*pi/2)  0 ;
        sin(pi/4+(j-2)*pi/2)   cos(pi/4+(j-2)*pi/2)  0 ;
        0                     0                 1];
    TCB(:,:,j)=[RCB(:,:,j)  C_B(:,j);0 0 0 1];%从单腿静坐标系到机身坐标系的变换

%计算初始世界坐标系和机身坐标系变换矩阵
TBG=[eye(3),[0;0;Height];0 0 0 1];
TGC(:,:,j)=TBG*TCB(:,:,j);
Leg_temp=TGC(:,:,j)*Leg_Data_C;

INITIA_DATA(1,:)=Leg_temp(1:3).';
INITIA_DATA(2,:)=[Leg_temp(1),-Leg_temp(2),Leg_temp(3)];
INITIA_DATA(3,:)=[-Leg_temp(1),-Leg_temp(2),Leg_temp(3)];
INITIA_DATA(4,:)=[-Leg_temp(1),Leg_temp(2),Leg_temp(3)];

INITIA_DATA(5,:)=[0,0,Height];
INITIA_DATA(6,:)=[BODY_side,-BODY_side,Height];
INITIA_DATA(7,:)=[BODY_side,BODY_side,Height];
INITIA_DATA(8,:)=[-BODY_side,BODY_side,Height];
INITIA_DATA(9,:)=[-BODY_side,-BODY_side,Height];

