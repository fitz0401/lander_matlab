function contact_index = EndForce_Identify(foot_pos, motor_vel, motor_acc, motor_toq)
    %% 输出结果
    global Q_INT

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
    global T_Rv1_C T_Rv2_C T_Rv3_C T_U1_C T_U2_C T_U3_C
    % 刚体的速度旋量和加速度旋量
    global V_Rv1U1 V_Rv2U2 V_Rv3U3 V_U1S1 V_U2S2 V_U3S3
    global A_Rv1U1 A_Rv2U2 A_Rv3U3 A_U1S1 A_U2S2 A_U3S3
    % 雅可比矩阵
    global J_L J_Pc1 J_Pc2 J_Pc3 J_Lc1 J_Lc2 J_Lc3
    
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
    
    %% 固有惯性参数
    % 重力加速度
    g = [0 0 -9.80665]';
    % 质量
    m_Rv1U1 = 1.0425310;
    m_U1S1 = 3.3241411;
    m_Rv2U2 = 0.5015574;
    m_U2S2 = 1.4877009;
    m_Rv3U3 = 0.5015574;
    m_U3S3 = 1.4877009;
    % 惯性张量(重心处，对齐连杆坐标系)
    I_Rv1U1 = [0.0012958 -0.0000095 -0.0020764; -0.0000095 0.0091005 -0.0000014; -0.0020764 -0.0000014 0.0084908];
    I_U1S1 = [0.1265660 0.0000005 0.0003834; 0.0000005 0.1267067 -0.0000024; 0.0003834 -0.0000024 0.0024612];
    I_Rv2U2 = [0.0002956 -0.0000761 -0.0001044; -0.0000761 0.0014695 0.0000256; -0.0001044 0.0000256 0.0014526];
    I_U2S2 = [0.0103360 -0.0000004 0.0000308; -0.0000004 0.0103377 0.0002682; 0.0000308 0.0002682 0.0013921];
    I_Rv3U3 = [0.0002956 0.0000761 0.0001044; 0.0000761 0.0014695 0.0000256; 0.0001044 0.0000256 0.0014526];
    I_U3S3 = [0.0103360 0.0000004 0.0000271; 0.0000004 0.0103458 -0.0000009; 0.0000271 -0.0000009 0.0013841];
    % 重心位置(连杆坐标系下)
    T_mRv1U1_Rv1 = [1 0 0 -0.0248835; 0 1 0 0.0; 0 0 1 -0.0243398; 0 0 0 1];
    T_mU1S1_U1 = [1 0 0 -0.0020224; 0 1 0 0.0000057; 0 0 1 0.3446863; 0 0 0 1];
    T_mRv2U2_Rv2 = [1 0 0 0.0755365; 0 1 0 0.0031313; 0 0 1 0.0042612; 0 0 0 1];
    T_mU2S2_U2 = [1 0 0 -0.0002806; 0 1 0 -0.0044984; 0 0 1 0.1500066; 0 0 0 1];
    T_mRv3U3_Rv3 = [1 0 0 -0.0755365; 0 1 0 0.0031313; 0 0 1 0.0042612; 0 0 0 1];
    T_mU3S3_U3 = [1 0 0 -0.0002281; 0 1 0 0.0000105; 0 0 1 0.1500739; 0 0 0 1];
    
    %% 动力学求解
    xF = foot_pos(1);
    yF = foot_pos(2);
    zF = foot_pos(3);

    % 运动学反解
    output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF);                                                            
    alpha1 = output_walkingPSP(1);  beta1 = output_walkingPSP(2);  gamma1 = output_walkingPSP(3);
    alpha2 = output_walkingPSP(4);  beta2 = output_walkingPSP(5);  gamma2 = output_walkingPSP(6);
    alpha3 = output_walkingPSP(7);  beta3 = output_walkingPSP(8);  gamma3 = output_walkingPSP(9);
    
    % 传动机构雅可比
    d1 = walkLegPrimaryTransMechPositionIK(alpha1);
    theta2 = walkLegTransMechPositionIK2(alpha2);
    theta3 = walkLegTransMechPositionIK3(alpha3);
    JFK = walkLegTransMechJacobian(alpha3,theta3);
    Jtrans = diag([sqrt(d2^2 - 2*cos(alpha1-theta_d+theta_t0+theta_origin1-pi/2)*d2*d3 + d3^2) / (d2*d3*sin(alpha1-theta_d+theta_t0+theta_origin1-pi/2)), -JFK, JFK]);
    JMotor = diag([5/1000/(2*pi), 1, 1]);
    tao = inv(Jtrans * JMotor) * motor_toq;
    q_v = [Jtrans * motor_vel; 0; 0; 0];
    q_a = [0 0 0 0 0 0]';

    % 速度、加速度正解
    [w, v, aw, av] = walkLegExeMechAFK...
                   (xF,yF,zF,q_v,q_a,alpha1,alpha2,alpha3,beta1,beta2,beta3,gamma1,gamma2,gamma3);
    % 正解过程中同时获取计算质心参数的雅可比矩阵
    T_mRv1U1_C = T_Rv1_C * T_mRv1U1_Rv1;
    T_mRv2U2_C = T_Rv2_C * T_mRv2U2_Rv2;
    T_mRv3U3_C = T_Rv3_C * T_mRv3U3_Rv3;
    T_mU1S1_C = T_U1_C * T_mU1S1_U1;
    T_mU2S2_C = T_U2_C * T_mU2S2_U2;
    T_mU3S3_C = T_U3_C * T_mU3S3_U3;
    % 各连杆的质心位置 【已验证】
    mRv1U1_C = T_mRv1U1_C(1:3,4);
    mRv2U2_C = T_mRv2U2_C(1:3,4);
    mRv3U3_C = T_mRv3U3_C(1:3,4);
    mU1S1_C = T_mU1S1_C(1:3,4);
    mU2S2_C = T_mU2S2_C(1:3,4);
    mU3S3_C = T_mU3S3_C(1:3,4);

    %% 各构件质心速度正解 【已验证，受机构参数影响】
    v_Rv1U1 = [V_Rv1U1(1:3); V_Rv1U1(4:6) + cross(V_Rv1U1(1:3), mRv1U1_C)];
    v_Rv2U2 = [V_Rv2U2(1:3); V_Rv2U2(4:6) + cross(V_Rv2U2(1:3), mRv2U2_C)];
    v_Rv3U3 = [V_Rv3U3(1:3); V_Rv3U3(4:6) + cross(V_Rv3U3(1:3), mRv3U3_C)];
    v_U1S1 = [V_U1S1(1:3); V_U1S1(4:6) + cross(V_U1S1(1:3), mU1S1_C)];
    v_U2S2 = [V_U2S2(1:3); V_U2S2(4:6) + cross(V_U2S2(1:3), mU2S2_C)];
    v_U3S3 = [V_U3S3(1:3); V_U3S3(4:6) + cross(V_U3S3(1:3), mU3S3_C)]; 

    %% 各构件质心加速度正解 【已验证，受机构参数影响】
    a_Rv1U1 = [A_Rv1U1(1:3); A_Rv1U1(4:6) + cross(V_Rv1U1(1:3), V_Rv1U1(4:6)) + cross(A_Rv1U1(1:3), mRv1U1_C) ...
                             + cross(V_Rv1U1(1:3), cross(V_Rv1U1(1:3), mRv1U1_C))];
    a_Rv2U2 = [A_Rv2U2(1:3); A_Rv2U2(4:6) + cross(V_Rv2U2(1:3), V_Rv2U2(4:6)) + cross(A_Rv2U2(1:3), mRv2U2_C) ...
                             + cross(V_Rv2U2(1:3), cross(V_Rv2U2(1:3), mRv2U2_C))];
    a_Rv3U3 = [A_Rv3U3(1:3); A_Rv3U3(4:6) + cross(V_Rv3U3(1:3), V_Rv3U3(4:6)) + cross(A_Rv3U3(1:3), mRv3U3_C) ...
                             + cross(V_Rv3U3(1:3), cross(V_Rv3U3(1:3), mRv3U3_C))];
    a_U1S1 = [A_U1S1(1:3); A_U1S1(4:6) + cross(V_U1S1(1:3), V_U1S1(4:6)) + cross(A_U1S1(1:3), mU1S1_C) ...
                           + cross(V_U1S1(1:3), cross(V_U1S1(1:3), mU1S1_C))];
    a_U2S2 = [A_U2S2(1:3); A_U2S2(4:6) + cross(V_U2S2(1:3), V_U2S2(4:6)) + cross(A_U2S2(1:3), mU2S2_C) ...
                           + cross(V_U2S2(1:3), cross(V_U2S2(1:3), mU2S2_C))];
    a_U3S3 = [A_U3S3(1:3); A_U3S3(4:6) + cross(V_U3S3(1:3), V_U3S3(4:6)) + cross(A_U3S3(1:3), mU3S3_C) ...
                           + cross(V_U3S3(1:3), cross(V_U3S3(1:3), mU3S3_C))];
    
    %% 惯性张量矩阵变换【已验证】
    I_Rv1U1_G = T_Rv1_C(1:3,1:3) * I_Rv1U1 * T_Rv1_C(1:3,1:3)';
    I_U1S1_G = T_U1_C(1:3,1:3) * I_U1S1 * T_U1_C(1:3,1:3)';
    I_Rv2U2_G = T_Rv2_C(1:3,1:3) * I_Rv2U2 * T_Rv2_C(1:3,1:3)';
    I_U2S2_G = T_U2_C(1:3,1:3) * I_U2S2 * T_U2_C(1:3,1:3)';
    I_Rv3U3_G = T_Rv3_C(1:3,1:3) * I_Rv3U3 * T_Rv3_C(1:3,1:3)';
    I_U3S3_G = T_U3_C(1:3,1:3) * I_U3S3 * T_U3_C(1:3,1:3)';

    %% 各杆件受力
    Q_Rv1U1 = [-I_Rv1U1_G * a_Rv1U1(1:3) - cross(v_Rv1U1(1:3), I_Rv1U1_G * v_Rv1U1(1:3)); m_Rv1U1 * (g - a_Rv1U1(4:6))];
    Q_Rv2U2 = [-I_Rv2U2_G * a_Rv2U2(1:3) - cross(v_Rv2U2(1:3), I_Rv2U2_G * v_Rv2U2(1:3)); m_Rv2U2 * (g - a_Rv2U2(4:6))];
    Q_Rv3U3 = [-I_Rv3U3_G * a_Rv3U3(1:3) - cross(v_Rv3U3(1:3), I_Rv3U3_G * v_Rv3U3(1:3)); m_Rv3U3 * (g - a_Rv3U3(4:6))];
    Q_U1S1 = [-I_U1S1_G * a_U1S1(1:3) - cross(v_U1S1(1:3), I_U1S1_G * v_U1S1(1:3)); m_U1S1 * (g - a_U1S1(4:6))];
    Q_U2S2 = [-I_U2S2_G * a_U2S2(1:3) - cross(v_U2S2(1:3), I_U2S2_G * v_U2S2(1:3)); m_U2S2 * (g - a_U2S2(4:6))];
    Q_U3S3 = [-I_U3S3_G * a_U3S3(1:3) - cross(v_U3S3(1:3), I_U3S3_G * v_U3S3(1:3)); m_U3S3 * (g - a_U3S3(4:6))];

    %% 雅可比矩阵【已验证】
    pc1_x = [0 -mRv1U1_C(3) mRv1U1_C(2); mRv1U1_C(3) 0 -mRv1U1_C(1); -mRv1U1_C(2) mRv1U1_C(1) 0];
    pc2_x = [0 -mRv2U2_C(3) mRv2U2_C(2); mRv2U2_C(3) 0 -mRv2U2_C(1); -mRv2U2_C(2) mRv2U2_C(1) 0];
    pc3_x = [0 -mRv3U3_C(3) mRv3U3_C(2); mRv3U3_C(3) 0 -mRv3U3_C(1); -mRv3U3_C(2) mRv3U3_C(1) 0];
    lc1_x = [0 -mU1S1_C(3) mU1S1_C(2); mU1S1_C(3) 0 -mU1S1_C(1); -mU1S1_C(2) mU1S1_C(1) 0];
    lc2_x = [0 -mU2S2_C(3) mU2S2_C(2); mU2S2_C(3) 0 -mU2S2_C(1); -mU2S2_C(2) mU2S2_C(1) 0];
    lc3_x = [0 -mU3S3_C(3) mU3S3_C(2); mU3S3_C(3) 0 -mU3S3_C(1); -mU3S3_C(2) mU3S3_C(1) 0];
    J_Pc1 = [eye(3) zeros(3,3); -pc1_x eye(3)] * J_Pc1 * [eye(3); zeros(3,3)];
    J_Pc2 = [eye(3) zeros(3,3); -pc2_x eye(3)] * J_Pc2 * [eye(3); zeros(3,3)];
    J_Pc3 = [eye(3) zeros(3,3); -pc3_x eye(3)] * J_Pc3 * [eye(3); zeros(3,3)];
    J_Lc1 = [eye(3) zeros(3,3); -lc1_x eye(3)] * J_Lc1 * [eye(3); zeros(3,3)];
    J_Lc2 = [eye(3) zeros(3,3); -lc2_x eye(3)] * J_Lc2 * [eye(3); zeros(3,3)];
    J_Lc3 = [eye(3) zeros(3,3); -lc3_x eye(3)] * J_Lc3 * [eye(3); zeros(3,3)];

    %% 将重力和惯性力换算到驱动关节
%     tao_res = - (J_Pc1' * Q_Rv1U1 + J_Pc2' * Q_Rv2U2 + J_Pc3' * Q_Rv3U3) ... 
%               - (J_Lc1' * Q_U1S1 + J_Lc2' * Q_U2S2 + J_Lc3' * Q_U3S3);
%     tao_diff = tao - tao_res;
    Q_INT = -(inv(J_L(4:6,:)))' * (tao + J_Pc1' * Q_Rv1U1 + J_Pc2' * Q_Rv2U2 + J_Pc3' * Q_Rv3U3 ...
                                       + J_Lc1' * Q_U1S1 + J_Lc2' * Q_U2S2 + J_Lc3' * Q_U3S3);
    
    %% 触地检测判据
    if (abs(Q_INT(1))) > 100 && (abs(Q_INT(3)) > 200)
        contact_index = 1;
    else
        contact_index = 0;
    end
end
