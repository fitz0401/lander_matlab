% �����ϰ��������һ���Ľ���Ҫ̧���
function map_z = getFootHeight(Obstacle_Point, Robot, Foot, map_x, map_y)

map_z = zeros(size(map_x));
% map_z�ǽ���Ҫ�����ĸ߶ȣ���ȻĬ��Ϊ0
% ��������ϰ�����߹��֣���ô�߶Ⱦ����ϰ������߶�

xv = reshape(map_x,1,Robot.len_x * Robot.len_y);
yv = reshape(map_y,1,Robot.len_x * Robot.len_y);

TransMat = [Robot.Body(Foot) Robot.Body(Foot+5)] - [0 0];%��ǰ���������ϵG�е�λ��


%Ŀǰ��˼·�����Ȱ��ϰ�������任���ֲ�����ϵ�£�Ȼ���ж�MAP�еĵ��Ƿ����ϰ��ﶥ��Χ�ɵ������ڣ��������ڵĵ㸳�߶�ֵ��
%�ڶ�ȡ��ʵ��ͼʱ�����Ȱѵ�ͼ�������ת������ǰ�������ϵ�£�Ȼ���mapZ��ÿ��xy���Ӧ��λ�ý����������ҵ���map����ӽ��ĵ�ͼ����Ϊ�õ�Ľ��Ƶ㣬���Ƶ��Zֵ��Ϊ��map���Zֵ��
%Ϊ������ٶ�������Զ�obstacle���ʵ��ľ���
Obstacle_temp=Obstacle_Point(1:3,:).';
Obstacle_temp(:,1:2)=Obstacle_temp(:,1:2)-TransMat;
margin=10;
index=find((Obstacle_temp(:,1)>(min(xv)-margin))&(Obstacle_temp(:,1)<(max(xv)+margin))&(Obstacle_temp(:,2)>(min(yv)-margin))&(Obstacle_temp(:,2)<(max(yv)+margin)));
Obstacle_temp=Obstacle_temp(index,:);
if isempty(Obstacle_temp)
    map_z=Robot.Body(Foot+10)*ones(size(map_x));
else
    for i=1:length(xv)
        Distance=sqrt((Obstacle_temp(:,1)-xv(i)).^2+(Obstacle_temp(:,2)-yv(i)).^2);
        [~,k]=min(Distance);
        map_z(i) = Obstacle_temp(k,3);
    end
end
%scatter3(Obstacle_temp(:,1),Obstacle_temp(:,2), Obstacle_temp(:,3), 10,[1,0.89,0.9],'filled'); % ����ͶӰ��
% for 

% for i = 1:length(Gap)
%     % ��ȫ������ϵ�µ��ϰ���ת�Ƶ��ֲ�����ϵ��
%     Gap(i).RectangleInitial = Gap(i).RectangleInitial - TransMat;
%     A = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) 0];
%     B = Gap(i).RectangleInitial + [Gap(i).RectangleLengthWidth(1) Gap(i).RectangleLengthWidth(2)];
%     C = Gap(i).RectangleInitial + [0 Gap(i).RectangleLengthWidth(2)];
%     D = Gap(i).RectangleInitial;
%     ObsMatrix = [A; B; C; D]; % �ϰ���Ķ���
%     
%     in = inpolygon(xv,yv,ObsMatrix(:,1),ObsMatrix(:,2)); % λ���ϰ��������Ե�ڲ����Ե�ϵĵ�
%     if Gap(i).Height(2) > 0 
%         % ������ϰ���
%         map_z(in) = Gap(i).Height(2);
%     else
%         % ����ǹ���
%         map_z(in) = Gap(i).Height(1);
%     end
% 
% end
end