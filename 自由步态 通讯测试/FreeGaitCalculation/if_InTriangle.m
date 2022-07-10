% https://ww2.mathworks.cn/matlabcentral/answers/277984-check-points-inside-triangle-or-on-edge-with-example
% Answer by @Roger Stafford  on 9 Apr 2016
% 
% Suppose P1 = [x1,y1], P2 = [x2,y2], and P3 = [x3,y3] are row vectors giving the coordinates of the three vertices of a triangle, and P = [x,y] is a row vector for the coordinates of a point P. To determine whether P lies inside the triangle P1P2P3 do this:
%    P12 = P1-P2; P23 = P2-P3; P31 = P3-P1;
%    t = sign(det([P31;P23]))*sign(det([P3-P;P23])) >= 0 & ...
%        sign(det([P12;P31]))*sign(det([P1-P;P31])) >= 0 & ...
%        sign(det([P23;P12]))*sign(det([P2-P;P12])) >= 0 ;
% Point P lies within the triangle if and only if t is true.

% if_InTriangle：判断总COG点是否在三角形内
% 输入：身体矩阵Body，三角形的顶点（三个数字，1234对应ABCD脚）
% 输出：与Body相同大小的逻辑矩阵，在三角形内为正，否则为假

function t = if_InTriangle(Body, num1, num2, num3)

% 判断是否在ACD中
% P1 P2 P3是三个顶点，P是要判断的点
P1x = Body(num1,:,:,:,:); P1y = Body(num1+5,:,:,:,:);
P2x = Body(num2,:,:,:,:); P2y = Body(num2+5,:,:,:,:);
P3x = Body(num3,:,:,:,:); P3y = Body(num3+5,:,:,:,:);
Px = Body(32,:,:,:,:); Py = Body(37,:,:,:,:);

P12x = P1x - P2x; P12y = P1y - P2y; P23x = P2x - P3x;
P23y = P2y - P3y; P31x = P3x - P1x; P31y = P3y - P1y;

det_P31_P23 = P31x .* P23y - P23x .* P31y; 
det_P3P_P23 = (P3x - Px) .* P23y - P23x .* (P3y - Py);

det_P12_P31 = P12x .* P31y - P31x .* P12y; 
det_P1P_P31 = (P1x - Px) .* P31y - P31x .* (P1y - Py);

det_P23_P12 = P23x .* P12y - P12x .* P23y; 
det_P2P_P12 = (P2x - Px) .* P12y - P12x .* (P2y - Py);

t = sign(det_P31_P23).*sign(det_P3P_P23) >= 0 & ...
    sign(det_P12_P31).*sign(det_P1P_P31) >= 0 & ...
    sign(det_P23_P12).*sign(det_P2P_P12) >= 0 ;
end

