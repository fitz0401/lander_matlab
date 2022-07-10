% https://ww2.mathworks.cn/matlabcentral/answers/95608-is-there-a-function-in-matlab-that-calculates-the-shortest-distance-from-a-point-to-a-line
% Answer by @MathWorks Support Team  on 27 Jun 2009
% 
% The ability to automatically calculate the shortest distance from a point to a line is not available in MATLAB. To work around this, see the following function:
% function d = point_to_line(pt, v1, v2)
%       a = v1 - v2;
%       b = pt - v2;
%       d = norm(cross(a,b)) / norm(a);

% find_Distance：判断计算点是否距离直线满足要求

function t = find_Distance(Body, SM, num1, num2)

Ax = Body(num1,:,:,:,:); Ay = Body(num1 + 5,:,:,:,:);
Bx = Body(num2,:,:,:,:); By = Body(num2 + 5,:,:,:,:);
Gx = Body(32,:,:,:,:); Gy = Body(37,:,:,:,:);

% a = abs((Ax-Bx).*(Gy-By) - (Ay-By).*(Gx-Bx));
% b = sqrt((Ax-Bx).^2 + (Ay-By).^2);
D = abs((Ax-Bx).*(Gy-By) - (Ay-By).*(Gx-Bx)) ./ sqrt((Ax-Bx).^2 + (Ay-By).^2);
t = D <= SM;
end