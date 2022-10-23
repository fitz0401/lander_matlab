% �ҵ��ڹ��������ռ��ڣ��˶�ѧԣ����С�Ľ�
function Foot_index = MinFootInterSpace(interSpaceMat, Foot_index, alpha)
% interspace = interSpaceMat(:,1);

% ǰ��������x��н�alpha����˸�����������ת-alpha
homoPoints = interSpaceMat';
homoPoints(3,:) = ones(4,1);
newPoints = rotz(rad2deg(-alpha)) * homoPoints;
% interspace��4*1�ľ����ĸ����x����
interspace = newPoints(1,:)';

% ����ǵ�һ��
if Foot_index == 0 
    [~,Foot_index] = min(interspace);
    return
end

% ѭ������
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