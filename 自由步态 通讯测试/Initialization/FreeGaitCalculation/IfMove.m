% IfMove:�ڸú������ƶ����壬���ж���һ��
% ���룺BODY_FOR_CALU�������ˣ�,num��Ҫ�����ȣ�,stepX,stepY�����������ϵľ��룩
% ��������Ⱥ�Ļ����ˣ�BODY_FOR_CALU�������Ⱥ����ڵ����ĵ��λ�ã����������ͬ�ľ���

function [PosG,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,num,stepX, stepY, stepZ)

BODY_FOR_CALU = BODY_FOR_CALU.Move(num, stepX, stepY, stepZ); 
PosG = GradComparation(BODY_FOR_CALU); % �����ͼ�ϣ��������˶������λ��ʱ�������ĸ�������

end


