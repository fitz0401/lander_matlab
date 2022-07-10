% �����ϰ��������һ���Ľ���Ҫ̧���
function map_z = getFootHeight(Gap, Robot, Foot, map_x, map_y)

map_z = zeros(size(map_x));
% map_z�ǽ���Ҫ�����ĸ߶ȣ���ȻĬ��Ϊ0
% ��������ϰ�����߹��֣���ô�߶Ⱦ����ϰ������߶�

xv = reshape(map_x,1,Robot.len_x * Robot.len_y);
yv = reshape(map_y,1,Robot.len_x * Robot.len_y);

TransMat = [Robot.Body(Foot) Robot.Body(Foot+5)] - [0 0];
for i = 1:length(Gap)
    % ��ȫ������ϵ�µ��ϰ���ת�Ƶ��ֲ�����ϵ��
    Gap(i).RectangleInitial = Gap(i).RectangleInitial - TransMat;
    A = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) 0];
    B = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2)];
    C = Gap(i).RectangleInitial + [0 Gap(i).RectangleLengthWidth(2)];
    D = Gap(i).RectangleInitial;
    ObsMatrix = [A; B; C; D]; % �ϰ���Ķ���
    
    in = inpolygon(xv,yv,ObsMatrix(:,1),ObsMatrix(:,2)); % λ���ϰ��������Ե�ڲ����Ե�ϵĵ�
    if Gap(i).Height(2) > 0 
        % ������ϰ���
        map_z(in) = Gap(i).Height(2);
    else
        % ����ǹ���
        map_z(in) = Gap(i).Height(1);
    end

end

end