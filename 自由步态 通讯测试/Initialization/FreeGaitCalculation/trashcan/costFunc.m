function f = costFunc(Body_in_global, Body_in_global0, Foot_in_global)
% x: x y z alpha beta gamma �������������
% x0: �������������ĳ�ʼֵ������x0 y0 z0����������global�е�λ�ã� alpha beta gamma ��Ϊ0
% Foot_in_gobal: �����global�е����꣬x y z��������������������
omiga1 = 1; omiga2 = 2; omiga3 = 3;

f1 = omiga1 * norm(Body_in_global(1:3) - Body_in_global0(1:3))^2;
f3 = omiga3 * ((Body_in_global(1)^2 + Body_in_global(2)^2) / (2 * Body_in_global0(3) * Body_in_global(1)) + 4 * Body_in_global(3)/Body_in_global(1));

Rm = eul2rotm([Body_in_global(4), Body_in_global(5), Body_in_global(6)]); % Ĭ��ת����ZYX������x��תgamma
Pm = [Body_in_global(1); Body_in_global(2); Body_in_global(3)];
T = zeros(4);
T(1:3,1:3) = inv(Rm); T(1:3,4) = -Rm\Pm; T(4,4) = 1;
Foot_in_Body = T * [Foot_in_global; [1 1 1 1]]; % ������body�����꣬�������У����һ��Ϊ1

% ������body�еĳ�ʼλ��
MatFromTXT = dlmread('IniPos_5Points.txt');
Foot_in_Body_Optimal = MatFromTXT(1:4,:); % �������о�����ֻ�ź���������
Foot_in_Body_Optimal(:,1) = Foot_in_Body_Optimal(:,1) - MatFromTXT(5,1);
Foot_in_Body_Optimal(:,2) = Foot_in_Body_Optimal(:,2) - MatFromTXT(5,2);
Foot_in_Body_Optimal(:,3) = Foot_in_Body_Optimal(:,3) - MatFromTXT(5,3);
Foot_in_Body_Optimal = Foot_in_Body_Optimal'; % �������о�����ֻ�ź���������

f2 = omiga2 * norm(Foot_in_Body - Foot_in_Body_Optimal,'fro');

f = f1 + f2 + f3;

fun = @(x)1+x(1)/(1+x(2)) - 3*x(1)*x(2) + x(2)*(1+x(1));
lb = [0,0];
ub = [1,2];
A = [];
b = [];
Aeq = [];
beq = [];
x0 = [0.5,1];
x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub)

end