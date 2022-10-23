% ��ʼ���յ�λ��
%targetNumber��ʾ�յ����������յ���ôʹ�ã�
function [endPosition, targetNumber] = InitialTargetPosition(startPosition, endPositionArgu)
rhou = endPositionArgu(1,:);  %���յ�������˶�����
alpha = endPositionArgu(2,:); %�յ�������Գ�ʼλ�õ�ת��
 
deltaX = rhou .* cos(alpha); deltaY = rhou .* sin(alpha);  %X�����ϵ�ǰ������
endPosition = repmat(startPosition,length(alpha),1);  %Ϊ���յ���񣿣�
% ���������Ҫ�ߵľ���
for targetNumber = 1:length(alpha)
    endPosition(targetNumber:end,1) = endPosition(targetNumber:end,1)+ deltaX(targetNumber);
    endPosition(targetNumber:end,2) = endPosition(targetNumber:end,2)+ deltaY(targetNumber);
end

end