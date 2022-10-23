function output_walkingPSP = walkLegExeMechPositionIK(xF,yF,zF)
%% 固有参数
% 执行机构全局变量
global l1 l2 l3 l4
global theta_p p1 p2x p2y p2z p3x p3y p3z l1x
global alpha1_min alpha1_max alpha2_min alpha2_max alpha3_min alpha3_max 
global beta1_min beta1_max beta2_min beta2_max beta3_min beta3_max
global gamma1_min gamma1_max gamma2_min gamma2_max gamma3_min gamma3_max
global phi1_initial phi2_initial phi3_initial
% 坐标变换变量
global S2_A S3_A
global T_R1_C T_R2_C T_R3_C 

% 求各驱动杆转动关节、虎克铰、球副的相关转角
% xF,yF,zF表示末端踝关节球副S1相对C系的位置坐标
% 本程序中，l3表示右侧辅缓冲器；l4表示主缓冲器外套筒
% output_walkingPSP的输出为[]或[alpha1  beta1  gamma1  alpha2  beta2  gamma2  alpha3  beta3  gamma3]


%% 准备部分
S1_C   =[xF; yF; zF];

%% limb 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% limb1 位置反解
S1_R1 = [eye(3),zeros(3,1)] * inv(T_R1_C) * [S1_C;1];
x=S1_R1(1);
y=S1_R1(2);
z=S1_R1(3);

gamma1 = asin( (x*sin(phi1_initial)-y*cos(phi1_initial)) / (l1+l4) );
if isreal(gamma1)==0
    output_walkingPSP = [];
    return
end

A_beta1=2*p1*l1x;
B_beta1=2*cos(gamma1)*p1*(l1+l4);
C_beta1=x^2+y^2+z^2-p1^2-(l1+l4)^2;

if (A_beta1+C_beta1)==0
    u=(C_beta1-A_beta1)/(2*B_beta1);
    beta1_vector=atan2(2*u,1-u^2);
elseif (A_beta1^2+B_beta1^2-C_beta1^2)>=0
    u1=(B_beta1-sqrt(A_beta1^2+B_beta1^2-C_beta1^2))/(A_beta1+C_beta1);
    u2=(B_beta1+sqrt(A_beta1^2+B_beta1^2-C_beta1^2))/(A_beta1+C_beta1);
    beta1_vector=[atan2(2*u1,1-u1^2),atan2(2*u2,1-u2^2)];
else
    output_walkingPSP = [];
    return
end
beta1=beta1_vector(1);

alpha1 = atan2(  (  ( -(l1+l4)*sin(phi1_initial)*cos(beta1)*sin(gamma1)-z*cos(phi1_initial)*sin(beta1)+x*cos(beta1) ) * (l1+l4) * cos(gamma1)  -  p1*z*cos(phi1_initial) +l1x * ((l1+l4) * sin(phi1_initial)*sin(beta1)*sin(gamma1)-z*cos(phi1_initial)*cos(beta1)-x*sin(beta1)) ) ,...
                            (  ( -(l1+l4)*sin(phi1_initial)*sin(beta1)*sin(gamma1)+z*cos(phi1_initial)*cos(beta1)+x*sin(beta1) ) * (l1+l4) * cos(gamma1)  +  p1*(x-(l1+l4)*sin(phi1_initial)*sin(gamma1)) + l1x * (x*cos(beta1)-z*cos(phi1_initial)*sin(beta1)-(l1+l4) * sin(phi1_initial)*cos(beta1)*sin(gamma1))  )   );


% limb1 位置正解
% 求T_U1_R1 , T_U1_C
T_U1_R1_M1 = [cos(phi1_initial), -sin(phi1_initial), 0, 0     ;     sin(phi1_initial), cos(phi1_initial), 0, 0     ;     0, 0, 1, 0     ;     0, 0, 0, 1];
T_U1_R1_M2 = [cos(alpha1), 0, sin(alpha1), 0     ;     0, 1, 0, 0     ;     -sin(alpha1), 0, cos(alpha1), 0     ;     0, 0, 0, 1];
T_U1_R1_M3 = [1, 0, 0, p1     ;     0, 1, 0, 0     ;     0, 0, 1, 0     ;     0, 0, 0, 1];
T_U1_R1_M4 = [cos(beta1), 0, sin(beta1), 0     ;     0, 1, 0, 0     ;     -sin(beta1), 0, cos(beta1), 0     ;     0, 0, 0, 1];
T_U1_R1_M5 = [1, 0, 0, 0     ;     0, cos(gamma1), -sin(gamma1), 0     ;     0, sin(gamma1), cos(gamma1), 0     ;    0, 0, 0, 1];
T_U1_R1 = T_U1_R1_M1 * T_U1_R1_M2 * T_U1_R1_M3 * T_U1_R1_M4 * T_U1_R1_M5;
T_A_U1 = [1, 0, 0, 0     ;     0, 0, -1, 0     ;     0, 1, 0, l4     ;     0, 0, 0, 1];
% T_A_U1 = [1, 0, 0, l1x     ;     0, 0, -1, 0     ;     0, 1, 0, l4     ;     0, 0, 0, 1];
T_A_R1 = T_U1_R1*T_A_U1;
T_A_C   = T_R1_C*T_A_R1;
%     T_U1_C = T_R1_C*T_U1_R1;
% T_A_C*[S1_A;1]
% 其他点坐标与位置变换
S2_R2 = [eye(3),zeros(3,1)] * inv(T_R2_C) * T_A_C * [S2_A;1];
S3_R3 = [eye(3),zeros(3,1)] * inv(T_R3_C) * T_A_C * [S3_A;1];

sol_limb1 = [alpha1  beta1  gamma1];

%% limb 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = S2_R2(1);
y = S2_R2(2);
z = S2_R2(3);

% 先求gamma2，存在2解
A = 4 * l2^2 * (p2x^2+p2z^2) ;
E = x*sin(phi2_initial) - y*cos(phi2_initial) + p2y;
D = sin(theta_p) * (x^2+y^2+z^2-p2x^2-p2y^2-p2z^2-l2^2) - 2 * (p2y*sin(theta_p)+p2z*cos(theta_p)) * (y*cos(phi2_initial)-x*sin(phi2_initial)-p2y);
B = -4*D*l2*p2z - 8*p2x^2*l2*cos(theta_p)*E;
C = D^2 + 4*p2x^2*E^2 - (2*l2*p2x*sin(theta_p))^2;
gamma2_vector = [asin((-B+sqrt(B^2-4*A*C))/(2*A)) , asin((-B-sqrt(B^2-4*A*C))/(2*A))]; % gamma2存在2解
if isreal(gamma2_vector(1))==0 && isreal(gamma2_vector(2))==0
    output_walkingPSP = [];
    return
end

beta2_vector = atan2(  ( sin(theta_p)*(2*x*p2y*sin(phi2_initial)-2*y*p2y*cos(phi2_initial)+x^2+y^2+z^2-p2x^2+p2y^2-p2z^2-l2^2) + 2*p2z*((x*sin(phi2_initial)-y*cos(phi2_initial)+p2y)*cos(theta_p) - l2*sin(gamma2_vector) )   ) , ...
                                      ( 2*p2x*( l2*cos(theta_p)*sin(gamma2_vector)-x*sin(phi2_initial)+y*cos(phi2_initial)-p2y ) )   );
alpha2_vector = atan2(   (  ( cos(theta_p)*cos(beta2_vector)*(x*cos(phi2_initial)+y*sin(phi2_initial))-z*sin(beta2_vector) )*l2.*cos(gamma2_vector) + l2*sin(theta_p)*sin(gamma2_vector)*(x*cos(phi2_initial)+y*sin(phi2_initial)) +x*p2z*cos(phi2_initial) + y*p2z*sin(phi2_initial) - p2x*z  ) ,...
                                        (  ( z*cos(theta_p)*cos(beta2_vector)+sin(beta2_vector)*(x*cos(phi2_initial)+y*sin(phi2_initial)) )*l2.*cos(gamma2_vector) + l2*z*sin(theta_p)*sin(gamma2_vector) + p2x*x*cos(phi2_initial) + p2x*y*sin(phi2_initial) +p2z*z  )    );

sol_limb2(1,:) = [alpha2_vector(1)  beta2_vector(1)  gamma2_vector(1)];
sol_limb2(2,:) = [alpha2_vector(2)  beta2_vector(2)  gamma2_vector(2)];


%% limb 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=S3_R3(1);
y=S3_R3(2);
z=S3_R3(3);

% 先求gamma3，存在2解
A = 4 * l3^2 * (p3x^2+p3z^2) ;
E = x*sin(phi3_initial) - y*cos(phi3_initial) + (-p3y);
D = sin(-theta_p) * (x^2+y^2+z^2-p3x^2-(-p3y)^2-p3z^2-l3^2) - 2 * ((-p3y)*sin(-theta_p)+p3z*cos(-theta_p)) * (y*cos(phi3_initial)-x*sin(phi3_initial)-(-p3y));
B = -4*D*l3*p3z - 8*p3x^2*l3*cos(-theta_p)*E;
C = D^2 + 4*p3x^2*E^2 - (2*l3*p3x*sin(-theta_p))^2;
gamma3_vector = [asin((-B+sqrt(B^2-4*A*C))/(2*A)) , asin((-B-sqrt(B^2-4*A*C))/(2*A))]; % gamma2存在2解
if isreal(gamma3_vector(1))==0 && isreal(gamma3_vector(2))==0
    output_walkingPSP = [];
    return
end
% beta3_vector = atan2(  ( sin(-theta_p)*(2*x*(-p3y)*sin(phi3_initial)-2*y*(-p3y)*cos(phi3_initial)+x^2+y^2+z^2-p3x^2+(-p3y)^2-p3z^2-l3^2) + 2*p3z*((x*sin(phi3_initial)-y*cos(phi3_initial)+(-p3y))*cos(-theta_p) - l3*sin(gamma3_vector) )   ),...
%                                       ( 2*p3x*( l3*cos(-theta_p)*sin(gamma3_vector)-x*sin(phi3_initial)+y*cos(phi3_initial)-(-p3y) ) )   );
% 
% 
% alpha3_vector = atan2(   (  ( cos(-theta_p)*cos(beta3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial))-z*sin(beta3_vector) )*l3.*cos(gamma3_vector) + l3*sin(-theta_p)*sin(gamma3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial)) +x*p3z*cos(phi3_initial) + y*p3z*sin(phi3_initial) - p3x*z  ),...
%                                         (  ( z*cos(-theta_p)*cos(beta3_vector)+sin(beta3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial)) )*l3.*cos(gamma3_vector) + l3*z*sin(-theta_p)*sin(gamma3_vector) + p3x*x*cos(phi3_initial) + p3x*y*sin(phi3_initial) +p3z*z  )    );
%  for j=1:length(alpha3_vector)
%      if alpha3_vector(j)>pi/2
%          alpha3_vector(j)=alpha3_vector(j)-pi;
%      end
%      if alpha3_vector(j)<-pi/2
%         alpha3_vector(j)=alpha3_vector(j)+pi;
%      end
%  end
 
% beta3_vector = atan(  ( sin(-theta_p)*(2*x*(-p3y)*sin(phi3_initial)-2*y*(-p3y)*cos(phi3_initial)+x^2+y^2+z^2-p3x^2+(-p3y)^2-p3z^2-l3^2) + 2*p3z*((x*sin(phi3_initial)-y*cos(phi3_initial)+(-p3y))*cos(-theta_p) - l3*sin(gamma3_vector) )   )./ ...
%                                       ( 2*p3x*( l3*cos(-theta_p)*sin(gamma3_vector)-x*sin(phi3_initial)+y*cos(phi3_initial)-(-p3y) ) )   );
% 
% alpha3_vector = atan(   (  ( cos(-theta_p)*cos(beta3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial))-z*sin(beta3_vector) )*l3.*cos(gamma3_vector) + l3*sin(-theta_p)*sin(gamma3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial)) +x*p3z*cos(phi3_initial) + y*p3z*sin(phi3_initial) - p3x*z  )./...
%                                         (  ( z*cos(-theta_p)*cos(beta3_vector)+sin(beta3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial)) )*l3.*cos(gamma3_vector) + l3*z*sin(-theta_p)*sin(gamma3_vector) + p3x*x*cos(phi3_initial) + p3x*y*sin(phi3_initial) +p3z*z  )    );


% % 先求gamma3，存在2解  原始备份
% A = 4 * l3^2 * (p3x^2+p3z^2) ;
% E = x*sin(phi3_initial) - y*cos(phi3_initial) - p3y;
% D = -sin(theta_p) * (x^2+y^2+z^2-p3x^2-p3y^2-p3z^2-l3^2) - 2 * (p3y*sin(theta_p)+p3z*cos(theta_p)) * (y*cos(phi3_initial)-x*sin(phi3_initial)+p3y);
% B = -4*D*l3*p3z - 8*p3x^2*l3*cos(theta_p)*E;
% C = D^2 + 4*p3x^2*E^2 - (2*l3*p3x*sin(theta_p))^2;
% gamma3_vector = [asin((-B+sqrt(B^2-4*A*C))/(2*A)) , asin((-B-sqrt(B^2-4*A*C))/(2*A))]; % gamma3存在2解
% if isreal(gamma3_vector(1))==0 && isreal(gamma3_vector(2))==0
%     output_walkingPSP = [];
%     return
% end
% 
beta3_vector = atan2(  ( sin(theta_p)*(-2*x*p3y*sin(phi3_initial)+2*y*p3y*cos(phi3_initial)+x^2+y^2+z^2-p3x^2+p3y^2-p3z^2-l3^2) - 2*p3z*((x*sin(phi3_initial)-y*cos(phi3_initial)-p3y)*cos(theta_p) - l3*sin(gamma3_vector) )   ) , ...
                                      ( -2*p3x*( l3*cos(theta_p)*sin(gamma3_vector)-x*sin(phi3_initial)+y*cos(phi3_initial)+p3y ) )   );%这一段出错，导致结果有误差

alpha3_vector = atan2(   (  ( cos(theta_p)*cos(beta3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial))-z*sin(beta3_vector) )*l3.*cos(gamma3_vector) - l3*sin(theta_p)*sin(gamma3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial)) +x*p3z*cos(phi3_initial) + y*p3z*sin(phi3_initial) - p3x*z  ) ,...
                                        (  ( z*cos(theta_p)*cos(beta3_vector)+sin(beta3_vector)*(x*cos(phi3_initial)+y*sin(phi3_initial)) )*l3.*cos(gamma3_vector) - l3*z*sin(theta_p)*sin(gamma3_vector) + p3x*x*cos(phi3_initial) + p3x*y*sin(phi3_initial) +p3z*z  )    );

sol_limb3(1,:) = [alpha3_vector(1)  beta3_vector(1)  gamma3_vector(1)];
sol_limb3(2,:) = [alpha3_vector(2)  beta3_vector(2)  gamma3_vector(2)];


%% 经过以上得到未筛分解集，包含虚数解 和 超过工作空间约束条件之解
all_multiSol = [sol_limb1   sol_limb2(1,:)   sol_limb3(1,:);
                         sol_limb1   sol_limb2(1,:)   sol_limb3(2,:);
                         sol_limb1   sol_limb2(2,:)   sol_limb3(1,:);
                         sol_limb1   sol_limb2(2,:)   sol_limb3(2,:)]; % all_multiSol维数4*9


%% 从解集all_multiSol中筛分出同时满足实数条件和工作空间约束条件之解集(part_multiSol)
part_multiSol = [];

for i = 1:4
    alpha1 = all_multiSol(i,1);   beta1 = all_multiSol(i,2);   gamma1 = all_multiSol(i,3);
    alpha2 = all_multiSol(i,4);   beta2 = all_multiSol(i,5);   gamma2 = all_multiSol(i,6);
    alpha3 = all_multiSol(i,7);   beta3 = all_multiSol(i,8);   gamma3 = all_multiSol(i,9);
    
     if    (isreal(alpha1)==1)  &&  (isreal(beta1)==1)  &&  (isreal(gamma1)==1) &&...
          (isreal(alpha2)==1)  &&  (isreal(beta2)==1)  &&  (isreal(gamma2)==1) &&...
          (isreal(alpha3)==1)  &&  (isreal(beta3)==1)  &&  (isreal(gamma3)==1) &&... 
          (alpha1<=alpha1_max) && (alpha1>=alpha1_min) &&...
          (alpha2<=alpha2_max) && (alpha2>=alpha2_min) &&...
          (alpha3<=alpha3_max) && (alpha3>=alpha3_min) &&...
          (beta1<=beta1_max)  && (beta1>=beta1_min) &&...
          (beta2<=beta2_max)  && (beta2>=beta2_min) &&...
          (beta3<=beta3_max)  && (beta3>=beta3_min) &&...
          (gamma1<=gamma1_max) && (gamma1>=gamma1_min) &&...
          (gamma2<=gamma2_max) && (gamma2>=gamma2_min) &&...
          (gamma3<=gamma3_max) && (gamma3>=gamma3_min)
    
%     if    (isreal(alpha1)==1)  &&  (isreal(beta1)==1)  &&  (isreal(gamma1)==1) &&...
%           (isreal(alpha2)==1)  &&  (isreal(beta2)==1)  &&  (isreal(gamma2)==1) &&...
%           (isreal(alpha3)==1)  &&  (isreal(beta3)==1)  &&  (isreal(gamma3)==1) 
          part_multiSol = [part_multiSol ; all_multiSol(i,:)];
    end   
end


%% 进一步筛分出唯一解，即：PSP(practical solution pattern)
if isempty(part_multiSol)==1
    output_walkingPSP = [];
    return
end

part_multiSol_alpha1 = part_multiSol(:,1);
part_multiSol_alpha2 = part_multiSol(:,4);
part_multiSol_alpha3 = part_multiSol(:,7);
% 
% stroke_alpha1 = abs(part_multiSol_alpha1-ALPHA(1));
% stroke_alpha2 = abs(part_multiSol_alpha2-ALPHA(2));
% stroke_alpha3 = abs(part_multiSol_alpha3-ALPHA(3));
stroke_alpha1 = abs(part_multiSol_alpha1-0);
stroke_alpha2 = abs(part_multiSol_alpha2-0);
stroke_alpha3 = abs(part_multiSol_alpha3-0);
% 
sum_stroke_alpha = stroke_alpha1+stroke_alpha2+stroke_alpha3;
row_of_PSP = find(sum_stroke_alpha==min(sum_stroke_alpha));
output_walkingPSP = part_multiSol(row_of_PSP,:);
% output_walkingPSP=part_multiSol;
end