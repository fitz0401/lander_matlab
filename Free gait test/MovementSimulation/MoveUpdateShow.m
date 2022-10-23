% MoveUpdateShow��Move���� & Update�����ռ� & Show
% ���룺Foot_index������һ�� double��1-4��ʾ�Ⱥţ�5��ʾ����  , Step���ߵĲ��� 1*2 double��

function BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, Foot_index, Step, BODY_PARA)

bodytemp = BODY_FOR_CALU;
%�������õ�move����ʵ�ֻ����˵��˶��������������˴洢����ƶ������ĵ��ƶ��Լ������ĵ����¼���
BODY_FOR_CALU = BODY_FOR_CALU.Move(Foot_index, Step(1), Step(2), Step(3)); % 5 ��������
if Foot_index == 5
    BODY_FOR_CALU.RotateAngle = Step(4:6);
    BODY_FOR_CALU = BODY_FOR_CALU.Rotate(Step(4), Step(5), Step(6));
    
    %�����˶�ʱTBG�˴����е���,����BODY_FOR_CALU.RotateAngle�д����ŷ���Ǳ�ʾ���Ǵ�ʱ�������̬��
    TBG_tem=[eul2rotm(BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX'),BODY_FOR_CALU.TBG(1:3,4);0 0 0 1];
    BODY_FOR_CALU.TBG=[eye(3),[Step(1);Step(2);Step(3)];0 0 0 1] * TBG_tem;   
%     BODY_FOR_CALU.TBG=[eul2rotm(BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX'),[Step(1);Step(2);Step(3)];0 0 0 1] * BODY_FOR_CALU.TBG;        
end

if Foot_index == 5
    iVector = 1:4;
else
    iVector = Foot_index;
end

%�����һ���˶���ʱ��Ϊʲô��1��һ����Y�������С�˶�������
for i = iVector
    % ���嶥���ƫ�������൱�ڽ����෴�ķ����˶�
    deltaX = (BODY_FOR_CALU.Body(i)-BODY_FOR_CALU.Body(15+i)) - (bodytemp.Body(i)-bodytemp.Body(15+i));
    deltaY = (BODY_FOR_CALU.Body(5+i)-BODY_FOR_CALU.Body(19+i)) - (bodytemp.Body(5+i)-bodytemp.Body(19+i));
    deltaZ = (BODY_FOR_CALU.Body(10+i)-BODY_FOR_CALU.Body(23+i)) - (bodytemp.Body(10+i)-bodytemp.Body(23+i));
    delta = [deltaX; deltaY; deltaZ];
    delta = eul2rotm(-BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX') * delta;
    
    delta(1) = round(delta(1) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval;
    delta(2) = round(delta(2) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval; % ��6.25�������ռ侫�ȣ�ȡ������֤������6.25
    
    %���ﵱ�����ƶ�ʱ����Ҫ�����ȼ����෴���˶�������ԵĹ����ռ�Ҫ����Ӧƽ��
    %Ϊʲô���˶�ʱ�����ռ�ҲҪ�˶����������˵��map_x��ԭ���ʾ��˵㣬�ڵ��빤���ռ��ʱ��Ӧ��ע�⣿������
    BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x - delta(1);
    BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y - delta(2);
    BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down - delta(3);
    BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up - delta(3);

    BODY_FOR_CALU.interSpace(i,:) = BODY_FOR_CALU.interSpace(i,:) + [delta(1) delta(2)];%�����ռ�����ϵ����Ӧƽ��
end
%{
if Foot_index == 5
    for i = 1:4
        % ���嶥���ƫ�������൱�ڽ����෴�ķ����˶�
        deltaX = (BODY_FOR_CALU.Body(i)-BODY_FOR_CALU.Body(15+i)) - (bodytemp.Body(i)-bodytemp.Body(15+i));
        deltaY = (BODY_FOR_CALU.Body(5+i)-BODY_FOR_CALU.Body(19+i)) - (bodytemp.Body(5+i)-bodytemp.Body(19+i));
        deltaZ = (BODY_FOR_CALU.Body(10+i)-BODY_FOR_CALU.Body(23+i)) - (bodytemp.Body(10+i)-bodytemp.Body(23+i));
        delta = [deltaX; deltaY; deltaZ];
        delta = eul2rotm(-BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX') * delta;
        
        delta(1) = round(delta(1) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval;
        delta(2) = round(delta(2) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval; % ��6.25�������ռ侫�ȣ�ȡ������֤������6.25
        
        BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x - delta(1);
        BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y - delta(2);
        BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down - delta(3);
        BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up - delta(3);
        
        BODY_FOR_CALU.interSpace(i,:) = BODY_FOR_CALU.interSpace(i,:) + [delta(1) delta(2)];
    end
else
    % ���嶥���ƫ�������൱�ڽ����෴�ķ����˶�
    deltaX = (BODY_FOR_CALU.Body(Foot_index)-BODY_FOR_CALU.Body(15+Foot_index)) - (bodytemp.Body(Foot_index)-bodytemp.Body(15+Foot_index));
    deltaY = (BODY_FOR_CALU.Body(5+Foot_index)-BODY_FOR_CALU.Body(19+Foot_index)) - (bodytemp.Body(5+Foot_index)-bodytemp.Body(19+Foot_index));
    deltaZ = (BODY_FOR_CALU.Body(10+Foot_index)-BODY_FOR_CALU.Body(23+Foot_index)) - (bodytemp.Body(10+Foot_index)-bodytemp.Body(23+Foot_index));
    delta = [deltaX; deltaY; deltaZ];
    delta = eul2rotm(-BODY_FOR_CALU.RotateAngle(linspace(3,1,3)),'ZYX') * delta;
    
    delta(1) = round(delta(1) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval;
    delta(2) = round(delta(2) / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval; % ��6.25�������ռ侫�ȣ�ȡ������֤������6.25
    
    BODY_FOR_CALU.Leg(Foot_index).map_x = BODY_FOR_CALU.Leg(Foot_index).map_x - delta(1);
    BODY_FOR_CALU.Leg(Foot_index).map_y = BODY_FOR_CALU.Leg(Foot_index).map_y - delta(2);
    BODY_FOR_CALU.Leg(Foot_index).zBoundry_down = BODY_FOR_CALU.Leg(Foot_index).zBoundry_down - delta(3);
    BODY_FOR_CALU.Leg(Foot_index).zBoundry_up = BODY_FOR_CALU.Leg(Foot_index).zBoundry_up - delta(3);
    
    BODY_FOR_CALU.interSpace(Foot_index,:) = BODY_FOR_CALU.interSpace(Foot_index,:) + [delta(1) delta(2)];
end
%}
TEMP = Aminate_MoveBody(Foot_index, BODY_FOR_CALU,BODY_PARA);
BODY_FOR_CALU=TEMP;
end
%{
% MoveUpdateShow��Move���� & Update�����ռ� & Show
% ���룺Foot_index������һ�� double��, Step���ߵĲ��� 1*2 double��

function BODY_FOR_CALU = MoveUpdateShow(BODY_FOR_CALU, Foot_index, Step)

BODY_FOR_CALU = BODY_FOR_CALU.Move(Foot_index, Step(1), Step(2), Step(3)); % 5 ��������

if Foot_index == 5
    % ������嶯
    % �ֲ�����ϵ�Ĵ�С��Ӧ��ҲҪ��
    for i = 1:4
        BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x + Step(1);
        BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y + Step(2);
        BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down + Step(3);
        BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up + Step(3);
        
        BODY_FOR_CALU.interSpace(i,:) = BODY_FOR_CALU.interSpace(i,:) - Step(1:2);
    end
else % Foot_index = 1-4
    % ����Ŷ�
    BODY_FOR_CALU.Leg(Foot_index).map_x = BODY_FOR_CALU.Leg(Foot_index).map_x - Step(1);
    BODY_FOR_CALU.Leg(Foot_index).map_y = BODY_FOR_CALU.Leg(Foot_index).map_y - Step(2);
    BODY_FOR_CALU.Leg(Foot_index).zBoundry_down = BODY_FOR_CALU.Leg(Foot_index).zBoundry_down - Step(3);
    BODY_FOR_CALU.Leg(Foot_index).zBoundry_up = BODY_FOR_CALU.Leg(Foot_index).zBoundry_up - Step(3);
    
    BODY_FOR_CALU.interSpace(Foot_index,:) = BODY_FOR_CALU.interSpace(Foot_index,:) + Step(1:2);
end

if length(Step) == 6
%     BODY_FOR_CALU.RotateAngle = BODY_FOR_CALU.RotateAngle + [Step(4), Step(5), Step(6)];
    BODY_FOR_CALU.RotateAngle = Step(4:6);
    % ��ת���岢�ı�ÿһֻ���ڹ����ռ��е�λ��
    bodytemp = BODY_FOR_CALU;
    BODY_FOR_CALU = BODY_FOR_CALU.Rotate(Step(4), Step(5), Step(6));
    for i = 1:4
        % ���嶥���ƫ�������൱�ڽ����෴�ķ����˶�
        deltaX = BODY_FOR_CALU.Body(15+i) - bodytemp.Body(15+i);
        deltaY = BODY_FOR_CALU.Body(19+i) - bodytemp.Body(19+i);
        deltaZ = BODY_FOR_CALU.Body(23+i) - bodytemp.Body(23+i);
        
        deltaX = round(deltaX / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval;
        deltaY = round(deltaY / BODY_FOR_CALU.Inteval)*BODY_FOR_CALU.Inteval; % ��6.25�������ռ侫�ȣ�ȡ������֤������6.25
        
        BODY_FOR_CALU.Leg(i).map_x = BODY_FOR_CALU.Leg(i).map_x + deltaX;
        BODY_FOR_CALU.Leg(i).map_y = BODY_FOR_CALU.Leg(i).map_y + deltaY;
        BODY_FOR_CALU.Leg(i).zBoundry_down = BODY_FOR_CALU.Leg(i).zBoundry_down + deltaZ;
        BODY_FOR_CALU.Leg(i).zBoundry_up = BODY_FOR_CALU.Leg(i).zBoundry_up + deltaZ;
    end
end

% BODY_FOR_CALU.Body0 = BODY_FOR_CALU.Body;

Aminate_MoveBody(Foot_index, BODY_FOR_CALU);

end
%}