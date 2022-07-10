function [LEGfigure,FOOTfigure,TransMechfigure,Dr_PARA] = plot3D_jthWalkLegExeMechDeleWS(j,TCjG,specified_footpad_j,BODY_PARA)

%% 参数转化
a1=BODY_PARA.Link_A(1);a2=BODY_PARA.Link_A(2);a3=BODY_PARA.Link_A(3);
b1=BODY_PARA.Link_B(1);b2=BODY_PARA.Link_B(2);b3=BODY_PARA.Link_B(3);
l1=BODY_PARA.Link_L(1);l2=BODY_PARA.Link_L(2);l3=BODY_PARA.Link_L(3);l4=BODY_PARA.Link_L(4);l1x=BODY_PARA.Link_L(5);
p1=BODY_PARA.Link_P(1);p2x=BODY_PARA.Link_P(2);p2y=BODY_PARA.Link_P(3);p2z=BODY_PARA.Link_P(4);p3x=BODY_PARA.Link_P(5);p3y=BODY_PARA.Link_P(6);p3z=BODY_PARA.Link_P(7);
theta_in=BODY_PARA.Angle(1);theta_m=BODY_PARA.Angle(2);theta_ex=BODY_PARA.Angle(3);theta_p=BODY_PARA.Angle(4);
d=BODY_PARA.Link_D;
alpha1_min=BODY_PARA.Lim_alpha(1,1);alpha1_max=BODY_PARA.Lim_alpha(1,2);alpha2_min=BODY_PARA.Lim_alpha(2,1);alpha2_max=BODY_PARA.Lim_alpha(2,2);alpha3_min=BODY_PARA.Lim_alpha(3,1);alpha3_max=BODY_PARA.Lim_alpha(3,2);
beta1_min=BODY_PARA.Lim_beta(1,1);beta1_max=BODY_PARA.Lim_beta(1,2);beta2_min=BODY_PARA.Lim_beta(2,1);beta2_max=BODY_PARA.Lim_beta(2,2);beta3_min=BODY_PARA.Lim_beta(3,1);beta3_max=BODY_PARA.Lim_beta(3,2);
gamma1_min=BODY_PARA.Lim_gama(1,1);gamma1_max=BODY_PARA.Lim_gama(1,2);gamma2_min=BODY_PARA.Lim_gama(2,1);gamma2_max=BODY_PARA.Lim_gama(2,2);gamma3_min=BODY_PARA.Lim_gama(3,1);gamma3_max=BODY_PARA.Lim_gama(3,2);
phi1_min=BODY_PARA.Lim_phi(1,1);phi1_max=BODY_PARA.Lim_phi(1,2);phi2_min=BODY_PARA.Lim_phi(2,1);phi2_max=BODY_PARA.Lim_phi(2,2);phi3_min=BODY_PARA.Lim_phi(3,1);phi3_max=BODY_PARA.Lim_phi(3,2);
phi1_initial=BODY_PARA.Init_phi(1);phi2_initial=BODY_PARA.Init_phi(2);phi3_initial=BODY_PARA.Init_phi(3);
Q_transmech=BODY_PARA.Q_transmech;
Q_Pritransmech=BODY_PARA.Q_Pritransmech;                                                                               
                                                                                           
                                                                                           
                                                                                           %% 其他参数
% total_layernum=48;% z方向的总层数(4的倍数)
% M_RGB=M_RGB_GEN(total_layernum); % 生成色值矩阵（由蓝到红）
% layernum=0; % 用于显示计算进度
% 
% X=[];Y=[];Z=[];


%% 开始遍历末端位置zF,xF,yF。基于Cj系
% zFmin=-2500/1000 ; zFmax=500/1000    ; s_zF=(zFmax-zFmin)/total_layernum;
% yFmin=-2000/1000 ; yFmax=2000/1000 ; s_yF=(yFmax-yFmin)/total_layernum;  %yFmin=-2000/1000 ;   yFmax=2000/1000 ;   s_yF=(yFmax-yFmin)/total_layernum;
% xFmin=0/1000     ; xFmax=2500/1000 ; s_xF=(xFmax-xFmin)/total_layernum;
% itotal=0;%迭代变量以求得工作空间内点的总数，方便计算性能指标的离散点总数量，最后赋给ntotal


% for zF = zFmin:3*s_zF:zFmax
%     zF = zF
%     for yF = yFmin:1*s_yF:yFmax
%         for xF = xFmin:1*s_xF:xFmax
%             
%             output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF,a1,b1,a2,b2,a3,b3,l1,l2,l3,l4,d,theta_in,theta_p,p1,p2x,p2y,p2z,p3x,p3y,p3z,...
%                                                                                                 phi1_initial,phi2_initial,phi3_initial,phi1_min,phi1_max,phi2_min,phi2_max,phi3_min,phi3_max,...
%                                                                                                 alpha1_min,alpha1_max,alpha2_min,alpha2_max,alpha3_min,alpha3_max,...
%                                                                                                 beta1_min,beta1_max,beta2_min,beta2_max,beta3_min,beta3_max,...
%                                                                                                 gamma1_min,gamma1_max,gamma2_min,gamma2_max,gamma3_min,gamma3_max,ksim);
% 
% 
%             if isempty(output_walkingPSP)==0
%                itotal=itotal+1;
%                F_CjG = TCjG*[xF;yF;zF;1];
% %                X(itotal) = F_CjG(1)+0.26;
%                X(itotal) = F_CjG(1);
%                Y(itotal) = F_CjG(2);
%                Z(itotal) = F_CjG(3);
%             end
% 
%         end
%     end
% end
% 
% ntotal=itotal;
% M_RGB_GEN_n=ceil(ntotal/4)*4;
% M_RGB=M_RGB_GEN(M_RGB_GEN_n); % 生成色值矩阵（由蓝到红）
% 
% WORKSPACEfigure=scatter3(X,Y,Z,10,M_RGB(1:length(X),:),'filled');

%% 绘制一位形
xF=specified_footpad_j(1);
yF=specified_footpad_j(2);
zF=specified_footpad_j(3);

output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF,BODY_PARA);
% output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF,a1,b1,a2,b2,a3,b3,l1,l2,l3,l4,d,theta_in,theta_p,p1,p2x,p2y,p2z,p3x,p3y,p3z,...
%                                                                                 phi1_initial,phi2_initial,phi3_initial,phi1_min,phi1_max,phi2_min,phi2_max,phi3_min,phi3_max,...
%                                                                                 alpha1_min,alpha1_max,alpha2_min,alpha2_max,alpha3_min,alpha3_max,...
%                                                                                 beta1_min,beta1_max,beta2_min,beta2_max,beta3_min,beta3_max,...
%                                                                                 gamma1_min,gamma1_max,gamma2_min,gamma2_max,gamma3_min,gamma3_max,ksim);


alpha1 = output_walkingPSP(1);    beta1 = output_walkingPSP(2);    gamma1 = output_walkingPSP(3);
alpha2 = output_walkingPSP(4);    beta2 = output_walkingPSP(5);    gamma2 = output_walkingPSP(6);
alpha3 = output_walkingPSP(7);    beta3 = output_walkingPSP(8);    gamma3 = output_walkingPSP(9);
                                          
%% plot3D_walkLegExeMech 坐标系转换
% 特殊点坐标
S1_A = [l1x; l1; 0];
S2_A = [-b2; 0; -a2];
S3_A = [-b2; 0;  a2];
R1_C = [b3*sin(theta_m); 0; 0];
R2_C = [0; -a3; -b3*cos(theta_m)];
R3_C = [0;  a3; -b3*cos(theta_m)];
S1_C   =[xF; yF; zF];



% 支链静坐标系R1、R2、R3相对C系位姿矩阵
% T_R1_C = [sin(theta_in), 0, cos(theta_in), b3*sin(theta_in)     ;     0, -1, 0, 0     ;     cos(theta_in), 0, -sin(theta_in), 0     ;     0, 0, 0, 1];
% T_R2_C = [0, 0, 1, 0     ;     -1, 0, 0, -a3     ;     0, -1, 0, -b3*cos(theta_in)     ;     0, 0, 0, 1];
% T_R3_C = [0, 0, 1, 0     ;     -1, 0, 0,  a3     ;     0, -1, 0, -b3*cos(theta_in)     ;     0, 0, 0, 1];
T_R1_C = [sin(theta_in), 0, cos(theta_in), b3*sin(theta_m)     ;     0, -1, 0, 0     ;     cos(theta_in), 0, -sin(theta_in), 0     ;     0, 0, 0, 1];
T_R2_C = [0, 0, 1, 0     ;     -1, 0, 0, -a3     ;     0, -1, 0, -b3*cos(theta_m)     ;     0, 0, 0, 1];
T_R3_C = [0, 0, 1, 0     ;     -1, 0, 0,  a3     ;     0, -1, 0, -b3*cos(theta_m)     ;     0, 0, 0, 1];


% % 支链静坐标系R1、R2、R3相对C系位姿矩阵
% T_R1_C = [sin(theta_in), 0, cos(theta_in), b3*sin(theta_in)     ;     0, -1, 0, 0     ;     cos(theta_in), 0, -sin(theta_in), 0     ;     0, 0, 0, 1];
% T_R2_C = [0, 0, 1, 0     ;     -1, 0, 0, -a3     ;     0, -1, 0, -b3*cos(theta_in)     ;     0, 0, 0, 1];
% T_R3_C = [0, 0, 1, 0     ;     -1, 0, 0,  a3     ;     0, -1, 0, -b3*cos(theta_in)     ;     0, 0, 0, 1];

% 求T_U1_R1 , T_U1_C
T_U1_R1_M1 = [cos(phi1_initial), -sin(phi1_initial), 0, 0     ;     sin(phi1_initial), cos(phi1_initial), 0, 0     ;     0, 0, 1, 0     ;     0, 0, 0, 1];
T_U1_R1_M2 = [cos(alpha1), 0, sin(alpha1), 0     ;     0, 1, 0, 0     ;     -sin(alpha1), 0, cos(alpha1), 0     ;     0, 0, 0, 1];
T_U1_R1_M3 = [1, 0, 0, p1     ;     0, 1, 0, 0     ;     0, 0, 1, 0     ;     0, 0, 0, 1];
T_U1_R1_M4 = [cos(beta1), 0, sin(beta1), 0     ;     0, 1, 0, 0     ;     -sin(beta1), 0, cos(beta1), 0     ;     0, 0, 0, 1];
T_U1_R1_M5 = [1, 0, 0, 0     ;     0, cos(gamma1), -sin(gamma1), 0     ;     0, sin(gamma1), cos(gamma1), 0     ;    0, 0, 0, 1];
T_U1_R1 = T_U1_R1_M1 * T_U1_R1_M2 * T_U1_R1_M3 * T_U1_R1_M4 * T_U1_R1_M5;
T_A_U1 = [1, 0, 0, l1x     ;     0, 0, -1, 0     ;     0, 1, 0, l4     ;     0, 0, 0, 1];
T_A_R1 = T_U1_R1*T_A_U1;
T_A_C   = T_R1_C*T_A_R1;
A_C = T_A_C(1:3,4);
T_U1_C = T_R1_C*T_U1_R1;
U1_C = T_U1_C(1:3,4);

% limb 2 -- 求T_U2_R2 , T_U2_C
T_U2_R2_M1 = [cos(phi2_initial), -sin(phi2_initial), 0, 0     ;     sin(phi2_initial), cos(phi2_initial), 0, 0     ;     0, 0, 1, 0     ;     0, 0, 0, 1];
T_U2_R2_M2 = [cos(alpha2), 0, sin(alpha2), 0     ;     0, 1, 0, 0     ;     -sin(alpha2), 0, cos(alpha2), 0     ;     0, 0, 0, 1];
T_U2_R2_M3 = [1, 0, 0, p2x     ;     0, 1, 0, p2y     ;     0, 0, 1, p2z     ;     0, 0, 0, 1];
T_U2_R2_M4 = [1, 0, 0, 0     ;     0, cos(-theta_p), -sin(-theta_p), 0     ;     0, sin(-theta_p), cos(-theta_p), 0     ;     0, 0, 0, 1];
T_U2_R2_M5 = [cos(beta2), 0, sin(beta2), 0     ;     0, 1, 0, 0     ;     -sin(beta2), 0, cos(beta2), 0     ;     0, 0, 0, 1];
T_U2_R2_M6 = [1, 0, 0, 0     ;     0, cos(gamma2), -sin(gamma2), 0     ;     0, sin(gamma2), cos(gamma2), 0     ;     0, 0, 0, 1];
T_U2_R2 = T_U2_R2_M1 * T_U2_R2_M2 * T_U2_R2_M3 * T_U2_R2_M4 * T_U2_R2_M5 * T_U2_R2_M6;
T_U2_C = T_R2_C*T_U2_R2;
U2_C = T_U2_C(1:3,4);
S2_C = [eye(3),zeros(3,1)] * T_A_C * [S2_A;1];

% limb 3 -- 求T_U3_R3 , T_U3_C
T_U3_R3_M1 = [cos(phi3_initial), -sin(phi3_initial), 0, 0     ;     sin(phi3_initial), cos(phi3_initial), 0, 0     ;     0, 0, 1, 0     ;     0, 0, 0, 1];
T_U3_R3_M2 = [cos(alpha3), 0, sin(alpha3), 0     ;     0, 1, 0, 0     ;     -sin(alpha3), 0, cos(alpha3), 0     ;     0, 0, 0, 1];
T_U3_R3_M3 = [1, 0, 0, p3x     ;     0, 1, 0, -p3y     ;     0, 0, 1, p3z     ;     0, 0, 0, 1];
T_U3_R3_M4 = [1, 0, 0, 0     ;     0, cos(theta_p), -sin(theta_p), 0     ;     0, sin(theta_p), cos(theta_p), 0     ;     0, 0, 0, 1];
T_U3_R3_M5 = [cos(beta3), 0, sin(beta3), 0     ;     0, 1, 0, 0     ;     -sin(beta3), 0, cos(beta3), 0     ;     0, 0, 0, 1];
T_U3_R3_M6 = [1, 0, 0, 0     ;     0, cos(gamma3), -sin(gamma3), 0     ;     0, sin(gamma3), cos(gamma3), 0     ;     0, 0, 0, 1];
T_U3_R3 = T_U3_R3_M1 * T_U3_R3_M2 * T_U3_R3_M3 * T_U3_R3_M4 * T_U3_R3_M5 * T_U3_R3_M6;
T_U3_C = T_R3_C*T_U3_R3;
U3_C = T_U3_C(1:3,4);
S3_C = [eye(3),zeros(3,1)] * T_A_C * [S3_A;1];


%传动机构
phi2=phi2_initial;
phi3=phi3_initial;
q1 = Q_transmech(1);
q2 = Q_transmech(2);
q3x =Q_transmech(3);
q3z =Q_transmech(4);
q4x =Q_transmech(5);
q4y =Q_transmech(6);
q4z =Q_transmech(7);
theta2_min=0 ;   theta2_max=pi;
theta3_min=0 ;   theta3_max=pi;
colorValue = [255 130 0]/255;
theta2 = walkLegTransMechPositionIK2(phi2_initial,alpha2,q1,q2,q3x,q3z,q4x,q4y,q4z,theta2_min,theta2_max);
theta3 = walkLegTransMechPositionIK3(phi3_initial,alpha3,q1,q2,q3x,q3z,q4x,q4y,q4z,theta3_min,theta3_max);
% theta2 = adjustLegTransMechPositionIK2(phi2,q1,q2,q3x,q3z,q4x,q4y,q4z,theta2_min,theta2_max);
% theta3 = adjustLegTransMechPositionIK3(phi3,q1,q2,q3x,q3z,q4x,q4y,q4z,theta3_min,theta3_max);
%左侧传动机构

Rv2 = TCjG*T_R2_C*[0;0;0;1];
Rt2_Rv2 = TCjG*T_R2_C*[-q4x;  -q4y;  q4z;1];
St21_Rv2 = TCjG*T_R2_C*[cos(theta2)*q1-q4x;  -q4y;  q4z+sin(theta2)*q1;1];
St22_Rv2 = TCjG*T_R2_C*[q3x*cos(phi2)*cos(alpha2)+q3z*cos(phi2)*sin(alpha2);  q3x*sin(phi2)*cos(alpha2)+q3z*sin(phi2)*sin(alpha2);  q3z*cos(alpha2)-q3x*sin(alpha2);1];

Rt2 = Rt2_Rv2;
St21 = St21_Rv2;
St22 = St22_Rv2;

%右侧传动机构
Rv3 = TCjG*T_R3_C*[0;0;0;1];
Rt3_Rv3 = TCjG*T_R3_C*[q4x;  -q4y;  q4z;1];
St31_Rv3 = TCjG*T_R3_C*[cos(theta3)*q1+q4x;  -q4y;  q4z+sin(theta3)*q1;1];
St32_Rv3 = TCjG*T_R3_C*[q3x*cos(phi3)*cos(alpha3)+q3z*cos(phi3)*sin(alpha3);  q3x*sin(phi3)*cos(alpha3)+q3z*sin(phi3)*sin(alpha3);  q3z*cos(alpha3)-q3x*sin(alpha3);1];

Rt3 = Rt3_Rv3;
St31 = St31_Rv3;
St32 = St32_Rv3;

%主传动机构
T_Rt12_phi=[1, 0, 0, 0     ;  0,   cos(phi1_initial), -sin(phi1_initial), 0     ;     0, sin(phi1_initial), cos(phi1_initial), 0     ;     0, 0, 0, 1];
theta_t0=Q_Pritransmech(1);
theta_d=Q_Pritransmech(2);
theta_origin1=Q_Pritransmech(3);
d2=Q_Pritransmech(4);
d3=Q_Pritransmech(5);
d1 = walkLegPrimaryTransMechPositionIK(alpha1,d2,d3,theta_t0,theta_d,theta_origin1);
theta_t1=theta_t0-theta_d-(pi/2-(theta_origin1+alpha1));
Rv1_C = [b3*sin(theta_in);0;0;1];
T_Rt11_Rv1_x=[1,0,0,-d2*sin(theta_d);0,1,0,0;0,0,1,0;0,0,0,1];
T_Rt11_Rv1_z=[1,0,0,0;0,1,0,0;0,0,1,d2*cos(theta_d);0,0,0,1];
T_Rt12_Rv1_x=[1,0,0,-d3*sin(pi-(theta_d+theta_t1));0,1,0,0;0,0,1,0;0,0,0,1];
T_Rt12_Rv1_z=[1,0,0,0;0,1,0,0;0,0,1,-d3*cos(pi-(theta_d+theta_t1));0,0,0,1];

Rt11_C=TCjG*T_Rt11_Rv1_x*T_Rt11_Rv1_z*Rv1_C;
Rt12_C=TCjG*T_Rt12_phi*T_Rt12_Rv1_x*T_Rt12_Rv1_z*Rv1_C;
Rv1_C=TCjG*Rv1_C;
Dr_PARA=[theta2,theta3,d1];

PLOTtransX=[[Rt2(1),St21(1)]',[St21(1),St22(1)]',[Rv2(1),St22(1)]',[Rt3(1),St31(1)]',[St31(1),St32(1)]',[Rv3(1),St32(1)]',[Rt11_C(1),Rt12_C(1)]'];
PLOTtransY=[[Rt2(2),St21(2)]',[St21(2),St22(2)]',[Rv2(2),St22(2)]',[Rt3(2),St31(2)]',[St31(2),St32(2)]',[Rv3(2),St32(2)]',[Rt11_C(2),Rt12_C(2)]'];
PLOTtransZ=[[Rt2(3),St21(3)]',[St21(3),St22(3)]',[Rv2(3),St22(3)]',[Rt3(3),St31(3)]',[St31(3),St32(3)]',[Rv3(3),St32(3)]',[Rt11_C(3),Rt12_C(3)]'];
TransMechfigure=plot3(PLOTtransX,PLOTtransY,PLOTtransZ,'Color',colorValue,'LineWidth',3);  %传动机构作图
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %



A_G = [eye(3) zeros(3,1)] * TCjG * [A_C;1];

R1_G = [eye(3) zeros(3,1)] * TCjG * [R1_C;1];
R2_G = [eye(3) zeros(3,1)] * TCjG * [R2_C;1];
R3_G = [eye(3) zeros(3,1)] * TCjG * [R3_C;1];

U1_G = [eye(3) zeros(3,1)] * TCjG * [U1_C;1];
U2_G = [eye(3) zeros(3,1)] * TCjG * [U2_C;1];
U3_G = [eye(3) zeros(3,1)] * TCjG * [U3_C;1];

S1_G = [eye(3) zeros(3,1)] * TCjG * [S1_C;1];
S2_G = [eye(3) zeros(3,1)] * TCjG * [S2_C;1];
S3_G = [eye(3) zeros(3,1)] * TCjG * [S3_C;1];

%运动后整机机身移动

% A_G(1)=A_G(1)+0.26;
% R1_G(1)=R1_G(1)+0.26;
% R2_G(1)=R2_G(1)+0.26;
% R3_G(1)=R3_G(1)+0.26;
% U1_G(1)=U1_G(1)+0.26;
% U2_G(1)=U2_G(1)+0.26;
% U3_G(1)=U3_G(1)+0.26;
% S1_G(1)=S1_G(1)+0.26;
% S2_G(1)=S2_G(1)+0.26;
% S3_G(1)=S3_G(1)+0.26;


% 绘制单腿机构
% view([4,-2.5,1.5])
%为了方便做动画对画图方式进行以下修改；
PLOTLEG1=[[R1_G(1),R2_G(1)]',[R1_G(1),R3_G(1)]',[R2_G(1),R3_G(1)]',[R1_G(1),U1_G(1)]',[R2_G(1),U2_G(1)]',[R3_G(1),U3_G(1)]',...
    [U1_G(1),S1_G(1)]',[U2_G(1),S2_G(1)]',[U3_G(1),S3_G(1)]',[A_G(1),S2_G(1)]',[A_G(1),S3_G(1)]',[S2_G(1),S3_G(1)]',[Rt12_C(1),Rv1_C(1)]'];
PLOTLEG2=[[R1_G(2),R2_G(2)]',[R1_G(2),R3_G(2)]',[R2_G(2),R3_G(2)]',[R1_G(2),U1_G(2)]',[R2_G(2),U2_G(2)]',[R3_G(2),U3_G(2)]',...
    [U1_G(2),S1_G(2)]',[U2_G(2),S2_G(2)]',[U3_G(2),S3_G(2)]',[A_G(2),S2_G(2)]',[A_G(2),S3_G(2)]',[S2_G(2),S3_G(2)]',[Rt12_C(2),Rv1_C(2)]'];
PLOTLEG3=[[R1_G(3),R2_G(3)]',[R1_G(3),R3_G(3)]',[R2_G(3),R3_G(3)]',[R1_G(3),U1_G(3)]',[R2_G(3),U2_G(3)]',[R3_G(3),U3_G(3)]',...
    [U1_G(3),S1_G(3)]',[U2_G(3),S2_G(3)]',[U3_G(3),S3_G(3)]',[A_G(3),S2_G(3)]',[A_G(3),S3_G(3)]',[S2_G(3),S3_G(3)]',[Rt12_C(3),Rv1_C(3)]'];
hold on
LEGfigure=plot3(PLOTLEG1,PLOTLEG2,PLOTLEG3,'b','LineWidth',3)  %R1R2

% plot3([R1_G(1),R2_G(1)],[R1_G(2),R2_G(2)],[R1_G(3),R2_G(3)],'b','LineWidth',3)  %R1R2
% hold on
% plot3([R1_G(1),R3_G(1)],[R1_G(2),R3_G(2)],[R1_G(3),R3_G(3)],'b','LineWidth',3)  %R1R3
% hold on
% plot3([R2_G(1),R3_G(1)],[R2_G(2),R3_G(2)],[R2_G(3),R3_G(3)],'b','LineWidth',3)  %R2R3
% hold on
% 
% plot3([R1_G(1),U1_G(1)],[R1_G(2),U1_G(2)],[R1_G(3),U1_G(3)],'b','LineWidth',3)  %R1U1
% hold on
% plot3([R2_G(1),U2_G(1)],[R2_G(2),U2_G(2)],[R2_G(3),U2_G(3)],'b','LineWidth',3)  %R2U2
% hold on
% plot3([R3_G(1),U3_G(1)],[R3_G(2),U3_G(2)],[R3_G(3),U3_G(3)],'b','LineWidth',3)  %R3U3
% hold on
% 
% plot3([U1_G(1),S1_G(1)],[U1_G(2),S1_G(2)],[U1_G(3),S1_G(3)],'b','LineWidth',3)  %U1S1
% hold on
% plot3([U2_G(1),S2_G(1)],[U2_G(2),S2_G(2)],[U2_G(3),S2_G(3)],'b','LineWidth',3)  %U2S2
% hold on
% plot3([U3_G(1),S3_G(1)],[U3_G(2),S3_G(2)],[U3_G(3),S3_G(3)],'b','LineWidth',3)  %U3S3
% hold on
% 
% % plot3([A_G(1),S1_G(1)],[A_G(2),S1_G(2)],[A_G(3),S1_G(3)],'b','LineWidth',3)  %AS1
% % hold on
% plot3([A_G(1),S2_G(1)],[A_G(2),S2_G(2)],[A_G(3),S2_G(3)],'b','LineWidth',3)  %AS2
% hold on
% plot3([A_G(1),S3_G(1)],[A_G(2),S3_G(2)],[A_G(3),S3_G(3)],'b','LineWidth',3)  %AS3
% hold on
% plot3([S2_G(1),S3_G(1)],[S2_G(2),S3_G(2)],[S2_G(3),S3_G(3)],'b','LineWidth',3)  %S2S3
% hold on


% 绘制足垫
r = 0.3*p1;  % 半径
pos = [S1_G(1),S1_G(2),S1_G(3)]; % 圆心位置
t=[0:1:(2*pi),0];% 圆滑性设置
FOOTfigure=plot3(pos(1)+r*sin(t),pos(2)+r*cos(t), pos(3)*ones(size(t)),'b','LineWidth',3)

% xlabel('x')
% ylabel('y')
% zlabel('z')
% axis equal
end