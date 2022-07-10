% 用四个点拟合平面，并计算出身体应该走的高度和三个转角
function StepForBody = FitPlane(BODY_FOR_CALU,x,y,z)

% regress多项式拟合。将多项式都视为自变量，进行线性拟合
c = ones(length(x),1); % 常数项
b = regress(z,[x, y, c]); % 添加非线性项进行拟合
% b就是上述各项的系数。拟合函数就是 z = b(1)*x + b(2)*y + b(3)
P1 = [0,0,b(3)]; P2 = [1,0,b(1) + b(3)]; P3 = [0,1,b(2) + b(3)]; % 拟合平面上的三个点
fitPlaneNormal = cross(P1-P2, P1-P3); % 拟合平面的法向量
fitPlaneTheta = acos(dot(fitPlaneNormal,[0,0,1])/(norm(fitPlaneNormal)*norm([0,0,1]))); % 平面法向量和(0,0,1)的夹角
fitPlaneAxis = cross([0 0 1],fitPlaneNormal); % 转轴方向，绕该轴从(0,0,1)转到现在平面需要转theta角度
if abs(fitPlaneAxis - [0 0 0]) <= 1e-4
    % 说明平面完全平行于地面
    rotateAngle = [0 0 0];
else
    % 需要计算三个转角
    % rot:绕某一轴旋转某一角度生成旋转矩阵
    rotateAngle = rotm2eul(RotalongAxis(fitPlaneAxis,fitPlaneTheta),'XYZ'); % 绕动坐标系旋转
end
% 若超出范围，则规定最大只能在范围以内
% rotateAngle(rotateAngle < BODY_FOR_CALU.RotateAngle_Boundry(1,:) ) = BODY_FOR_CALU.RotateAngle_Boundry(1,(rotateAngle < BODY_FOR_CALU.RotateAngle_Boundry(1,:) ));
% rotateAngle(rotateAngle > BODY_FOR_CALU.RotateAngle_Boundry(2,:) ) = BODY_FOR_CALU.RotateAngle_Boundry(2,(rotateAngle > BODY_FOR_CALU.RotateAngle_Boundry(2,:) ));
% rotateAngle(abs(rotateAngle) < 1e-4) = 0; % 弧度1e-4以下不考虑，约为1角度
StepForBody(4:6) = round(rotateAngle,2); % 角度值取绝对值，不是相对于上一步的相对值

% % COGPlaneConstant = norm([b(1) b(2) -1]) + b(3); % 【2020.1625】是预设的理想高度（拟合平面到身体COG的高度）
% % StepForBody(3) = b(1)*BODY_FOR_CALU.Body0(5) + b(2)*BODY_FOR_CALU.Body0(10) + COGPlaneConstant - BODY_FOR_CALU.Body0(15);
% % 拟合平面为z = b(1)*x + b(2)*y + b(3)，带入x/y坐标，并减去现在的高度，即为要移动的高度
% StepForBody(3) = b(1)*BODY_FOR_CALU.Body0(5) + b(2)*BODY_FOR_CALU.Body0(10) + b(3) - BODY_FOR_CALU.Body0(15);
% if abs(StepForBody(3)) <= 1e-2
%     StepForBody(3) = 0;
% end

% COGPlaneConstant = norm([b(1) b(2) -1]) + b(3); % 【2020.1625】是预设的理想高度（拟合平面到身体COG的高度）
% StepForBody(3) = b(1)*BODY_FOR_CALU.Body0(5) + b(2)*BODY_FOR_CALU.Body0(10) + COGPlaneConstant - BODY_FOR_CALU.Body0(15);
StepForBody(3) = b(1)*BODY_FOR_CALU.Body(5) + b(2)*BODY_FOR_CALU.Body(10) + b(3);
StepForBody(3) = StepForBody(3) + BODY_FOR_CALU.Body0(15) - BODY_FOR_CALU.Body(15);
% 拟合平面为z = b(1)*x + b(2)*y + b(3)，带入x/y坐标，并减去现在的高度，即为要移动的高度
% StepForBody(3) = b(1)*BODY_FOR_CALU.Body0(5) + b(2)*BODY_FOR_CALU.Body0(10) + b(3);
% if abs(StepForBody(3)) <= 1e-2
%     StepForBody(3) = 0;
% end
StepForBody(1:2) = 0; % 只是为了初始化
end