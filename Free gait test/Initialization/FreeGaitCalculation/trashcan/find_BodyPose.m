function x = find_BodyPose(x0, BODY_temp, A, b, lb, ub, Incentre)
% x(Body_in_global): x y z alpha beta gamma 是六个输入参数
% x0: 上述六个参数的初始值，其中x0 y0 z0就是身体在global中的位置， alpha beta gamma 均为0
% Foot_in_gobal: 足端在global中的坐标，x y z三个参数，共三行四列
omiga1 = 1e-5; omiga2 = 2e-2; omiga3 = 30;

OptimalHeight = BODY_temp.Body(15);
Foot_in_global = [BODY_temp.Body(1:4) BODY_temp.Body(6:9) BODY_temp.Body(11:14)]'; % 脚的位置

% f1 = omiga1 * norm(x(1:3) - x0(1:3))^2;
% f3 = omiga3 * ((x(1)^2 + x(2)^2) / (2 * x0(3) * x(1)) + 4 * x(3)/x(1));
%
% Rm = eul2rotm([x(4), x(5), x(6)]); % 默认转角是ZYX，先绕x轴转gamma
% Pm = [x(1); x(2); x(3)];
% T = zeros(4);
% T(1:3,1:3) = inv(Rm); T(1:3,4) = -Rm\Pm; T(4,4) = 1;
% Foot_in_Body = T * [Foot_in_global; [1 1 1 1]]; % 四足在body中坐标，四行四列，最后一行为1
%
% 四足在body中的初始位置
MatFromTXT = dlmread('IniPos_5Points.txt');
Foot_in_Body_Optimal = MatFromTXT(1:4,:); % 四行三列矩阵，四只脚和三个坐标
Foot_in_Body_Optimal(:,1) = Foot_in_Body_Optimal(:,1) - MatFromTXT(5,1);
Foot_in_Body_Optimal(:,2) = Foot_in_Body_Optimal(:,2) - MatFromTXT(5,2);
Foot_in_Body_Optimal(:,3) = Foot_in_Body_Optimal(:,3) - MatFromTXT(5,3);
Foot_in_Body_Optimal = Foot_in_Body_Optimal'; % 三行四列矩阵，四只脚和三个坐标
Foot_in_Body_Optimal = [Foot_in_Body_Optimal; 0,0,0,1];
%
% f2 = omiga2 * norm(Foot_in_Body - Foot_in_Body_Optimal,'fro');
%
% f = f1 + f2 + f3;

% x = x0 + [200 200 200 0.1 0.1 0.1];
% f1 = @(x) norm(x(1:3) - Incentre(1:3))^2;
% f2 = @(x) norm(([inv(eul2rotm([x(4), x(5), x(6)])), -eul2rotm([x(4), x(5), x(6)])\[x(1); x(2); x(3)]; 0,0,0,1] * [Foot_in_global; [1 1 1 1]]) - Foot_in_Body_Optimal,'fro');
% s = norm([x(1)-BODY_temp.Body(5),x(2)-BODY_temp.Body(10)]) * cos(alpha - atan2(x(2)-BODY_temp.Body(10), x(1)-BODY_temp.Body(5)));
% f3 = @(x) (x(3)-OptimalHeight) / (norm([x(1)-BODY_temp.Body(5),x(2)-BODY_temp.Body(10)]) * cos(alpha - atan2(x(2)-BODY_temp.Body(10), x(1)-BODY_temp.Body(5))));
% fun = @(x) f1 + f2 + f3;

fun = @(x) omiga1 * norm(x(1:3) - Incentre(1:3))^2 + omiga3 * abs(x(3)-OptimalHeight) / norm([x(1)-BODY_temp.Body(5),x(2)-BODY_temp.Body(10)]) ...
    + omiga2 * norm(([inv(eul2rotm([x(4), x(5), x(6)])), -eul2rotm([x(4), x(5), x(6)])\[x(1); x(2); x(3)]; 0,0,0,1] * [Foot_in_global; [1 1 1 1]]) - Foot_in_Body_Optimal,'fro');


% lb = [x0(1:3)-1000, x0(4:6)-pi];
% ub = [x0(1:3)+1000, x0(4:6)+pi];
% A = [];
% b = [];
Aeq = [];
beq = [];
% x0 = [0.5,1];
x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub);

end