% map_cost：前进方向向量(1,tan(alpha))与落足点向量的点积最大（最接近stride）
function cost = getMapLegDot(map_x, map_y, alpha)
% size(a, 1)行，size(a, 2)列
row = size(map_x, 1); column = size(map_x, 2);
% reshape是按列重新排列的
vector_a = [reshape(map_x,[1 row * column]); reshape(map_y,[1 row * column]); ones([1 row * column])];
vector_b = [cos(alpha) * ones([1 row * column]); sin(alpha) * ones([1 row * column]); ones([1 row * column])];
cost = dot(vector_a, vector_b);
cost = reshape(cost,[row, column]);
end