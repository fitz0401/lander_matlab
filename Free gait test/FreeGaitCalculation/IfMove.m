% IfMove:�ڸú������ƶ����壬���ж���һ��
% ���룺BODY_FOR_CALU�������ˣ�,num��Ҫ�����ȣ�,stepX,stepY�����������ϵľ��룩
% ��������Ⱥ�Ļ����ˣ�BODY_FOR_CALU�������Ⱥ����ڵ����ĵ��λ�ã����������ͬ�ľ���
%�����Ǽ��������map_X��map_Y�е�ÿ��������˶���Ȼ������˶���ĵ㴦���ĸ�֧���������У��������ȶ�ԣ�ȵ�У�ˣ�
function [PosG,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,num,stepX, stepY, stepZ)
% length(map_x(:,1)),length(map_y(1,:))

BODY_FOR_CALU = BODY_FOR_CALU.Move(num, stepX, stepY, stepZ); 
PosG = GradComparation(BODY_FOR_CALU,length(stepX(1,:,1)),length(stepY(1,1,:))); % �����ͼ�ϣ��������˶������λ��ʱ�������ĸ�������

end


