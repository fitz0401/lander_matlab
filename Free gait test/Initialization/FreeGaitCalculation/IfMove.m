% IfMove:在该函数里移动身体，以判断下一步
% 输入：BODY_FOR_CALU（机器人）,num（要迈的腿）,stepX,stepY（两个方向上的距离）
% 输出：迈腿后的机器人（BODY_FOR_CALU），迈腿后现在的重心点的位置（与机器人相同的矩阵）

function [PosG,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,num,stepX, stepY, stepZ)

BODY_FOR_CALU = BODY_FOR_CALU.Move(num, stepX, stepY, stepZ); 
PosG = GradComparation(BODY_FOR_CALU); % 计算地图上，若身体运动到这个位置时，处于哪个三角形

end


