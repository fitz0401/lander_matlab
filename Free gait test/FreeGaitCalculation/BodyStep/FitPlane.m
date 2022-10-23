% ���ĸ������ƽ�棬�����������Ӧ���ߵĸ߶Ⱥ�����ת��
function StepForBody = FitPlane(BODY_FOR_CALU,x,y,z)

% regress����ʽ��ϡ�������ʽ����Ϊ�Ա����������������
c = ones(length(x),1); % ������
b = regress(z,[x, y, c]); % ��ӷ�������������
% b�������������ϵ������Ϻ������� z = b(1)*x + b(2)*y + b(3)
P1 = [0,0,b(3)]; P2 = [1,0,b(1) + b(3)]; P3 = [0,1,b(2) + b(3)]; % ���ƽ���ϵ�������
fitPlaneNormal = cross(P1-P2, P1-P3); % ���ƽ��ķ�����
fitPlaneTheta = acos(dot(fitPlaneNormal,[0,0,1])/(norm(fitPlaneNormal)*norm([0,0,1]))); % ƽ�淨������(0,0,1)�ļн�
fitPlaneAxis = cross([0 0 1],fitPlaneNormal); % ת�᷽���Ƹ����(0,0,1)ת������ƽ����Ҫתtheta�Ƕ�
if abs(fitPlaneAxis - [0 0 0]) <= 1e-4
    % ˵��ƽ����ȫƽ���ڵ���
    rotateAngle = [0 0 0];
else
    % ��Ҫ��������ת��
    % rot:��ĳһ����תĳһ�Ƕ�������ת����
    rotateAngle = rotm2eul(RotalongAxis(fitPlaneAxis,fitPlaneTheta),'XYZ'); % �ƶ�����ϵ��ת
end
% ��������Χ����涨���ֻ���ڷ�Χ����
% rotateAngle(rotateAngle < BODY_FOR_CALU.RotateAngle_Boundry(1,:) ) = BODY_FOR_CALU.RotateAngle_Boundry(1,(rotateAngle < BODY_FOR_CALU.RotateAngle_Boundry(1,:) ));
% rotateAngle(rotateAngle > BODY_FOR_CALU.RotateAngle_Boundry(2,:) ) = BODY_FOR_CALU.RotateAngle_Boundry(2,(rotateAngle > BODY_FOR_CALU.RotateAngle_Boundry(2,:) ));
% rotateAngle(abs(rotateAngle) < 1e-4) = 0; % ����1e-4���²����ǣ�ԼΪ1�Ƕ�
StepForBody(4:6) = round(rotateAngle,2); % �Ƕ�ֵȡ����ֵ�������������һ�������ֵ

% % COGPlaneConstant = norm([b(1) b(2) -1]) + b(3); % ��2020.1625����Ԥ�������߶ȣ����ƽ�浽����COG�ĸ߶ȣ�
% % StepForBody(3) = b(1)*BODY_FOR_CALU.Body0(5) + b(2)*BODY_FOR_CALU.Body0(10) + COGPlaneConstant - BODY_FOR_CALU.Body0(15);
% % ���ƽ��Ϊz = b(1)*x + b(2)*y + b(3)������x/y���꣬����ȥ���ڵĸ߶ȣ���ΪҪ�ƶ��ĸ߶�
% StepForBody(3) = b(1)*BODY_FOR_CALU.Body0(5) + b(2)*BODY_FOR_CALU.Body0(10) + b(3) - BODY_FOR_CALU.Body0(15);
% if abs(StepForBody(3)) <= 1e-2
%     StepForBody(3) = 0;
% end

% COGPlaneConstant = norm([b(1) b(2) -1]) + b(3); % ��2020.1625����Ԥ�������߶ȣ����ƽ�浽����COG�ĸ߶ȣ�
% StepForBody(3) = b(1)*BODY_FOR_CALU.Body0(5) + b(2)*BODY_FOR_CALU.Body0(10) + COGPlaneConstant - BODY_FOR_CALU.Body0(15);
StepForBody(3) = b(1)*BODY_FOR_CALU.Body(5) + b(2)*BODY_FOR_CALU.Body(10) + b(3);
StepForBody(3) = StepForBody(3) + BODY_FOR_CALU.Body0(15) - BODY_FOR_CALU.Body(15);
% ���ƽ��Ϊz = b(1)*x + b(2)*y + b(3)������x/y���꣬����ȥ���ڵĸ߶ȣ���ΪҪ�ƶ��ĸ߶�
% StepForBody(3) = b(1)*BODY_FOR_CALU.Body0(5) + b(2)*BODY_FOR_CALU.Body0(10) + b(3);
% if abs(StepForBody(3)) <= 1e-2
%     StepForBody(3) = 0;
% end
StepForBody(1:2) = 0; % ֻ��Ϊ�˳�ʼ��
end