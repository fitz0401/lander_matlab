% if_Recognize(Obstacle,step)�ж���һ������ʱ���ĸ����Ƿ�������ϰ���
% ����Obstacle��֮ǰ�����struct��,step��������
% �����ͼ����ά���������ϰ������1�����ϰ������0

function Bit = if_InRectangle(BODY_FOR_CALU, Foot, map_z, gradX, gradY)

Bit = map_z >= BODY_FOR_CALU.Leg(Foot).zBoundry_down & map_z <= BODY_FOR_CALU.Leg(Foot).zBoundry_up ...
    & gradX <= BODY_FOR_CALU.gradBoundry & gradY <= BODY_FOR_CALU.gradBoundry;

end