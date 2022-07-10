function StepForBody = Optimise_NextBody(BODY_FOR_CALU, alpha, index, BodyStep)
%% 先找到身体工作空间的外壳
dis = 6.25;
% 这个x/y的范围足够大，能包括起四条腿的工作空间，然后取并，求身体的工作空间
xBoundry(1) = min([BODY_FOR_CALU.Leg(1).map_x(1,1) BODY_FOR_CALU.Leg(2).map_x(1,1) BODY_FOR_CALU.Leg(3).map_x(1,1) BODY_FOR_CALU.Leg(4).map_x(1,1)]);
xBoundry(2) = max([BODY_FOR_CALU.Leg(1).map_x(1,end) BODY_FOR_CALU.Leg(2).map_x(1,end) BODY_FOR_CALU.Leg(3).map_x(1,end) BODY_FOR_CALU.Leg(4).map_x(1,end)]);
yBoundry(1) = max([BODY_FOR_CALU.Leg(1).map_y(1,1) BODY_FOR_CALU.Leg(2).map_y(1,1) BODY_FOR_CALU.Leg(3).map_y(1,1) BODY_FOR_CALU.Leg(4).map_y(1,1)]);
yBoundry(2) = min([BODY_FOR_CALU.Leg(1).map_y(end,1) BODY_FOR_CALU.Leg(2).map_y(end,1) BODY_FOR_CALU.Leg(3).map_y(end,1) BODY_FOR_CALU.Leg(4).map_y(end,1)]);

step_x = linspace(xBoundry(1), xBoundry(2), (xBoundry(2)-xBoundry(1))/dis+1); % x从小到大 y从大到小
step_y = linspace(yBoundry(1), yBoundry(2), (yBoundry(1)-yBoundry(2))/dis+1);
BODY_FOR_CALU.len_x = length(step_x);
BODY_FOR_CALU.len_y = length(step_y);
map_x = repmat(step_x,BODY_FOR_CALU.len_y,1);
map_y = repmat(step_y,BODY_FOR_CALU.len_x,1); map_y = map_y';

% 只需要找map_x_body对应的值即可，因为输出的bit在map_x和map_y相同
[Bit_map_body, map_z_up, map_z_down] = optimiseBodyArea(BODY_FOR_CALU, step_x, step_y, size(map_x));

% 上述map和bit都是建立在脚的公共工作空间下的，反应到身体上还需要取反
Bit_map_body = rot90(Bit_map_body,2);
map_z_up = rot90(map_z_up,2); map_z_down = rot90(map_z_down,2);
map_x = rot90(map_x,2); map_y = rot90(map_y,2); 
map_x = -map_x; map_y = -map_y;
map_z_temp = map_z_down;
map_z_down = -map_z_up; map_z_up = -map_z_temp;

%% 找到外壳后拟合曲面
% regress多项式拟合。将多项式各项都视为自变量，进行线性拟合
sizePoints = size(map_x);
fitPoints_x = reshape(map_x, [sizePoints(1)*sizePoints(2), 1]); fitPoints_y = reshape(map_y, [sizePoints(1)*sizePoints(2), 1]);
fitPoints_z_up = reshape(map_z_up, [sizePoints(1)*sizePoints(2), 1]); fitPoints_z_down = reshape(map_z_down, [sizePoints(1)*sizePoints(2), 1]);
% x = [fitPoints_x; fitPoints_x]; y = [fitPoints_y; fitPoints_y];
% z = [fitPoints_z_up; fitPoints_z_down]; % 一对(x,y)对应两个z值，所以先将所有点全部展开
x = [fitPoints_x]; y = [fitPoints_y];
z = [fitPoints_z_up]; % 一对(x,y)对应两个z值，所以先将所有点全部展开
posNAN = isnan(z);
x(posNAN) = []; y(posNAN) = []; z(posNAN) = [];

c = ones(length(x),1); % 常数项
b = regress(z,[x.^3, x.^2.*y, x.*y.^2, y.^3, x.^2, x.*y, y.*2, x, y, c]); % 添加非线性项进行拟合.这里取三次多项式
% b就是上述各项的系数。拟合函数就是
% z = b(1)*x3 + b(2)*x2y + b(3)*xy2 + b(4)* y3 + b(5)*x2 + b(6)*xy + b(7)*y2 + b(8)*x + b(9)*y + b(10)*c 
% 【现在的问题是，拟合的效果不好，找不到曲面（也即优化函数的边界条件）】

%{
a = min(BODY_FOR_CALU.FootLocalPos(1:4,1)); % 四只脚的a
b = min(BODY_FOR_CALU.FootLocalPos(5:8,1)); % 四只脚的b
c = min(BODY_FOR_CALU.FootLocalPos(9:12,1)); % 四只脚的c
d = min(BODY_FOR_CALU.FootLocalPos(13:16,1)); % 四只脚的d
e = min(BODY_FOR_CALU.FootLocalPos(17:20,1)); % 四只脚的e
f = min(BODY_FOR_CALU.FootLocalPos(21:24,1)); % 四只脚的f
a_angle = BODY_FOR_CALU.RotateAngle(1:3) - BODY_FOR_CALU.RotateAngle_Boundry(1,:); % [gamma beta alpha]_下界
b_angle = BODY_FOR_CALU.RotateAngle_Boundry(2,:) - BODY_FOR_CALU.RotateAngle(1:3); % 身体转动允许范围 [gamma beta alpha]_上界

% 将之前的计算结果BodyStep设为初值
x0 = BodyStep + [BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10) BODY_FOR_CALU.Body(15)];
x0 = [x0 BODY_FOR_CALU.RotateAngle(1:3)];
bodyarea_lb = [BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10) BODY_FOR_CALU.Body(15)] - [b d f];
bodyarea_ub = [BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10) BODY_FOR_CALU.Body(15)] + [a c e];
lb = bodyarea_lb - x0(1:3); lb(4:6) = -a_angle;
ub = bodyarea_ub - x0(1:3); ub(4:6) = b_angle;
lb = lb + x0; ub = ub + x0;

% x0 = [BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10) BODY_FOR_CALU.Body(15) BODY_FOR_CALU.RotateAngle(1:3)]; % 优化函数的初值
% x0 = x0 + [a c 0 0 0 0];
% lb = [-a-b, -c-d, -e, -a_angle] + x0; % 身体位姿移动下界
% ub = [0, 0, f, b_angle] + x0; % 身体位姿移动上界
[A, b, Incentre] = find_Constraints(BODY_FOR_CALU, index);
A(:,3:6) = 0;
Incentre(3) = x0(3);
Aeq = [];
beq = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% StepForBody = find_BodyPose(x0, BODY_FOR_CALU, A, b, lb, ub, Incentre);

% x(Body_in_global): x y z alpha beta gamma 是六个输入参数
% x0: 上述六个参数的初始值，其中x0 y0 z0就是身体在global中的位置， alpha beta gamma 均为0
omiga1 = 1e-2*3; omiga2 = 1e-2*3; omiga3 = 5*1;
OptimalHeight = BODY_FOR_CALU.Body(15);

Foot_in_global = [BODY_FOR_CALU.Body(1:4)'; BODY_FOR_CALU.Body(6:9)'; BODY_FOR_CALU.Body(11:14)'; 1 1 1 1]; % 脚的位置
Apex_in_body = [BODY_FOR_CALU.Body(16:19)'; BODY_FOR_CALU.Body(20:23)'; BODY_FOR_CALU.Body(24:27)'; 2 2 2 2] - repmat([BODY_FOR_CALU.Body(5); BODY_FOR_CALU.Body(10); BODY_FOR_CALU.Body(15); 1],1,4); % 顶点的位置
% T_Body_in_global = [eul2rotm([x(4), x(5), x(6)]), [BODY_FOR_CALU.Body(5); BODY_FOR_CALU.Body(10); BODY_FOR_CALU.Body(15)]; 0 0 0 1];
% Apex_in_global = T_Body_in_global * Apex_in_body;
% Foot_in_Apex = Foot_in_global - Apex_in_global;
% Foot_in_Apex_Optimal = [BODY_FOR_CALU.Body(1:4)'; BODY_FOR_CALU.Body(6:9)'; BODY_FOR_CALU.Body(11:14)'; 1 1 1 1] - [BODY_FOR_CALU.Body(16:19)'; BODY_FOR_CALU.Body(20:23)'; BODY_FOR_CALU.Body(24:27)'; 1 1 1 1];
Foot_in_Apex_Optimal = 1.0e+03 * ...
[   0.5593    0.5494   -0.2559   -0.1269
   -0.3640    0.4341    0.3011   -0.3423
   -1.2000   -1.2000   -1.2000   -1.2000
         0         0         0         0];
% f2 = norm(Foot_in_Apex - Foot_in_Apex_Optimal,'fro');


% x = x0 + [359.999980680438,289.999976899231,0,-1.81866513108100e-05,-3.64106325470073e-10,-1.08879437674435e-10]
% Foot_in_global = [BODY_FOR_CALU.Body(1:4)'; BODY_FOR_CALU.Body(6:9)'; BODY_FOR_CALU.Body(11:14)'; 1 1 1 1] % 脚的位置
% Apex_in_body = [BODY_FOR_CALU.Body(16:19)'; BODY_FOR_CALU.Body(20:23)'; BODY_FOR_CALU.Body(24:27)'; 2 2 2 2] - repmat([BODY_FOR_CALU.Body(5); BODY_FOR_CALU.Body(10); BODY_FOR_CALU.Body(15); 1],1,4) % 顶点的位置
% T_Body_in_global = [eul2rotm([x(4), x(5), x(6)]), [x(1); x(2); x(3)]; 0 0 0 1]
% Apex_in_global = T_Body_in_global * Apex_in_body
% Foot_in_Apex = Foot_in_global - Apex_in_global
% % Foot_in_Apex_Optimal = [BODY_FOR_CALU.Body(1:4)'; BODY_FOR_CALU.Body(6:9)'; BODY_FOR_CALU.Body(11:14)'; 1 1 1 1] - [BODY_FOR_CALU.Body(16:19)'; BODY_FOR_CALU.Body(20:23)'; BODY_FOR_CALU.Body(24:27)'; 1 1 1 1]
% Foot_in_Apex_Optimal = 1.0e+03 * ...
% [    0.5593    0.5494   -0.2559   -0.1269
%    -0.3640    0.4341    0.3011   -0.3423
%    -1.2000   -1.2000   -1.2000   -1.2000
%          0         0         0         0];
% Foot_in_Apex - Foot_in_Apex_Optimal
% f2 = norm(Foot_in_Apex - Foot_in_Apex_Optimal,'fro')
% f1 = norm(x(1:3) - Incentre(1:3))
% f3 = (x(3)-OptimalHeight) / (norm([x(1)-BODY_FOR_CALU.Body(5),x(2)-BODY_FOR_CALU.Body(10)]) * cos(alpha - atan2(x(2)-BODY_FOR_CALU.Body(10), x(1)-BODY_FOR_CALU.Body(5))))

f1 = @(x) norm(x(1:3) - Incentre(1:3));
f2 = @(x) norm(Foot_in_global - [eul2rotm([x(4), x(5), x(6)]), ...
    [x(1); x(2); x(3)]; 0 0 0 1] * Apex_in_body - Foot_in_Apex_Optimal,'fro');
f3 = @(x) abs(x(3)-OptimalHeight) / (norm([x(1)-BODY_FOR_CALU.Body(5),x(2)-BODY_FOR_CALU.Body(10)]) * cos(alpha - atan2(x(2)-BODY_FOR_CALU.Body(10), x(1)-BODY_FOR_CALU.Body(5))));
fun = @(x) omiga1*f1(x) + omiga2*f2(x) + omiga3*f3(x);

StepForBody = fmincon(fun,x0,A,b,Aeq,beq,lb,ub);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
StepForBody = StepForBody - [BODY_FOR_CALU.Body(5) BODY_FOR_CALU.Body(10) BODY_FOR_CALU.Body(15) BODY_FOR_CALU.RotateAngle(1:3)];
%}

end