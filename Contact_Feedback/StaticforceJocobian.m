% Author:Fitz
% Date:2022/9
% 足端与电机力雅可比求解，与Adams求解结果对比

tic

close all
clear all
clc
dbstop if error
load("Adams仿真数据\FK_res.mat")

%% 固有参数
% 执行机构全局变量
global a1 b1 a2 b2 a3 b3 l1 l2 l3 l4 ksim
global d theta_in theta_ex theta_p p1 p2x p2y p2z p3x p3y p3z l1x theta_m
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
% 雅可比矩阵
global J_L J_L_inv

% ReLML尺度综合论文中给出的结果
a1=251/1000;            b1=202.9166/1000;   
a2=35.3553/2/1000;      b2=38.3391/1000;     
a3=127/1000;            b3=60.8790/1000;  
% 第九个孔
l1=(213.6473+80)/1000;
l2=406.3691/1000;     l3=406.3691/1000;   
l4=448.7958/1000;
d=863/2000;
theta_in=pi/6;        theta_ex=pi/6;          theta_p=(40*pi)/180 ;         p1=129/1000;  
p2x=123.8/1000;     p2y=25.5/1000;     p2z=28.0985/1000;
p3x=123.8/1000;     p3y=25.5/1000;     p3z=28.0985/1000;  
l1x=5.362/1000;
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
S1_A = [l1x; l1; 0];
S2_A = [-b2; 0; -a2];
S3_A = [-b2; 0;  a2];
R1_C = [b3*sin(theta_m); 0; 0];
R2_C = [0; -a3; -b3*cos(theta_m)];
R3_C = [0;  a3; -b3*cos(theta_m)];

% 支链静坐标系R1、R2、R3相对C系位姿矩阵
T_R1_C = [sin(theta_in), 0, cos(theta_in), b3*sin(theta_m)     ;     0, -1, 0, 0     ;     cos(theta_in), 0, -sin(theta_in), 0     ;     0, 0, 0, 1];
T_R2_C = [0, 0, 1, 0     ;     -1, 0, 0, -a3     ;     0, -1, 0, -b3*cos(theta_m)     ;     0, 0, 0, 1];
T_R3_C = [0, 0, 1, 0     ;     -1, 0, 0,  a3     ;     0, -1, 0, -b3*cos(theta_m)     ;     0, 0, 0, 1];

%% 绘制一位形
%存储结果信息
force_res = zeros(6, 1000);
i = 1;
    xF = footx(i,2);
    yF = footy(i,2);
    zF = footz(i,2);
    q_a = [0 0 0 0 0 0]';
    q_v = [0 0 0 0 0 0]';
    output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF);
                                                                                 
    % output_walkingPSP的输出为[]或[alpha1  beta1  gamma1  alpha2  beta2  gamma2  alpha3  beta3  gamma3]                                                                    
    alpha1 = output_walkingPSP(1);  beta1 = output_walkingPSP(2);  gamma1 = output_walkingPSP(3);
    alpha2 = output_walkingPSP(4);  beta2 = output_walkingPSP(5);  gamma2 = output_walkingPSP(6);
    alpha3 = output_walkingPSP(7);  beta3 = output_walkingPSP(8);  gamma3 = output_walkingPSP(9);
    
    d1 = walkLegPrimaryTransMechPositionIK(alpha1);
    theta2 = walkLegTransMechPositionIK2(alpha2);
    theta3 = walkLegTransMechPositionIK3(alpha3);
    
    % 雅可比矩阵求解
    [~, ~, ~, ~] = walkLegExeMechAFK...
                   (xF,yF,zF,q_v,q_a,alpha1,alpha2,alpha3,beta1,beta2,beta3,gamma1,gamma2,gamma3);
    JFK = walkLegTransMechJacobian(alpha3,theta3);
    Jtrans = diag([sqrt(d2^2 - 2*cos(alpha1-theta_d+theta_t0+theta_origin1-pi/2)*d2*d3 + d3^2) / (d2*d3*sin(alpha1-theta_d+theta_t0+theta_origin1-pi/2)), -JFK, JFK]);
    JMotor = diag([5/1000/(2*pi), 1, 1]);
    (Jtrans * JMotor) * [8.05046924004322; -2.57357595022900; -2.56820774051138]

    % 力雅可比矩阵
    (J_L)' * [0;0;0;-5;0;20];
    s1_x = [0 -zF yF; zF 0 -xF; -yF xF 0];
    Q_INT = (J_L_inv)' * [5.1882; -1.5362; -1.5362];
    %(Q_INT(4) - (-5)) * zF - (Q_INT(6) - 20) * xF
toc