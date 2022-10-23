% Move:�ƶ�����
% ����Ҫ������(��ֵ��double)�����Ⱦ��루1*2 double���������

function BODY_FOR_CALU = Move(BODY_FOR_CALU,num,step)

stepX = step(1); stepY = step(2);

if num < 5
    BODY_FOR_CALU.Body(num,:,:) = BODY_FOR_CALU.Body(num,:,:) + stepX; % ����
    BODY_FOR_CALU.Body(num+5,:,:) = BODY_FOR_CALU.Body(num+5,:,:) + stepY; % ����
    
    BODY_FOR_CALU.Body(num+18,:,:) = (BODY_FOR_CALU.Body(num+10,:,:) + BODY_FOR_CALU.Body(num,:,:))/2; % �����ı仯
    BODY_FOR_CALU.Body(num+23,:,:) = (BODY_FOR_CALU.Body(num+14,:,:) + BODY_FOR_CALU.Body(num+5,:,:))/2; % �����ı仯
elseif num == 5
    BODY_FOR_CALU.Body(5,:,:) = BODY_FOR_CALU.Body(5,:,:) + stepX; % �������ı仯
    BODY_FOR_CALU.Body(10,:,:) = BODY_FOR_CALU.Body(10,:,:) + stepY;
    
    BODY_FOR_CALU.Body(11:14,:,:) = BODY_FOR_CALU.Body(11:14,:,:) + stepX; % ���嶥��仯
    BODY_FOR_CALU.Body(15:18,:,:) = BODY_FOR_CALU.Body(15:18,:,:) + stepY;
    
    BODY_FOR_CALU.Body(19:22,:,:) = (BODY_FOR_CALU.Body(1:4,:,:) + BODY_FOR_CALU.Body(11:14,:,:))/2; % �����ı仯
    BODY_FOR_CALU.Body(24:27,:,:) = (BODY_FOR_CALU.Body(6:9,:,:) + BODY_FOR_CALU.Body(15:18,:,:))/2;
else
    error('Error in Foot/Body to move in calculation.');
end

% �����ƶ������������ĵ�λ�á�MassRatio�Ǹ��ȼ���������ռ��
BODY_FOR_CALU.Body(23,:,:) = BODY_FOR_CALU.Body(5,:,:) * BODY_FOR_CALU.MassRatio(5) ...
    + BODY_FOR_CALU.Body(19,:,:) * BODY_FOR_CALU.MassRatio(1) + BODY_FOR_CALU.Body(20,:,:) * BODY_FOR_CALU.MassRatio(2) ...
    + BODY_FOR_CALU.Body(21,:,:) * BODY_FOR_CALU.MassRatio(3) + BODY_FOR_CALU.Body(22,:,:) * BODY_FOR_CALU.MassRatio(4);
BODY_FOR_CALU.Body(28,:,:) = BODY_FOR_CALU.Body(10,:,:) * BODY_FOR_CALU.MassRatio(5) ...
    + BODY_FOR_CALU.Body(24,:,:) * BODY_FOR_CALU.MassRatio(1) + BODY_FOR_CALU.Body(25,:,:) * BODY_FOR_CALU.MassRatio(2) ...
    + BODY_FOR_CALU.Body(26,:,:) * BODY_FOR_CALU.MassRatio(3) + BODY_FOR_CALU.Body(27,:,:) * BODY_FOR_CALU.MassRatio(4);
