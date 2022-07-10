% 初始化终点位置
%targetNumber表示终点数量？多终点怎么使用？
function [endPosition, targetNumber] = InitialTargetPosition(startPosition, endPositionArgu)
rhou = endPositionArgu(1,:);  %到终点坐标的运动距离
alpha = endPositionArgu(2,:); %终点坐标相对初始位置的转角
 
deltaX = rhou .* cos(alpha); deltaY = rhou .* sin(alpha);  %X方向上的前近距离
endPosition = repmat(startPosition,length(alpha),1);  %为多终点服务？？
% 定义机器人要走的距离
for targetNumber = 1:length(alpha)
    endPosition(targetNumber:end,1) = endPosition(targetNumber:end,1)+ deltaX(targetNumber);
    endPosition(targetNumber:end,2) = endPosition(targetNumber:end,2)+ deltaY(targetNumber);
end

end