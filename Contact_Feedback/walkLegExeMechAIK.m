function [q_v, q_a] = walkLegExeMechAIK...
               (xF,yF,zF,S_L,A_L,alpha1,alpha2,alpha3,beta1,beta2,beta3,gamma1,gamma2,gamma3)
%% 固有参数
% 执行机构全局变量
global a1 b1 a2 b2 a3 b3 l1 l2 l3 l4 ksim Rsp Rms
global d h theta_in theta_ex theta_p p1 p2x p2y p2z p3x p3y p3z l1x theta_m
global phi1_initial phi2_initial phi3_initial
% 坐标变换变量
global S1_A S2_A S3_A R1_C R2_C R3_C
global T_R1_C T_R2_C T_R3_C 

%% 坐标变换与点位计算
% limb 1 -- 求T_U1_R1 , T_U1_C【R1 to U1，C to U1】
T_U1_R1_M1 = [cos(phi1_initial), -sin(phi1_initial), 0, 0     ;     sin(phi1_initial), cos(phi1_initial), 0, 0     ;     0, 0, 1, 0     ;     0, 0, 0, 1];
T_U1_R1_M2 = [cos(alpha1), 0, sin(alpha1), 0     ;     0, 1, 0, 0     ;     -sin(alpha1), 0, cos(alpha1), 0     ;     0, 0, 0, 1];
T_U1_R1_M3 = [1, 0, 0, p1     ;     0, 1, 0, 0     ;     0, 0, 1, 0     ;     0, 0, 0, 1];
T_U1_R1_M4 = [cos(beta1), 0, sin(beta1), 0     ;     0, 1, 0, 0     ;     -sin(beta1), 0, cos(beta1), 0     ;     0, 0, 0, 1];
T_U1_R1_M5 = [1, 0, 0, 0     ;     0, cos(gamma1), -sin(gamma1), 0     ;     0, sin(gamma1), cos(gamma1), 0     ;    0, 0, 0, 1];
T_U1_R1 = T_U1_R1_M1 * T_U1_R1_M2 * T_U1_R1_M3 * T_U1_R1_M4 * T_U1_R1_M5;
T_A_U1 = [1, 0, 0, 0     ;     0, 0, -1, 0     ;     0, 1, 0, l4     ;     0, 0, 0, 1];
T_A_R1 = T_U1_R1*T_A_U1;
T_A_C   = T_R1_C*T_A_R1;
A_C = T_A_C(1:3,4);
T_U1_C = T_R1_C*T_U1_R1;
U1_C = T_U1_C(1:3,4);
T_R1phi1_C = T_R1_C*T_U1_R1_M1; % 表示R1系转动phi1之后的那个坐标系的位姿矩阵

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
T_R2phi2_C = T_R2_C*T_U2_R2_M1; % 表示R2系转动phi2之后的那个坐标系的位姿矩阵

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
T_R3phi3_C = T_R3_C*T_U3_R3_M1; % 表示R3系转动phi3之后的那个坐标系的位姿矩阵


%% 旋量系
% 约束旋量系，3阶
e_R1U1 = (U1_C-R1_C) / norm(U1_C-R1_C);
e13 = T_R1phi1_C(1:3,2);
e14 = T_U1_C(1:3,1);


% 传递力旋量系，3阶
m1 = cross(e_R1U1,e13);
screw_T1 = [m1 ; cross(U1_C,m1)];

e25 = (S2_C-U2_C) / norm(S2_C-U2_C);
screw_T2 = [e25 ; cross(U2_C,e25)];

e35 = (S3_C-U3_C) / norm(S3_C-U3_C);
screw_T3 = [e35 ; cross(U3_C,e35)];


% 输入运动旋量系，3阶
e12 = e13;
screw_I1 = [e12 ; cross(R1_C,e12)];

e22 = T_R2phi2_C(1:3,2);
screw_I2 = [e22 ; cross(R2_C,e22)];

e32 = T_R3phi3_C(1:3,2);
screw_I3 = [e32 ; cross(R3_C,e32)];

% 其它旋量系
screw_12 = screw_I1;
screw_13 = [e13; cross(U1_C,e13)];
screw_14 = [e14; cross(U1_C,e14)];

screw_22 = screw_I2;
e23 = T_U2_C(1:3,2);
screw_23 = [e23; cross(U2_C,e23)];
e24 = T_U2_C(1:3,1);
screw_24 = [e24; cross(U2_C,e24)];
e26 = e25;
screw_26 = [e26; cross(S2_C,e26)];
e27 = e24;
screw_27 = [e27; cross(S2_C,e27)];
e28 = e23;
screw_28 = [e28; cross(S2_C,e28)];

screw_32 = screw_I3;
e33 = T_U3_C(1:3,2);
screw_33 = [e33; cross(U3_C,e33)];
e34 = T_U3_C(1:3,1);
screw_34 = [e34; cross(U3_C,e34)];
e36 = e35;
screw_36 = [e36; cross(S3_C,e36)];
e37 = e34;
screw_37 = [e37; cross(S3_C,e37)];
e38 = e33;
screw_38 = [e38; cross(S3_C,e38)];

screw_C1 = [e_R1U1; cross(U1_C,e_R1U1)];
screw_C2 = [e13; cross(U1_C,e13)];
screw_C3 = [zeros(3,1); cross(e13,e14)];

%% 雅克比矩阵
Jx = [cross(U1_C,m1)'             m1' ;
         cross(U2_C,e25)'            e25' ;
         cross(U3_C,e35)'            e35' ;
         cross(U1_C,e_R1U1)'      e_R1U1' ;
         cross(U1_C,e13)'            e13' ;
         cross(e13,e14)'              zeros(3,1)'];

Jq = diag([screwReciprocalProduct(screw_T1,screw_I1) , screwReciprocalProduct(screw_T2,screw_I2) , screwReciprocalProduct(screw_T3,screw_I3), 0, 0, 0]);

%% 速度建模
J_FKL = inv(Jx) * Jq;
J_FK1 = [screw_12, screw_13, screw_14];
J_FK2 = [screw_22, screw_23, screw_24, screw_26, screw_27, screw_28];
J_FK3 = [screw_32, screw_33, screw_34, screw_36, screw_37, screw_38];
J_THETA1 = pinv(J_FK1) * J_FKL;
J_THETA2 = inv(J_FK2) * J_FKL;
J_THETA3 = inv(J_FK3) * J_FKL;
Jq3 = diag([screwReciprocalProduct(screw_T1,screw_I1) , screwReciprocalProduct(screw_T2,screw_I2) , screwReciprocalProduct(screw_T3,screw_I3)]);
q_v = inv(Jq3) * Jx(1:3,:) * S_L;

%% 加速度建模
G_A = [screw_T1'; screw_T2'; screw_T3'; screw_C1'; screw_C2'; screw_C3'] * [zeros(3,3), eye(3); eye(3), zeros(3,3)];
G_q = diag([screwReciprocalProduct(screw_T1,screw_I1) , screwReciprocalProduct(screw_T2,screw_I2) , screwReciprocalProduct(screw_T3,screw_I3)]);
H_a1 = [0, screwReciprocalProduct(lieProduct(screw_12, screw_13),screw_T1), screwReciprocalProduct(lieProduct(screw_12, screw_14),screw_T1);
        0 , 0, screwReciprocalProduct(lieProduct(screw_13, screw_14),screw_T1); 0, 0, 0];
H_a2 = [0, screwReciprocalProduct(lieProduct(screw_22, screw_23),screw_T2), screwReciprocalProduct(lieProduct(screw_22, screw_24),screw_T2), ...
        screwReciprocalProduct(lieProduct(screw_22, screw_26),screw_T2), screwReciprocalProduct(lieProduct(screw_22, screw_27),screw_T2), ...
        screwReciprocalProduct(lieProduct(screw_22, screw_28),screw_T2);
        0, 0, screwReciprocalProduct(lieProduct(screw_23, screw_24),screw_T2), screwReciprocalProduct(lieProduct(screw_23, screw_26),screw_T2), ...
        screwReciprocalProduct(lieProduct(screw_23, screw_27),screw_T2), screwReciprocalProduct(lieProduct(screw_23, screw_28),screw_T2);
        0, 0, 0, screwReciprocalProduct(lieProduct(screw_24, screw_26),screw_T2), screwReciprocalProduct(lieProduct(screw_24, screw_27),screw_T2), ...
        screwReciprocalProduct(lieProduct(screw_24, screw_28),screw_T2);
        0, 0, 0, 0, screwReciprocalProduct(lieProduct(screw_26, screw_27),screw_T2), screwReciprocalProduct(lieProduct(screw_26, screw_28),screw_T2);
        0, 0, 0, 0, 0, screwReciprocalProduct(lieProduct(screw_27, screw_28),screw_T2);
        0, 0, 0, 0, 0, 0];
H_a3 = [0, screwReciprocalProduct(lieProduct(screw_32, screw_33),screw_T3), screwReciprocalProduct(lieProduct(screw_32, screw_34),screw_T3), ...
        screwReciprocalProduct(lieProduct(screw_32, screw_36),screw_T3), screwReciprocalProduct(lieProduct(screw_32, screw_37),screw_T3), ...
        screwReciprocalProduct(lieProduct(screw_32, screw_38),screw_T3);
        0, 0, screwReciprocalProduct(lieProduct(screw_33, screw_34),screw_T3), screwReciprocalProduct(lieProduct(screw_33, screw_36),screw_T3), ...
        screwReciprocalProduct(lieProduct(screw_33, screw_37),screw_T3), screwReciprocalProduct(lieProduct(screw_33, screw_38),screw_T3);
        0, 0, 0, screwReciprocalProduct(lieProduct(screw_34, screw_36),screw_T3), screwReciprocalProduct(lieProduct(screw_34, screw_37),screw_T3), ...
        screwReciprocalProduct(lieProduct(screw_34, screw_38),screw_T3);
        0, 0, 0, 0, screwReciprocalProduct(lieProduct(screw_36, screw_37),screw_T3), screwReciprocalProduct(lieProduct(screw_36, screw_38),screw_T3);
        0, 0, 0, 0, 0, screwReciprocalProduct(lieProduct(screw_37, screw_38),screw_T3);
        0, 0, 0, 0, 0, 0];
H_Ja1 = J_FKL' * (pinv(J_FK1))' * H_a1 * pinv(J_FK1) * J_FKL;
H_Ja2 = J_FKL' * (inv(J_FK2))' * H_a2 * inv(J_FK2) * J_FKL;
H_Ja3 = J_FKL' * (inv(J_FK3))' * H_a3 * inv(J_FK3) * J_FKL;

H_c1 = [0, screwReciprocalProduct(lieProduct(screw_12, screw_13),screw_C1), screwReciprocalProduct(lieProduct(screw_12, screw_14),screw_C1);
        0, 0, screwReciprocalProduct(lieProduct(screw_13, screw_14),screw_C1);
        0, 0, 0];
H_c2 = [0, screwReciprocalProduct(lieProduct(screw_12, screw_13),screw_C2), screwReciprocalProduct(lieProduct(screw_12, screw_14),screw_C2);
        0, 0, screwReciprocalProduct(lieProduct(screw_13, screw_14),screw_C2);
        0, 0, 0];
H_c3 = [0, screwReciprocalProduct(lieProduct(screw_12, screw_13),screw_C3), screwReciprocalProduct(lieProduct(screw_12, screw_14),screw_C3);
        0, 0, screwReciprocalProduct(lieProduct(screw_13, screw_14),screw_C3);
        0, 0, 0];
H_Jc1 = J_FKL' * (pinv(J_FK1))' * H_c1 * pinv(J_FK1) * J_FKL;
H_Jc2 = J_FKL' * (pinv(J_FK1))' * H_c2 * pinv(J_FK1) * J_FKL;
H_Jc3 = J_FKL' * (pinv(J_FK1))' * H_c3 * pinv(J_FK1) * J_FKL;

J_FKL_inv = inv(Jq3) * Jx(1:3,:);
q_a = inv(G_q) * G_A(1:3,:) * A_L - [inv(G_q) zeros(3,3)] * [S_L' * (J_FKL_inv)' *  H_Ja1(1:3, 1:3) * J_FKL_inv * S_L; S_L' * (J_FKL_inv)' *  H_Ja2(1:3, 1:3) * J_FKL_inv * S_L;
                                                             S_L' * (J_FKL_inv)' *  H_Ja3(1:3, 1:3) * J_FKL_inv * S_L; S_L' * (J_FKL_inv)' *  H_Jc1(1:3, 1:3) * J_FKL_inv * S_L; 
                                                             S_L' * (J_FKL_inv)' *  H_Jc2(1:3, 1:3) * J_FKL_inv * S_L; S_L' * (J_FKL_inv)' *  H_Jc3(1:3, 1:3) * J_FKL_inv * S_L];
end
