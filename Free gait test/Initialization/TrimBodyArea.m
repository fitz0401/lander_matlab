% �޽������壩�����ռ�
% ��Χ��һȦû��Ҫ��nan��ȥ��������֤��һ�е�һ�о��з�nan��ֵ
function [map_x, map_y] = TrimBodyArea(map_x, map_y)
% �ҵ�map�в�Ϊnan��λ��
[rowX, colX] = find(~isnan(map_x) == true);
[rowY, colY] = find(~isnan(map_y) == true);
% �ҵ���Щλ����x/y�����С��λ��
minrowX = min(rowX); maxrowX = max(rowX); 
mincolX = min(colX); maxcolX = max(colX); 

minrowY = min(rowY); maxrowY = max(rowY); 
mincolY = min(colY); maxcolY = max(colY); 
% ��Ҫȡ�ľ������£�
map_x = map_x(minrowX:maxrowX, mincolX:maxcolX);
map_y = map_y(minrowY:maxrowY, mincolY:maxcolY);

end