% ���ݵ�ͼ���ж��Ƿ��ͼ�ϵĵ��Ƿ�ɴ�

function [BODY_FOR_CALU, ReachablePos, map] = getReachPosforFoot(BODY_FOR_CALU, footReadytoMove, Gap)

BODY_FOR_CALU.len_x = length(BODY_FOR_CALU.Leg(footReadytoMove).map_x(1,:));
BODY_FOR_CALU.len_y = length(BODY_FOR_CALU.Leg(footReadytoMove).map_y(:,1)');
map_x = BODY_FOR_CALU.Leg(footReadytoMove).map_x;
map_y = BODY_FOR_CALU.Leg(footReadytoMove).map_y;

% ��map_z��ֵ
map_z = getHeight(Gap, BODY_FOR_CALU, footReadytoMove, map_x, map_y);
map_z = map_z - BODY_FOR_CALU.Body(footReadytoMove+10); % map_z��ȥ������ֻ�ŵĸ߶ȣ������ֵ

% ��map_z���ݶȣ��ݶȹ���ĵ㲻�ܲ�
[gradX,gradY] = gradient(map_z);

% �����ϰ����ڵ�ͼ�ϵ�λ��
% ReachablePos�����ʾ�˵�ͼ����Щλ�ÿ����ߣ���Щ������
if Gap(1).RectangleLengthWidth == [0 0]
    % û��gap
    ReachablePos = true(BODY_FOR_CALU.len_y,BODY_FOR_CALU.len_x);
else
    % map_z���ܴ������ֵ��С����Сֵ���ݶ�grad���ܴ������ֵ
    ReachablePos = map_z >= BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down & map_z <= BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up ...
        & gradX <= BODY_FOR_CALU.gradBoundry & gradY <= BODY_FOR_CALU.gradBoundry;
end
ReachablePos(abs(map_x) <= 1e-4 & abs(map_y) <= 1e-4) = false; % x/y����ͬʱΪ0
if isempty(find(ReachablePos == 1,1))
    % ����Ҳ���1��˵����һ���ķ�Χ��ȫ��gap
    error('No reachable position is in next foot area.');
end

map = zeros(size(map_z,1), size(map_z,2), 3);
map(:,:,1) = map_x;
map(:,:,2) = map_y;
map(:,:,3) = map_z;

end