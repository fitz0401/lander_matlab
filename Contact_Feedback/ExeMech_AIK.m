% Author:Fitz
% Date:2022/10
% 加速度反解验证
% 说明：α1、α2的方向与admas中定义相反，α3一致
tic

close all
clear all
clc
dbstop if error
load("Adams仿真数据\IK_res.mat")

%% 固有参数
% 执行机构全局变量
global a1 b1 a2 b2 a3 b3 l1 l2 l3 l4 ksim Rsp Rms
global d h theta_in theta_ex theta_p p1 p2x p2y p2z p3x p3y p3z l1x theta_m
global alpha1_min alpha1_max alpha2_min alpha2_max alpha3_min alpha3_max 
global phi1_min phi1_max phi2_min phi2_max phi3_min phi3_max
global beta1_min beta1_max beta2_min beta2_max beta3_min beta3_max
global gamma1_min gamma1_max gamma2_min gamma2_max gamma3_min gamma3_max
global phi1_initial phi2_initial phi3_initial theta2_min theta2_max theta3_min theta3_max
% 传动机构全局变量
global theta_t0 theta_d d2 d3 theta_origin1
global q1 q2 q3x q3z q4x q4y q4z
% 坐标变换变量
global S1_A S2_A S3_A R1_C R2_C R3_C
global T_R1_C T_R2_C T_R3_C 

% ReLML尺度综合论文中给出的结果
a1=251/1000;       b1=202.9166/1000;   a2=35.3553/2/1000;      b2=38.3391/1000;     a3=127/1000;     b3=60.8790/1000;  
% 第九个孔
l1=(213.6473+80)/1000;
l2=406.3691/1000;     l3=406.3691/1000;   
l4=448.7958/1000;
d=863/2000;
h = 451;          theta_in=pi/6;        theta_ex=pi/6;          theta_p=(40*pi)/180 ;         p1=129/1000;  
p2x=124/1000;     p2y=27.7771/1000;     p2z=26.0140/1000;
p3x=124/1000;     p3y=27.7771/1000;     p3z=26.0140/1000;   
l1x=5.3619/1000;
theta_m=17.6909*pi/180;

alpha1_min=-3*pi/3;     alpha1_max=0.1;
alpha2_min=-3*pi/3;     alpha2_max=0.1;
alpha3_min=-3*pi/3;     alpha3_max=0.1;
phi1_min=-pi/2;            phi1_max=pi/2;
phi2_min=-pi/2;            phi2_max=pi/2;
phi3_min=pi/2;              phi3_max=-pi/2;  % 注意此项特殊，取逻辑或
beta1_min=-pi/3;          beta1_max=pi/3;
beta2_min=-pi/3;          beta2_max=pi/3;
beta3_min=-pi/3;          beta3_max=pi/3;
gamma1_min=-pi/3;     gamma1_max=pi/3;
gamma2_min=-pi/3;     gamma2_max=pi/3;
gamma3_min=-pi/3;     gamma3_max=pi/3;
ksim=pi/3;

% 其他参数
h = d;     theta_ex=pi/6;     Rms = d+b1*sin(theta_in);
Rsp = d+b3*sin(theta_in)+(l1(1)+l4(1))*sin(theta_ex);   Rsp=2.1;
phi1_initial=0;         phi2_initial=0;        phi3_initial=-pi; 
theta2_min = 0.0;       theta2_max = pi;
theta3_min = 0.0;       theta3_max = pi;

% 主传动
theta_t0 = (167.2238 * pi) / 180;
theta_d = (43.3231 * pi) / 180;
d2 = 229.5545 / 1000;
d3 = 172.1663 / 1000;
theta_origin1 = pi / 2 - pi / 6;

% 辅传动 Adams
q1 = 82.4761 / 1000;
q2 = 141.0035 / 1000;
q3x = 61.0 / 1000;
q3z = 24.0 / 1000;
q4x = 19.8 / 1000;
q4y = 95 / 1000;
q4z = 9.0 / 1000;

% 特殊点坐标
S1_A = [0; l1; 0];
S2_A = [-b2; 0; -a2];
S3_A = [-b2; 0;  a2];
R1_C = [b3*sin(theta_in); 0; 0];
R2_C = [0; -a3; -b3*cos(theta_in)];
R3_C = [0;  a3; -b3*cos(theta_in)];

% 支链静坐标系R1、R2、R3相对C系位姿矩阵
T_R1_C = [sin(theta_in), 0, cos(theta_in), b3*sin(theta_in)     ;     0, -1, 0, 0     ;     cos(theta_in), 0, -sin(theta_in), 0     ;     0, 0, 0, 1];
T_R2_C = [0, 0, 1, 0     ;     -1, 0, 0, -a3     ;     0, -1, 0, -b3*cos(theta_in)     ;     0, 0, 0, 1];
T_R3_C = [0, 0, 1, 0     ;     -1, 0, 0,  a3     ;     0, -1, 0, -b3*cos(theta_in)     ;     0, 0, 0, 1];

%% 迭代求解
q_v = zeros(3,1000);
q_a = zeros(3,1000);
for i = 1 : 1000
    xF = footx(i,2);
    yF = footy(i,2);
    zF = footz(i,2);
    A_F = [MainLinkAwx(i,2) MainLinkAwy(i,2) MainLinkAwz(i,2) 0.02 0.04 -0.06]';
    X_L = [MainLinkwx(i,2) MainLinkwy(i,2) MainLinkwz(i,2) 0.02*i/1000 0.04*i/1000 -0.06*i/1000]';
    % 旋量转换
    S_L = zeros(6,1); A_L = zeros(6,1);
    S_L(1:3) = X_L(1:3);
    S_L(4:6) = X_L(4:6) - cross(X_L(1:3), [xF; yF; zF]);
    A_L(1:3) = A_F(1:3);
    A_L(4:6) = A_F(4:6) - cross(A_F(1:3), [xF; yF; zF]) - cross(S_L(1:3), cross(S_L(1:3), [xF; yF; zF])) - cross(S_L(1:3), S_L(4:6)); 
    
    %% 运动学反解
    output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF);
                                                                             
                                                                  
    alpha1 = output_walkingPSP(1);  beta1 = output_walkingPSP(2);  gamma1 = output_walkingPSP(3);
    alpha2 = output_walkingPSP(4);  beta2 = output_walkingPSP(5);  gamma2 = output_walkingPSP(6);
    alpha3 = output_walkingPSP(7);  beta3 = output_walkingPSP(8);  gamma3 = output_walkingPSP(9);
    %[alpha1,alpha2,alpha3]
    
    %% 加速度正解
    [q_v(:,i), q_a(:,i)] = walkLegExeMechAIK...
               (xF,yF,zF,S_L,A_L,alpha1,alpha2,alpha3,beta1,beta2,beta3,gamma1,gamma2,gamma3);
    
end
toc

%% 结果显示
t = linspace(0,1,1000);
% alpha速度
figure(1)
subplot(3,1,1)
plot(t,-q_v(1,:))
title('$\dot{\alpha_1}$','Interpreter','latex')
subplot(3,1,2)
plot(t,-q_v(2,:))
title('$\dot{\alpha_2}$','Interpreter','latex')
subplot(3,1,3)
plot(t,q_v(3,:))
title('$\dot{\alpha_3}$','Interpreter','latex')

% alpha加速度
figure(2)
subplot(3,1,1)
plot(t,-q_a(1,:))
title('$\ddot{\alpha_1}$','Interpreter','latex')
subplot(3,1,2)
plot(t,-q_a(2,:))
title('$\ddot{\alpha_2}$','Interpreter','latex')
subplot(3,1,3)
plot(t,q_a(3,:))
title('$\ddot{\alpha_3}$','Interpreter','latex')