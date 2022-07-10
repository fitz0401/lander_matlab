% 找到在公共工作空间内，运动学裕度最小的脚
function Foot_index = MinFootInterSpace(interSpaceMat, Foot_index, alpha)
% interspace = interSpaceMat(:,1);

% 前进方向与x轴夹角alpha，因此各点坐标先旋转-alpha
homoPoints = interSpaceMat';
homoPoints(3,:) = ones(4,1);
newPoints = rotz(rad2deg(-alpha)) * homoPoints;
% interspace：4*1的矩阵，四个点的x坐标
interspace = newPoints(1,:)';

% 如果是第一步
if Foot_index == 0 
    [~,Foot_index] = min(interspace);
    return
end

% 循环周期
circleSequence{1} = [3 2 4 1];
circleSequence{2} = [4 1 3 2];
circleSequence{3} = [2 4 1 3];
circleSequence{4} = [1 3 2 4];

for i = circleSequence{Foot_index}
    if interspace(i) == min(interspace)
        Foot_index = i;
        return
    end
end

end