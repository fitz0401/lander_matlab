% map_cost��ǰ����������(1,tan(alpha))������������ĵ�������ӽ�stride��
function cost = getMapLegDot(map_x, map_y, alpha)
% size(a, 1)�У�size(a, 2)��
row = size(map_x, 1); column = size(map_x, 2);
% reshape�ǰ����������е�
vector_a = [reshape(map_x,[1 row * column]); reshape(map_y,[1 row * column]); ones([1 row * column])];
vector_b = [cos(alpha) * ones([1 row * column]); sin(alpha) * ones([1 row * column]); ones([1 row * column])];
cost = dot(vector_a, vector_b);
cost = reshape(cost,[row, column]);
end