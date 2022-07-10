function x = find_BodyPose(x0, BODY_temp, A, b, lb, ub, Incentre)
% x(Body_in_global): x y z alpha beta gamma �������������
% x0: �������������ĳ�ʼֵ������x0 y0 z0����������global�е�λ�ã� alpha beta gamma ��Ϊ0
% Foot_in_gobal: �����global�е����꣬x y z��������������������
omiga1 = 1e-5; omiga2 = 2e-2; omiga3 = 30;

OptimalHeight = BODY_temp.Body(15);
Foot_in_global = [BODY_temp.Body(1:4) BODY_temp.Body(6:9) BODY_temp.Body(11:14)]'; % �ŵ�λ��

% f1 = omiga1 * norm(x(1:3) - x0(1:3))^2;
% f3 = omiga3 * ((x(1)^2 + x(2)^2) / (2 * x0(3) * x(1)) + 4 * x(3)/x(1));
%
% Rm = eul2rotm([x(4), x(5), x(6)]); % Ĭ��ת����ZYX������x��תgamma
% Pm = [x(1); x(2); x(3)];
% T = zeros(4);
% T(1:3,1:3) = inv(Rm); T(1:3,4) = -Rm\Pm; T(4,4) = 1;
% Foot_in_Body = T * [Foot_in_global; [1 1 1 1]]; % ������body�����꣬�������У����һ��Ϊ1
%
% ������body�еĳ�ʼλ��
MatFromTXT = dlmread('IniPos_5Points.txt');
Foot_in_Body_Optimal = MatFromTXT(1:4,:); % �������о�����ֻ�ź���������
Foot_in_Body_Optimal(:,1) = Foot_in_Body_Optimal(:,1) - MatFromTXT(5,1);
Foot_in_Body_Optimal(:,2) = Foot_in_Body_Optimal(:,2) - MatFromTXT(5,2);
Foot_in_Body_Optimal(:,3) = Foot_in_Body_Optimal(:,3) - MatFromTXT(5,3);
Foot_in_Body_Optimal = Foot_in_Body_Optimal'; % �������о�����ֻ�ź���������
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