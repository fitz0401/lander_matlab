% IfMove:在该函数里移动身体，以判断下一步
% 输入：BODY_FOR_CALU（机器人）,num（要迈的腿）,stepX,stepY（两个方向上的距离）
% 输出：迈腿后的机器人（BODY_FOR_CALU），迈腿后现在的重心点的位置（与机器人相同的矩阵）
%这里是假设机身按照map_X和map_Y中的每个点进行运动，然后计算运动后的点处于哪个支撑三角形中，包含了稳定裕度的校核；
function [PosG,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,num,stepX, stepY, stepZ)
% length(map_x(:,1)),length(map_y(1,:))

BODY_FOR_CALU = BODY_FOR_CALU.Move(num, stepX, stepY, stepZ); 
PosG = GradComparation(BODY_FOR_CALU,length(stepX(1,:,1)),length(stepY(1,1,:))); % 计算地图上，若身体运动到这个位置时，处于哪个三角形

end


