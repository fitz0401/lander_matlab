% 修建（身体）工作空间
% 周围有一圈没必要的nan，去除掉。保证第一行第一列就有非nan的值
function [map_x, map_y] = TrimBodyArea(map_x, map_y)
% 找到map中不为nan的位置
[rowX, colX] = find(~isnan(map_x) == true);
[rowY, colY] = find(~isnan(map_y) == true);
% 找到这些位置中x/y最大最小的位置
minrowX = min(rowX); maxrowX = max(rowX); 
mincolX = min(colX); maxcolX = max(colX); 

minrowY = min(rowY); maxrowY = max(rowY); 
mincolY = min(colY); maxcolY = max(colY); 
% 需要取的矩阵即如下：
map_x = map_x(minrowX:maxrowX, mincolX:maxcolX);
map_y = map_y(minrowY:maxrowY, mincolY:maxcolY);

end