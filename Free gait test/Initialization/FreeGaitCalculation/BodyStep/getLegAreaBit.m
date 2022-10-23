% 找到腿的工作空间的交集
% map_body_bit:腿的工作空间的交集在总工作空间下的bit
function map_body_bit = getLegAreaBit(BODY_FOR_CALU, step_x_body, step_y_body)
% step必须是行向量
lenx = length(step_x_body);
leny = length(step_y_body);
map_body_bit = false(4,leny,lenx); % 共4层，每一层都是二维的map

for i = 1:4
    [~, legx_start] = find(step_x_body >= min(BODY_FOR_CALU.Leg(i).map_x(:,1)),1); % 在身体map里，leg1从(1,leg1_start)取到(1,leg1_end)
    [~, legx_end] = find(step_x_body <= max(BODY_FOR_CALU.Leg(i).map_x(:,end)),1,'last');
    [~, legy_start] = find(step_y_body <= max(BODY_FOR_CALU.Leg(i).map_y(1,:)),1); % 分别是x和y
    [~, legy_end] = find(step_y_body >= min(BODY_FOR_CALU.Leg(i).map_y(end,:)),1,'last');
    map_body_bit(i, legy_start:legy_end, legx_start:legx_end) = true;
end

end