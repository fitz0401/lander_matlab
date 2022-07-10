% NextStep_FreeGait���������������ݵ����ж���һ��������
% ���룺BODY_FOR_CALU��Ŀǰ���壩, NextFoot_index����һ��Ҫ�ߵĽţ�, Gap�����֣�, stride������ȣ�
% �������һ���Ĳ�������һ���Ĳ��� 1*2 double��

function StepForLeg = NextFootStep(BODY_FOR_CALU, footReadytoMove, Gap, alpha)
%% ����Ҫ���ݵ�ͼ���ж��Ƿ��ͼ�ϵĵ��Ƿ�ɴ�
% mapx/y���ڽŵľֲ�����ϵ�µģ���Ҫ����ת��ȫ�ֵĵ�ͼ����ϵ��
[row,col] = size(BODY_FOR_CALU.Leg(footReadytoMove).map_x);
mapTempX = reshape(BODY_FOR_CALU.Leg(footReadytoMove).map_x, [1 row * col]);
mapTempY = reshape(BODY_FOR_CALU.Leg(footReadytoMove).map_y, [1 row * col]);
mapTempZup = reshape(BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up, [1 row * col]);
mapTempZdown = reshape(BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down, [1 row * col]);

mapTemp3matUp = [mapTempX; mapTempY; mapTempZup];
mapTemp3matUp = eul2rotm(BODY_FOR_CALU.RotateAngle,'XYZ') * mapTemp3matUp;

mapTemp3matDown = [mapTempX; mapTempY; mapTempZdown];
mapTemp3matDown = eul2rotm(BODY_FOR_CALU.RotateAngle,'XYZ') * mapTemp3matDown;

BODY_FOR_CALU.Leg(footReadytoMove).map_x = reshape(mapTemp3matUp(1,:), [row,col]);
BODY_FOR_CALU.Leg(footReadytoMove).map_y = reshape(mapTemp3matUp(2,:), [row,col]);
BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up = reshape(mapTemp3matUp(3,:), [row,col]);
BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down = reshape(mapTemp3matDown(3,:), [row,col]);

BODY_FOR_CALU.len_x = length(BODY_FOR_CALU.Leg(footReadytoMove).map_x(1,:));
BODY_FOR_CALU.len_y = length(BODY_FOR_CALU.Leg(footReadytoMove).map_y(:,1)');
map_x = BODY_FOR_CALU.Leg(footReadytoMove).map_x;
map_y = BODY_FOR_CALU.Leg(footReadytoMove).map_y;

% ��map_z��ֵ
map_z = getFootHeight(Gap, BODY_FOR_CALU, footReadytoMove, map_x, map_y);
map_z = map_z - BODY_FOR_CALU.Body(footReadytoMove+10); % map_z��ȥ������ֻ�ŵĸ߶ȣ������ֵ

% ��map_z���ݶȣ��ݶȹ���ĵ㲻�ܲ�
[gradX,gradY] = gradient(map_z);

% �����ϰ����ڵ�ͼ�ϵ�λ��
% ReachablePos�����ʾ�˵�ͼ����Щλ�ÿ����ߣ���Щ������
%�˴��ж�׼��Ϊ���������������ռ�Z�����½�֮��������Ҹ�λ�õ��ݶ�ҪС�ڻ������˶�׼���ݶȣ�������ʵΪ�������жϣ���������ͨ�������Ӿ���Ϣ�еĿ������ͼ�빤���ռ��󽻵õ�
ReachablePos = map_z >= BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down & map_z <= BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up ...
    & gradX <= BODY_FOR_CALU.gradBoundry & gradY <= BODY_FOR_CALU.gradBoundry;
ReachablePos(abs(map_x) < BODY_FOR_CALU.Inteval & abs(map_y) < BODY_FOR_CALU.Inteval) = false; % x/y����ͬʱΪ0 %������δȷ��
if isempty(find(ReachablePos == 1,1))
    % ����Ҳ���1��˵����һ���ķ�Χ��ȫ��gap
    error('No reachable position is in next foot area.');
end

%{
%% ����һ���Ƿ���������Ԥ��

% ���ж�֮������һֻ��
vectorForFoot = 1:4; vectorForFoot(footReadytoMove) = []; % ����Ҫ������ֻ�ţ������������ŵ��˶�ѧԣ��
[~, indexNextFoot] = min(BODY_FOR_CALU.interSpace(vectorForFoot,1));
nextFoot = vectorForFoot(indexNextFoot); % ��һ��Ҫ�ߵĽ�
if nextFoot == 1 || nextFoot == 3
    lineForFoot = [2 4];
else
    lineForFoot = [1 3];
end

BODY_FOR_CALU.Body = repmat(BODY_FOR_CALU.Body,1,BODY_FOR_CALU.len_x,BODY_FOR_CALU.len_y);
% Ϊ��IfMove����Ҫ��reshape����ά����
map_x_move = permute(reshape(map_x,[1 size(map_x)]),[1 3 2]);
map_y_move = permute(reshape(map_y,[1 size(map_y)]),[1 3 2]);
map_z_move = permute(reshape(map_z,[1 size(map_z)]),[1 3 2]);
% ��ֻ������������룬�õ�Ŀǰ42*380*380���������״̬
[~,BODY_FOR_CALU] = IfMove(BODY_FOR_CALU,footReadytoMove,map_x_move,map_y_move,map_z_move); 
% PosG = reshape(permute(PosG,[1,3,2]),size(map_x)); % ��PosGת�ɶ�ά
%{
NotDeadLock = false(1,size(map_x,1),size(map_x,2));

% ������һֻ�ŵĹ����ռ��仯����˵��г�һ������
mapFootX = BODY_FOR_CALU.Leg(footReadytoMove).map_x;
mapFootY = BODY_FOR_CALU.Leg(footReadytoMove).map_y;
mapFootZup = BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up;
mapFootZdown = BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down;
for xIndex = 1:BODY_FOR_CALU.len_x
    for yIndex = 1:BODY_FOR_CALU.len_y
        % �����һ����֮ǰ����Ŀɴ�㣬Ԥ����һ���Ƿ�����
        % ����ֱ������
        if ReachablePos(yIndex, xIndex) == true
            % ���ȸ�������ŵĹ����ռ�
            BODY_FOR_CALU.Leg(footReadytoMove).map_x = BODY_FOR_CALU.Leg(footReadytoMove).map_x - map_x(yIndex, xIndex);
            BODY_FOR_CALU.Leg(footReadytoMove).map_y = BODY_FOR_CALU.Leg(footReadytoMove).map_y - map_y(yIndex, xIndex);
            BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down = BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down - map_z(yIndex, xIndex);
            BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up = BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up - map_z(yIndex, xIndex);
            
            % ��������Ĺ����ռ�
            [~, Bit_NextFoot, ~, ~] = getReachPosforBody(BODY_FOR_CALU, footReadytoMove);
            
            if ~isempty(find(Bit_NextFoot == 1,1)) % ����ҵõ�1��˵����һ��������
                NotDeadLock(1, xIndex, yIndex) = true;
            end
            
            % �ָ�����ŵĹ����ռ�
            BODY_FOR_CALU.Leg(footReadytoMove).map_x = mapFootX;
            BODY_FOR_CALU.Leg(footReadytoMove).map_y = mapFootY;
            BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_down = mapFootZup;
            BODY_FOR_CALU.Leg(footReadytoMove).zBoundry_up = mapFootZdown;
        end
    end
end

%}

% �ҵ�������Ҫ�������������ϵ���ɢ�㣨ȡ10����
pointsNumber = 10;
bodyMoveX1 = BODY_FOR_CALU.Body(lineForFoot(1),:,:) - BODY_FOR_CALU.Body(5,:,:);
bodyMoveX2 = BODY_FOR_CALU.Body(lineForFoot(2),:,:) - BODY_FOR_CALU.Body(5,:,:);
bodyMoveY1 = BODY_FOR_CALU.Body(lineForFoot(1)+5,:,:) - BODY_FOR_CALU.Body(10,:,:);
bodyMoveY2 = BODY_FOR_CALU.Body(lineForFoot(2)+5,:,:) - BODY_FOR_CALU.Body(10,:,:);
disX = (bodyMoveX2 - bodyMoveX1) / (pointsNumber-1); % �м�ȡ8���㣬������λ����10����
disY = (bodyMoveY2 - bodyMoveY1) / (pointsNumber-1);
bodyMoveX = repmat(bodyMoveX1,[pointsNumber 1 1]);
bodyMoveY = repmat(bodyMoveX1,[pointsNumber 1 1]);
% bodyMoveX/Y��10*380*380�ľ���ÿһ���Ӧ���λ���ϵ�һ��(x,y)
% �жϽ�����ƶ����x/y���Ƿ��ڹ����ռ���
for i = 1:pointsNumber
    bodyMoveX(i,:,:) = bodyMoveX1 + (i-1) * disX;
    bodyMoveY(i,:,:) = bodyMoveY1 + (i-1) * disY;
end

NotDeadLock = false(1,size(map_x,1),size(map_x,2));
for i = vectorForFoot % ѭ����ֻ��
    for j = 1:pointsNumber % ѭ��10����
        mapx3d = BODY_FOR_CALU.Leg(i).map_x;
        mapy3d = BODY_FOR_CALU.Leg(i).map_y;
        mapx3d(isnan(BODY_FOR_CALU.Leg(i).zBoundry_down)) = nan;
        mapy3d(isnan(BODY_FOR_CALU.Leg(i).zBoundry_down)) = nan;
        % mapx3d�ǵ�iֻ�ŵ�mapx/y
        % ����10*380*380�ľ�����˵��ÿһ��Ԫ�ض�Ӧ�Ķ�һ��
        cellMapx3d{1,1,1} = mapx3d;
        cellMapy3d{1,1,1} = mapy3d;
        cellMapx3d = repmat(cellMapx3d,[1,size(bodyMoveX,2),size(bodyMoveX,3)]);
        cellMapy3d = repmat(cellMapy3d,[1,size(bodyMoveY,2),size(bodyMoveY,3)]);
        % 10*380*380��cell�У�ÿһ�������Ӧ�����
        cellMapx3d = cellfun(@cellAddMat, cellMapx3d, num2cell(bodyMoveX(j,:,:)),'UniformOutput',false);
        cellMapy3d = cellfun(@cellAddMat, cellMapy3d, num2cell(bodyMoveY(j,:,:)),'UniformOutput',false);
        % ֻҪ��һ��cell����(0,0)����㣬����Ϊ�����ڹ����ռ���
        % ֻҪ10����������һ��1������Ϊ��true
        bitEachPoint = cellfun(@cellLeginWorkspace, b, c,'UniformOutput',false);
        bitEachPoint = cell2mat(bitEachPoint);
        NotDeadLock = bitEachPoint(1,:,:) | NotDeadLock;
    end
%     
%     mapx3d = permute(reshape(mapx3d,[1 size(mapx3d)]),[1 3 2]);
%     mapy3d = permute(reshape(mapy3d,[1 size(mapy3d)]),[1 3 2]);
%     
%     mapx3d = repmat(mapx3d,[pointsNumber,1,1]) + bodyMoveX;
%     mapy3d = repmat(mapy3d,[pointsNumber,1,1]) + bodyMoveY;
%     
%     % ���ҵ�x/y��Ϊ0���Ǹ��㣬˵���������ڹ����ռ���
%     mapxy3d = abs(mapx3d) <= BODY_FOR_CALU.Inteval/2 & abs(mapy3d) <= BODY_FOR_CALU.Inteval/2;
%     for j = 2:pointsNumber % ѭ��10����
%         NotDeadLock = bitEachPoint(1,:,:) | NotDeadLock;
%     end
end
NotDeadLock = reshape(permute(NotDeadLock,[1,3,2]),size(map_x)); % ��PosGת�ɶ�ά

% interSpace = reshape(BODY_FOR_CALU.interSpace, [1 1 8]);
% interSpace = repmat(interSpace,[size(map_z) 1]);
% interSpace(:,:,footReadytoMove) = interSpace(:,:,footReadytoMove) + map_x;
% interSpace(:,:,footReadytoMove+4) = interSpace(:,:,footReadytoMove+4) + map_y;
% % ����ֻ����x����Сֵ(Ӧ������ǰ���������Сֵ)���ж���һ����˭
% mapIndex = zeros(size(map_z));
% [row,column] = size(map_z);
% for j = 1:row
%     b = reshape(interSpace(1,:,1:4),[column,4]);
%     [~,index] = min(b,[],2);
%     mapIndex(j,:) = index';
% end
% % [~,index] = min(interSpace(:,:,1:4));
% 
% [~,index] = min(BODY_FOR_CALU.interSpace(:,1));
% Next(index == 1) = "A"; Next(index == 2) = "B";
% Next(index == 3) = "C"; Next(index == 4) = "D";
% NotDeadLock = ~contains(PosG,Next) & PosG ~= "";

ReachablePos = ReachablePos & NotDeadLock;
%}
%% �ڵ�ͼ�ϣ������жϺ���ѡ������ʵĵ�
% % ����������Ȩ��
% omiga1 = 1; omiga2 = 1; omiga3 = 2;
% % costDotProduct��ǰ����������(1,tan(alpha))������������ĵ�������ӽ�stride��
% costDotProduct = getMapLegDot(map_x, map_y, alpha);
% costDeltaY = (-1)*abs(map_y);
% costStride = (-1)*sqrt((map_x - stride(1)).^2 + map_y.^2); % ��(stride,0)�ľ���
% costMap = omiga1 * costDotProduct + omiga2 * costDeltaY + omiga3 * costStride;
% costMap(~ReachablePos) = nan;
% IdealPos = costMap == max(costMap(:)); 

% % ����������Ȩ��
% omiga1 = 1; omiga2 = 1; omiga3 = 2;
% % costDotProduct��ǰ����������(1,tan(alpha))������������ĵ�������ӽ�stride��
% costDotProduct = (-1)*abs(getMapLegDot(map_x, map_y, alpha) - BODY_FOR_CALU.stride);
% costDeltaY = (-1)*abs(map_y);
% % costStride = (-1)*sqrt((map_x - BODY_FOR_CALU.stride(1)).^2 + map_y.^2); % ��(stride,0)�ľ���
% costMap = omiga1 * costDotProduct + omiga2 * costDeltaY;
% costMap(~ReachablePos) = nan;
% map_x(~ReachablePos)=nan; map_y(~ReachablePos)=nan;
% IdealPos = costMap == max(costMap(:)); 

% ��ӽ���(stride,0)��
map_cost = sqrt((map_x - BODY_FOR_CALU.stride*cos(alpha)).^2 + (map_y - BODY_FOR_CALU.stride*sin(alpha)).^2);
map_cost(~ReachablePos | map_x<0) = nan;
IdealPos = map_cost == min(min(map_cost)); 

% % ����������Ȩ��
% omiga1 = 1; omiga2 = 4000;
% % costDotProduct��ǰ����������(1,tan(alpha))������������ĵ�������ӽ�stride��
% costDotProduct = (-1)*abs(getMapLegDot(map_x, map_y, alpha) - BODY_FOR_CALU.stride);
% costDeltaAngle = (-1)*abs(atan2(map_y,map_x) - alpha);
% costMap = omiga1 * costDotProduct + omiga2 * costDeltaAngle;
% costMap(~ReachablePos) = nan;
% IdealPos = costMap == max(costMap(:)); 

% pos������IdealPos��1��λ��
% ������������ϣ�ֻȡ��һ��
pos = find(IdealPos == 1);
if length(pos) > 1
    for i = 2:length(pos)
        IdealPos(pos(i)) = false;
    end
end
if isempty(pos)
    % ����Ҳ���1��˵���Ҳ������ʵĵ㣬����
    error('DeadLock in lifting next foot.');
end
% StepForBody������һ�����Ÿ����Ĳ���
StepForLeg(1) = map_x(IdealPos); StepForLeg(2) = map_y(IdealPos); StepForLeg(3) = map_z(IdealPos);
StepForLeg(1) = RoundDis(BODY_FOR_CALU.Inteval, StepForLeg(1));
StepForLeg(2) = RoundDis(BODY_FOR_CALU.Inteval, StepForLeg(2));
end