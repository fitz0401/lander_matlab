% �ҵ��ȵĹ����ռ�Ľ���
% map_body_bit:�ȵĹ����ռ�Ľ������ܹ����ռ��µ�bit
function map_body_bit = getLegAreaBit(BODY_FOR_CALU, step_x_body, step_y_body)
% step������������
lenx = length(step_x_body);
leny = length(step_y_body);
map_body_bit = false(4,leny,lenx); % ��4�㣬ÿһ�㶼�Ƕ�ά��map

for i = 1:4
    [~, legx_start] = find(step_x_body >= min(BODY_FOR_CALU.Leg(i).map_x(:,1)),1); % ������map�leg1��(1,leg1_start)ȡ��(1,leg1_end)
    [~, legx_end] = find(step_x_body <= max(BODY_FOR_CALU.Leg(i).map_x(:,end)),1,'last');
    [~, legy_start] = find(step_y_body <= max(BODY_FOR_CALU.Leg(i).map_y(1,:)),1); % �ֱ���x��y
    [~, legy_end] = find(step_y_body >= min(BODY_FOR_CALU.Leg(i).map_y(end,:)),1,'last');
    map_body_bit(i, legy_start:legy_end, legx_start:legx_end) = true;
end

end