function BODY_FOR_CALU = UpdateBodySpace(BODY_FOR_CALU)

% ���㹤���ռ�ļ�ֵ
xBoundry(1) = min([BODY_FOR_CALU.Leg(1).map_x(:,1); BODY_FOR_CALU.Leg(2).map_x(:,1); BODY_FOR_CALU.Leg(3).map_x(:,1); BODY_FOR_CALU.Leg(4).map_x(:,1)]);
xBoundry(2) = max([BODY_FOR_CALU.Leg(1).map_x(:,end); BODY_FOR_CALU.Leg(2).map_x(:,end); BODY_FOR_CALU.Leg(3).map_x(:,end); BODY_FOR_CALU.Leg(4).map_x(:,end)]);
yBoundry(1) = max([BODY_FOR_CALU.Leg(1).map_y(1,:) BODY_FOR_CALU.Leg(2).map_y(1,:) BODY_FOR_CALU.Leg(3).map_y(1,:) BODY_FOR_CALU.Leg(4).map_y(1,:)]);
yBoundry(2) = min([BODY_FOR_CALU.Leg(1).map_y(end,:) BODY_FOR_CALU.Leg(2).map_y(end,:) BODY_FOR_CALU.Leg(3).map_y(end,:) BODY_FOR_CALU.Leg(4).map_y(end,:)]);
% ͨ����ֵ����������幤���ռ�ļ�ֵ
step_x = linspace(xBoundry(1), xBoundry(2), (xBoundry(2)-xBoundry(1))/BODY_FOR_CALU.Inteval+1); % x��С���� y�Ӵ�С
step_y = linspace(yBoundry(1), yBoundry(2), (yBoundry(1)-yBoundry(2))/BODY_FOR_CALU.Inteval+1); % ע������ȡ��ת��
% step_y = linspace(yBoundry(1), yBoundry(2), (yBoundry(2)-yBoundry(1))/BODY_FOR_CALU.Inteval+1); % ע������ȡ��ת��
lengthX = length(step_x);
lengthY = length(step_y);
% ����һ�������map�����map�㹻�󣬿������������map
map_x = repmat(step_x,lengthY,1);
map_y = repmat(step_y,lengthX,1); map_y = map_y';
% ֻ��Ҫ��map_x_body��Ӧ��ֵ���ɣ���Ϊ�����bit��map_x��map_y��ͬ
Bit_map_body = getBodyAreaBit(BODY_FOR_CALU, step_x, step_y,[0,0,0,0,0,0]);
% Bit_map_body = ~isnan(map_z);

% ����map��bit���ǽ����ڽŵĹ��������ռ��µģ���Ӧ�������ϻ���Ҫȡ��
Bit_map_body = rot90(Bit_map_body,2);
map_x = rot90(map_x,2); map_y = rot90(map_y,2);
map_x = -map_x; map_y = -map_y;
map_x(~Bit_map_body) = nan; map_y(~Bit_map_body) = nan;
[map_x, map_y] = TrimBodyArea(map_x, map_y);

% ����Ĺ����ռ���Ϊ�˿����ȶ�ԣ�ȣ�����Ҫ����z����
BODY_FOR_CALU.BodySpace.map_x = map_x;
BODY_FOR_CALU.BodySpace.map_y = map_y;

end