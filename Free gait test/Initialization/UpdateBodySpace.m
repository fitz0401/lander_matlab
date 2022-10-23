function BODY_FOR_CALU = UpdateBodySpace(BODY_FOR_CALU)

% 四足工作空间的极值
xBoundry(1) = min([BODY_FOR_CALU.Leg(1).map_x(:,1); BODY_FOR_CALU.Leg(2).map_x(:,1); BODY_FOR_CALU.Leg(3).map_x(:,1); BODY_FOR_CALU.Leg(4).map_x(:,1)]);
xBoundry(2) = max([BODY_FOR_CALU.Leg(1).map_x(:,end); BODY_FOR_CALU.Leg(2).map_x(:,end); BODY_FOR_CALU.Leg(3).map_x(:,end); BODY_FOR_CALU.Leg(4).map_x(:,end)]);
yBoundry(1) = max([BODY_FOR_CALU.Leg(1).map_y(1,:) BODY_FOR_CALU.Leg(2).map_y(1,:) BODY_FOR_CALU.Leg(3).map_y(1,:) BODY_FOR_CALU.Leg(4).map_y(1,:)]);
yBoundry(2) = min([BODY_FOR_CALU.Leg(1).map_y(end,:) BODY_FOR_CALU.Leg(2).map_y(end,:) BODY_FOR_CALU.Leg(3).map_y(end,:) BODY_FOR_CALU.Leg(4).map_y(end,:)]);
% 通过极值，计算出身体工作空间的极值
step_x = linspace(xBoundry(1), xBoundry(2), (xBoundry(2)-xBoundry(1))/BODY_FOR_CALU.Inteval+1); % x从小到大 y从大到小
step_y = linspace(yBoundry(1), yBoundry(2), (yBoundry(1)-yBoundry(2))/BODY_FOR_CALU.Inteval+1); % 注意这里取了转置
% step_y = linspace(yBoundry(1), yBoundry(2), (yBoundry(2)-yBoundry(1))/BODY_FOR_CALU.Inteval+1); % 注意这里取了转置
lengthX = length(step_x);
lengthY = length(step_y);
% 画出一个身体的map，这个map足够大，可以容纳四足的map
map_x = repmat(step_x,lengthY,1);
map_y = repmat(step_y,lengthX,1); map_y = map_y';
% 只需要找map_x_body对应的值即可，因为输出的bit在map_x和map_y相同
Bit_map_body = getBodyAreaBit(BODY_FOR_CALU, step_x, step_y,[0,0,0,0,0,0]);
% Bit_map_body = ~isnan(map_z);

% 上述map和bit都是建立在脚的公共工作空间下的，反应到身体上还需要取反
Bit_map_body = rot90(Bit_map_body,2);
map_x = rot90(map_x,2); map_y = rot90(map_y,2);
map_x = -map_x; map_y = -map_y;
map_x(~Bit_map_body) = nan; map_y(~Bit_map_body) = nan;
[map_x, map_y] = TrimBodyArea(map_x, map_y);

% 身体的工作空间是为了考虑稳定裕度，不需要考虑z方向
BODY_FOR_CALU.BodySpace.map_x = map_x;
BODY_FOR_CALU.BodySpace.map_y = map_y;

end